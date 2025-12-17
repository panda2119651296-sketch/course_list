// pages/Index.ets
import { TimetableComponent } from '../view/TimetableComponent'
import { AssignmentComponent } from '../view/AssignmentComponent'

@Entry
@Component
struct Index {
  @State currentIndex: number = 0;

  build() {
    Tabs({ barPosition: BarPosition.End }) {
      // Tab 1: 课表
      TabContent() {
        TimetableComponent()
      }
      .tabBar('课表')

      // Tab 2: 作业
      TabContent() {
        AssignmentComponent()
      }
      .tabBar('作业待办')
    }
    .onChange((index) => {
      this.currentIndex = index;
    })
  }
}