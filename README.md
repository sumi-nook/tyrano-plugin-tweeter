# Tweeter

ティラノスクリプト用Twitter風ウィンドウプラグイン

## 使い方

1. ティラノスクリプトの`data/others/plugin`フォルダに`tweeter`フォルダをコピーします
2. `first.ks`等で`[plugin name="tweeter"]`を呼びロードします
3. 使用したいところで`[enable_tweeter top=... left=... width=... height=...]`を呼びウィンドウを作成します
4. ツイートを追加したいところで`[add_tweet name=... screen_name=... text=...]`を呼ぶことでウィンドウにツイートが追加されます
5. 不要になったら`[disable_tweeter]`を呼び、ウィンドウを削除します

### enable_tweeter

Twitter風ウィンドウを表示します。

引数はゲームウィンドウ内でのpx単位で指定してください。

* `top`: px
* `left`: px
* `width`: px
* `height`: px

```
[enable_tweeter top=0 left=660 width=300 height=640]
```

### add_tweet

ウィンドウにツイートを追加します。

* `name`: アカウント名
* `screen_name`: `@〜`に入るアカウント名（`@`は自動で付きます）
* `mode`: 先頭追加`"front"`(default) または 末尾追加`"last"`
* `id`: ツイートID （任意）

```
[add_tweet name="ユーザーネーム" screen_name="username" text="Hello World!" id="0001"]
```

### remove_tweet

ツイートを指定して削除します。

* `id`: `add_tweet`で指定した`id`

```
[remove_tweet id="0001"]
```

### clear_tweet

ツイートを全削除します。

```
[clear_tweet]
```

### hide_tweeter

ウィンドウを非表示にします。

```
[hide_tweeter]
```

### show_tweeter

ウィンドウを再表示します。

```
[show_tweeter]
```

### disable_tweeter

ウィンドウを削除します。
（ツイートが消えます）

```
[disable_tweeter]
```

## LICENSE

MIT License

### 3rdparty

* Font Awesome: MIT & SIL OFL 1.1 License
* Bootstrap: MIT License
* Twitter Logo（サンプル用）: https://about.twitter.com/ja/company/brand-resources.html
