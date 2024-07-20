import 'package:flutter/material.dart';
// import 'calendar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'test.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) =>  MaterialApp(
    debugShowCheckedModeBanner: false,
    theme:ThemeData(fontFamily: 'Sora' ),
    home: const homepage(),
  );
}

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  var page = <Widget>[const Calendar()];
  final int _navItem = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text("Calendar"),
      ),
      body: page[_navItem],

      bottomNavigationBar: NavigationBar(
        indicatorShape: const CircleBorder(),
        selectedIndex: _navItem,
        destinations: bottomNavItems(),
        backgroundColor: const Color.fromARGB(255, 223, 223, 223),
      ),
      );

  List<Widget> bottomNavItems(){
    var navItemIcons = [
      'asset/images/group.png', 'asset/images/create.png' , 'asset/images/note.png'
    ];

    var navItemLabels = [
      'Group' , 'Create' , 'Note'
    ];

    return List.generate(navItemLabels.length, (index) =>
        NavigationDestination(
          icon: Image.asset(navItemIcons[index],width: 50,height: 50,),
          label: navItemLabels[index],
        )
    );
  }
}

