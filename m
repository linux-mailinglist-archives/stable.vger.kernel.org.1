Return-Path: <stable+bounces-119931-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DC5A497A5
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 11:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41D083BA4F6
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 10:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8494725F7B1;
	Fri, 28 Feb 2025 10:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BZkAQFD+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19B225D910
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 10:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740739479; cv=none; b=O1sYmrBL+Au1+dhk/sFXCqF6ubOF7dKtmD4Fl2GddC466q7Tba6ig+r83qryU3Iaq0z2K0NUKVslJ7iMDWxCqp7NlBacurYL105DbLvOdvv6pCmbd23F0eDVIa0mmkPhrSQLdQEZGHq8gcwloco46E6rXiSTnb3fESKFqyWr/ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740739479; c=relaxed/simple;
	bh=IPabpKlL0RXk21YuKRWFebst8QcMGrxlX6fKwfKsK40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dGiZaubS9YOCPLVQuxWC2jeeNdIauPD0UjVT9K4JD/G8mvD1oKVlwMaRn8PlM4tPwfeHs5/cTStupADGEqtVcT+2xpnMFafLeaVHy75FQ5NpXCuiNvoyiZrDTkPBcuOYmF1vMYbM24vHauBkIzhduORX3evB4uY2a92yjlFoKGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BZkAQFD+; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740739477; x=1772275477;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IPabpKlL0RXk21YuKRWFebst8QcMGrxlX6fKwfKsK40=;
  b=BZkAQFD+ol+FxmY1yPwRElEvmtt5Lq4UoKYSPDZwCzAByBa1hozfy6Bg
   vM8sjXhoFv4Umt6ArI0IREOZo9QTl4kxuyC17tnyz9IIh0Vry+11Eewuu
   zeuMsnkdIxIZ7Xe+eOm/xLfkZoIWQzL5NDbvx6Bh9dAKlvFcR/lBRvvK7
   +oHRkWT4gjU/HyOo2lNcptNCO3OyLoxX0FRYZtvBFfHTCZxK6lOiIcY+b
   5QOYJBPCyAlE65jjDzX6whVFA5Gcho1QUcquQMazkGYt0jyVoeevWdHAZ
   vN59Gov0Y0g/4hp8aMpN9onPh7IVlmBTwsX11J0doX6Lf3QNRIy3Eqizv
   A==;
X-CSE-ConnectionGUID: +MdanTznRFWIEwXP2sTACQ==
X-CSE-MsgGUID: NxbUcVTyQBOIxRrjie3zEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="40840568"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="40840568"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 02:44:37 -0800
X-CSE-ConnectionGUID: TZn2ipAnSDCxfzCEKZrtZg==
X-CSE-MsgGUID: v2AhIybMQkqdFkExHh0qqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="148114588"
Received: from monicael-mobl3 (HELO fedora..) ([10.245.246.40])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 02:44:36 -0800
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Oak Zeng <oak.zeng@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/3] drm/xe/userptr: Unmap userptrs in the mmu notifier
Date: Fri, 28 Feb 2025 11:44:18 +0100
Message-ID: <20250228104418.44313-4-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228104418.44313-1-thomas.hellstrom@linux.intel.com>
References: <20250228104418.44313-1-thomas.hellstrom@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If userptr pages are freed after a call to the xe mmu notifier,
the device will not be blocked out from theoretically accessing
these pages unless they are also unmapped from the iommu, and
this violates some aspects of the iommu-imposed security.

Ensure that userptrs are unmapped in the mmu notifier to
mitigate this. A naive attempt would try to free the sg table, but
the sg table itself may be accessed by a concurrent bind
operation, so settle for unly unmapping.

Fixes: 81e058a3e7fd ("drm/xe: Introduce helper to populate userptr")
Cc: Oak Zeng <oak.zeng@intel.com>
Cc: <stable@vger.kernel.org> # v6.10+
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_hmm.c      | 49 ++++++++++++++++++++++++++------
 drivers/gpu/drm/xe/xe_hmm.h      |  2 ++
 drivers/gpu/drm/xe/xe_vm.c       |  4 +++
 drivers/gpu/drm/xe/xe_vm_types.h |  4 +++
 4 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_hmm.c b/drivers/gpu/drm/xe/xe_hmm.c
index d3b5551496d0..35d257d4680f 100644
--- a/drivers/gpu/drm/xe/xe_hmm.c
+++ b/drivers/gpu/drm/xe/xe_hmm.c
@@ -136,6 +136,43 @@ static int xe_build_sg(struct xe_device *xe, struct hmm_range *range,
 			       DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_NO_KERNEL_MAPPING);
 }
 
