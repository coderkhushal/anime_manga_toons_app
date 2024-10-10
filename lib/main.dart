import 'package:demo_project/screens/detail_screen.dart';
import 'package:demo_project/screens/favourite_screen.dart';
import 'package:demo_project/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:path_provider/path_provider.dart";
import "dart:io";
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bottom Navigation Bar',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        "/": (context) => MyHomePage(title: "AnimeMangaToons"),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final pageController = PageController(initialPage: 0);
  late int _selectedIndex = 0;
  void initState() {

  checkandwritefile();
  }
  void checkandwritefile()async{

    final directory= await getApplicationDocumentsDirectory();
    final filepath = "${directory}/animedata.json";
    var content = await rootBundle.loadString("assets/files/animedata.json");
    var file = File(filepath).writeAsString(content);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            "AnimeMangaToons",
            style: GoogleFonts.lato(
                color: Colors.white, fontWeight: FontWeight.bold),
          )),
          backgroundColor: Colors.deepPurple,
        ),
        extendBody: true,
        body: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Center(child: HomeScreen()),
            Center(
              child: FavouriteScreen(),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.deepPurple,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
              pageController.jumpToPage(index);
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Home",
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.border_all_outlined), label: "Favourite")
          ],
        ),
      ),
    );
  }
}
