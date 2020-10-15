// 從package.json文件中獲取到項物名稱和版本號
var packageInfo = require('./package.json');
var zip = packageInfo.name + "_v" + packageInfo.version;
var zipper = require('zip-local'); // 引入插件
var fs = require('fs');
function writeBuildInfo(){
  var buildTime =  new Date().toString();
  fs.writeFileSync('dist/eopen/build.info', 'version=' + packageInfo.version + '\nbuildTime=' + buildTime);
  console.log('寫檔案');
};
writeBuildInfo(); // 寫檔案 build.info
console.log('寫檔案完成');
// 壓縮資料夾成.zip
zipper.sync.zip("dist/eopen").compress().save("dist/package/"+zip + ".zip");
