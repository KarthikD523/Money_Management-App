import 'package:flutter/cupertino.dart';
import 'package:money_management/models/category/category_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

const Category_DB_Name= "category-database";

// ignore: implementation_imports

abstract class CategoryDBFunctions
{
  Future<List<CategoryModel>> getCategories();
  Future<void> insertCategory(CategoryModel value);
  Future<void> deleteCategory(String categoryID);
}
class CategoryDB implements CategoryDBFunctions
{
  CategoryDB._internal();
  static CategoryDB instance=CategoryDB._internal();

  factory CategoryDB()
  {
    return instance;
  }

  ValueNotifier<List<CategoryModel>> incomeCategory=ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseCategory=ValueNotifier([]);


  @override
  Future<void> insertCategory(CategoryModel value) async{
   final _categoryDB=await Hive.openBox<CategoryModel>(Category_DB_Name);
   _categoryDB.put(value.id,value);
   refreshUI();
  }

@override Future<List<CategoryModel>> getCategories() async {
     final _categoryDB=await Hive.openBox<CategoryModel>(Category_DB_Name);
   return _categoryDB.values.toList();
  }

  Future<void> refreshUI() async
  {
    final _allcategories=await getCategories();
    incomeCategory.value.clear();
    expenseCategory.value.clear();
    Future.forEach(_allcategories, (CategoryModel category) {
      if(category.type==CategoryType.income)
      {
        incomeCategory.value.add(category);
      }
      else{
        expenseCategory.value.add(category);
      }
    }
    );
    incomeCategory.notifyListeners();
    expenseCategory.notifyListeners();
  }

  @override
  Future<void> deleteCategory(String categoryID) async {
    final _categoryDB= await Hive.openBox<CategoryModel>(Category_DB_Name);
    _categoryDB.delete(categoryID);
    refreshUI();
  }
  

  }
