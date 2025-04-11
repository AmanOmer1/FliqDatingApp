import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:japx/japx.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Chatscreeen extends StatefulWidget {
  const Chatscreeen({super.key});

  @override
  State<Chatscreeen> createState() => _ChatscreeenState();
}

class _ChatscreeenState extends State<Chatscreeen> {
  List contactUser = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chatScreenUsersFetching();
  }

  Future<void> chatScreenUsersFetching() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token') ?? '';
    final fetchedResponse = await http.get(
      Uri.parse(
        'https://test.myfliqapp.com/api/v1/chat/chat-messages/queries/contact-users',
      ),
      headers: {
        'Accept': 'application/vnd.api+json',
        'Authorization': 'Bearer $token',
      },
    );
    print('test=================0');
    print(fetchedResponse);
    if (fetchedResponse.statusCode == 200 ||
        fetchedResponse.statusCode == 201) {
      print('test====1');
      final jsonDecoded = Japx.decode(json.decode(fetchedResponse.body));
      print('test============2');
      print(jsonDecoded);
      print('test=====================3');
      setState(() {
        contactUser = jsonDecoded['data'];
      });
    } else {
      print("Failed , Error=========, Api");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () => Navigator.pop(context),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Messages',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextField(
                style: TextStyle(color: Colors.black),
                cursorColor: Colors.black54,
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Chat',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: contactUser.length,
                  itemBuilder: (context, index) {
                    final data = contactUser[index];
                    final user = data?['attributes'];

                    final imageURL =
                        user != null ? user['profile_photo_url'] ?? '' : '';
                    final name =
                        user != null ? user['name'] ?? 'NoName' : 'Unknown';

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            imageURL.isNotEmpty
                                ? NetworkImage(imageURL)
                                : AssetImage(
                                      'lib/assets/images/assetsplash.jpg',
                                    )
                                    as ImageProvider,
                      ),
                      title: Text(
                        name,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      onTap: () {},
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
