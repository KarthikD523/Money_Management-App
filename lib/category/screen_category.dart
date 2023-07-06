import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_management/category/Expense_category.dart';
import 'package:money_management/category/income_category.dart';
import 'package:money_management/db/category/category_db.dart';

class Screen_Category extends StatefulWidget {
  const Screen_Category({ Key? key }) : super(key: key);

  @override
  State<Screen_Category> createState() => _Screen_CategoryState();
}

class _Screen_CategoryState extends State<Screen_Category> with SingleTickerProviderStateMixin {

  late  TabController _tabcontrolller;

  @override
  void initState() {
    // TODO: implement initState
    _tabcontrolller=TabController(length: 2,vsync: this);
    CategoryDB().refreshUI();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

    body: SafeArea(child: Column(
      children: [
        TabBar(
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          controller: _tabcontrolller,
          tabs: [
          Tab(text: 'INCOME',
          ),
          Tab(text: 'EXPENSE'),

        ]),
        Expanded(
          child: TabBarView(
            controller: _tabcontrolller,
            children: [
            IncomeCategory(),
            ExpenseCategory(),
          ]),
        )
      ],
    )),

    );
    
    
  }
}