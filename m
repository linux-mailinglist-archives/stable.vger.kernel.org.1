Return-Path: <stable+bounces-41788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 595E08B681C
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 04:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9FAA1F221C7
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 02:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F32DDA1;
	Tue, 30 Apr 2024 02:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ALo/enCJ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022AED517
	for <stable@vger.kernel.org>; Tue, 30 Apr 2024 02:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714445990; cv=none; b=Rk2R0BgBsUTAFo/SvesUDtNCCeuHPMOM3f84dA0P5wlOZ42DgAxlvjQWGBBz7/QgTTbfSRdOLZanjys3stQ/GflCz3lWiK9N3OPAn8JZbiEf43bNtY1VQZX6z6EnHlDRTydvZ4fc74slWJtRwL9XvA0zThMk92iWUlG/v3xjYHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714445990; c=relaxed/simple;
	bh=AdkdOKu7YviakUnJTPuBRqgmfDaNW/NwZTHp9gvlUiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=JkufW/Hj1KBwymgnNxK7wT9ABd1c3lh7OetNad1nNK/i+HkDA1AqtRc+iAnfYllWIltri9iE7amR6teIRWuITvZf3t5UY02BWh5GXkkuGGO9VXxfGwWQDwajJMesrYK0+9CNtVYpFbWCq8PQb/Jkiy8jP6wZlsN0ga/XTcms9N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ALo/enCJ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714445989; x=1745981989;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AdkdOKu7YviakUnJTPuBRqgmfDaNW/NwZTHp9gvlUiQ=;
  b=ALo/enCJIrSUVSCr9nG9e70CnDZBnrgFZfSzFvuEKJNOqYIBDHMlnVUM
   V5oGbkDktj7JkG1rtMBIpd9HLeLEoT4vudimeVzb2lINn0gwG3JivnII2
   ZLvYnMV4b0HceSX+3kPAWV5B9iY7hLANmfnd/AbdayFBMbOw0njHVKc/r
   Vo8XjOgSHZqcHBD3qKoRoo3H515FJNIPcyxtHRMQPETA7njqaLgMI1Z/U
   9wAOIZqyqDyb9xcwtKxtbSoItfXHu+pqvXjFVPMJMaAygKP8/3tA3KX1F
   Q1Bqfnnqhq9LeYQnBautoLSHVgh6RjT1jRz5ohU7HcYsh6RGsVqrgVUcF
   g==;
X-CSE-ConnectionGUID: INBVy8l+TyaNfajHuTKAgw==
X-CSE-MsgGUID: ABq+OehqTASQoR8xeY3g4w==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="32634394"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="32634394"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 19:59:48 -0700
X-CSE-ConnectionGUID: /5x2oLcWTGOVkgdoVu5E/g==
X-CSE-MsgGUID: Ph7AS8ixSiyCtNU1a2y/NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="26398497"
Received: from lstrano-desk.jf.intel.com ([10.54.39.91])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 19:59:47 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: <intel-xe@lists.freedesktop.org>
Cc: Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe: Unmap userptr in MMU invalidation notifier
Date: Mon, 29 Apr 2024 20:00:20 -0700
Message-Id: <20240430030020.2306682-1-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

To be secure, when a userptr is invalidated the pages should be dma
unmapped ensuring the device can no longer touch the invalidated pages.

v2:
 - Don't free sg table in MMU notifer, just dma unmap pages

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Fixes: 12f4b58a37f4 ("drm/xe: Use hmm_range_fault to populate user pages")
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: stable@vger.kernel.org # 6.8
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_hmm.c      | 42 ++++++++++++++++++++++++++------
 drivers/gpu/drm/xe/xe_hmm.h      |  1 +
 drivers/gpu/drm/xe/xe_pt.c       |  2 +-
 drivers/gpu/drm/xe/xe_vm.c       |  5 +++-
 drivers/gpu/drm/xe/xe_vm_types.h |  5 +++-
 5 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_hmm.c b/drivers/gpu/drm/xe/xe_hmm.c
index 2c32dc46f7d4..baf42514e1f9 100644
--- a/drivers/gpu/drm/xe/xe_hmm.c
+++ b/drivers/gpu/drm/xe/xe_hmm.c
@@ -112,16 +112,20 @@ static int xe_build_sg(struct xe_device *xe, struct hmm_range *range,
 	return ret;
 }
 
-/*
- * xe_hmm_userptr_free_sg() - Free the scatter gather table of userptr
+#define need_unmap(__sg)	((u64)(__sg) & 0x1ull)
+#define clear_need_unmap(__sg)	(__sg) = (struct sg_table *)((u64)(__sg) & ~0x1ull)
+#define set_need_unmap(__sg)	(__sg) = (struct sg_table *)((u64)(__sg) | 0x1ull)
+
+/**
+ * xe_hmm_userptr_unmap_sg() - Unmap the scatter gather table of userptr
  *
  * @uvma: the userptr vma which hold the scatter gather table
  *
  * With function xe_userptr_populate_range, we allocate storage of
- * the userptr sg table. This is a helper function to free this
- * sg table, and dma unmap the address in the table.
+ * the userptr sg table. This is a helper function to dma unmap the address in
+ * the table.
  */
