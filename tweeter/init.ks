; [enable_tweeter]
; * top: px
; * left: px
; * width: px
; * height: px
; * thema_color: color string
; * logo_path: logo image path
; * border_radius: window border-radius
; * hide: create with hide
[macro name="enable_tweeter"]

; Tweeter Window
[iscript]
// default arguments
mp.top = mp.top || "0";
mp.left = mp.left || "660";
mp.width = mp.width || "300";
mp.height = mp.height || "640";
mp.thema_color = mp.thema_color || "#1ca0f1";
mp.logo_path = mp.logo_path || "./data/others/plugin/tweeter/3rdparty/Twitter_Logo/Twitter_Logo_WhiteOnImage.svg";
mp.border_radius = mp.border_radius || "";
mp.hide = mp.hide || "";

// load css
let head = document.getElementsByTagName('head')[0];
// tweeter
let tt = document.getElementById("tweeter_css");
if ( ! tt ) {
  let tweeter = document.createElement('link');
  tweeter.id = "tweeter_css";
  tweeter.rel = "stylesheet";
  tweeter.type = "text/css";
  tweeter.href = "./data/others/plugin/tweeter/css/tweeter.css";
  tweeter.media = "all";
  head.appendChild(tweeter);
}
// fontawesome
let fa = document.getElementById("fontawesome_css");
if ( ! fa ) {
  let fontawesome = document.createElement('link');
  fontawesome.id = "fontawesome_css";
  fontawesome.rel = "stylesheet";
  fontawesome.type = "text/css";
  fontawesome.href = "./data/others/plugin/tweeter/3rdparty/fontawesome/css/all.min.css";
  fontawesome.media = "all";
  head.appendChild(fontawesome);
}
// bootstrap
let bs = document.getElementById("bootstrap_css");
if ( ! bs ) {
  let bootstrap = document.createElement('link');
  bootstrap.id = "fontawesome_css";
  bootstrap.rel = "stylesheet";
  bootstrap.type = "text/css";
  bootstrap.href = "./data/others/plugin/tweeter/3rdparty/bootstrap/css/bootstrap.min.css";
  bootstrap.media = "all";
  head.appendChild(bootstrap);
}

let tyrano_base = document.getElementById("tyrano_base");
let test = document.getElementById("tweeter");
if ( test ) {
  tyrano_base.removeChild(test);
}

let root = document.createElement("div");
root.id = "tweeter";
root.className = "tweeter";
root.style.cssText = "width: " + mp.width + "px; height: " + mp.height + "px; top: " + mp.top + "px; left: " + mp.left + "px;";
if ( mp.border_radius ) {
  root.style.cssText += " border-radius: " + mp.border_radius + "px;";
}

let navbar = document.createElement("nav");
navbar.className = "navbar";
navbar.style.cssText = "background-color: " + mp.thema_color + ";";
if ( mp.border_radius ) {
  navbar.style.cssText += " border-radius: " + mp.border_radius + "px " + mp.border_radius + "px 0px 0px;";
}
let logo = document.createElement("img");
logo.className = "logo";
logo.width = 30;
logo.height = 30;
logo.src = mp.logo_path;
navbar.appendChild(logo);
root.appendChild(navbar);

let contents = document.createElement("div");
contents.id = "tweeter_contents";
contents.className = "contents col";
root.appendChild(contents);

tyrano_base.appendChild(root);
[endscript]

[endmacro]


; [add_tweet]
; * icon_path: icon source path
; * name: user name
; * screen_name: account name
; * mode: "front" or "back"
; * id: tweet_id
[macro name="add_tweet"]

[iscript]
// default arguments
mp.icon_path = mp.icon_path || "./data/others/plugin/tweeter/img/twitter_default.jpg";
mp.name = mp.name || "Unknown";
mp.screen_name = mp.screen_name || "unknown";
mp.mode = mp.mode || "front";
mp.id = mp.id || "";


let root = document.getElementById("tweeter_contents");
if ( root ) {
  let tweet = document.createElement("div");
  tweet.className = "media";
  if ( mp.id ) {
    tweet.id = "tweet-" + mp.id;
  }
  // icon
  let icon = document.createElement("img");
  icon.className = "mr-3";
  icon.setAttribute("src", mp.icon_path);
  icon.setAttribute("alt", "");
  tweet.appendChild(icon);
  // body
  let body = document.createElement("div");
  body.className = "media-body";
  // name
  let name = document.createElement("div");
  name.className = "name";
  name.appendChild(document.createTextNode(mp.name));
  let screen_name = document.createElement("span");
  screen_name.className = "screen_name";
  screen_name.appendChild(document.createTextNode("@" + mp.screen_name));
  name.appendChild(screen_name);
  body.appendChild(name);
  body.appendChild(document.createTextNode(mp.text));
  // footer
  let footer = document.createElement("div");
  footer.className = "footer clearfix";
  let comment = document.createElement("span");
  comment.className = "far fa-comment";
  footer.appendChild(comment);
  let retweet = document.createElement("span");
  retweet.className = "fa fa-retweet";
  footer.appendChild(retweet);
  let heart = document.createElement("span");
  heart.className = "far fa-heart";
  footer.appendChild(heart);
  body.appendChild(footer);

  tweet.appendChild(body);
  if ( mp.mode == "back" ) {
    root.appendChild(tweet);
  } else {
    root.insertBefore(tweet, root.childNodes[0]);
  }
}
[endscript]

[endmacro]

; [remove_tweet]
; * id: tweet_id
[macro name="remove_tweet"]

[iscript]
mp.id = mp.id || "";

if ( mp.id ) {
  let root = document.getElementById("tweeter_contents");
  let tweet = document.getElementById("tweet-" + mp.id);
  if ( root && tweet ) {
    root.removeChild(tweet);
  }
}
[endscript]

[endmacro]


; [clear_tweet]
[macro name="clear_tweet"]

[iscript]
let root = document.getElementById("tweeter_contents");
if ( root ) {
  let size = root.childNodes.length;
  for (let i = size - 1; i >= 0; --i) {
    root.removeChild(root.childNodes[i]);
  }
}
[endscript]

[endmacro]


; [hide_tweeter]
[macro name="hide_tweeter"]

[iscript]
let root = document.getElementById("tweeter");
if ( root ) {
  root.style.display = "none";
}
[endscript]

[endmacro]


; [show_tweeter]
[macro name="show_tweeter"]

[iscript]
let root = document.getElementById("tweeter");
if ( root ) {
  root.style.display = "block";
}
[endscript]

[endmacro]


; [disable_tweeter]
[macro name="disable_tweeter"]

[iscript]
let tyrano_base = document.getElementById("tyrano_base");
let root = document.getElementById("tweeter");
if ( root ) {
  tyrano_base.removeChild(root);
}
[endscript]

[endmacro]


[return]
