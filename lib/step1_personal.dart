import 'package:flutter/material.dart';
import 'resume_model.dart';
import 'resume_widget.dart';
import 'step2_professional.dart';

class Step1PersonalInfo extends StatefulWidget {
  final ResumeData data;
  const Step1PersonalInfo({super.key, required this.data});

  @override
  State<Step1PersonalInfo> createState() => _Step1PersonalInfoState();
}

class _Step1PersonalInfoState extends State<Step1PersonalInfo> {
  late final TextEditingController _name = TextEditingController(
    text: widget.data.fullName,
  );
  late final TextEditingController _email = TextEditingController(
    text: widget.data.email,
  );
  late final TextEditingController _phone = TextEditingController(
    text: widget.data.phone,
  );
  late final TextEditingController _location = TextEditingController(
    text: widget.data.location,
  );

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    _location.dispose();
    super.dispose();
  }

  void _save() {
    widget.data.fullName = _name.text.trim();
    widget.data.email = _email.text.trim();
    widget.data.phone = _phone.text.trim();
    widget.data.location = _location.text.trim();
  }

  void _next() {
    _save();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => Step2Professional(data: widget.data)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: resumeAppBar(
        context: context,
        showSave: false,
        onBack: () => Navigator.maybePop(context),
        onSave: _save,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const StepHeader(
                    step: 1,
                    total: 5,
                    label: 'Personal Details',
                    title: 'Personal Info',
                    subtitle:
                        'Tell us how employers can reach you. This information will appear at the very top of your resume.',
                  ),
                  const SizedBox(height: 24),
                  LabelledField(
                    label: 'Full Name',
                    hint: 'e.g. Jonathan Anderson',
                    controller: _name,
                  ),
                  const SizedBox(height: 16),
                  LabelledField(
                    label: 'Email Address',
                    hint: 'jonathan.a@example.com',
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  LabelledField(
                    label: 'Phone Number',
                    hint: '+1 (555) 000-0000',
                    controller: _phone,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),
                  // Location with icon
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'LOCATION',
                        style: TextStyle(
                          color: kText,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextField(
                        controller: _location,
                        style: const TextStyle(color: kText, fontSize: 14),
                        decoration: InputDecoration(
                          hintText: 'San Francisco, CA',
                          hintStyle: const TextStyle(
                            color: Color(0xFFBBBBCC),
                            fontSize: 13,
                          ),
                          prefixIcon: const Icon(
                            Icons.location_on_outlined,
                            color: kSubtext,
                            size: 18,
                          ),
                          filled: true,
                          fillColor: kInput,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: kBorder),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: kBorder),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: kBlue,
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  NavButtons(showBack: false, onNext: _next),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          ResumeBottomNav(currentStep: 0, onTap: (i) => _handleNavTap(i)),
        ],
      ),
    );
  }

  void _handleNavTap(int i) {
    if (i == 0) return;
    _save();
    if (i == 1) _next();
  }
}
