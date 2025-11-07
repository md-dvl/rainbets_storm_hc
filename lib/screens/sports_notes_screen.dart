import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '../utils/colors.dart';
import '../widgets/gradient_card.dart';
import '../widgets/storm_painter.dart';
import '../models/note_model.dart';

class SportsNotesScreen extends StatefulWidget {
  const SportsNotesScreen({super.key});
  
  @override
  State<SportsNotesScreen> createState() => _SportsNotesScreenState();
}

class _SportsNotesScreenState extends State<SportsNotesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _stormController;
  final List<NoteModel> _notes = [];
  
  @override
  void initState() {
    super.initState();
    _stormController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();
  }
  
  @override
  void dispose() {
    _stormController.dispose();
    super.dispose();
  }
  
  void _showAddNoteDialog() {
    final titleController = TextEditingController();
    final contentController = TextEditingController();
    
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('New Note'),
        content: Column(
          children: [
            const SizedBox(height: 16),
            CupertinoTextField(
              controller: titleController,
              placeholder: 'Title',
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.mediumBlue,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 12),
            CupertinoTextField(
              controller: contentController,
              placeholder: 'Content',
              maxLines: 5,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.mediumBlue,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ],
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Save'),
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                setState(() {
                  _notes.add(NoteModel(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    title: titleController.text,
                    content: contentController.text,
                    createdAt: DateTime.now(),
                  ));
                });
                HapticFeedback.mediumImpact();
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.deepNavy,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: AppColors.deepNavy,
        border: null,
        middle: const Text(
          'Sports Notes',
          style: TextStyle(
            color: AppColors.whitePrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _showAddNoteDialog,
          child: const Icon(
            CupertinoIcons.add_circled_solid,
            color: AppColors.whitePrimary,
            size: 28,
          ),
        ),
      ),
      child: CustomPaint(
        painter: StormPainter(_stormController),
        child: SafeArea(
          child: _notes.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.book_fill,
                        size: 64,
                        color: AppColors.neutralGrayBlue.withOpacity(0.5),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No notes yet',
                        style: TextStyle(
                          color: AppColors.lightGrayAccent.withOpacity(0.6),
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tap + to add a note',
                        style: TextStyle(
                          color: AppColors.lightGrayAccent.withOpacity(0.4),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _notes.length,
                  itemBuilder: (context, index) {
                    final note = _notes[index];
                    return GradientCard(
                      onTap: () {
                        HapticFeedback.mediumImpact();
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  note.title,
                                  style: const TextStyle(
                                    color: AppColors.whitePrimary,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  setState(() {
                                    _notes.removeAt(index);
                                  });
                                  HapticFeedback.mediumImpact();
                                },
                                child: const Icon(
                                  CupertinoIcons.delete,
                                  color: AppColors.lightGrayAccent,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          if (note.content.isNotEmpty) ...[
                            const SizedBox(height: 12),
                            Text(
                              note.content,
                              style: TextStyle(
                                color: AppColors.lightGrayAccent.withOpacity(0.9),
                                fontSize: 15,
                                height: 1.5,
                              ),
                            ),
                          ],
                          const SizedBox(height: 12),
                          Text(
                            _formatDate(note.createdAt),
                            style: TextStyle(
                              color: AppColors.neutralGrayBlue,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
  
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

