Return-Path: <stable+bounces-114274-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB3AA2C8A8
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 17:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A6B2169213
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 16:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79E118BC3F;
	Fri,  7 Feb 2025 16:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EPcJROjt"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C933B57C9F
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 16:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738945443; cv=none; b=TgGZQgHvS7Z/pDYcwV5No9ZskaPkLEEA0BQ2LQceZMLDJE3/OlLACJmh+pYnRhqqV3AUPHZEGSphLehOmbLNLWK5lIRX/Folfm/N2szKcPD68xNDuZfn2to1MJMvWph5PqHcJxfyc1YAcHarmVR1vDKYMH6ljxlHwyK0GGwk+do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738945443; c=relaxed/simple;
	bh=VpKkhKPCwP/eWjXtyw93qnuZirQn/Fe0LjWFYpfLIZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MZt39XnKJ6J6BHMebIL560YYXGWksTgysk2xR/X6hNWgr1YmCGs5AeFxsujBPdjJ4bwBQ3OxHDGsHyf7rb8U8bZZbBZ9fHGmsGkG1wkDBzVOZ1a7Nd98O75evqDFt7XnGis8MDdOMTcEFv5CKf40Pc+U0tSy1GW4yxWa4l59Qv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EPcJROjt; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738945441; x=1770481441;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VpKkhKPCwP/eWjXtyw93qnuZirQn/Fe0LjWFYpfLIZQ=;
  b=EPcJROjtZ+mdkquQTg+xo3hd1IC86uWRlmgyZNQKa4OuAb8tPSlcTyon
   GBVpVV8zsIwwhvSenOuuO0IHdBAFDM27jllQH8f4j7aVXFmpjDWQPGcyE
   VeUkB4CTC6SO5IeA+IGuogcKADdniy1VxjYS071pCYzeTLp3pm7tX9FC0
   6t9bFPlpM/RH/GhicpKhPSmhxKwwPad52A0+8FbGwx3lbdOEVGMVL+iMw
   hnxtKN+yhbs0j0NoTd66IRhvqPot6RaFKxzVGXxVLm4fk7Rgm1DoHsscw
   iF2WjNn11B0KxC+BGParnKSyQrIR5oWOZTHQbFfBMBHXCBh4if1dIJl2J
   Q==;
X-CSE-ConnectionGUID: 51UAj3JuQKCuxR42v9/wiQ==
X-CSE-MsgGUID: oogm6+72TjeEOsKZxTNZbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="39500227"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="39500227"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 08:24:01 -0800
X-CSE-ConnectionGUID: oM55lDiSRhy1fQr81Ew6/A==
X-CSE-MsgGUID: ulxWW6C3S7CUFqVmkLG45g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116768616"
Received: from nirmoyda-desk.igk.intel.com ([10.211.135.230])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 08:24:00 -0800
From: Nirmoy Das <nirmoy.das@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Nirmoy Das <nirmoy.das@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe: Carve out wopcm portion from the stolen memory
Date: Fri,  7 Feb 2025 17:43:34 +0100
Message-ID: <20250207164334.1393054-1-nirmoy.das@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Deutschland GmbH, Registered Address: Am Campeon 10, 85579 Neubiberg, Germany, Commercial Register: Amtsgericht Muenchen HRB 186928
Content-Transfer-Encoding: 8bit

Top of stolen memory is wopcm which shouldn't be accessed so remove
that portion of memory from the stolen memory.

Fixes: d8b52a02cb40 ("drm/xe: Implement stolen memory.")
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
---
 drivers/gpu/drm/xe/xe_ttm_stolen_mgr.c | 54 ++++++++++++++------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_ttm_stolen_mgr.c b/drivers/gpu/drm/xe/xe_ttm_stolen_mgr.c
index 423856cc18d4..d414421f8c13 100644
--- a/drivers/gpu/drm/xe/xe_ttm_stolen_mgr.c
+++ b/drivers/gpu/drm/xe/xe_ttm_stolen_mgr.c
@@ -57,12 +57,35 @@ bool xe_ttm_stolen_cpu_access_needs_ggtt(struct xe_device *xe)
 	return GRAPHICS_VERx100(xe) < 1270 && !IS_DGFX(xe);
 }
 
+static u32 get_wopcm_size(struct xe_device *xe)
+{
+	u32 wopcm_size;
+	u64 val;
+
+	val = xe_mmio_read64_2x32(xe_root_tile_mmio(xe), STOLEN_RESERVED);
+	val = REG_FIELD_GET64(WOPCM_SIZE_MASK, val);
+
+	switch (val) {
+	case 0x5 ... 0x6:
+		val--;
+		fallthrough;
+	case 0x0 ... 0x3:
+		wopcm_size = (1U << val) * SZ_1M;
+		break;
+	default:
+		WARN(1, "Missing case wopcm_size=%llx\n", val);
+		wopcm_size = 0;
+	}
+
+	return wopcm_size;
+}
+
 static s64 detect_bar2_dgfx(struct xe_device *xe, struct xe_ttm_stolen_mgr *mgr)
 {
 	struct xe_tile *tile = xe_device_get_root_tile(xe);
 	struct xe_mmio *mmio = xe_root_tile_mmio(xe);
 	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
-	u64 stolen_size;
+	u64 stolen_size, wopcm_size;
 	u64 tile_offset;
 	u64 tile_size;
 
@@ -74,7 +97,13 @@ static s64 detect_bar2_dgfx(struct xe_device *xe, struct xe_ttm_stolen_mgr *mgr)
 	if (drm_WARN_ON(&xe->drm, tile_size < mgr->stolen_base))
 		return 0;
 
+	/* Carve out the top of DSM as it contains the reserved WOPCM region */
+	wopcm_size = get_wopcm_size(xe);
+	if (drm_WARN_ON(&xe->drm, !wopcm_size))
+		return 0;
+
 	stolen_size = tile_size - mgr->stolen_base;
+	stolen_size -= wopcm_size;
 
 	/* Verify usage fits in the actual resource available */
 	if (mgr->stolen_base + stolen_size <= pci_resource_len(pdev, LMEM_BAR))
@@ -89,29 +118,6 @@ static s64 detect_bar2_dgfx(struct xe_device *xe, struct xe_ttm_stolen_mgr *mgr)
 	return ALIGN_DOWN(stolen_size, SZ_1M);
 }
 
-static u32 get_wopcm_size(struct xe_device *xe)
-{
-	u32 wopcm_size;
-	u64 val;
-
-	val = xe_mmio_read64_2x32(xe_root_tile_mmio(xe), STOLEN_RESERVED);
-	val = REG_FIELD_GET64(WOPCM_SIZE_MASK, val);
-
-	switch (val) {
-	case 0x5 ... 0x6:
-		val--;
-		fallthrough;
-	case 0x0 ... 0x3:
-		wopcm_size = (1U << val) * SZ_1M;
-		break;
-	default:
-		WARN(1, "Missing case wopcm_size=%llx\n", val);
-		wopcm_size = 0;
-	}
-
-	return wopcm_size;
-}
-
 static u32 detect_bar2_integrated(struct xe_device *xe, struct xe_ttm_stolen_mgr *mgr)
 {
 	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
-- 
2.46.0


