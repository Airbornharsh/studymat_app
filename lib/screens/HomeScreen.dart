import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studymat_app/Utils/PdfApi.dart';
import 'package:studymat_app/providers/Settings.dart';
import 'package:studymat_app/providers/StudyMats.dart';
import 'package:studymat_app/screens/AuthScreen.dart';
import 'package:studymat_app/screens/InstitutionScreen.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:studymat_app/screens/PdfViewerPage.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  bool start = true;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future onLoad() async {
      final prefs = await SharedPreferences.getInstance();
      // prefs.setString("hopl_backend_uri", "http://localhost:3000");
      // prefs.setString("studymat_backend_uri", "http://192.168.1.35:3000");
      prefs.setString("studymat_backend_uri", "https://studymat.vercel.app");
    }

    onLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text("Study Mat"),
          ),
          body: Container(
            child: Column(children: [
              // TextButton(
              //     style: ButtonStyle(
              //         backgroundColor: MaterialStatePropertyAll<Color>(
              //             Colors.grey.shade800)),
              //     onPressed: () async {
              //       // const url =
              //       //     'https://firebasestorage.googleapis.com/v0/b/studymat-1.appspot.com/o/Resume.pdf?alt=media&token=05817cc7-fafc-4a39-adfa-9e3146ee3ddf';
              //       // final file = await PDFApi.loadNetwork(url);

              //       // Navigator.of(context)
              //       //     .pushNamed(PdfViewerPage.routeName, arguments: file);
              //     },
              //     child: Text("Click",
              //         style: TextStyle(color: Colors.grey.shade300))),
              const SizedBox(
                height: 6,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 18),
                child: TextField(
                  onTap: () {
                    setState(() {
                      isSearching = true;
                    });
                  },
                  controller: _searchController,
                  style: TextStyle(color: Colors.grey.shade900),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search",
                      icon: const Icon(Icons.search, color: Colors.grey),
                      iconColor: Colors.grey.shade900,
                      suffixIcon: isSearching
                          ? IconButton(
                              onPressed: () {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                setState(() {
                                  isSearching = false;
                                });
                              },
                              icon: const Icon(Icons.clear),
                            )
                          : IconButton(
                              onPressed: () {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                setState(() {
                                  isSearching = false;
                                });
                                _searchController.clear();
                              },
                              icon: const Icon(Icons.clear),
                            ),
                      suffixIconColor: Colors.grey.shade900),
                  onSubmitted: (value) async {
                    if (_searchController.text == "adminloginupdate") {
                      Navigator.of(context).pushNamed(AuthScreen.routeName);
                    } else {
                      await Provider.of<StudyMat>(context, listen: false)
                          .listInstitutes(_searchController.text);

                      FocusScope.of(context).requestFocus(new FocusNode());
                      setState(() {
                        isSearching = false;
                      });
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount:
                      Provider.of<StudyMat>(context).getInstitutionsLength,
                  itemBuilder: (context, index) {
                    final institution =
                        Provider.of<StudyMat>(context).getInstitutions[index];
                    return Container(
                      decoration: BoxDecoration(
                          color: Provider.of<Settings>(context).getColor1),
                      child: ListTile(
                        onTap: () async {
                          setState(() {
                            isLoading = true;
                          });
                          await Provider.of<StudyMat>(context, listen: false)
                              .loadMat(institution.id);

                          setState(() {
                            isLoading = false;
                          });
                          Navigator.of(context).pushNamed(
                              InstitutionScreen.routeName,
                              arguments: institution.id);
                        },
                        style: ListTileStyle.drawer,
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(
                            institution.photoLink,
                            errorBuilder: (context, error, stackTrace) {
                              return const SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: Center(child: Text('😊')));
                            },
                          ),
                        ),
                        title: Text(
                          institution.name,
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          "Pdfs: ${institution.pdfs} , Videos: ${institution.videos} , Playlists: ${institution.playlists}",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ]),
          ),
        ),
        if (isLoading)
          Positioned(
            top: 0,
            left: 0,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Container(
              color: const Color.fromRGBO(80, 80, 80, 0.3),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: const Center(child: CircularProgressIndicator()),
            ),
          ),
      ],
    );
  }
}
