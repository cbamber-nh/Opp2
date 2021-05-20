const ModuleFederationPlugin = require("webpack").container
  .ModuleFederationPlugin;

const deps = require("./package.json").dependencies;

module.exports = {
  publicPath: process.env.VUE_APP_API_ROOT || "http://" + process.env.HOST + ":" + process.env.PORT + "/",
  configureWebpack: {
    plugins: [
      new ModuleFederationPlugin({
        name: "opp",
        filename: "remoteEntry.js",
        exposes: {
          "./Header": "./src/components/Header",
          "./Footer": "./src/components/Footer",
        },
      }),
    ],
  },
  devServer: {
    port: process.env.PORT || 8081,
  },
};