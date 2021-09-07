import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'main.dart';
//import 'globals.dart' as globals;

class MainDrawer extends StatelessWidget {
  final ValueChanged<String>? toCurrencyChanged;
  final ValueChanged<String>? fromCurrencyChanged;
  const MainDrawer({ Key? key ,this.toCurrencyChanged,this.fromCurrencyChanged}) : super(key: key);
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
                  fromCurrencyChanged!('EGP');
                },
              ),
              ListTile(
                title: Text('USD'),
                subtitle: Text('American Dollar'),
                onTap: (){
                  fromCurrencyChanged!('USD');
                },
              ),
              ListTile(
                title: Text('EUR'),
                subtitle: Text('European Dollar'),
                onTap: (){
                  fromCurrencyChanged!('EUR');
                },
              ),
              ListTile(
                title: Text('KD'),
                subtitle: Text('Kuwati Dinar'),
                onTap: (){
                  fromCurrencyChanged!('KD');
                },
              ),
              ListTile(
                title: Text('CHF'),
                subtitle: Text('Swiss Franc'),
                onTap: (){
                  fromCurrencyChanged!('CHF');
                },
              ),
              ListTile(
                title: Text('Q'),
                subtitle: Text('Qatari Riyal'),
                onTap: (){
                  fromCurrencyChanged!('Q');
                },
              ),
              ListTile(
                title: Text('TURK'),
                subtitle: Text('Turkish Lira'),
                onTap: (){
                  fromCurrencyChanged!('TURK');
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
                  toCurrencyChanged!('EGP');
                },
              ),
              ListTile(
                title: Text('USD'),
                subtitle: Text('American Dollar'),
                onTap: (){
                  toCurrencyChanged!('USD');
                },
              ),
              ListTile(
                title: Text('EUR'),
                subtitle: Text('European Dollar'),
                onTap: (){
                  toCurrencyChanged!('EUR');
                },                
              ),
              ListTile(
                title: Text('KD'),
                subtitle: Text('Kuwati Dinar'),
                onTap: (){
                  toCurrencyChanged!('KD');
                },                
              ),
              ListTile(
                title: Text('CHF'),
                subtitle: Text('Swiss Franc'),
                onTap: (){
                  toCurrencyChanged!('CHF');
                },                
              ),
              ListTile(
                title: Text('Q'),
                subtitle: Text('Qatari Riyal'),
                onTap: (){
                  toCurrencyChanged!('Q');
                },                
              ),
              ListTile(
                title: Text('TURK'),
                subtitle: Text('Turkish Lira'),
                onTap: (){
                  toCurrencyChanged!('TURK');
                },                
              ),                                                             
            ],
          ),
        ],
      ),
    );
  }
}
