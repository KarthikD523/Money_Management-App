import 'package:flutter/material.dart';
import 'package:money_management/db/category/category_db.dart';
import 'package:money_management/models/category/category_model.dart';

class ExpenseCategory extends StatelessWidget {
   ExpenseCategory({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(valueListenable: CategoryDB().expenseCategory, 
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