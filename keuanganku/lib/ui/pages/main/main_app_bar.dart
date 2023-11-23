import 'package:flutter/material.dart';
import 'package:keuanganku/ui/pages/main/main_list_judul_menu.dart';
import 'package:keuanganku/ui/reusable%20_components/app_bar/app_bar.dart';

class Properties {
  final Color primaryColor = const Color(0xff383651);
}

class ApplicationBar{
  ApplicationBar({required this.scaffoldKey, required this.index});
  final Properties properties = Properties();
  final GlobalKey<ScaffoldState> scaffoldKey;
  final int index;

  dynamic getWidget(BuildContext context) {
    return KAppBar(
      leading: IconButton(
        onPressed: (){
          scaffoldKey.currentState!.openDrawer();
        }, 
        icon: const Icon(Icons.menu), 
        color: properties.primaryColor,
      ),
      title: menuTitle[index],
      centerTitle: true,
      backgroundColor: Colors.white,
      shadowColor: Colors.transparent,
      elevation: 0,
    ).getWidget();
  }
}