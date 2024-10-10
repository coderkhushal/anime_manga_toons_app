class ArticleModel {
  static List<Article> articles = [];
}
class Article{
  final title;
  final imageURL;
  final creator;
  final genre;
  final description;
  bool favourite;
  Article({this.title, this.imageURL, this.creator, this.genre, this.description, required this.favourite});

  static  Article fromMap(Map<String, dynamic> mp){
    return Article(
      title : mp["title"],
      description: mp["description"],
      genre: mp["genre"],
      creator: mp["creator"],
      imageURL: mp["imageURL"],
      favourite: mp["favourite"]

    );
  }
  toMap() => {
    "title": title,
    "description":description,
    "creator":creator,
    "genre":genre,
    "imageURL":imageURL,
    "favourite":favourite
  };

}
