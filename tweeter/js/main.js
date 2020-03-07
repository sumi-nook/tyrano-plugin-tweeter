(function(){
  function register_tag(tagname, tag) {
    let obj = object(tag);
    obj.kag = TYRANO.kag;

    TYRANO.kag.ftag.master_tag[tagname] = obj;
  }


  /*
   [create_tweeter]
   * top: px
   * left: px
   * width: px
   * height: px
   * thema_color: color string
   * logo_path: logo image path
   * border_radius: window border-radius
   * hide: create with hide
   */
  register_tag("create_tweeter", {
    vital : [],
    pm: {
      top: "0",
      left: "660",
      width: "300",
      height: "640",
      thema_color: "#1ca0f1",
      logo_path: "./data/others/plugin/tweeter/3rdparty/Twitter_Logo/Twitter_Logo_WhiteOnImage.svg",
      border_radius: "",
      hide: "",
      backlog: "true",
    },
    start : function(pm) {
      this.kag.tweeter = {
        "backlog": pm.backlog == "false" ? false : true,
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
      root.style.cssText = "width: " + pm.width + "px; height: " + pm.height + "px; top: " + pm.top + "px; left: " + pm.left + "px;";
      if ( pm.border_radius ) {
        root.style.cssText += " border-radius: " + pm.border_radius + "px;";
      }
      if ( pm.hide == "true" ) {
        root.style.display = "none";
      }

      let navbar = document.createElement("nav");
      navbar.className = "navbar";
      navbar.style.cssText = "background-color: " + pm.thema_color + ";";
      if ( pm.border_radius ) {
        navbar.style.cssText += " border-radius: " + pm.border_radius + "px " + pm.border_radius + "px 0px 0px;";
      }
      let logo = document.createElement("img");
      logo.className = "logo";
      logo.width = 30;
      logo.height = 30;
      logo.src = pm.logo_path;
      navbar.appendChild(logo);
      root.appendChild(navbar);

      let contents = document.createElement("div");
      contents.id = "tweeter_contents";
      contents.className = "contents col";
      root.appendChild(contents);

      tyrano_base.appendChild(root);

      //終わったら次のタグへ
      this.kag.ftag.nextOrder();
    }
  });


  /*
   [tweet]
   * icon_path: icon source path
   * name: user name
   * screen_name: account name
   * mode: "front" or "back"
   * id: tweet_id
   */
  register_tag("tweet", {
    vital : [],
    pm: {
      icon_path: "./data/others/plugin/tweeter/img/twitter_default.jpg",
      name: "Unknown",
      screen_name: "unknown",
      mode: "front",
      id: "",
      text: "",
    },
    start : function(pm) {
      this.kag.stat.is_script = true;
      this.kag.stat.buff_script = "";
      this.kag.tweeter.current = {
        icon_path: pm.icon_path,
        name: pm.name,
        screen_name: pm.screen_name,
        mode: pm.mode,
        id: pm.id,
      };
      //終わったら次のタグへ
      this.kag.ftag.nextOrder();
    },
  });


  /*
   [endtweet]
   */
  register_tag("endtweet", {
    vital : [],
    pm: {},
    start : function(_) {
      console.log(this)
      let pm = this.kag.tweeter.current;
      pm.text = this.kag.stat.buff_script;
      this.kag.stat.is_script = false;
      //this.kag.stat.buff_script = "";
      let root = document.getElementById("tweeter_contents");
      if ( root && pm.text ) {
        let tweet = document.createElement("div");
        tweet.className = "media";
        if ( pm.id ) {
          tweet.id = "tweet-" + pm.id;
        }
        // icon
        let icon = document.createElement("img");
        icon.className = "mr-3";
        icon.setAttribute("src", pm.icon_path);
        icon.setAttribute("alt", "");
        tweet.appendChild(icon);
        // body
        let body = document.createElement("div");
        body.className = "media-body";
        // name
        let name = document.createElement("div");
        name.className = "name";
        name.appendChild(document.createTextNode(pm.name));
        let screen_name = document.createElement("span");
        screen_name.className = "screen_name";
        screen_name.appendChild(document.createTextNode("@" + pm.screen_name));
        name.appendChild(screen_name);
        body.appendChild(name);
        body.appendChild(document.createTextNode(pm.text));
        // footer
        let footer = document.createElement("div");
        footer.className = "footer clearfix";
        let comment = document.createElement("span");
        comment.className = "footer-icon";
        let comment_icon = document.createElement("span");
        comment_icon.className = "far fa-comment icon";
        comment.appendChild(comment_icon);
        if ( pm.id ) {
          let comment_count = document.createElement("span");
          comment_count.id = "tweet-reply-" + pm.id;
          comment_count.className = "count";
          comment.appendChild(comment_count);
        }
        footer.appendChild(comment);
        let retweet = document.createElement("span");
        retweet.className = "footer-icon";
        let retweet_icon = document.createElement("span");
        retweet_icon.className = "fa fa-retweet icon";
        retweet.appendChild(retweet_icon);
        if ( pm.id ) {
          let retweet_count = document.createElement("span");
          retweet_count.id = "tweet-retweet-" + pm.id;
          retweet_count.className = "count";
          retweet.appendChild(retweet_count);
        }
        footer.appendChild(retweet);
        let heart = document.createElement("span");
        heart.className = "footer-icon";
        let heart_icon = document.createElement("span");
        heart_icon.className = "far fa-heart icon";
        heart.appendChild(heart_icon);
        if ( pm.id ) {
          let heart_count = document.createElement("span");
          heart_count.id = "tweet-favorite-" + pm.id;
          heart_count.className = "count";
          heart.appendChild(heart_count);
        }
        footer.appendChild(heart);
        body.appendChild(footer);

        tweet.appendChild(body);
        if ( pm.mode == "back" ) {
          root.appendChild(tweet);
        } else {
          root.insertBefore(tweet, root.childNodes[0]);
        }

        if (this.kag.tweeter.backlog) {
          this.kag.pushBackLog("<b class='backlog_chara_name tweeter-"+pm.screen_name+"'>"+pm.name+"@"+pm.screen_name+"</b>：<span class='backlog_text tweeter-"+pm.screen_name+"'>"+pm.text+"</span>", "add");
        }
      }

      //終わったら次のタグへ
      this.kag.ftag.nextOrder();
    },
  });


  /*
   [set_reply]
   * id: tweet_id
   * value: reply count
   */
  register_tag("set_reply", {
    vital : [],
    pm: {
      id: "",
      value: "0",
    },
    start : function(pm) {
      if ( pm.id ) {
        let count = document.getElementById("tweet-reply-" + pm.id);
        if ( count ) {
          if ( pm.value == "0" ) {
            count.textContent = "";
          } else {
            count.textContent = pm.value;
          }
        }
      }

      //終わったら次のタグへ
      this.kag.ftag.nextOrder();
    },
  });


  /*
   [set_retweet]
   * id: tweet_id
   * value: retweet count
   */
  register_tag("set_retweet", {
    vital : [],
    pm: {
      id: "",
      value: "0",
    },
    start : function(pm) {
      if ( pm.id ) {
        let count = document.getElementById("tweet-retweet-" + pm.id);
        if ( count ) {
          if ( pm.value == "0" ) {
            count.textContent = "";
          } else {
            count.textContent = pm.value;
          }
        }
      }

      //終わったら次のタグへ
      this.kag.ftag.nextOrder();
    },
  });


  /*
   [set_favorite]
   * id: tweet_id
   * value: favorite count
   */
  register_tag("set_favorite", {
    vital : [],
    pm: {
      id: "",
      value: "0",
    },
    start : function(pm) {
      if ( pm.id ) {
        let count = document.getElementById("tweet-favorite-" + pm.id);
        console.log(count);
        if ( count ) {
          if ( pm.value == "0" ) {
            count.textContent = "";
          } else {
            count.textContent = pm.value;
          }
        }
      }

      //終わったら次のタグへ
      this.kag.ftag.nextOrder();
    },
  });


  /*
   [remove_tweet]
   * id: tweet_id
   */
  register_tag("remove_tweet", {
    vital : [],
    pm: {
      id: "",
    },
    start : function(pm) {
      if ( pm.id ) {
        let root = document.getElementById("tweeter_contents");
        let tweet = document.getElementById("tweet-" + pm.id);
        if ( root && tweet ) {
          root.removeChild(tweet);
        }
      }

      //終わったら次のタグへ
      this.kag.ftag.nextOrder();
    },
  });


  /*
   [clear_tweet]
   */
  register_tag("clear_tweet", {
    vital : [],
    pm: {},
    start : function(pm) {
      let root = document.getElementById("tweeter_contents");
      if ( root ) {
        let size = root.childNodes.length;
        for (let i = size - 1; i >= 0; --i) {
          root.removeChild(root.childNodes[i]);
        }
      }

      //終わったら次のタグへ
      this.kag.ftag.nextOrder();
    },
  });


  /*
   [hide_tweeter]
   */
  register_tag("hide_tweeter", {
    vital : [],
    pm: {},
    start : function(pm) {
      let root = document.getElementById("tweeter");
      if ( root ) {
        root.style.display = "none";
      }

      //終わったら次のタグへ
      this.kag.ftag.nextOrder();
    },
  });


  /*
   [show_tweeter]
   */
  register_tag("show_tweeter", {
    vital : [],
    pm: {},
    start : function(pm) {
      let root = document.getElementById("tweeter");
      if ( root ) {
        root.style.display = "block";
      }

      //終わったら次のタグへ
      this.kag.ftag.nextOrder();
    },
  });


  /*
   [disable_tweeter_backlog]
   */
  register_tag("disable_tweeter_backlog", {
    vital : [],
    pm: {},
    start : function(pm) {
      if ( this.kag.tweeter ) {
        this.kag.tweeter.backlog = false;
      }

      //終わったら次のタグへ
      this.kag.ftag.nextOrder();
    },
  });


  /*
   [enable_tweeter_backlog]
   */
  register_tag("enable_tweeter_backlog", {
    vital : [],
    pm: {},
    start : function(pm) {
      if ( this.kag.tweeter ) {
        this.kag.tweeter.backlog = true;
      }
    },
  });


  /*
   [delete_tweeter]
   */
  register_tag("delete_tweeter", {
    vital: [],
    pm: {},
    start: function(pm) {
      let tyrano_base = document.getElementById("tyrano_base");
      let root = document.getElementById("tweeter");
      if ( root ) {
        tyrano_base.removeChild(root);
      }

      //終わったら次のタグへ
      this.kag.ftag.nextOrder();
    },
  });

})();
