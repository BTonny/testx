import 'package:flutter/material.dart';
import 'package:testx/models/visitor.dart';
import 'package:testx/utils/colors.dart';
import 'package:testx/visitor_pass.dart';

import 'utils/fonts.dart';
import 'utils/utils.dart';

class RegisterVisitor extends StatefulWidget {
  const RegisterVisitor({super.key});

  @override
  State<RegisterVisitor> createState() => _RegisterVisitorState();
}

class _RegisterVisitorState extends State<RegisterVisitor> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  bool submit = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => TestXUtils.hideKeyboard(context),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: const Text('New Visitor Pre-Access'),
        ),
        body: Stack(
          children: [
            Stack(
              children: [
                Image.asset(
                  "assets/images/calling-elevator-2023-11-27-04-53-35-utc.jpg",
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF121625).withOpacity(0.85),
                  ),
                ),
              ],
            ),
            const Positioned(
              left: 0,
              right: 0,
              top: 80,
              child: Center(
                child: Text(
                  'Villa 45, Palm Crescent Compound, Al Sufouh 2',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: TestXFonts.headerFontFamily,
                    fontWeight: FontWeight.w400,
                    height: 0.09,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: 128,
              child: Container(
                decoration: const ShapeDecoration(
                  color: TestXColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(80)),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x332BBAD2),
                      blurRadius: 30,
                      offset: Offset(0, 0),
                      spreadRadius: 0,
                    )
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(
                  top: 40,
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Padding(
                          padding:
                              EdgeInsets.only(bottom: 10, left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Visitor Info',
                                style: TextStyle(
                                  fontFamily: TestXFonts.headerFontFamily,
                                  color: Color(0xFF121625),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text.rich(
                                TextSpan(
                                  style: TextStyle(
                                      fontFamily: TestXFonts.headerFontFamily),
                                  children: [
                                    TextSpan(
                                      text: '*',
                                      style: TextStyle(
                                        color: TestXColors.secondaryColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' Required field',
                                      style: TextStyle(
                                        color: Color(0xFF121625),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        _listTileCard(
                          context,
                          required: true,
                          icon: inputIcon(Icons.person),
                          label: 'Visitor Name',
                          failedValidation:
                              _nameController.text.isEmpty && submit,
                          input: TextFormField(
                            controller: _nameController,
                            style: inputTextStyle(),
                            decoration: fieldInputDecoration(
                                hint: 'Enter visitor name'),
                          ),
                        ),
                        _listTileCard(
                          context,
                          required: true,
                          icon: inputIcon(Icons.phone),
                          label: 'Phone',
                          failedValidation:
                              _phoneController.text.isEmpty && submit,
                          input: TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: fieldInputDecoration(
                                hint: 'Enter phone number'),
                            style: inputTextStyle(),
                          ),
                        ),
                        _listTileCard(
                          context,
                          icon: inputIcon(Icons.email),
                          label: 'Email',
                          failedValidation: _emailController.text.isNotEmpty &&
                              !TestXUtils.isValidEmail(_emailController.text) &&
                              submit,
                          validationMessage: 'Invalid email address',
                          input: TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: fieldInputDecoration(
                                hint: 'Enter email address'),
                            style: inputTextStyle(),
                          ),
                        ),
                        Builder(builder: (context) {
                          bool validate = selectedDate != null &&
                              selectedDate!.isAfter(DateTime(
                                DateTime.now().year,
                                DateTime.now().month,
                                DateTime.now().day,
                              ));
                          return _listTileCard(
                            context,
                            required: true,
                            validationMessage: 'Invalid date',
                            icon: inputIcon(
                              Icons.calendar_today,
                              failedValidation: submit && !validate,
                            ),
                            failedValidation: submit && !validate,
                            label: 'Expected Visit Date',
                            input: GestureDetector(
                              onTap: () => _selectDate(context),
                              child: Text(
                                selectedDate == null
                                    ? 'Click to pick a date'
                                    : TestXUtils.formatDate(selectedDate!),
                                style: inputTextStyle(),
                              ),
                            ),
                          );
                        }),
                        Builder(builder: (context) {
                          bool validate = selectedDate != null &&
                              selectedDate!.isAfter(DateTime.now());

                          return _listTileCard(
                            context,
                            required: true,
                            failedValidation: submit && !validate,
                            validationMessage: 'Invalid time',
                            icon: inputIcon(
                              Icons.access_time_filled,
                              failedValidation: submit && !validate,
                            ),
                            label: 'Expected Visit Time',
                            input: GestureDetector(
                              onTap: () => _selectTime(context),
                              child: Text(
                                selectedDate == null
                                    ? 'Click to pick a time'
                                    : TestXUtils.formatTime(selectedDate!),
                                style: inputTextStyle(),
                              ),
                            ),
                          );
                        }),
                        _listTileCard(
                          context,
                          icon: inputIcon(Icons.credit_card),
                          label: 'ID Number',
                          input: TextFormField(
                            controller: _idController,
                            keyboardType: TextInputType.number,
                            decoration:
                                fieldInputDecoration(hint: 'E.g: xxxxxxxxxxxx'),
                            style: inputTextStyle(),
                          ),
                        ),
                        _listTileCard(
                          context,
                          height: 120,
                          failedValidation:
                              _reasonController.text.isEmpty && submit,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          required: true,
                          icon: inputIcon(Icons.messenger),
                          label: 'Visit Reason',
                          input: TextFormField(
                            controller: _reasonController,
                            maxLines: 4,
                            autofocus: false,
                            decoration: fieldInputDecoration(
                                hint: 'Enter reason for visit'),
                            style: inputTextStyle(),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field is required';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 15, bottom: 30, left: 20, right: 20),
                          decoration: ShapeDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xFF157C8C),
                                TestXColors.secondaryColor
                              ],
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(500),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x4C3596A6),
                                blurRadius: 40,
                                offset: Offset(0, 10),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: ElevatedButton(
                              onPressed: _submitForm,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 12,
                                ).copyWith(left: 25),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Next Step",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      color: Colors.black,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.chevron_right_sharp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    setState(() {
      submit = true;
    });

    bool isValid = _validateFields();

    if (isValid) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return VisitorPass(
          visitor: Visitor(
            name: _nameController.text,
            phone: _phoneController.text,
            email: _emailController.text,
            date: selectedDate!,
            visitorId: _idController.text,
            reason: _reasonController.text,
          ),
        );
      })).then((value) {
        setState(() {
          submit = false;
        });
        FocusManager.instance.primaryFocus?.unfocus();
      });
    } else {
      setState(() {
        submit = true;
      });
    }
  }

  bool _validateFields() {
    if (_nameController.text.isEmpty) return false;
    if (_phoneController.text.isEmpty) return false;
    if (_reasonController.text.isEmpty) return false;

    if (selectedDate == null) return false;

    DateTime today = DateTime.now();
    DateTime selectedDay =
        DateTime(selectedDate!.year, selectedDate!.month, selectedDate!.day);
    DateTime currentDay = DateTime(today.year, today.month, today.day);

    if (selectedDay.isBefore(currentDay)) return false;

    if (_emailController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        !TestXUtils.isValidEmail(_emailController.text)) {
      return false;
    }

    return true;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = DateTime(
          picked.year,
          picked.month,
          picked.day,
          selectedDate?.hour ?? TimeOfDay.now().hour,
          selectedDate?.minute ?? TimeOfDay.now().minute,
        );
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedDate = DateTime(
          selectedDate?.year ?? DateTime.now().year,
          selectedDate?.month ?? DateTime.now().month,
          selectedDate?.day ?? DateTime.now().day,
          picked.hour,
          picked.minute,
        );
      });
    }
  }
}

