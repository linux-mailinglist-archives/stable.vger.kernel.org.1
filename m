Return-Path: <stable+bounces-75855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4699757B0
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 17:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04EDE1F2712B
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 15:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25501AC42B;
	Wed, 11 Sep 2024 15:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aZIlXFnm"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE881AC453
	for <stable@vger.kernel.org>; Wed, 11 Sep 2024 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726070153; cv=none; b=hSi4hM2Qg3LnuC+PcRYXZNfp/wWesZltDLjJK1hYL6CLU+aZP3B/jm2KyjBvli/xPTNlb58fDOh/HJkggXCdOgnG0Ln1ENHv71SbPUTG7t74z4ZQ4RMxuxY2+SFySsDI65NaQjhiQy50/iHmyz0DO8tvmc5ubC4cjPxWqZ34bmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726070153; c=relaxed/simple;
	bh=DxZWgv8LmI84zVG27feULf1IIzcwEZhS5w1FwvUkZf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZVQYUfOtv7EjbcnZLlBIuGPN+nQbsPOFTlvnB4vRHCJcBZFORTmGDHcVfR4aTYEk5pNXxqDyU3oOG+SAIwmDHkTGB5dBuSLQKH1T4ubhXnbXeLdUNETkCfxoOGDuvHjlALgTAC9ALHxAgboCSYvRtIUPl0kQdiB6NxJdEU7Wfik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aZIlXFnm; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726070152; x=1757606152;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DxZWgv8LmI84zVG27feULf1IIzcwEZhS5w1FwvUkZf0=;
  b=aZIlXFnmdXFCKiqlJVBvOd9stJQ0M3wMmM3AEYEToRSfvxzrj+cXk2ww
   lOD3hBCRd4zYFBLOC1kTlsgHxHeya4IsuWY4x9zIY9883tVb7+xQMWDv5
   gCLoaBiEp1+1r/WuLbNTCuHUMn3aS2hpl6TB+4zcipDFN6wKR8GejkATW
   hZr2jKhHIrs62Xgtp0bHzSDeP3SdzA1dCkJAwLcbvL75UCPFWn93pyP4v
   qkzlrdWHfQW3bB6vVKLbbRpxArKj/334obJ4j1ymIB30PgjFtBseirlFi
   S1mHs94sAdyhvDE5CchwwQNTEhmL9Vl0M2vbumb1o+JQWTUn6p4OZ3DC5
   Q==;
X-CSE-ConnectionGUID: aXcaQkxFTaGGsLe6KqdYeg==
X-CSE-MsgGUID: 30u3fzDVTHG6beic3nC9/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="24703337"
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="24703337"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 08:55:51 -0700
X-CSE-ConnectionGUID: UZm/QsFrRe2KgYqueoEL/w==
X-CSE-MsgGUID: aPAogfTrQ1ymCHqmRK3Jog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="67257836"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO mwauld-desk.intel.com) ([10.245.244.102])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 08:55:50 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	Tejas Upadhyay <tejas.upadhyay@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	stable@vger.kernel.org,
	Matthew Brost <matthew.brost@intel.com>
Subject: [PATCH v2 2/4] drm/xe/client: add missing bo locking in show_meminfo()
Date: Wed, 11 Sep 2024 16:55:28 +0100
Message-ID: <20240911155527.178910-6-matthew.auld@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911155527.178910-5-matthew.auld@intel.com>
References: <20240911155527.178910-5-matthew.auld@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

bo_meminfo() wants to inspect bo state like tt and the ttm resource,
however this state can change at any point leading to stuff like NPD and
UAF, if the bo lock is not held. Grab the bo lock when calling
bo_meminfo(), ensuring we drop any spinlocks first. In the case of
object_idr we now also need to hold a ref.

v2 (MattB)
  - Also add xe_bo_assert_held()

Fixes: 0845233388f8 ("drm/xe: Implement fdinfo memory stats printing")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>
Cc: "Thomas Hellström" <thomas.hellstrom@linux.intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Tejas Upadhyay <tejas.upadhyay@intel.com>
---
 drivers/gpu/drm/xe/xe_drm_client.c | 39 +++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_drm_client.c b/drivers/gpu/drm/xe/xe_drm_client.c
index badfa045ead8..95a05c5bc897 100644
--- a/drivers/gpu/drm/xe/xe_drm_client.c
+++ b/drivers/gpu/drm/xe/xe_drm_client.c
@@ -10,6 +10,7 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 
+#include "xe_assert.h"
 #include "xe_bo.h"
 #include "xe_bo_types.h"
 #include "xe_device_types.h"
@@ -151,10 +152,13 @@ void xe_drm_client_add_bo(struct xe_drm_client *client,
  */
 void xe_drm_client_remove_bo(struct xe_bo *bo)
 {
+	struct xe_device *xe = ttm_to_xe_device(bo->ttm.bdev);
 	struct xe_drm_client *client = bo->client;
 
+	xe_assert(xe, !kref_read(&bo->ttm.base.refcount));
+
 	spin_lock(&client->bos_lock);
-	list_del(&bo->client_link);
+	list_del_init(&bo->client_link);
 	spin_unlock(&client->bos_lock);
 
 	xe_drm_client_put(client);
@@ -166,6 +170,8 @@ static void bo_meminfo(struct xe_bo *bo,
 	u64 sz = bo->size;
 	u32 mem_type;
 
+	xe_bo_assert_held(bo);
+
 	if (bo->placement.placement)
 		mem_type = bo->placement.placement->mem_type;
 	else
@@ -207,7 +213,20 @@ static void show_meminfo(struct drm_printer *p, struct drm_file *file)
 	idr_for_each_entry(&file->object_idr, obj, id) {
 		struct xe_bo *bo = gem_to_xe_bo(obj);
 
-		bo_meminfo(bo, stats);
+		if (dma_resv_trylock(bo->ttm.base.resv)) {
+			bo_meminfo(bo, stats);
+			xe_bo_unlock(bo);
+		} else {
+			xe_bo_get(bo);
+			spin_unlock(&file->table_lock);
+
+			xe_bo_lock(bo, false);
+			bo_meminfo(bo, stats);
+			xe_bo_unlock(bo);
+
+			xe_bo_put(bo);
+			spin_lock(&file->table_lock);
+		}
 	}
 	spin_unlock(&file->table_lock);
 
@@ -217,7 +236,21 @@ static void show_meminfo(struct drm_printer *p, struct drm_file *file)
 		if (!kref_get_unless_zero(&bo->ttm.base.refcount))
 			continue;
 
-		bo_meminfo(bo, stats);
+		if (dma_resv_trylock(bo->ttm.base.resv)) {
+			bo_meminfo(bo, stats);
+			xe_bo_unlock(bo);
+		} else {
+			spin_unlock(&client->bos_lock);
+
+			xe_bo_lock(bo, false);
+			bo_meminfo(bo, stats);
+			xe_bo_unlock(bo);
+
+			spin_lock(&client->bos_lock);
+			/* The bo ref will prevent this bo from being removed from the list */
+			xe_assert(xef->xe, !list_empty(&bo->client_link));
+		}
+
 		xe_bo_put_deferred(bo, &deferred);
 	}
 	spin_unlock(&client->bos_lock);
-- 
2.46.0


