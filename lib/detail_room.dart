import 'package:flutter/material.dart';

class DetailRoom extends StatefulWidget {
  final roomList room_list;
  const DetailRoom({super.key});

  @override
  _DetailRoomState createState() => _DetailRoomState();
}

class _DetailRoomState extends State<DetailRoom> {
  double exchangeRate=1;
  late Currency currency;

  @override
  void initState() {
    loadExchange();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Detail Room'),
        ),
      body _buildRoomBody();
    );
  }

  Widget _buildRoomBody(){
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.network('${room.imageUrl}'),
            Text('${room.name}'),
            Text('${room.price}'),
            Text((widget.product.retailPrice!.toDouble()*exchangeRate).toString()),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  exchangeRate = currency.conversionRates!.iDR!;
                });
              },
              child: Text("IDR"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  exchangeRate = currency.conversionRates!.uSD! as double;
                });
              },
              child: Text("USD"),
            )
          ]
        )
      )
    )
  }

  void loadExchange(){
    ApiDataSource.instance.getCurrency().then((data){
      setState(() {
        currency = Currency.fromJson(data);
      });
    }).catchError((error){
      print('error');
    });
  }
}

