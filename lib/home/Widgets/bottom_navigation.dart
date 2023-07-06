import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../category/screen_category.dart';
import '../screen_home.dart';


class Bottom_Navigation extends StatelessWidget {
   Bottom_Navigation({ Key? key }) : super(key: key);

 

  @override
  Widget build(BuildContext context) {
    return  ValueListenableBuilder(
      valueListenable: Screen_Home.selectedIndex,
      builder: (BuildContext ctx , int updatedIndex, Widget? _)
      {
     return  BottomNavigationBar(
      currentIndex: updatedIndex,
        onTap: (index){
      Screen_Home.selectedIndex.value=index;
        },
        items: 
      const [
     BottomNavigationBarItem(icon: Icon(CupertinoIcons.home),
     label: 'Transactions'
     ),
     BottomNavigationBarItem(icon: Icon(Icons.category),
     label: 'Category')
      ]
      );
      }
      
    );
  }
}

