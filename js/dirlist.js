var writeReadmeText = (filename) => {
  window.addEventListener('load', () => {
    const xhr = new XMLHttpRequest();
    xhr.open('GET', filename, true);
    xhr.onload = function () {
      document.getElementById("foot").innerText = xhr.responseText;
    };
    xhr.send(null);
  });
};

var writeReadmeHtml = (filename) => {
  window.addEventListener('load', () => {
    const xhr = new XMLHttpRequest();
    xhr.open('GET', filename, true);
    xhr.onload = function () {
      document.getElementById("foot").innerHTML = xhr.responseText;
    };
    xhr.send(null);
  });
};
