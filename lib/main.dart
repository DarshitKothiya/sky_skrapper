import 'package:c_convert/modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'helper.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  List currencyList = ['CAD', 'EUR', 'INR', 'JPY', 'USD'];

  bool isIOS = false;
  String? from;
  String? To;
  String API = "https://api.exchangerate.host/convert?from=USD&to=INR&amount=1";

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController amountController = TextEditingController();

  int iosConvertFromVal = 0;
  int iosConvertToVal = 0;

  @override
  Widget build(BuildContext context) {
    return (isIOS)
        ? MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: const Text("Currency Converter"),
                backgroundColor: Colors.teal,
                centerTitle: true,
                actions: [
                  Switch(
                    value: isIOS,
                    onChanged: (val) {
                      setState(() {
                        isIOS = val;
                      });
                    },
                  ),
                ],
              ),
              body: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Form(
                        key: formKey,
                        child: TextFormField(
                          controller: amountController,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Enter Amount First";
                            }
                          },
                          decoration: InputDecoration(
                              hintText: "Enter Amount",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 150,
                      width: 300,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.teal),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          DropdownButton(
                            hint: from == null
                                ? Text('Dropdown')
                                : Text(
                                    "$from",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                            isExpanded: true,
                            iconSize: 30.0,
                            style: TextStyle(color: Colors.blue),
                            items: ['CAD', 'EUR', 'INR', 'JPY', 'USD'].map(
                              (val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(val),
                                );
                              },
                            ).toList(),
                            onChanged: (val) {
                              setState(
                                () {
                                  from = val;
                                },
                              );
                            },
                          ),
                          DropdownButton(
                            hint: To == null
                                ? Text('Dropdown')
                                : Text(
                                    "$To",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                            isExpanded: true,
                            iconSize: 30.0,
                            style: TextStyle(color: Colors.blue),
                            items: ['CAD', 'EUR', 'INR', 'JPY', 'USD'].map(
                              (val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(val),
                                );
                              },
                            ).toList(),
                            onChanged: (val) {
                              setState(
                                () {
                                  To = val;
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (formKey.currentState!.validate()) {
                            String amount = amountController.text;
                            String convertFrom = from.toString();
                            String convertTo = To.toString();

                            API =
                                "https://api.exchangerate.host/convert?from=$convertFrom&to=$convertTo&amount=$amount";
                          }
                        });
                      },
                      child: Container(
                        height: 50,
                        width: 250,
                        decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(10)),
                        alignment: Alignment.center,
                        child: const Text("Convert Amount"),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Container(
                      height: 50,
                      width: 250,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.teal, width: 1.5)),
                      child: FutureBuilder(
                        future: CurrencyApiHelper.currencyApiHelper
                            .fetchCurrencyData(API: API),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text("Error: ${snapshot.error}");
                          } else if (snapshot.hasData) {
                            Currency? res = snapshot.data;

                            return Text("${res!.convertAmount}");
                          }

                          return CircularProgressIndicator();
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        : CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text("Currency Convertor"),
          trailing: CupertinoSwitch(
            onChanged: (val){
              setState(() {
                isIOS = val;
              });
            },
            value: isIOS,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Form(
                  key: formKey,
                  child: CupertinoTextFormFieldRow(
                    controller: amountController,

                    validator: (val){
                      if(val!.isEmpty){
                        return "Enter Amount";
                      }
                    },
                    placeholder: "Enter Amount",
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white,width: 1.5)
                       ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 150,
                width: 300,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.teal),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 55,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: CupertinoButton(
                        padding: const EdgeInsets.all(0),
                        child: from == null
                            ? Text('Dropdown', style: TextStyle(
                            color: Colors.black, fontSize: 15),)
                            : Text(
                          "$from",
                          style: TextStyle(
                              color: Colors.black, fontSize: 15),
                        ),
                        onPressed: () {
                          showCupertinoModalPopup(
                              context: context,
                              barrierDismissible: true,
                              builder: (context) {
                                return Container(
                                  height: 500,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white,
                                    ),
                                  ),
                                  child: CupertinoPicker(
                                    scrollController:
                                    FixedExtentScrollController(
                                      initialItem: iosConvertFromVal,
                                    ),
                                    itemExtent: 35,
                                    children: currencyList.map((val) {
                                      return DropdownMenuItem<
                                          String>(
                                        value: val,
                                        alignment: Alignment.center,
                                        child: Text(val),
                                      );
                                    }).toList(),
                                    onSelectedItemChanged: (val) {
                                      List data =  currencyList;
                                      setState(() {
                                        iosConvertFromVal =
                                            data.indexOf(data[val]);
                                        from = data[val];
                                      });
                                    },
                                  ),
                                );
                              });
                        },
                      ),
                    ),
                    Container(
                      height: 55,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: CupertinoButton(
                        padding: const EdgeInsets.all(0),
                        child: from == null
                            ? Text('Dropdown', style: TextStyle(
                            color: Colors.black, fontSize: 15),)
                            : Text(
                          "$To",
                          style: TextStyle(
                              color: Colors.black, fontSize: 15),
                        ),
                        onPressed: () {
                          showCupertinoModalPopup(
                              context: context,
                              builder: (context) {
                                return Container(
                                  height: 500,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white,
                                    ),
                                  ),
                                  child: CupertinoPicker(
                                    scrollController:
                                    FixedExtentScrollController(
                                      initialItem: iosConvertToVal,
                                    ),
                                    itemExtent: 35,
                                    children: currencyList.map((val) {
                                      return DropdownMenuItem<
                                          String>(
                                        value: val,
                                        alignment: Alignment.center,
                                        child: Text(val),
                                      );
                                    }).toList(),
                                    onSelectedItemChanged: (val) {

                                      setState(() {
                                        iosConvertToVal = currencyList.indexOf(currencyList[val]);
                                        from = currencyList[val];
                                      });
                                    },
                                  ),
                                );
                              });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (formKey.currentState!.validate()) {
                      String amount = amountController.text;
                      String convertFrom = from.toString();
                      String convertTo = To.toString();

                      API =
                      "https://api.exchangerate.host/convert?from=$convertFrom&to=$convertTo&amount=$amount";
                    }
                  });
                },
                child: Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(10)),
                  alignment: Alignment.center,
                  child: const Text("Convert Amount"),
                ),
              ),
              const SizedBox(height: 50),
              Container(
                height: 50,
                width: 250,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.teal, width: 1.5)),
                child: FutureBuilder(
                  future: CurrencyApiHelper.currencyApiHelper
                      .fetchCurrencyData(API: API),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else if (snapshot.hasData) {
                      Currency? res = snapshot.data;

                      return Text("${res!.convertAmount}");
                    }

                    return CircularProgressIndicator();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
