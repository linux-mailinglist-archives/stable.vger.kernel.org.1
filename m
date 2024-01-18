Return-Path: <stable+bounces-12219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B521E8320D5
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 22:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DDA91F23FC5
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 21:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6B831758;
	Thu, 18 Jan 2024 21:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X3hvUqRf"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F9D2E405
	for <stable@vger.kernel.org>; Thu, 18 Jan 2024 21:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705612898; cv=none; b=SFrWsBZgkIXS92Sz5KZyFfBxWvDACoOeGF/viVyyerji7ybzAqQ9vxt3Y66Opt6zb45DOJfJKsC+HQrrXT2TOesbLLW8/8NrZHPHPJyoggYKdQ6J/gpOFIhqxnyQev1352lUCMZq3IFwj+W4cCTEdf3A8l6QtqvOyymEINpnEvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705612898; c=relaxed/simple;
	bh=nxAoPH/9xOf9RPzzSMosGSznbNrSwa9TR1GaunXRfrI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XqijtM0SU99sBGLWTHTInrhDSQ0CirQVwBKHbj4VPYeb3biryhan7f3c3lxIJOnhuNbvE2g6i0OKMKKPtlQXWk0rogAZAxCwU0zw2tVN3S2VDUKMXZez02wBdyrQvag2rKRhUqJR06CS4NBszRpdtLqHbkh+LdSjVAvOex4fQaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X3hvUqRf; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705612896; x=1737148896;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nxAoPH/9xOf9RPzzSMosGSznbNrSwa9TR1GaunXRfrI=;
  b=X3hvUqRfgNAV53VwcrPf5NBHADwhDgnLjI4uUArJIJBxyczqaR0XkUqR
   c+ce/9AuwSmhQlReWvjpEsBpRGLnw+3OMmpj6nsZI/nP5Ty7EP2COTaEM
   RDLBnhcIiwErY9wovy6IyAm5tKi7ifuv5iH4io1b8qGpM+2m20DnLqD0n
   dvt9fLISJIaB0pBEt7Trn2kICEjc7dYMeiAYixxUqW0y+g+eof6Ueri+T
   sezyPVeDRriXhvVkfS5A3djXycOC0CmnbmhWIQb2ovQtB4dKaldaOZAQy
   gUPZ/L8opF2mIxKOiUgKZaRszkH5fENlD0CD6BB4Uae0zkFcuOaJgWVey
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="7290082"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="7290082"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 13:21:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="777826256"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="777826256"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga007.jf.intel.com with SMTP; 18 Jan 2024 13:21:32 -0800
Received: by stinkbox (sSMTP sendmail emulation); Thu, 18 Jan 2024 23:21:31 +0200
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: [PATCH] drm/i915/psr: Only allow PSR in LPSP mode on HSW non-ULT
Date: Thu, 18 Jan 2024 23:21:31 +0200
Message-ID: <20240118212131.31868-1-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

On HSW non-ULT (or at least on Dell Latitude E6540) external displays
start to flicker when we enable PSR on the eDP. We observe a much higher
SR and PC6 residency than should be possible with an external display,
and indeen much higher than what we observe with eDP disabled and
only the external display enabled. Looks like the hardware is somehow
ignoring the fact that the external display is active during PSR.

I wasn't able to redproduce this on my HSW ULT machine, or BDW.
So either there's something specific about this particular laptop
(eg. some unknown firmware thing) or the issue is limited to just
non-ULT HSW systems. All known registers that could affect this
look perfectly reasonable on the affected machine.

As a workaround let's unmask the LPSP event to prevent PSR entry
except while in LPSP mode (only pipe A + eDP active). This
will prevent PSR entry entirely when multiple pipes are active.
The one slight downside is that we now also prevent PSR entry
when driving eDP with pipe B or C, but I think that's a reasonable
tradeoff to avoid having to implement a more complex workaround.

Cc: stable@vger.kernel.org
Fixes: 783d8b80871f ("drm/i915/psr: Re-enable PSR1 on hsw/bdw")
Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/10092
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_psr.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 696d5d32ca9d..1010b8c405df 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -1544,8 +1544,18 @@ static void intel_psr_enable_source(struct intel_dp *intel_dp,
 	 * can rely on frontbuffer tracking.
 	 */
 	mask = EDP_PSR_DEBUG_MASK_MEMUP |
-	       EDP_PSR_DEBUG_MASK_HPD |
-	       EDP_PSR_DEBUG_MASK_LPSP;
+	       EDP_PSR_DEBUG_MASK_HPD;
+
+	/*
+	 * For some unknown reason on HSW non-ULT (or at least on
+	 * Dell Latitude E6540) external displays start to flicker
+	 * when PSR is enabled on the eDP. SR/PC6 residency is much
+	 * higher than should be possible with an external display.
+	 * As a workaround leave LPSP unmasked to prevent PSR entry
+	 * when external displays are active.
+	 */
+	if (DISPLAY_VER(dev_priv) >= 8 || IS_HASWELL_ULT(dev_priv))
+		mask |= EDP_PSR_DEBUG_MASK_LPSP;
 
 	if (DISPLAY_VER(dev_priv) < 20)
 		mask |= EDP_PSR_DEBUG_MASK_MAX_SLEEP;
-- 
2.41.0


