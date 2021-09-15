import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'drawer.dart';
import 'globals.dart' as globals;

void main() {
  runApp(CurrencyConverter());
}

class CurrencyConverter extends StatefulWidget {
  const CurrencyConverter({Key? key}) : super(key: key);
  @override
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  var fromController = TextEditingController();
  var toController = TextEditingController();
  Widget build(BuildContext context) {
    globals.fromCurrency ??= '';
    globals.toCurrency ??= '';
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Lato'),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: Colors.green.shade300,
          title: Text('Currency Converter'),
          centerTitle: true,
        ),
        drawer: MainDrawer(
          toCurrencyChanged: (toVal) {
          setState(() {
            globals.toCurrency = toVal;
            globals.fromCurrencyVal = 0;
            globals.result = null;
            fromController.clear();
            toController.clear();
          });
        },
          fromCurrencyChanged: (fromVal){
            setState(() {
            globals.fromCurrency = fromVal;  
            globals.fromCurrencyVal = 0;
            globals.result = null;
            fromController.clear();
            toController.clear();                        
            });
          }
        ),
    body: SafeArea(
          child: Column(
            children: [
              Card(
                elevation: 3,
                margin: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        "Convert From ${globals.fromCurrency}",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.lightGreen.shade400,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                      indent: 20,
                      endIndent: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Convert To ${globals.toCurrency}',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.lightGreen.shade400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  margin: EdgeInsets.only(right: 20, left: 10),
                  //color: Colors.lightGreen.shade50,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 40),
                        child: buildTextField(
                            Icon(
                              Icons.undo,
                              color: Colors.green.shade300,
                            ),
                            'From ${globals.fromCurrency!}',
                            false,
                            fromController),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextButton.icon(
                        label: Text(''),
                        icon: Icon(
                          Icons.import_export,
                          size: 43,
                          color: Colors.grey.shade700,
                        ),
                        onPressed: () {
                          setState(() {                           
                          String temp = '';
                          temp = globals.fromCurrency!; //USD
                          globals.fromCurrency = globals.toCurrency!; // USD --> EUR
                          globals.toCurrency = temp; //EUR--> USD
                          print('Reverse Clicked');
                          print('From: ${globals.fromCurrency}');
                          print('To: ${globals.toCurrency}');
                          });
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.all(-3)),
                          splashFactory: NoSplash.splashFactory,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 40),
                        child: buildTextField(
                            Icon(
                              Icons.redo,
                              color: Colors.green.shade300,
                            ),
                            'To ${globals.toCurrency!}',
                            true,
                            toController,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.red,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        child: Text(
                          'Convert!',
                          style: TextStyle(
                              fontSize: 27, fontWeight: FontWeight.bold),
                        ),
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.symmetric(vertical: 18)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green.shade300),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                        ),
                        //CONVERT BUTTON LOGIC
                        onPressed: () {
                          setState(() {
                          bool success = false;
                          for(var x in globals.cnvRates.keys){
                          try{
                          globals.fromCurrencyVal = double.parse(fromController.text);
                          }
                          on FormatException{
                            print('error caught');
                            break;
                          }
                          //OFFLINE MODE
                          if(globals.online!=true && globals.ratesFetchedSuccesfully !=true && globals.liveRates.length <1){       
                            print('Calculated using offline mode');                
                            if(x.contains(globals.fromCurrency!)&&x.contains(globals.toCurrency!)){
                              globals.currentCnvRate = globals.cnvRates[x];
                              print(x);
                              if (x.startsWith(globals.toCurrency!)) {
                                globals.result = globals.fromCurrencyVal / globals.currentCnvRate!;
                                toController.text = '${globals.result!.toStringAsFixed(2)} ${globals.toCurrency}';
                                success = true;
                              }
                              else if(x.startsWith(globals.fromCurrency!)){
                                globals.result = globals.fromCurrencyVal * globals.currentCnvRate!;
                                toController.text = '${globals.result!.toStringAsFixed(2)} ${globals.toCurrency}';
                                success = true;
                              }
                            }
                          }
                          //ONLINE MODE
                          //TODO: CREATE A FUNCTION TO AVOID CODE REPETITION
                          else{
                            print('Calculated using online mode');                       
                            if(x.contains(globals.fromCurrency!)&&x.contains(globals.toCurrency!)){
                              globals.currentCnvRate = globals.liveRates[x];
                              print(x);
                              if (x.startsWith(globals.toCurrency!)) {
                                globals.result = globals.fromCurrencyVal / globals.currentCnvRate!;
                                toController.text = '${globals.result!.toStringAsFixed(2)} ${globals.toCurrency}';
                                success = true;
                              }
                              else if(x.startsWith(globals.fromCurrency!)){
                                globals.result = globals.fromCurrencyVal * globals.currentCnvRate!;
                                toController.text = '${globals.result!.toStringAsFixed(2)} ${globals.toCurrency}';
                                success = true;
                              }
                            }
                          }
                          }
                          print(success.toString());
                          if (success == false) {
                            toController.text = 'Invalid Number';
                          }
                        });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  SnackBar buildSimpleSnackBar(Color bckgroundColor,Text title){
    return SnackBar(
      content: title,
      backgroundColor: bckgroundColor,
      duration: Duration(seconds: 8),
    );
  }

  Widget buildTextField(Icon icn, String hintTxt,[bool readOnly=false,TextEditingController? controller_ = null]) {
  return TextField(
    onSubmitted: (value){
      try{
      globals.fromCurrencyVal = double.parse(value);
      print('Submitted');
      }
      on FormatException{
        print('invalid number');
        ScaffoldMessenger.of(context).showSnackBar(buildSimpleSnackBar(
          Colors.red.shade600,
          Text('Invalid Number',style: TextStyle(fontSize: 18,color: Colors.white),)
        ));
      }
    },
    controller: controller_,
    readOnly: readOnly,
    keyboardType: TextInputType.number,
    textInputAction: TextInputAction.done,
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      labelText: hintTxt,
      icon: icn,
    ),
  );
}
}
