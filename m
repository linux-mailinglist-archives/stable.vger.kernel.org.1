Return-Path: <stable+bounces-32219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD88E88B3F3
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 23:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3F36B45B50
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 18:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A744E1AD;
	Mon, 25 Mar 2024 17:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N6EcQRhL"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DA94D9FD
	for <stable@vger.kernel.org>; Mon, 25 Mar 2024 17:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711389463; cv=none; b=FNoa6oPLE92yo9UFGCmQsjVAbnnCgAJPNC6jTBqVL9eEUkGHyWGzCL43yMHYIGTiUM4CJCM6em42GHEOYEhn0sdVtA6gRNkBAvmYXwkWp8raQv0Bu/4Xx49+fYcCf8Da0TR3qBIZqoH44DcPX+PSd374Eq06H3A2SUQXVfr8yKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711389463; c=relaxed/simple;
	bh=TMu6A9T8MaNgOPzZjzWo7JRhNbLv/gHUBXQ9NEZ5FfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yph2V/Ukvy3ZZ6iiUa5leMzl20daVzvKuF9bZt+C5VBhwIWf3y3wmBmIKUE3kXHE854Ux+CERBqxh/AR+GgLW/YxAKM+BLUm6U+IDxCS+A+436r9e/WeRiZdy9+70/HEAkk0YX9ZY+QNx9lxJakEMPRZSegLk22j1LpIcD9bWds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N6EcQRhL; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711389462; x=1742925462;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TMu6A9T8MaNgOPzZjzWo7JRhNbLv/gHUBXQ9NEZ5FfA=;
  b=N6EcQRhLqwfSwHVdYKzw0mXR5KJO0jlQsHtuKF653jJAhwzWcLWTPmeP
   VHZF7XPxszGdSSncTh2QwcljG3agEjYAycA9et68N7JEbAJHS2yFxCHpM
   DsOhhLnGvqnx6IQWVlTLbIWA1wbYSGhPt99/6qEGknhvSzeMJ+eJ1Zf07
   1qyNh92Ewg/IykINobIQy6EdKIgsj1Z15zjCFh6W7X9yrUcPeS/L+2FtO
   RpYSiKEIZ49tWqO/zQPliRz4GnuueCQ3TB/YwhdbojBvvJouShPkQNu6I
   z45pcXTwYhyTAWqKgSvY/F76x0zVujyWjud9nxX8hR2hjpE29KpLFuiaj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="10205462"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="10205462"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 10:57:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="827784780"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="827784780"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga001.jf.intel.com with SMTP; 25 Mar 2024 10:57:38 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 25 Mar 2024 19:57:38 +0200
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>
Subject: [PATCH] drm/i915: Pre-populate the cursor physical dma address
Date: Mon, 25 Mar 2024 19:57:38 +0200
Message-ID: <20240325175738.3440-1-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Calling i915_gem_object_get_dma_address() from the vblank
evade critical section triggers might_sleep().

While we know that we've already pinned the framebuffer
and thus i915_gem_object_get_dma_address() will in fact
not sleep in this case, it seems reasonable to keep the
unconditional might_sleep() for maximum coverage.

So let's instead pre-populate the dma address during
fb pinning, which all happens before we enter the
vblank evade critical section.

We can use u32 for the dma address as this class of
hardware doesn't support >32bit addresses.

Cc: stable@vger.kernel.org
Fixes: 0225a90981c8 ("drm/i915: Make cursor plane registers unlocked")
Link: https://lore.kernel.org/intel-gfx/20240227100342.GAZd2zfmYcPS_SndtO@fat_crate.local/
Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_cursor.c        |  4 +---
 drivers/gpu/drm/i915/display/intel_display_types.h |  1 +
 drivers/gpu/drm/i915/display/intel_fb_pin.c        | 10 ++++++++++
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_cursor.c b/drivers/gpu/drm/i915/display/intel_cursor.c
index f8b33999d43f..0d3da55e1c24 100644
--- a/drivers/gpu/drm/i915/display/intel_cursor.c
+++ b/drivers/gpu/drm/i915/display/intel_cursor.c
@@ -36,12 +36,10 @@ static u32 intel_cursor_base(const struct intel_plane_state *plane_state)
 {
 	struct drm_i915_private *dev_priv =
 		to_i915(plane_state->uapi.plane->dev);
-	const struct drm_framebuffer *fb = plane_state->hw.fb;
-	struct drm_i915_gem_object *obj = intel_fb_obj(fb);
 	u32 base;
 
 	if (DISPLAY_INFO(dev_priv)->cursor_needs_physical)
-		base = i915_gem_object_get_dma_address(obj, 0);
+		base = plane_state->phys_dma_addr;
 	else
 		base = intel_plane_ggtt_offset(plane_state);
 
diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index 8a35fb6b2ade..68f26a33870b 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -728,6 +728,7 @@ struct intel_plane_state {
 #define PLANE_HAS_FENCE BIT(0)
 
 	struct intel_fb_view view;
+	u32 phys_dma_addr; /* for cursor_needs_physical */
 
 	/* Plane pxp decryption state */
 	bool decrypt;
diff --git a/drivers/gpu/drm/i915/display/intel_fb_pin.c b/drivers/gpu/drm/i915/display/intel_fb_pin.c
index 7b42aef37d2f..b6df9baf481b 100644
--- a/drivers/gpu/drm/i915/display/intel_fb_pin.c
+++ b/drivers/gpu/drm/i915/display/intel_fb_pin.c
@@ -255,6 +255,16 @@ int intel_plane_pin_fb(struct intel_plane_state *plane_state)
 			return PTR_ERR(vma);
 
 		plane_state->ggtt_vma = vma;
+
+		/*
+		 * Pre-populate the dma address before we enter the vblank
+		 * evade critical section as i915_gem_object_get_dma_address()
+		 * will trigger might_sleep() even if it won't actually sleep,
+		 * which is the case when the fb has already been pinned.
+		 */
+		if (phys_cursor)
+			plane_state->phys_dma_addr =
+				i915_gem_object_get_dma_address(intel_fb_obj(fb), 0);
 	} else {
 		struct intel_framebuffer *intel_fb = to_intel_framebuffer(fb);
 
-- 
2.43.2


