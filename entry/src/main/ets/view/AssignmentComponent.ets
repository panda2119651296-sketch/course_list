import { Assignment } from '../model/Types';

// 1. 添加作业弹窗
@CustomDialog
struct AddAssignmentDialog {
  controller: CustomDialogController;
  confirm: (item: Assignment) => void = () => {};

  @State courseName: string = '';
  @State content: string = '';
  @State deadline: string = '';

  build() {
    Column({ space: 15 }) {
      Text('布置新作业').fontSize(20).fontWeight(FontWeight.Bold).margin(10)
      TextInput({ placeholder: '科目 (如: 马原)' }).onChange(v => this.courseName = v)
      TextInput({ placeholder: '作业内容 (如: 1000字论文)' }).onChange(v => this.content = v)
      TextInput({ placeholder: '截止日期 (YYYY-MM-DD)' }).onChange(v => this.deadline = v) // 也可以用DatePicker

      Row() {
        Button('取消').backgroundColor(Color.Gray).onClick(() => this.controller.close())
        Button('添加').onClick(() => {
          if (this.content) {
            this.confirm({
              id: Date.now(),
              courseName: this.courseName || '其他',
              content: this.content,
              deadline: this.deadline || '尽快',
              isFinished: false
            });
            this.controller.close();
          }
        })
      }.justifyContent(FlexAlign.SpaceEvenly).width('100%')
    }.padding(20).backgroundColor(Color.White).borderRadius(10)
  }
}

@Component
export struct AssignmentComponent {
  @State assignments: Assignment[] = [];

  dialogController: CustomDialogController = new CustomDialogController({
    builder: AddAssignmentDialog({
      confirm: (item: Assignment) => {
        this.assignments.push(item);
        // 💡 记得保存数据
      }
    }),
    alignment: DialogAlignment.Bottom // 弹窗从底部弹出，体验更好
  });

  // 定义侧滑删除的按钮样式
  @Builder itemEnd(index: number) {
    Button({ type: ButtonType.Circle }) {
      // ✅ 修复：直接用文字 '删' 代替图片
      Text('删')
        .fontSize(14)
        .fontColor(Color.White)
    }
    .width(40)
    .height(40)
    .backgroundColor(Color.Red)
    .margin({ left: 10 })
    .onClick(() => {
      this.assignments.splice(index, 1); // 从数组中移除
      // 💡 记得保存数据
    })
  }

  // 如果没有icon资源，可以用这个纯文字版
  @Builder itemEndText(index: number) {
    Button("删除")
      .backgroundColor(Color.Red)
      .fontColor(Color.White)
      .height('100%')
      .width(80)
      .onClick(() => {
        this.assignments.splice(index, 1);
      })
  }

  build() {
    Column() {
      Row() {
        Text('待办清单').fontSize(24).fontWeight(FontWeight.Bold)
        Blank()
        // 顶部添加按钮
        Button('+ 新作业').height(30).fontSize(14)
          .onClick(() => this.dialogController.open())
      }.width('95%').margin({ top: 15, bottom: 15 })

      List({ space: 12 }) {
        ForEach(this.assignments, (item: Assignment, index: number) => {
          ListItem() {
            // 原有的卡片布局
            Row() {
              Checkbox({ name: 'done' })
                .select(item.isFinished)
                .onChange((val) => item.isFinished = val)

              Column() {
                Text(item.content)
                  .fontSize(16)
                  .decoration({ type: item.isFinished ? TextDecorationType.LineThrough : TextDecorationType.None })
                  .fontColor(item.isFinished ? Color.Gray : Color.Black)

                Row() {
                  Text(item.courseName).fontSize(10).backgroundColor('#F0F0F0').padding(4).borderRadius(4)
                  Blank().width(10)
                  Text(item.deadline).fontSize(10).fontColor(Color.Red)
                }.margin({ top: 5 })
              }.alignItems(HorizontalAlign.Start).margin({ left: 10 })
            }
            .width('100%')
            .padding(15)
            .backgroundColor(Color.White)
            .borderRadius(12)
            .shadow({ radius: 4, color: '#10000000' })
          }
          // 🔥 核心：添加侧滑删除功能
          .swipeAction({ end: this.itemEndText(index) })
        })
      }
      .width('95%')
      .layoutWeight(1)

      if (this.assignments.length === 0) {
        Text('暂无作业，去休息吧~').fontColor(Color.Gray).margin({top: 50})
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}