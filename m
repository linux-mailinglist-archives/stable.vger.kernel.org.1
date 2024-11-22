Return-Path: <stable+bounces-94664-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7769D6532
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 22:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 459A6282D84
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 21:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD73C18BC0D;
	Fri, 22 Nov 2024 21:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ICkvbPb4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E281DF983
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 21:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732309675; cv=none; b=GSiQ69XeIHH6jHA7D+BpfXlv4X8I7weOaZnb+5OjoXaXbfKf5Avp9St+ppSzceO7ZoZuKNK08d/JwjK7vL/eLO3RZ312qoa79argvO5SNnz7zp95D6c6O2RhX4ZemqKEdJIIcWoS24hckf25hAOoak1PhfNc3PVyfAHxlBNTO70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732309675; c=relaxed/simple;
	bh=bNPk7BADm4ISCfnTWG+Q16kEieIBbx15AGllheI8SAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gYQX/R8/dlci4sUZh1/Fa3cH4SIO2VL+bPX8LOBPXc6zD0HNmCxQ1d5UthR19x3RseCd6+DYebMdlEknsro0ISudDlG2e57Sm7nRu5ye3KfsHpxDuNALgV7RrLhQTqs/Cw5waoEjkdB8PuKUkiI44zsQrVUu/6S6/LqEjyrEXlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ICkvbPb4; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732309674; x=1763845674;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bNPk7BADm4ISCfnTWG+Q16kEieIBbx15AGllheI8SAc=;
  b=ICkvbPb4X9/wnzCApMrH5xsRnOXn3Y/zR03usBQ3IlQFhKMoPKBWeGrv
   kJ/KUkgqSDLfbVPeBmCiT3kqk7C/BuiB5BuoDmu6DzwnK6+6n+0X2/opV
   DtbyEAfoQGSmpQi7mNzC5USn6Yb9BHAc5fgTe91my1WhMjZ8Vwt/GgClJ
   PyZEprpsIb67JQ+eoY9JezYCqd2UmCmf7Qh8fdsEulv43GjJiUEJomGsS
   gnfMvt623nPH4lx+pAQz4znnpBh+MZ8vqyzJMAmYB3A5cswcA3KBYTHni
   6i5jSlAUDH6SRg6ArX4gZwHayInXtmTJE2DjuoFNp4X9MKeko7DTgCUkG
   Q==;
X-CSE-ConnectionGUID: IdKitIYySPmEIH4+0RuYKQ==
X-CSE-MsgGUID: ZEZxcsLoSE65PZhnB6xmbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="43878283"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="43878283"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:44 -0800
X-CSE-ConnectionGUID: zxeH8sAyQpezPsxc85tUpg==
X-CSE-MsgGUID: qIstF1LYRwWsjH/PeiP7TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="95457291"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:44 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Suraj Kandpal <suraj.kandpal@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 6.11 27/31] drm/xe/display: Do not suspend resume dp mst during runtime
Date: Fri, 22 Nov 2024 13:07:15 -0800
Message-ID: <20241122210719.213373-28-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122210719.213373-1-lucas.demarchi@intel.com>
References: <20241122210719.213373-1-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Suraj Kandpal <suraj.kandpal@intel.com>

commit 47382485baa781b68622d94faa3473c9a235f23e upstream.

Remove intel_dp_mst_suspend/resume from runtime suspend resume
sequences. It is incorrect as it depends on AUX transfers which
itself depend on the device being runtime resumed. This is
also why we see a lock_dep splat here.

<4> [76.011119] kworker/4:2/192 is trying to acquire lock:
<4> [76.011122] ffff8881120b3210 (&mgr->lock#2){+.+.}-{3:3}, at:
drm_dp_mst_topology_mgr_suspend+0x33/0xd0 [drm_display_helper]
<4> [76.011142]
but task is already holding lock:
<4> [76.011144] ffffffffa0bc3420
(xe_pm_runtime_lockdep_map){+.+.}-{0:0}, at:
xe_pm_runtime_suspend+0x51/0x3f0 [xe]
<4> [76.011223]
which lock already depends on the new lock.
<4> [76.011226]
the existing dependency chain (in reverse order) is:
<4> [76.011229]
-> #2 (xe_pm_runtime_lockdep_map){+.+.}-{0:0}:
<4> [76.011233]        pm_runtime_lockdep_prime+0x2f/0x50 [xe]
<4> [76.011306]        xe_pm_runtime_resume_and_get+0x29/0x90 [xe]
<4> [76.011377]        intel_display_power_get+0x24/0x70 [xe]
<4> [76.011466]        intel_digital_port_connected_locked+0x4c/0xf0
[xe]
<4> [76.011551]        intel_dp_aux_xfer+0xb8/0x7c0 [xe]
<4> [76.011633]        intel_dp_aux_transfer+0x166/0x2e0 [xe]
<4> [76.011715]        drm_dp_dpcd_access+0x87/0x150
[drm_display_helper]
<4> [76.011726]        drm_dp_dpcd_probe+0x3d/0xf0 [drm_display_helper]
<4> [76.011737]        drm_dp_dpcd_read+0xdd/0x130 [drm_display_helper]
<4> [76.011747]        intel_dp_get_colorimetry_status+0x3a/0x70 [xe]
<4> [76.011886]        intel_dp_init_connector+0x4ff/0x1030 [xe]
<4> [76.011969]        intel_ddi_init+0xc5b/0x1030 [xe]
<4> [76.012058]        intel_bios_for_each_encoder+0x36/0x60 [xe]
<4> [76.012145]        intel_setup_outputs+0x201/0x460 [xe]
<4> [76.012233]        intel_display_driver_probe_nogem+0x155/0x1e0 [xe]
<4> [76.012320]        xe_display_init_noaccel+0x27/0x70 [xe]

Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240912012545.702032-2-suraj.kandpal@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/display/xe_display.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/display/xe_display.c b/drivers/gpu/drm/xe/display/xe_display.c
index 696e3cd716991..5aeb672f329de 100644
--- a/drivers/gpu/drm/xe/display/xe_display.c
+++ b/drivers/gpu/drm/xe/display/xe_display.c
@@ -325,7 +325,8 @@ static void __xe_display_pm_suspend(struct xe_device *xe, bool runtime)
 
 	xe_display_flush_cleanup_work(xe);
 
-	intel_dp_mst_suspend(xe);
+	if (!runtime)
+		intel_dp_mst_suspend(xe);
 
 	intel_hpd_cancel_work(xe);
 
@@ -398,7 +399,9 @@ static void __xe_display_pm_resume(struct xe_device *xe, bool runtime)
 		intel_display_driver_resume_access(xe);
 
 	/* MST sideband requires HPD interrupts enabled */
-	intel_dp_mst_resume(xe);
+	if (!runtime)
+		intel_dp_mst_resume(xe);
+
 	if (!runtime && has_display(xe)) {
 		intel_display_driver_resume(xe);
 		drm_kms_helper_poll_enable(&xe->drm);
-- 
2.47.0


