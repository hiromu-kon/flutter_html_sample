import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('flutter_htmlのサンプル'),
      ),
      body: SingleChildScrollView(
        child: Html(
          data: """
      <h2>YouTube iframe:</h2>
      <iframe width="600" height="300" src="https://www.youtube.com/embed/fq4N0hgOWzU"></iframe>

      <h2>Twitter iframe:</h2>
      <iframe width="600" height="500" src="https://twitter.com/openwc/status/1427617679427440643"></iframe>

      <h2>Instagram iframe:</h2>
      <iframe width="600" height="600" src="https://www.instagram.com/p/CoZOiOXrqXF/?igshid=YmMyMTA2M2Y%3D"></iframe>

      <h2>Vimeo iframe:</h2>
      <iframe width="600" height="300" src="https://player.vimeo.com/video/262032904?h=680dd997a3&title=0&byline=0&portrait=0"></iframe>
      """,
          navigationDelegateForIframe: (NavigationRequest request) =>
              NavigationDecision.navigate,
        ),
      ),
    );
  }
}
