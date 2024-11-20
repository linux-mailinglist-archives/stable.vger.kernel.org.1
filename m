Return-Path: <stable+bounces-94442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDB39D404C
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 17:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D119D284901
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 16:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15190153BED;
	Wed, 20 Nov 2024 16:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kvWNhAAa"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4103A148FE8
	for <stable@vger.kernel.org>; Wed, 20 Nov 2024 16:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732120898; cv=none; b=IsQSc0e+GTA5QKPPIXk/zW13KH7ArwCxFcTuuXzjRSXAGNEijQ6ChOCT0LJB5YMelgJoFtQvyTyZPZSinQKuqpg8aqcXu63SLYnY7NX/D2PeldDQ/YTjuQOIMsaUsAVX4WLjx9XlC0KKGBuCZahF49wACKeqi5TY40g0wLKcFgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732120898; c=relaxed/simple;
	bh=Lp1XsOjfEdnhtE95S3d9mElLCXp65ltf+bTb949N1gA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cSzPTrXsvRo2mcVXLJg+eWpvhQzTGLwz908qTP3XUXbxY1QdYmbBq5s28tvt22jBd78qOSZmfjO/EGXQdYgyqlABHn6jFSzVzfsySzjTAyKrve6+LX3a2DOFDvCAl8Yr22Df4kYCI4FboejHuB/o0oABc5PteeUeoW3FnDR04qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kvWNhAAa; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732120897; x=1763656897;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Lp1XsOjfEdnhtE95S3d9mElLCXp65ltf+bTb949N1gA=;
  b=kvWNhAAaiecyUrj7ooMc9BwWlI6fuDpU1KEXwh8GcxvrikAWgWmKyV4N
   l5qOqlxGo9omPs1f5SdWvir+DsbAEIGC3XF4Vk6KwE9s7eqvFUjrchDSE
   uBwZZe/o8K0glm+nV5VOhU/UCuxPeIyuSvDzudpvrsiJ3dLNK2s5ql5kg
   4N1vNCyQ7gQ3OP7/VeghxkM2VHSaFZAf+JyLqesES5dT7xyHuNcEQpOC7
   MoxD8Wb32GMWpEdDnoxfJBE7CUNrnB0idoNLrT1mYngypQNG3B50t/ZOx
   4gXNJJbOiBnNeJMPnDTfhvTufFRU3C0LvxkRfP4D+se4zHc3VRimg7YHw
   w==;
X-CSE-ConnectionGUID: sHKb2iSuTK66kZ5SfoYcLA==
X-CSE-MsgGUID: z6C/pBnuS9CuklWUy6HoAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="49620315"
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="49620315"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 08:41:31 -0800
X-CSE-ConnectionGUID: 8Bl7c7onSzio3udjPW59BQ==
X-CSE-MsgGUID: qMTWedN2SeWFfZUjz6xghg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="90137166"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 20 Nov 2024 08:41:30 -0800
Received: by stinkbox (sSMTP sendmail emulation); Wed, 20 Nov 2024 18:41:28 +0200
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: [PATCH 2/4] drm/i915/color: Stop using non-posted DSB writes for legacy LUT
Date: Wed, 20 Nov 2024 18:41:21 +0200
Message-ID: <20241120164123.12706-3-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241120164123.12706-1-ville.syrjala@linux.intel.com>
References: <20241120164123.12706-1-ville.syrjala@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

DSB LUT register writes vs. palette anti-collision logic
appear to interact in interesting ways:
- posted DSB writes simply vanish into thin air while
  anti-collision is active
- non-posted DSB writes actually get blocked by the anti-collision
  logic, but unfortunately this ends up hogging the bus for
  long enough that unrelated parallel CPU MMIO accesses start
  to disappear instead

Even though we are updating the LUT during vblank we aren't
immune to the anti-collision logic because it kicks in brifly
for pipe prefill (initiated at frame start). The safe time
window for performing the LUT update is thus between the
undelayed vblank and frame start. Turns out that with low
enough CDCLK frequency (DSB execution speed depends on CDCLK)
we can exceed that.

As we are currently using non-posted writes for the legacy LUT
updates, in which case we can hit the far more severe failure
mode. The problem is exacerbated by the fact that non-posted
writes are much slower than posted writes (~4x it seems).

To mititage the problem let's switch to using posted DSB
writes for legacy LUT updates (which will involve using the
double write approach to avoid other problems with DSB
vs. legacy LUT writes). Despite writing each register twice
this will in fact make the legacy LUT update faster when
compared to the non-posted write approach, making the
problem less likely to appear. The failure mode is also
less severe.

This isn't the 100% solution we need though. That will involve
estimating how long the LUT update will take, and pushing
frame start and/or delayed vblank forward to guarantee that
the update will have finished by the time the pipe prefill
starts...

Cc: stable@vger.kernel.org
Fixes: 34d8311f4a1c ("drm/i915/dsb: Re-instate DSB for LUT updates")
Fixes: 25ea3411bd23 ("drm/i915/dsb: Use non-posted register writes for legacy LUT")
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/12494
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_color.c | 30 ++++++++++++++--------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_color.c b/drivers/gpu/drm/i915/display/intel_color.c
index 6ea3d5c58cb1..7cd902bbd244 100644
--- a/drivers/gpu/drm/i915/display/intel_color.c
+++ b/drivers/gpu/drm/i915/display/intel_color.c
@@ -1368,19 +1368,29 @@ static void ilk_load_lut_8(const struct intel_crtc_state *crtc_state,
 	lut = blob->data;
 
 	/*
-	 * DSB fails to correctly load the legacy LUT
-	 * unless we either write each entry twice,
-	 * or use non-posted writes
+	 * DSB fails to correctly load the legacy LUT unless
+	 * we either write each entry twice when using posted
+	 * writes, or we use non-posted writes.
+	 *
+	 * If palette anti-collision is active during LUT
+	 * register writes:
+	 * - posted writes simply get dropped and thus the LUT
+	 *   contents may not be correctly updated
+	 * - non-posted writes are blocked and thus the LUT
+	 *   contents are always correct, but simultaneous CPU
+	 *   MMIO access will start to fail
+	 *
+	 * Choose the lesser of two evils and use posted writes.
+	 * Using posted writes is also faster, even when having
+	 * to write each register twice.
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


