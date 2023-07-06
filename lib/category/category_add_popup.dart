import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_management/db/category/category_db.dart';
import 'package:money_management/models/category/category_model.dart';

ValueNotifier<CategoryType> selectedCategoryNotifier =ValueNotifier(CategoryType.income);

Future<void> showCategoryPopup(BuildContext context){
  final _nameEdittingController=TextEditingController();
return showDialog(context: context , builder: (ctx){
return SimpleDialog(
  title: Text('ADD CATEGORY'),
  children: [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _nameEdittingController,
        decoration: InputDecoration(
          hintText: 'Category name',
          border: OutlineInputBorder(),
        ),
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          RadioButton(title: 'Income', type: CategoryType.income),
          RadioButton(title: 'Expense', type: CategoryType.expense),

        ],
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(onPressed: (){
        final _name=_nameEdittingController.text.toString();
        final _type=selectedCategoryNotifier.value;
        if(_name.isEmpty)
        {
          return;
        }
        final _category=CategoryModel(id: DateTime.now().microsecondsSinceEpoch.toString(), name: _name, type: _type);
        CategoryDB().insertCategory(_category);
        Navigator.of(context).pop();
      }, child: Text('Save')),
    )
  ],
);

}
);
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  const RadioButton({ Key? key,
  required this.title,
  required this.type
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: selectedCategoryNotifier,
          builder:(BuildContext ctx, CategoryType newCategory, Widget? _) {
            return Row(
            children: [
              Radio<CategoryType>(value: type, 
              groupValue: newCategory, 
              onChanged: (value){
                if(value==Null)
                {
                  return;
                }
                else{
                selectedCategoryNotifier.value= value!;
                selectedCategoryNotifier.notifyListeners();}
              }
              )
            ],
          );
          },
        
        ),
        Text(title),
      ],
      
    );
    
  }
}