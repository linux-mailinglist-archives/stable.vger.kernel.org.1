Return-Path: <stable+bounces-89369-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5960A9B6E66
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 22:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B48D1C20BBF
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 21:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FD71EF940;
	Wed, 30 Oct 2024 21:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a/HnXUdP"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E9114F90
	for <stable@vger.kernel.org>; Wed, 30 Oct 2024 21:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730322476; cv=none; b=c8yUD1w7RgbmYFd00fiGmrMJZi+2/R5kzAqPZe7HU6kP6JZ57zApcRMW43C+pVkrMUTHXEO5tU1Ths688tkoBF9CpJ1euh73uYdpQoeZkTNmCpsi3RLcxAGhbPDrXBCxRLuY3CIcHanunG0kCwWNOrS0WCpiMApTtIZ/qh2bXmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730322476; c=relaxed/simple;
	bh=iyugDT8KwE3v90s8BHydvH0MvQMrAVgSaemFzpK91IE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TbPehYfwvYlaez5r+vwC1HenpUipWgWVK5iSUK1pu6gudfEfREIR0FweZquzd2iFzimxPHqXI/4iFBaxwg1QhYa4VMRRZANRl9klyDkoDYreORlZ7h0lpkToPrM4METFJYNC6RpwzYw4Pg6nj+FEmX1wUaGY6yZqmLG1DW/k7pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a/HnXUdP; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730322474; x=1761858474;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iyugDT8KwE3v90s8BHydvH0MvQMrAVgSaemFzpK91IE=;
  b=a/HnXUdPvhV/XnV9g1e5QW4SD5a004eP/gIjds3rofJoPyJzV2QMQrqQ
   JxPleiIOfFvZJT4bLb6HiuwfCKHbXmPivuaoHHbI2eVvVsDb8bpZc5bV5
   Y+iGgGH7zOw2kDv2p5hJdiuzvs2+v1EMa0vcMAA44ZfwM+iFzNqlxH8dh
   wMuAwmSpPL+i2hDQ6I13o1yE7W6Ku7zUkrUdRKUdXGInDdzbC/putWUSg
   iMZcGVGyNuqGKBQn15e6rWETW4Qaq1Ce+vHKVwkqefHdX91CFFKV+2ARK
   1KWXvOTuU+8zcQ5Uy5VlfwM50ZBYAD3qhMp6ulld13hgu8sMrHhuHxQvK
   g==;
X-CSE-ConnectionGUID: yO+O8ETRRdSM+sLDAApaaA==
X-CSE-MsgGUID: JRgNj44CSoCf4VsQu/jqOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="29490596"
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="29490596"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 14:07:53 -0700
X-CSE-ConnectionGUID: Yy0i89OwRJCBnWB8QphNOg==
X-CSE-MsgGUID: w7XGJw3cQWi0mBcM4lLHLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="82550507"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 30 Oct 2024 14:07:51 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 30 Oct 2024 23:07:50 +0200
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: [PATCH] drm/i915/color: Stop using non-posted DSB writes for legacy LUT
Date: Wed, 30 Oct 2024 23:07:50 +0200
Message-ID: <20241030210750.6550-1-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Apparently using non-posted DSB writes to update the legacy
LUT can cause CPU MMIO accesses to fail on TGL. Stop using
them for the legacy LUT updates, and instead switch to using
the double write approach (which is the other empirically
found workaround for the issue of DSB failing to correctly
update the legacy LUT).

Cc: stable@vger.kernel.org
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/12494
Fixes: 25ea3411bd23 ("drm/i915/dsb: Use non-posted register writes for legacy LUT")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_color.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_color.c b/drivers/gpu/drm/i915/display/intel_color.c
index 174753625bca..aa50ecaf368d 100644
--- a/drivers/gpu/drm/i915/display/intel_color.c
+++ b/drivers/gpu/drm/i915/display/intel_color.c
@@ -1357,19 +1357,19 @@ static void ilk_load_lut_8(const struct intel_crtc_state *crtc_state,
 	lut = blob->data;
 
 	/*
-	 * DSB fails to correctly load the legacy LUT
-	 * unless we either write each entry twice,
-	 * or use non-posted writes
+	 * DSB fails to correctly load the legacy LUT unless
+	 * we either write each entry twice, or use non-posted
+	 * writes. However using non-posted writes can cause
+	 * CPU MMIO accesses to fail on TGL, so we choose to
+	 * use the double write approach.
 	 */
-	if (crtc_state->dsb_color_vblank)
-		intel_dsb_nonpost_start(crtc_state->dsb_color_vblank);
-
-	for (i = 0; i < 256; i++)
+	for (i = 0; i < 256; i++) {
 		ilk_lut_write(crtc_state, LGC_PALETTE(pipe, i),
 			      i9xx_lut_8(&lut[i]));
-
-	if (crtc_state->dsb_color_vblank)
-		intel_dsb_nonpost_end(crtc_state->dsb_color_vblank);
+		if (crtc_state->dsb_color_vblank)
+			ilk_lut_write(crtc_state, LGC_PALETTE(pipe, i),
+				      i9xx_lut_8(&lut[i]));
+	}
 }
 
 static void ilk_load_lut_10(const struct intel_crtc_state *crtc_state,
-- 
2.45.2


