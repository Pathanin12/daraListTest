import 'package:flutter/material.dart';
import '../storage/dataStorage_dao/itemDao.dart';
import '../storage/model/order_model.dart';
import 'insertData.dart';

class showListData extends StatefulWidget {
  const showListData({Key? key}) : super(key: key);

  @override
  State<showListData> createState() => _showListDataState();
}

class _showListDataState extends State<showListData> {
  List<ItemModel> item = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ItemDao.getAllItem().then((value) {
      setState(() {
        item = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            actions: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const insertData(1, null)));
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.indigoAccent,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ]),
                  margin: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 5, right: 15),
                  width: 60,
                  alignment: Alignment.center,
                  child: const Text(
                    'Add+',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              )
            ],
            leading: const SizedBox(),
            backgroundColor: Colors.black45,
            elevation: 0,
            title: const Center(
              child: Text(
                'Data',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
          body: (item.isEmpty)
              ? Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.do_not_disturb_alt,
                        size: 25,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'no information',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      )
                    ],
                  ),
                )
              : ListView(
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                  color: Colors.deepPurpleAccent,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(8),
                                      topLeft: Radius.circular(8))),
                              width: MediaQuery.of(context).size.width * 0.95,
                              height: 50,
                              child: Row(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'Item',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const VerticalDivider(
                                    width: 20,
                                    thickness: 3,
                                    indent: 1,
                                    endIndent: 0,
                                    color: Colors.grey,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'Qty',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const VerticalDivider(
                                    width: 20,
                                    thickness: 3,
                                    indent: 1,
                                    endIndent: 0,
                                    color: Colors.grey,
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            deleteAll();
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.3),
                                                    spreadRadius: 3,
                                                    blurRadius: 5,
                                                    offset: const Offset(0,
                                                        3), // changes position of shadow
                                                  ),
                                                ]),
                                            margin: const EdgeInsets.only(
                                                top: 3,
                                                bottom: 3,
                                                left: 5,
                                                right: 5),
                                            height: 40,
                                            width: 80,
                                            alignment: Alignment.center,
                                            child: const Text(
                                              'DeleteAll',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.95,
                              height: MediaQuery.of(context).size.height * 1,
                              child: listData(),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
        ),
      ),
    );
  }

  Widget listData() {
    return ListView.builder(
      padding: EdgeInsets.zero,
      // shrinkWrap: true,
      // physics: BouncingScrollPhysics(),
      itemCount: item.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Container(
              height: 40,
              padding: const EdgeInsets.only(left: 5, right: 5),
              color: Colors.white,
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    alignment: Alignment.center,
                    child: Text(
                      '${item[index].item}',
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ),
                  const VerticalDivider(
                    width: 20,
                    thickness: 3,
                    indent: 0,
                    endIndent: 0,
                    color: Colors.grey,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    alignment: Alignment.center,
                    child: Text(
                      '${item[index].qty}',
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ),
                  const VerticalDivider(
                    width: 20,
                    thickness: 3,
                    indent: 0,
                    endIndent: 0,
                    color: Colors.grey,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  insertData(2, item[index])));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.indigoAccent,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ]),
                      margin: const EdgeInsets.only(
                          top: 3, bottom: 3, left: 5, right: 5),
                      height: 40,
                      width: 60,
                      alignment: Alignment.center,
                      child: const Text(
                        'Edit',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      delete(item[index]);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ]),
                      margin: const EdgeInsets.only(
                          top: 3, bottom: 3, left: 5, right: 5),
                      height: 40,
                      width: 60,
                      alignment: Alignment.center,
                      child: const Text(
                        'Delete',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Divider(
              height: 3,
              color: Colors.grey,
            )
          ],
        );
      },
    );
  }

  delete(ItemModel _item) async {
    await ItemDao.deleteByID(_item).then((value) async {
      setState(() {
        item = value;
      });
    });
  }

  deleteAll() async {
    await ItemDao.deleteAll().then((value) async {
      setState(() {
        item = value;
      });
    });
  }
}
