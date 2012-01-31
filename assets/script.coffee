content = null
last_url = ''
reveals = null
next_reveal = 0

hide_reveals = ->
  reveals = content.getElementsByClassName 'reveal'
  if reveals.length
    reveal.style.opacity = 0 for reveal in reveals
    next_reveal = 0

ajax = (url) ->
  xhr = new XMLHttpRequest()
  xhr.open 'GET', url, true
  xhr.setRequestHeader 'X-Requested-With', 'XMLHttpRequest'
  xhr.onreadystatechange = ->
    if 4 == xhr.readyState and 200 == xhr.status
      content.innerHTML = xhr.responseText
      last_url = url
      hide_reveals()
  xhr.send(null)

set_page_content = (event) ->
  if event.state and event.state.url != last_url
    unless '' == last_url and event.state.url == window.location.href
      ajax event.state.url

window.onpopstate = set_page_content

nav_item_click = (event) ->
  a = this.children[0]
  if a.attributes['data-title']
    title = a.attributes['data-title'].value
  else
    title = a.innerText
  url = a.href
  state = { title: title, url: url }
  set_page_content { state: state }
  history.pushState state, title, url
  event.preventDefault()

reveal_next = (event) ->
  if next_reveal < reveals.length and event.target.tagName != 'A'
    reveals[next_reveal].style.opacity = 1
    next_reveal++

document.addEventListener 'DOMContentLoaded', ->
  content = document.getElementById 'content'
  hide_reveals()
  nav = document.getElementById 'nav'
  nav_items = nav.getElementsByTagName 'li'
  li.addEventListener 'click', nav_item_click for li in nav_items
  content.addEventListener 'click', reveal_next
