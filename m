Return-Path: <stable+bounces-192646-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 785BEC3D50F
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 21:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D76E188E3EB
	for <lists+stable@lfdr.de>; Thu,  6 Nov 2025 20:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510953557EB;
	Thu,  6 Nov 2025 20:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jPcapbjS"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F53355053
	for <stable@vger.kernel.org>; Thu,  6 Nov 2025 20:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762459210; cv=none; b=eQY9VBq7Y47ea9nCfdUpRUVx9+TS3u7pIJbV5a1AYtSoDMyvVQEk60L/kjJJfzBEPOyPwQYtDwEs+3kMeIDNWhoS0yNlJ2TIl/grz+WS0wcULY3bJpAlTRA07Ym3pDqHaON7anGznM9LdzzQuBPMFb8LCZwV597oPy1KtRntPNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762459210; c=relaxed/simple;
	bh=fL3c0z32jFUaN92k7QfLdHQCPMSLzrpgyjVR+Jsl5Fk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WvA2fjOUaptNBoKTIRSd+UChwJDLKZn7ecQXaLn00nfpxjFx/Fmm3IdFfniDDPKAZEmHIGpr1sbDQn/dgCEP61vWB7uXiuwmOQiNK/ccTk5asZo6OUZNdf6xaWVtA+1Arp+X1zA+rRCfuVA6C+lfLpPVEinta9Y0VyR8OYyS/WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jPcapbjS; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762459208; x=1793995208;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fL3c0z32jFUaN92k7QfLdHQCPMSLzrpgyjVR+Jsl5Fk=;
  b=jPcapbjSCEChqTRAlmq6AxaxhZa2GPbLC/8dYyIw+hkbmxsmS+sGpWAk
   nhgdJKuuqROTOmYcQxweqAU+M6VeI6ipu141plNA3gTo9kByXS3mcFlIL
   Rj7SQ10+Nfak/Ut7xgV4p59gffut9JoiNQvg+UUy2opIdQLba/gyRejtf
   UQ/CbsVqNM4iZTZeF5ME+75s7IH+NGZXabwXTVyQ/Mqecuh6YW0mKwZRU
   OUvGfYhl84objbXLjb9KBMfm3LT6UOWLREC1ttVoxhS+cQxSbudMFmrWB
   a8Z8A1cTiMwW4LoXW/E0+WdaeoR4Y2x//2Ns2lHiZKMF88okPHxNARfBs
   g==;
X-CSE-ConnectionGUID: suuxn5htTK+HEtUmFwULBw==
X-CSE-MsgGUID: +5++l92ER+mJQSiVGcYRCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="64645483"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="64645483"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 12:00:07 -0800
X-CSE-ConnectionGUID: djilhG0LTp2sfhGAFgE8SQ==
X-CSE-MsgGUID: QOuSdItQThyXqNemjJXRHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="187106026"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.65])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 12:00:04 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: jani.nikula@intel.com,
	=?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/psr: fix pipe to vblank conversion
Date: Thu,  6 Nov 2025 22:00:00 +0200
Message-ID: <20251106200000.1455164-1-jani.nikula@intel.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit

First, we can't assume pipe == crtc index. If a pipe is fused off in
between, it no longer holds. intel_crtc_for_pipe() is the only proper
way to get from a pipe to the corresponding crtc.

Second, drivers aren't supposed to access or index drm->vblank[]
directly. There's drm_crtc_vblank_crtc() for this.

Use both functions to fix the pipe to vblank conversion.

Fixes: f02658c46cf7 ("drm/i915/psr: Add mechanism to notify PSR of pipe enable/disable")
Cc: Jouni Högander <jouni.hogander@intel.com>
Cc: <stable@vger.kernel.org> # v6.16+
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/display/intel_psr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 05014ffe3ce1..c77a92ea7919 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -932,7 +932,8 @@ static bool is_dc5_dc6_blocked(struct intel_dp *intel_dp)
 {
 	struct intel_display *display = to_intel_display(intel_dp);
 	u32 current_dc_state = intel_display_power_get_current_dc_state(display);
-	struct drm_vblank_crtc *vblank = &display->drm->vblank[intel_dp->psr.pipe];
+	struct intel_crtc *crtc = intel_crtc_for_pipe(display, intel_dp->psr.pipe);
+	struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(&crtc->base);
 
 	return (current_dc_state != DC_STATE_EN_UPTO_DC5 &&
 		current_dc_state != DC_STATE_EN_UPTO_DC6) ||
-- 
2.47.3


