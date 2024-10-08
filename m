Return-Path: <stable+bounces-81547-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 526AA994402
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 11:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7699A1C20E55
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 09:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AAF152532;
	Tue,  8 Oct 2024 09:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kcJhEYdi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C41613C827
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 09:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728379156; cv=none; b=i6thL/CHdy34q0R06ZCgok1fSAV30JAdB/GVLVXGRbY0oXVHA7O3y1MZjVTcNaPTSfXkSQOa1h4qb/K3qvNS4j+WWGxV0sMzem+uMzfWxAMtssBaA2f0aYJdyxYJUVqIM+pX9+6JT2+8wjsgaZWxxtm8LB3k0Tws4GU/H+dD+54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728379156; c=relaxed/simple;
	bh=qbvn2kFo1T/l4c6lAakJpCTWDTc4eM+w3cJ3lJirWyw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JsH+hGCdOCBzu3yfjKSIu60/wxiKCKu0hWGPXgvc9ytPAXFwb9uncXgZUHuDZAlPYaYLWGz7OVbvH8CdmNsdaGImHQJQNaHoSzwgmIQ3/ajVKCQWT1SaoYb+uBW/xtciDqkSorB4JgcWakxK//YQ0qvGtM6C7nKvppu0iohtHLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kcJhEYdi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CBB0C4CEC7;
	Tue,  8 Oct 2024 09:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728379155;
	bh=qbvn2kFo1T/l4c6lAakJpCTWDTc4eM+w3cJ3lJirWyw=;
	h=Subject:To:Cc:From:Date:From;
	b=kcJhEYdiLjvZ5lz4eOsGjUImSDVISHyaOhoRqrgFiQSs9SmiPBqsXbtpR+d8Iw5Bg
	 /vR0+J+I5VO1N9Ztbvh+PsOCTZ3y6pMVfme8BvwAUeY3DnsexFsttoauHUIOb/B8a3
	 /JMZDPWUyZ8hRtWLaVzUU3v9vuXVLa0daVLKkxh0=
Subject: FAILED: patch "[PATCH] drm/i915: Fix readout degamma_lut mismatch on ilk/snb" failed to apply to 6.6-stable tree
To: ville.syrjala@linux.intel.com,uma.shankar@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Oct 2024 11:19:01 +0200
Message-ID: <2024100801-yelp-fasting-b762@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 33eca84db6e31091cef63584158ab64704f78462
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100801-yelp-fasting-b762@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

33eca84db6e3 ("drm/i915: Fix readout degamma_lut mismatch on ilk/snb")
da8c3cdb016c ("drm/i915: Rename bigjoiner master/slave to bigjoiner primary/secondary")
fb4943574f92 ("drm/i915: Rename all bigjoiner to joiner")
578ff98403ce ("drm/i915: Allow bigjoiner for MST")
3607b30836ae ("drm/i915: Handle joined pipes inside hsw_crtc_enable()")
e16bcbb01186 ("drm/i915: Handle joined pipes inside hsw_crtc_disable()")
2b8ad19d3ed6 ("drm/i915: Introduce intel_crtc_joined_pipe_mask()")
e43b4f7980f8 ("drm/i915: Pass connector to intel_dp_need_bigjoiner()")
5a1527ed8b43 ("drm/i915/mst: Check intel_dp_joiner_needs_dsc()")
aa099402f98b ("drm/i915: Extract intel_dp_joiner_needs_dsc()")
c0b8afc3a777 ("drm/i915: s/intel_dp_can_bigjoiner()/intel_dp_has_bigjoiner()/")
e02ef5553d9b ("drm/i915: Update pipes in reverse order for bigjoiner")
3a5e09d82f97 ("drm/i915: Fix intel_modeset_pipe_config_late() for bigjoiner")
f9d5e51db656 ("drm/i915/vrr: Disable VRR when using bigjoiner")
ef79820db723 ("drm/i915: Disable live M/N updates when using bigjoiner")
b37e1347b991 ("drm/i915: Disable port sync when bigjoiner is used")
372fa0c79d3f ("drm/i915/psr: Disable PSR when bigjoiner is used")
7a3f171c8f6a ("drm/i915: Extract glk_need_scaler_clock_gating_wa()")
c922a47913f9 ("drm/i915: Clean up glk_pipe_scaler_clock_gating_wa()")
e9fa99dd47a4 ("drm/i915: Shuffle DP .mode_valid() checks")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 33eca84db6e31091cef63584158ab64704f78462 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Date: Wed, 10 Jul 2024 15:41:37 +0300
Subject: [PATCH] drm/i915: Fix readout degamma_lut mismatch on ilk/snb
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On ilk/snb the pipe may be configured to place the LUT before or
after the CSC depending on various factors, but as there is only
one LUT (no split mode like on IVB+) we only advertise a gamma_lut
and no degamma_lut in the uapi to avoid confusing userspace.

