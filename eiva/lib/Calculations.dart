import 'package:shared_preferences/shared_preferences.dart';

Future<String> getPreferenceValue(String key) async {
  final prefs = await SharedPreferences.getInstance();
  int? value = prefs.getInt(key);
  return value != null ? value.toString() : 'Nop';
}

Future<double> getTypePrice(Map type, double size, bool typeVammeno) async {
  double finalTypePrice = 0;

  // Check if type hasn't been selected
  if (type.isNotEmpty) {
    // Get type price per square meter
    var typePrice = double.parse(await getPreferenceValue(type['name']));

    if (typeVammeno) {
      var vafhPrice = double.parse(await getPreferenceValue('type_vammeno'));
      finalTypePrice = (typePrice + vafhPrice) * size;
    } else {
      finalTypePrice = typePrice * size;
    }
  }

  return finalTypePrice;
}

Future<double> getChannelPrice(
    Map channel, double height, bool channelVammeno) async {
  double finalChannelPrice = 0;

  // Check if channel hasn't been selected
  if (channel.isNotEmpty) {
    // Get channel price per square meter
    var channelPrice = double.parse(await getPreferenceValue(channel['name']));

    if (channelVammeno) {
      var vafhPrice = double.parse(await getPreferenceValue('channel_vammeno'));
      finalChannelPrice = (channelPrice + vafhPrice) * height;
    } else {
      finalChannelPrice = channelPrice * height;
    }
  }

  return finalChannelPrice;
}

Future<double> getBoxPrice(Map box, double width, bool boxVammeno) async {
  double finalBoxPrice = 0;

  // Check if box hasn't been selected
  if (box.isNotEmpty) {
    // Get box price per square meter
    var boxPrice = double.parse(await getPreferenceValue(box['name']));

    if (boxVammeno) {
      var vafhPrice = double.parse(await getPreferenceValue('box_vammeno'));
      finalBoxPrice = (boxPrice + vafhPrice) * width;
    } else {
      finalBoxPrice = boxPrice * width;
    }
  }

  return finalBoxPrice;
}

Future<double> getMetopiPrice(
    Map metopi, double width, bool metopiVammeno) async {
  double finalMetopiPrice = 0;

  // Check if metopi hasn't been selected
  if (metopi.isNotEmpty) {
    // Get metopi price per square meter
    var metopiPrice = double.parse(await getPreferenceValue(metopi['name']));

    if (metopiVammeno) {
      var vafhPrice = double.parse(await getPreferenceValue('metopi_vammeno'));
      finalMetopiPrice = (metopiPrice + vafhPrice) * width;
    } else {
      finalMetopiPrice = metopiPrice * width;
    }
  }
  return finalMetopiPrice;
}

Future<double> getMotorPrice(Map motor) async {
  double finalMotorPrice = 0;

  // Check if motor hasn't been selected
  if (motor.isNotEmpty) {
    // Get motor price
    var motorPrice = double.parse(await getPreferenceValue(motor['name']));

    finalMotorPrice = motorPrice;
  }
  return finalMotorPrice;
}

Future<double> getElectronicsPrice(Map electronics) async {
  double finalElectronicsPrice = 0;

  // Check if electronics hasn't been selected
  if (electronics.isNotEmpty) {
    // Get electronics price
    var electronicsPrice =
        double.parse(await getPreferenceValue(electronics['name']));

    finalElectronicsPrice = electronicsPrice;
  }
  return finalElectronicsPrice;
}

Future<double> getApasfalishPrice(bool apasfalish) async {
  double finalApasfalishPrice = 0;

  if (apasfalish) {
    finalApasfalishPrice = double.parse(await getPreferenceValue('apasfalish'));
  }

  return finalApasfalishPrice;
}

Future<double> getFouskaPrice(bool fouska, double width) async {
  double finalFouskaPrice = 0;

  if (fouska) {
    finalFouskaPrice =
        double.parse(await getPreferenceValue('lastixo_fouska')) * width;
  }

  return finalFouskaPrice;
}

Future<List> calculatePrice(
  double height,
  double width,
  Map type,
  bool typeVammeno,
  Map channel,
  bool channelVammeno,
  Map box,
  bool boxVammeno,
  Map metopi,
  bool metopiVammeno,
  Map motor,
  Map electronics,
  bool apasfalish,
  bool fouska,
  double discount,
  // String discount
) async {
  List resultList = [];
  height = height / 100;
  width = width / 100;
  resultList.add({'greek': 'Εμβαδόν', 'value': height * width});

  var finalTypePrice = await getTypePrice(type, height * width, typeVammeno);

  var finalChannelPrice =
      await getChannelPrice(channel, height, channelVammeno);

  var finalBoxPrice = await getBoxPrice(box, width, boxVammeno);

  var finalMetopiPrice = await getMetopiPrice(metopi, width, metopiVammeno);

  var finalMotorPrice = await getMotorPrice(motor);

  var finalElectronicsPrice = await getElectronicsPrice(electronics);

  var finalApasfalishPrice = await getApasfalishPrice(apasfalish);

  var finalFouskaPrice = await getFouskaPrice(fouska, width);

  // Add components to result list
  resultList.add({'greek': 'Τύπος', 'value': finalTypePrice.toInt()});
  resultList.add({'greek': 'Κανάλι', 'value': finalChannelPrice.toInt()});
  resultList.add({'greek': 'Μοτέρ', 'value': finalMotorPrice.toInt()});
  resultList.add({'greek': 'Κουτί', 'value': finalBoxPrice.toInt()});
  resultList.add({'greek': 'Μετώπη', 'value': finalMetopiPrice.toInt()});
  resultList
      .add({'greek': 'Ηλεκτρονικά', 'value': finalElectronicsPrice.toInt()});
  resultList
      .add({'greek': 'Απασφάλιση', 'value': finalApasfalishPrice.toInt()});
  resultList.add({'greek': 'Φούσκα', 'value': finalFouskaPrice.toInt()});

  // Calculate total price
  double totalPrice = 0;
  totalPrice = finalTypePrice +
      finalChannelPrice +
      finalMotorPrice +
      finalBoxPrice +
      finalMetopiPrice +
      finalElectronicsPrice +
      finalApasfalishPrice +
      finalFouskaPrice;

  int totalPriceWithDiscount =
      (totalPrice - (totalPrice * (discount / 100))).toInt();

  // Add total price to result list
  resultList.add({'greek': 'Σύνολο', 'value': totalPrice.toInt()});
  resultList
      .add({'greek': 'Σύνολο με έκπτωση', 'value': totalPriceWithDiscount});

  int totalPriceWithDiscountForty =
      (totalPrice - (totalPrice * (40 / 100))).toInt();
  int totalPriceWithDiscountSixty =
      (totalPrice - (totalPrice * (37.5 / 100))).toInt();
  int totalPriceWithDiscountFifty =
      (totalPrice - (totalPrice * (35 / 100))).toInt();

  resultList.add(
      {'greek': 'Σύνολο με έκπτωση 40%', 'value': totalPriceWithDiscountForty});
  resultList.add({
    'greek': 'Σύνολο με έκπτωση 37.5%',
    'value': totalPriceWithDiscountSixty
  });
  resultList.add(
      {'greek': 'Σύνολο με έκπτωση 35%', 'value': totalPriceWithDiscountFifty});

  return resultList;
}
