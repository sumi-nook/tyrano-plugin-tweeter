; [create_tweeter]
; * top: px
; * left: px
; * width: px
; * height: px
; * thema_color: color string
; * logo_path: logo image path
; * border_radius: window border-radius
; * hide: create with hide
[macro name="create_tweeter"]

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
mp.backlog = mp.backlog || "true";

this.tweeter = {
  "backlog": mp.backlog == "false" ? false : true,
};

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
mp.text = mp.text || "";
mp.mode = mp.mode || "front";
mp.id = mp.id || "";


let root = document.getElementById("tweeter_contents");
if ( root && mp.text ) {
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
  comment.className = "footer-icon";
  let comment_icon = document.createElement("span");
  comment_icon.className = "far fa-comment icon";
  comment.appendChild(comment_icon);
  if ( mp.id ) {
    let comment_count = document.createElement("span");
    comment_count.id = "tweet-reply-" + mp.id;
    comment_count.className = "count";
    comment.appendChild(comment_count);
  }
  footer.appendChild(comment);
  let retweet = document.createElement("span");
  retweet.className = "footer-icon";
  let retweet_icon = document.createElement("span");
  retweet_icon.className = "fa fa-retweet icon";
  retweet.appendChild(retweet_icon);
  if ( mp.id ) {
    let retweet_count = document.createElement("span");
    retweet_count.id = "tweet-retweet-" + mp.id;
    retweet_count.className = "count";
    retweet.appendChild(retweet_count);
  }
  footer.appendChild(retweet);
  let heart = document.createElement("span");
  heart.className = "footer-icon";
  let heart_icon = document.createElement("span");
  heart_icon.className = "far fa-heart icon";
  heart.appendChild(heart_icon);
  if ( mp.id ) {
    let heart_count = document.createElement("span");
    heart_count.id = "tweet-favorite-" + mp.id;
    heart_count.className = "count";
    heart.appendChild(heart_count);
  }
  footer.appendChild(heart);
  body.appendChild(footer);

  tweet.appendChild(body);
  if ( mp.mode == "back" ) {
    root.appendChild(tweet);
  } else {
    root.insertBefore(tweet, root.childNodes[0]);
  }

  if (this.tweeter.backlog) {
    this.kag.pushBackLog("<b class='backlog_chara_name tweeter-"+mp.screen_name+"'>"+mp.name+"@"+mp.screen_name+"</b>：<span class='backlog_text tweeter-"+mp.screen_name+"'>"+mp.text+"</span>", "add");
  }
}
[endscript]

[endmacro]


; [set_reply]
; * id: tweet_id
; * value: reply count
[macro name="set_reply"]

[iscript]
mp.id = mp.id || "";
mp.value = mp.value || "0";

if ( mp.id ) {
  let count = document.getElementById("tweet-reply-" + mp.id);
  if ( count ) {
    if ( mp.value == "0" ) {
      count.textContent = "";
    } else {
      count.textContent = mp.value;
    }
  }
}
[endscript]

[endmacro]


; [set_retweet]
; * id: tweet_id
; * value: retweet count
[macro name="set_retweet"]

[iscript]
mp.id = mp.id || "";
mp.value = mp.value || "0";

if ( mp.id ) {
  let count = document.getElementById("tweet-retweet-" + mp.id);
  if ( count ) {
    if ( mp.value == "0" ) {
      count.textContent = "";
    } else {
      count.textContent = mp.value;
    }
  }
}
[endscript]

[endmacro]


; [set_favorite]
; * id: tweet_id
; * value: favorite count
[macro name="set_favorite"]

[iscript]
mp.id = mp.id || "";
mp.value = mp.value || "0";

if ( mp.id ) {
  let count = document.getElementById("tweet-favorite-" + mp.id);
  console.log(count);
  if ( count ) {
    if ( mp.value == "0" ) {
      count.textContent = "";
    } else {
      count.textContent = mp.value;
    }
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


; [disable_tweeter_backlog]
[macro name="disable_tweeter_backlog"]

[iscript]
if ( this.tweeter ) {
  this.tweeter.backlog = false;
}
[endscript]

[endmacro]


; [enable_tweeter_backlog]
[macro name="enable_tweeter_backlog"]

[iscript]
if ( this.tweeter ) {
  this.tweeter.backlog = true;
}
[endscript]

[endmacro]


; [delete_tweeter]
[macro name="delete_tweeter"]

[iscript]
let tyrano_base = document.getElementById("tyrano_base");
let root = document.getElementById("tweeter");
if ( root ) {
  tyrano_base.removeChild(root);
}
[endscript]

[endmacro]


[return]