-void xe_hmm_userptr_free_sg(struct xe_userptr_vma *uvma)
+void xe_hmm_userptr_unmap_sg(struct xe_userptr_vma *uvma)
 {
 	struct xe_userptr *userptr = &uvma->userptr;
 	struct xe_vma *vma = &uvma->vma;
@@ -129,11 +133,34 @@ void xe_hmm_userptr_free_sg(struct xe_userptr_vma *uvma)
 	struct xe_vm *vm = xe_vma_vm(vma);
 	struct xe_device *xe = vm->xe;
 	struct device *dev = xe->drm.dev;
+	bool do_unmap;
 
 	xe_assert(xe, userptr->sg);
-	dma_unmap_sgtable(dev, userptr->sg,
-			  write ? DMA_BIDIRECTIONAL : DMA_TO_DEVICE, 0);
 
+	spin_lock(&vm->userptr.invalidated_lock);
+	do_unmap = need_unmap(userptr->sg);
+	clear_need_unmap(userptr->sg);
+	spin_unlock(&vm->userptr.invalidated_lock);
+
+	if (do_unmap)
+		dma_unmap_sgtable(dev, userptr->sg,
+				  write ? DMA_BIDIRECTIONAL : DMA_TO_DEVICE, 0);
+}
+
+/*
+ * xe_hmm_userptr_free_sg() - Free the scatter gather table of userptr
+ *
+ * @uvma: the userptr vma which hold the scatter gather table
+ *
+ * With function xe_userptr_populate_range, we allocate storage of
+ * the userptr sg table. This is a helper function to free this
+ * sg table, and dma unmap the address in the table.
+ */
+void xe_hmm_userptr_free_sg(struct xe_userptr_vma *uvma)
+{
+	struct xe_userptr *userptr = &uvma->userptr;
+
+	xe_hmm_userptr_unmap_sg(uvma);
 	sg_free_table(userptr->sg);
 	userptr->sg = NULL;
 }
@@ -244,6 +271,7 @@ int xe_hmm_userptr_populate_range(struct xe_userptr_vma *uvma,
 
 	xe_mark_range_accessed(&hmm_range, write);
 	userptr->sg = &userptr->sgt;
+	set_need_unmap(userptr->sg);
 	userptr->notifier_seq = hmm_range.notifier_seq;
 
 free_pfns:
diff --git a/drivers/gpu/drm/xe/xe_hmm.h b/drivers/gpu/drm/xe/xe_hmm.h
index 909dc2bdcd97..56e653dc9fa2 100644
--- a/drivers/gpu/drm/xe/xe_hmm.h
+++ b/drivers/gpu/drm/xe/xe_hmm.h
@@ -9,3 +9,4 @@ struct xe_userptr_vma;
 
 int xe_hmm_userptr_populate_range(struct xe_userptr_vma *uvma, bool is_mm_mmap_locked);
 void xe_hmm_userptr_free_sg(struct xe_userptr_vma *uvma);
+void xe_hmm_userptr_unmap_sg(struct xe_userptr_vma *uvma);
diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
index 8d3765d3351e..b095257dc684 100644
--- a/drivers/gpu/drm/xe/xe_pt.c
+++ b/drivers/gpu/drm/xe/xe_pt.c
@@ -635,7 +635,7 @@ xe_pt_stage_bind(struct xe_tile *tile, struct xe_vma *vma,
 
 	if (!xe_vma_is_null(vma)) {
 		if (xe_vma_is_userptr(vma))
-			xe_res_first_sg(to_userptr_vma(vma)->userptr.sg, 0,
+			xe_res_first_sg(vma_to_userptr_sg(vma), 0,
 					xe_vma_size(vma), &curs);
 		else if (xe_bo_is_vram(bo) || xe_bo_is_stolen(bo))
 			xe_res_first(bo->ttm.resource, xe_vma_bo_offset(vma),
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index dfd31b346021..c3d54dcf2a3e 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -637,6 +637,9 @@ static bool vma_userptr_invalidate(struct mmu_interval_notifier *mni,
 		XE_WARN_ON(err);
 	}
 
+	if (userptr->sg)
+		xe_hmm_userptr_unmap_sg(uvma);
+
 	trace_xe_vma_userptr_invalidate_complete(vma);
 
 	return true;
@@ -3405,7 +3408,7 @@ int xe_analyze_vm(struct drm_printer *p, struct xe_vm *vm, int gt_id)
 		if (is_null) {
 			addr = 0;
 		} else if (is_userptr) {
-			struct sg_table *sg = to_userptr_vma(vma)->userptr.sg;
+			struct sg_table *sg = vma_to_userptr_sg(vma);
 			struct xe_res_cursor cur;
 
 			if (sg) {
diff --git a/drivers/gpu/drm/xe/xe_vm_types.h b/drivers/gpu/drm/xe/xe_vm_types.h
index ce1a63a5e3e7..0478a2235076 100644
--- a/drivers/gpu/drm/xe/xe_vm_types.h
+++ b/drivers/gpu/drm/xe/xe_vm_types.h
@@ -34,6 +34,9 @@ struct xe_vm;
 #define XE_VMA_PTE_COMPACT	(DRM_GPUVA_USERBITS << 9)
 #define XE_VMA_DUMPABLE		(DRM_GPUVA_USERBITS << 10)
 
+#define vma_to_userptr_sg(__vma) \
+	(struct sg_table *)((u64)to_userptr_vma((__vma))->userptr.sg & ~0x1ull)
+
 /** struct xe_userptr - User pointer */
 struct xe_userptr {
 	/** @invalidate_link: Link for the vm::userptr.invalidated list */
@@ -206,7 +209,7 @@ struct xe_vm {
 		struct rw_semaphore notifier_lock;
 		/**
 		 * @userptr.invalidated_lock: Protects the
-		 * @userptr.invalidated list.
+		 * @userptr.invalidated list and dma mapped pages of userptrs
 		 */
 		spinlock_t invalidated_lock;
 		/**
-- 
2.34.1


