Return-Path: <stable+bounces-26908-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44153872DE5
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 05:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75F4C1C217D7
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 04:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E13F15E97;
	Wed,  6 Mar 2024 04:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mkjfvqji"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2F714F7F
	for <stable@vger.kernel.org>; Wed,  6 Mar 2024 04:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709698105; cv=none; b=meMxa3N8fdGmNst5HPAoQK/x6NezxkVNG0qLQKOW8Rc4gzvyjqUW9X3DoVvcPweuuhM92n22XbeDv2PwL2XTAeXOK1WX6JMcVIrDX+2tzB2vDL5g7GCXO5gIn5Az1oG4PmkpW3L39lg2n7/Prw5HcZ/HNb+29jiofYg9t04VzbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709698105; c=relaxed/simple;
	bh=V/rGHrKIPvGHaqPazua1v+UrW50FZwNh/U2I93EPdX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ByooXD5SZoYhZzGnjTa0Vrt4QlMLg9HR4XcGupzYxN/PAkh1UPO08ciRjEW3iy85MLip5R/ZqsctdAHowq4D3ilyJ/Z4gmyrhF/w78z9VQka2g+bdbxyQJp8NHjSC2qC1wWT7TTDErQH/GuOIvsO9+ubF3OcePTtQ9v330zndbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mkjfvqji; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709698104; x=1741234104;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V/rGHrKIPvGHaqPazua1v+UrW50FZwNh/U2I93EPdX8=;
  b=mkjfvqjiiPYVM6KS75hyByoK4jvtKsOp3tAa8Ycjo/FsRdHzCDID5Bkr
   KtFmYpf1Ubjegv2Q/26XNX1ySrXHGcNke1HvbTeOUzHYsKmBea9eimZR5
   MF7pkxZe2E8v6oxWuA15fbisw15ql1B7KcSHL0dVwBbE19mh44VtF8ZZ1
   PBqEUch1XkoC3v+zrMdIomsUjzLglLEiD3APhS+8Z1GEK4Ksr+v/7oJjb
   kqcp0K+FlxF4tnYk+Js+IRAV2IGJzctm8kyz+EDBiR/yUxsQjQ9cAVanr
   WPnhRhoOf9vfCNXD+2rG0YR/9m/M7+CxaemAdVi6F1f1MoJx6ib1b4T5Q
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="21817367"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="21817367"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 20:08:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="827774098"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="827774098"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga001.jf.intel.com with SMTP; 05 Mar 2024 20:08:10 -0800
Received: by stinkbox (sSMTP sendmail emulation); Wed, 06 Mar 2024 06:08:09 +0200
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: [PATCH 1/3] drm/i915/vrr: Generate VRR "safe window" for DSB
Date: Wed,  6 Mar 2024 06:08:04 +0200
Message-ID: <20240306040806.21697-2-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240306040806.21697-1-ville.syrjala@linux.intel.com>
References: <20240306040806.21697-1-ville.syrjala@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Looks like TRANS_CHICKEN bit 31 means something totally different
depending on the platform:
TGL: generate VRR "safe window" for DSB
ADL/DG2: make TRANS_SET_CONTEXT_LATENCY effective with VRR

So far we've only set this on ADL/DG2, but when using DSB+VRR
we also need to set it on TGL.

And a quick test on MTL says it doesn't need this bit for either
of those purposes, even though it's still documented as valid
in bspec.

Cc: stable@vger.kernel.org
Fixes: 34d8311f4a1c ("drm/i915/dsb: Re-instate DSB for LUT updates")
Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/9927
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_vrr.c | 7 ++++---
 drivers/gpu/drm/i915/i915_reg.h          | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_vrr.c b/drivers/gpu/drm/i915/display/intel_vrr.c
index 5d905f932cb4..eb5bd0743902 100644
--- a/drivers/gpu/drm/i915/display/intel_vrr.c
+++ b/drivers/gpu/drm/i915/display/intel_vrr.c
@@ -187,10 +187,11 @@ void intel_vrr_set_transcoder_timings(const struct intel_crtc_state *crtc_state)
 	enum transcoder cpu_transcoder = crtc_state->cpu_transcoder;
 
 	/*
-	 * TRANS_SET_CONTEXT_LATENCY with VRR enabled
-	 * requires this chicken bit on ADL/DG2.
+	 * This bit seems to have two meanings depending on the platform:
+	 * TGL: generate VRR "safe window" for DSB vblank waits
+	 * ADL/DG2: make TRANS_SET_CONTEXT_LATENCY effective with VRR
 	 */
-	if (DISPLAY_VER(dev_priv) == 13)
+	if (IS_DISPLAY_VER(dev_priv, 12, 13))
 		intel_de_rmw(dev_priv, CHICKEN_TRANS(cpu_transcoder),
 			     0, PIPE_VBLANK_WITH_DELAY);
 
diff --git a/drivers/gpu/drm/i915/i915_reg.h b/drivers/gpu/drm/i915/i915_reg.h
index e00557e1a57f..3b2e49ce29ba 100644
--- a/drivers/gpu/drm/i915/i915_reg.h
+++ b/drivers/gpu/drm/i915/i915_reg.h
@@ -4599,7 +4599,7 @@
 #define MTL_CHICKEN_TRANS(trans)	_MMIO_TRANS((trans), \
 						    _MTL_CHICKEN_TRANS_A, \
 						    _MTL_CHICKEN_TRANS_B)
-#define   PIPE_VBLANK_WITH_DELAY	REG_BIT(31) /* ADL/DG2 */
+#define   PIPE_VBLANK_WITH_DELAY	REG_BIT(31) /* tgl+ */
 #define   SKL_UNMASK_VBL_TO_PIPE_IN_SRD	REG_BIT(30) /* skl+ */
 #define   HSW_FRAME_START_DELAY_MASK	REG_GENMASK(28, 27)
 #define   HSW_FRAME_START_DELAY(x)	REG_FIELD_PREP(HSW_FRAME_START_DELAY_MASK, x)
-- 
2.43.0


