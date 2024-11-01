Return-Path: <stable+bounces-89504-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 080499B94B7
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 16:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76B151F21C4B
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 15:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0541C5798;
	Fri,  1 Nov 2024 15:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dFTtnwjp"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DC12CAB
	for <stable@vger.kernel.org>; Fri,  1 Nov 2024 15:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730476081; cv=none; b=gk3HosoK9CoTQnlKwTIa/i+Cfa8OC1kQD7CdI4jqLBVnc72G0fAMBParSAIPNi+IpqfmRU47jnW+rvjh68vR/6+ySscrU8lBtT8R5mX7TYHJxwkd66l6IGBzf4/ILJoIh7h5zCVOh3VuQFcbgJPLQUrSqMn7lQvcTkQaHdk0V+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730476081; c=relaxed/simple;
	bh=NzZuzP1txsyh3b6lJQLLnxOamwV4L69UuIMVYLElb8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/uOkzKp4pGwnjkdLyR3fRSqO79SVAcpuw9/YYYGGxHzpKx7tSEXww0OuiCbtZ8vZyt+ozbTKDVtfoSXJrteKCKFCVxoy1d3802/PWemv22x0WkT5zKNK41bHu9t+z6Hmc5AJmkynxQpQoUnmAPsRVOTdM5uL9o5nmwUJvJSjBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dFTtnwjp; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730476080; x=1762012080;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NzZuzP1txsyh3b6lJQLLnxOamwV4L69UuIMVYLElb8k=;
  b=dFTtnwjpNRXgGollWMg4daDiu1vTEjuIEmwLceIIr0HSi4VXHL5YYYhu
   qlNeYSA4x0cRQ9MjHAKKKA1AcOm93EQu4gzIh0YvAYG36xoZPOxzhR5Nq
   KxVGOmy2sI3u+8HNwogKxVMBEs6Hk0WHKuMExUnFELGiyqSe7+CtZTKaf
   c6i5ruSL4pX7LZ1hZbu0q2uo+nJFCAngv7M0CUZIPTlcLpasvwNbvE39b
   RUKvj3PyVNAz8OkH/IZA3NA2pBZ+aw9qHHXAYnND5FGzkOhyLmNCJ0PL2
   COl51BU3osNWM4qAsbPXfgAagAA5akW8GfcM7VL27LyQD+DpH5Ko3m7ax
   w==;
X-CSE-ConnectionGUID: NxsWoIAuQT6fCcq0QQD7Kg==
X-CSE-MsgGUID: SXumL8+yR4iAXehME4Vqwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41344013"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41344013"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 08:47:59 -0700
X-CSE-ConnectionGUID: P2HlMJZdS+eAnbqbygTyDA==
X-CSE-MsgGUID: VmI9hothS/qsEWfyCvRvsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="83435568"
Received: from oandoniu-mobl3.ger.corp.intel.com (HELO mwauld-desk.intel.com) ([10.245.244.34])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 08:47:57 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] drm/xe: improve hibernation on igpu
Date: Fri,  1 Nov 2024 15:47:26 +0000
Message-ID: <20241101154724.203525-4-matthew.auld@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241101154724.203525-3-matthew.auld@intel.com>
References: <20241101154724.203525-3-matthew.auld@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GGTT looks to be stored inside stolen memory on igpu which is not
treated as normal RAM.  The core kernel skips this memory range when
creating the hibernation image, therefore when coming back from
hibernation the GGTT programming is lost. This seems to cause issues
with broken resume where GuC FW fails to load:

[drm] *ERROR* GT0: load failed: status = 0x400000A0, time = 10ms, freq = 1250MHz (req 1300MHz), done = -1
[drm] *ERROR* GT0: load failed: status: Reset = 0, BootROM = 0x50, UKernel = 0x00, MIA = 0x00, Auth = 0x01
[drm] *ERROR* GT0: firmware signature verification failed
[drm] *ERROR* CRITICAL: Xe has declared device 0000:00:02.0 as wedged.

Current GGTT users are kernel internal and tracked as pinned, so it
should be possible to hook into the existing save/restore logic that we
use for dgpu, where the actual evict is skipped but on restore we
importantly restore the GGTT programming.  This has been confirmed to
fix hibernation on at least ADL and MTL, though likely all igpu
platforms are affected.

This also means we have a hole in our testing, where the existing s4
tests only really test the driver hooks, and don't go as far as actually
rebooting and restoring from the hibernation image and in turn powering
down RAM (and therefore losing the contents of stolen).

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/3275
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
---
 drivers/gpu/drm/xe/xe_bo.c       | 36 ++++++++++++++------------------
 drivers/gpu/drm/xe/xe_bo_evict.c |  6 ------
 2 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index d79d8ef5c7d5..0ae5c8f7bab8 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -950,7 +950,10 @@ int xe_bo_restore_pinned(struct xe_bo *bo)
 	if (WARN_ON(!xe_bo_is_pinned(bo)))
 		return -EINVAL;
 
