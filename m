Return-Path: <stable+bounces-94639-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F16AB9D6519
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 22:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B30B1613E6
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 21:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B75189BBE;
	Fri, 22 Nov 2024 21:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hINS3tCg"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE15E156F3A
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 21:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732309663; cv=none; b=u5wmy8831UotGIy/yPpJgCuFah+uHr9Ek593DGM1mwuOkf2v6apLUvOlXt7YQ9hYAIrU1pGvemnJI1vLoJm5NuigwSn4KjKiMbb8coLccRtcTebZ5P3U8aIs55sWS/C39AhvnBh4OI6Fle+17sF0xhT98bH3uqB5QdwHO9KAeQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732309663; c=relaxed/simple;
	bh=J+CQCjnG0yrWPyghUz+hLbkHui18h1EmaOgfs5+r7CE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sCAz3EMrSQFuRMNEeAC9Gxflj1PTFeZNqTf8xjDXo29yLRp0BtcGKVrpS7GYnJ19b/YIXhFvK3BX+pXDrd0zysVTO+fIo8Z1GZuLFDRJm8lvaNn3NqAh47PQ5diwi06DNR9eu+mlsWJIXtkCGaCHKn3ZMfDes9ETdhEBQdIXPkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hINS3tCg; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732309660; x=1763845660;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J+CQCjnG0yrWPyghUz+hLbkHui18h1EmaOgfs5+r7CE=;
  b=hINS3tCg4EzqeYpXaH7GEVHZnOAYpr567RCfOlAP7eJYKHvluaItGQKI
   p9ySvI3z07WmhmY7664U0qN5jansGBEZtTgC2jWHFUn+Z0Lgpl+VeFX1W
   7v8b4cEtICNkM3Mj1sGdHvd0eqJP2OeR4RyJGH8o0bHOFIGC6I53Lyl8y
   12iByBXXh5gpgDVULIgV4fCQAN5GanslvyAsJqIlkgW90iHL0nJ2Y/K+p
   sH+qG0vF6S9VzEjF2HoR5v+0HPndrm6F0yEkYPvfe47/POTYC/3Marvsl
   rx8ySj2+ZhHJEPIRjKSsEZEOm3DionyLovBdIc5z/IN/1sEEoIco1NPQ+
   g==;
X-CSE-ConnectionGUID: tk3bu9oFSQ2+UIVVl0vt4w==
X-CSE-MsgGUID: jkqb5MpmTKuMj4s3s60vdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="43878254"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="43878254"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:39 -0800
X-CSE-ConnectionGUID: 8wFz2sudSH+oE2cMA3BrSQ==
X-CSE-MsgGUID: EL1LNLLVTOWjoEjkSzpTJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="95457181"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:39 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Akshata Jahagirdar <akshata.jahagirdar@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 6.11 01/31] drm/xe/migrate: Handle clear ccs logic for xe2 dgfx
Date: Fri, 22 Nov 2024 13:06:49 -0800
Message-ID: <20241122210719.213373-2-lucas.demarchi@intel.com>
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

From: Akshata Jahagirdar <akshata.jahagirdar@intel.com>

commit 108c972a11c5f6e37be58207460d9bcac06698db upstream.

For Xe2 dGPU, we clear the bo by modifying the VRAM using an
uncompressed pat index which then indirectly updates the
compression status as uncompressed i.e zeroed CCS.
So xe_migrate_clear() should be updated for BMG to not
emit CCS surf copy commands.

v2: Moved xe_device_needs_ccs_emit() to xe_migrate.c and changed
name to xe_migrate_needs_ccs_emit() since its very specific to
migration.(Matt)

Signed-off-by: Akshata Jahagirdar <akshata.jahagirdar@intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Reviewed-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Signed-off-by: Matt Roper <matthew.d.roper@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/8dd869dd8dda5e17ace28c04f1a48675f5540874.1721250309.git.akshata.jahagirdar@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/xe_migrate.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_migrate.c b/drivers/gpu/drm/xe/xe_migrate.c
index a849c48d8ac90..8315cb02f370d 100644
--- a/drivers/gpu/drm/xe/xe_migrate.c
+++ b/drivers/gpu/drm/xe/xe_migrate.c
@@ -348,6 +348,11 @@ static u32 xe_migrate_usm_logical_mask(struct xe_gt *gt)
 	return logical_mask;
 }
 
+static bool xe_migrate_needs_ccs_emit(struct xe_device *xe)
+{
+	return xe_device_has_flat_ccs(xe) && !(GRAPHICS_VER(xe) >= 20 && IS_DGFX(xe));
+}
+
 /**
  * xe_migrate_init() - Initialize a migrate context
  * @tile: Back-pointer to the tile we're initializing for.
@@ -421,7 +426,7 @@ struct xe_migrate *xe_migrate_init(struct xe_tile *tile)
 		return ERR_PTR(err);
 
 	if (IS_DGFX(xe)) {
-		if (xe_device_has_flat_ccs(xe))
+		if (xe_migrate_needs_ccs_emit(xe))
 			/* min chunk size corresponds to 4K of CCS Metadata */
 			m->min_chunk_size = SZ_4K * SZ_64K /
 				xe_device_ccs_bytes(xe, SZ_64K);
@@ -1035,7 +1040,7 @@ struct dma_fence *xe_migrate_clear(struct xe_migrate *m,
 					clear_system_ccs ? 0 : emit_clear_cmd_len(gt), 0,
 					avail_pts);
 
-		if (xe_device_has_flat_ccs(xe))
+		if (xe_migrate_needs_ccs_emit(xe))
 			batch_size += EMIT_COPY_CCS_DW;
 
 		/* Clear commands */
@@ -1063,7 +1068,7 @@ struct dma_fence *xe_migrate_clear(struct xe_migrate *m,
 		if (!clear_system_ccs)
 			emit_clear(gt, bb, clear_L0_ofs, clear_L0, XE_PAGE_SIZE, clear_vram);
 
-		if (xe_device_has_flat_ccs(xe)) {
+		if (xe_migrate_needs_ccs_emit(xe)) {
 			emit_copy_ccs(gt, bb, clear_L0_ofs, true,
 				      m->cleared_mem_ofs, false, clear_L0);
 			flush_flags = MI_FLUSH_DW_CCS;
-- 
2.47.0


