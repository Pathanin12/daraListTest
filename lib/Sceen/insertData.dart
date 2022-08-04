import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

import '../storage/dataStorage_dao/itemDao.dart';
import '../storage/model/order_model.dart';
import 'listData.dart';

class insertData extends StatefulWidget {
  final int typePage;
  final ItemModel ?Item;

  const insertData(this.typePage,this.Item, {super.key});

  @override
  State<insertData> createState() => _insertDataState();
}

class _insertDataState extends State<insertData> {
  TextEditingController ?textItem = TextEditingController();
  TextEditingController ?textQty = TextEditingController();
  final formKey = GlobalKey<FormState>();
  ItemModel ? item;
  var uuid = const Uuid();
  String ? id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    changData();
  }

  changData() async {
    setState(() {
      if (widget.typePage == 1) {
        id = uuid.v4();
      } else {
        item = widget.Item;
        id = item!.id;
        textItem!.text = item!.item.toString();
        textQty!.text = item!.qty.toString();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textItem!.dispose();
    textQty!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios,size: 25,color: Colors.white,),
          ),
          backgroundColor: Colors.black45,
          elevation: 0,
          title: Center(
            child: Text(
              (widget.typePage == 1) ? 'InsertData' : 'EditData',
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
        body: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(

                    margin: const EdgeInsets.only(right: 20),
                    alignment: Alignment.centerRight,
                    width: 60,
                    child: const Text(
                      'Item  :', style: TextStyle(color: Colors.black),),
                  ),
                  SizedBox(
                    height: 40,
                    width: 150,
                    child: TextFormField(
                      validator: (value) {
                        if (textItem!.text.trim().isEmpty) {
                          return 'Please enter information.';
                        }
                        return null;
                      },
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(3),
                      ],

                      autofocus: false,
                      controller: textItem,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: "Item",
                        floatingLabelBehavior: FloatingLabelBehavior.always,

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.grey),
                          gapPadding: 10,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.grey),
                          gapPadding: 10,
                        ),
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    alignment: Alignment.centerRight,
                    width: 60,
                    child: const Text(
                      'Qty  :', style: TextStyle(color: Colors.black),),
                  ),
                  SizedBox(
                    height: 40,
                    width: 150,
                    child: TextFormField(
                      validator: (value) {
                        if (textQty!.text.trim().isEmpty) {
                          return 'Please enter information.';
                        }
                        return null;
                      },
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(3),
                      ],
                      autofocus: false,
                      controller: textQty,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Qty",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.grey),
                          gapPadding: 10,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.grey),
                          gapPadding: 10,
                        ),
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10,),
              InkWell(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    insertOrEditData();
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 80,
                  height: 35,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: const Text('Save',
                    style: TextStyle(color: Colors.white, fontSize: 15),),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
  Future<void>insertOrEditData()async{
    var data = {
      'id': id,
      'item':textItem!.text.trim().toString() ,
      'qty':textQty!.text.trim().toString()
    };
    var _data= ItemModel.fromJson(data);
    if(widget.typePage==1){
      insert(_data);
    }else{
      edit(_data);
    }
  }

  Future<void> insert(var data) async {
    print(jsonEncode(data));
   await ItemDao.insertItem(data).then((value) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const showListData()));
    });
  }

  Future<void> edit(var data) async {
    print(jsonEncode(data));
    await ItemDao.updateItemByID(data).then((value) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const showListData()));
    });
  }
}
