String? toCurrency ='';
String? fromCurrency;

bool online = false;
bool ratesFetchedSuccesfully = false;
Map<String, double> cnvRates = {
  'USDtoEGP': 15.51,
  'USDtoEUR': 0.85,
  'USDtoKD': 0.30,
  'USDtoCHF': 0.92,
  'USDtoQ': 3.64,
  'USDtoTURK': 8.32,
  'EGPtoEUR': 0.054,
  'EGPtoKD': 0.019,
  'EGPtoCHF': 0.058,
  'EGPtoQ': 0.23,
  'EGPtoTURK': 0.53,
  'EURtoKD': 0.35,
  'EURtoCHF': 1.08,
  'EURtoQ': 4.30,
  'EURtoTURK': 9.81,
  'KDtoCHF': 3.05,
  'KDtoQ': 12,
  'KDtoTURK': 27,
  'CHFtoQ': 3.98,
  'CHFtoTURK': 9.08,
  'QtoTURK': 2.28
};

Map<String,dynamic> liveRates = {};


double? result;
double fromCurrencyVal = 0;
double? currentCnvRate;