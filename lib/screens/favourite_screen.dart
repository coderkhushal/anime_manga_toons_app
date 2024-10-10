
import 'dart:convert';
import 'package:demo_project/widgets/article_widget.dart';
import "package:path_provider/path_provider.dart";
import "dart:io";
import 'package:flutter/material.dart';
import "package:demo_project/models/article.dart";
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
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
    List<Article> list = List.from(decodeddata).map<Article>((article) => Article.fromMap(article)).toList().where((element) => element.favourite==true).toList();
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
