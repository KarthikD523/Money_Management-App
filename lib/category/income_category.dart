import 'package:flutter/material.dart';

import '../db/category/category_db.dart';
import '../models/category/category_model.dart';

class IncomeCategory extends StatelessWidget {
   IncomeCategory({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(valueListenable: CategoryDB().incomeCategory, 
    builder:(BuildContext ctx,List<CategoryModel> newList,Widget? _)
    {
      
      return ListView.separated(itemBuilder:(context,index)
    {
      final _category=newList[index];
      return  Card(
        child: ListTile(
          title: Text(_category.name),
          trailing: IconButton(onPressed: (){
            CategoryDB.instance.deleteCategory(_category.id);
          }, icon: Icon(Icons.delete)),
        ),
      );
    } , 
    separatorBuilder: (context,index)
    {
      return SizedBox(height:10);
    },
     itemCount: newList.length)
    ;
  }
    );
    }
}