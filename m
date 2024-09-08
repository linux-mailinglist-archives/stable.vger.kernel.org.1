Return-Path: <stable+bounces-73900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 047E197076A
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 14:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A05C1C20D23
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 12:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95E914C5AE;
	Sun,  8 Sep 2024 12:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jOMeo1Uu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0901DA26
	for <stable@vger.kernel.org>; Sun,  8 Sep 2024 12:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725798948; cv=none; b=kyjzxzAFp7zhKCX7g7oxb4w40lpqwF4mh5VTfFnaytpTOOwEeVEV9EojT3oNlNyY+GEBBfqygSQg9/M4tGzRA0LDqMN4TQfO+TVXx/eBz6N3yFFaUsKqQxd4DUlM0WZz7S/rABfW/1Iw7MfsDQw2YKM2CURDCh+SCeQI34GQu/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725798948; c=relaxed/simple;
	bh=7048aMBYZkvYDxsZfHPgS+XQjSrt/wxO69tV9D+WfuA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EqVxqtYIFMW+TTstJ0MKyTcQkQEbaEViKt1kq0vwv5d1iSzeAvrmE2lrK6aYSJe/KMsGqXe4Ulhddj/KZm46cbIUvS2+5GbZbH0lJCmUPItpeTpOAzLI7G0bh/vfcBY6zOynkZe1AvVwjinZgXcKbu7tY9iuPMF5ndc/bbC9BbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jOMeo1Uu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A11CEC4CEC3;
	Sun,  8 Sep 2024 12:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725798948;
	bh=7048aMBYZkvYDxsZfHPgS+XQjSrt/wxO69tV9D+WfuA=;
	h=Subject:To:Cc:From:Date:From;
	b=jOMeo1Uulb9gElZvUc/LhlD7+5z0qpLX297cbta8aCCIdPPWobwmR7+jpuv711x2Y
	 ThVQ717Renj4i9JcM/nohokm2Jaq48QIAp9rUj+nenP/vGP7jQjzA208yCfUQ0pHtt
	 bZPzB/LGspqBwxnGqyBsEI9rvkgvRhtPdbTq8F+k=
Subject: FAILED: patch "[PATCH] drm/i915: Fix readout degamma_lut mismatch on ilk/snb" failed to apply to 6.10-stable tree
To: ville.syrjala@linux.intel.com,joonas.lahtinen@linux.intel.com,uma.shankar@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 08 Sep 2024 14:35:45 +0200
Message-ID: <2024090844-result-caucasian-a9e5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x e8705632435ae2f2253b65d3786da389982e8813
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090844-result-caucasian-a9e5@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

e8705632435a ("drm/i915: Fix readout degamma_lut mismatch on ilk/snb")
da8c3cdb016c ("drm/i915: Rename bigjoiner master/slave to bigjoiner primary/secondary")
fb4943574f92 ("drm/i915: Rename all bigjoiner to joiner")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e8705632435ae2f2253b65d3786da389982e8813 Mon Sep 17 00:00:00 2001
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
(cherry picked from commit 33eca84db6e31091cef63584158ab64704f78462)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>

diff --git a/drivers/gpu/drm/i915/display/intel_modeset_setup.c b/drivers/gpu/drm/i915/display/intel_modeset_setup.c
index 7602cb30ebf1..e1213f3d93cc 100644
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


