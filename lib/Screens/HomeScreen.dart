import 'package:flutter/material.dart';

//non-library
import 'package:jinnie/Screens/WishScreen.dart';
import 'package:jinnie/Screens/LoginScreen.dart';
import 'package:jinnie/Utils/Constants.dart';

class HomeScreen extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() {
    if (Constants.tempAccessToken != null) {
      return _HomeScreenState();
    }
    else {
      return _HomeLoginState();
    }
  }
}

class _HomeLoginState extends State<HomeScreen> {
  @override
    Widget build(BuildContext context) {
      
      return LoginScreen();
    }
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        
      ),
      body: DefaultTabController(
        length: 4,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: Text("Title"),
                backgroundColor: Colors.blue[300],
                pinned: true,
                floating: true,
                // forceElevated: innerBoxIsScrolled,
                bottom: new TabBar(
                  indicatorColor: Colors.white,
                  tabs: <Tab>[
                    new Tab(icon: Icon(Icons.home),),
                    new Tab(icon: Icon(Icons.announcement),),
                    new Tab(icon: Icon(Icons.notifications),),
                    new Tab(icon: Icon(Icons.mail),)
                  ],
                  controller: _tabController,
                ),
              ),
            ];
          },
          body: new TabBarView(
            controller: _tabController,
            children: <Widget>[
              new WishScreen(),
              new WishScreen(),
              new WishScreen(),
              new WishScreen()
            ],
          )
        ),
      ),
    );
  }
}
