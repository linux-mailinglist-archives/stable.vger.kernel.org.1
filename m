Return-Path: <stable+bounces-143298-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 104E7AB3D8A
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 18:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 340E917A203
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 16:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B80E24BC01;
	Mon, 12 May 2025 16:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ue1j+dDZ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F00296146
	for <stable@vger.kernel.org>; Mon, 12 May 2025 16:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747066942; cv=none; b=GBJkv3bNb/kDnlU9B+nIBFJr/p8IHyZ8bHnIHT4EBQFu9Am8BKO+rdtRlaxNcWIbr5Wl75I5pP7EaRKcBA+Z2+uAVGduJBaf26PHhB7QtV/4L3CSIykGp3uQ6NsM4bdFIzjDaKUqHI80+ukusDvl3ZtYEgyf0XnLsHfbzMtjBJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747066942; c=relaxed/simple;
	bh=0dqOp3Pgln+ypz6hC9RiZnuoVBVIKng2l+q1FMgTu6o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vFFqRKrJlSJvwHB+u+wM/yaFFDGEO+aUQBsImusixU5LOLAhdXjx7OdznwFT27FHrOu3hdJkEGmp5ZHqeDF0Of+RKPGOHmyIrwzcOl+kzMh6MkJ7B6usrnO57oVqlrBJvwAB4+790HPVU/nurzQiPIq0lLNfJF4UCm+C1GTGbeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ue1j+dDZ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747066941; x=1778602941;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0dqOp3Pgln+ypz6hC9RiZnuoVBVIKng2l+q1FMgTu6o=;
  b=Ue1j+dDZh9refcVjfb6DmjVyYrFdQAwWDmBywcTKhblMoep9CKhVjloC
   T03glo11Ez6mkRJHbNgnHkSwKWUVzMfIvTrg6+RLP4aDdS1EdUUm3geXC
   VOQoIk1YwEO9GBNg6aMl58DqAvM60Cj982tt5nwU3TwLGaqFyoqDYYPSe
   tyZr5sqk+28ANgN+kzuJCWsm0K5zcnkmv7Bp47UBSmm8DXOcPDJN9s5+h
   r1lS2ZV6AG52TH461zh0T3HLBpSaEuGR3DV1SivWbJOOpEErPE9U1+IBe
   9SRnZqE1DMAsS476DgdS3VXuDUFCJK9NVNYV/TWI9/T8LkfcY7E6g+xX+
   w==;
X-CSE-ConnectionGUID: 0OjadGRKSE+0QvxRlEVLZQ==
X-CSE-MsgGUID: A5DRJbz6QOKrauW+7eLZrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="59508074"
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; 
   d="scan'208";a="59508074"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 09:22:20 -0700
X-CSE-ConnectionGUID: QhRkqykhRN2FBJzftA6VOg==
X-CSE-MsgGUID: dUFFQuhiSeu10AyOxFyc2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; 
   d="scan'208";a="142532642"
Received: from unknown (HELO himal-Super-Server.iind.intel.com) ([10.190.239.34])
  by orviesa005.jf.intel.com with ESMTP; 12 May 2025 09:22:18 -0700
From: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.brost@intel.com,
	thomas.hellstrom@linux.intel.com,
	stable@vger.kernel.org,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Subject: [PATCH v8 02/20] drm/xe: Strict migration policy for atomic SVM faults
Date: Mon, 12 May 2025 22:17:22 +0530
Message-Id: <20250512164740.466852-3-himal.prasad.ghimiray@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250512164740.466852-1-himal.prasad.ghimiray@intel.com>
References: <20250512164740.466852-1-himal.prasad.ghimiray@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Matthew Brost <matthew.brost@intel.com>

Mixing GPU and CPU atomics does not work unless a strict migration
policy of GPU atomics must be device memory. Enforce a policy of must be
in VRAM with a retry loop of 3 attempts, if retry loop fails abort
fault.

Removing always_migrate_to_vram modparam as we now have real migration
policy.

v2:
 - Only retry migration on atomics
 - Drop alway migrate modparam
v3:
 - Only set vram_only on DGFX (Himal)
 - Bail on get_pages failure if vram_only and retry count exceeded (Himal)
 - s/vram_only/devmem_only
 - Update xe_svm_range_is_valid to accept devmem_only argument
v4:
 - Fix logic bug get_pages failure
v5:
 - Fix commit message (Himal)
 - Mention removing always_migrate_to_vram in commit message (Lucas)
 - Fix xe_svm_range_is_valid to check for devmem pages
 - Bail on devmem_only && !migrate_devmem (Thomas)
