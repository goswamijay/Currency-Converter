import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiClient {
  final Uri currencyURL = Uri.https("free.currconv.com", "api/v7/currencies", {
    "apiKey": "4f6ef6f6c136f9f2e860"
  });
  String apiKey = "defff1f9da263b5ebd3017ac";

  Future<List<String>> getCurrencies() async {
    http.Response res = await http.get(currencyURL);
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      var list = body["results"];
      List<String> currencies = (list.keys).toList();
      print(currencies);
      return currencies;
    } else {
      throw Exception("Failed to connect to API");
    }
  }

  Future<double> getRate(String from, String to) async {
    final Uri rateUrl = Uri.https("free.currconv.com", "api/v7/convert", {
      "apiKey": "4f6ef6f6c136f9f2e860",
      "q": "${from}_${to}",
      "compact": "ultra",
    });
    print("${from}");
    http.Response res = await http.get(rateUrl);
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      return body["${from}_${to}"];
    } else {
      throw Exception("Faild to connect to API");
    }
  }
}
