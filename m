Return-Path: <stable+bounces-5146-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AA380B44D
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 13:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 769BC2810FB
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 12:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F054814A92;
	Sat,  9 Dec 2023 12:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yl7ararh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B75748C
	for <stable@vger.kernel.org>; Sat,  9 Dec 2023 12:46:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F987C433C9;
	Sat,  9 Dec 2023 12:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702126018;
	bh=gPrJpPMw6uE5vAY//MrF1DM8dg73CSvO7HYxyPu+iak=;
	h=Subject:To:Cc:From:Date:From;
	b=Yl7ararhaXjfJG3wekjH2s3vBJ7Gn5ZI3uVKxKxbRIwTz+xtI/yUkNJ/FZ+9Mu4zA
	 OpAdZtwAB40v2c6XvDkRPDxgngCLdZXWDbit+jsOiijI4MBep0cEzGAaNFhD3XjYDD
	 ckwNt89Ak/fX9dv1P4v1DICp1zfT+pZNzrUyHBXQ=
Subject: FAILED: patch "[PATCH] drm/i915: Skip some timing checks on BXT/GLK DSI transcoders" failed to apply to 5.10-stable tree
To: ville.syrjala@linux.intel.com,jani.nikula@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 09 Dec 2023 13:46:45 +0100
Message-ID: <2023120945-idiocy-palpable-de59@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 20c2dbff342aec13bf93c2f6c951da198916a455
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023120945-idiocy-palpable-de59@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

20c2dbff342a ("drm/i915: Skip some timing checks on BXT/GLK DSI transcoders")
f2f9c8cb6421 ("drm/i915/sdvo: stop caching has_hdmi_monitor in struct intel_sdvo")
19d7dc6638a9 ("drm/i915/lvds: s/intel_encoder/encoder/ etc.")
7f66476c930c ("drm/i915/lvds: s/dev_priv/i915/")
9dd56e979cb6 ("drm/i915/lvds: Use REG_BIT() & co.")
15d045fd85eb ("drm/i915/panel: move panel fixed EDID to struct intel_panel")
c36225a1e046 ("drm/i915/bios: convert intel_bios_init_panel() to drm_edid")
25fa6b0f69ac ("drm/i915/edid: convert DP, HDMI and LVDS to drm_edid")
9d04eb20bc71 ("drm/i915/display: Drop check for doublescan mode in modevalid")
3f9ffce5765d ("drm/i915: Do panel VBT init early if the VBT declares an explicit panel type")
f70f8153e364 ("drm/i915: Introduce intel_panel_init_alloc()")
09b350d7b05a ("drm/i915/dvo: s/intel_encoder/encoder/ etc.")
d82b9a898d52 ("drm/i915/dvo: Flatten intel_dvo_init()")
c584f86c6242 ("drm/i915/dvo: Eliminate useless 'port' variable")
201ec1bbca03 ("drm/i915/dvo: Introduce intel_dvo_connector_type()")
6ebf5caf1fae ("drm/i915/dvo: Actually initialize the DVO encoder type")
3b5130a68df1 ("drm/i915/dvo: Don't leak connector state on DVO init failure")
4b9cc6efeb06 ("drm/i915/dvo: Remove unused panel_wants_dither")
002c6ca75289 ("Merge drm/drm-next into drm-intel-next")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 20c2dbff342aec13bf93c2f6c951da198916a455 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Date: Mon, 27 Nov 2023 16:50:25 +0200
Subject: [PATCH] drm/i915: Skip some timing checks on BXT/GLK DSI transcoders
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Apparently some BXT/GLK systems have DSI panels whose timings
don't agree with the normal cpu transcoder hblank>=32 limitation.
This is perhaps fine as there are no specific hblank/etc. limits
listed for the BXT/GLK DSI transcoders.

Move those checks out from the global intel_mode_valid() into
into connector specific .mode_valid() hooks, skipping BXT/GLK
DSI connectors. We'll leave the basic [hv]display/[hv]total
checks in intel_mode_valid() as those seem like sensible upper
limits regardless of the transcoder used.

