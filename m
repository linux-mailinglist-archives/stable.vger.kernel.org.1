Return-Path: <stable+bounces-94645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 450C99D6520
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 22:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8362CB23131
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 21:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25BF187FEC;
	Fri, 22 Nov 2024 21:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NiJM9k+m"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47771DEFFC
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 21:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732309667; cv=none; b=iBMQAxNwiFTZTucSW6KDdCzWlse/kNPvuTReiePGZa9lTP9acROZ/W4mmxdn3bbGuBEfmhHvCvPej5QPkKukZIzyfWCQ+2P8jjKO+8AOb39JcoT2q6YZgJ6YFbLOolspfISrnFku4Qb+gUtUDYV+qdpuEjvjVVPzJ4aefmSHFAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732309667; c=relaxed/simple;
	bh=oMljhQ8WuuBdBOx1/6jRSKOc0KHFGc5CfQyF0yFsiwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WrEOTkzkrHhYi83SNnSBJ9jpHquvsEuE5y0vPmkn/09P64B5EIwagCs4Rgwjq+IhWg2byvA+G6EBzUEQKfnnhTzRBokI7H6P2iGRDanz8+4ALkNWN7djzt+KWKfq3e/Y2ptqC5Dm/tJ7475ziT6CAHGh64QiLPLE2yJeL5rxxI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NiJM9k+m; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732309665; x=1763845665;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oMljhQ8WuuBdBOx1/6jRSKOc0KHFGc5CfQyF0yFsiwg=;
  b=NiJM9k+m+DgZ6iTB4yr8BYMFQZCUjKKsJ2NyNHlTVCDrTgBezi3dzuuD
   v0xdOHjLQ7kdI26WlEHU2LU5J87qhk6Bdnv87cvaYPFJsMXWYJ5GXm+oN
   xDFaqgPY1ynf8cMDDaD364bJ0vNOlgTiEspilP4yt9J4jtt+kIjXOnur2
   lEuKg+RD6TCJ1OmjgvCRYVbO8upzJCzPkhIFIoTCrjX+bgJVhaG0uu1UK
   OlR8+a5QyyUJCfxUkU9iAX7VNXNJiX+/+TA4SZuXkAhmtkBEZPylYjPoQ
   9fXhRinkISevqojDzO0XxWUKlOKZYbfSz34XmJtl3V9VpKBfBO4yNhPoE
   w==;
X-CSE-ConnectionGUID: HMEJg0WgQ4SfJLwPfxsIwA==
X-CSE-MsgGUID: YXcfKGDKR/a4WwFmm10tDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="43878264"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="43878264"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:40 -0800
X-CSE-ConnectionGUID: VbzuoNCuQ+27jnpSjjEVNA==
X-CSE-MsgGUID: XaulzwY8TYChoc+7ukcU6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="95457210"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:40 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Akshata Jahagirdar <akshata.jahagirdar@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 6.11 09/31] drm/xe/xe_migrate: Handle migration logic for xe2+ dgfx
Date: Fri, 22 Nov 2024 13:06:57 -0800
Message-ID: <20241122210719.213373-10-lucas.demarchi@intel.com>
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

commit 523f191cc0c728a02a7e5fd0ec26526c41f399ef upstream.

During eviction (vram->sysmem), we use compressed -> uncompressed mapping.
During restore (sysmem->vram), we need to use mapping from
uncompressed -> uncompressed.
Handle logic for selecting the compressed identity map for eviction,
and selecting uncompressed map for restore operations.
v2: Move check of xe_migrate_ccs_emit() before calling
xe_migrate_ccs_copy(). (Nirmoy)

