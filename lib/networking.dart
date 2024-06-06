import 'dart:convert';

import 'package:http/http.dart' as http;
const apidata='https://rest.coinapi.io/v1/exchangerate';
const apikey='1B936F12-CDF8-4CEA-AC1B-3193D2727C90';
class NetworkHelper
{
  String selectedCurrency;
  String selectedCoin;
  NetworkHelper(this.selectedCurrency,this.selectedCoin);


  Future getApiData() async
  {
    http.Response response=await http.get(Uri.parse('$apidata/$selectedCoin/$selectedCurrency?apikey=$apikey'));
    if(response.statusCode==200)
      {
        print('GOOD');
          var data=response.body;
           return jsonDecode(data);





      }
    else {
      print('ERROR');
      print(response.statusCode);
    }
    return -1;
  }
}