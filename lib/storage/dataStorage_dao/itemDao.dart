import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';

import '../dataBase_setup/dataBaseSetupItem.dart';
import '../model/order_model.dart';


class ItemDao with ChangeNotifier {
  static const String folderName = "Order";
  static final _orderFolder = intMapStoreFactory.store(folderName);

  static Future<Database> get _db async => await AppDatabaseItem.instance.database;

  static Future insertItem(ItemModel item) async {
    await _orderFolder.add(await _db, item.toJson());
  }

  static Future updateItemByID(ItemModel item) async {
    final finder = Finder(filter: Filter.equals('id', item.id));
    await _orderFolder.update(await _db, item.toJson(), finder: finder);
  }

  static Future<List<ItemModel>> deleteByID(ItemModel item) async {
    final finder = Finder(filter: Filter.equals('id', item.id));
    await _orderFolder.delete(await _db, finder: finder);
    final recordSnapshot = await _orderFolder.find(await _db);
    return recordSnapshot.map((snapshot) {
      final order = ItemModel.fromJson(snapshot.value);
      return order;
    }).toList();
  }

  static Future<List<ItemModel>> deleteAll() async {
    await _orderFolder.delete(await _db);
    final recordSnapshot = await _orderFolder.find(await _db);
    return recordSnapshot.map((snapshot) {
      final order = ItemModel.fromJson(snapshot.value);
      return order;
    }).toList();
  }

  static Future<List<ItemModel>> getAllItem() async {
    final recordSnapshot = await _orderFolder.find(await _db);
    return recordSnapshot.map((snapshot) {
      final order = ItemModel.fromJson(snapshot.value);
      return order;
    }).toList();
  }
}
