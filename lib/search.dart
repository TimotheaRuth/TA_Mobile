import 'package:flutter/material.dart';
import 'API_Services.dart';
import 'room_model.dart';

class Search extends SearchDelegate {
  FetchUser _userList = FetchUser();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            query = "";
            showSuggestions(context);
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<Data>>(
        future: _userList.getUserList(query: query),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          var data = snapshot.data!;
          if (data.isEmpty) {
            return Center(child: Text("No results found"));
          }
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              var room = data[index];
              return Card(
                child: ListTile(
                  title: Row(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: Text('${room.id}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${room.name}',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text('${room.price}')
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<Data>>(
      future: _userList.getUserList(query: query),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        var data = snapshot.data!;
        if (data.isEmpty) {
          return Center(child: Text("No suggestions found"));
        }
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            var room = data[index];
            return ListTile(
              title: Text('${room.name}'),
              onTap: () {
                query = room.name!;
                showResults(context);
              },
            );
          },
        );
      },
    );
  }
}
