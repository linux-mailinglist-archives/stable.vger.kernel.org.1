Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D04E779355
	for <lists+stable@lfdr.de>; Fri, 11 Aug 2023 17:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbjHKPin (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 11 Aug 2023 11:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjHKPin (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 11 Aug 2023 11:38:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2D5127
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 08:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691768322; x=1723304322;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a21IUUMRF8btD1SHvo3z2b2mV15i0jdE4/BK1I911V0=;
  b=XrJ/WsGacFpEy93h5ZUvFnv4kMD4iCSlE/WTwGq+KJ+dFGG8GnMwziPJ
   V1Zlhog8Cuf1oV/G+HrmoL/4qF+gXnAa9/Ld4u+dqfA8vcnciOzEUMabR
   9tpbqr880ltTG0S4XKmchY7ELbQE6EXBXfhUVfawzFSkfwoy7W3iS95Ov
   R+jVbLGnP+Dzd8VAOa21PirQlbtKO5SiwGV1Jdwt2To3sCYpDX/X0hvWp
   e6ynN2SXSy0qGBvtdDoek/yH+Rlt6gGrAHJ1TjFWSYMfZ2FCSZTF9HUB3
   FLLL8ypE4cMqJ8Z4Cp8RTDHpVMSgGjJfL9BYb2oaQPTEuvPhMJg0N/KgR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="402673040"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="402673040"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 08:38:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="682581766"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="682581766"
Received: from ideak-desk.fi.intel.com ([10.237.72.78])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 08:38:40 -0700
From:   Imre Deak <imre.deak@intel.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     stable@vger.kernel.org
Subject: [PATCH] drm/i915/skl+: Disable DC states on DSI ports
Date:   Fri, 11 Aug 2023 18:38:54 +0300
Message-Id: <20230811153854.2211050-1-imre.deak@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

DC*co/5/6 is not supported on DSI ports active in video mode (Bspec
4234, 49193).

On GLK for DSI command mode the "Enter/Exit Low Power Mode" sequence
would need to be programmed around each frame update (Bspec 21356) and
presumedly the same is required on BXT and SKL, even though it's not
stated for those explicitly (BXT: Bspec 13756). The driver doesn't run
these sequences, but command mode on BXT-GLK is not implemented either.

On ICL+ for DSI command mode DC*co/DSI is supported by the HW (Bspec
49195), but this is not implemented in the driver.

Based on the above disable DC states while DSI ports are active.

References: https://gitlab.freedesktop.org/drm/intel/-/issues/8419
Cc: <stable@vger.kernel.org>
Signed-off-by: Imre Deak <imre.deak@intel.com>
---
 drivers/gpu/drm/i915/display/intel_display_power_map.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_display_power_map.c b/drivers/gpu/drm/i915/display/intel_display_power_map.c
index 5ad04cd42c158..1950dae4a7649 100644
--- a/drivers/gpu/drm/i915/display/intel_display_power_map.c
+++ b/drivers/gpu/drm/i915/display/intel_display_power_map.c
@@ -331,6 +331,7 @@ I915_DECL_PW_DOMAINS(skl_pwdoms_pw_2,
 
 I915_DECL_PW_DOMAINS(skl_pwdoms_dc_off,
 	SKL_PW_2_POWER_DOMAINS,
+	POWER_DOMAIN_PORT_DSI,
 	POWER_DOMAIN_AUX_A,
 	POWER_DOMAIN_MODESET,
 	POWER_DOMAIN_GT_IRQ,
@@ -435,6 +436,7 @@ I915_DECL_PW_DOMAINS(bxt_pwdoms_pw_2,
 
 I915_DECL_PW_DOMAINS(bxt_pwdoms_dc_off,
 	BXT_PW_2_POWER_DOMAINS,
+	POWER_DOMAIN_PORT_DSI,
 	POWER_DOMAIN_AUX_A,
 	POWER_DOMAIN_GMBUS,
 	POWER_DOMAIN_MODESET,
@@ -517,6 +519,7 @@ I915_DECL_PW_DOMAINS(glk_pwdoms_pw_2,
 
 I915_DECL_PW_DOMAINS(glk_pwdoms_dc_off,
 	GLK_PW_2_POWER_DOMAINS,
+	POWER_DOMAIN_PORT_DSI,
 	POWER_DOMAIN_AUX_A,
 	POWER_DOMAIN_GMBUS,
 	POWER_DOMAIN_MODESET,
@@ -684,6 +687,7 @@ I915_DECL_PW_DOMAINS(icl_pwdoms_pw_2,
 
 I915_DECL_PW_DOMAINS(icl_pwdoms_dc_off,
 	ICL_PW_2_POWER_DOMAINS,
+	POWER_DOMAIN_PORT_DSI,
 	POWER_DOMAIN_AUX_A,
 	POWER_DOMAIN_MODESET,
 	POWER_DOMAIN_DC_OFF,
@@ -858,6 +862,7 @@ I915_DECL_PW_DOMAINS(tgl_pwdoms_pw_2,
 
 I915_DECL_PW_DOMAINS(tgl_pwdoms_dc_off,
 	TGL_PW_3_POWER_DOMAINS,
+	POWER_DOMAIN_PORT_DSI,
 	POWER_DOMAIN_AUX_A,
 	POWER_DOMAIN_AUX_B,
 	POWER_DOMAIN_AUX_C,
@@ -1056,6 +1061,7 @@ I915_DECL_PW_DOMAINS(rkl_pwdoms_pw_3,
 
 I915_DECL_PW_DOMAINS(rkl_pwdoms_dc_off,
 	RKL_PW_3_POWER_DOMAINS,
+	POWER_DOMAIN_PORT_DSI,
 	POWER_DOMAIN_AUX_A,
 	POWER_DOMAIN_AUX_B,
 	POWER_DOMAIN_MODESET,
@@ -1138,6 +1144,7 @@ I915_DECL_PW_DOMAINS(dg1_pwdoms_pw_3,
 
 I915_DECL_PW_DOMAINS(dg1_pwdoms_dc_off,
 	DG1_PW_3_POWER_DOMAINS,
+	POWER_DOMAIN_PORT_DSI,
 	POWER_DOMAIN_AUDIO_MMIO,
 	POWER_DOMAIN_AUX_A,
 	POWER_DOMAIN_AUX_B,
-- 
2.37.2

