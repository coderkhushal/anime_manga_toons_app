import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:demo_project/widgets/article_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:demo_project/models/article.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final directory = await getApplicationDocumentsDirectory();
    final filepath = "${directory.path}/animedata.json";

    // Check if the file exists
    if (!await File(filepath).exists()) {
      final String assetPath = 'assets/files/animedata.json';
      final String articlesJson = await rootBundle.loadString(assetPath);


      await File(filepath).writeAsString(articlesJson);
      print('File created at: $filepath');
    }

    var articlesJson = await File(filepath).readAsString();
    var decodedData = jsonDecode(articlesJson);
    List<Article> list = List.from(decodedData).map<Article>((article) => Article.fromMap(article)).toList();
    ArticleModel.articles = list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Popular Toons')),
      body: (ArticleModel.articles.isNotEmpty)
          ? ListView.builder(
        itemCount: ArticleModel.articles.length,
        itemBuilder: (context, index) {
          return ArticleWidget(
            articleIndex: index,
            article: ArticleModel.articles[index],
          );
        },
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
