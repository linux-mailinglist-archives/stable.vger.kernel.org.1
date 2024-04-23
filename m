Return-Path: <stable+bounces-40934-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 752928AF9A8
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 23:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C45E28A211
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 21:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3502145321;
	Tue, 23 Apr 2024 21:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KUXmmD3T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91553143C6C;
	Tue, 23 Apr 2024 21:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908564; cv=none; b=oSFwkKu7DEW61UyFKVhIQPPiPsZRL0ViEplLSNQtQn0F6v7LK6EsK67qSgO6zx62SbJ2VmK8seDA+5WSZ/OcyZbgJMh6BJvNX+JKUhE/BK915Lxlsva8Xzc6JwV0Fwq6wIHUwYcWYmjGa7sPhGzXXFqrA4Gm7kw/+itlCAumPK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908564; c=relaxed/simple;
	bh=r+jEbIJEhjhof6CWn4N0nFb18VGsnPgPH/4CP3s2LBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nWl1VsUvN5lgXY8Zpxv3GkFUyJuyoytGhfpqX9IF3NM0YKQ/SFyAEFKBASxiVHm13wzbYfFYCMsmHXEouWdHsTSprddnAMsC+INWBWRtfnRBUxJxBc2ykZaX/51KewjeIu/FRVW3wnbCmdh1ckmEx/dGDBLoUAGZ8XKOzHGDJvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KUXmmD3T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A84C32783;
	Tue, 23 Apr 2024 21:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713908564;
	bh=r+jEbIJEhjhof6CWn4N0nFb18VGsnPgPH/4CP3s2LBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KUXmmD3Tju2NXWxWJfDVinX3udKGStiAL5mExu6Ve3m6zaQWzxIsz+JNRPdkOJoYR
	 OVDQeLCFa5ML4nwpcRpL7/HmYUPyy8pbZpQ6MPSjP5WxHGUq+hPZY6/q4Axxv3sZDx
	 +24KgiIjR8W421RLSsGNDm+9XOESjDPjFXREps7I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Manasi Navare <navaremanasi@chromium.org>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 012/158] drm/i915: Adjust seamless_m_n flag behaviour
Date: Tue, 23 Apr 2024 14:37:29 -0700
Message-ID: <20240423213856.117313615@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423213855.696477232@linuxfoundation.org>
References: <20240423213855.696477232@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

[ Upstream commit 825edc8bc72f3266534a04e9a4447b12332fac82 ]

Make the seamless_m_n flag more like the update_pipe fastset
flag, ie. the flag will only be set if we need to do the seamless
M/N update, and in all other cases the flag is cleared. Also
rename the flag to update_m_n to make it more clear it's similar
to update_pipe.

I believe special casing seamless_m_n like this makes sense
as it also affects eg. vblank evasion. We can potentially avoid
some vblank evasion tricks, simplify some checks, and hopefully
will help with the VRR vs. M/N mess.

Cc: Manasi Navare <navaremanasi@chromium.org>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230901130440.2085-6-ville.syrjala@linux.intel.com
Reviewed-by: Manasi Navare <navaremanasi@chromium.org>
Stable-dep-of: 4a36e46df7aa ("drm/i915: Disable live M/N updates when using bigjoiner")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_atomic.c   |  1 +
 drivers/gpu/drm/i915/display/intel_crtc.c     |  2 +-
 drivers/gpu/drm/i915/display/intel_display.c  | 22 +++++++++++--------
 .../drm/i915/display/intel_display_types.h    |  2 +-
 drivers/gpu/drm/i915/display/intel_dp.c       |  2 +-
 5 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_atomic.c b/drivers/gpu/drm/i915/display/intel_atomic.c
index 7cf51dd8c0567..aaddd8c0cfa0e 100644
--- a/drivers/gpu/drm/i915/display/intel_atomic.c
+++ b/drivers/gpu/drm/i915/display/intel_atomic.c
@@ -259,6 +259,7 @@ intel_crtc_duplicate_state(struct drm_crtc *crtc)
 		drm_property_blob_get(crtc_state->post_csc_lut);
 
 	crtc_state->update_pipe = false;
+	crtc_state->update_m_n = false;
 	crtc_state->disable_lp_wm = false;
 	crtc_state->disable_cxsr = false;
 	crtc_state->update_wm_pre = false;
diff --git a/drivers/gpu/drm/i915/display/intel_crtc.c b/drivers/gpu/drm/i915/display/intel_crtc.c
index 5c89eba8148c0..cfbfbfed3f5e6 100644
--- a/drivers/gpu/drm/i915/display/intel_crtc.c
+++ b/drivers/gpu/drm/i915/display/intel_crtc.c
@@ -510,7 +510,7 @@ static void intel_crtc_vblank_evade_scanlines(struct intel_atomic_state *state,
 	 * M/N is double buffered on the transcoder's undelayed vblank,
 	 * so with seamless M/N we must evade both vblanks.
 	 */
-	if (new_crtc_state->seamless_m_n && intel_crtc_needs_fastset(new_crtc_state))
+	if (new_crtc_state->update_m_n)
 		*min -= adjusted_mode->crtc_vblank_start - adjusted_mode->crtc_vdisplay;
 }
 
diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index 39efd67cc3232..1a59fca40252c 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -5215,7 +5215,7 @@ intel_pipe_config_compare(const struct intel_crtc_state *current_config,
 	PIPE_CONF_CHECK_X(lane_lat_optim_mask);
 
 	if (HAS_DOUBLE_BUFFERED_M_N(dev_priv)) {
-		if (!fastset || !pipe_config->seamless_m_n)
+		if (!fastset || !pipe_config->update_m_n)
 			PIPE_CONF_CHECK_M_N(dp_m_n);
 	} else {
 		PIPE_CONF_CHECK_M_N(dp_m_n);
@@ -5353,7 +5353,7 @@ intel_pipe_config_compare(const struct intel_crtc_state *current_config,
 	if (IS_G4X(dev_priv) || DISPLAY_VER(dev_priv) >= 5)
 		PIPE_CONF_CHECK_I(pipe_bpp);
 
-	if (!fastset || !pipe_config->seamless_m_n) {
+	if (!fastset || !pipe_config->update_m_n) {
 		PIPE_CONF_CHECK_I(hw.pipe_mode.crtc_clock);
 		PIPE_CONF_CHECK_I(hw.adjusted_mode.crtc_clock);
 	}
@@ -5448,6 +5448,7 @@ int intel_modeset_all_pipes(struct intel_atomic_state *state,
 
 		crtc_state->uapi.mode_changed = true;
 		crtc_state->update_pipe = false;
+		crtc_state->update_m_n = false;
 
 		ret = drm_atomic_add_affected_connectors(&state->base,
 							 &crtc->base);
@@ -5565,13 +5566,14 @@ static void intel_crtc_check_fastset(const struct intel_crtc_state *old_crtc_sta
 {
 	struct drm_i915_private *i915 = to_i915(old_crtc_state->uapi.crtc->dev);
 
-	if (!intel_pipe_config_compare(old_crtc_state, new_crtc_state, true)) {
+	if (!intel_pipe_config_compare(old_crtc_state, new_crtc_state, true))
 		drm_dbg_kms(&i915->drm, "fastset requirement not met, forcing full modeset\n");
+	else
+		new_crtc_state->uapi.mode_changed = false;
 
-		return;
-	}
+	if (intel_crtc_needs_modeset(new_crtc_state))
+		new_crtc_state->update_m_n = false;
 
-	new_crtc_state->uapi.mode_changed = false;
 	if (!intel_crtc_needs_modeset(new_crtc_state))
 		new_crtc_state->update_pipe = true;
 }
@@ -6297,6 +6299,7 @@ int intel_atomic_check(struct drm_device *dev,
 			if (intel_cpu_transcoders_need_modeset(state, BIT(master))) {
 				new_crtc_state->uapi.mode_changed = true;
 				new_crtc_state->update_pipe = false;
+				new_crtc_state->update_m_n = false;
 			}
 		}
 
@@ -6309,6 +6312,7 @@ int intel_atomic_check(struct drm_device *dev,
 			if (intel_cpu_transcoders_need_modeset(state, trans)) {
 				new_crtc_state->uapi.mode_changed = true;
 				new_crtc_state->update_pipe = false;
+				new_crtc_state->update_m_n = false;
 			}
 		}
 
@@ -6316,6 +6320,7 @@ int intel_atomic_check(struct drm_device *dev,
 			if (intel_pipes_need_modeset(state, new_crtc_state->bigjoiner_pipes)) {
 				new_crtc_state->uapi.mode_changed = true;
 				new_crtc_state->update_pipe = false;
+				new_crtc_state->update_m_n = false;
 			}
 		}
 	}
@@ -6494,7 +6499,7 @@ static void intel_pipe_fastset(const struct intel_crtc_state *old_crtc_state,
 	    IS_BROADWELL(dev_priv) || IS_HASWELL(dev_priv))
 		hsw_set_linetime_wm(new_crtc_state);
 
-	if (new_crtc_state->seamless_m_n)
+	if (new_crtc_state->update_m_n)
 		intel_cpu_transcoder_set_m1_n1(crtc, new_crtc_state->cpu_transcoder,
 					       &new_crtc_state->dp_m_n);
 }
@@ -6630,8 +6635,7 @@ static void intel_update_crtc(struct intel_atomic_state *state,
 	 *
 	 * FIXME Should be synchronized with the start of vblank somehow...
 	 */
-	if (vrr_enabling(old_crtc_state, new_crtc_state) ||
-	    (new_crtc_state->seamless_m_n && intel_crtc_needs_fastset(new_crtc_state)))
+	if (vrr_enabling(old_crtc_state, new_crtc_state) || new_crtc_state->update_m_n)
 		intel_crtc_update_active_timings(new_crtc_state,
 						 new_crtc_state->vrr.enable);
 
diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index 8b0dc2b75da4a..1c23b186aff20 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -1084,6 +1084,7 @@ struct intel_crtc_state {
 
 	unsigned fb_bits; /* framebuffers to flip */
 	bool update_pipe; /* can a fast modeset be performed? */
+	bool update_m_n; /* update M/N seamlessly during fastset? */
 	bool disable_cxsr;
 	bool update_wm_pre, update_wm_post; /* watermarks are updated */
 	bool fifo_changed; /* FIFO split is changed */
@@ -1196,7 +1197,6 @@ struct intel_crtc_state {
 	/* m2_n2 for eDP downclock */
 	struct intel_link_m_n dp_m2_n2;
 	bool has_drrs;
-	bool seamless_m_n;
 
 	/* PSR is supported but might not be enabled due the lack of enabled planes */
 	bool has_psr;
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index d712cb9b81e1e..7e135ed8e1d75 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -2149,7 +2149,7 @@ intel_dp_drrs_compute_config(struct intel_connector *connector,
 	int pixel_clock;
 
 	if (has_seamless_m_n(connector))
-		pipe_config->seamless_m_n = true;
+		pipe_config->update_m_n = true;
 
 	if (!can_enable_drrs(connector, pipe_config, downclock_mode)) {
 		if (intel_cpu_transcoder_has_m2_n2(i915, pipe_config->cpu_transcoder))
-- 
2.43.0




