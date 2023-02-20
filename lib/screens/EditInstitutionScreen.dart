import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studymat_app/providers/User.dart';
import 'package:studymat_app/screens/AddMatScreen.dart';

class EditInstitutionScreen extends StatefulWidget {
  static const String routeName = "upload";
  EditInstitutionScreen({super.key});
  bool start = true;

  @override
  State<EditInstitutionScreen> createState() => _EditInstitutionScreenState();
}

class _EditInstitutionScreenState extends State<EditInstitutionScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    if (widget.start) {
      Provider.of<User>(context).listAvailableInstitutes();

      setState(() {
        widget.start = false;
      });
    }

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text("Upload Mat"),
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount:
                      Provider.of<User>(context).getAvailableInstitutionsLength,
                  itemBuilder: (context, index) {
                    final institution = Provider.of<User>(context)
                        .getAvailableInstitutions[index];
                    return ListTile(
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });
                        await Provider.of<User>(context, listen: false)
                            .loadMat(institution.id);

                        setState(() {
                          isLoading = false;
                        });
                        Navigator.of(context).pushNamed(AddMatScreen.routeName,
                            arguments: institution.id);
                      },
                      title: Text(institution.name,
                          overflow: TextOverflow.ellipsis),
                      subtitle: Text(
                        "Pdfs: ${institution.pdfs} , Videos: ${institution.videos} , Playlists: ${institution.playlists}",
                        style: const TextStyle(color: Colors.white),
                      ),
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
                    );
                  },
                ),
              )
            ],
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
