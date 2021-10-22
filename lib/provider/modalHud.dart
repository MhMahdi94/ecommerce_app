import 'package:flutter/widgets.dart';

class ModalHud extends ChangeNotifier {
  bool isLoading = false;

  setIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
