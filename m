Return-Path: <stable+bounces-166677-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DCCB1BFEA
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 07:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0B82625F49
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 05:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B82F1F416B;
	Wed,  6 Aug 2025 05:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W3vAXLCd"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F171F1313;
	Wed,  6 Aug 2025 05:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754458046; cv=none; b=FKu/VduN6Bx4W1U9wbn2fR30L69IF4T/bZy7k/zXbw8+S2yUE+W+QJ9/NY7vpifOMwikh8ame0jmntAxj4ntEqPjD7jWTRMa387IQhReZRC48gV9xbfv02cos8FfutLlYlZpSf0S8RWVm+9cKsl796D8pl0Dw+pxwrgK3HBb1MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754458046; c=relaxed/simple;
	bh=HRKGh5GMr0Y0GiAjduAzHB/gbXfyTo85oBnav1YXI8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y6kmMmaCc8TTknQx3GkNAnBUcvU3dYezlFjVdyBywkq8JkNMbI/U1CwjPfW5MW2b2mDEalqkgONOE5bPni1b8RLdzvBOs+ZZg0AKECUpxKNiGMBm3kPfXPcuDvjaqdbXg5ZDMT1NOCizPM22tuUHkXyRhPpJ7ty4mro0hhNzD4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W3vAXLCd; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754458044; x=1785994044;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HRKGh5GMr0Y0GiAjduAzHB/gbXfyTo85oBnav1YXI8s=;
  b=W3vAXLCdUkbJV//0Woze8WM2P2knZnDt7IG8DBmrmTvjfnftgyLBfby9
   WvyygRWyVSO4Q6tpwEFkjPNQpwWrvAMxl+gPcLfYpHS6vIDjuZKn/+mhl
   RTUa4wpY2xHKdabSfUEorxcvlubSJfIz3JOB3dMUgAi459Pk27Kp/WIiA
   S/1WLO3dwvY5DoSjhUPErdQC2BeSTaFG75SefnVstBjqGkgWVV8cHL8Ow
   MyKaNsf3i2oPtc3BYzAXlV1bFp1MHa85EGIcOTszDqbTMyqhpGWQXsOau
   IxNb+CV07yvnUQqYuGzO84OyOaF+wjIXWT5kwU1pZedY15tN2EHODhCu8
   Q==;
X-CSE-ConnectionGUID: rKvl7hLtSh2zxxHkyNW3Cw==
X-CSE-MsgGUID: UAbf+92qReyyjuGIBoBu+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="55977835"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="55977835"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 22:27:23 -0700
X-CSE-ConnectionGUID: JW0BjZwXRziKhvoP66NqIA==
X-CSE-MsgGUID: 5OZ4BVhJSyWm4iHSzrdM8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="164215209"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa007.fm.intel.com with ESMTP; 05 Aug 2025 22:27:19 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jann Horn <jannh@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>,
	Yi Lai <yi1.lai@intel.com>
Cc: iommu@lists.linux.dev,
	security@kernel.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/1] iommu/sva: Invalidate KVA range on kernel TLB flush
Date: Wed,  6 Aug 2025 13:25:05 +0800
Message-ID: <20250806052505.3113108-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In the IOMMU Shared Virtual Addressing (SVA) context, the IOMMU hardware
shares and walks the CPU's page tables. The Linux x86 architecture maps
the kernel address space into the upper portion of every process’s page
table. Consequently, in an SVA context, the IOMMU hardware can walk and
cache kernel space mappings. However, the Linux kernel currently lacks
a notification mechanism for kernel space mapping changes. This means
the IOMMU driver is not aware of such changes, leading to a break in
IOMMU cache coherence.

Modern IOMMUs often cache page table entries of the intermediate-level
page table as long as the entry is valid, no matter the permissions, to
optimize walk performance. Currently the iommu driver is notified only
for changes of user VA mappings, so the IOMMU's internal caches may
retain stale entries for kernel VA. When kernel page table mappings are
changed (e.g., by vfree()), but the IOMMU's internal caches retain stale
entries, Use-After-Free (UAF) vulnerability condition arises.

If these freed page table pages are reallocated for a different purpose,
potentially by an attacker, the IOMMU could misinterpret the new data as
valid page table entries. This allows the IOMMU to walk into attacker-
controlled memory, leading to arbitrary physical memory DMA access or
privilege escalation.

To mitigate this, introduce a new iommu interface to flush IOMMU caches.
This interface should be invoked from architecture-specific code that
manages combined user and kernel page tables, whenever a kernel page table
update is done and the CPU TLB needs to be flushed.

Fixes: 26b25a2b98e4 ("iommu: Bind process address spaces to devices")
Cc: stable@vger.kernel.org
Suggested-by: Jann Horn <jannh@google.com>
Co-developed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
---
 arch/x86/mm/tlb.c         |  4 +++
 drivers/iommu/iommu-sva.c | 60 ++++++++++++++++++++++++++++++++++++++-
 include/linux/iommu.h     |  4 +++
 3 files changed, 67 insertions(+), 1 deletion(-)

Change log:
v3:
 - iommu_sva_mms is an unbound list; iterating it in an atomic context
   could introduce significant latency issues. Schedule it in a kernel
   thread and replace the spinlock with a mutex.
 - Replace the static key with a normal bool; it can be brought back if
   data shows the benefit.
 - Invalidate KVA range in the flush_tlb_all() paths.
 - All previous reviewed-bys are preserved. Please let me know if there
   are any objections.

v2:
 - https://lore.kernel.org/linux-iommu/20250709062800.651521-1-baolu.lu@linux.intel.com/
 - Remove EXPORT_SYMBOL_GPL(iommu_sva_invalidate_kva_range);
 - Replace the mutex with a spinlock to make the interface usable in the
   critical regions.

