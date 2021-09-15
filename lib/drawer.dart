import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'API.dart' as API;
import 'dart:convert';
import 'globals.dart' as globals;

class MainDrawer extends StatefulWidget {
  final ValueChanged<String>? toCurrencyChanged;
  final ValueChanged<String>? fromCurrencyChanged;
  const MainDrawer({ Key? key ,this.toCurrencyChanged,this.fromCurrencyChanged}) : super(key: key);

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  final fetchedSuccesfullySnackBar = SnackBar(
      content: Text('Rates Fetched Succesfully',style: TextStyle(fontSize: 15),),
      backgroundColor: Colors.green,
      padding: EdgeInsets.symmetric(vertical: 12),
      duration: Duration(seconds: 8),
    );
  final offlineModeSnackBar = SnackBar(
      content: Text('Offline mode enabled',style: TextStyle(fontSize: 15),),
      backgroundColor: Colors.red,
      padding: EdgeInsets.symmetric(vertical: 12),
      duration: Duration(seconds: 8),
    );    
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.green.shade300,Colors.green.shade400])),
            child: Center(
              child: Text(
                'Currency Converter',
                style: TextStyle(                 
                  fontSize: 27,
                  color: Colors.white,
                  fontWeight: FontWeight.w500
                ),
                ),
            ),
          ),
          //CONVERT FROM
          ExpansionTile(
            title: Text('Convert From'),
            subtitle: Text('Select the currency to convert from',style: TextStyle(color: Colors.grey.shade600),),
            children: [
              ListTile(
                title: Text('EGP'),
                subtitle: Text('Egyptian Pound'),
                onTap: (){
                  widget.fromCurrencyChanged!('EGP');
                },
              ),
              ListTile(
                title: Text('USD'),
                subtitle: Text('American Dollar'),
                onTap: (){
                  widget.fromCurrencyChanged!('USD');
                },
              ),
              ListTile(
                title: Text('EUR'),
                subtitle: Text('European Dollar'),
                onTap: (){
                  widget.fromCurrencyChanged!('EUR');
                },
              ),
              ListTile(
                title: Text('KD'),
                subtitle: Text('Kuwati Dinar'),
                onTap: (){
                  widget.fromCurrencyChanged!('KD');
                },
              ),
              ListTile(
                title: Text('CHF'),
                subtitle: Text('Swiss Franc'),
                onTap: (){
                  widget.fromCurrencyChanged!('CHF');
                },
              ),
              ListTile(
                title: Text('Q'),
                subtitle: Text('Qatari Riyal'),
                onTap: (){
                  widget.fromCurrencyChanged!('Q');
                },
              ),
              ListTile(
                title: Text('TURK'),
                subtitle: Text('Turkish Lira'),
                onTap: (){
                  widget.fromCurrencyChanged!('TURK');
                },
              ),                                                                    
            ],
          ),
          //CONVERT TO
          ExpansionTile(
            title: Text('Convert To'),
            subtitle: Text('Select the currency to convert To',style: TextStyle(color: Colors.grey.shade600),),
            children: [
              ListTile(
                title: Text('EGP'),
                subtitle: Text('Egyptian Pound'),
                onTap: (){
                  widget.toCurrencyChanged!('EGP');
                },
              ),
              ListTile(
                title: Text('USD'),
                subtitle: Text('American Dollar'),
                onTap: (){
                  widget.toCurrencyChanged!('USD');
                },
              ),
              ListTile(
                title: Text('EUR'),
                subtitle: Text('European Dollar'),
                onTap: (){
                  widget.toCurrencyChanged!('EUR');
                },                
              ),
              ListTile(
                title: Text('KD'),
                subtitle: Text('Kuwati Dinar'),
                onTap: (){
                  widget.toCurrencyChanged!('KD');
                },                
              ),
              ListTile(
                title: Text('CHF'),
                subtitle: Text('Swiss Franc'),
                onTap: (){
                  widget.toCurrencyChanged!('CHF');
                },                
              ),
              ListTile(
                title: Text('Q'),
                subtitle: Text('Qatari Riyal'),
                onTap: (){
                  widget.toCurrencyChanged!('Q');
                },                
              ),
              ListTile(
                title: Text('TURK'),
                subtitle: Text('Turkish Lira'),
                onTap: (){
                  widget.toCurrencyChanged!('TURK');
                },                
              ),                                                             
            ],
          ),
          SwitchListTile(
            value: globals.online,
            onChanged: (value) async{
              setState(() {
                globals.online = value;
              });
                if(globals.online==true){
                try{
                Fluttertoast.showToast(
                  msg: 'Fetching Rates...',
                  toastLength: Toast.LENGTH_LONG,
                  fontSize: 14,
                  backgroundColor: Colors.green,
                );
                var data = await API.getRates();
                print('finished running script');
                Map<String,dynamic> decodedData = jsonDecode(data);
                globals.liveRates = decodedData;
                globals.ratesFetchedSuccesfully = true;
                print(globals.liveRates);
                Fluttertoast.showToast(
                  msg: 'Rates Fetched Succesfully',
                  toastLength: Toast.LENGTH_LONG,
                  fontSize: 14,
                  backgroundColor: Colors.green,
                );                
                }on Exception{
                  globals.online = false;
                }
                }
                else{
                  globals.ratesFetchedSuccesfully = false;
                  globals.liveRates.clear();
                Fluttertoast.showToast(
                  msg: 'Offline Mode Enabled',
                  toastLength: Toast.LENGTH_SHORT,
                  fontSize: 14,
                  backgroundColor: Colors.red,
                );
                }
            },
            title: Text('Live Rates'),
            subtitle: Text('Gets Real-Time conversion rates'),
            activeColor: Colors.green,
            inactiveThumbColor: Colors.red.shade400,
            inactiveTrackColor: Colors.red.shade200,
          ),
        ],
      ),
    );
  }

}
