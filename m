Return-Path: <stable+bounces-59004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2337492D1CB
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 14:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDC002851AF
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 12:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF0A191F62;
	Wed, 10 Jul 2024 12:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XtJfZWEB"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6441A19066D
	for <stable@vger.kernel.org>; Wed, 10 Jul 2024 12:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720615302; cv=none; b=M4aorzB/7R1AhLSJoCAPV8zalHNuQhGck5S9miId9b9w5ZXcFwLIb7GR8qabn+uksArupCurqaOLyr20PcfAto+QE4WsITQ060ETA+X2ByrSJkAdDg6s9avNR5WO9c9DUIsRHQGOVJ2OEk0dXhJAkIXGXLKEir2KnVWFvCpFEFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720615302; c=relaxed/simple;
	bh=2tqPNEFWygqfk1hUyRVA/mCWN5DE9KFHkML6WN8jaT8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HKWjvzOcWlUB+dRVhOsNqfrou3owjvIJng1DFF0S8DYv1QW14VNQWCMxYBARG4JOFgO+vjeioep5NvukZa6Bn8xFOIuXYaGTpu4pMeymI5I70OeBBtMzOadCSdxbY6yf7CP8dYyZaoTjkZO41dw+K9nkt0+YBIYAHXX7OetknWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XtJfZWEB; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720615302; x=1752151302;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2tqPNEFWygqfk1hUyRVA/mCWN5DE9KFHkML6WN8jaT8=;
  b=XtJfZWEBa0hulZe7MMCWs1pHO+JLFL+Ghqbgbi8K9d46L6FrNf4TrsD5
   h/ICqTTmcKoPya0ltcRT6mn3p0KyIfwpwiy0eGFKcnRwMCX2Fm5OZp29d
   3+bBGzJSwFxA+VEQSf6is7fZA2SluKJw+N/zoOvuE7Web7kUs/L3TLw8n
   FN2lSAbQneF4LGQ7xTl76w0TilnSYEEZ8sSQhzSqcpdG/40w8h94/hynM
   46jjpDlb2j1ekjRzfnV5JCfjruaViMuiV9ANfLw3EPMyd8LGyByAVdps5
   jqSXWsQnXGA8+cfsMXccHj+lThye/75jTfqKM5ZzKAsPwIw+G4ypQJNS+
   g==;
X-CSE-ConnectionGUID: JtEEqp/MQaOK3GTQCp2pCg==
X-CSE-MsgGUID: ED0sLJ5wR3+u3WKLyEw+7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="21696961"
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="21696961"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 05:41:41 -0700
X-CSE-ConnectionGUID: skW5B46gSz260u4JJIlRXA==
X-CSE-MsgGUID: Gg4RpCqNQQ655HI8umNATA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="48182937"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 10 Jul 2024 05:41:38 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 10 Jul 2024 15:41:37 +0300
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: [PATCH] drm/i915: Fix readout degamma_lut mismatch on ilk/snb
Date: Wed, 10 Jul 2024 15:41:37 +0300
Message-ID: <20240710124137.16773-1-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

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
---
 .../drm/i915/display/intel_modeset_setup.c    | 31 ++++++++++++++++---
 1 file changed, 26 insertions(+), 5 deletions(-)

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
-- 
2.44.2


