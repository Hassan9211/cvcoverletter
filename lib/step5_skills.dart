import 'package:flutter/material.dart';
import 'resume_model.dart';
import 'resume_widget.dart';

class Step5Skills extends StatefulWidget {
  final ResumeData data;
  const Step5Skills({super.key, required this.data});

  @override
  State<Step5Skills> createState() => _Step5SkillsState();
}

class _Step5SkillsState extends State<Step5Skills> {
  late List<String> _selected;
  final _searchCtrl = TextEditingController();
  String _query = '';

  @override
  void initState() {
    super.initState();
    _selected = List.from(widget.data.selectedSkills);
    _searchCtrl.addListener(
      () => setState(() => _query = _searchCtrl.text.trim().toLowerCase()),
    );
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _save() => widget.data.selectedSkills = List.from(_selected);

  void _toggleSkill(String skill) {
    setState(() {
      if (_selected.contains(skill)) {
        _selected.remove(skill);
      } else {
        _selected.add(skill);
      }
    });
  }

  void _addCustomSkill() {
    final skill = _searchCtrl.text.trim();
    if (skill.isEmpty) return;
    setState(() {
      if (!_selected.contains(skill)) _selected.add(skill);
      _searchCtrl.clear();
    });
  }

  void _finish() {
    _save();
    _showCompletionDialog();
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        backgroundColor: kWhite,
        contentPadding: const EdgeInsets.all(28),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: kTag,
                borderRadius: BorderRadius.circular(32),
              ),
              child: const Icon(
                Icons.check_circle_outline,
                color: kBlue,
                size: 36,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Resume Complete!',
              style: TextStyle(
                color: kText,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Your resume has been saved successfully. You can edit it anytime.',
              textAlign: TextAlign.center,
              style: TextStyle(color: kSubtext, fontSize: 13, height: 1.5),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).popUntil((r) => r.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kText,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'GO TO HOME',
                  style: TextStyle(
                    color: kWhite,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> get _filteredPopular => kPopularSkills
      .where(
        (s) =>
            !_selected.contains(s) &&
            (_query.isEmpty || s.toLowerCase().contains(_query)),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: resumeAppBar(
        context: context,
        showSave: true,
        onBack: () => Navigator.pop(context),
        onSave: _finish,
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
                    step: 5,
                    total: 5,
                    label: 'Skills & Expertise',
                    title: 'Skills',
                    subtitle:
                        'Highlight your core competencies. Professional skills make you more discoverable to recruiters and ATS systems.',
                  ),
                  const SizedBox(height: 24),

                  // ── Add Skill Input ──
                  const Text(
                    'ADD A SKILL',
                    style: TextStyle(
                      color: kText,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchCtrl,
                          style: const TextStyle(color: kText, fontSize: 14),
                          onSubmitted: (_) => _addCustomSkill(),
                          decoration: InputDecoration(
                            hintText: 'e.g. Adobe Creative Suite',
                            hintStyle: const TextStyle(
                              color: Color(0xFFBBBBCC),
                              fontSize: 13,
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
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: _addCustomSkill,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kText,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 14,
                          ),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'ADD',
                          style: TextStyle(
                            color: kWhite,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // ── Selected Skills ──
                  if (_selected.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    const Text(
                      'SELECTED SKILLS',
                      style: TextStyle(
                        color: kText,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _selected
                          .map(
                            (skill) => _SkillChip(
                              label: skill,
                              selected: true,
                              onTap: () => _toggleSkill(skill),
                            ),
                          )
                          .toList(),
                    ),
                  ],

                  const SizedBox(height: 24),

                  // ── Popular Skills ──
                  const Text(
                    'Popular for your role',
                    style: TextStyle(
                      color: kText,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),

                  if (_filteredPopular.isEmpty)
                    const Text(
                      'No more suggestions',
                      style: TextStyle(color: kSubtext, fontSize: 13),
                    )
                  else
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2.5,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                      itemCount: _filteredPopular.length,
                      itemBuilder: (_, i) {
                        final skill = _filteredPopular[i];
                        // Alternate category labels
                        final cats = [
                          'DESIGN',
                          'TECHNICAL',
                          'MANAGEMENT',
                          'TECHNICAL',
                          'SOFT SKILLS',
                          'MANAGEMENT',
                        ];
                        final cat = cats[i % cats.length];
                        return _PopularCard(
                          skill: skill,
                          category: cat,
                          onTap: () => _toggleSkill(skill),
                        );
                      },
                    ),

                  const SizedBox(height: 32),
                  NavButtons(
                    nextLabel: 'FINISH',
                    onBack: () => Navigator.pop(context),
                    onNext: _finish,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          ResumeBottomNav(
            currentStep: 4,
            onTap: (i) {
              if (i == 4) return;
              _save();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

// ─── Skill Chip ───────────────────────────────────────────────────────────────
class _SkillChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _SkillChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? kTag : kInput,
          border: Border.all(
            color: selected ? kBlue.withValues(alpha: 0.4) : kBorder,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color: selected ? kTagText : kSubtext,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (selected) ...[
              const SizedBox(width: 4),
              Icon(
                Icons.close,
                size: 13,
                color: kTagText.withValues(alpha: 0.6),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ─── Popular Skill Card ───────────────────────────────────────────────────────
class _PopularCard extends StatelessWidget {
  final String skill;
  final String category;
  final VoidCallback onTap;

  const _PopularCard({
    required this.skill,
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: kInput,
          border: Border.all(color: kBorder),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              skill,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: kText,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              category,
              style: const TextStyle(
                color: kSubtext,
                fontSize: 9,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
