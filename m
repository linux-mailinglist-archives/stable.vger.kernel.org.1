Return-Path: <stable+bounces-110882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15104A1DB2F
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 18:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58D701889719
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 17:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523F818A6D7;
	Mon, 27 Jan 2025 17:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G/u8ZG6e"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245397DA6A
	for <stable@vger.kernel.org>; Mon, 27 Jan 2025 17:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737998525; cv=none; b=B6swn8Fl4CTVQX/J/KiA1zo8cpPKwnOwWxo64Plc8yYJAqIChZ540pTup6a8JcaO6AjeITCxJ0wpTxEPEAHlePpYfPsOruX9Mck6If7bcUmjqEBERmfbJdsB2hynxAGS/zt3Vxx1A3H4kRiQw+VV8rUwMAjq66ZCfK2yMuhVceM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737998525; c=relaxed/simple;
	bh=P3Gszlz4xLYuT0ZVy9z99gNgTYlSg48w9P7o+uZtvq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZ0y22jrC7m0L6mdI8ia8tDGM3u5qDdIsZM5RqeoIMftyM1iXzm/GIWSX6A4F/Ett53LtJ3JD4gRnY6os7T9wjygPb8N4H8sRA5qouT6m5xveQDIHtz19wnIZVP/5yK8gKO3UoxLhTVUaANgxZlt26PIRZ+s2VsGWdL+X2KvWkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G/u8ZG6e; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737998523; x=1769534523;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P3Gszlz4xLYuT0ZVy9z99gNgTYlSg48w9P7o+uZtvq8=;
  b=G/u8ZG6e5JE4XO9BQUTV89aQaNvhFvSr41IwYIjTJd57+xdxZMQ7OQbY
   uRXlAAO/u31BCJB9PHqaruDSn0UlBWn6mS8woWx9Bj9f0QJtNgeg6qwaz
   ZzqcHhXhRiSp283yUOY9Q8tR1kNwLLczQgrnlJCMN7Ut/hlqswe3jHSA+
   GAn/QqvrNTCpE+AWr4JuB7gTWd2a6d1Cud1VHH55tQrx8ScBu8KZWtDae
   PcmAyxbgGWckvU2a1rYQr/sFawYidAwVOD8UEb7O9hTcGh/gEFCnvpmIi
   VRy8Xp9nN0XXs+3m3ATeP2ChsapJgAwIg2DJVsqVNiJ7TehZqIRdE+HpI
   g==;
X-CSE-ConnectionGUID: 7Yop9vLOTbiyLcTvXO2TTQ==
X-CSE-MsgGUID: +iOHZLJCQgaxqUUiUEE/Qw==
X-IronPort-AV: E=McAfee;i="6700,10204,11328"; a="38501378"
X-IronPort-AV: E=Sophos;i="6.13,239,1732608000"; 
   d="scan'208";a="38501378"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 09:22:02 -0800
X-CSE-ConnectionGUID: z7MG5m1UTPyLyykihObxkw==
X-CSE-MsgGUID: zFwszp9jTZWDB3UdaO22NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,239,1732608000"; 
   d="scan'208";a="108610181"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 27 Jan 2025 09:22:00 -0800
Received: by stinkbox (sSMTP sendmail emulation); Mon, 27 Jan 2025 19:21:59 +0200
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: [PATCH 01/11] drm/i915: Make sure all planes in use by the joiner have their crtc included
Date: Mon, 27 Jan 2025 19:21:46 +0200
Message-ID: <20250127172156.21928-2-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250127172156.21928-1-ville.syrjala@linux.intel.com>
References: <20250127172156.21928-1-ville.syrjala@linux.intel.com>
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
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_display.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index 7d68d652c1bc..2b31c8f4b7cd 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -6682,12 +6682,30 @@ static int intel_async_flip_check_hw(struct intel_atomic_state *state, struct in
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


