import "package:demo_project/screens/detail_screen.dart";
import "package:flutter/material.dart";
import "package:demo_project/models/article.dart";
import "package:google_fonts/google_fonts.dart";

class ArticleWidget extends StatefulWidget {
  final Article article;
  final articleIndex ;
  const ArticleWidget({required this.article, required this.articleIndex});

  @override
  State<ArticleWidget> createState() => _ArticleWidgetState();
}

class _ArticleWidgetState extends State<ArticleWidget> {
  bool isFavourite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailScreen(article: widget.article, articleIndex: widget.articleIndex)));
      },
      child: Card(
        child: Column(
          children: [
            Container(
                height: 200,
                child: Image.network(
                  widget.article.imageURL,
                  fit: BoxFit.contain,
                )),
            Padding(
              padding: EdgeInsets.all(6),
              child: Text(widget.article.title,
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold, fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