+static void xe_hmm_userptr_set_mapped(struct xe_userptr_vma *uvma)
+{
+	struct xe_userptr *userptr = &uvma->userptr;
+	struct xe_vm *vm = xe_vma_vm(&uvma->vma);
+
+	lockdep_assert_held_write(&vm->lock);
+
+	mutex_lock(&userptr->unmap_mutex);
+	xe_assert(vm->xe, !userptr->mapped);
+	userptr->mapped = true;
+	mutex_unlock(&userptr->unmap_mutex);
+}
+
+void xe_hmm_userptr_unmap(struct xe_userptr_vma *uvma)
+{
+	struct xe_userptr *userptr = &uvma->userptr;
+	struct xe_vma *vma = &uvma->vma;
+	bool write = !xe_vma_read_only(vma);
+	struct xe_vm *vm = xe_vma_vm(vma);
+	struct xe_device *xe = vm->xe;
+
+	if (!lockdep_is_held_type(&vm->userptr.notifier_lock, 0) &&
+	    !lockdep_is_held_type(&vm->lock, 0) &&
+	    !(vma->gpuva.flags & XE_VMA_DESTROYED)) {
+		xe_vm_assert_held(vm);
+		lockdep_assert_held(&vm->userptr.notifier_lock);
+		lockdep_assert_held(&vm->lock);
+	}
+
+	mutex_lock(&userptr->unmap_mutex);
+	if (userptr->sg && userptr->mapped)
+		dma_unmap_sgtable(xe->drm.dev, userptr->sg,
+				  write ? DMA_BIDIRECTIONAL : DMA_TO_DEVICE, 0);
+	userptr->mapped = false;
+	mutex_unlock(&userptr->unmap_mutex);
+}
+
 /**
  * xe_hmm_userptr_free_sg() - Free the scatter gather table of userptr
  * @uvma: the userptr vma which hold the scatter gather table
@@ -147,16 +184,9 @@ static int xe_build_sg(struct xe_device *xe, struct hmm_range *range,
 void xe_hmm_userptr_free_sg(struct xe_userptr_vma *uvma)
 {
 	struct xe_userptr *userptr = &uvma->userptr;
-	struct xe_vma *vma = &uvma->vma;
-	bool write = !xe_vma_read_only(vma);
-	struct xe_vm *vm = xe_vma_vm(vma);
-	struct xe_device *xe = vm->xe;
-	struct device *dev = xe->drm.dev;
-
-	xe_assert(xe, userptr->sg);
-	dma_unmap_sgtable(dev, userptr->sg,
-			  write ? DMA_BIDIRECTIONAL : DMA_TO_DEVICE, 0);
 
+	xe_assert(xe_vma_vm(&uvma->vma)->xe, userptr->sg);
+	xe_hmm_userptr_unmap(uvma);
 	sg_free_table(userptr->sg);
 	userptr->sg = NULL;
 }
@@ -290,6 +320,7 @@ int xe_hmm_userptr_populate_range(struct xe_userptr_vma *uvma,
 
 	xe_mark_range_accessed(&hmm_range, write);
 	userptr->sg = &userptr->sgt;
+	xe_hmm_userptr_set_mapped(uvma);
 	userptr->notifier_seq = hmm_range.notifier_seq;
 	up_read(&vm->userptr.notifier_lock);
 	kvfree(pfns);
diff --git a/drivers/gpu/drm/xe/xe_hmm.h b/drivers/gpu/drm/xe/xe_hmm.h
index 9602cb7d976d..0ea98d8e7bbc 100644
--- a/drivers/gpu/drm/xe/xe_hmm.h
+++ b/drivers/gpu/drm/xe/xe_hmm.h
@@ -13,4 +13,6 @@ struct xe_userptr_vma;
 int xe_hmm_userptr_populate_range(struct xe_userptr_vma *uvma, bool is_mm_mmap_locked);
 
 void xe_hmm_userptr_free_sg(struct xe_userptr_vma *uvma);
+
+void xe_hmm_userptr_unmap(struct xe_userptr_vma *uvma);
 #endif
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index dd422ac95dc0..3dbd3d38008a 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -621,6 +621,8 @@ static void __vma_userptr_invalidate(struct xe_vm *vm, struct xe_userptr_vma *uv
 		err = xe_vm_invalidate_vma(vma);
 		XE_WARN_ON(err);
 	}
+
+	xe_hmm_userptr_unmap(uvma);
 }
 
 static bool vma_userptr_invalidate(struct mmu_interval_notifier *mni,
@@ -1039,6 +1041,7 @@ static struct xe_vma *xe_vma_create(struct xe_vm *vm,
 			INIT_LIST_HEAD(&userptr->invalidate_link);
 			INIT_LIST_HEAD(&userptr->repin_link);
 			vma->gpuva.gem.offset = bo_offset_or_userptr;
+			mutex_init(&userptr->unmap_mutex);
 
 			err = mmu_interval_notifier_insert(&userptr->notifier,
 							   current->mm,
@@ -1080,6 +1083,7 @@ static void xe_vma_destroy_late(struct xe_vma *vma)
 		 * them anymore
 		 */
 		mmu_interval_notifier_remove(&userptr->notifier);
+		mutex_destroy(&userptr->unmap_mutex);
 		xe_vm_put(vm);
 	} else if (xe_vma_is_null(vma)) {
 		xe_vm_put(vm);
diff --git a/drivers/gpu/drm/xe/xe_vm_types.h b/drivers/gpu/drm/xe/xe_vm_types.h
index 1fe79bf23b6b..eca73c4197d4 100644
--- a/drivers/gpu/drm/xe/xe_vm_types.h
+++ b/drivers/gpu/drm/xe/xe_vm_types.h
@@ -59,12 +59,16 @@ struct xe_userptr {
 	struct sg_table *sg;
 	/** @notifier_seq: notifier sequence number */
 	unsigned long notifier_seq;
+	/** @unmap_mutex: Mutex protecting dma-unmapping */
+	struct mutex unmap_mutex;
 	/**
 	 * @initial_bind: user pointer has been bound at least once.
 	 * write: vm->userptr.notifier_lock in read mode and vm->resv held.
 	 * read: vm->userptr.notifier_lock in write mode or vm->resv held.
 	 */
 	bool initial_bind;
+	/** @mapped: Whether the @sgt sg-table is dma-mapped. Protected by @unmap_mutex. */
+	bool mapped;
 #if IS_ENABLED(CONFIG_DRM_XE_USERPTR_INVAL_INJECT)
 	u32 divisor;
 #endif
-- 
2.48.1


