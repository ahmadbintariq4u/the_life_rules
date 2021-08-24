import 'package:animations/animations.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:the_life/favorite.dart';
import 'package:the_life/home.dart';
import 'package:the_life/my_clipper.dart';
import 'package:the_life/setting.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  int currentTab = 1;
  PageController _pageController = PageController(initialPage: 1);
  final List<Widget> screens = [Favorite(), Home(), Setting()];
  Widget currentScreen = Home();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'The Life Rules',
        theme: ThemeData(
          accentColor: Colors.blueAccent,
          dividerColor: Colors.transparent,
        ),
        home: Scaffold(
          // appBar: AppBar(title: Text('The Life Rules')),

          bottomNavigationBar: CurvedNavigationBar(
            height: 50,
            backgroundColor: Colors.transparent,
            color: Colors.blueAccent,
            buttonBackgroundColor: Colors.blueAccent,
            items: <Widget>[
              Icon(
                Icons.favorite_rounded,
                size: 30,
                color: Colors.red[400],
              ),
              Icon(
                Icons.home,
                size: 30,
                color: Colors.white,
              ),
              Icon(
                Icons.settings,
                color: Colors.white,
              ),
            ],
            index: currentTab,
            animationCurve: Curves.decelerate,
            animationDuration: Duration(milliseconds: 500),
            onTap: (index) {
              setState(() {
                currentScreen = screens[index];
                // _pageController.jumpToPage(index);
                _pageController.animateToPage(index,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.linear);
              });
            },
          ),
          body: ClipPath(
            clipper: MyClipper(),
            child: PageView(
              clipBehavior: Clip.antiAlias,
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  currentTab = page;
                });
              },
              children: [
                Favorite(),
                Home(),
                Setting(),
              ],
            ),
          ),
        ));
  }
}
