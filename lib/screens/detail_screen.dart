import 'dart:convert';
import "package:path_provider/path_provider.dart";
import "dart:io";
import 'package:flutter/material.dart';
import "package:demo_project/models/article.dart";
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
class DetailScreen extends StatefulWidget {
  final Article article ;

  final articleIndex;
  const DetailScreen({ required this.article, required this.articleIndex});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}


class _DetailScreenState extends State<DetailScreen> {
   late bool isFavourite ;
  void initState() {

    super.initState();
    isFavourite = widget.article.favourite;

  }
  toggleFavorite() async {

    final directory= await getApplicationDocumentsDirectory();
    final filepath = "${directory.path}/animedata.json";
    var articlesjson = await File(filepath).readAsString();
    var decodeddata= jsonDecode(articlesjson);
    List<Article> list = List.from(decodeddata).map<Article>((article) => Article.fromMap(article)).toList();
    list[widget.articleIndex].favourite = !(list[widget.articleIndex].favourite);
    await File(filepath).writeAsString(jsonEncode(list.map((e) => e.toMap()).toList()));

    setState(() {

      isFavourite = (list[widget.articleIndex].favourite);
      print(isFavourite);
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(

            children: [
              Text(widget.article.title,
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                fontSize: 35,
                fontWeight: FontWeight.bold,

              ),
              ),
              Container(
                height: 200,
                child: Image.network(widget.article.imageURL,
                  fit: BoxFit.contain,
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                     decoration: BoxDecoration(
                        color: Colors.purpleAccent.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(widget.article.genre,
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      // color: Colors.purpleAccent.withOpacity(0.4),


                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Creator"),
                          Padding(
                            padding: EdgeInsets.only(left:10),
                            child: Text(widget.article.creator,
                              style: GoogleFonts.lato(
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          )
                        ],
                      )
                    ),
                    Padding(
                      padding: EdgeInsets.only(right:10),
                      child: IconButton(
                        icon: Icon(
                          color: isFavourite ? Colors.red : Colors.black,
                          isFavourite ? Icons.favorite : Icons.favorite_border
                        ),
                        onPressed: toggleFavorite ,
                      ),
                    )
                  ],
                ),

              ),
              Padding(
                padding: EdgeInsets.only(top:30),
                  child: Text(widget.article.description))
            ],
          ),
        )
      ),
    );
  }
}

