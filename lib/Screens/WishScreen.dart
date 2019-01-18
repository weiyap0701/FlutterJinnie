import 'package:flutter/material.dart';

//non-library
import 'package:jinnie/Model/WishModel.dart';
import 'package:jinnie/Views/PostCell.dart';
import 'package:jinnie/Utils/Helper.dart';
import 'package:jinnie/API/ApiHandler.dart';

class WishScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WishScreenState();
  }
}

class _WishScreenState extends State<WishScreen> {

  bool _isLoading = true;
  List<WishModel> wishArray;
  var skip = 0;
  var lastIndex = 0;

  @override
  void initState() {
    super.initState();
    _performGetWishList();
  }

  _performGetWishList() {
    WishApiHandler.getWishList(skip).then((tempWishArray){
      if (tempWishArray != null) {
        if (this.wishArray != null) {
          final wishes = this.wishArray;
          this.wishArray = null;
          this.wishArray = wishes + tempWishArray;
        }
        else {
          this.wishArray = tempWishArray;
        }

        setState(() {
          _isLoading = false;       
        });
      }
      else {
        Helper.showErrorDialog(context);
      }
    });
  }

  Widget _loadingIndicator() {
    return new Center(
      child: new CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _isLoading
      ? _loadingIndicator() 
      : new ListView.builder(
          itemCount: this.wishArray != null ? this.wishArray.length : 0,
          itemBuilder: (context, i) {
            if (i == this.wishArray.length - 1) {
              if (lastIndex != i) {
                skip = skip + 5;
                _performGetWishList();
                print("Skip: " + skip.toString() + " Last index: " + i.toString() + "Length: " + this.wishArray.length.toString());
                lastIndex = i;
              }
            }
            final wishModel = this.wishArray[i];
            return PostCell(wishModel: wishModel);
        },
    ));
  }
}
