import 'package:flutter/material.dart';
import 'API_Services.dart';
import 'room_model.dart';
import 'search.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FetchUser _userList = FetchUser();
  late List<Data> rooms;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('User List'),
          actions: [
            IconButton(
              icon: Icon(Icons.search, color: Colors.blueGrey, size: 40),
              onPressed: () {
                showSearch(context: context, delegate: Search());
              },
            )
          ],
        ),
        body: Container(
          child: FutureBuilder<List<Data>>(
            future: _userList.getUserList(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              rooms = snapshot.data ?? [];

              return ListView.builder(
                itemCount: rooms.length,
                itemBuilder: (context, index) {
                  var room = rooms[index];
                  return Card(
                    child: ListTile(
                      title: Row(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                '${room.id}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${room.name}',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              Text('${room.price}'),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