Icon inputIcon(IconData icon, {bool failedValidation = false}) {
  return Icon(
    icon,
    size: 26,
    color:
        failedValidation ? TestXColors.errorColor : TestXColors.secondaryColor,
  );
}

TextStyle inputTextStyle() {
  return const TextStyle(
    color: Colors.black,
    fontSize: 13,
    fontWeight: FontWeight.normal,
  );
}

InputDecoration fieldInputDecoration({String hint = ''}) {
  return InputDecoration(
    isDense: true,
    contentPadding: const EdgeInsets.symmetric(
      vertical: 0,
      horizontal: 0,
    ),
    border: InputBorder.none,
    hintText: hint,
    hintStyle: TextStyle(
      color: Colors.black.withOpacity(0.5),
      fontSize: 12,
      fontWeight: FontWeight.w400,
      // height: 0.14,
    ),
  );
}

Widget _listTileCard(BuildContext context,
    {required Widget icon,
    required String label,
    required Widget input,
    bool failedValidation = false,
    String validationMessage = 'This Field is Required',
    double height = 60,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    bool required = false}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 5),
    margin: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: height,
          width: MediaQuery.sizeOf(context).width,
          margin: failedValidation ? const EdgeInsets.only(bottom: 4) : null,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: failedValidation
                  ? const BorderSide(
                      width: 1,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      color: TestXColors.errorColor,
                    )
                  : BorderSide.none,
            ),
            shadows: [
              failedValidation
                  ? const BoxShadow(
                      color: Color(0x4CF2474A),
                      blurRadius: 30,
                      offset: Offset(0, 0),
                      spreadRadius: 0,
                    )
                  : const BoxShadow(
                      color: Color(0x332BBAD2),
                      blurRadius: 20,
                      offset: Offset(0, 0),
                      spreadRadius: 0,
                    )
            ],
          ),
          child: Row(
            crossAxisAlignment: crossAxisAlignment,
            children: [
              icon,
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: label,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (required)
                            const TextSpan(
                              text: ' *',
                              style: TextStyle(
                                color: TestXColors.secondaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    input,
                  ],
                ),
              ),
            ],
          ),
        ),
        if (failedValidation)
          Text(
            validationMessage,
            style: const TextStyle(
              color: TestXColors.errorColor,
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
      ],
    ),
  );
}
