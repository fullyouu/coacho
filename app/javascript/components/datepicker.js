const date_picker_element = document.querySelector('.date-picker');
if (date_picker_element) {
  const selected_date_element = document.querySelector('.date-picker .selected-date');
  const dates_element = document.querySelector('.date-picker .dates');
  const mth_element = document.querySelector('.date-picker .dates .month .mth');
  const next_mth_element = document.querySelector('.date-picker .dates .month .next-mth');
  const prev_mth_element = document.querySelector('.date-picker .dates .month .prev-mth');
  const days_element = document.querySelector('.date-picker .dates .days');
  const availability_data = document.querySelector('.offer-availability-info').dataset.availability.split("\"").filter(element => element.length > 1);
  const months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

  available_dates = availability_data.map(el => new Date(el));
  //available_dates = available_dates_times.map(el => new Date(`${el.getFullYear()} ${el.getMonth()} ${el.getDate()}`).uniq

  let date = new Date();
  let day = date.getDate();
  let month = date.getMonth();
  let year = date.getFullYear();

  let selectedDate = date;
  let selectedDay = day;
  let selectedMonth = month;
  let selectedYear = year;

  mth_element.textContent = months[month] + ' ' + year;

  selected_date_element.textContent = formatDate(date);
  selected_date_element.dataset.value = selectedDate;

  populateDates();

  // EVENT LISTENERS
  date_picker_element.addEventListener('click', toggleDatePicker);
  next_mth_element.addEventListener('click', goToNextMonth);
  prev_mth_element.addEventListener('click', goToPrevMonth);

  // FUNCTIONS

  function toggleDatePicker(e) {
    if (!checkEventPathForClass(e.path, 'dates')) {
      dates_element.classList.toggle('active');
    }
  }

  function goToNextMonth(e) {
    month++;
    if (month > 11) {
      month = 0;
      year++;
    }
    mth_element.textContent = months[month] + ' ' + year;
    populateDates();
  }

  function goToPrevMonth(e) {
    now = new Date()
    if (year > now.getFullYear()) {
      month--;
    };
    if (year == now.getFullYear() && month > now.getMonth()) {
      month--;
    };
    if (month < 0) {
      month = 11;
      year--;
    }
    mth_element.textContent = months[month] + ' ' + year;
    populateDates();
  }

  function populateDates(e) {
    days_element.innerHTML = '';
    let amount_days = 30;
    if (month > 6 && month % 2 == 1) {
      amount_days = 31;
    }
    if (month <= 6 && month % 2 == 0) {
      amount_days = 31;
    }
    if (month == 1) {
      amount_days = 28;
    }
    if (month == 1 && year % 4 == 0) {
      amount_days = 29;
    }

    for (let i = 0; i < amount_days; i++) {
      const day_element = document.createElement('div');
      day_element.classList.add('day');
      day_element.textContent = i + 1;

      if  (selectedYear == year && selectedMonth == month && selectedDay == (i + 1)) {
        day_element.classList.add('selected');
      };

      checkIfAvailable(available_dates, day_element, i)

      now = new Date();
      if (year == now.getFullYear() && month == now.getMonth() && (i + 1) < now.getDate()) {
        day_element.classList.add('passed');
        if (day_element.classList.contains('available')) {
          day_element.classList.remove('available');
        };
      };

      day_element.addEventListener('click', function (event) {
        if (event.currentTarget.classList.contains('available')) {
          selectedDate = new Date(year + '-' + (month + 1) + '-' + (i + 1));
          selectedDay = (i + 1);
          selectedMonth = month;
          selectedYear = year;

          selected_date_element.textContent = formatDate(selectedDate);
          selected_date_element.dataset.value = selectedDate;

          // dateToRender = findDateToRender(available_dates, selectedDay, selectedMonth, selectedYear);
          // timeslotsFor(dateToRender);
          document.getElementById('appointment_date').value = selectedDate + " 15:00:00+01:00";
          populateDates();
        };
      });

      days_element.appendChild(day_element);
    };
  };

  function timeslotsFor(dateToRender) {

  };

  function findDateToRender(arr, selectedDay, selectedMonth, selectedYear) {
    return arr.find(el => el.getFullYear() == selectedYear && el.getMonth() == selectedMonth && el.getDate() == selectedDay);
  };

  function checkIfAvailable(arr, day, day_index) {
    arr.forEach((el) => {
      if (el.getFullYear() == year && el.getMonth() == month && el.getDate() == (day_index + 1)) {
        day.classList.add('available');
      };
    });
  };

  // HELPER FUNCTIONS
  function checkEventPathForClass(path, selector) {
    for (let i = 0; i < path.length; i++) {
      if (path[i].classList && path[i].classList.contains(selector)) {
        return true;
      }
    }

    return false;
  }
  function formatDate(d) {
    let day = d.getDate();
    if (day < 10) {
      day = '0' + day;
    }

    let month = d.getMonth() + 1;
    if (month < 10) {
      month = '0' + month;
    }

    let year = d.getFullYear();

    return day + ' / ' + month + ' / ' + year;
  }
}
