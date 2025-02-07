Return-Path: <stable+bounces-114313-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78958A2D01A
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 22:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94D34188E03F
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 21:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030DF1DC747;
	Fri,  7 Feb 2025 21:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XhJiT77k"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B17D1CD213
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 21:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738965254; cv=none; b=ORmBD7P194XJNAPTwLr+qR2zhyHAhyzB2VezXoR8xm3I/TiuT3fN475cxwu6dfuvWdGNb8vwYhMJhmqzxR7goVN98dgzeqlVynT+bOd/BIG/Ak5BuuYYvQwtaU0jk2Al761AADg9dKerifHrl8vJch88LjrJdXZnD6y+tXffxMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738965254; c=relaxed/simple;
	bh=/N22X57dfIawpmK9XKXDhSiFTLAacsMuQ22BMcBjiMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YF1Tc8DJUx0YT72vNdUrNcOvxbI7fgEmSXWbKM128LPe7dAriZLuVf0/ECZjTlzq5WSgbSmhiTTdRmh64gXFJ+PRc3odqyhN8+ebfyYYyHrj+7epkLbc9+3Dw+ZL5nYDRYyJW0fPgSrazVzw9rk1w+04PBSfs/q64eD1mulyipI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XhJiT77k; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738965253; x=1770501253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/N22X57dfIawpmK9XKXDhSiFTLAacsMuQ22BMcBjiMs=;
  b=XhJiT77ksAyL/Bwx+P0Vk/SlIqsW9hUtt2FqUk98eWIyankCkjmngW+0
   5yhpdBxyyg7iFlH4XWaP9XmGSmyUzceL3Z3tcLMCJOFcQmKhxOkSFvIdx
   Q6oJY14UCn5Sjf0on7hJbspKlUJUuMjjJFvc9bU0Wn8cyKWhI3XoT9w7m
   BrrC39gy4SNZaUf7dM8r5mWvWHz3OORmshgFBx3CGalc9Ew7c6kxEAQc5
   ns1ag1uPs9IogN0FPQO4QG0HbeOhtTuMmRu0z66jp+Yto/SZdwDlhkBgC
   EiFPeW9bpKo/Mau3R57cfvCyJp9mY4Bztn4AgbxU/vJQW4UPL9an4zNIk
   g==;
X-CSE-ConnectionGUID: pMjM432pSlWum1J8hFaSxA==
X-CSE-MsgGUID: Ow00+FfXQh+3rKNaQ7v9Wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="39745985"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="39745985"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 13:54:13 -0800
X-CSE-ConnectionGUID: 39d1LmgTTBiaSr+VitbELA==
X-CSE-MsgGUID: l23nMjTbTTewpH2M9v+VRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="111851036"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 07 Feb 2025 13:54:10 -0800
Received: by stinkbox (sSMTP sendmail emulation); Fri, 07 Feb 2025 23:54:09 +0200
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: [PATCH 1/3] drm/i915: Fix scanline_offset for LNL+ and BMG+
Date: Fri,  7 Feb 2025 23:54:04 +0200
Message-ID: <20250207215406.19348-2-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250207215406.19348-1-ville.syrjala@linux.intel.com>
References: <20250207215406.19348-1-ville.syrjala@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Turns out LNL+ and BMG+ no longer have the weird extra scanline
offset for HDMI outputs. Fix intel_crtc_scanline_offset()
accordingly so that scanline evasion/etc. works correctly on
HDMI outputs on these new platforms.

Cc: stable@vger.kernel.org
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_vblank.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_vblank.c b/drivers/gpu/drm/i915/display/intel_vblank.c
index 4efd4f7d497a..7b240ce681a0 100644
--- a/drivers/gpu/drm/i915/display/intel_vblank.c
+++ b/drivers/gpu/drm/i915/display/intel_vblank.c
@@ -222,7 +222,9 @@ int intel_crtc_scanline_offset(const struct intel_crtc_state *crtc_state)
 	 * However if queried just before the start of vblank we'll get an
 	 * answer that's slightly in the future.
 	 */
-	if (DISPLAY_VER(display) == 2)
+	if (DISPLAY_VER(display) >= 20 || display->platform.battlemage)
+		return 1;
+	else if (DISPLAY_VER(display) == 2)
 		return -1;
 	else if (HAS_DDI(display) && intel_crtc_has_type(crtc_state, INTEL_OUTPUT_HDMI))
 		return 2;
-- 
2.45.3


