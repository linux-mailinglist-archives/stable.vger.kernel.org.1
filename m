Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB0574D8B3
	for <lists+stable@lfdr.de>; Mon, 10 Jul 2023 16:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjGJOOH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 10 Jul 2023 10:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjGJOOG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 10 Jul 2023 10:14:06 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F6BAD
        for <stable@vger.kernel.org>; Mon, 10 Jul 2023 07:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688998445; x=1720534445;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KpjvDg0uJU0e9GCxK/5yktW4NfSsuZ6Lg8FWv3BC+sU=;
  b=md9xi7LT5UUH5s8y9TpEMd/LRVp5cNFDsh8OjPxR2ukFynzx7HZdoPEP
   EQ66wCmspT+Ypn9aOePv7cWTw0YzoTpbWyyszDmvPYxKSPCX2fGAJeSLP
   o89nurKgpyQna2qLH8nGcqTvEBLYYsJCDpObcbZTHbBeuzK+VsHqhU+LV
   U3oZ0K2D/O9Skbs4vmPq9+a6kdujQ+HrI78zCmF/GLTg1YIcqTdU/sY+Q
   IDqGmI0PpkCJOHoBDMBwahJ8/vrNVpxxiHunwKfT+I5p7Ma+kdLyjKeop
   3p2sF5l1Usrzd+qNyLpsmVjsvWDQMUX1BdjBNW6RfrlQLkJmyI8PkR73I
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="366927456"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="366927456"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 07:14:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="834291303"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="834291303"
Received: from unknown (HELO ideak-desk.fi.intel.com) ([10.237.72.78])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 07:14:03 -0700
From:   Imre Deak <imre.deak@intel.com>
To:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     intel-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/i915/tc: Fix system resume MST mode restore for DP-alt sinks
Date:   Mon, 10 Jul 2023 17:13:59 +0300
Message-Id: <20230710141359.754365-2-imre.deak@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230710141359.754365-1-imre.deak@intel.com>
References: <20230710141359.754365-1-imre.deak@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

commit 06f66261a1567d66b9d35c87393b6edfbea4c8f8 upstream.

At least restoring the MST topology during system resume needs to use
AUX before the display HW readout->sanitization sequence is complete,
but on TC ports the PHY may be in the wrong mode for this, resulting in
the AUX transfers to fail.

The initial TC port mode is kept fixed as BIOS left it for the above HW
readout sequence (to prevent changing the mode on an enabled port).  If
the port is disabled this initial mode is TBT - as in any case the PHY
ownership is not held - even if a DP-alt sink is connected. Thus, the
AUX transfers during this time will use TBT mode instead of the expected
DP-alt mode and so time out.

Fix the above by connecting the PHY during port initialization if the
port is disabled, which will switch to the expected mode (DP-alt in the
above case).

As the encoder/pipe HW state isn't read-out yet at this point, check if
the port is enabled based on the DDI_BUF enabled flag. Save the read-out
initial mode, so intel_tc_port_sanitize_mode() can check this wrt. the
read-out encoder HW state.

Signed-off-by: Imre Deak <imre.deak@intel.com>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230316131724.359612-5-imre.deak@intel.com
[For stable include intel_de.h for intel_de_read() (Imre)]
References: https://gitlab.freedesktop.org/drm/intel/-/issues/4306#note_1832688
Cc: <stable@vger.kernel.org> # 6.1.x: a82796a2e332: Fix TypeC mode initialization
Cc: <stable@vger.kernel.org> # 6.1.x: 67165722c27c: Fix TC port link ref init
---
 .../drm/i915/display/intel_display_types.h    |  1 +
 drivers/gpu/drm/i915/display/intel_tc.c       | 51 +++++++++++++++++--
 2 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index 63b7105e818a6..a8bf91a21cb24 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -1763,6 +1763,7 @@ struct intel_digital_port {
 	bool tc_legacy_port:1;
 	char tc_port_name[8];
 	enum tc_port_mode tc_mode;
+	enum tc_port_mode tc_init_mode;
 	enum phy_fia tc_phy_fia;
 	u8 tc_phy_fia_idx;
 
diff --git a/drivers/gpu/drm/i915/display/intel_tc.c b/drivers/gpu/drm/i915/display/intel_tc.c
index f50c92ca0dff8..bda77828dc95f 100644
--- a/drivers/gpu/drm/i915/display/intel_tc.c
+++ b/drivers/gpu/drm/i915/display/intel_tc.c
@@ -5,6 +5,7 @@
 
 #include "i915_drv.h"
 #include "i915_reg.h"
+#include "intel_de.h"
 #include "intel_display.h"
 #include "intel_display_power_map.h"
 #include "intel_display_types.h"
@@ -116,6 +117,24 @@ assert_tc_cold_blocked(struct intel_digital_port *dig_port)
 	drm_WARN_ON(&i915->drm, !enabled);
 }
 
