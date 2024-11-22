Return-Path: <stable+bounces-94638-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F1C9D6518
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 22:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC0E0282D3B
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 21:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C269E187FEC;
	Fri, 22 Nov 2024 21:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JgjTwx72"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17C817DFFC
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 21:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732309663; cv=none; b=t++yCGiSYNUKAw9sg9RPedfkZgCc4jRq+MXrlgTqUVaQ+5MZYtg2UvOkmB4fb+uq3AzrMo2cCboX2sSXHAn8Tdfz7soVIAA8u9y6ejLfbAOKQqcpCIwO2QauYccmSP/aEeQg4MTOI1RZrgACde0QGfSwtXcG7Qx+v51QCW4wMbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732309663; c=relaxed/simple;
	bh=ocKSkAp8weOe09wa3d+fp8PttYUoE3WYNKLddGT3t5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lSY7wkBc+j3B0tDVgDQCpN0W953G4znARRLm4TDMn36MI5fHEihzvvBtl1PyZef38Rov+lbpXfzTn2PCPL2qjbyAu4LVdwSiQxP7QkzHmfCz+5OA3RuARTFjMBgxrwiM+oj5OB1WzChkcmmrtAtR1Rm0n76tiuC2zry5KhnKXmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JgjTwx72; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732309661; x=1763845661;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ocKSkAp8weOe09wa3d+fp8PttYUoE3WYNKLddGT3t5Q=;
  b=JgjTwx72t6xmYGP+wzHd4+q7HrfgWZQgawtak1VT/CmvjtgG8WNBGHPV
   Mi8Q8B1ebCbCUt30bNWz8wEZVgyd2iAT35QQ9rTLLbLmG1hhpq220dR2Q
   cWz0FO4dZqmfe25NVC6RNrW5S0hY3fj7g3/1vhFiqGATkLVQA8bgAOhtD
   wuEi4yuy8sHfdxpzz+WLuIv41NZebTAIWEe50+JwGODe7HgWIYxvxErt3
   Tl4N8R93dkweIQmYQVx1S5ZpAbSL+nZfth3ajKD/tD8PJKCRHNOJKs7Tf
   bDxis2oYyvy3FWIMUOxgTXnjFxPbcv29F1FNVhEGSOeWT9Txc7RZ8uJX5
   w==;
X-CSE-ConnectionGUID: ZgbC3zlxS6OxyWyW+jSBlA==
X-CSE-MsgGUID: k92p3rxpSSyuwuYylt7L8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="43878256"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="43878256"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:39 -0800
X-CSE-ConnectionGUID: 2sHjwX9wSE2ZtRauSWLPYQ==
X-CSE-MsgGUID: vYMz7LP5So2JUmcJ1Z29LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="95457186"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:39 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Akshata Jahagirdar <akshata.jahagirdar@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 6.11 02/31] drm/xe/migrate: Add helper function to program identity map
Date: Fri, 22 Nov 2024 13:06:50 -0800
Message-ID: <20241122210719.213373-3-lucas.demarchi@intel.com>
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

commit 8d79acd567db183e675cccc6cc737d2959e2a2d9 upstream.

Add an helper function to program identity map.

v2: Formatting nits

Signed-off-by: Akshata Jahagirdar <akshata.jahagirdar@intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Matt Roper <matthew.d.roper@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/91dc05f05bd33076fb9a9f74f8495b48d2abff53.1721250309.git.akshata.jahagirdar@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/xe_migrate.c | 88 ++++++++++++++++++---------------
 1 file changed, 48 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_migrate.c b/drivers/gpu/drm/xe/xe_migrate.c
index 8315cb02f370d..f1cdb6f1fa176 100644
--- a/drivers/gpu/drm/xe/xe_migrate.c
+++ b/drivers/gpu/drm/xe/xe_migrate.c
@@ -131,6 +131,51 @@ static u64 xe_migrate_vram_ofs(struct xe_device *xe, u64 addr)
 	return addr + (256ULL << xe_pt_shift(2));
 }
 
