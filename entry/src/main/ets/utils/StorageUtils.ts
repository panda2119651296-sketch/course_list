import preferences from '@ohos.data.preferences';
import common from '@ohos.app.ability.common';

const PREF_NAME = 'CampusHelperPref';

export class StorageUtils {

  // 获取Preferences实例
  static async getPref(context: common.UIAbilityContext) {
    return await preferences.getPreferences(context, PREF_NAME);
  }

  // 保存数据 (通用方法)
  static async putData(context: common.UIAbilityContext, key: string, value: string) {
    const pref = await this.getPref(context);
    await pref.put(key, value);
    await pref.flush(); // 必须flush才能写入磁盘
  }

  // 读取数据
  static async getData(context: common.UIAbilityContext, key: string): Promise<string> {
    const pref = await this.getPref(context);
    // 默认返回空数组的JSON字符串
    return await pref.get(key, '[]') as string;
  }
}