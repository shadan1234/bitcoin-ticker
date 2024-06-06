import 'package:bitcoin_ticker/networking.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

const apidata = 'https://rest.coinapi.io/v1/exchangerate/';
const apikey = '1B936F12-CDF8-4CEA-AC1B-3193D2727C90';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  int rate1 = 0;
  int rate2 = 0;
  int rate3 = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    exchangeRate();
  }

  void exchangeRate() async {
    // NetworkHelper networkHelper=NetworkHelper(Uri.parse('$apidata BTC/USD ?apikey=$apikey'));
    try {
      NetworkHelper networkHelper = NetworkHelper(selectedCurrency, 'BTC');
      var data = await networkHelper.getApiData();
      double conversion = (data['rate']);
      rate1 = conversion.toInt();
      setState(() {});
    } catch (e) {
      print(e);
    }
    try {
      NetworkHelper networkHelper = NetworkHelper(selectedCurrency, 'ETH');
      var data = await networkHelper.getApiData();
      double conversion = (data['rate']);
      rate2 = conversion.toInt();
      setState(() {});
    } catch (e) {
      print(e);
    }
    try {
      NetworkHelper networkHelper = NetworkHelper(selectedCurrency, 'LTC');
      var data = await networkHelper.getApiData();
      double conversion = (data['rate']);
      rate3 = conversion.toInt();
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  DropdownButton<String> getAndroid() {
    return DropdownButton<String>(
      value: selectedCurrency,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value!;
          exchangeRate();
        });

        // print(rate);
      },
      items: [
        for (int i = 0; i < 21; i++)
          DropdownMenuItem(
            child: Text(currenciesList[i]),
            value: currenciesList[i],
          ),
      ],
    );
  }

  CupertinoPicker ios() {
    return CupertinoPicker(
        itemExtent: 32.0,
        onSelectedItemChanged: (value) {
          print(value);
        },
        children: [
          for (int i = 0; i < 21; i++) Text(currenciesList[i]),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: GestureDetector(
              onTap: () {
                exchangeRate();
                setState(() {
                  // print(rate);
                });
              },
              child: Card(
                color: Colors.lightBlueAccent,
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                  child: Text(
                    '1 BTC = $rate1 $selectedCurrency',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: GestureDetector(
              onTap: () {
                exchangeRate();
                setState(() {
                  // print(rate);
                });
              },
              child: Card(
                color: Colors.lightBlueAccent,
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                  child: Text(
                    '1 ETH = $rate2 $selectedCurrency',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: GestureDetector(
              onTap: () {
                exchangeRate();
                setState(() {
                  // print(rate);
                });
              },
              child: Card(
                color: Colors.lightBlueAccent,
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                  child: Text(
                    '1 LTC = $rate3 $selectedCurrency',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 280,
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? ios() : getAndroid(),
          ),
        ],
      ),
    );
  }
}
