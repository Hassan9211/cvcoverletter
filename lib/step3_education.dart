import 'package:flutter/material.dart';
import 'resume_model.dart';
import 'resume_widget.dart';
import 'step4_experiance.dart';

class Step3Education extends StatefulWidget {
  final ResumeData data;
  const Step3Education({super.key, required this.data});

  @override
  State<Step3Education> createState() => _Step3EducationState();
}

class _Step3EducationState extends State<Step3Education> {
  late List<_EduControllers> _controllers;

  @override
  void initState() {
    super.initState();
    if (widget.data.educations.isEmpty) {
      widget.data.educations.add(Education());
    }
    _controllers = widget.data.educations
        .map((e) => _EduControllers.from(e))
        .toList();
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _save() {
    widget.data.educations = _controllers
        .map(
          (c) => Education(
            school: c.school.text.trim(),
            degree: c.degree.text.trim(),
            graduationYear: c.year.text.trim(),
          ),
        )
        .toList();
  }

  void _addEducation() {
    setState(() {
      widget.data.educations.add(Education());
      _controllers.add(_EduControllers.empty());
    });
  }

  void _removeEducation(int i) {
    setState(() {
      _controllers[i].dispose();
      _controllers.removeAt(i);
      widget.data.educations.removeAt(i);
    });
  }

  void _next() {
    _save();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => Step4Experience(data: widget.data)),
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
                    step: 4,
                    total: 5,
                    label: 'Education',
                    title: 'Education',
                    subtitle:
                        'Highlight your academic background and professional certifications to build credibility.',
                  ),
                  const SizedBox(height: 24),

                  // Education entries
                  ...List.generate(
                    _controllers.length,
                    (i) => _EduCard(
                      index: i,
                      controllers: _controllers[i],
                      onRemove: _controllers.length > 1
                          ? () => _removeEducation(i)
                          : null,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Add more button
                  GestureDetector(
                    onTap: _addEducation,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: kBlue.withValues(alpha: 0.4),
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        color: kTag,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, color: kBlue, size: 18),
                          SizedBox(width: 6),
                          Text(
                            'ADD EDUCATION',
                            style: TextStyle(
                              color: kBlue,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
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
            currentStep: 2,
            onTap: (i) {
              if (i == 2) return;
              _save();
              if (i < 2) Navigator.pop(context);
              if (i == 3) _next();
            },
          ),
        ],
      ),
    );
  }
}

// ─── Education Card ───────────────────────────────────────────────────────────
class _EduCard extends StatelessWidget {
  final int index;
  final _EduControllers controllers;
  final VoidCallback? onRemove;

  const _EduCard({
    required this.index,
    required this.controllers,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: kBorder),
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFFAFAFC),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Education ${index + 1}',
                style: const TextStyle(
                  color: kText,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (onRemove != null)
                GestureDetector(
                  onTap: onRemove,
                  child: const Icon(
                    Icons.delete_outline,
                    color: kDanger,
                    size: 18,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 14),
          LabelledField(
            label: 'School',
            hint: 'e.g. Stanford University',
            controller: controllers.school,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: LabelledField(
                  label: 'Degree',
                  hint: 'e.g. B.A. Ect',
                  controller: controllers.degree,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: LabelledField(
                  label: 'Grad Year',
                  hint: 'YYYY',
                  controller: controllers.year,
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Controllers helper ───────────────────────────────────────────────────────
class _EduControllers {
  final TextEditingController school;
  final TextEditingController degree;
  final TextEditingController year;

  _EduControllers({
    required this.school,
    required this.degree,
    required this.year,
  });

  factory _EduControllers.from(Education e) => _EduControllers(
    school: TextEditingController(text: e.school),
    degree: TextEditingController(text: e.degree),
    year: TextEditingController(text: e.graduationYear),
  );

  factory _EduControllers.empty() => _EduControllers(
    school: TextEditingController(),
    degree: TextEditingController(),
    year: TextEditingController(),
  );

  void dispose() {
    school.dispose();
    degree.dispose();
    year.dispose();
  }
}