-	if (WARN_ON(xe_bo_is_vram(bo) || !bo->ttm.ttm))
+	if (WARN_ON(xe_bo_is_vram(bo)))
+		return -EINVAL;
+
+	if (WARN_ON(!bo->ttm.ttm && !xe_bo_is_stolen(bo)))
 		return -EINVAL;
 
 	if (!mem_type_is_vram(place->mem_type))
@@ -1770,6 +1773,7 @@ int xe_bo_pin_external(struct xe_bo *bo)
 
 int xe_bo_pin(struct xe_bo *bo)
 {
+	struct ttm_place *place = &(bo->placements[0]);
 	struct xe_device *xe = xe_bo_device(bo);
 	int err;
 
@@ -1800,7 +1804,6 @@ int xe_bo_pin(struct xe_bo *bo)
 	 */
 	if (IS_DGFX(xe) && !(IS_ENABLED(CONFIG_DRM_XE_DEBUG) &&
 	    bo->flags & XE_BO_FLAG_INTERNAL_TEST)) {
-		struct ttm_place *place = &(bo->placements[0]);
 
 		if (mem_type_is_vram(place->mem_type)) {
 			xe_assert(xe, place->flags & TTM_PL_FLAG_CONTIGUOUS);
@@ -1809,13 +1812,12 @@ int xe_bo_pin(struct xe_bo *bo)
 				       vram_region_gpu_offset(bo->ttm.resource)) >> PAGE_SHIFT;
 			place->lpfn = place->fpfn + (bo->size >> PAGE_SHIFT);
 		}
+	}
 
-		if (mem_type_is_vram(place->mem_type) ||
-		    bo->flags & XE_BO_FLAG_GGTT) {
-			spin_lock(&xe->pinned.lock);
-			list_add_tail(&bo->pinned_link, &xe->pinned.kernel_bo_present);
-			spin_unlock(&xe->pinned.lock);
-		}
+	if (mem_type_is_vram(place->mem_type) || bo->flags & XE_BO_FLAG_GGTT) {
+		spin_lock(&xe->pinned.lock);
+		list_add_tail(&bo->pinned_link, &xe->pinned.kernel_bo_present);
+		spin_unlock(&xe->pinned.lock);
 	}
 
 	ttm_bo_pin(&bo->ttm);
@@ -1863,24 +1865,18 @@ void xe_bo_unpin_external(struct xe_bo *bo)
 
 void xe_bo_unpin(struct xe_bo *bo)
 {
+	struct ttm_place *place = &(bo->placements[0]);
 	struct xe_device *xe = xe_bo_device(bo);
 
 	xe_assert(xe, !bo->ttm.base.import_attach);
 	xe_assert(xe, xe_bo_is_pinned(bo));
 
-	if (IS_DGFX(xe) && !(IS_ENABLED(CONFIG_DRM_XE_DEBUG) &&
-	    bo->flags & XE_BO_FLAG_INTERNAL_TEST)) {
-		struct ttm_place *place = &(bo->placements[0]);
-
-		if (mem_type_is_vram(place->mem_type) ||
-		    bo->flags & XE_BO_FLAG_GGTT) {
-			spin_lock(&xe->pinned.lock);
-			xe_assert(xe, !list_empty(&bo->pinned_link));
-			list_del_init(&bo->pinned_link);
-			spin_unlock(&xe->pinned.lock);
-		}
+	if (mem_type_is_vram(place->mem_type) || bo->flags & XE_BO_FLAG_GGTT) {
+		spin_lock(&xe->pinned.lock);
+		xe_assert(xe, !list_empty(&bo->pinned_link));
+		list_del_init(&bo->pinned_link);
+		spin_unlock(&xe->pinned.lock);
 	}
-
 	ttm_bo_unpin(&bo->ttm);
 }
 
diff --git a/drivers/gpu/drm/xe/xe_bo_evict.c b/drivers/gpu/drm/xe/xe_bo_evict.c
index 32043e1e5a86..b01bc20eb90b 100644
--- a/drivers/gpu/drm/xe/xe_bo_evict.c
+++ b/drivers/gpu/drm/xe/xe_bo_evict.c
@@ -34,9 +34,6 @@ int xe_bo_evict_all(struct xe_device *xe)
 	u8 id;
 	int ret;
 
-	if (!IS_DGFX(xe))
-		return 0;
-
 	/* User memory */
 	for (mem_type = XE_PL_VRAM0; mem_type <= XE_PL_VRAM1; ++mem_type) {
 		struct ttm_resource_manager *man =
@@ -125,9 +122,6 @@ int xe_bo_restore_kernel(struct xe_device *xe)
 	struct xe_bo *bo;
 	int ret;
 
-	if (!IS_DGFX(xe))
-		return 0;
-
 	spin_lock(&xe->pinned.lock);
 	for (;;) {
 		bo = list_first_entry_or_null(&xe->pinned.evicted,
-- 
2.47.0


