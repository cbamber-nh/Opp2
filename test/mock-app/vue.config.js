const ModuleFederationPlugin = require("webpack").container
  .ModuleFederationPlugin;

module.exports = {
  publicPath: process.env.VUE_APP_MOCK_API_ROOT || "http://localhost:8082/",
  configureWebpack: {
    plugins: [
      new ModuleFederationPlugin({
        name: "mockApp",
        filename: "remoteEntry.js",
        remotes: {
          opp: process.env.VUE_APP_OPP_REMOTE || "opp@http://localhost:8081/remoteEntry.js",
        },
      }),
    ],
  },
  devServer: {
    port: process.env.PORT || 8082,
  },
};