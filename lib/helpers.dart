import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:random_people_data/modal.dart';

class RandomDataAPIHelper{
  RandomDataAPIHelper._();

  static final RandomDataAPIHelper randomDataAPIHelper = RandomDataAPIHelper._();

  Future<Random?> fetchSingelRandomData({required String API}) async{

    http.Response res = await http.get(Uri.parse(API));

    if(res.statusCode==200){

      Map decodedData = jsonDecode(res.body);

      Random random = Random.fromMap(data: decodedData);

      return random;
    }

  }
}