Cc: stable@vger.kernel.org
Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/9720
Fixes: 8f4b1068e7fc ("drm/i915: Check some transcoder timing minimum limits")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231127145028.4899-1-ville.syrjala@linux.intel.com
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
(cherry picked from commit e0ef2daa8ca8ce4dbc2fd0959e383b753a87fd7d)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>

diff --git a/drivers/gpu/drm/i915/display/icl_dsi.c b/drivers/gpu/drm/i915/display/icl_dsi.c
index c4585e445198..67143a0f5189 100644
--- a/drivers/gpu/drm/i915/display/icl_dsi.c
+++ b/drivers/gpu/drm/i915/display/icl_dsi.c
@@ -1440,6 +1440,13 @@ static void gen11_dsi_post_disable(struct intel_atomic_state *state,
 static enum drm_mode_status gen11_dsi_mode_valid(struct drm_connector *connector,
 						 struct drm_display_mode *mode)
 {
+	struct drm_i915_private *i915 = to_i915(connector->dev);
+	enum drm_mode_status status;
+
+	status = intel_cpu_transcoder_mode_valid(i915, mode);
+	if (status != MODE_OK)
+		return status;
+
 	/* FIXME: DSC? */
 	return intel_dsi_mode_valid(connector, mode);
 }
diff --git a/drivers/gpu/drm/i915/display/intel_crt.c b/drivers/gpu/drm/i915/display/intel_crt.c
index 913e5d230a4d..6f6b348b8a40 100644
--- a/drivers/gpu/drm/i915/display/intel_crt.c
+++ b/drivers/gpu/drm/i915/display/intel_crt.c
@@ -348,8 +348,13 @@ intel_crt_mode_valid(struct drm_connector *connector,
 	struct drm_device *dev = connector->dev;
 	struct drm_i915_private *dev_priv = to_i915(dev);
 	int max_dotclk = dev_priv->max_dotclk_freq;
+	enum drm_mode_status status;
 	int max_clock;
 
+	status = intel_cpu_transcoder_mode_valid(dev_priv, mode);
+	if (status != MODE_OK)
+		return status;
+
 	if (mode->flags & DRM_MODE_FLAG_DBLSCAN)
 		return MODE_NO_DBLESCAN;
 
diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index 94330108145e..4ee7d569b379 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -7869,6 +7869,16 @@ enum drm_mode_status intel_mode_valid(struct drm_device *dev,
 	    mode->vtotal > vtotal_max)
 		return MODE_V_ILLEGAL;
 
+	return MODE_OK;
+}
+
+enum drm_mode_status intel_cpu_transcoder_mode_valid(struct drm_i915_private *dev_priv,
+						     const struct drm_display_mode *mode)
+{
+	/*
+	 * Additional transcoder timing limits,
+	 * excluding BXT/GLK DSI transcoders.
+	 */
 	if (DISPLAY_VER(dev_priv) >= 5) {
 		if (mode->hdisplay < 64 ||
 		    mode->htotal - mode->hdisplay < 32)
diff --git a/drivers/gpu/drm/i915/display/intel_display.h b/drivers/gpu/drm/i915/display/intel_display.h
index 0e5dffe8f018..a05c7e2b782e 100644
--- a/drivers/gpu/drm/i915/display/intel_display.h
+++ b/drivers/gpu/drm/i915/display/intel_display.h
@@ -403,6 +403,9 @@ enum drm_mode_status
 intel_mode_valid_max_plane_size(struct drm_i915_private *dev_priv,
 				const struct drm_display_mode *mode,
 				bool bigjoiner);
+enum drm_mode_status
+intel_cpu_transcoder_mode_valid(struct drm_i915_private *i915,
+				const struct drm_display_mode *mode);
 enum phy intel_port_to_phy(struct drm_i915_private *i915, enum port port);
 bool is_trans_port_sync_mode(const struct intel_crtc_state *state);
 bool is_trans_port_sync_master(const struct intel_crtc_state *state);
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 2852958dd4e7..b21bcd40f111 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -1172,6 +1172,10 @@ intel_dp_mode_valid(struct drm_connector *_connector,
 	enum drm_mode_status status;
 	bool dsc = false, bigjoiner = false;
 
+	status = intel_cpu_transcoder_mode_valid(dev_priv, mode);
+	if (status != MODE_OK)
+		return status;
+
 	if (mode->flags & DRM_MODE_FLAG_DBLCLK)
 		return MODE_H_ILLEGAL;
 
diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
index 851b312bd844..4816e4e77f83 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -959,6 +959,10 @@ intel_dp_mst_mode_valid_ctx(struct drm_connector *connector,
 		return 0;
 	}
 
+	*status = intel_cpu_transcoder_mode_valid(dev_priv, mode);
+	if (*status != MODE_OK)
+		return 0;
+
 	if (mode->flags & DRM_MODE_FLAG_DBLSCAN) {
 		*status = MODE_NO_DBLESCAN;
 		return 0;
diff --git a/drivers/gpu/drm/i915/display/intel_dvo.c b/drivers/gpu/drm/i915/display/intel_dvo.c
index 55d6743374bd..9111e9d46486 100644
--- a/drivers/gpu/drm/i915/display/intel_dvo.c
+++ b/drivers/gpu/drm/i915/display/intel_dvo.c
@@ -217,11 +217,17 @@ intel_dvo_mode_valid(struct drm_connector *_connector,
 		     struct drm_display_mode *mode)
 {
 	struct intel_connector *connector = to_intel_connector(_connector);
+	struct drm_i915_private *i915 = to_i915(connector->base.dev);
 	struct intel_dvo *intel_dvo = intel_attached_dvo(connector);
 	const struct drm_display_mode *fixed_mode =
 		intel_panel_fixed_mode(connector, mode);
 	int max_dotclk = to_i915(connector->base.dev)->max_dotclk_freq;
 	int target_clock = mode->clock;
+	enum drm_mode_status status;
+
+	status = intel_cpu_transcoder_mode_valid(i915, mode);
+	if (status != MODE_OK)
+		return status;
 
 	if (mode->flags & DRM_MODE_FLAG_DBLSCAN)
 		return MODE_NO_DBLESCAN;
diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index ac315f8e7820..bfa456fa7d25 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -1983,6 +1983,10 @@ intel_hdmi_mode_valid(struct drm_connector *connector,
 	bool ycbcr_420_only;
 	enum intel_output_format sink_format;
 
+	status = intel_cpu_transcoder_mode_valid(dev_priv, mode);
+	if (status != MODE_OK)
+		return status;
+
 	if ((mode->flags & DRM_MODE_FLAG_3D_MASK) == DRM_MODE_FLAG_3D_FRAME_PACKING)
 		clock *= 2;
 
diff --git a/drivers/gpu/drm/i915/display/intel_lvds.c b/drivers/gpu/drm/i915/display/intel_lvds.c
index 2a4ca7e65775..bcbdd1984fd9 100644
--- a/drivers/gpu/drm/i915/display/intel_lvds.c
+++ b/drivers/gpu/drm/i915/display/intel_lvds.c
@@ -389,11 +389,16 @@ intel_lvds_mode_valid(struct drm_connector *_connector,
 		      struct drm_display_mode *mode)
 {
 	struct intel_connector *connector = to_intel_connector(_connector);
+	struct drm_i915_private *i915 = to_i915(connector->base.dev);
 	const struct drm_display_mode *fixed_mode =
 		intel_panel_fixed_mode(connector, mode);
 	int max_pixclk = to_i915(connector->base.dev)->max_dotclk_freq;
 	enum drm_mode_status status;
 
+	status = intel_cpu_transcoder_mode_valid(i915, mode);
+	if (status != MODE_OK)
+		return status;
+
 	if (mode->flags & DRM_MODE_FLAG_DBLSCAN)
 		return MODE_NO_DBLESCAN;
 
diff --git a/drivers/gpu/drm/i915/display/intel_sdvo.c b/drivers/gpu/drm/i915/display/intel_sdvo.c
index a636f42ceae5..a9ac7d45d1f3 100644
--- a/drivers/gpu/drm/i915/display/intel_sdvo.c
+++ b/drivers/gpu/drm/i915/display/intel_sdvo.c
@@ -1921,13 +1921,19 @@ static enum drm_mode_status
 intel_sdvo_mode_valid(struct drm_connector *connector,
 		      struct drm_display_mode *mode)
 {
+	struct drm_i915_private *i915 = to_i915(connector->dev);
 	struct intel_sdvo *intel_sdvo = intel_attached_sdvo(to_intel_connector(connector));
 	struct intel_sdvo_connector *intel_sdvo_connector =
 		to_intel_sdvo_connector(connector);
-	int max_dotclk = to_i915(connector->dev)->max_dotclk_freq;
 	bool has_hdmi_sink = intel_has_hdmi_sink(intel_sdvo_connector, connector->state);
+	int max_dotclk = i915->max_dotclk_freq;
+	enum drm_mode_status status;
 	int clock = mode->clock;
 
+	status = intel_cpu_transcoder_mode_valid(i915, mode);
+	if (status != MODE_OK)
+		return status;
+
 	if (mode->flags & DRM_MODE_FLAG_DBLSCAN)
 		return MODE_NO_DBLESCAN;
 
diff --git a/drivers/gpu/drm/i915/display/intel_tv.c b/drivers/gpu/drm/i915/display/intel_tv.c
index 31a79fdfc812..2ee4f0d95851 100644
--- a/drivers/gpu/drm/i915/display/intel_tv.c
+++ b/drivers/gpu/drm/i915/display/intel_tv.c
@@ -958,8 +958,14 @@ static enum drm_mode_status
 intel_tv_mode_valid(struct drm_connector *connector,
 		    struct drm_display_mode *mode)
 {
+	struct drm_i915_private *i915 = to_i915(connector->dev);
 	const struct tv_mode *tv_mode = intel_tv_mode_find(connector->state);
-	int max_dotclk = to_i915(connector->dev)->max_dotclk_freq;
+	int max_dotclk = i915->max_dotclk_freq;
+	enum drm_mode_status status;
+
+	status = intel_cpu_transcoder_mode_valid(i915, mode);
+	if (status != MODE_OK)
+		return status;
 
 	if (mode->flags & DRM_MODE_FLAG_DBLSCAN)
 		return MODE_NO_DBLESCAN;
diff --git a/drivers/gpu/drm/i915/display/vlv_dsi.c b/drivers/gpu/drm/i915/display/vlv_dsi.c
index 55da627a8b8d..f488394d3108 100644
--- a/drivers/gpu/drm/i915/display/vlv_dsi.c
+++ b/drivers/gpu/drm/i915/display/vlv_dsi.c
@@ -1541,9 +1541,25 @@ static const struct drm_encoder_funcs intel_dsi_funcs = {
 	.destroy = intel_dsi_encoder_destroy,
 };
 
+static enum drm_mode_status vlv_dsi_mode_valid(struct drm_connector *connector,
+					       struct drm_display_mode *mode)
+{
+	struct drm_i915_private *i915 = to_i915(connector->dev);
+
+	if (IS_VALLEYVIEW(i915) || IS_CHERRYVIEW(i915)) {
+		enum drm_mode_status status;
+
+		status = intel_cpu_transcoder_mode_valid(i915, mode);
+		if (status != MODE_OK)
+			return status;
+	}
+
+	return intel_dsi_mode_valid(connector, mode);
+}
+
 static const struct drm_connector_helper_funcs intel_dsi_connector_helper_funcs = {
 	.get_modes = intel_dsi_get_modes,
-	.mode_valid = intel_dsi_mode_valid,
+	.mode_valid = vlv_dsi_mode_valid,
 	.atomic_check = intel_digital_connector_atomic_check,
 };
 


