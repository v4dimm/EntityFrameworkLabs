using Lab.Models.Entities;
using Lab.Models.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace Lab.Controllers
{
    public class Lab2Controller : Controller
    {
        // GET: Lab2
        [AllowAnonymous]
        public ActionResult ListOfPeople()
        {
            List<Person> people = new List<Person>();
            using (var db = new LabEntities())
            {
                people = db.People.OrderByDescending(x => x.Age)
                    .ThenBy(x => x.LastName)
                    .ThenBy(x => x.FirstName).ToList();
            }
            return View(people);
        }

        [HttpGet]
        [Authorize]
        public ActionResult PersonDetails(Guid personId)
        {
            Person model = new Person();
            using (var db = new LabEntities())
            {
                model = db.People.Find(personId);
            }
            return View(model);
        }

        List<Tuple<string, string>> GetGendersList()
        {
            List<Tuple<string, string>> genders = new List<Tuple<string, string>>
            {
                new Tuple<string, string>("ж", "Женский"),
                new Tuple<string, string>("м", "Мужской")
            };
            return genders;
        }

        [HttpGet]
        public ActionResult CreatePerson()
        {
            ViewBag.Genders = new SelectList(GetGendersList(), "Item1", "Item2");
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken()]
        public ActionResult CreatePerson(PersonVM newPerson)
        {
            if (ModelState.IsValid)
            {
                using (var context = new LabEntities())
                {
                    Person person = new Person
                    {
                        Id = Guid.NewGuid(),
                        LastName = newPerson.LastName,
                        FirstName = newPerson.FirstName,
                        Patronymic = newPerson.Patronymic,
                        Gender = newPerson.Gender,
                        Age = newPerson.Age,
                        HasJob = newPerson.HasJob
                    };

                    context.People.Add(person);
                    context.SaveChanges();
                }

                return RedirectToAction("ListOfPeople");
            }
            ViewBag.Genders = new SelectList(GetGendersList(), "Item1", "Item2");
            return View(newPerson);
        }

        [HttpGet]
        [Authorize(Roles = "Admin")]
        public ActionResult EditPerson(Guid personID)
        {
            PersonVM model;
            using (var context = new LabEntities())
            {
                Person person = context.People.Find(personID);
                model = new PersonVM
                {
                    Id = person.Id,
                    LastName = person.LastName,
                    FirstName = person.FirstName,
                    Patronymic = person.Patronymic,
                    Gender = person.Gender,
                    Age = person.Age,
                    HasJob = person.HasJob
                };
            }
            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken()]
        [Authorize(Roles = "Admin")]
        public ActionResult EditPerson(PersonVM model)
        {
            if (ModelState.IsValid)
            {
                using (var context = new LabEntities())
                {
                    Person editedPerson = new Person
                    {
                        Id = model.Id,
                        LastName = model.LastName,
                        FirstName = model.FirstName,
                        Patronymic = model.Patronymic,
                        Gender = model.Gender,
                        Age = model.Age,
                        HasJob = model.HasJob

                    };
                    context.People.Attach(editedPerson);
                    context.Entry(editedPerson).State = System.Data.Entity.EntityState.Modified;
                    context.SaveChanges();
                }

                return RedirectToAction("ListOfPeople");
            }
            ViewBag.Genders = new SelectList(GetGendersList(), "Item1", "Item2");
            return View(model);
        }

        [HttpGet]
        [Authorize(Roles = "Admin")]
        public ActionResult DeletePerson(Guid personID)
        {
            Person personToDelete;
            using (var context = new LabEntities())
            {
                personToDelete = context.People.Find(personID);
            }
            return View(personToDelete);
        }
        
        [HttpPost, ActionName("DeletePerson")]
        [Authorize(Roles = "Admin")]
        public ActionResult DeleteConfirmed(Guid personID)
        {
            using (var context = new LabEntities())
            {
                Person personToDelete = new Person
                {
                    Id = personID
                };
                context.Entry(personToDelete).State = System.Data.Entity.EntityState.Deleted;

                context.SaveChanges();
            }
            return RedirectToAction("ListOfPeople");
        }

        [ChildActionOnly]
        public ActionResult QuestionAnswered(Guid personID)
        {
            string message = "";
            using (var context = new LabEntities())
            {
                int questionAnsweredNumber = context.People.Find(personID).Answers.Count;
                message = $"Вопросов отвечено: { questionAnsweredNumber}.";
            }
            return PartialView("QuestionAnswered", message);
        }
    }
}