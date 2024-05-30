import 'dart:convert';
import 'package:http/http.dart' as http;
import 'room_model.dart';

class FetchUser {
  var data = [];
  List<Data> result = [];
  String fetchurl = "https://reservasihotelbe-dot-e-02-415004.as.r.appspot.com/api/roomtypes";

  Future<List<Data>> getUserList({String? query}) async {
    var url = Uri.parse(fetchurl);
    var response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var rooms = roomList.fromJson(jsonData);
        result = rooms.data!;

        if (query != null && query.isNotEmpty) {
          result = result
              .where((element) =>
              element.name!.toLowerCase().contains(query.toLowerCase()))
              .toList();
        }
      } else {
        print('API error');
      }
    } on Exception catch (e) {
      print('error: $e');
    }
    return result;
  }
}
