import 'package:shared_preferences/shared_preferences.dart';

Future<String> getPreferenceValue(String key) async {
  final prefs = await SharedPreferences.getInstance();
  int? value = prefs.getInt(key);
  return value != null ? value.toString() : 'Nop';
}

Future<double> getTypePrice(
    double typePrice, double size, bool typeVammeno) async {
  double finalTypePrice = 0;
  if (typeVammeno) {
    var vafhPrice = getPreferenceValue('type_vammeno');
    finalTypePrice = (typePrice + double.parse(await vafhPrice)) * size;
  } else {
    finalTypePrice = typePrice * size;
  }

  return finalTypePrice;
}

Future<double> getChannelPrice(
    double channelPrice, bool channelVammeno, double height) async {
  double finalChannelPrice = 0;

  if (channelVammeno) {
    var vafhPrice = getPreferenceValue('channel_vammeno');
    finalChannelPrice = (double.parse(await vafhPrice) + channelPrice) * height;
  } else {
    finalChannelPrice = channelPrice * height;
  }
  return finalChannelPrice;
}

Future<double> getBoxPrice(
    double boxPrice, bool boxVammeno, double width) async {
  double finalBoxPrice = 0;

  if (boxVammeno) {
    var vafhPrice = getPreferenceValue('box_vammeno');
    finalBoxPrice = (double.parse(await vafhPrice) + boxPrice) * width;
  } else {
    finalBoxPrice = boxPrice * width;
  }
  return finalBoxPrice;
}

Future<double> getMetopiPrice(
    double metopiPrice, bool metopiVammeno, double width) async {
  double finalMetopiPrice = 0;

  if (metopiVammeno) {
    var vafhPrice = getPreferenceValue('metopi_vammeno');
    finalMetopiPrice = (double.parse(await vafhPrice) + metopiPrice) * width;
  } else {
    finalMetopiPrice = metopiPrice * width;
  }
  return finalMetopiPrice;
}

Future<double> getApasfalishPrice(bool apasfalish) async {
  double finalApasfalishPrice = 0;

  if (apasfalish) {
    var apasfalishPrice = getPreferenceValue('apasfalish');
    finalApasfalishPrice = double.parse(await apasfalishPrice);
  }

  return finalApasfalishPrice;
}

Future<double> getFouskaPrice(bool fouska, double width) async {
  double finalFouskaPrice = 0;

  if (fouska) {
    var fouskaPrice = getPreferenceValue('lastixo_fouska');
    finalFouskaPrice = double.parse(await fouskaPrice) * width;
  }

  return finalFouskaPrice;
}

Future<List> calculatePrice(
    double height,
    double width,
    Map type,
    Map channel,
    Map motor,
    Map electronics,
    Map box,
    Map metopi,
    bool typeVammeno,
    bool channelVammeno,
    bool boxVammeno,
    bool metopiVammeno,
    bool apasfalish,
    bool fouska,
    int discount) async {
  List resultList = [];
  height = height / 100;
  width = width / 100;
  resultList.add({'greek': 'Εμβαδόν', 'value': height * width});

  // Get the prices of the selected components
  var type_price = getPreferenceValue(type['name']);
  var channel_price = getPreferenceValue(channel['name']);
  var motor_price = getPreferenceValue(motor['name']);
  var electronics_price = getPreferenceValue(electronics['name']);
  var box_price = getPreferenceValue(box['name']);
  var metopi_price = getPreferenceValue(metopi['name']);

  try {
    var finalTypePrice = getTypePrice(
        double.parse(await type_price), height * width, typeVammeno);

    var finalChannelPrice = getChannelPrice(
        double.parse(await channel_price), channelVammeno, height);

    var finalBoxPrice =
        getBoxPrice(double.parse(await box_price), boxVammeno, width);

    var finalMetopiPrice =
        getMetopiPrice(double.parse(await metopi_price), metopiVammeno, width);

    var finalApasfalishPrice = getApasfalishPrice(apasfalish);

    var finalFouskaPrice = getFouskaPrice(fouska, width);

    // Calculate the final price ---------------------------------------
    // resultMap.add({'greek': 'Te', 'value':await finalTypePrice});
    // resultMap['finalChannelPrice'] = await finalChannelPrice;
    // resultMap['finalMotorPrice'] = double.parse(await motor_price);
    // resultMap['finalElectronicsPrice'] = double.parse(await electronics_price);
    // resultMap['finalBoxPrice'] = await finalBoxPrice;
    // resultMap['finalMetopiPrice'] = await finalMetopiPrice;
    // resultMap['finalApasfalishPrice'] = await finalApasfalishPrice;
    // resultMap['finalFouskaPrice'] = await finalFouskaPrice;
    print(await finalTypePrice);
    print(await finalChannelPrice);
    print(await motor_price);
    print(await electronics_price);
    print(await finalBoxPrice);
    print(await finalMetopiPrice);
    print(await finalApasfalishPrice);
    print(await finalFouskaPrice);

    double finalPrice = await finalTypePrice +
        await finalChannelPrice +
        double.parse(await motor_price) +
        double.parse(await electronics_price) +
        await finalBoxPrice +
        await finalMetopiPrice +
        await finalApasfalishPrice +
        await finalFouskaPrice;

    String finalPriceString = finalPrice.toStringAsFixed(2);
    double discountedPrice = finalPrice - (finalPrice * (discount / 100));
    discountedPrice = double.parse(discountedPrice.toStringAsFixed(2));
    resultList.add({'greek': 'Τελική Τιμή', 'value': finalPrice});
    resultList.add({
      'greek': 'Τελική Τιμή με Έκπτωση $discount%',
      'value': discountedPrice
    });
  } catch (e) {
    print(e);
  }

  return resultList;
}
