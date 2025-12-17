// model/Types.ts

// 课程模型
export interface Course {
  id: number;          // 唯一标识
  name: string;        // 课程名，如“信号与系统”
  location: string;    // 地点，如“教三-301”
  dayOfWeek: number;   // 周几 (1-7)
  period: number;      // 第几节 (1-12)
  color: string;       // 课程背景色，用于UI美化
}

// 作业模型
export interface Assignment {
  id: number;
  courseName: string;  // 关联科目
  content: string;     // 作业内容
  deadline: string;    // 截止日期 (YYYY-MM-DD)
  isFinished: boolean; // 是否完成
}