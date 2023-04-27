import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html_iframe/flutter_html_iframe.dart';
import 'package:social_embed_webview/platforms/instagram.dart';
import 'package:social_embed_webview/platforms/twitter.dart';
import 'package:social_embed_webview/social_embed_webview.dart';
import 'package:html/parser.dart' as htmlparser;

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const data = """
      <h2>YouTube iframe:</h2>
      <iframe width="560" height="315" src="https://www.youtube.com/embed/fq4N0hgOWzU" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

      <h2>Twitter iframe:</h2>
      <blockquote class="twitter-tweet"><p lang="en" dir="ltr">🌟 Meet Serverpod — the open-source backend for Flutter, written in <a href="https://twitter.com/dart_lang?ref_src=twsrc%5Etfw">@dart_lang</a>! <br><br>New updates add seamless support for Google Cloud, including special support for Cloud Run.<br><br>Read the blog ↓ <a href="https://t.co/9ga0NFWAJc">https://t.co/9ga0NFWAJc</a></p>&mdash; Flutter (@FlutterDev) <a href="https://twitter.com/FlutterDev/status/1650910696966701075?ref_src=twsrc%5Etfw">April 25, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

      <h2>Instagram iframe:</h2>

      <h2>Vimeo iframe:</h2>
      <iframe width="600" height="300" src="https://player.vimeo.com/video/262032904?h=680dd997a3&title=0&byline=0&portrait=0"></iframe>
    """;
    final document = htmlparser.parse(data);
    final instagramContents =
        document.getElementsByClassName('instagram-media').map((element) {
      return element.outerHtml;
    }).toList();

    final twitterContents =
        document.getElementsByClassName('twitter-tweet').map((element) {
      return element.outerHtml;
    }).toList();

    final content = data.replaceAll('<p>[instagram-embed-script]</p>', '');

    var instagramIndex = -1;
    var twitterIndex = -1;

    return Scaffold(
      appBar: AppBar(
        title: const Text('flutter_htmlのサンプル'),
      ),
      body: SingleChildScrollView(
        child: Html(
          data: content,
          customRenders: {
            instagramMatcher(): CustomRender.widget(
              widget: (context, buildChildren) {
                instagramIndex += 1;
                return SocialEmbed(
                  socialMediaObj: InstagramEmbedData(
                    embedHtml: instagramContents[instagramIndex],
                  ),
                );
              },
            ),
            twitterMatcher(): CustomRender.widget(
              widget: (context, buildChildren) {
                twitterIndex += 1;
                return SocialEmbed(
                  socialMediaObj: TwitterEmbedData(
                    embedHtml: twitterContents[twitterIndex],
                  ),
                );
              },
            ),
            iframeMatcher(): iframeRender(),
          },
        ),
      ),
    );
  }
}

CustomRenderMatcher instagramMatcher() {
  return (context) {
    return context.tree.elementClasses.toString() == '[instagram-media]';
  };
}

CustomRenderMatcher twitterMatcher() {
  return (context) {
    return context.tree.elementClasses.toString() == '[twitter-tweet]';
  };
}
