Return-Path: <stable+bounces-120361-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 363C6A4EA35
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 18:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D67D19C2303
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 17:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6911B27EC9E;
	Tue,  4 Mar 2025 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n3DtKGnY"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C112853EB
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 17:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741109643; cv=none; b=YHbWITDXCOWp5AZqfxkZYQNRnCGdVHf9EIRckjdUlg/ZZ3V9hDqSgmrYIAp1EOLFSaRw8sWcaPfmDyiiQ0SoUFerEbluY3Fiv0Dw5bmNUE79pKmG7xjpQrDQQbnRoD6K5K2E4ZOedUop5V2niZesFvvYKdcD1lxtVwBq7wExZhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741109643; c=relaxed/simple;
	bh=Q8ykoHajhYKC/0j99YakSq7ktOxPNaZq3ahZ19lMjXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qEv5W0hzrKbf5BGWhljQtiNsSRX0Daj0iDxP3T0KB27lo1jzMo7pjZ0pUc01ccU+ZcF3qFqzAqX4zAq+LkjmtB0gjMb5k/8Uhtflcnb7016kmJCvzuEGCk6GkK/GVChPGutSaz3xLGqVDi6Mzx8+psZk0UWhtPrXyMqjXjnvE90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n3DtKGnY; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741109641; x=1772645641;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q8ykoHajhYKC/0j99YakSq7ktOxPNaZq3ahZ19lMjXM=;
  b=n3DtKGnYqZyzoQrU/L2Bk2o+cubnd0yG2NUmQ+vXBJdWo/Xet5xG4BuQ
   gZSgeq1NS8CIvw5VNqY8L+LjH9BBlCsmjhxKFqUBEttQ1sUSo+dS7qFaO
   8/5w79lwuKZI951fFXX+OVaukCtRgmDMybxeft0nQ5TnvLpNWHdZJojm4
   SxdhqhEvsjzgnJ0NbS1am4R5L3vaXKxoBE2EblOp1I8ojUGP6I3ky7i+R
   whIaKWD6M8jOhDm408uhrmFNMSEtCHjZN8jIdapwPg3C/5jeIEb+r1E4m
   pikNFBwtG5mfWM/GOOWDorD5s8uyqWj1NeDoq0LA/qoKVg121As7vO5Re
   Q==;
X-CSE-ConnectionGUID: epImKt/1RRGaN+w/qk1s+A==
X-CSE-MsgGUID: pU1xMeNUSTmgc2VsQ95CgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42172084"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="42172084"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 09:34:01 -0800
X-CSE-ConnectionGUID: em3oKGuBR+aIT+tlPT8zjw==
X-CSE-MsgGUID: dQW+X3LiSmuGQp4oD9K/TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="119123302"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO fedora..) ([10.245.246.227])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 09:34:00 -0800
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Oak Zeng <oak.zeng@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 3/3] drm/xe/userptr: Unmap userptrs in the mmu notifier
Date: Tue,  4 Mar 2025 18:33:42 +0100
Message-ID: <20250304173342.22009-4-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304173342.22009-1-thomas.hellstrom@linux.intel.com>
References: <20250304173342.22009-1-thomas.hellstrom@linux.intel.com>
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
operation, so settle for only unmapping.

v3:
- Update lockdep asserts.
- Fix a typo (Matthew Auld)

Fixes: 81e058a3e7fd ("drm/xe: Introduce helper to populate userptr")
Cc: Oak Zeng <oak.zeng@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: <stable@vger.kernel.org> # v6.10+
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
---
 drivers/gpu/drm/xe/xe_hmm.c      | 51 ++++++++++++++++++++++++++------
 drivers/gpu/drm/xe/xe_hmm.h      |  2 ++
 drivers/gpu/drm/xe/xe_vm.c       |  4 +++
 drivers/gpu/drm/xe/xe_vm_types.h |  4 +++
 4 files changed, 52 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_hmm.c b/drivers/gpu/drm/xe/xe_hmm.c
index d33dd7bc3f41..68a5bc1cf77b 100644
--- a/drivers/gpu/drm/xe/xe_hmm.c
+++ b/drivers/gpu/drm/xe/xe_hmm.c
@@ -150,6 +150,45 @@ static int xe_build_sg(struct xe_device *xe, struct hmm_range *range,
 			       DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_NO_KERNEL_MAPPING);
 }
 
+static void xe_hmm_userptr_set_mapped(struct xe_userptr_vma *uvma)
+{
+	struct xe_userptr *userptr = &uvma->userptr;
+	struct xe_vm *vm = xe_vma_vm(&uvma->vma);
+
+	lockdep_assert_held_write(&vm->lock);
+	lockdep_assert_held(&vm->userptr.notifier_lock);
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
+		/* Don't unmap in exec critical section. */
+		xe_vm_assert_held(vm);
+		/* Don't unmap while mapping the sg. */
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
@@ -161,16 +200,9 @@ static int xe_build_sg(struct xe_device *xe, struct hmm_range *range,
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
@@ -295,6 +327,7 @@ int xe_hmm_userptr_populate_range(struct xe_userptr_vma *uvma,
 
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