v6:
 - Add READ_ONCE barriers for opportunistic checks (Thomas)
 - Pair READ_ONCE with WRITE_ONCE (Thomas)
v7:
 - Adjust comments (Thomas)

Fixes: 2f118c949160 ("drm/xe: Add SVM VRAM migration")
Cc: stable@vger.kernel.org
Signed-off-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Acked-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>`
Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/drm_gpusvm.c   |  23 +++++--
 drivers/gpu/drm/xe/xe_module.c |   3 -
 drivers/gpu/drm/xe/xe_module.h |   1 -
 drivers/gpu/drm/xe/xe_pt.c     |  14 ++++-
 drivers/gpu/drm/xe/xe_svm.c    | 111 +++++++++++++++++++++++++--------
 drivers/gpu/drm/xe/xe_svm.h    |   5 --
 include/drm/drm_gpusvm.h       |  40 +++++++-----
 7 files changed, 140 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index a58d03e6cac2..41f6616bcf76 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -1118,6 +1118,10 @@ static void __drm_gpusvm_range_unmap_pages(struct drm_gpusvm *gpusvm,
 	lockdep_assert_held(&gpusvm->notifier_lock);
 
 	if (range->flags.has_dma_mapping) {
+		struct drm_gpusvm_range_flags flags = {
+			.__flags = range->flags.__flags,
+		};
+
 		for (i = 0, j = 0; i < npages; j++) {
 			struct drm_pagemap_device_addr *addr = &range->dma_addr[j];
 
@@ -1131,8 +1135,12 @@ static void __drm_gpusvm_range_unmap_pages(struct drm_gpusvm *gpusvm,
 							    dev, *addr);
 			i += 1 << addr->order;
 		}
-		range->flags.has_devmem_pages = false;
-		range->flags.has_dma_mapping = false;
+
+		/* WRITE_ONCE pairs with READ_ONCE for opportunistic checks */
+		flags.has_devmem_pages = false;
+		flags.has_dma_mapping = false;
+		WRITE_ONCE(range->flags.__flags, flags.__flags);
+
 		range->dpagemap = NULL;
 	}
 }
@@ -1334,6 +1342,7 @@ int drm_gpusvm_range_get_pages(struct drm_gpusvm *gpusvm,
 	int err = 0;
 	struct dev_pagemap *pagemap;
 	struct drm_pagemap *dpagemap;
+	struct drm_gpusvm_range_flags flags;
 
 retry:
 	hmm_range.notifier_seq = mmu_interval_read_begin(notifier);
@@ -1378,7 +1387,8 @@ int drm_gpusvm_range_get_pages(struct drm_gpusvm *gpusvm,
 	 */
 	drm_gpusvm_notifier_lock(gpusvm);
 
-	if (range->flags.unmapped) {
+	flags.__flags = range->flags.__flags;
+	if (flags.unmapped) {
 		drm_gpusvm_notifier_unlock(gpusvm);
 		err = -EFAULT;
 		goto err_free;
@@ -1474,14 +1484,17 @@ int drm_gpusvm_range_get_pages(struct drm_gpusvm *gpusvm,
 		}
 		i += 1 << order;
 		num_dma_mapped = i;
-		range->flags.has_dma_mapping = true;
+		flags.has_dma_mapping = true;
 	}
 
 	if (zdd) {
-		range->flags.has_devmem_pages = true;
+		flags.has_devmem_pages = true;
 		range->dpagemap = dpagemap;
 	}
 
+	/* WRITE_ONCE pairs with READ_ONCE for opportunistic checks */
+	WRITE_ONCE(range->flags.__flags, flags.__flags);
+
 	drm_gpusvm_notifier_unlock(gpusvm);
 	kvfree(pfns);
 set_seqno:
diff --git a/drivers/gpu/drm/xe/xe_module.c b/drivers/gpu/drm/xe/xe_module.c
index 64bf46646544..e4742e27e2cd 100644
--- a/drivers/gpu/drm/xe/xe_module.c
+++ b/drivers/gpu/drm/xe/xe_module.c
@@ -30,9 +30,6 @@ struct xe_modparam xe_modparam = {
 module_param_named(svm_notifier_size, xe_modparam.svm_notifier_size, uint, 0600);
 MODULE_PARM_DESC(svm_notifier_size, "Set the svm notifier size(in MiB), must be power of 2");
 
-module_param_named(always_migrate_to_vram, xe_modparam.always_migrate_to_vram, bool, 0444);
-MODULE_PARM_DESC(always_migrate_to_vram, "Always migrate to VRAM on GPU fault");
-
 module_param_named_unsafe(force_execlist, xe_modparam.force_execlist, bool, 0444);
 MODULE_PARM_DESC(force_execlist, "Force Execlist submission");
 
diff --git a/drivers/gpu/drm/xe/xe_module.h b/drivers/gpu/drm/xe/xe_module.h
index 84339e509c80..5a3bfea8b7b4 100644
--- a/drivers/gpu/drm/xe/xe_module.h
+++ b/drivers/gpu/drm/xe/xe_module.h
@@ -12,7 +12,6 @@
 struct xe_modparam {
 	bool force_execlist;
 	bool probe_display;
-	bool always_migrate_to_vram;
 	u32 force_vram_bar_size;
 	int guc_log_level;
 	char *guc_firmware_path;
diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
index b42cf5d1b20c..b04756a97cdc 100644
--- a/drivers/gpu/drm/xe/xe_pt.c
+++ b/drivers/gpu/drm/xe/xe_pt.c
@@ -2270,11 +2270,19 @@ static void op_commit(struct xe_vm *vm,
 	}
 	case DRM_GPUVA_OP_DRIVER:
 	{
+		/* WRITE_ONCE pairs with READ_ONCE in xe_svm.c */
+
 		if (op->subop == XE_VMA_SUBOP_MAP_RANGE) {
-			op->map_range.range->tile_present |= BIT(tile->id);
-			op->map_range.range->tile_invalidated &= ~BIT(tile->id);
+			WRITE_ONCE(op->map_range.range->tile_present,
+				   op->map_range.range->tile_present |
+				   BIT(tile->id));
+			WRITE_ONCE(op->map_range.range->tile_invalidated,
+				   op->map_range.range->tile_invalidated &
+				   ~BIT(tile->id));
 		} else if (op->subop == XE_VMA_SUBOP_UNMAP_RANGE) {
-			op->unmap_range.range->tile_present &= ~BIT(tile->id);
+			WRITE_ONCE(op->unmap_range.range->tile_present,
+				   op->unmap_range.range->tile_present &
+				   ~BIT(tile->id));
 		}
 		break;
 	}
diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
index d25f02c8d7fc..d8e15259a8df 100644
--- a/drivers/gpu/drm/xe/xe_svm.c
+++ b/drivers/gpu/drm/xe/xe_svm.c
@@ -16,8 +16,17 @@
 
 static bool xe_svm_range_in_vram(struct xe_svm_range *range)
 {
-	/* Not reliable without notifier lock */
-	return range->base.flags.has_devmem_pages;
+	/*
+	 * Advisory only check whether the range is currently backed by VRAM
+	 * memory.
+	 */
+
+	struct drm_gpusvm_range_flags flags = {
+		/* Pairs with WRITE_ONCE in drm_gpusvm.c */
+		.__flags = READ_ONCE(range->base.flags.__flags),
+	};
+
+	return flags.has_devmem_pages;
 }
 
 static bool xe_svm_range_has_vram_binding(struct xe_svm_range *range)
@@ -650,9 +659,16 @@ void xe_svm_fini(struct xe_vm *vm)
 }
 
 static bool xe_svm_range_is_valid(struct xe_svm_range *range,
-				  struct xe_tile *tile)
+				  struct xe_tile *tile,
+				  bool devmem_only)
 {
-	return (range->tile_present & ~range->tile_invalidated) & BIT(tile->id);
+	/*
+	 * Advisory only check whether the range currently has a valid mapping,
+	 * READ_ONCE pairs with WRITE_ONCE in xe_pt.c
+	 */
+	return ((READ_ONCE(range->tile_present) &
+		 ~READ_ONCE(range->tile_invalidated)) & BIT(tile->id)) &&
+		(!devmem_only || xe_svm_range_in_vram(range));
 }
 
 #if IS_ENABLED(CONFIG_DRM_XE_DEVMEM_MIRROR)
@@ -726,6 +742,36 @@ static int xe_svm_alloc_vram(struct xe_vm *vm, struct xe_tile *tile,
 }
 #endif
 
+static bool supports_4K_migration(struct xe_device *xe)
+{
+	if (xe->info.vram_flags & XE_VRAM_FLAGS_NEED64K)
+		return false;
+
+	return true;
+}
+
+static bool xe_svm_range_needs_migrate_to_vram(struct xe_svm_range *range,
+					       struct xe_vma *vma)
+{
+	struct xe_vm *vm = range_to_vm(&range->base);
+	u64 range_size = xe_svm_range_size(range);
+
+	if (!range->base.flags.migrate_devmem)
+		return false;
+
+	if (xe_svm_range_in_vram(range)) {
+		drm_dbg(&vm->xe->drm, "Range is already in VRAM\n");
+		return false;
+	}
+
+	if (range_size <= SZ_64K && !supports_4K_migration(vm->xe)) {
+		drm_dbg(&vm->xe->drm, "Platform doesn't support SZ_4K range migration\n");
+		return false;
+	}
+
+	return true;
+}
+
 /**
  * xe_svm_handle_pagefault() - SVM handle page fault
  * @vm: The VM.
@@ -749,12 +795,15 @@ int xe_svm_handle_pagefault(struct xe_vm *vm, struct xe_vma *vma,
 			IS_ENABLED(CONFIG_DRM_XE_DEVMEM_MIRROR),
 		.check_pages_threshold = IS_DGFX(vm->xe) &&
 			IS_ENABLED(CONFIG_DRM_XE_DEVMEM_MIRROR) ? SZ_64K : 0,
+		.devmem_only = atomic && IS_DGFX(vm->xe) &&
+			IS_ENABLED(CONFIG_DRM_XE_DEVMEM_MIRROR),
 	};
 	struct xe_svm_range *range;
 	struct drm_gpusvm_range *r;
 	struct drm_exec exec;
 	struct dma_fence *fence;
 	struct xe_tile *tile = gt_to_tile(gt);
+	int migrate_try_count = ctx.devmem_only ? 3 : 1;
 	ktime_t end = 0;
 	int err;
 
@@ -775,24 +824,30 @@ int xe_svm_handle_pagefault(struct xe_vm *vm, struct xe_vma *vma,
 	if (IS_ERR(r))
 		return PTR_ERR(r);
 
+	if (ctx.devmem_only && !r->flags.migrate_devmem)
+		return -EACCES;
+
 	range = to_xe_range(r);
-	if (xe_svm_range_is_valid(range, tile))
+	if (xe_svm_range_is_valid(range, tile, ctx.devmem_only))
 		return 0;
 
 	range_debug(range, "PAGE FAULT");
 
-	/* XXX: Add migration policy, for now migrate range once */
-	if (!range->skip_migrate && range->base.flags.migrate_devmem &&
-	    xe_svm_range_size(range) >= SZ_64K) {
-		range->skip_migrate = true;
-
+	if (--migrate_try_count >= 0 &&
+	    xe_svm_range_needs_migrate_to_vram(range, vma)) {
 		err = xe_svm_alloc_vram(vm, tile, range, &ctx);
 		if (err) {
-			drm_dbg(&vm->xe->drm,
-				"VRAM allocation failed, falling back to "
-				"retrying fault, asid=%u, errno=%pe\n",
-				vm->usm.asid, ERR_PTR(err));
-			goto retry;
+			if (migrate_try_count || !ctx.devmem_only) {
+				drm_dbg(&vm->xe->drm,
+					"VRAM allocation failed, falling back to retrying fault, asid=%u, errno=%pe\n",
+					vm->usm.asid, ERR_PTR(err));
+				goto retry;
+			} else {
+				drm_err(&vm->xe->drm,
+					"VRAM allocation failed, retry count exceeded, asid=%u, errno=%pe\n",
+					vm->usm.asid, ERR_PTR(err));
+				return err;
+			}
 		}
 	}
 
@@ -800,15 +855,22 @@ int xe_svm_handle_pagefault(struct xe_vm *vm, struct xe_vma *vma,
 	err = drm_gpusvm_range_get_pages(&vm->svm.gpusvm, r, &ctx);
 	/* Corner where CPU mappings have changed */
 	if (err == -EOPNOTSUPP || err == -EFAULT || err == -EPERM) {
-		if (err == -EOPNOTSUPP) {
-			range_debug(range, "PAGE FAULT - EVICT PAGES");
-			drm_gpusvm_range_evict(&vm->svm.gpusvm, &range->base);
+		if (migrate_try_count > 0 || !ctx.devmem_only) {
+			if (err == -EOPNOTSUPP) {
+				range_debug(range, "PAGE FAULT - EVICT PAGES");
+				drm_gpusvm_range_evict(&vm->svm.gpusvm,
+						       &range->base);
+			}
+			drm_dbg(&vm->xe->drm,
+				"Get pages failed, falling back to retrying, asid=%u, gpusvm=%p, errno=%pe\n",
+				vm->usm.asid, &vm->svm.gpusvm, ERR_PTR(err));
+			range_debug(range, "PAGE FAULT - RETRY PAGES");
+			goto retry;
+		} else {
+			drm_err(&vm->xe->drm,
+				"Get pages failed, retry count exceeded, asid=%u, gpusvm=%p, errno=%pe\n",
+				vm->usm.asid, &vm->svm.gpusvm, ERR_PTR(err));
 		}
-		drm_dbg(&vm->xe->drm,
-			"Get pages failed, falling back to retrying, asid=%u, gpusvm=%p, errno=%pe\n",
-			vm->usm.asid, &vm->svm.gpusvm, ERR_PTR(err));
-		range_debug(range, "PAGE FAULT - RETRY PAGES");
-		goto retry;
 	}
 	if (err) {
 		range_debug(range, "PAGE FAULT - FAIL PAGE COLLECT");
@@ -842,9 +904,6 @@ int xe_svm_handle_pagefault(struct xe_vm *vm, struct xe_vma *vma,
 	}
 	drm_exec_fini(&exec);
 
-	if (xe_modparam.always_migrate_to_vram)
-		range->skip_migrate = false;
-
 	dma_fence_wait(fence, false);
 	dma_fence_put(fence);
 
diff --git a/drivers/gpu/drm/xe/xe_svm.h b/drivers/gpu/drm/xe/xe_svm.h
index 2881af1e60b2..30fc78b85b30 100644
--- a/drivers/gpu/drm/xe/xe_svm.h
+++ b/drivers/gpu/drm/xe/xe_svm.h
@@ -39,11 +39,6 @@ struct xe_svm_range {
 	 * range. Protected by GPU SVM notifier lock.
 	 */
 	u8 tile_invalidated;
-	/**
-	 * @skip_migrate: Skip migration to VRAM, protected by GPU fault handler
-	 * locking.
-	 */
-	u8 skip_migrate	:1;
 };
 
 /**
diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
index 9fd25fc880a4..653d48dbe1c1 100644
--- a/include/drm/drm_gpusvm.h
+++ b/include/drm/drm_gpusvm.h
@@ -185,6 +185,31 @@ struct drm_gpusvm_notifier {
 	} flags;
 };
 
+/**
+ * struct drm_gpusvm_range_flags - Structure representing a GPU SVM range flags
+ *
+ * @migrate_devmem: Flag indicating whether the range can be migrated to device memory
+ * @unmapped: Flag indicating if the range has been unmapped
+ * @partial_unmap: Flag indicating if the range has been partially unmapped
+ * @has_devmem_pages: Flag indicating if the range has devmem pages
+ * @has_dma_mapping: Flag indicating if the range has a DMA mapping
+ * @__flags: Flags for range in u16 form (used for READ_ONCE)
+ */
+struct drm_gpusvm_range_flags {
+	union {
+		struct {
+			/* All flags below must be set upon creation */
+			u16 migrate_devmem : 1;
+			/* All flags below must be set / cleared under notifier lock */
+			u16 unmapped : 1;
+			u16 partial_unmap : 1;
+			u16 has_devmem_pages : 1;
+			u16 has_dma_mapping : 1;
+		};
+		u16 __flags;
+	};
+};
+
 /**
  * struct drm_gpusvm_range - Structure representing a GPU SVM range
  *
@@ -198,11 +223,6 @@ struct drm_gpusvm_notifier {
  * @dpagemap: The struct drm_pagemap of the device pages we're dma-mapping.
  *            Note this is assuming only one drm_pagemap per range is allowed.
  * @flags: Flags for range
- * @flags.migrate_devmem: Flag indicating whether the range can be migrated to device memory
- * @flags.unmapped: Flag indicating if the range has been unmapped
- * @flags.partial_unmap: Flag indicating if the range has been partially unmapped
- * @flags.has_devmem_pages: Flag indicating if the range has devmem pages
- * @flags.has_dma_mapping: Flag indicating if the range has a DMA mapping
  *
  * This structure represents a GPU SVM range used for tracking memory ranges
  * mapped in a DRM device.
@@ -216,15 +236,7 @@ struct drm_gpusvm_range {
 	unsigned long notifier_seq;
 	struct drm_pagemap_device_addr *dma_addr;
 	struct drm_pagemap *dpagemap;
-	struct {
-		/* All flags below must be set upon creation */
-		u16 migrate_devmem : 1;
-		/* All flags below must be set / cleared under notifier lock */
-		u16 unmapped : 1;
-		u16 partial_unmap : 1;
-		u16 has_devmem_pages : 1;
-		u16 has_dma_mapping : 1;
-	} flags;
+	struct drm_gpusvm_range_flags flags;
 };
 
 /**
-- 
2.34.1


