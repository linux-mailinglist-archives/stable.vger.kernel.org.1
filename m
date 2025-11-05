Return-Path: <stable+bounces-192530-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C05C37051
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 18:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5030D1A271E3
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 17:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B27214812;
	Wed,  5 Nov 2025 17:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jnJUvHG1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EFF331A4B
	for <stable@vger.kernel.org>; Wed,  5 Nov 2025 17:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762362633; cv=none; b=Lg49CX2PCAHsIzOeaqb+VufOITOTXycoaBLwmplPQbivB0LjTesm+fYn3up0BwW3XqaQbHdgHmAf9/2FLWiymy5wNqj2Jt8Psp0i5VMKiQdx6m6zQ1wk+vYgF+IkhmmRtXfd+SfblmLyh8pL+mbJNd3wADZkPVnoLmoJYdQiLqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762362633; c=relaxed/simple;
	bh=e40xFR6tQfR7PJ5Wsjq2Qgq1xP5o8XykAqV6jk3uYIE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XNEDfYVMBqt25OgfWrkRSzE7tv7BNssnwxVOj0BJ52umatSKna1IWtP3DTwrXa4ptDSN6+ZcdDL592+5pM3pwpT1oNxMhNbT1E8E3BQZFpFW7meeySub3ork8io5b3EFuwlrylhyeYzVr8Q+dqxsT7OvbAHJfFEq1Oi6msHctMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jnJUvHG1; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762362632; x=1793898632;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=e40xFR6tQfR7PJ5Wsjq2Qgq1xP5o8XykAqV6jk3uYIE=;
  b=jnJUvHG1PXpe5HKoVUCb/kyQj61pf8cW9pZ0yPK9/zMLI5QEW7/iKQnu
   VkrqO8jjsbqxYfMByVRseEDWZ0FoDINftEFbPktq47ccowPxbmgQPurL+
   7GGeo7Ky6Md3EePNsdpDxFFoW+yEIZ2XBqJvN84H8J+3SIqjBW04sYoT8
   M43hhhJs2WCi+0s5pno6zYrJtVUdb/3E/y7TcPKnxrERhJJdVYKWhhQ24
   nGa+rMqzHncCaPCZ2uAqlX8dd8GyizAla3GbURIc2r4qO65ceqIL9DRoY
   1dZos+q5NqFb+YcOFriz+HItxWaEkODQ0VgD0cwxK7ey0eQRr40eEf8qw
   A==;
X-CSE-ConnectionGUID: ZvrbjVWBTpik118kPu5N5Q==
X-CSE-MsgGUID: FheYzmXFTB+Fo3macME+uQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="68323107"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="68323107"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 09:10:19 -0800
X-CSE-ConnectionGUID: Slyr9WPCS9mkMWzl/9S0+g==
X-CSE-MsgGUID: hXWzaHjIQL+9jfglbQ6EyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="187354703"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.87])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 09:10:17 -0800
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/psr: Reject async flips when selective fetch is enabled
Date: Wed,  5 Nov 2025 19:10:15 +0200
Message-ID: <20251105171015.22234-1-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

The selective fetch code doesn't handle asycn flips correctly.
There is a nonsense check for async flips in
intel_psr2_sel_fetch_config_valid() but that only gets called
for modesets/fastsets and thus does nothing for async flips.

Currently intel_async_flip_check_hw() is very unhappy as the
selective fetch code pulls in planes that are not even async
flips capable.

Reject async flips when selective fetch is enabled, until
someone fixes this properly (ie. disable selective fetch while
async flips are being issued).

Cc: stable@vger.kernel.org
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_display.c | 8 ++++++++
 drivers/gpu/drm/i915/display/intel_psr.c     | 6 ------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index 42ec78798666..10583592fefe 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -6020,6 +6020,14 @@ static int intel_async_flip_check_uapi(struct intel_atomic_state *state,
 		return -EINVAL;
 	}
 
+	/* FIXME: selective fetch should be disabled for async flips */
+	if (new_crtc_state->enable_psr2_sel_fetch) {
+		drm_dbg_kms(display->drm,
+			    "[CRTC:%d:%s] async flip disallowed with PSR2 selective fetch\n",
+			    crtc->base.base.id, crtc->base.name);
+		return -EINVAL;
+	}
+
 	for_each_oldnew_intel_plane_in_state(state, plane, old_plane_state,
 					     new_plane_state, i) {
 		if (plane->pipe != crtc->pipe)
diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 05014ffe3ce1..65d77aea9536 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -1296,12 +1296,6 @@ static bool intel_psr2_sel_fetch_config_valid(struct intel_dp *intel_dp,
 		return false;
 	}
 
-	if (crtc_state->uapi.async_flip) {
-		drm_dbg_kms(display->drm,
-			    "PSR2 sel fetch not enabled, async flip enabled\n");
-		return false;
-	}
-
 	return crtc_state->enable_psr2_sel_fetch = true;
 }
 
-- 
2.49.1


