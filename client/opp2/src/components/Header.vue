<template>
  <section>
    <FeatherAppBar :labels="labels" :content="content" class="demo-app-bar">
      <FeatherAppBarLink
        :icon="icon"
        title="Home"
        type="home"
        url="./FeatherAppBar.html"
        slot="left"
      />
      <FeatherAppBarLink
        :icon="support"
        title="Support"
        url="./FeatherAppBar.html"
        slot="right"
      />
    </FeatherAppBar>
  </section>
</template>
<script>
import { FeatherAppBar, FeatherAppBarLink } from "@feather/app-bar";
import NaviNetIcon from "@feather/icon/products/NantHealthPartnerPortal";
import Support from "@feather/icon/actions/Help";
export default {
  data() {
    return {
      labels: {
        skip: "Skip to main content"
      },
      content: "test",
      icon: NaviNetIcon,
      support: Support
    };
  },
  components: {
    FeatherAppBar,
    FeatherAppBarLink
  }
};
</script>
<style lang="scss" scoped>
.demo-app-bar {
  position: absolute !important;
  ::v-deep {
    header {
      position: absolute !important;
      z-index: 1 !important;
    }
  }
}
section {
  height: 200px;
  position: relative;
}
#test {
  height: 300px;
}
</style>