import flatpickr from "flatpickr";
import "./index.css";
import "flatpickr/dist/themes/dark.css";

document.addEventListener("DOMContentLoaded", () => {
  const inputs = document.querySelectorAll('input[type*="date"]');
  inputs.forEach(input => {
    flatpickr(input, {
      enableTime: false,
      altInput: true,
      altFormat: "F j, Y",
      dateFormat: "Y-m-d",
      minDate: input.getAttribute("min"),
      maxDate: input.getAttribute("max")
    });
  });
});
