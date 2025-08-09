class Messagemodel {
  String message;
  String? id;
  Messagemodel({required this.message, this.id});
  factory Messagemodel.fromjson(json) {
    return Messagemodel(message: json['message'], id: json['id']);
  }
}
