import { Course } from '../model/Types';
import { StorageUtils } from '../utils/StorageUtils';

// 1. 定义莫兰迪色系池
const MORANDI_COLORS = ['#E0BBE4', '#957DAD', '#D291BC', '#FEC8D8', '#FFDFD3', '#B5EAD7', '#C7CEEA', '#81B622'];

// 2. 自定义添加课程的弹窗
@CustomDialog
struct AddCourseDialog {
  controller: CustomDialogController;
  // 用于接收父组件传递的添加函数
  confirm: (course: Course) => void = () => {};

  // 表单状态
  @State name: string = '';
  @State location: string = '';
  @State day: string = '';
  @State period: string = '';
  @State selectedColor: string = MORANDI_COLORS[Math.floor(Math.random() * MORANDI_COLORS.length)]; // 默认随机

  build() {
    Column({ space: 15 }) {
      Text('添加新课程').fontSize(20).fontWeight(FontWeight.Bold).margin({ top: 10, bottom: 10 })

      TextInput({ placeholder: '课程名称 (如: 操作系统)' }).onChange(val => this.name = val)
      TextInput({ placeholder: '教室地点 (如: 教三-201)' }).onChange(val => this.location = val)

      Row({ space: 10 }) {
        TextInput({ placeholder: '周几 (1-7)' }).type(InputType.Number).width('45%').onChange(val => this.day = val)
        TextInput({ placeholder: '第几节 (1-12)' }).type(InputType.Number).width('45%').onChange(val => this.period = val)
      }

      // 颜色选择区域
      Text('选择课程颜色').fontSize(14).fontColor(Color.Gray).width('100%')
      Flex({ wrap: FlexWrap.Wrap }) {
        ForEach(MORANDI_COLORS, (color: string) => {
          Circle({ width: 25, height: 25 })
            .fill(color)
            .margin(5)
            .borderWidth(this.selectedColor === color ? 2 : 0) // 选中态加边框
            .borderColor(Color.Black)
            .onClick(() => this.selectedColor = color)
        })
      }

      Row() {
        Button('取消').backgroundColor(Color.Gray).onClick(() => this.controller.close())
        Button('确定').onClick(() => {
          if (this.name && this.day && this.period) {
            // 回调给父组件
            this.confirm({
              id: Date.now(), // 用时间戳做简单ID
              name: this.name,
              location: this.location,
              dayOfWeek: parseInt(this.day),
              period: parseInt(this.period),
              color: this.selectedColor
            });
            this.controller.close();
          }
        })
      }.justifyContent(FlexAlign.SpaceEvenly).width('100%').margin({ bottom: 10 })
    }.padding(20).backgroundColor(Color.White).borderRadius(10)
  }
}

@Component
export struct TimetableComponent {
  @State courses: Course[] = [];

  // 初始化弹窗控制器
  dialogController: CustomDialogController = new CustomDialogController({
    builder: AddCourseDialog({
      confirm: (newCourse: Course) => this.addCourse(newCourse)
    }),
    alignment: DialogAlignment.Center
  });

  aboutToAppear() {
    // 模拟加载数据 (实际开发中这里应该调用 StorageUtils.getData)
    // this.courses = JSON.parse(await StorageUtils.getData(getContext(this), 'courses_data'));
    // 暂时放一个示例
    if(this.courses.length === 0) {
      this.courses.push({ id: 1, name: '示例课程', location: '101', dayOfWeek: 1, period: 1, color: MORANDI_COLORS[0] })
    }
  }

  // 添加课程逻辑
  // ✅ 修改后：显式加上 : void
  addCourse(course: Course): void {
    this.courses.push(course);
  }

  // ✅ 修改后：显式加上 : void
  deleteCourse(id: number): void {
    this.courses = this.courses.filter(c => c.id !== id);
  }

  build() {
    Column() {
      // 表头
      Row() {
        ForEach(['一', '二', '三', '四', '五', '六', '日'], (day: string) => {
          Text(day).width('14%').textAlign(TextAlign.Center).fontWeight(FontWeight.Bold)
        })
      }.height(40).width('100%').backgroundColor('#F0F0F0')

      // 课表内容
      List() {
        ForEach([1, 2, 3, 4, 5, 6, 7], (day: number) => {
          ListItem() {
            Column() {
              Text(`星期${day}`).fontSize(16).fontWeight(FontWeight.Bold).fontColor('#666666').margin({ top: 10, bottom: 5 })

              // 渲染当天的课程
              if (this.courses.filter(c => c.dayOfWeek === day).length === 0) {
                Text('无课').fontSize(12).fontColor('#CCCCCC').margin({bottom: 10})
              } else {
                ForEach(this.courses.filter(c => c.dayOfWeek === day), (course: Course) => {
                  Row() {
                    Column() {
                      Text(course.name).fontSize(16).fontColor(Color.White).fontWeight(FontWeight.Medium)
                      Text(`${course.location} | 第${course.period}节`).fontSize(12).fontColor('rgba(255,255,255,0.8)')
                    }.alignItems(HorizontalAlign.Start)
                  }
                  .width('100%')
                  .padding(12)
                  .backgroundColor(course.color)
                  .borderRadius(12)
                  .margin({ bottom: 8 })
                  .shadow({ radius: 3, color: '#20000000', offsetY: 2 })
                  // 长按删除功能
                  .gesture(
                    LongPressGesture().onAction(() => {
                      AlertDialog.show({
                        title: '删除课程',
                        message: `确定要删除 ${course.name} 吗？`,
                        primaryButton: { value: '取消', action: () => {} },
                        secondaryButton: { value: '删除', fontColor: Color.Red, action: () => this.deleteCourse(course.id) }
                      })
                    })
                  )
                })
              }
            }.alignItems(HorizontalAlign.Start).padding({ left: 10, right: 10 }).width('100%')
          }
        })
      }.layoutWeight(1) // 占满剩余空间

      // 悬浮添加按钮
      Button('+')
        .width(60)
        .height(60)
        .fontSize(30)
        .position({ x: '78%', y: '85%' })
        .shadow({radius: 5})
        .onClick(() => {
          this.dialogController.open();
        })
    }.height('100%').backgroundColor('#FAFAFA')
  }
}