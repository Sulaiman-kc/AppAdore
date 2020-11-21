import 'package:http/http.dart' as http;
import 'dart:convert';
final String apiUrl = "https://elephant-api.herokuapp.com/elephants";
class DataModel {
  List Data;
  Future fetchUsers() async {
    var result = await http.get(apiUrl);
    return jsonDecode(result.body);
  }
}
