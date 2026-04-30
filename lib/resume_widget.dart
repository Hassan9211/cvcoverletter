import 'package:flutter/material.dart';

// ─── Colors ───────────────────────────────────────────────────────────────────
const Color kBg = Color(0xFFF5F5F5);
const Color kWhite = Color(0xFFFFFFFF);
const Color kAccent = Color(0xFF1A1A2E);
const Color kBlue = Color(0xFF2563EB);
const Color kText = Color(0xFF1A1A2E);
const Color kSubtext = Color(0xFF6B7280);
const Color kBorder = Color(0xFFE5E7EB);
const Color kInput = Color(0xFFF9FAFB);
const Color kTag = Color(0xFFEFF6FF);
const Color kTagText = Color(0xFF1D4ED8);
const Color kDanger = Color(0xFFEF4444);

// ─── Shared AppBar ────────────────────────────────────────────────────────────
PreferredSizeWidget resumeAppBar({
  required BuildContext context,
  required bool showSave,
  required VoidCallback onBack,
  VoidCallback? onSave,
}) {
  return AppBar(
    backgroundColor: kWhite,
    elevation: 0,
    centerTitle: true,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back, color: kText, size: 20),
      onPressed: onBack,
    ),
    title: const Text(
      'RESUME BUILDER',
      style: TextStyle(
        color: kText,
        fontSize: 12,
        fontWeight: FontWeight.w800,
        letterSpacing: 2.5,
      ),
    ),
    actions: [
      if (showSave)
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: TextButton(
            onPressed: onSave,
            style: TextButton.styleFrom(
              backgroundColor: kText,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: const Text(
              'SAVE',
              style: TextStyle(
                color: kWhite,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
              ),
            ),
          ),
        )
      else
        Padding(
          padding: const EdgeInsets.only(right: 14),
          child: TextButton(
            onPressed: onSave,
            child: const Text(
              'SAVE',
              style: TextStyle(
                color: kBlue,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
    ],
  );
}

// ─── Step Header ──────────────────────────────────────────────────────────────
class StepHeader extends StatelessWidget {
  final int step;
  final int total;
  final String label;
  final String title;
  final String subtitle;

  const StepHeader({
    super.key,
    required this.step,
    required this.total,
    required this.label,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Step indicator
        Row(
          children: [
            Text(
              'STEP $step OF $total',
              style: const TextStyle(
                color: kSubtext,
                fontSize: 10,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                color: kBlue,
                fontSize: 10,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        // Progress bar
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: step / total,
            backgroundColor: kBorder,
            valueColor: const AlwaysStoppedAnimation<Color>(kBlue),
            minHeight: 3,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          title,
          style: const TextStyle(
            color: kText,
            fontSize: 26,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: const TextStyle(color: kSubtext, fontSize: 13, height: 1.5),
        ),
      ],
    );
  }
}

// ─── Labelled Text Field ──────────────────────────────────────────────────────
class LabelledField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final int maxLines;
  final TextInputType keyboardType;

  const LabelledField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            color: kText,
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: const TextStyle(color: kText, fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFFBBBBCC), fontSize: 13),
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
              borderSide: const BorderSide(color: kBlue, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Bottom Nav Bar ───────────────────────────────────────────────────────────
class ResumeBottomNav extends StatelessWidget {
  final int currentStep;
  final Function(int) onTap;

  const ResumeBottomNav({
    super.key,
    required this.currentStep,
    required this.onTap,
  });

  static const _items = [
    {'icon': Icons.person_outline, 'label': 'CONTACT'},
    {'icon': Icons.description_outlined, 'label': 'SUMMARY'},
    {'icon': Icons.school_outlined, 'label': 'WORK'},
    {'icon': Icons.work_outline, 'label': 'SCHOOL'},
    {'icon': Icons.star_outline, 'label': 'SKILLS'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: kWhite,
        border: Border(top: BorderSide(color: kBorder)),
      ),
      child: Row(
        children: List.generate(_items.length, (i) {
          final active = i == currentStep;
          return Expanded(
            child: GestureDetector(
              onTap: () => onTap(i),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                color: Colors.transparent,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _items[i]['icon'] as IconData,
                      size: 20,
                      color: active ? kBlue : kSubtext,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      _items[i]['label'] as String,
                      style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                        color: active ? kBlue : kSubtext,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ─── Next / Back Buttons ──────────────────────────────────────────────────────
class NavButtons extends StatelessWidget {
  final bool showBack;
  final bool showNext;
  final String nextLabel;
  final VoidCallback? onBack;
  final VoidCallback? onNext;

  const NavButtons({
    super.key,
    this.showBack = true,
    this.showNext = true,
    this.nextLabel = 'NEXT',
    this.onBack,
    this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (showBack)
          Expanded(
            child: OutlinedButton(
              onPressed: onBack,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: const BorderSide(color: kBorder),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'BACK',
                style: TextStyle(
                  color: kText,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),
        if (showBack && showNext) const SizedBox(width: 12),
        if (showNext)
          Expanded(
            flex: showBack ? 2 : 1,
            child: ElevatedButton(
              onPressed: onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: kText,
                padding: const EdgeInsets.symmetric(vertical: 14),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                nextLabel,
                style: const TextStyle(
                  color: kWhite,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// ─── Tip Box ──────────────────────────────────────────────────────────────────
class TipBox extends StatelessWidget {
  final String tip;
  const TipBox({super.key, required this.tip});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        border: Border.all(color: const Color(0xFFFCD34D)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('💡', style: TextStyle(fontSize: 14)),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'EXECUTIVE TIP',
                  style: TextStyle(
                    color: Color(0xFF92400E),
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  tip,
                  style: const TextStyle(
                    color: Color(0xFF78350F),
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
