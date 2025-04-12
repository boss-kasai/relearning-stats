---
title: Rのブログ、Rで作って公開する
author: ThePastOfDice
date: '2025-04-12'
slug: []
categories: ["環境"]
tags: ["R", "RStudio", "GitHub"]
draft: yes
---

Rの再学習のブログを書くことに決めて、まず最初に考えることはやっぱり「どこでブログを書こうか」ですよね。
はてなブログやQiita, Zennなど多数のサービスがあり簡単にブログは始められます。

しかしせっかくなので、ブログの作成もRでやってみたい。
私がRをメインで使用していた時には、まだメジャーではありませんでしたがR MarkdownなどのRでレポートを作成したり、簡単なWEBサイトをつくれるという話はありました。
当時はそのようなものを使ったことはありませんでしが、せっかく学習し直すのでその辺もカバーしていこうと思います。

## R Studioのインストール

今、RをやるならR Studioを使うのがいいかなと思います。
他の選択肢もあったらすみません。

R Studioは下記URLからダウンロードできます。
https://posit.co/download/rstudio-desktop/

私の環境はMacなのでwindowsの方は適宜読み替えてください。

## 今回の目的と使用技術

今回は無料でRを使ってブログを公開することを目的にします。
ブログ内ではRのコードと実行結果が書きやすく、見やすいようにします。

ブログなどサイトを公開する際は、サーバーが必要になります。
今回はGitHub Pagesを使用します。
無料で設定が簡単そうなのが選定理由です。

Rでのブログ作成には大きく２つの方法があります。
 **Hugo（+ blogdown）** と **Quarto**です。
私が調べた限り、Hugoの方がテーマ(デザイン)が豊富でサイト全体が軽量なようです。
Quartoはよりモダンで、R以外の言語もより柔軟に対応できるようです。

今回は、単純に情報が多かったHugoを使うことにしました。

## 前準備

GitHubのアカウントが無い方は、下記から作成してください。
https://github.com

GitHubでリポジトリを作成してください。
名前；リポジトリ名はそのままURLになります(オリジナルドメインへの変更も可能)
公開設定；Public(無料でやる場合、Publicにする必要があります)
初期ファイル；README.md を生成にチェック

注意；下書きの記事を含めて世界中からアクセス可能な状態になるので、個人情報などは書かないようにしましょう。

上記で作成したGitHub リポジトリをローカルにクローンしてください。
```terminal
git clone https://github.com/yourusername/yourrepositoryname.git
cd yourrepositoryname
```
`yourusername`: あなたのGitHubのユーザー名

`yourrepositoryname`: 先ほど作成したリポジトリ名


RStudioを起動して、クローンしたプロジェクトを開いてください。
まず、今後の作業がしやすいようにRstudioでProjectを作成します。

**手順（RStudio内で）**
1. RStudioメニュー → File → New Project...
2. 「Existing Directory（既存のフォルダ）」を選択
3. 「Browse...」をクリックし、フォルダを選択
4. 「Create Project」をクリック

この作業をしておくことで、ファイルの入出力などが作業フォルダ内で行われます。
この作業をしていないと、意図しないフォルダにファイルを出力することになります。

HugoではWordPressのように世界中の人が作成したテーマを使用することができます。
主なものは下記URLから確認できます。

https://www.gohugothemes.com

自分のブログのイメージに合ったものを選んでおいてください。

私はシンプルなデザインを今回使用することにしました。

https://www.gohugothemes.com/theme/athul-archie/

## Hugoとblogdown のセットアップ
RStudioのConsoleで下記コマンドを実行していってください。
ここからの操作は、Projectを作成してそのフォルダ(ディレクトリ)で行ってください。

blogdownのインストール
```r
install.packages("blogdown")
library(blogdown)
```

Hugoのインストール
```r
blogdown::install_hugo(version = "0.121.1", force = TRUE)
```
注意: 執筆時点(2025年4月12日)での安定バージョンをインストールしています。適宜最適化してください。

選択したテーマで新規サイト作成を行う
```r
# Archie テーマで新規サイト作成
blogdown::new_site(theme = "athul/archie", sample = TRUE, empty_dirs = TRUE)
```

この過程でいくつかエラーにぶつかったので、同じエラーになった方は参考にしてください。

**Hugoバージョンが 0.146 でエラー**

作業時点での最新バージョンのHugoを導入したところ、今回使用したテーマが最新バージョンに対応していませんでした。
そのため、少し前の安定バージョンを指定することで、テーマを動かすことができました。
バージョンを指定する方法は、自動で作成された```.Rprofile```というファイルの一番下に下記を追記してください。

```:.Rprofile
options(blogdown.hugo.version = "0.121.1")
```

これでHugoのバージョンを固定できます。

**必要なファイルがないなど**

私はバージョンの変更など何度か変更をしていたら、動かなくなりました。
そんな時は全て消して最初からやり直すのがおすすめです。
自動化されていると便利な反面何かしらの問題が起きた時に特定するのが難しくなります。なので、全く意味わからなくなったら最初からやり直すといいと思います。その辺のコストが低いのもプログラミングのいいところですよね。

## 記事の作成

最初にサンプルの記事が複数作成されています。
記事は、```content/posts/```内にあります。

サンプルの記事はいらないので、削除してしまった大丈夫です。
記事を追加するためのコマンドは下記になります。

```
blogdown::new_post(
  title = "RとGitHub Pagesでブログを作る方法",
  ext = ".Rmd",
  subdir = "posts",
  author = "ThePastOfDice",
  title_case = FALSE
)
```

適当なページを作ったら、下記コマンドでローカル(自分のPC)でサイトを動かしてみることができます。
編集するのでは拡張子が.Rmdになっているファイルです。
,
.Rmdファイルに書き込んで編集・保存するとその内容を.mdに反映してくれます。
Rのコードとかがあるとこれが便利なのだと思います。

```
blogdown::build_site()
```

このコマンドを実行しておくと、ローカルでどんな感じで表示されるかを確認することができます。

## サイト公開の準備

記事ができた状態で、下記コマンドを順次実行すると公開のために必要なファイルを作成してくれます。

```
unlink("docs", recursive = TRUE) # docsというフォルダを削除する
dir.create("docs") # docsというフォルダを作成
file.copy(from = list.files("public", full.names = TRUE), to = "docs", recursive = TRUE)
file.create("docs/.nojekyll")
```

## GitHubにpush

GitHubに作成したデータをpushします。

```
git add .
git commit -m "初回ビルドと公開準備"
git push origin main
```

この時私は.gitignoreファイルで、docsフォルダが指定されてしまっていたので、その部分をコメントアウトしました。
GitHubのR用の.gitignoreを使用するとこの問題に直面するので気をつけてください。

## GitHub Pages 設定

1. リポジトリ → Settings → Pages
2. Source: main
3. Folder: docs/
4. save をクリック

ここまでで問題なければサイトが公開されるはずです！

私自身かなりエラーと戦ったので、細かく記録を残すことができずかなり概要的な紹介になってしまいました。
もっと細かく記録をとらないとと反省しています。
Quartoで再挑戦でもして、もっと細かく書こうかなとも思ってます。

今日はこの辺で。
