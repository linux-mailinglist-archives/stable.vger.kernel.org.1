Return-Path: <stable+bounces-115071-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB91CA32C1C
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 17:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB9657A2409
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 16:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFB8254AE9;
	Wed, 12 Feb 2025 16:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T5EbU05a"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDDA2505B3
	for <stable@vger.kernel.org>; Wed, 12 Feb 2025 16:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739378618; cv=none; b=ZVFa6LY3FPRskSr2VceteY1P4uBmDA+5B/VsfvagX5OxgFH0PSedyP0aNRKCrySNJas6h/7YXiPMQkelhXGn2xF//Ji+qSq22A4va/hGX/+71OpgP4h+hHmkxMoBJjav6DSrnSVtS3OcB4WpdHShGMgTMTnGdijRFe5z34IuXRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739378618; c=relaxed/simple;
	bh=YrnPSpVf2jwz+B6WC7wmulzFUtAP3wiQuTGPAXskFYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GmkAtb4cyUk9xxOEh7ANdvPnZRbd3jfJnbCN+G5yZ9F6bpFOtS2Cg5cNXqeODHiRQ4ciEpS17uxYQwwgGDLDXC/tfgtT8m22cC/6Cuxw4A8KpCI48wAoCeo1OVxWvi+XMGHoYl4zyk4p1sgkuphzcDj4zNi2cqO+hUqslqsohSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T5EbU05a; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739378617; x=1770914617;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YrnPSpVf2jwz+B6WC7wmulzFUtAP3wiQuTGPAXskFYo=;
  b=T5EbU05aGcwSNR3/5+SFPsOYt4FDWYGzl7D3Od0/tyQQ3GmLnDozr974
   tF6cKhjckpxdfiiiDoQ2v2HbsgqRXK48P5AFQlmCYRSF3YH6IyAJEwYWN
   LNmmJE+2snfHRlmCokHkycbM/p16L1iX0qRQcGm7je433hPKtu901Ec8K
   IX2DvQOHAHcvNRD4Y3IozerYPwl4bctZeYrz0hSRYyyoB3KuYuAuKSU4y
   y6QuRjOFVjiTCmTQmIQh6EC3+hIoKWq+is9uN1i0Qkjop0mD7e36b0tch
   lKLW6v//ZqCQaUPre5gotPlA9sWX7/8v+ALlPiRQdp1iWrFBiBYhLyBY7
   Q==;
X-CSE-ConnectionGUID: Jaio/ALgRJm86cAldvyrXw==
X-CSE-MsgGUID: 3wvRz0y5RX+fTkadFi3z/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="62514958"
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="62514958"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 08:43:36 -0800
X-CSE-ConnectionGUID: V+5/N6VjTCaflTlkssT+yQ==
X-CSE-MsgGUID: 9pWfsUldTrS2ilKR7VqLOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="113082575"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 12 Feb 2025 08:43:34 -0800
Received: by stinkbox (sSMTP sendmail emulation); Wed, 12 Feb 2025 18:43:33 +0200
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [PATCH v2 01/10] drm/i915: Make sure all planes in use by the joiner have their crtc included
Date: Wed, 12 Feb 2025 18:43:21 +0200
Message-ID: <20250212164330.16891-2-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250212164330.16891-1-ville.syrjala@linux.intel.com>
References: <20250212164330.16891-1-ville.syrjala@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Any active plane needs to have its crtc included in the atomic
state. For planes enabled via uapi that is all handler in the core.
But when we use a plane for joiner the uapi code things the plane
is disabled and therefore doesn't have a crtc. So we need to pull
those in by hand. We do it first thing in
intel_joiner_add_affected_crtcs() so that any newly added crtc will
subsequently pull in all of its joined crtcs as well.

The symptoms from failing to do this are:
- duct tape in the form of commit 1d5b09f8daf8 ("drm/i915: Fix NULL
  ptr deref by checking new_crtc_state")
- the plane's hw state will get overwritten by the disabled
  uapi state if it can't find the uapi counterpart plane in
  the atomic state from where it should copy the correct state

Cc: stable@vger.kernel.org
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_display.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index 6c1e7441313e..22bf46be2ca9 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -6695,12 +6695,30 @@ static int intel_async_flip_check_hw(struct intel_atomic_state *state, struct in
 static int intel_joiner_add_affected_crtcs(struct intel_atomic_state *state)
 {
 	struct drm_i915_private *i915 = to_i915(state->base.dev);
+	const struct intel_plane_state *plane_state;
 	struct intel_crtc_state *crtc_state;
+	struct intel_plane *plane;
 	struct intel_crtc *crtc;
 	u8 affected_pipes = 0;
 	u8 modeset_pipes = 0;
 	int i;
 
+	/*
+	 * Any plane which is in use by the joiner needs its crtc.
+	 * Pull those in first as this will not have happened yet
+	 * if the plane remains disabled according to uapi.
+	 */
+	for_each_new_intel_plane_in_state(state, plane, plane_state, i) {
+		crtc = to_intel_crtc(plane_state->hw.crtc);
+		if (!crtc)
+			continue;
+
+		crtc_state = intel_atomic_get_crtc_state(&state->base, crtc);
+		if (IS_ERR(crtc_state))
+			return PTR_ERR(crtc_state);
+	}
+
+	/* Now pull in all joined crtcs */
 	for_each_new_intel_crtc_in_state(state, crtc, crtc_state, i) {
 		affected_pipes |= crtc_state->joiner_pipes;
 		if (intel_crtc_needs_modeset(crtc_state))
-- 
2.45.3


