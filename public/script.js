(function() {
  var ajax, content, hide_reveals, last_url, nav_item_click, next_reveal, reveal_next, reveals, set_page_content;

  content = null;

  last_url = '';

  reveals = null;

  next_reveal = 0;

  hide_reveals = function() {
    var reveal, _i, _len;
    reveals = content.getElementsByClassName('reveal');
    if (reveals.length) {
      for (_i = 0, _len = reveals.length; _i < _len; _i++) {
        reveal = reveals[_i];
        reveal.style.opacity = 0;
      }
      return next_reveal = 0;
    }
  };

  ajax = function(url) {
    var xhr;
    xhr = new XMLHttpRequest();
    xhr.open('GET', url, true);
    xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
    xhr.onreadystatechange = function() {
      if (4 === xhr.readyState && 200 === xhr.status) {
        content.innerHTML = xhr.responseText;
        last_url = url;
        return hide_reveals();
      }
    };
    return xhr.send(null);
  };

  set_page_content = function(event) {
    if (event.state && event.state.url !== last_url) {
      if (!('' === last_url && event.state.url === window.location.href)) {
        return ajax(event.state.url);
      }
    }
  };

  window.onpopstate = set_page_content;

  nav_item_click = function(event) {
    var a, state, title, url;
    a = this.children[0];
    if (a.attributes['data-title']) {
      title = a.attributes['data-title'].value;
    } else {
      title = a.innerText;
    }
    url = a.href;
    state = {
      title: title,
      url: url
    };
    set_page_content({
      state: state
    });
    history.pushState(state, title, url);
    return event.preventDefault();
  };

  reveal_next = function(event) {
    if (next_reveal < reveals.length && event.target.tagName !== 'A') {
      reveals[next_reveal].style.opacity = 1;
      return next_reveal++;
    }
  };

  document.addEventListener('DOMContentLoaded', function() {
    var li, nav, nav_items, _i, _len;
    content = document.getElementById('content');
    hide_reveals();
    nav = document.getElementById('nav');
    nav_items = nav.getElementsByTagName('li');
    for (_i = 0, _len = nav_items.length; _i < _len; _i++) {
      li = nav_items[_i];
      li.addEventListener('click', nav_item_click);
    }
    return content.addEventListener('click', reveal_next);
  });

}).call(this);
