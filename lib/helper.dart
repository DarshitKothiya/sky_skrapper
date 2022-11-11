import 'dart:convert';
import 'package:c_convert/modal.dart';
import 'package:http/http.dart' as http;

class CurrencyApiHelper {
  CurrencyApiHelper._();
  static final CurrencyApiHelper currencyApiHelper = CurrencyApiHelper._();



  Future<Currency?> fetchCurrencyData({required String API}) async {
    http.Response res = await http.get(Uri.parse(API));

    if (res.statusCode == 200) {
      Map<String, dynamic> decodeData = jsonDecode(res.body);

      Currency currency = Currency.fromMap(decodeData);

      return currency;
    }
  }
}