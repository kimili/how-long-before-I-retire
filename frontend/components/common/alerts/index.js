import "./alerts.css";
import "./images/close.svg";

const Alerts = {
  init() {
    this.alerts = document.querySelectorAll(".alert");
    if (!this.alerts.length) {
      return;
    }

    this.displayDelay = 500;
    this.displayDuration = 12000;
    this.currentAlertIndex = 0;
    this.viewTimer = null;

    this.alerts.forEach(alert => this.configure(alert));

    this.displayNext();
  },

  configure(alert) {
    const close = alert.querySelector("button.close");
    close.addEventListener("click", this.dismiss.bind(this), false);
  },

  displayNext() {
    const alert = this.alerts[this.currentAlertIndex];
    if (!alert) {
      return;
    }
    window.setTimeout(() => {
      alert.classList.add("-show");
      this.viewTimer = window.setTimeout(() => {
        this.dismiss();
      }, this.displayDuration);
    }, this.displayDelay);
  },

  dismiss() {
    if (this.viewTimer) {
      window.clearTimeout(this.viewTimer);
      this.viewTimer = null;
    }
    const alert = this.alerts[this.currentAlertIndex];
    if (!alert) {
      return;
    }
    alert.classList.remove("-show");
    this.currentAlertIndex = this.currentAlertIndex + 1;
    this.displayNext();
  }
};

document.addEventListener("DOMContentLoaded", Alerts.init.bind(Alerts));
