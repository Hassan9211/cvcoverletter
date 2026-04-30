import 'package:flutter/material.dart';
import 'resume_model.dart';
import 'resume_widget.dart';
import 'step5_skills.dart';

class Step4Experience extends StatefulWidget {
  final ResumeData data;
  const Step4Experience({super.key, required this.data});

  @override
  State<Step4Experience> createState() => _Step4ExperienceState();
}

class _Step4ExperienceState extends State<Step4Experience> {
  late List<_ExpControllers> _controllers;

  @override
  void initState() {
    super.initState();
    if (widget.data.experiences.isEmpty) {
      widget.data.experiences.add(WorkExperience());
    }
    _controllers = widget.data.experiences
        .map((e) => _ExpControllers.from(e))
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
    widget.data.experiences = _controllers
        .map(
          (c) => WorkExperience(
            title: c.title.text.trim(),
            company: c.company.text.trim(),
            duration: c.duration.text.trim(),
          ),
        )
        .toList();
  }

  void _addExperience() {
    setState(() {
      widget.data.experiences.add(WorkExperience());
      _controllers.add(_ExpControllers.empty());
    });
  }

  void _removeExperience(int i) {
    setState(() {
      _controllers[i].dispose();
      _controllers.removeAt(i);
      widget.data.experiences.removeAt(i);
    });
  }

  void _next() {
    _save();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => Step5Skills(data: widget.data)),
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
                    step: 3,
                    total: 5,
                    label: 'Work Experience',
                    title: 'Work Experience',
                    subtitle:
                        'Detail your professional journey. Start with your most recent role to showcase your current expertise.',
                  ),
                  const SizedBox(height: 24),

                  // Experience entries
                  ...List.generate(
                    _controllers.length,
                    (i) => _ExpCard(
                      index: i,
                      controllers: _controllers[i],
                      onRemove: _controllers.length > 1
                          ? () => _removeExperience(i)
                          : null,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Add experience button
                  GestureDetector(
                    onTap: _addExperience,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        border: Border.all(color: kBorder),
                        borderRadius: BorderRadius.circular(8),
                        color: kInput,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_circle_outline,
                            color: kSubtext,
                            size: 18,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Add Experience',
                            style: TextStyle(
                              color: kSubtext,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
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
            currentStep: 3,
            onTap: (i) {
              if (i == 3) return;
              _save();
              if (i < 3) Navigator.pop(context);
              if (i == 4) _next();
            },
          ),
        ],
      ),
    );
  }
}

// ─── Experience Card ──────────────────────────────────────────────────────────
class _ExpCard extends StatelessWidget {
  final int index;
  final _ExpControllers controllers;
  final VoidCallback? onRemove;

  const _ExpCard({
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
          // Header with bullet and actions
          Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: kBlue,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Experience ${index + 1}',
                  style: const TextStyle(
                    color: kText,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Icon(Icons.edit_outlined, color: kSubtext, size: 16),
              const SizedBox(width: 10),
              if (onRemove != null)
                GestureDetector(
                  onTap: onRemove,
                  child: const Icon(
                    Icons.delete_outline,
                    color: kDanger,
                    size: 16,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 14),
          LabelledField(
            label: 'Job Title',
            hint: 'e.g. Senior Product Designer',
            controller: controllers.title,
          ),
          const SizedBox(height: 12),
          LabelledField(
            label: 'Company',
            hint: 'e.g. Lumina Tech Industries',
            controller: controllers.company,
          ),
          const SizedBox(height: 12),
          LabelledField(
            label: 'Duration',
            hint: 'e.g. Jan 2021 — Present',
            controller: controllers.duration,
          ),
        ],
      ),
    );
  }
}

// ─── Controllers helper ───────────────────────────────────────────────────────
class _ExpControllers {
  final TextEditingController title;
  final TextEditingController company;
  final TextEditingController duration;

  _ExpControllers({
    required this.title,
    required this.company,
    required this.duration,
  });

  factory _ExpControllers.from(WorkExperience e) => _ExpControllers(
    title: TextEditingController(text: e.title),
    company: TextEditingController(text: e.company),
    duration: TextEditingController(text: e.duration),
  );

  factory _ExpControllers.empty() => _ExpControllers(
    title: TextEditingController(),
    company: TextEditingController(),
    duration: TextEditingController(),
  );

  void dispose() {
    title.dispose();
    company.dispose();
    duration.dispose();
  }
}