+static void xe_migrate_program_identity(struct xe_device *xe, struct xe_vm *vm, struct xe_bo *bo,
+					u64 map_ofs, u64 vram_offset, u16 pat_index, u64 pt_2m_ofs)
+{
+	u64 pos, ofs, flags;
+	u64 entry;
+	/* XXX: Unclear if this should be usable_size? */
+	u64 vram_limit =  xe->mem.vram.actual_physical_size +
+		xe->mem.vram.dpa_base;
+	u32 level = 2;
+
+	ofs = map_ofs + XE_PAGE_SIZE * level + vram_offset * 8;
+	flags = vm->pt_ops->pte_encode_addr(xe, 0, pat_index, level,
+					    true, 0);
+
+	xe_assert(xe, IS_ALIGNED(xe->mem.vram.usable_size, SZ_2M));
+
+	/*
+	 * Use 1GB pages when possible, last chunk always use 2M
+	 * pages as mixing reserved memory (stolen, WOCPM) with a single
+	 * mapping is not allowed on certain platforms.
+	 */
+	for (pos = xe->mem.vram.dpa_base; pos < vram_limit;
+	     pos += SZ_1G, ofs += 8) {
+		if (pos + SZ_1G >= vram_limit) {
+			entry = vm->pt_ops->pde_encode_bo(bo, pt_2m_ofs,
+							  pat_index);
+			xe_map_wr(xe, &bo->vmap, ofs, u64, entry);
+
+			flags = vm->pt_ops->pte_encode_addr(xe, 0,
+							    pat_index,
+							    level - 1,
+							    true, 0);
+
+			for (ofs = pt_2m_ofs; pos < vram_limit;
+			     pos += SZ_2M, ofs += 8)
+				xe_map_wr(xe, &bo->vmap, ofs, u64, pos | flags);
+			break;	/* Ensure pos == vram_limit assert correct */
+		}
+
+		xe_map_wr(xe, &bo->vmap, ofs, u64, pos | flags);
+	}
+
+	xe_assert(xe, pos == vram_limit);
+}
+
 static int xe_migrate_prepare_vm(struct xe_tile *tile, struct xe_migrate *m,
 				 struct xe_vm *vm)
 {
@@ -254,47 +299,10 @@ static int xe_migrate_prepare_vm(struct xe_tile *tile, struct xe_migrate *m,
 
 	/* Identity map the entire vram at 256GiB offset */
 	if (IS_DGFX(xe)) {
-		u64 pos, ofs, flags;
-		/* XXX: Unclear if this should be usable_size? */
-		u64 vram_limit =  xe->mem.vram.actual_physical_size +
-			xe->mem.vram.dpa_base;
-
-		level = 2;
-		ofs = map_ofs + XE_PAGE_SIZE * level + 256 * 8;
-		flags = vm->pt_ops->pte_encode_addr(xe, 0, pat_index, level,
-						    true, 0);
-
-		xe_assert(xe, IS_ALIGNED(xe->mem.vram.usable_size, SZ_2M));
-
-		/*
-		 * Use 1GB pages when possible, last chunk always use 2M
-		 * pages as mixing reserved memory (stolen, WOCPM) with a single
-		 * mapping is not allowed on certain platforms.
-		 */
-		for (pos = xe->mem.vram.dpa_base; pos < vram_limit;
-		     pos += SZ_1G, ofs += 8) {
-			if (pos + SZ_1G >= vram_limit) {
-				u64 pt31_ofs = bo->size - XE_PAGE_SIZE;
-
-				entry = vm->pt_ops->pde_encode_bo(bo, pt31_ofs,
-								  pat_index);
-				xe_map_wr(xe, &bo->vmap, ofs, u64, entry);
-
-				flags = vm->pt_ops->pte_encode_addr(xe, 0,
-								    pat_index,
-								    level - 1,
-								    true, 0);
-
-				for (ofs = pt31_ofs; pos < vram_limit;
-				     pos += SZ_2M, ofs += 8)
-					xe_map_wr(xe, &bo->vmap, ofs, u64, pos | flags);
-				break;	/* Ensure pos == vram_limit assert correct */
-			}
-
-			xe_map_wr(xe, &bo->vmap, ofs, u64, pos | flags);
-		}
+		u64 pt31_ofs = bo->size - XE_PAGE_SIZE;
 
-		xe_assert(xe, pos == vram_limit);
+		xe_migrate_program_identity(xe, vm, bo, map_ofs, 256, pat_index, pt31_ofs);
+		xe_assert(xe, (xe->mem.vram.actual_physical_size <= SZ_256G));
 	}
 
 	/*
-- 
2.47.0