+static enum intel_display_power_domain
+tc_port_power_domain(struct intel_digital_port *dig_port)
+{
+	struct drm_i915_private *i915 = to_i915(dig_port->base.base.dev);
+	enum tc_port tc_port = intel_port_to_tc(i915, dig_port->base.port);
+
+	return POWER_DOMAIN_PORT_DDI_LANES_TC1 + tc_port - TC_PORT_1;
+}
+
+static void
+assert_tc_port_power_enabled(struct intel_digital_port *dig_port)
+{
+	struct drm_i915_private *i915 = to_i915(dig_port->base.base.dev);
+
+	drm_WARN_ON(&i915->drm,
+		    !intel_display_power_is_enabled(i915, tc_port_power_domain(dig_port)));
+}
+
 u32 intel_tc_port_get_lane_mask(struct intel_digital_port *dig_port)
 {
 	struct drm_i915_private *i915 = to_i915(dig_port->base.base.dev);
@@ -693,6 +712,16 @@ static void __intel_tc_port_put_link(struct intel_digital_port *dig_port)
 	dig_port->tc_link_refcount--;
 }
 
+static bool tc_port_is_enabled(struct intel_digital_port *dig_port)
+{
+	struct drm_i915_private *i915 = to_i915(dig_port->base.base.dev);
+
+	assert_tc_port_power_enabled(dig_port);
+
+	return intel_de_read(i915, DDI_BUF_CTL(dig_port->base.port)) &
+	       DDI_BUF_CTL_ENABLE;
+}
+
 /**
  * intel_tc_port_init_mode: Read out HW state and init the given port's TypeC mode
  * @dig_port: digital port
@@ -715,10 +744,24 @@ void intel_tc_port_init_mode(struct intel_digital_port *dig_port)
 	tc_cold_wref = tc_cold_block(dig_port, &domain);
 
 	dig_port->tc_mode = intel_tc_port_get_current_mode(dig_port);
-	/* Prevent changing dig_port->tc_mode until intel_tc_port_sanitize_mode() is called. */
-	__intel_tc_port_get_link(dig_port);
+	/*
+	 * Save the initial mode for the state check in
+	 * intel_tc_port_sanitize_mode().
+	 */
+	dig_port->tc_init_mode = dig_port->tc_mode;
 	dig_port->tc_lock_wakeref = tc_cold_block(dig_port, &dig_port->tc_lock_power_domain);
 
+	/*
+	 * The PHY needs to be connected for AUX to work during HW readout and
+	 * MST topology resume, but the PHY mode can only be changed if the
+	 * port is disabled.
+	 */
+	if (!tc_port_is_enabled(dig_port))
+		intel_tc_port_update_mode(dig_port, 1, false);
+
+	/* Prevent changing dig_port->tc_mode until intel_tc_port_sanitize_mode() is called. */
+	__intel_tc_port_get_link(dig_port);
+
 	tc_cold_unblock(dig_port, domain, tc_cold_wref);
 
 	drm_dbg_kms(&i915->drm, "Port %s: init mode (%s)\n",
@@ -764,11 +807,11 @@ void intel_tc_port_sanitize_mode(struct intel_digital_port *dig_port)
 		 * we'll just switch to disconnected mode from it here without
 		 * a note.
 		 */
-		if (dig_port->tc_mode != TC_PORT_TBT_ALT)
+		if (dig_port->tc_init_mode != TC_PORT_TBT_ALT)
 			drm_dbg_kms(&i915->drm,
 				    "Port %s: PHY left in %s mode on disabled port, disconnecting it\n",
 				    dig_port->tc_port_name,
-				    tc_port_mode_name(dig_port->tc_mode));
+				    tc_port_mode_name(dig_port->tc_init_mode));
 		icl_tc_phy_disconnect(dig_port);
 		__intel_tc_port_put_link(dig_port);
 
-- 
2.37.2

