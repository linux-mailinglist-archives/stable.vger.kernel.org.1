Return-Path: <stable+bounces-81545-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2ED5994435
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 11:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 467D5B2ADFB
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 09:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8341B13B5B6;
	Tue,  8 Oct 2024 09:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Eq2CVN7d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4111C2566
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 09:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728379143; cv=none; b=M7DsDlDBat2Gv60M7Fw7Q/M55iGN7SHRM1kUK4gmUhAm+EfCmbSSDiRZG+38ixGFzk0yREPR6jXKlUYNyW86BGzifuZm+FfMMVXXjLNUpBJ4f2M7SlTAEn/GW9J2+ziG7MSIZvVg/u1EkywEdBd2EeNe8ZreHUytbd1nrOM2F3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728379143; c=relaxed/simple;
	bh=i+1uK1PohyzZNrsUbrZpWxd3qqk1OyC2Lthzj/QpEwE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=d7imrS2UfVvZHkP6gKSt+9jf//oAK5gQK3BKa3Ecqo2SuEljpGHJmq2X7mhP1RA8GH6TOoR8mjd4DhDu6tErYC3FtTFW6RUX7LU5fOlEfCbdT5b2u/k9gyWpBbR6iLh0iXMEW68AhgkL9L10jcqyqC5FAfwZjV4RsZ7fMLgW2kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Eq2CVN7d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CDBC4CEC7;
	Tue,  8 Oct 2024 09:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728379143;
	bh=i+1uK1PohyzZNrsUbrZpWxd3qqk1OyC2Lthzj/QpEwE=;
	h=Subject:To:Cc:From:Date:From;
	b=Eq2CVN7d8u1keJR0t7SGLXRqTFmKEmKQlNju9K9Ka8wK+WOzoHIhFnGcOZ5QurmMC
	 t2aUvYaSdl7LkKD15kJZvIsJ+YybKHrYaASXe3Axp5jwvfJ7s3MUJ2teAStIuyaFxw
	 PCd1+2fqqOEVVI30Uszwnx1RikIh5MTK4W2kF6Ac=
Subject: FAILED: patch "[PATCH] drm/i915: Fix readout degamma_lut mismatch on ilk/snb" failed to apply to 6.11-stable tree
To: ville.syrjala@linux.intel.com,uma.shankar@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Oct 2024 11:19:00 +0200
Message-ID: <2024100859-bogus-pursuable-6b33@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.11-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.11.y
git checkout FETCH_HEAD
git cherry-pick -x 33eca84db6e31091cef63584158ab64704f78462
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100859-bogus-pursuable-6b33@gregkh' --subject-prefix 'PATCH 6.11.y' HEAD^..

Possible dependencies:

33eca84db6e3 ("drm/i915: Fix readout degamma_lut mismatch on ilk/snb")

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


