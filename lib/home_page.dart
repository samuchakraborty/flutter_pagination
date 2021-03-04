import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_listview_infinite_scrolling/provider/data_provider.dart';
import 'package:provider/provider.dart';

import 'models/data_model.dart' as Product;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollController = new ScrollController();
  int _page = 1;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    var videosBloc = Provider.of<DataProvider>(context, listen: false);
    videosBloc.resetStreams();
    videosBloc.fetchAllUsers(_page);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        videosBloc.setLoadingState(LoadMoreStatus.LOADING);
        videosBloc.fetchAllUsers(++_page);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //  var videosBloc = Provider.of<DataProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Infinite Scrolling"),
      ),
      body: Consumer<DataProvider>(
        builder: (context, usersModel, child) {
          // if (usersModel.allUsers != null && usersModel.allUsers.length > 0) {
          //   return Center(child: CircularProgressIndicator());
          // }
          // return _listView(usersModel);
          if (usersModel.allUsers != null) {
            if (usersModel.allUsers.length > 0) {
              return _listView(usersModel);
            }
          }

            return Center(child: CircularProgressIndicator());

        }
      ),
    );
  }

  Widget _listView(DataProvider dataProvider) {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: dataProvider.allUsers.length,
      controller: _scrollController,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        if ((index == dataProvider.allUsers.length - 1) &&
            dataProvider.allUsers.length < dataProvider.totalRecords) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        }

        return Column(
          // spacing: 8, //vertical spacing
          // runSpacing: 8, //horizontal spacing
          // alignment: WrapAlignment.center,
          // crossAxisAlignment: WrapCrossAlignment.center,

          children: [
            Text((index + 1).toString()),
            _buildRow(dataProvider.allUsers[index]),
          ],
        );
      },
      // separatorBuilder: (context, index) {
      //   return Divider();
      // },
    );
  }

  Widget _buildRow(Product.Product radioModel) {
    // return ListTile(title: new Text(radioModel.name));

    return Card(
      elevation: 3,
      semanticContainer: true,
      child: Wrap(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF0b894),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Sale",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    margin: EdgeInsets.only(right: 10),
                    child: IconButton(
                        // padding: const EdgeInsets.all(0),
                        icon: Icon(Icons.account_balance),
                        onPressed: () {}),
                  ),
                ],
              ),

              Container(
                height: 50,
                //  2.5,
                width: MediaQuery.of(context).size.width / 2,
                child: Image.network(
                    "https://anazbd.com/" + radioModel.featureImage),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  radioModel.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "TK: " + (radioModel.originalPrice).toString(),
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        iconSize: 30,
                        icon: Icon(Icons.ac_unit),
                        onPressed: () {}),
                  ),
                ],
              ),
              //  SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
