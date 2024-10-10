import 'dart:convert';
import "dart:io";
import "package:path_provider/path_provider.dart";
import 'package:demo_project/widgets/article_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:demo_project/models/article.dart";
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState(){
    
    super.initState();
        loaddata();
  }
  loaddata() async {

    final directory= await getApplicationDocumentsDirectory();
    final filepath = "${directory.path}/animedata.json";
    var articlesjson = await File(filepath).readAsString() ;
    var decodeddata= jsonDecode(articlesjson);
    List<Article> list = List.from(decodeddata).map<Article>((article) => Article.fromMap(article)).toList();
    ArticleModel.articles = list;

    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    loaddata();
    return Container(
      child: (ArticleModel.articles.length!=0 && ArticleModel.articles.isNotEmpty) ?  ListView.builder(
        itemCount: ArticleModel.articles.length,
        itemBuilder: (context, index){
          return ArticleWidget(
            articleIndex: index,
            article : ArticleModel.articles[index]
          );
        },
      ) :
          Center(
            child: CircularProgressIndicator(),
          )
    );
  }
}
