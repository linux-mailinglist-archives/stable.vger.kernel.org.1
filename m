Return-Path: <stable+bounces-16151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C79A783F101
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52AD41F214D6
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 22:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C401E537;
	Sat, 27 Jan 2024 22:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KQeQQNxU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF0B18E07
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 22:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706395269; cv=none; b=TdBPGfImns1VxpC7Zmyp8EzJrjlrJozrMdaapjiMbXxDGz9LYv/RClOGfUcs0x8A8KOxpFrcS+q4jYUv/y5hUQpd2nPFMr+4gha2+7cc0H43QEP1S6pRKUqJ/WoPEdoOwmgiwX6jYoibOTQ5jW0gqxe+ih+G4yzoG1Zx1Bvpq/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706395269; c=relaxed/simple;
	bh=JhWTAAPeIZXpSvPEgG87rg3XbEm+frcsJE0fOTTnXDI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KOaf8bZaO2Po3lsr1NUIqhPbwsPzRjAcD+I2ed8XVFBDQ03jNMypxNc119Lc9I+dZZGWQKEKE4CZ2Vh3gtRF7tY6j4pxuO6KSCuEmldBIuKBhEGcW1m8CSUbg9FBFecHUmLO295WNRVXJS9jko5xn60gPiAcPVsVXvzPAXwobXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KQeQQNxU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F04C43390;
	Sat, 27 Jan 2024 22:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706395268;
	bh=JhWTAAPeIZXpSvPEgG87rg3XbEm+frcsJE0fOTTnXDI=;
	h=Subject:To:Cc:From:Date:From;
	b=KQeQQNxUaE3DErySlrIcW8CMMJwPb0uzFgWbxltDa7HM3155EIMiltKGe5i0lSuL/
	 fOcw/8x2laEAiwmABoSy5oZsj0HSJr/FwiIdwii34jGMi/jo1VXLFszf7WNXerXnGd
	 GL5ZDQLjA/XsitKf88UlJLVswyHar/KlCoyD5HlA=
Subject: FAILED: patch "[PATCH] drm/amd/display: Simplify brightness initialization" failed to apply to 6.1-stable tree
To: camille.cho@amd.com,alexander.deucher@amd.com,hamza.mahfooz@amd.com,krunoslav.kovac@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 14:41:07 -0800
Message-ID: <2024012707-snowfield-level-6562@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 43b8ac4b34ec239bccf4a692c1227ef51a95a4d2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012707-snowfield-level-6562@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

43b8ac4b34ec ("drm/amd/display: Simplify brightness initialization")
5edb7cdff85a ("drm/amd/display: Reduce default backlight min from 5 nits to 1 nits")
6ec876472ff7 ("drm/amd/display: refactor ILR to make it work")
2ad127ba4c6e ("drm/amd/display: Cache backlight_millinits in link structure and setting brightness accordingly")
98ce7d32e215 ("drm/amd/display: convert link.h functions to function pointer style")
22f1482aff4a ("drm/amd/display: add sysfs entry to read PSR residency from firmware")
788c6e2ce5c7 ("drm/amd/display: replace all dc_link function call in link with link functions")
202a3816f37e ("drm/amd/display: move dc_link functions in protocols folder to dc_link_exports")
6455cb522191 ("drm/amd/display: link link_dp_dpia_bw.o in makefile")
76f5dc40ebb1 ("drm/amd/display: move dc_link functions in link root folder to dc_link_exports")
36516001a7c9 ("drm/amd/display: move dc_link functions in accessories folder to dc_link_exports")
1e88eb1b2c25 ("drm/amd/display: Drop CONFIG_DRM_AMD_DC_HDCP")
aee0c07a74d3 ("drm/amd/display: Unify DC logging for BW Alloc")
7ae1dbe6547c ("drm/amd/display: merge dc_link.h into dc.h and dc_types.h")
1099238b966e ("drm/amd/display: Update BW ALLOCATION Function declaration")
a06d565b4a1c ("drm/amd/display: Allocation at stream Enable")
c32699caeca8 ("drm/amd/display: Updating Video Format Fall Back Policy.")
c69fc3d0de6c ("drm/amd/display: Reduce CPU busy-waiting for long delays")
455ad25997ba ("drm/amdgpu: Select DRM_DISPLAY_HDCP_HELPER in amdgpu")
8e5cfe547bf3 ("drm/amd/display: upstream link_dp_dpia_bw.c")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 43b8ac4b34ec239bccf4a692c1227ef51a95a4d2 Mon Sep 17 00:00:00 2001
From: Camille Cho <camille.cho@amd.com>
Date: Fri, 3 Nov 2023 12:08:42 +0800
Subject: [PATCH] drm/amd/display: Simplify brightness initialization

[Why]
Remove the brightness cache in DC. It uses a single value to represent
the brightness for both SDR and HDR mode. This leads to flash in HDR
on/off. It also unconditionally programs brightness as in HDR mode. This
may introduce garbage on SDR mode in miniLED panel.

