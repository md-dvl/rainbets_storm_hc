import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/colors.dart';
import '../widgets/gradient_card.dart';
import '../widgets/storm_painter.dart';
import '../models/group_model.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});
  
  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _stormController;
  String? _selectedSport;
  final List<GroupModel> _groups = [];
  
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
  
  void _showAddGroupDialog() {
    if (_selectedSport == null) {
      HapticFeedback.mediumImpact();
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Select Sport'),
          content: const Text('Please select a sport first.'),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
      return;
    }
    
    final nameController = TextEditingController();
    final cityController = TextEditingController();
    final descriptionController = TextEditingController();
    
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
            child: Container(
              constraints: const BoxConstraints(
                maxHeight: 600,
                minHeight: 400,
              ),
              decoration: BoxDecoration(
                gradient: AppColors.cardGradient,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.lightGrayAccent.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.lightGrayAccent.withOpacity(0.1),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Add Group',
                          style: TextStyle(
                            color: AppColors.whitePrimary,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          minSize: 0,
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Icon(
                            CupertinoIcons.xmark_circle_fill,
                            color: AppColors.lightGrayAccent,
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Content
                  Flexible(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Group Name',
                            style: TextStyle(
                              color: AppColors.lightGrayAccent,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          CupertinoTextField(
                            controller: nameController,
                            placeholder: 'Enter group name',
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.mediumBlue.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.lightGrayAccent.withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            style: const TextStyle(
                              color: AppColors.whitePrimary,
                              fontSize: 16,
                            ),
                            placeholderStyle: TextStyle(
                              color: AppColors.lightGrayAccent.withOpacity(0.5),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'City',
                            style: TextStyle(
                              color: AppColors.lightGrayAccent,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          CupertinoTextField(
                            controller: cityController,
                            placeholder: 'Enter city',
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.mediumBlue.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.lightGrayAccent.withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            style: const TextStyle(
                              color: AppColors.whitePrimary,
                              fontSize: 16,
                            ),
                            placeholderStyle: TextStyle(
                              color: AppColors.lightGrayAccent.withOpacity(0.5),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Description',
                            style: TextStyle(
                              color: AppColors.lightGrayAccent,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          CupertinoTextField(
                            controller: descriptionController,
                            placeholder: 'Enter description (optional)',
                            maxLines: 4,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.mediumBlue.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.lightGrayAccent.withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            style: const TextStyle(
                              color: AppColors.whitePrimary,
                              fontSize: 16,
                            ),
                            placeholderStyle: TextStyle(
                              color: AppColors.lightGrayAccent.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Actions
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: AppColors.lightGrayAccent.withOpacity(0.1),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: CupertinoButton(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            color: AppColors.mediumBlue.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(12),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                color: AppColors.whitePrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: CupertinoButton(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            color: AppColors.mediumBlue,
                            borderRadius: BorderRadius.circular(12),
                            onPressed: () {
                              if (nameController.text.trim().isNotEmpty &&
                                  cityController.text.trim().isNotEmpty) {
                                setState(() {
                                  _groups.add(GroupModel(
                                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                                    name: nameController.text.trim(),
                                    city: cityController.text.trim(),
                                    description: descriptionController.text.trim(),
                                    sport: _selectedSport!,
                                    createdAt: DateTime.now(),
                                  ));
                                });
                                HapticFeedback.mediumImpact();
                                Navigator.of(context).pop();
                              } else {
                                HapticFeedback.lightImpact();
                              }
                            },
                            child: const Text(
                              'Add',
                              style: TextStyle(
                                color: AppColors.whitePrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.deepNavy,
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: AppColors.deepNavy,
        border: null,
        middle: Text(
          'Events',
          style: TextStyle(
            color: AppColors.whitePrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      child: CustomPaint(
        painter: StormPainter(_stormController),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Sport Selection
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildSportButton('Rugby', CupertinoIcons.sportscourt_fill),
                    _buildSportButton('Basketball', CupertinoIcons.sportscourt_fill),
                    _buildSportButton('Baseball', CupertinoIcons.sportscourt_fill),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Add Group Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: _showAddGroupDialog,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: AppColors.navyToBlueGradient,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.lightGrayAccent.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.add_circled_solid,
                          color: AppColors.whitePrimary,
                          size: 24,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Add Group',
                          style: TextStyle(
                            color: AppColors.whitePrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Groups List
              Expanded(
                child: _groups.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.group_solid,
                              size: 64,
                              color: AppColors.neutralGrayBlue.withOpacity(0.5),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No groups yet',
                              style: TextStyle(
                                color: AppColors.lightGrayAccent.withOpacity(0.6),
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.only(bottom: 20),
                        itemCount: _groups.length,
                        itemBuilder: (context, index) {
                          final group = _groups[index];
                          return _buildGroupCard(group, index);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildSportButton(String sport, IconData icon) {
    final isSelected = _selectedSport == sport;
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        setState(() => _selectedSport = sport);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.lightGrayAccent,
                    AppColors.mediumBlue,
                    AppColors.mediumBlue,
                  ],
                )
              : null,
          color: isSelected ? null : AppColors.mediumBlue.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppColors.lightGrayAccent
                : AppColors.neutralGrayBlue.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.lightGrayAccent.withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                  BoxShadow(
                    color: AppColors.mediumBlue.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: AppColors.whitePrimary,
              size: 28,
            ),
            const SizedBox(height: 4),
            Text(
              sport,
              style: TextStyle(
                color: AppColors.whitePrimary,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  void _deleteGroup(int index) {
    final group = _groups[index];
    HapticFeedback.mediumImpact();
    
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Delete Group'),
        content: Text(
          'Are you sure you want to delete "${group.name}"?',
          style: const TextStyle(
            color: AppColors.whitePrimary,
          ),
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text('Delete'),
            onPressed: () {
              setState(() {
                _groups.removeAt(index);
              });
              HapticFeedback.mediumImpact();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildGroupCard(GroupModel group, int index) {
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
                  group.name,
                  style: const TextStyle(
                    color: AppColors.whitePrimary,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.mediumBlue.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      group.sport,
                      style: const TextStyle(
                        color: AppColors.whitePrimary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    minSize: 0,
                    onPressed: () => _deleteGroup(index),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.red.withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                      child: const Icon(
                        CupertinoIcons.delete,
                        color: Colors.red,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(
                CupertinoIcons.location_solid,
                color: AppColors.lightGrayAccent,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                group.city,
                style: TextStyle(
                  color: AppColors.lightGrayAccent,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          if (group.description.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              group.description,
              style: TextStyle(
                color: AppColors.lightGrayAccent.withOpacity(0.8),
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

