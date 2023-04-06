import "package:flutter/material.dart";
import 'package:flutter_contacts/contact.dart';

class SearchContact extends StatefulWidget {
  final contactLst;
  final Function func;
  const SearchContact({required this.contactLst, required this.func});

  @override
  State<SearchContact> createState() => _SearchContactState();
}

class _SearchContactState extends State<SearchContact> {
  TextEditingController editingController = TextEditingController();

  //final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
  var items = [];
  Function? selectContact;

  @override
  void initState() {
    selectContact = widget.func;
    items.addAll(widget.contactLst);
    super.initState();
  }

  void filterSearchResults(String query) {
    List<Contact> dummySearchList = [];
    dummySearchList.addAll(widget.contactLst);
    if (query.isNotEmpty) {
      List<Contact> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.displayName.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(widget.contactLst);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //return Container();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: const Text('Select contact'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: editingController,
                decoration: InputDecoration(
                  iconColor: Colors.deepOrangeAccent,
                  labelText: "Search",
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final contact = items[index];
                    return InkWell(
                      onTap: () => selectContact!(contact, context),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: ListTile(
                          title: Text(
                            contact.displayName,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          leading: contact.photo == null
                              ? null
                              : CircleAvatar(
                                  backgroundImage: MemoryImage(contact.photo!),
                                  radius: 30,
                                ),
                          subtitle: SizedBox(
                            height: 1,
                            width: double.infinity,
                            child: Container(
                              color: Colors.deepOrangeAccent,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