[How]
Simplify the initialization flow by removing the DC cache and taking
what panel has as default. Expand the mechanism for PWM to DPCD Aux to
restore cached brightness value generally.

Cc: stable@vger.kernel.org # 6.1+
Reviewed-by: Krunoslav Kovac <krunoslav.kovac@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Camille Cho <camille.cho@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 349629858205..18b8d7f3f738 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1610,7 +1610,6 @@ struct dc_link {
 	enum edp_revision edp_revision;
 	union dpcd_sink_ext_caps dpcd_sink_ext_caps;
 
-	struct backlight_settings backlight_settings;
 	struct psr_settings psr_settings;
 
 	struct replay_settings replay_settings;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 4a60d2c47686..a2f6c994a2a9 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -991,10 +991,6 @@ struct link_mst_stream_allocation_table {
 	struct link_mst_stream_allocation stream_allocations[MAX_CONTROLLER_NUM];
 };
 
-struct backlight_settings {
-	uint32_t backlight_millinits;
-};
-
 /* PSR feature flags */
 struct psr_settings {
 	bool psr_feature_enabled;		// PSR is supported by sink
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index f2fe523f914f..24153b0df503 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -879,7 +879,7 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 			(link->dpcd_sink_ext_caps.bits.oled == 1)) {
 			dpcd_set_source_specific_data(link);
 			msleep(post_oui_delay);
-			set_cached_brightness_aux(link);
+			set_default_brightness_aux(link);
 		}
 
 		return true;
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 34a4a8c0e18c..f8e01ca09d96 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2142,8 +2142,7 @@ static enum dc_status enable_link_dp(struct dc_state *state,
 	if (link->dpcd_sink_ext_caps.bits.oled == 1 ||
 		link->dpcd_sink_ext_caps.bits.sdr_aux_backlight_control == 1 ||
 		link->dpcd_sink_ext_caps.bits.hdr_aux_backlight_control == 1) {
-		set_cached_brightness_aux(link);
-
+		set_default_brightness_aux(link);
 		if (link->dpcd_sink_ext_caps.bits.oled == 1)
 			msleep(bl_oled_enable_delay);
 		edp_backlight_enable_aux(link, true);
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index fdeb8dff5485..ac0fa88b52a0 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -170,7 +170,6 @@ bool edp_set_backlight_level_nits(struct dc_link *link,
 	*(uint32_t *)&dpcd_backlight_set.backlight_level_millinits = backlight_millinits;
 	*(uint16_t *)&dpcd_backlight_set.backlight_transition_time_ms = (uint16_t)transition_time_in_ms;
 
-	link->backlight_settings.backlight_millinits = backlight_millinits;
 
 	if (!link->dpcd_caps.panel_luminance_control) {
 		if (core_link_write_dpcd(link, DP_SOURCE_BACKLIGHT_LEVEL,
@@ -288,9 +287,9 @@ bool set_default_brightness_aux(struct dc_link *link)
 	if (link && link->dpcd_sink_ext_caps.bits.oled == 1) {
 		if (!read_default_bl_aux(link, &default_backlight))
 			default_backlight = 150000;
-		// if < 1 nits or > 5000, it might be wrong readback
-		if (default_backlight < 1000 || default_backlight > 5000000)
-			default_backlight = 150000; //
+		// if > 5000, it might be wrong readback
+		if (default_backlight > 5000000)
+			default_backlight = 150000;
 
 		return edp_set_backlight_level_nits(link, true,
 				default_backlight, 0);
@@ -298,15 +297,6 @@ bool set_default_brightness_aux(struct dc_link *link)
 	return false;
 }
 
-bool set_cached_brightness_aux(struct dc_link *link)
-{
-	if (link->backlight_settings.backlight_millinits)
-		return edp_set_backlight_level_nits(link, true,
-						    link->backlight_settings.backlight_millinits, 0);
-	else
-		return set_default_brightness_aux(link);
-	return false;
-}
 bool edp_is_ilr_optimization_enabled(struct dc_link *link)
 {
 	if (link->dpcd_caps.edp_supported_link_rates_count == 0 || !link->panel_config.ilr.optimize_edp_link_rate)
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
index 39526bd40178..b7493ff4fcee 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
@@ -30,7 +30,6 @@
 enum dp_panel_mode dp_get_panel_mode(struct dc_link *link);
 void dp_set_panel_mode(struct dc_link *link, enum dp_panel_mode panel_mode);
 bool set_default_brightness_aux(struct dc_link *link);
-bool set_cached_brightness_aux(struct dc_link *link);
 void edp_panel_backlight_power_on(struct dc_link *link, bool wait_for_hpd);
 int edp_get_backlight_level(const struct dc_link *link);
 bool edp_get_backlight_level_nits(struct dc_link *link,


