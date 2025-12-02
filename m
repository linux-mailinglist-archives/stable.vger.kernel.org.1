Return-Path: <stable+bounces-198132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 236AAC9CAB8
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 19:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B1C704E13B2
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 18:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830AF2D1F4E;
	Tue,  2 Dec 2025 18:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c2htYjrn"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7654D2C0297
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 18:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764700799; cv=none; b=uGLRoAzphJa7J2HxqvVtQ7H5+fYSnyJvgf2LUPGaYsnqlKf+E+RoaorSDl/uypt51kDwF1iF2clhkUCPrUX+aG0YsyUOAenzj77HN7h1i2GdqUQ06ouOQkkLI0lEDu9SmVutqBSNbZXFR3FV0Qp0hIFTO/76YLmS19LKcL1zN2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764700799; c=relaxed/simple;
	bh=9Ul08rqPczUY9Bogxe3yXyfTFe2bGnh040pIQDGuCns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gyJox9zKgZW2PJZh+FbTLf/jIj7r2GBhG5OD6roBZ415NYLhG8NuoSk3DUp9qBUKxUKQPVLuP1Da3lo8l6/fHOmdE7HdbnYJnB8bYDLlrDGmYpXZhBnGmEiTfjj7lGXiehTSJ3/g4CRqrxTC+AjewNRT+OjLLBV762+ttOeeH0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c2htYjrn; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764700797; x=1796236797;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9Ul08rqPczUY9Bogxe3yXyfTFe2bGnh040pIQDGuCns=;
  b=c2htYjrnSmqyk8tUfJCBWvhK70zimWy1C7fuNqw25/pLsF6XauhloXDO
   FUyvXR/V1IyQGnoW1scTAT+GnDWYOsNGjPG8CBVRAyCyUUqFZ8fUEZcpv
   w+ObfqYj7n9bR4LllcRktUikEtVgQyWPo7uc5tenPQQdDqMuUB2M/a1y7
   D/6h8/hATParJLweyxZrKlENsUERu5jEWo4iyTJYZto/aiLN0j1F/8rO4
   SSo16Cu/t5pIk2KpQgWvUy+T4+HhMYNudmUBqUNR+hsr4omwz1eySOK05
   NrhP+OvWr2XsnX6JJliH5mFn25fbrzLY3R9bZGfO4MTx5+S/+gckKEBs9
   g==;
X-CSE-ConnectionGUID: fSk0GI2dT86XVFzYK6mTbg==
X-CSE-MsgGUID: M+ZJACKuQgqMIeswng9qcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="66755789"
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; 
   d="scan'208";a="66755789"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 10:39:56 -0800
X-CSE-ConnectionGUID: Qv4WnIqCQ0SprvTAgvTF9Q==
X-CSE-MsgGUID: S9Y9TNM9RMyT8W8XETV0CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; 
   d="scan'208";a="231791879"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.246.182])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 10:39:55 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: jani.nikula@intel.com,
	Mohammed Thasleem <mohammed.thasleem@intel.com>,
	Imre Deak <imre.deak@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/dmc: fix an unlikely NULL pointer deference at probe
Date: Tue,  2 Dec 2025 20:39:50 +0200
Message-ID: <20251202183950.2450315-1-jani.nikula@intel.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
Content-Transfer-Encoding: 8bit

intel_dmc_update_dc6_allowed_count() oopses when DMC hasn't been
initialized, and dmc is thus NULL.

That would be the case when the call path is
intel_power_domains_init_hw() -> {skl,bxt,icl}_display_core_init() ->
gen9_set_dc_state() -> intel_dmc_update_dc6_allowed_count(), as
intel_power_domains_init_hw() is called *before* intel_dmc_init().

However, gen9_set_dc_state() calls intel_dmc_update_dc6_allowed_count()
conditionally, depending on the current and target DC states. At probe,
the target is disabled, but if DC6 is enabled, the function is called,
and an oops follows. Apparently it's quite unlikely that DC6 is enabled
at probe, as we haven't seen this failure mode before.

Add NULL checks and switch the dmc->display references to just display.

Fixes: 88c1f9a4d36d ("drm/i915/dmc: Create debugfs entry for dc6 counter")
Cc: Mohammed Thasleem <mohammed.thasleem@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: <stable@vger.kernel.org> # v6.16+
Signed-off-by: Jani Nikula <jani.nikula@intel.com>

---

Rare case, but this may also throw off the rc6 counting in debugfs when
it does happen.
---
 drivers/gpu/drm/i915/display/intel_dmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dmc.c b/drivers/gpu/drm/i915/display/intel_dmc.c
index 2fb6fec6dc99..169bbbc91f6d 100644
--- a/drivers/gpu/drm/i915/display/intel_dmc.c
+++ b/drivers/gpu/drm/i915/display/intel_dmc.c
@@ -1570,10 +1570,10 @@ void intel_dmc_update_dc6_allowed_count(struct intel_display *display,
 	struct intel_dmc *dmc = display_to_dmc(display);
 	u32 dc5_cur_count;
 
-	if (DISPLAY_VER(dmc->display) < 14)
+	if (!dmc || DISPLAY_VER(display) < 14)
 		return;
 
-	dc5_cur_count = intel_de_read(dmc->display, DG1_DMC_DEBUG_DC5_COUNT);
+	dc5_cur_count = intel_de_read(display, DG1_DMC_DEBUG_DC5_COUNT);
 
 	if (!start_tracking)
 		dmc->dc6_allowed.count += dc5_cur_count - dmc->dc6_allowed.dc5_start;
@@ -1587,7 +1587,7 @@ static bool intel_dmc_get_dc6_allowed_count(struct intel_display *display, u32 *
 	struct intel_dmc *dmc = display_to_dmc(display);
 	bool dc6_enabled;
 
-	if (DISPLAY_VER(display) < 14)
+	if (!dmc || DISPLAY_VER(display) < 14)
 		return false;
 
 	mutex_lock(&power_domains->lock);
-- 
2.47.3


