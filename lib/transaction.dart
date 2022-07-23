// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class MyTransaction extends StatelessWidget {

  
  final String transactionName;
  final String money;
  final String expenseOrIncome;


  MyTransaction({
    required this.transactionName,
    required this.money,
    required this.expenseOrIncome, 
    
  });

  

  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                padding: EdgeInsets.all(15),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.amber),
                          child: Center(
                            child: Icon(
                              Icons.attach_money_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(transactionName,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),  
                     Text(
                          (expenseOrIncome == 'expense' ? '-' : '+') + '\$' + money,
                          
                          style: TextStyle(
                            //fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color:
                                expenseOrIncome == 'expense' ? Colors.red : Colors.green,
                          ),
                        
                        ),
                           
                  ] 
                ),
            ),
          )
  
      
      
    );
  
  }

  }
    
