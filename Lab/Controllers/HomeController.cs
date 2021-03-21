using Lab.Models.Entities;
using Lab.Models.ViewModels;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace Lab.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }

        public ActionResult Login()
        {
            return View();
        }

        [AllowAnonymous]
        [HttpPost]
        public ActionResult Login(UserVM webUser)
        {
            System.Console.WriteLine(webUser);

            if (ModelState.IsValid)
            {
                using (LabEntities context = new LabEntities())
                {
                    User user = null;
                    user = context.Users.Where(u => u.Login == webUser.Login).FirstOrDefault();


                    if (user != null)
                    {
                        string passwordHash = ReturnHashCode(webUser.Password + user.Salt.ToString().ToUpper());
                        if (passwordHash == user.PasswordHash)
                        {
                            string userRole = "";
                            switch (user.UserRole)
                            {
                                case 1:
                                    userRole = "Admin";
                                    break;
                                case 2:
                                    userRole = "Participant";
                                    break;
                            }

                            FormsAuthenticationTicket authTicket = new FormsAuthenticationTicket(
                                1,
                                user.Login,
                                DateTime.Now,
                                DateTime.Now.AddDays(1),
                                false,
                                userRole);

                            string encryptedTicket = FormsAuthentication.Encrypt(authTicket);
                            HttpContext.Response.Cookies.Add(new HttpCookie(FormsAuthentication.FormsCookieName, encryptedTicket));
                            return RedirectToAction("ListOfPeople", "Lab2");
                        }
                    }
                }
            }
            ViewBag.Error = "Пользователя с таким логином и паролем не существует, попробуйте еще раз";
            return View(webUser);
        }

        private string ReturnHashCode(string loginAndSalt)
        {
            string hash = "";
            using (SHA1 sha1Hash = SHA1.Create())
            {
                byte[] data = sha1Hash.ComputeHash(Encoding.UTF8.GetBytes(loginAndSalt));
                StringBuilder sBuilder = new StringBuilder();
                for (int i = 0; i < data.Length; i++)
                {
                    sBuilder.Append(data[i].ToString("x2"));
                }
                hash = sBuilder.ToString().ToUpper();
            }
            return hash;
        }

        public ActionResult LogOut()
        {
            FormsAuthentication.SignOut();
            return RedirectToAction("ListOfPeople", "Lab2");
        }
    }
}