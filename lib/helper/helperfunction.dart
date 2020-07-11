import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions{
  static String sharedprefuserloginkey="ISLOGGEDIN";
  static String sharedperfusernamekey="USERNAMEKEY";
  static String sharedprefuseremailkey="USEREMAILKEY";

  //save data

  static Future<bool> saveuserLoggedinSharedPreference(bool isUserloggedIn) async{
    if(isUserloggedIn==null)
      isUserloggedIn=false;
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return await prefs.setBool(sharedprefuserloginkey, isUserloggedIn);
  }

  static Future<bool> saveuserNameSharedPreference(String Username) async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return await prefs.setString(sharedperfusernamekey, Username);
  }

  static Future<bool> saveuserEmailSharedPreference(String Useremail) async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return await prefs.setString(sharedprefuseremailkey, Useremail);
  }

  //get data

  static Future<bool> getuserLoggedinSharedPreference() async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return await prefs.getBool(sharedprefuserloginkey);
  }

  static Future<String> getuserNameSharedPreference() async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return await prefs.getString(sharedperfusernamekey);
  }

  static Future<String> getuserEmailSharedPreference() async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return await prefs.getString(sharedprefuseremailkey);
  }
}