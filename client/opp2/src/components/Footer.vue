<template>
  <div>
    <div style="height:10px;"></div>
    <FeatherFooter :copyright="copyright">
      <FeatherFooterLink href="#termsofuse" slot="links" @click="log('test')">
        Terms of Use
      </FeatherFooterLink>
      <FeatherFooterLink href="#termsofuse1" slot="links">
        Privacy Policy
      </FeatherFooterLink>
      <FeatherFooterLink href="#termsofuse2" slot="links">
        Notice of Privacy Practices
      </FeatherFooterLink>
    </FeatherFooter>
  </div>
</template>
<script>
import * as components from "@feather/footer";
export default {
  data: () => ({
    copyright:
      "Copyright © ${year} NantHealth, Inc.  All Rights Reserved.  NaviNet® is a registered trademark of NantHealth and its affiliates."
  }),
  methods: {
    log(str) {
      console.log(str);
    }
  },
  components: {
    ...components
  }
};
</script>