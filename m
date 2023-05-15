Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AB37037C7
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244150AbjEORYK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244085AbjEORXn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:23:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24067E726
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:22:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B541662C7D
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:22:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7355C433D2;
        Mon, 15 May 2023 17:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171335;
        bh=kTlnrCaLLxGhKAuq8vjsHx7R1IrrkD7ASsB9N1wNDLA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CdvjgwMc3IQAweUc/40SgH7JtgBsBWt4PiVxZ01YLVzARkrMt34ZSWm2TTLCuMUA4
         RML8tow9bWyMDpKDWBr3Saz0zsmz7+OBm62N6Uq1VazbkCCjmWjrX3I1SxvmNR/kIL
         DmRQKcPUNEb5+8ENOOAaYY7lElsCXxB8q1Vq0buA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 6.2 177/242] drm/i915/dsi: Use unconditional msleep() instead of intel_dsi_msleep()
Date:   Mon, 15 May 2023 18:28:23 +0200
Message-Id: <20230515161727.187886031@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

commit c8c2969bfcba5fcba3a5b078315c1b586d927d9f upstream.

The intel_dsi_msleep() helper skips sleeping if the MIPI-sequences have
a version of 3 or newer and the panel is in vid-mode.

This is based on the big comment around line 730 which starts with
"Panel enable/disable sequences from the VBT spec.", where
the "v3 video mode seq" column does not have any wait t# entries.

Checking the Windows driver shows that it does always honor
the VBT delays independent of the version of the VBT sequences.

Commit 6fdb335f1c9c ("drm/i915/dsi: Use unconditional msleep for
the panel_on_delay when there is no reset-deassert MIPI-sequence")
switched to a direct msleep() instead of intel_dsi_msleep()
when there is no MIPI_SEQ_DEASSERT_RESET sequence, to fix
the panel on an Acer Aspire Switch 10 E SW3-016 not turning on.

And now testing on a Nextbook Ares 8A shows that panel_on_delay
must always be honored otherwise the panel will not turn on.

Instead of only always using regular msleep() for panel_on_delay
do as Windows does and always use regular msleep() everywhere
were intel_dsi_msleep() is used and drop the intel_dsi_msleep()
helper.

Changes in v2:
- Replace all intel_dsi_msleep() calls instead of just
  the intel_dsi_msleep(panel_on_delay) call

Cc: stable@vger.kernel.org
Fixes: 6fdb335f1c9c ("drm/i915/dsi: Use unconditional msleep for the panel_on_delay when there is no reset-deassert MIPI-sequence")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230425194441.68086-1-hdegoede@redhat.com
(cherry picked from commit fa83c12132f71302f7d4b02758dc0d46048d3f5f)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/display/icl_dsi.c       |    2 +-
 drivers/gpu/drm/i915/display/intel_dsi_vbt.c |   11 -----------
 drivers/gpu/drm/i915/display/intel_dsi_vbt.h |    1 -
 drivers/gpu/drm/i915/display/vlv_dsi.c       |   22 +++++-----------------
 4 files changed, 6 insertions(+), 30 deletions(-)

--- a/drivers/gpu/drm/i915/display/icl_dsi.c
+++ b/drivers/gpu/drm/i915/display/icl_dsi.c
@@ -1211,7 +1211,7 @@ static void gen11_dsi_powerup_panel(stru
 
 	/* panel power on related mipi dsi vbt sequences */
 	intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_POWER_ON);
-	intel_dsi_msleep(intel_dsi, intel_dsi->panel_on_delay);
+	msleep(intel_dsi->panel_on_delay);
 	intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_DEASSERT_RESET);
 	intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_INIT_OTP);
 	intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_DISPLAY_ON);
--- a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
+++ b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
@@ -762,17 +762,6 @@ void intel_dsi_vbt_exec_sequence(struct
 		gpiod_set_value_cansleep(intel_dsi->gpio_backlight, 0);
 }
 
