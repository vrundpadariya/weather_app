import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/api.dart';
import '../../provider/cityList.dart';
import 'Homepage.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

List<String> cityName = [];

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchName = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  List<String>? valuex;

  @override
  Widget build(BuildContext context) {
    // valueFunction();?
    final lanProvider = Provider.of<APICallProvider>(context, listen: true);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Manage Cities",
                style: TextStyle(fontSize: 30),
              ),
              Container(
                  child: Autocomplete(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text == '') {
                    return const Iterable<String>.empty();
                  } else {
                    List<String> matches = <String>[];
                    matches.addAll(cities);

                    matches.retainWhere((s) {
                      return s
                          .toLowerCase()
                          .contains(textEditingValue.text.toLowerCase());
                    });
                    return matches;
                  }
                },
                onSelected: (selection) async {
                  cityName.add(selection);
                  print(cityName.length);

                  await lanProvider.fetchApiData(selection).then((value) {
                    if (value != null) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(
                              cityname: selection,
                            ),
                          ),
                          (route) => false);
                    } else {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text("No City Found "),
                          content: const Text("Try again!!!!"),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                              child: Container(
                                color: Colors.green,
                                padding: const EdgeInsets.all(14),
                                child: const Text("okay"),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  });
                },
              )),
              SizedBox(
                height: 20,
              ),
              valuex?.length != null
                  ? InkWell(
                      child: Container(
                        height: MediaQuery.sizeOf(context).height - 250,
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomePage(
                                          cityname: valuex?[index],
                                        ),
                                      ));
                                },
                                child: Container(
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: ListTile(
                                    leading: Icon(Icons.location_city),
                                    title: Center(
                                        child: Text("${valuex?[index]}")),
                                    trailing: Icon(Icons.delete),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 10,
                              );
                            },
                            itemCount: valuex!.length),
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    ));
  }
}
