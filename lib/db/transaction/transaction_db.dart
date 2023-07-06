import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management/models/transaction/transaction_model.dart';

const Transaction_DB_Name='transaction-db';

abstract class Transaction_DB_Functions{
  Future<void> addTransaction(TransactionModel obj);
  Future<List<TransactionModel>> getAllTransaction();
  Future<void> deleteTransaction(String id);
}

class TransactionDB implements Transaction_DB_Functions{

 

 TransactionDB._internal();
 static TransactionDB instance=TransactionDB._internal();

 factory TransactionDB() {
  return instance;
 }
  ValueNotifier<List<TransactionModel>>  transactionListNotifier=ValueNotifier([]);

  @override
  Future<void> addTransaction(TransactionModel obj) async {
   final _db= await  Hive.openBox<TransactionModel>(Transaction_DB_Name);
   await _db.put(obj.id, obj);
   TransactionDB.instance.refresh();
  }

  @override
  Future<List<TransactionModel>> getAllTransaction() async{
    final _db=await Hive.openBox<TransactionModel>(Transaction_DB_Name);
    return _db.values.toList();
  }

  

  Future<void> refresh() async{
    
    final _list=await getAllTransaction();
    _list.sort((first,second){
      return first.date.compareTo(second.date);
    });
     transactionListNotifier.value.clear();
    Future.forEach(_list, (TransactionModel val){
     transactionListNotifier.value.add(val);
    });
    
   
    
    print(transactionListNotifier.value.length);
    transactionListNotifier.notifyListeners();
  }

  @override
  Future<void> deleteTransaction(String id) async{
     final _db=await Hive.openBox<TransactionModel>(Transaction_DB_Name);
   await  _db.delete(id);
   refresh();
  }
}