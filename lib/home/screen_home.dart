import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_management/category/category_add_popup.dart';
import 'package:money_management/category/screen_category.dart';
import 'package:money_management/db/category/category_db.dart';
import 'package:money_management/home/Widgets/bottom_navigation.dart';

import 'package:money_management/main.dart';
import 'package:money_management/models/category/category_model.dart';
import 'package:money_management/transaction/screen_transaction.dart';


class Screen_Home extends StatelessWidget {
   Screen_Home({ Key? key }) : super(key: key);
 
  static ValueNotifier<int> selectedIndex=ValueNotifier(0);
  

   List<Widget> _pages= [Screen_Transaction(),Screen_Category()];
   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Money Manager'),
        centerTitle: true,
      ),
    bottomNavigationBar:  Bottom_Navigation(),

    body: SafeArea(
     child: ValueListenableBuilder(
        valueListenable: selectedIndex,
        builder: (BuildContext context, int updatedIndex, Widget? _) {
          return  _pages[selectedIndex.value];
        },
      ),
      
    ),
    
    floatingActionButton: FloatingActionButton(onPressed: (){
      if(selectedIndex.value==0)
      {
        print('Add transaction');
        Navigator.of(context).pushNamed('/Add_trans');
      }
      else if(selectedIndex.value==1)
      {
        showCategoryPopup(context);
        //final _sample=CategoryModel(id: DateTime.now().microsecondsSinceEpoch.toString(),
         //name: 'Travle',
         // type: CategoryType.expense);
         // CategoryDB().insertCategory(_sample);
      }

    },
    child: Icon(Icons.add)),

    );
    
    
  }
}