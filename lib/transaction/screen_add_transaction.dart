import 'dart:async';

import 'package:flutter/material.dart';
import 'package:money_management/category/category_add_popup.dart';
import 'package:money_management/db/category/category_db.dart';
import 'package:money_management/db/transaction/transaction_db.dart';
import 'package:money_management/models/category/category_model.dart';
import 'package:money_management/models/transaction/transaction_model.dart';

class ScreenAddTransaction extends StatefulWidget {
  const ScreenAddTransaction({ Key? key }) : super(key: key);

  


  @override
  State<ScreenAddTransaction> createState() => _ScreenAddTransactionState();
}

class _ScreenAddTransactionState extends State<ScreenAddTransaction> {
  DateTime? _selectedDate;
  CategoryType? _selectedCategoryType;
  CategoryModel? _selectedCategoryModel;
  ValueNotifier<CategoryType> _selectedCategoryNotifier =ValueNotifier(CategoryType.income);
  String? _categoryID;

  final _purposeEdittingController=TextEditingController();
  final _amountEdittingController=TextEditingController();


   @override
  void initState() {
    _selectedCategoryType=CategoryType.income;
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    body: SafeArea(
      child: Column(
        children: [
          
      
                 
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _purposeEdittingController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Purpose',
                  border: OutlineInputBorder(),
                  )
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _amountEdittingController,
                  decoration: InputDecoration(
                    hintText: "Amount",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              TextButton.icon(onPressed: () async{
                final _selectedDateTemp= await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now().subtract(Duration(days:30)), lastDate: DateTime.now());
                print(_selectedDateTemp.toString());
                setState(() {
                  _selectedDate=_selectedDateTemp;
                });
              }, icon: Icon(Icons.calendar_today), label: Text(_selectedDate==null ? 'Select date':_selectedDate.toString())),

              
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Radio<CategoryType>(value: CategoryType.income, groupValue: _selectedCategoryType, onChanged: (newvalue){
                       setState(() {
                         _selectedCategoryType=CategoryType.income;
                          _categoryID=null;
                         
                       });
                      }),
                      Text('Income'),
                    ],
                  ),
                   Row(
                    children: [
                      Radio<CategoryType>(value: CategoryType.expense, groupValue: _selectedCategoryType, onChanged: (newvalue){
                        setState(() {
                          _selectedCategoryType=CategoryType.expense;
                          _categoryID=null;
                           
                        }); 
                      }),
                      Text('Expense'),
                    ],
                  ),
                ],
              ),
        
              
              
              DropdownButton( value: _categoryID,
                hint: Text('Select category'),
             
              items: (_selectedCategoryType==CategoryType.income? CategoryDB.instance.incomeCategory:CategoryDB.instance.expenseCategory).value.map((e) {
                return DropdownMenuItem(value: e.id,child: Text(e.name) ,
                onTap: (){
                  _selectedCategoryModel=e;
                },
                );
              }
              ).toList(), 
              onChanged: (selectedvalue)
              {
                print(selectedvalue);
                _categoryID=selectedvalue.toString();

              }),
              ElevatedButton.icon(onPressed: (){
                addTransaction();
                TransactionDB.instance.refresh();
                Navigator.of(context).pop();
              }, icon: Icon(Icons.check), label: Text('Submit')),
            ],
          ),
        
      ),
      );
    
    
  }
  Future<void> addTransaction()async{
    final _purposeText=_purposeEdittingController.text;
    final _amountText=_amountEdittingController.text;
    if(_purposeText==null){
      return;
    }
    if(_amountText==null){
      return;
    }
    if(_categoryID==null){
      return;
    }
    if(_selectedDate==null){
      return;
    }
    if(_selectedCategoryModel==null)
    {
      return;
    }
    final _parsedAmount=double.tryParse(_amountText);
    if(_parsedAmount==null){
      return;
    }

   final _model= TransactionModel(purpose: _purposeText,
     amount: _parsedAmount,
     date: _selectedDate!, 
     type: _selectedCategoryType!, 
     category: _selectedCategoryModel!);

     await TransactionDB.instance.addTransaction(_model);
     await TransactionDB.instance.refresh();

  }
}