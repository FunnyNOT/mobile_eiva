import 'package:flutter/material.dart';
import 'package:eiva_mobile/MyList.dart';
import 'package:eiva_mobile/Calculations.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Create a global key for the form
  final _formKey = GlobalKey<FormState>();
  var selectedType;
  var selectedChannel;
  var selectedMotor;
  var selectedElectronics;
  var selectedBox;
  var selectedMetopi;
  var selectedHeight;
  var selectedWidth;
  bool selectedTypeVammeno = true;
  bool selectedChannelVammeno = true;
  bool selectedBoxVammeno = true;
  bool selectedMetopiVammeno = true;
  bool selectedApasfalish = false;
  bool selectedFouska = false;
  var selectedDiscount;

  @override
  Widget build(BuildContext context) {
    var allItems = myListHomePage;
    var typeList =
        allItems.where((item) => item['group'] == 'Τύπος Ρολού').toList();
    var channelList =
        allItems.where((item) => item['group'] == 'Κανάλι').toList();
    var motorList = allItems.where((item) => item['group'] == 'Μοτέρ').toList();
    var electronicsList =
        allItems.where((item) => item['group'] == 'Ηλεκτρονικά').toList();
    var boxList = allItems.where((item) => item['group'] == 'Κουτί').toList();
    var metopiList =
        allItems.where((item) => item['group'] == 'Μετώπη').toList();

    var discountList = [0, 35, 37.5, 40, 42.5];

    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //Size
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Card(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Ύψος',
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (newValue) {
                              setState(() {
                                selectedHeight = newValue;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Πλάτος',
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (newValue) {
                              setState(() {
                                selectedWidth = newValue;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //Type
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Card(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: DropdownButton(
                          value: selectedType,
                          items: typeList.map((item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(item['greek']),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              selectedType = newValue;
                            });
                          },
                          hint: const Text('Τύπος Ρολού'),
                        ),
                      ),
                    ),
                  ),
                  Checkbox(
                    value: selectedTypeVammeno,
                    onChanged: (val) {
                      setState(() {
                        selectedTypeVammeno = val ?? false;
                      });
                    },
                    shape: const CircleBorder(),
                  ),
                  const Text('Βαμμένο'),
                ],
              ),
              //Channel
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Card(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: DropdownButton(
                          value: selectedChannel,
                          items: channelList.map((item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(item['greek']),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              selectedChannel = newValue;
                            });
                          },
                          hint: const Text('Κανάλι'),
                        ),
                      ),
                    ),
                  ),
                  Checkbox(
                    value: selectedChannelVammeno == true ? true : false,
                    onChanged: (val) {
                      setState(() {
                        selectedChannelVammeno = val ?? false;
                      });
                    },
                    shape: const CircleBorder(),
                  ),
                  const Text('Βαμμένο'),
                ],
              ),
              //Motor
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Card(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: DropdownButton(
                      value: selectedMotor,
                      items: motorList.map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item['greek']),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedMotor = newValue;
                        });
                      },
                      hint: const Text('Μοτέρ'),
                    ),
                  ),
                ),
              ),
              //Electronics
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Card(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: DropdownButton(
                      value: selectedElectronics,
                      items: electronicsList.map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item['greek']),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedElectronics = newValue;
                        });
                      },
                      hint: const Text('Ηλεκτρονικά'),
                    ),
                  ),
                ),
              ),
              //Box
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Card(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: DropdownButton(
                          value: selectedBox,
                          items: boxList.map((item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(item['greek']),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              selectedBox = newValue;
                            });
                          },
                          hint: const Text('Κουτί'),
                        ),
                      ),
                    ),
                  ),
                  Checkbox(
                    value: selectedBoxVammeno,
                    onChanged: (val) {
                      setState(() {
                        selectedBoxVammeno = val ?? false;
                      });
                    },
                    shape: const CircleBorder(),
                  ),
                  const Text('Βαμμένο'),
                ],
              ),
              //Metopi
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Card(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: DropdownButton(
                          value: selectedMetopi,
                          items: metopiList.map((item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(item['greek']),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              selectedMetopi = newValue;
                            });
                          },
                          hint: const Text('Μετώπη'),
                        ),
                      ),
                    ),
                  ),
                  Checkbox(
                    value: selectedMetopiVammeno == true ? true : false,
                    onChanged: (val) {
                      setState(() {
                        selectedMetopiVammeno = val ?? false;
                      });
                    },
                    shape: const CircleBorder(),
                  ),
                  const Text('Βαμμένο'),
                ],
              ),
              //Extra
              Row(children: <Widget>[
                Checkbox(
                  value: selectedApasfalish,
                  onChanged: (val) {
                    setState(() {
                      selectedApasfalish = val ?? false;
                    });
                  },
                  shape: const CircleBorder(),
                ),
                const Text('Απασφάλιση'),
                Checkbox(
                  value: selectedFouska,
                  onChanged: (val) {
                    setState(() {
                      selectedFouska = val ?? false;
                    });
                  },
                  shape: const CircleBorder(),
                ),
                const Text('Φούσκα'),
              ]),
              //Discount
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Card(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: DropdownButton(
                      value: selectedDiscount,
                      items: discountList.map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item.toString()),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedDiscount = newValue;
                        });
                      },
                      hint: const Text('Έκπτωση'),
                    ),
                  ),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    // Run calculations
                    List resultList = await calculatePrice(
                      double.parse(selectedHeight),
                      double.parse(selectedWidth),
                      selectedType,
                      selectedChannel,
                      selectedMotor,
                      selectedElectronics,
                      selectedBox,
                      selectedMetopi,
                      selectedTypeVammeno,
                      selectedChannelVammeno,
                      selectedBoxVammeno,
                      selectedMetopiVammeno,
                      selectedApasfalish,
                      selectedFouska,
                      selectedDiscount,
                    );

                    // show the resultList in a pop up window
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Results'),
                          content: Column(
                            children: resultList.map((result) {
                              return Text(
                                  '${result['greek']}: ${result['value']}');
                            }).toList(),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
