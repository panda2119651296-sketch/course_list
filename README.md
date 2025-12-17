🎓 CampusMate - 你的校园生活管家 (OpenHarmony版)
一款轻量、高颜值的大学生课程与作业管理助手

A Minimalist Campus Assistant built with ArkTS & ArkUI.

📖 项目简介 (Introduction)
CampusMate 是一款基于 OpenHarmony (HarmonyOS) 原生开发的效率工具。

我发现市面上的课表应用往往功能过于臃肿或广告繁多。因此，我利用 ArkTS 和声明式 UI 开发了这款应用，旨在为大学生提供一个纯净、本地化、高颜值的日程管理方案。

它没有复杂的多余功能，只专注于两件事：“今天上什么课” 和 “作业什么时候交”。

✨ 核心亮点 (Highlights)
1. 🎨 极简美学设计
沉浸式课表：抛弃传统刻板的表格线，采用卡片式布局。

莫兰迪配色 (Morandi Colors)：内置算法自动为新课程分配低饱和度的高级配色，视觉舒适，久看不累。

2. ⚡️ 高效交互体验
智能待办：作业列表按 DDL (截止日期) 自动排序，紧迫任务一目了然。

原生手势：

左滑删除 (Swipe Action)：参考原生应用交互，左滑作业卡片即可快速清理。

长按管理：长按课程卡片呼出二级菜单，防止误触。

3. 🔒 纯净本地存储
隐私优先：使用 Preferences 首选项技术。

离线可用：所有数据均存储于设备本地，无需联网，重启设备数据不丢失，完全由用户掌控。

🛠️ 技术架构 (Tech Stack)
本项目采用了标准的 MVVM 分层思想，代码结构清晰

核心语言: ArkTS (TypeScript Extended)

UI 框架: ArkUI 

开发工具: DevEco Studio

📂 目录结构 (Directory Structure)

entry/src/main/ets

├── model                  // [数据模型层] 

│   └── Types.ts           // 定义 Course(课程) 和 Assignment(作业) 数据结构

├── view                   // [UI组件层] 模块化设计

│   ├── TimetableComponent.ets  // 课表组件 (含自定义弹窗 CustomDialog)

│   └── AssignmentComponent.ets // 待办组件 (含 List 侧滑操作)

├── utils                  // [工具类]

│   └── StorageUtils.ts    // 封装数据存取逻辑，实现业务与存储解耦

├── pages                  // [页面层]

│   └── Index.ets          // 应用主入口，管理 Tabs 切换

└── entryability           // [系统入口]
    └── EntryAbility.ts    // 生命周期管理



📸 界面预览 (Screenshots)
  
   <img width="526" height="926" alt="image" src="https://github.com/user-attachments/assets/40372712-5131-4035-b757-77337412ec5b" />
    <img width="513" height="924" alt="image" src="https://github.com/user-attachments/assets/1222f60b-c281-476c-8041-e14dd4df66df" />


🤝 贡献与反馈 (Contribution)

欢迎提交 Issue 或 Pull Request！

如果你觉得这个项目对你有帮助，请给我一颗星星 ⭐️。

Built with ❤️ using ArkTS
