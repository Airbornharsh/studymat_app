import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path/path.dart';

class PdfViewerPage extends StatefulWidget {
  static const routeName = "pdfview";
  PdfViewerPage({super.key});

  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  late PDFViewController _controller;
  int pages = 0;
  int indexPage = 0;

  @override
  Widget build(BuildContext context) {
    final file = ModalRoute.of(context)!.settings.arguments as File;
    final name = basename(file.path);
    final text = '${indexPage + 1} of $pages';
    print(file.path);

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        actions: pages >= 2
            ? [
                Center(child: Text(text)),
                IconButton(
                  icon: const Icon(Icons.chevron_left, size: 32),
                  onPressed: () {
                    final page = indexPage == 0 ? pages : indexPage - 1;
                    _controller.setPage(page);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right, size: 32),
                  onPressed: () {
                    final page = indexPage == pages - 1 ? 0 : indexPage + 1;
                    _controller.setPage(page);
                  },
                ),
              ]
            : null,
      ),
      body: PDFView(
        filePath: file.path,
        onRender: (pages) => setState(() => pages = pages!),
        onViewCreated: (controller) => setState(() => _controller = controller),
        onPageChanged: (indexPage, _) => setState(() => indexPage = indexPage!),
      ),
    );
  }
}
