// ─── Resume Data Model ────────────────────────────────────────────────────────

class ResumeData {
  // Step 1 - Personal Info
  String fullName = '';
  String email = '';
  String phone = '';
  String location = '';

  // Step 2 - Professional Summary
  String summary = '';

  // Step 3 - Education
  List<Education> educations = [];

  // Step 4 - Work Experience
  List<WorkExperience> experiences = [];

  // Step 5 - Skills
  List<String> selectedSkills = [];
}

class Education {
  String school = '';
  String degree = '';
  String graduationYear = '';

  Education({this.school = '', this.degree = '', this.graduationYear = ''});

  Education copyWith({
    String? school,
    String? degree,
    String? graduationYear,
  }) => Education(
    school: school ?? this.school,
    degree: degree ?? this.degree,
    graduationYear: graduationYear ?? this.graduationYear,
  );
}

class WorkExperience {
  String title = '';
  String company = '';
  String duration = '';

  WorkExperience({this.title = '', this.company = '', this.duration = ''});

  WorkExperience copyWith({String? title, String? company, String? duration}) =>
      WorkExperience(
        title: title ?? this.title,
        company: company ?? this.company,
        duration: duration ?? this.duration,
      );
}

// Popular skills list
const List<String> kPopularSkills = [
  'UI Design',
  'React',
  'Flutter',
  'Project Management',
  'System Architecture',
  'TypeScript',
  'Problem Solving',
  'Strategic Planning',
  'Data Analysis',
  'Agile Methodology',
  'Python',
  'Leadership',
  'Communication',
  'SQL',
  'Machine Learning',
  'Node.js',
  'Product Management',
  'Figma',
];