-void intel_dsi_msleep(struct intel_dsi *intel_dsi, int msec)
-{
-	struct intel_connector *connector = intel_dsi->attached_connector;
-
-	/* For v3 VBTs in vid-mode the delays are part of the VBT sequences */
-	if (is_vid_mode(intel_dsi) && connector->panel.vbt.dsi.seq_version >= 3)
-		return;
-
-	msleep(msec);
-}
-
 void intel_dsi_log_params(struct intel_dsi *intel_dsi)
 {
 	struct drm_i915_private *i915 = to_i915(intel_dsi->base.base.dev);
--- a/drivers/gpu/drm/i915/display/intel_dsi_vbt.h
+++ b/drivers/gpu/drm/i915/display/intel_dsi_vbt.h
@@ -16,7 +16,6 @@ void intel_dsi_vbt_gpio_init(struct inte
 void intel_dsi_vbt_gpio_cleanup(struct intel_dsi *intel_dsi);
 void intel_dsi_vbt_exec_sequence(struct intel_dsi *intel_dsi,
 				 enum mipi_seq seq_id);
-void intel_dsi_msleep(struct intel_dsi *intel_dsi, int msec);
 void intel_dsi_log_params(struct intel_dsi *intel_dsi);
 
 #endif /* __INTEL_DSI_VBT_H__ */
--- a/drivers/gpu/drm/i915/display/vlv_dsi.c
+++ b/drivers/gpu/drm/i915/display/vlv_dsi.c
@@ -783,7 +783,6 @@ static void intel_dsi_pre_enable(struct
 {
 	struct intel_dsi *intel_dsi = enc_to_intel_dsi(encoder);
 	struct intel_crtc *crtc = to_intel_crtc(pipe_config->uapi.crtc);
-	struct intel_connector *connector = to_intel_connector(conn_state->connector);
 	struct drm_i915_private *dev_priv = to_i915(crtc->base.dev);
 	enum pipe pipe = crtc->pipe;
 	enum port port;
@@ -831,21 +830,10 @@ static void intel_dsi_pre_enable(struct
 	if (!IS_GEMINILAKE(dev_priv))
 		intel_dsi_prepare(encoder, pipe_config);
 
+	/* Give the panel time to power-on and then deassert its reset */
 	intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_POWER_ON);
-
-	/*
-	 * Give the panel time to power-on and then deassert its reset.
-	 * Depending on the VBT MIPI sequences version the deassert-seq
-	 * may contain the necessary delay, intel_dsi_msleep() will skip
-	 * the delay in that case. If there is no deassert-seq, then an
-	 * unconditional msleep is used to give the panel time to power-on.
-	 */
-	if (connector->panel.vbt.dsi.sequence[MIPI_SEQ_DEASSERT_RESET]) {
-		intel_dsi_msleep(intel_dsi, intel_dsi->panel_on_delay);
-		intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_DEASSERT_RESET);
-	} else {
-		msleep(intel_dsi->panel_on_delay);
-	}
+	msleep(intel_dsi->panel_on_delay);
+	intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_DEASSERT_RESET);
 
 	if (IS_GEMINILAKE(dev_priv)) {
 		glk_cold_boot = glk_dsi_enable_io(encoder);
@@ -879,7 +867,7 @@ static void intel_dsi_pre_enable(struct
 		msleep(20); /* XXX */
 		for_each_dsi_port(port, intel_dsi->ports)
 			dpi_send_cmd(intel_dsi, TURN_ON, false, port);
-		intel_dsi_msleep(intel_dsi, 100);
+		msleep(100);
 
 		intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_DISPLAY_ON);
 
@@ -1007,7 +995,7 @@ static void intel_dsi_post_disable(struc
 	/* Assert reset */
 	intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_ASSERT_RESET);
 
-	intel_dsi_msleep(intel_dsi, intel_dsi->panel_off_delay);
+	msleep(intel_dsi->panel_off_delay);
 	intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_POWER_OFF);
 
 	intel_dsi->panel_power_off_time = ktime_get_boottime();


