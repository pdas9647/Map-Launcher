import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> openMapInBrowser(double originLat, double originLong,
      String businessLat, String businessLong) async {
    String url =
        'https://www.google.com/maps/dir/?api=1&origin=$originLat,$originLong&destination=${double.parse(businessLat)},${double.parse(businessLong)}&travelmode=driving';
    // Uri.encodeFull('https://www.google.com/maps');
    // Uri.encodeFull('https://www.woolha.com');
    // Uri.encodeFull('https://flutter.dev');
    /*if (Platform.isAndroid) {
      if (await canLaunch(googleUrl)) {
        await launch(googleUrl);
      } else {
        throw 'Could not launch $googleUrl';
      }
    } else if (Platform.isIOS) {
      if (await canLaunch(googleUrl)) {
        await launch(googleUrl);
      } else {
        throw 'Could not launch $googleUrl';
      }
    }*/
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () async {
            final availableMaps = await MapLauncher.installedMaps;
            showMaterialModalBottomSheet(
                context: context,
                elevation: 8.0,
                backgroundColor: Colors.transparent,
                builder: (context) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Card(
                          elevation: 8.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Get Directions
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Get Directions',
                                  style: GoogleFonts.poppins(
                                    fontSize: 25.0,
                                    color: Colors.grey.shade500,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Divider(color: Colors.grey.shade400),
                              for (var map in availableMaps)
                                Column(
                                  children: [
                                    ListTile(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                        return map.showDirections(
                                          origin: Coords(24.178159, 88.270266),
                                          destination:
                                              Coords(23.382559, 87.8478261),
                                          directionsMode:
                                              DirectionsMode.driving,
                                        );
                                      },
                                      title: Text(
                                        'Open in ${map.mapName}',
                                        style: GoogleFonts.getFont(
                                          'Poppins',
                                          fontSize: 20.0,
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      leading: SvgPicture.asset(
                                        map.icon,
                                        height: 30.0,
                                        width: 30.0,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Divider(color: Colors.grey.shade700),
                                  ],
                                ),
                              Column(
                                children: [
                                  ListTile(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                      openMapInBrowser(24.178159, 88.270266,
                                          '23.382559', '87.8478261');
                                    },
                                    title: Text(
                                      'Open in browser',
                                      style: GoogleFonts.getFont(
                                        'Poppins',
                                        fontSize: 20.0,
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    leading:
                                        Icon(MaterialIcons.open_in_browser),
                                  ),
                                  SizedBox(height: 10.0),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // cancel button
                        Card(
                          elevation: 8.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Cancel',
                                style: GoogleFonts.getFont(
                                  'Poppins',
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                });
          },
          child: Text('Map', style: GoogleFonts.poppins(fontSize: 40.0)),
        ),
      ),
    );
  }
}
