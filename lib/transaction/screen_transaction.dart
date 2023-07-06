import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_management/db/category/category_db.dart';
import 'package:money_management/db/transaction/transaction_db.dart';
import 'package:money_management/models/category/category_model.dart';

import '../models/transaction/transaction_model.dart';


class Screen_Transaction extends StatelessWidget {
  const Screen_Transaction({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool choice=false;
     TransactionDB.instance.refresh();
     CategoryDB.instance.refreshUI();
    
    
      

      
        return   ValueListenableBuilder(
         valueListenable: TransactionDB.instance.transactionListNotifier  ,
         builder: (BuildContext context,List<TransactionModel> newList, Widget? _) {
           return ListView.separated(
        padding: EdgeInsets.all(10),
        itemBuilder: (BuildContext context, int index)
        {
          final _value=newList[index];
          print(_value.purpose.toString());
          return Slidable(
            startActionPane: ActionPane(motion:ScrollMotion(), children: [
              SlidableAction(onPressed: (context){
                TransactionDB.instance.deleteTransaction(_value.id!);
              },
              icon: Icons.delete,
              label: 'delete',
              )
            ]),
            key: Key(_value.id!),
            child: Card(
              child:  ListTile(
                leading:  CircleAvatar(
                  radius: 50,
                  child: Text(parseDate(_value.date),
                  textAlign: TextAlign.center,),
                  backgroundColor: _value.type==CategoryType.income?Colors.red:Colors.green,
                  ),
                title: Text('RS ${_value.amount}'),
                subtitle:  Text(_value.category.name),
              ),
            ),
          );
        }, 
        separatorBuilder: (BuildContext context,int index)
        {
          return const SizedBox(height:10);
        },
         itemCount: newList.length);
         },
       );
  }
      
     
    
    
    
  }
  String parseDate(DateTime date)
  {
    final _date=DateFormat.MMMd().format(date);
    final _splitted_date=_date.split(' ');
        return '${_splitted_date.last}\n${_splitted_date.first}';
  }
  
