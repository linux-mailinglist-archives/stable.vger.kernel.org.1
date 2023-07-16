Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD4375571E
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbjGPU5Y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbjGPU5V (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:57:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE29610D
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:57:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BB0660E2C
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61558C433C7;
        Sun, 16 Jul 2023 20:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689541038;
        bh=P15VSta9DNdg0oWc+YHAg1KZyuuW0SANQGGtiNra8Yg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RLRNAt3MwYGubPyklgD5DVXhv8Wu4f12WUU3wykO1GELL2pofs+BaA/iv/G3OUq27
         qX0s7mOS0lOD7NjOjePSlMc6S7l+2hhSKSBGajDD9ulXoJ9qU7jpvSsQQUU0EdxMRH
         5uVGIY+K2D5gcCpJDMpqwxmi0IJGpPOaZb2BsiuI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Imre Deak <imre.deak@intel.com>,
        Mika Kahola <mika.kahola@intel.com>
Subject: [PATCH 6.1 577/591] drm/i915: Fix TypeC mode initialization during system resume
Date:   Sun, 16 Jul 2023 21:51:56 +0200
Message-ID: <20230716194938.787379484@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Imre Deak <imre.deak@intel.com>

commit a82796a2e332d108b2d3aff38509caad370f69b5 upstream.

During system resume DP MST requires AUX to be working already before
the HW state readout of the given encoder. Since AUX requires the
encoder/PHY TypeC mode to be initialized, which atm only happens during
HW state readout, these AUX transfers can change the TypeC mode
incorrectly (disconnecting the PHY for an enabled encoder) and trigger
the state check WARNs in intel_tc_port_sanitize().

Fix this by initializing the TypeC mode earlier both during driver
loading and system resume and making sure that the mode can't change
until the encoder's state is read out. While at it add the missing
DocBook comments and rename
intel_tc_port_sanitize()->intel_tc_port_sanitize_mode() for consistency.

Signed-off-by: Imre Deak <imre.deak@intel.com>
Reviewed-by: Mika Kahola <mika.kahola@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20220922172148.2913088-1-imre.deak@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/display/intel_ddi.c |    8 +++
 drivers/gpu/drm/i915/display/intel_tc.c  |   66 +++++++++++++++++++++++--------
 drivers/gpu/drm/i915/display/intel_tc.h  |    3 -
 3 files changed, 60 insertions(+), 17 deletions(-)

--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -3579,7 +3579,7 @@ static void intel_ddi_sync_state(struct
 	enum phy phy = intel_port_to_phy(i915, encoder->port);
 
 	if (intel_phy_is_tc(i915, phy))
-		intel_tc_port_sanitize(enc_to_dig_port(encoder));
+		intel_tc_port_sanitize_mode(enc_to_dig_port(encoder));
 
 	if (crtc_state && intel_crtc_has_dp_encoder(crtc_state))
 		intel_dp_sync_state(encoder, crtc_state);
@@ -3789,11 +3789,17 @@ static void intel_ddi_encoder_destroy(st
 
 static void intel_ddi_encoder_reset(struct drm_encoder *encoder)
 {
+	struct drm_i915_private *i915 = to_i915(encoder->dev);
 	struct intel_dp *intel_dp = enc_to_intel_dp(to_intel_encoder(encoder));
+	struct intel_digital_port *dig_port = enc_to_dig_port(to_intel_encoder(encoder));
+	enum phy phy = intel_port_to_phy(i915, dig_port->base.port);
 
 	intel_dp->reset_link_params = true;
 
 	intel_pps_encoder_reset(intel_dp);
+
+	if (intel_phy_is_tc(i915, phy))
+		intel_tc_port_init_mode(dig_port);
 }
 
 static const struct drm_encoder_funcs intel_ddi_funcs = {
--- a/drivers/gpu/drm/i915/display/intel_tc.c
+++ b/drivers/gpu/drm/i915/display/intel_tc.c
@@ -687,18 +687,58 @@ static void
 intel_tc_port_link_init_refcount(struct intel_digital_port *dig_port,
 				 int refcount)
 {
+	dig_port->tc_link_refcount = refcount;
+}
+
+/**
+ * intel_tc_port_init_mode: Read out HW state and init the given port's TypeC mode
+ * @dig_port: digital port
+ *
+ * Read out the HW state and initialize the TypeC mode of @dig_port. The mode
+ * will be locked until intel_tc_port_sanitize_mode() is called.
+ */
+void intel_tc_port_init_mode(struct intel_digital_port *dig_port)
+{
 	struct drm_i915_private *i915 = to_i915(dig_port->base.base.dev);
+	intel_wakeref_t tc_cold_wref;
+	enum intel_display_power_domain domain;
 
+	mutex_lock(&dig_port->tc_lock);
+
+	drm_WARN_ON(&i915->drm, dig_port->tc_mode != TC_PORT_DISCONNECTED);
+	drm_WARN_ON(&i915->drm, dig_port->tc_lock_wakeref);
 	drm_WARN_ON(&i915->drm, dig_port->tc_link_refcount);
-	dig_port->tc_link_refcount = refcount;
+
+	tc_cold_wref = tc_cold_block(dig_port, &domain);
+
+	dig_port->tc_mode = intel_tc_port_get_current_mode(dig_port);
+	/* Prevent changing dig_port->tc_mode until intel_tc_port_sanitize_mode() is called. */
+	intel_tc_port_link_init_refcount(dig_port, 1);
+	dig_port->tc_lock_wakeref = tc_cold_block(dig_port, &dig_port->tc_lock_power_domain);
+
+	tc_cold_unblock(dig_port, domain, tc_cold_wref);
+
+	drm_dbg_kms(&i915->drm, "Port %s: init mode (%s)\n",
+		    dig_port->tc_port_name,
+		    tc_port_mode_name(dig_port->tc_mode));
+
+	mutex_unlock(&dig_port->tc_lock);
 }
 
-void intel_tc_port_sanitize(struct intel_digital_port *dig_port)
+/**
+ * intel_tc_port_sanitize_mode: Sanitize the given port's TypeC mode
+ * @dig_port: digital port
+ *
+ * Sanitize @dig_port's TypeC mode wrt. the encoder's state right after driver
+ * loading and system resume:
+ * If the encoder is enabled keep the TypeC mode/PHY connected state locked until
+ * the encoder is disabled.
+ * If the encoder is disabled make sure the PHY is disconnected.
+ */
+void intel_tc_port_sanitize_mode(struct intel_digital_port *dig_port)
 {
 	struct drm_i915_private *i915 = to_i915(dig_port->base.base.dev);
 	struct intel_encoder *encoder = &dig_port->base;
-	intel_wakeref_t tc_cold_wref;
-	enum intel_display_power_domain domain;
 	int active_links = 0;
 
 	mutex_lock(&dig_port->tc_lock);
@@ -708,21 +748,14 @@ void intel_tc_port_sanitize(struct intel
 	else if (encoder->base.crtc)
 		active_links = to_intel_crtc(encoder->base.crtc)->active;
 
-	drm_WARN_ON(&i915->drm, dig_port->tc_mode != TC_PORT_DISCONNECTED);
-	drm_WARN_ON(&i915->drm, dig_port->tc_lock_wakeref);
+	drm_WARN_ON(&i915->drm, dig_port->tc_link_refcount != 1);
+	intel_tc_port_link_init_refcount(dig_port, active_links);
 
-	tc_cold_wref = tc_cold_block(dig_port, &domain);
-
-	dig_port->tc_mode = intel_tc_port_get_current_mode(dig_port);
 	if (active_links) {
 		if (!icl_tc_phy_is_connected(dig_port))
 			drm_dbg_kms(&i915->drm,
 				    "Port %s: PHY disconnected with %d active link(s)\n",
 				    dig_port->tc_port_name, active_links);
-		intel_tc_port_link_init_refcount(dig_port, active_links);
-
-		dig_port->tc_lock_wakeref = tc_cold_block(dig_port,
-							  &dig_port->tc_lock_power_domain);
 	} else {
 		/*
 		 * TBT-alt is the default mode in any case the PHY ownership is not
@@ -736,9 +769,10 @@ void intel_tc_port_sanitize(struct intel
 				    dig_port->tc_port_name,
 				    tc_port_mode_name(dig_port->tc_mode));
 		icl_tc_phy_disconnect(dig_port);
-	}
 
-	tc_cold_unblock(dig_port, domain, tc_cold_wref);
+		tc_cold_unblock(dig_port, dig_port->tc_lock_power_domain,
+				fetch_and_zero(&dig_port->tc_lock_wakeref));
+	}
 
 	drm_dbg_kms(&i915->drm, "Port %s: sanitize mode (%s)\n",
 		    dig_port->tc_port_name,
@@ -923,4 +957,6 @@ void intel_tc_port_init(struct intel_dig
 	dig_port->tc_mode = TC_PORT_DISCONNECTED;
 	dig_port->tc_link_refcount = 0;
 	tc_port_load_fia_params(i915, dig_port);
+
+	intel_tc_port_init_mode(dig_port);
 }
--- a/drivers/gpu/drm/i915/display/intel_tc.h
+++ b/drivers/gpu/drm/i915/display/intel_tc.h
@@ -24,7 +24,8 @@ int intel_tc_port_fia_max_lane_count(str
 void intel_tc_port_set_fia_lane_count(struct intel_digital_port *dig_port,
 				      int required_lanes);
 
-void intel_tc_port_sanitize(struct intel_digital_port *dig_port);
+void intel_tc_port_init_mode(struct intel_digital_port *dig_port);
+void intel_tc_port_sanitize_mode(struct intel_digital_port *dig_port);
 void intel_tc_port_lock(struct intel_digital_port *dig_port);
 void intel_tc_port_unlock(struct intel_digital_port *dig_port);
 void intel_tc_port_flush_work(struct intel_digital_port *dig_port);