Signed-off-by: Akshata Jahagirdar <akshata.jahagirdar@intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Reviewed-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Signed-off-by: Matt Roper <matthew.d.roper@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/79b3a016e686a662ae68c32b5fc7f0f2ac8043e9.1721250309.git.akshata.jahagirdar@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/xe_migrate.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_migrate.c b/drivers/gpu/drm/xe/xe_migrate.c
index 2d7f69ac09a7f..853bc3fd43705 100644
--- a/drivers/gpu/drm/xe/xe_migrate.c
+++ b/drivers/gpu/drm/xe/xe_migrate.c
@@ -706,7 +706,7 @@ static u32 xe_migrate_ccs_copy(struct xe_migrate *m,
 	struct xe_gt *gt = m->tile->primary_gt;
 	u32 flush_flags = 0;
 
-	if (xe_device_has_flat_ccs(gt_to_xe(gt)) && !copy_ccs && dst_is_indirect) {
+	if (!copy_ccs && dst_is_indirect) {
 		/*
 		 * If the src is already in vram, then it should already
 		 * have been cleared by us, or has been populated by the
@@ -782,6 +782,7 @@ struct dma_fence *xe_migrate_copy(struct xe_migrate *m,
 	bool copy_ccs = xe_device_has_flat_ccs(xe) &&
 		xe_bo_needs_ccs_pages(src_bo) && xe_bo_needs_ccs_pages(dst_bo);
 	bool copy_system_ccs = copy_ccs && (!src_is_vram || !dst_is_vram);
+	bool use_comp_pat = GRAPHICS_VER(xe) >= 20 && IS_DGFX(xe) && src_is_vram && !dst_is_vram;
 
 	/* Copying CCS between two different BOs is not supported yet. */
 	if (XE_WARN_ON(copy_ccs && src_bo != dst_bo))
@@ -808,7 +809,7 @@ struct dma_fence *xe_migrate_copy(struct xe_migrate *m,
 		u32 batch_size = 2; /* arb_clear() + MI_BATCH_BUFFER_END */
 		struct xe_sched_job *job;
 		struct xe_bb *bb;
-		u32 flush_flags;
+		u32 flush_flags = 0;
 		u32 update_idx;
 		u64 ccs_ofs, ccs_size;
 		u32 ccs_pt;
@@ -826,6 +827,7 @@ struct dma_fence *xe_migrate_copy(struct xe_migrate *m,
 		src_L0 = min(src_L0, dst_L0);
 
 		pte_flags = src_is_vram ? PTE_UPDATE_FLAG_IS_VRAM : 0;
+		pte_flags |= use_comp_pat ? PTE_UPDATE_FLAG_IS_COMP_PTE : 0;
 		batch_size += pte_update_size(m, pte_flags, src, &src_it, &src_L0,
 					      &src_L0_ofs, &src_L0_pt, 0, 0,
 					      avail_pts);
@@ -846,7 +848,7 @@ struct dma_fence *xe_migrate_copy(struct xe_migrate *m,
 
 		/* Add copy commands size here */
 		batch_size += ((copy_only_ccs) ? 0 : EMIT_COPY_DW) +
-			((xe_device_has_flat_ccs(xe) ? EMIT_COPY_CCS_DW : 0));
+			((xe_migrate_needs_ccs_emit(xe) ? EMIT_COPY_CCS_DW : 0));
 
 		bb = xe_bb_new(gt, batch_size, usm);
 		if (IS_ERR(bb)) {
@@ -875,11 +877,12 @@ struct dma_fence *xe_migrate_copy(struct xe_migrate *m,
 		if (!copy_only_ccs)
 			emit_copy(gt, bb, src_L0_ofs, dst_L0_ofs, src_L0, XE_PAGE_SIZE);
 
-		flush_flags = xe_migrate_ccs_copy(m, bb, src_L0_ofs,
-						  IS_DGFX(xe) ? src_is_vram : src_is_pltt,
-						  dst_L0_ofs,
-						  IS_DGFX(xe) ? dst_is_vram : dst_is_pltt,
-						  src_L0, ccs_ofs, copy_ccs);
+		if (xe_migrate_needs_ccs_emit(xe))
+			flush_flags = xe_migrate_ccs_copy(m, bb, src_L0_ofs,
+							  IS_DGFX(xe) ? src_is_vram : src_is_pltt,
+							  dst_L0_ofs,
+							  IS_DGFX(xe) ? dst_is_vram : dst_is_pltt,
+							  src_L0, ccs_ofs, copy_ccs);
 
 		job = xe_bb_create_migration_job(m->q, bb,
 						 xe_migrate_batch_base(m, usm),
-- 
2.47.0


