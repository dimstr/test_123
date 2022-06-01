import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_markdown/flutter_markdown.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    Key? key,
    required this.type,
    required this.urlToMarkdown,
    required this.urlToWeb,
  }) : super(key: key);

  final String type;
  final String urlToMarkdown;
  final String urlToWeb;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    Widget _page = Container();
    if (widget.type == "m") {
      _page = MarkdownPage(urlToMarkDown: widget.urlToMarkdown);
    } else if (widget.type == "w") {
      _page = WebViewPage(initialUrl: widget.urlToWeb);
    } else if (widget.type == "v") {
      _page = Container();
    } else if (widget.type == "i") {
      _page = Container();
    }
    return Scaffold(
      appBar: AppBar(
          // elevation: 0,
          ),
      body: _page,
    );
  }
}

class WebViewPage extends StatefulWidget {
  const WebViewPage({
    Key? key,
    required this.initialUrl,
  }) : super(key: key);

  final String initialUrl;

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  void initState() {
    super.initState();

    if (kIsWeb) WebView.platform = WebWebViewPlatform();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: widget.initialUrl,
    );
  }
}

class MarkdownPage extends StatefulWidget {
  const MarkdownPage({
    Key? key,
    required this.urlToMarkDown,
  }) : super(key: key);

  final String urlToMarkDown;

  @override
  State<MarkdownPage> createState() => _MarkdownPageState();
}

class _MarkdownPageState extends State<MarkdownPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: http.get(
        Uri.parse(widget.urlToMarkDown),
      ),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Markdown(
            data: snapshot.data!.body,
            styleSheet: MarkdownStyleSheet(
              p: const TextStyle(
                fontSize: 18,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text(
                'Произошла неизвестая ошибка! Проверьте подключение к интернету'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
