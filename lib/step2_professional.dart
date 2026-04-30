import 'package:flutter/material.dart';
import 'resume_model.dart';
import 'resume_widget.dart';
import 'step3_education.dart';

class Step2Professional extends StatefulWidget {
  final ResumeData data;
  const Step2Professional({super.key, required this.data});

  @override
  State<Step2Professional> createState() => _Step2ProfessionalState();
}

class _Step2ProfessionalState extends State<Step2Professional> {
  late final TextEditingController _summary = TextEditingController(
    text: widget.data.summary,
  );

  @override
  void dispose() {
    _summary.dispose();
    super.dispose();
  }

  void _save() => widget.data.summary = _summary.text.trim();

  void _next() {
    _save();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => Step3Education(data: widget.data)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: resumeAppBar(
        context: context,
        showSave: false,
        onBack: () => Navigator.pop(context),
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
                    step: 2,
                    total: 5,
                    label: 'Professional Summary',
                    title: 'Professional\nSummary',
                    subtitle:
                        'Summarize your professional background in 2–3 impactful sentences. Focus on your key achievements and core competencies.',
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'PROFESSIONAL SUMMARY',
                    style: TextStyle(
                      color: kText,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _summary,
                    maxLines: 8,
                    style: const TextStyle(
                      color: kText,
                      fontSize: 13,
                      height: 1.5,
                    ),
                    decoration: InputDecoration(
                      hintText:
                          'Example: Accomplished Marketing Director with 10+ years of experience in driving brand growth and leading cross-functional teams in high-pressure tech environments...',
                      hintStyle: const TextStyle(
                        color: Color(0xFFBBBBCC),
                        fontSize: 12,
                        height: 1.5,
                      ),
                      filled: true,
                      fillColor: kInput,
                      contentPadding: const EdgeInsets.all(14),
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
                        borderSide: const BorderSide(color: kBlue, width: 1.5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Character count
                  Align(
                    alignment: Alignment.centerRight,
                    child: ValueListenableBuilder(
                      valueListenable: _summary,
                      builder: (_, v, _) => Text(
                        '${_summary.text.length} characters',
                        style: const TextStyle(color: kSubtext, fontSize: 11),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const TipBox(
                    tip:
                        'Include specific metrics or high-impact results. Recruiters spend avg 7 seconds on a resume — make yours count.',
                  ),
                  const SizedBox(height: 32),
                  NavButtons(
                    onBack: () => Navigator.pop(context),
                    onNext: _next,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          ResumeBottomNav(
            currentStep: 1,
            onTap: (i) {
              if (i == 1) return;
              _save();
              if (i == 0) Navigator.pop(context);
              if (i == 2) _next();
            },
          ),
        ],
      ),
    );
  }
}
