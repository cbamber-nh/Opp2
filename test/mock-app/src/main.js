import Vue from "vue";
import App from "./App.vue";
import "@feather/styles";
import "@feather/styles/themes/eviti-light.css";

Vue.config.productionTip = false;

new Vue({
  render: (h) => h(App),
}).$mount("#app");
