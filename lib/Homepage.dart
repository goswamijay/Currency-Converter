import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/Widgets/drop_down.dart';
import 'Services/api_client.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiClient client = ApiClient();
  Color maincolor = Color(0xFF212936);
  Color secondcolor = Color(0xFF2849E5);

  late List<String> currencies;
  String from = "INR";
  String to = "USD";

  late double rate;
  String result = "";


  @override
  void initState() {
    (() async {
      List<String> list = await client.getCurrencies();
      setState(() {
        currencies = list;
      });
    })();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: maincolor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Container(
                width: double.infinity,
                child: Text("Currency Converter", style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold
                ),),
              ),
              Expanded(child: Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [

                  TextField(
                    onSubmitted: (value) async{
          rate = await client.getRate(from, to);
          setState(() {
            result = (rate * double.parse(value)).toStringAsFixed(3);
          });
                    },
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: "Input value to convert",
                        labelStyle: TextStyle(fontWeight: FontWeight.normal,
                            fontSize: 18.0,
                            color: secondcolor)
                    ),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customDropDown(currencies,from, (val) {
                        setState(() {
                          from = val;
                        });
                      }),
                  FloatingActionButton(onPressed: (){
                   String temp = from;
                    setState(() {
                      from = to;
                      to = temp;
                    });
                  },child: Icon(Icons.swap_horiz),backgroundColor: secondcolor,),
                  customDropDown(currencies,to, (val) {
                    setState(() {
                      to = val;
                    });
                  })
                    ],
                  ),
                  SizedBox(height: 50.0,),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Column(
                      children: [
                        Text("Result",style: TextStyle(
                          color: Colors.black,
                          fontSize:24.0,
                          fontWeight: FontWeight.bold,
                        ),),
                        Text(result,style: TextStyle(
                          color: secondcolor,
                          fontSize: 36.0,
                          fontWeight: FontWeight.bold,
                        ),),
                      ],
                    ),
                  )
                ],),))
            ],
          ),
        ),
      ),
    );
  }
}

