<template>
  <div id="app">
    <Header />
    <p>This is the mock info X app. It consumes the header & footer from OPP</p>
    <Footer />
  </div>
</template>

<script>

export default {
  name: "App",
  components: {
    Header: () => import("opp/Header"),
    Footer: () => import("opp/Footer"),
  },
};
</script>

<style lang="scss">
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}
</style>
