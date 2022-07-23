import 'dart:async';
import 'package:expense_tracker/user.dart';
import 'package:flutter/material.dart';
import 'google_sheets_api.dart';
import 'loading_circle.dart';
import 'plus_button.dart';
import 'top_card.dart';
import 'transaction.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(
    
  );
}

class _HomePageState extends State<HomePage> {
  // collect user input
  final  _textcontrollerAMOUNT = TextEditingController();
  final _textcontrollerITEM = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isIncome = false;

  

  // enter the new transaction into the spreadsheet
  void _enterTransaction() {
    GoogleSheetsApi.insert(
      _textcontrollerITEM.text,
      _textcontrollerAMOUNT.text,
      _isIncome,
    );
    setState(() {});
  }

 
  

  
  


  // new transaction
  void _newTransaction() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) {
              return AlertDialog(
                backgroundColor: Colors.grey[200],
                title: Text('N E W  T R A N S A C T I O N', 
                style: TextStyle(color: Colors.amber,)),
                
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Expense',
                          style: TextStyle(color: Colors.blueGrey[600],
                          fontWeight: FontWeight.bold
                          )),
                          Switch(
                            activeColor: Colors.amber,
                            value: _isIncome,
                            onChanged: (newValue) {
                              setState(() {
                                _isIncome = newValue;
                              });
                            },
                          ),
                          Text('Income',
                          style: TextStyle(color: Colors.blueGrey[600],
                          fontWeight: FontWeight.bold
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Form(
                              key: _formKey,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Amount of transaction',
                                ),
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Enter an amount';
                                  }
                                  return null;
                                },
                                controller: _textcontrollerAMOUNT,
                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Name of transaction',
                              ),
                              controller: _textcontrollerITEM,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  MaterialButton(
                    color: Colors.amber,
                    child:
                        Text('Cancel', style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.bold)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  MaterialButton(
                    color: Colors.amber,
                    child: Text('Enter', style: TextStyle(color: Colors.white,
                    fontWeight: FontWeight.bold)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _enterTransaction();
                        Navigator.of(context).pop();
                      }
                    },
                  )
                ],
              );
            },
          );
        });
  }


  void _modifytransactions(UserFields) {
    showDialog( barrierDismissible: false,
        context: context,
         builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) {
            return AlertDialog(
               backgroundColor: Colors.grey[200],
               
                title: Text('E D I T  T R A N S A C T I O N', 
                style: TextStyle(color: Colors.amber, fontSize: 18)),

                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Expense',
                          style: TextStyle(color: Colors.blueGrey[600],
                          fontWeight: FontWeight.bold
                          )),
                          Switch(
                            activeColor: Colors.amber,
                            value: _isIncome,
                            onChanged: (newValue) {
                              setState(() {
                                _isIncome = newValue;
                              });
                            },
                          ),
                          Text('Income',
                          style: TextStyle(color: Colors.blueGrey[600],
                          fontWeight: FontWeight.bold
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Form(
                              key: _formKey,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Amount of transaction',
                                ),
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Enter an amount';
                                  }
                                  return null;
                                },
                                controller: _textcontrollerAMOUNT,
                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Name of transaction',
                              ),
                              controller: _textcontrollerITEM,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[  
                Padding(padding: 
                EdgeInsets.only(right: 5, left: 5)),    
                  TextButton(
                    child:
                        Text('Delete', style: TextStyle(color: Colors.red,
                        fontWeight: FontWeight.bold)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child:
                        Text('Cancel', style: TextStyle(color: Colors.amber,
                        fontWeight: FontWeight.bold)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text('Continue', style: TextStyle(color: Colors.amber,
                    fontWeight: FontWeight.bold)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _enterTransaction();
                        Navigator.of(context).pop();
                      }
                    },
                  )
                ],

            );
        
            }
      );

  });
  }

  

  // wait for the data to be fetched from google sheets
  bool timerHasStarted = false;
  void startLoading() {
    timerHasStarted = true;
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (GoogleSheetsApi.loading == false) {
        setState(() {});
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // start loading until the data arrives
    if (GoogleSheetsApi.loading == true && timerHasStarted == false) {
      startLoading();
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            TopNeuCard(
              balance: (GoogleSheetsApi.calculateIncome() -
                      GoogleSheetsApi.calculateExpense())
                  .toStringAsFixed(2),
              income: GoogleSheetsApi.calculateIncome().toStringAsFixed(2),
              expense: GoogleSheetsApi.calculateExpense().toStringAsFixed(2),
            ),
            Expanded(
              child: Container(
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: GoogleSheetsApi.loading == true
                            ? LoadingCircle()
                            :  GestureDetector(
                              onTap: (){
                                _modifytransactions(UserFields(
                                
                                ));
                              },
                                    child: ListView.builder(
                                     itemCount:
                                          GoogleSheetsApi.currentTransactions.length,
                                      itemBuilder: (context, index) {
                                        return  MyTransaction(
                                              transactionName: GoogleSheetsApi
                                                  .currentTransactions[index][0],
                                              money: GoogleSheetsApi
                                                  .currentTransactions[index][1],
                                              expenseOrIncome: GoogleSheetsApi
                                               .currentTransactions[index][2], 
                                                  );
                                            
                                           }
                                          ),
                            ),
                            ),
                    
                  
                    ],
                  ),
                ),
              ),
            ),
            PlusButton(
              function: _newTransaction,
            ),
          ],
        ),
      ),
    );
  }
}