v1: https://lore.kernel.org/linux-iommu/20250704133056.4023816-1-baolu.lu@linux.intel.com/

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 39f80111e6f1..3b85e7d3ba44 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -12,6 +12,7 @@
 #include <linux/task_work.h>
 #include <linux/mmu_notifier.h>
 #include <linux/mmu_context.h>
+#include <linux/iommu.h>
 
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
@@ -1478,6 +1479,8 @@ void flush_tlb_all(void)
 	else
 		/* Fall back to the IPI-based invalidation. */
 		on_each_cpu(do_flush_tlb_all, NULL, 1);
+
+	iommu_sva_invalidate_kva_range(0, TLB_FLUSH_ALL);
 }
 
 /* Flush an arbitrarily large range of memory with INVLPGB. */
@@ -1540,6 +1543,7 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 		kernel_tlb_flush_range(info);
 
 	put_flush_tlb_info();
+	iommu_sva_invalidate_kva_range(start, end);
 }
 
 /*
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 1a51cfd82808..d0da2b3fd64b 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -10,6 +10,8 @@
 #include "iommu-priv.h"
 
 static DEFINE_MUTEX(iommu_sva_lock);
+static bool iommu_sva_present;
+static LIST_HEAD(iommu_sva_mms);
 static struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
 						   struct mm_struct *mm);
 
@@ -42,6 +44,7 @@ static struct iommu_mm_data *iommu_alloc_mm_data(struct mm_struct *mm, struct de
 		return ERR_PTR(-ENOSPC);
 	}
 	iommu_mm->pasid = pasid;
+	iommu_mm->mm = mm;
 	INIT_LIST_HEAD(&iommu_mm->sva_domains);
 	/*
 	 * Make sure the write to mm->iommu_mm is not reordered in front of
@@ -132,8 +135,13 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 	if (ret)
 		goto out_free_domain;
 	domain->users = 1;
-	list_add(&domain->next, &mm->iommu_mm->sva_domains);
 
+	if (list_empty(&iommu_mm->sva_domains)) {
+		if (list_empty(&iommu_sva_mms))
+			WRITE_ONCE(iommu_sva_present, true);
+		list_add(&iommu_mm->mm_list_elm, &iommu_sva_mms);
+	}
+	list_add(&domain->next, &iommu_mm->sva_domains);
 out:
 	refcount_set(&handle->users, 1);
 	mutex_unlock(&iommu_sva_lock);
@@ -175,6 +183,13 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
 		list_del(&domain->next);
 		iommu_domain_free(domain);
 	}
+
+	if (list_empty(&iommu_mm->sva_domains)) {
+		list_del(&iommu_mm->mm_list_elm);
+		if (list_empty(&iommu_sva_mms))
+			WRITE_ONCE(iommu_sva_present, false);
+	}
+
 	mutex_unlock(&iommu_sva_lock);
 	kfree(handle);
 }
@@ -312,3 +327,46 @@ static struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
 
 	return domain;
 }
+
+struct kva_invalidation_work_data {
+	struct work_struct work;
+	unsigned long start;
+	unsigned long end;
+};
+
+static void invalidate_kva_func(struct work_struct *work)
+{
+	struct kva_invalidation_work_data *data =
+		container_of(work, struct kva_invalidation_work_data, work);
+	struct iommu_mm_data *iommu_mm;
+
+	guard(mutex)(&iommu_sva_lock);
+	list_for_each_entry(iommu_mm, &iommu_sva_mms, mm_list_elm)
+		mmu_notifier_arch_invalidate_secondary_tlbs(iommu_mm->mm,
+				data->start, data->end);
+
+	kfree(data);
+}
+
+void iommu_sva_invalidate_kva_range(unsigned long start, unsigned long end)
+{
+	struct kva_invalidation_work_data *data;
+
+	if (likely(!READ_ONCE(iommu_sva_present)))
+		return;
+
+	/* will be freed in the task function */
+	data = kzalloc(sizeof(*data), GFP_ATOMIC);
+	if (!data)
+		return;
+
+	data->start = start;
+	data->end = end;
+	INIT_WORK(&data->work, invalidate_kva_func);
+
+	/*
+	 * Since iommu_sva_mms is an unbound list, iterating it in an atomic
+	 * context could introduce significant latency issues.
+	 */
+	schedule_work(&data->work);
+}
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index c30d12e16473..66e4abb2df0d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1134,7 +1134,9 @@ struct iommu_sva {
 
 struct iommu_mm_data {
 	u32			pasid;
+	struct mm_struct	*mm;
 	struct list_head	sva_domains;
+	struct list_head	mm_list_elm;
 };
 
 int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode);
@@ -1615,6 +1617,7 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev,
 					struct mm_struct *mm);
 void iommu_sva_unbind_device(struct iommu_sva *handle);
 u32 iommu_sva_get_pasid(struct iommu_sva *handle);
+void iommu_sva_invalidate_kva_range(unsigned long start, unsigned long end);
 #else
 static inline struct iommu_sva *
 iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
@@ -1639,6 +1642,7 @@ static inline u32 mm_get_enqcmd_pasid(struct mm_struct *mm)
 }
 
 static inline void mm_pasid_drop(struct mm_struct *mm) {}
+static inline void iommu_sva_invalidate_kva_range(unsigned long start, unsigned long end) {}
 #endif /* CONFIG_IOMMU_SVA */
 
 #ifdef CONFIG_IOMMU_IOPF
-- 
2.43.0


