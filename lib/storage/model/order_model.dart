class ItemModel {
  String? id;
  String? item;
  String? qty;

  ItemModel({this.id, this.item, this.qty});

  ItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    item = json['item'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item'] = this.item;
    data['qty'] = this.qty;
    return data;
  }
}
