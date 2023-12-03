Return-Path: <stable+bounces-3755-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF012802428
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 14:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16A771C20915
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 13:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B0CF9C4;
	Sun,  3 Dec 2023 13:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rwFy/D1d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1450C8CB
	for <stable@vger.kernel.org>; Sun,  3 Dec 2023 13:19:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D596AC433C8;
	Sun,  3 Dec 2023 13:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701609573;
	bh=JZrYfqSrNx91y5DNstgztOrwgNNtPl4lFP7eWPkBfSU=;
	h=Subject:To:Cc:From:Date:From;
	b=rwFy/D1dHZJ6CQGI0AJX/jslknMuhkHTJelAcCk34ONk9LpntXsNrROhXbw79ZwIc
	 QlFH55BMvgSMImLWGM8eKT0jz4YDL/XY2CHB6kqa5EbvzyWlnbxhge87WgeusWCU5s
	 x06GfWS6HLapOnveCXHtvXc4qd+V5VYkYgYF+Lrs=
Subject: FAILED: patch "[PATCH] drm/amd/display: Simplify brightness initialization" failed to apply to 6.6-stable tree
To: camille.cho@amd.com,alexander.deucher@amd.com,hamza.mahfooz@amd.com,krunoslav.kovac@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 03 Dec 2023 14:19:30 +0100
Message-ID: <2023120329-puppet-makeover-72ec@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x d9e865826c202b262f9ee3f17a03cc4ac5d44ced
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023120329-puppet-makeover-72ec@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

d9e865826c20 ("drm/amd/display: Simplify brightness initialization")
5edb7cdff85a ("drm/amd/display: Reduce default backlight min from 5 nits to 1 nits")
6ec876472ff7 ("drm/amd/display: refactor ILR to make it work")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d9e865826c202b262f9ee3f17a03cc4ac5d44ced Mon Sep 17 00:00:00 2001
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
index c4e5c3350b75..2cafd644baff 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1609,7 +1609,6 @@ struct dc_link {
 	enum edp_revision edp_revision;
 	union dpcd_sink_ext_caps dpcd_sink_ext_caps;
 
-	struct backlight_settings backlight_settings;
 	struct psr_settings psr_settings;
 
 	struct replay_settings replay_settings;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index fcb825e4f1bb..35d146217aef 100644
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
index e32a7974a4bc..996e4ee99023 100644
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
index ebf7deb63d13..a034288ad75d 100644
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


