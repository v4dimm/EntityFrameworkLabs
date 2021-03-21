﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Lab.Models.ViewModels
{
    public class PersonVM
    {
        public System.Guid Id { get; set; }

        [Required]
        [DisplayName("Фамилия")]
        [StringLength(100)]
        public string LastName { get; set; }

        [Required]
        [DisplayName("Имя")]
        public string FirstName { get; set; }

        [DisplayName("Отчество")]
        public string Patronymic { get; set; }

        [Required]
        [DisplayName("Полных лет")]
        [Range(18, 100)]
        public int Age { get; set; }

        [DisplayName("Пол")]
        public string Gender { get; set; }

        [Required]
        [DisplayName("Трудоустроен")]
        public bool HasJob { get; set; }

        [DisplayName("Дата рождения")]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime Birthday { get; set; }

        [DisplayName("Дата и время добавления")]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-ddThh:mm}", ApplyFormatInEditMode = true)]
        public DateTime InsertDateTime { get; set; }

        [DisplayName("Время подъема")]
        [DisplayFormat(DataFormatString = "{0:HH:mmm:ss}", ApplyFormatInEditMode = true)]
        public DateTime WakeUpTime { get; set; }
    }
}