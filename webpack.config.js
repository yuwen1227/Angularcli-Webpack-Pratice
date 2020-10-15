const path = require('path');
const {
  CleanWebpackPlugin
} = require('clean-webpack-plugin');
const CopyPlugin = require('copy-webpack-plugin');
var packageInfo = require('./package.json');

// 從package.json文件中獲取到項物名稱和版本號
var packageInfo = require('./package.json');
var zip = packageInfo.name + "_v" + packageInfo.version;
var zipper = require('zip-local'); // 引入插件

var fs = require('fs');

// function writeBuildInfo() {
//   var buildTime = new Date().toString();
//   fs.writeFileSync('dist/eopen/build.info', 'version=' + packageInfo.version + '\nbuildTime=' + buildTime);
//   console.log('寫檔案');
// };
// writeBuildInfo(); // 寫檔案 build.info

//讓webpack可以上文件到ftp server上
// var SftpWebpackPlugin = require('sftp-webpack-plugin');

module.exports = (config, options) => {
  config.plugins.push(
    new CleanWebpackPlugin(path),
    new CopyPlugin({
      patterns: [{
          from: './docs',
          to: './../package/[name]_v' + packageInfo.version + '.[ext]'
        },
        {
          from: './install_shell',
          to: './../package/'
        }
      ],
    }),
    // new class MyZipWebpackPlugin {
    //   apply(compiler) {
    //     compiler.hooks.emit.tapAsync(
    //       'MyZipWebpackPlugin',
    //       (compilation, callback) => {
    //         zipper.sync.zip("dist/eopen").compress().save("dist/package/" + zip + ".zip");
    //         callback();
    //         console.log('This is an example plugin!');
    //       }
    //     );
    //   }
    // },
    // new SftpWebpackPlugin({
    //   port: '',
    //   host: '',
    //   username: '',
    //   password: '',
    //   from: '',
    //   to: ''
    // })
  )
  return config;
};
