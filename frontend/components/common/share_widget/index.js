import "./index.css";

function getPageInfo() {
  return {
    url: window.location.href.replace(/\?.*$/, ""), // Strip out any query string.
    lang: document.querySelector("html").getAttribute("lang") || "en"
  };
}

function doFacebook(evt) {
  evt.preventDefault();
  evt.stopPropagation();

  const fbShareWindow = window.open(
    evt.currentTarget.href,
    "FacebookShare",
    "width=626,height=436"
  );
  fbShareWindow.focus();
}

function doTweet(evt) {
  evt.preventDefault();
  evt.stopPropagation();

  const pageInfo = getPageInfo();
  const intentURL = `${evt.currentTarget.href +
    (evt.currentTarget.href.indexOf("?") > -1 ? "&" : "?")}lang=${
    pageInfo.lang
  }`;

  const tweetWindow = window.open(
    intentURL,
    "TweetTweet",
    "width=550,height=420"
  );
  tweetWindow.focus();
}

document.addEventListener("DOMContentLoaded", () => {
  const widget = document.querySelector(".share-widget");
  if (!widget) {
    return;
  }
  widget.querySelector(".twitter a").addEventListener("click", doTweet);
  widget.querySelector(".facebook a").addEventListener("click", doFacebook);
});