This can cause a problem during readout if the VBIOS/GOP enabled
the LUT in the pre CSC configuration. The current code blindly
assigns the results of the readout to the degamma_lut, which will
cause a failure during the next atomic_check() as we aren't expecting
anything to be in degamma_lut since it's not visible to userspace.

Fix the problem by assigning whatever LUT we read out from the
hardware into gamma_lut.

Cc: stable@vger.kernel.org
Fixes: d2559299d339 ("drm/i915: Make ilk_read_luts() capable of degamma readout")
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/11608
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240710124137.16773-1-ville.syrjala@linux.intel.com
Reviewed-by: Uma Shankar <uma.shankar@intel.com>

diff --git a/drivers/gpu/drm/i915/display/intel_modeset_setup.c b/drivers/gpu/drm/i915/display/intel_modeset_setup.c
index 6f85f5352455..72694dde3c22 100644
--- a/drivers/gpu/drm/i915/display/intel_modeset_setup.c
+++ b/drivers/gpu/drm/i915/display/intel_modeset_setup.c
@@ -326,6 +326,8 @@ static void intel_modeset_update_connector_atomic_state(struct drm_i915_private
 
 static void intel_crtc_copy_hw_to_uapi_state(struct intel_crtc_state *crtc_state)
 {
+	struct drm_i915_private *i915 = to_i915(crtc_state->uapi.crtc->dev);
+
 	if (intel_crtc_is_joiner_secondary(crtc_state))
 		return;
 
@@ -337,11 +339,30 @@ static void intel_crtc_copy_hw_to_uapi_state(struct intel_crtc_state *crtc_state
 	crtc_state->uapi.adjusted_mode = crtc_state->hw.adjusted_mode;
 	crtc_state->uapi.scaling_filter = crtc_state->hw.scaling_filter;
 
-	/* assume 1:1 mapping */
-	drm_property_replace_blob(&crtc_state->hw.degamma_lut,
-				  crtc_state->pre_csc_lut);
-	drm_property_replace_blob(&crtc_state->hw.gamma_lut,
-				  crtc_state->post_csc_lut);
+	if (DISPLAY_INFO(i915)->color.degamma_lut_size) {
+		/* assume 1:1 mapping */
+		drm_property_replace_blob(&crtc_state->hw.degamma_lut,
+					  crtc_state->pre_csc_lut);
+		drm_property_replace_blob(&crtc_state->hw.gamma_lut,
+					  crtc_state->post_csc_lut);
+	} else {
+		/*
+		 * ilk/snb hw may be configured for either pre_csc_lut
+		 * or post_csc_lut, but we don't advertise degamma_lut as
+		 * being available in the uapi since there is only one
+		 * hardware LUT. Always assign the result of the readout
+		 * to gamma_lut as that is the only valid source of LUTs
+		 * in the uapi.
+		 */
+		drm_WARN_ON(&i915->drm, crtc_state->post_csc_lut &&
+			    crtc_state->pre_csc_lut);
+
+		drm_property_replace_blob(&crtc_state->hw.degamma_lut,
+					  NULL);
+		drm_property_replace_blob(&crtc_state->hw.gamma_lut,
+					  crtc_state->post_csc_lut ?:
+					  crtc_state->pre_csc_lut);
+	}
 
 	drm_property_replace_blob(&crtc_state->uapi.degamma_lut,
 				  crtc_state->hw.degamma_lut);


