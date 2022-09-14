import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data.dart';
import 'package:todo/main.dart';

class EditTaskScreen extends StatefulWidget {
  EditTaskScreen({super.key, required this.task});
  final TaskEntity task;

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  //grftan va zakhire on roye DataBAse
  late final TextEditingController _controller =
  //=========================================================>>>> zamani ke in text fild load shod ma dakhelesh esm task mizarim
      TextEditingController(text: widget.task.name);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: themeData.colorScheme.surface,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
           /// ahmiyat dadn be tghir task ha 
            widget.task.name = _controller.text;
            //==================================================================entkhabl rang ovlaviat karbar
            widget.task.priority = widget.task.priority;
            // cheack krdn task ha dakhel box
            if (widget.task.isInBox) {
               //===================================================================================>>>>> Zakhire task ha

              widget.task.save();
            } else {
              final box = Hive.box(taskBoxName);
              box.add(widget.task);
            }
            Navigator.of(context).pop();
          },
          label: Row(
            children: [
              const Text('savechange'),
              const SizedBox(
                width: 4,
              ),
              Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 142, 90, 247),
                ),
                child: const Icon(
                  CupertinoIcons.check_mark,
                  size: 18,
                ),
              )
            ],
          )),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: themeData.colorScheme.surface,

        ///==================================================================>>>>> om chizi ke roye background gharar migirad
        foregroundColor: themeData.colorScheme.onSurface,
        title: const Text('EditTasks'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(
                    flex: 1,
                    child: PriorityCheackbox(
                      onTap: () {
                        setState(() {
                          widget.task.priority = Priority.hight;
                        });
                      },
                      labale: 'Hight',
                      color: hightPrioritycolor,
                      isSeleceted: widget.task.priority == Priority.hight,
                    )),
                const SizedBox(
                  width: 8,
                ),
                Flexible(
                    flex: 1,
                    child: PriorityCheackbox(
                      onTap: () {
                        setState(() {
                          widget.task.priority = Priority.normal;
                        });
                      },
                      labale: 'Normal',
                      color: naromalPrioritycolor,
                      isSeleceted: widget.task.priority == Priority.normal,
                    )),
                const SizedBox(
                  width: 8,
                ),
                Flexible(
                    flex: 1,
                    child: PriorityCheackbox(
                      onTap: () {
                        setState(() {
                          widget.task.priority = Priority.low;
                        });
                      },
                      labale: 'Low',
                      color: lowPrioritycolor,
                      isSeleceted: widget.task.priority == Priority.low,
                    )),
              ],
            ),
            TextField(
                controller: _controller,
                decoration: InputDecoration(
                    label: Text('add Task for Today...',
                        style: themeData.textTheme.bodyText2!
                            .apply(fontSizeFactor: 1.4))))
          ],
        ),
      ),
    );
  }
}

/// sakht custom cheack box jajaht olawiat bandi task ha

class PriorityCheackbox extends StatelessWidget {
  final String labale;
  final Color color;
  final bool isSeleceted;
  final GestureTapCallback onTap;

  const PriorityCheackbox(
      {super.key,
      required this.labale,
      required this.color,
      required this.isSeleceted,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              width: 2,
              color: secondrTextColor.withOpacity(0.2),
            )),
        child: Stack(children: [
          Center(child: Text(labale)),
          Positioned(
            right: 8,
            top: 0,
            bottom: 0,
            child: Center(
              child: _CheackboxShape(
                value: isSeleceted,
                color: color,
              ),
            ),
          )
        ]),
      ),
    );
  }
}

class _CheackboxShape extends StatelessWidget {
  final bool value;
  final Color color;

  const _CheackboxShape({required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      height: 16,
      width: 16,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: value
          ? const Icon(
              CupertinoIcons.check_mark,
              color: Colors.white,
              size: 14,
            )
          : null,
    );
  }
}
