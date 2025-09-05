Return-Path: <stable+bounces-177782-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBC1B44DBA
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 07:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACFC0488D47
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 05:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A72527D776;
	Fri,  5 Sep 2025 05:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="evy9xbAl"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B90B2765E3;
	Fri,  5 Sep 2025 05:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757051631; cv=none; b=CiJn71CRMh+5VX5PYhqP5/r96PhYxIlO/ilVsHnaFJwN7nppVoR/Gmw9jPS1T20M9cSCjRi981glm8WbpjzgOifeVrCyHU9Ds/X0t8ItgEqhYc829cdaObI0UutJxO/OU9rZpM3eea+dI6yBnfGMOBpUqHmuSZJhFitYDPrPrJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757051631; c=relaxed/simple;
	bh=6GHT4PiZ6qBzFbzaFMfbG7VyjEvCdedpy+KfqQr0cZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fX80+qsL+5/MMvTTyyW6dl6VxYf/1XPcM/NPDztLqh9VZdNLl36Up/v3CX7D9qjDxF6WlnrUDxlrWfdKuPpEB2LTMnlJBIborBriVqEeC+An2hZ+XxuJliqqTOZi+IIIbS2LhW7xLb8oww1x3iUcAK97owF0BU5mRFuCQwGcbgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=evy9xbAl; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757051629; x=1788587629;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6GHT4PiZ6qBzFbzaFMfbG7VyjEvCdedpy+KfqQr0cZ8=;
  b=evy9xbAlYyNdcPPE6VxRCflsGjIJuI9JiIYpQWA0xoEIMFYwilRxadHF
   kpG//9Ob5gerU6kHEcFY+LltQ/wO5wjbQfSgcRBIWM7+VBezM31leBB8E
   +ogWOR+HBIsT2gliPrvREqKqYCbYSIVK87kPAhfbTMjgv4EHvwsQeQ/hY
   qlE0ePk4rkcJu+Hjfu3SuUm7piCy20ijybBAWok60ZVjMqXtxCL3LeO1D
   C4Lddzn80vnRm1ibd8QTkOIorTX32Rr8lD3aPc5JB4MT1iWaqXXRnws+B
   VNmLyyKokeL38GNy9Qhq+aAdR1c3dRXe/ISh2xlwq9tKZfSIl2TPqp5BP
   w==;
X-CSE-ConnectionGUID: 6kwxkRpzQMi/R4n8h292ZQ==
X-CSE-MsgGUID: 0DUBRJ6zTlq6L1LDMjQr+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="70015180"
X-IronPort-AV: E=Sophos;i="6.18,240,1751266800"; 
   d="scan'208";a="70015180"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 22:53:49 -0700
X-CSE-ConnectionGUID: Z7MYerB1TmmAc0gm/frbvg==
X-CSE-MsgGUID: Xl6B3EtVSOqbHDEK8Zr86Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,240,1751266800"; 
   d="scan'208";a="209257788"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa001.jf.intel.com with ESMTP; 04 Sep 2025 22:53:45 -0700
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
Subject: [PATCH v4 8/8] iommu/sva: Invalidate stale IOTLB entries for kernel address space
Date: Fri,  5 Sep 2025 13:51:03 +0800
Message-ID: <20250905055103.3821518-9-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250905055103.3821518-1-baolu.lu@linux.intel.com>
References: <20250905055103.3821518-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the IOMMU Shared Virtual Addressing (SVA) context, the IOMMU hardware
shares and walks the CPU's page tables. The x86 architecture maps the
kernel's virtual address space into the upper portion of every process's
page table. Consequently, in an SVA context, the IOMMU hardware can walk
and cache kernel page table entries.

The Linux kernel currently lacks a notification mechanism for kernel page
table changes, specifically when page table pages are freed and reused.
The IOMMU driver is only notified of changes to user virtual address
mappings. This can cause the IOMMU's internal caches to retain stale
entries for kernel VA.

A Use-After-Free (UAF) and Write-After-Free (WAF) condition arises when
kernel page table pages are freed and later reallocated. The IOMMU could
misinterpret the new data as valid page table entries. The IOMMU might
then walk into attacker-controlled memory, leading to arbitrary physical
memory DMA access or privilege escalation. This is also a Write-After-Free
issue, as the IOMMU will potentially continue to write Accessed and Dirty
bits to the freed memory while attempting to walk the stale page tables.

Currently, SVA contexts are unprivileged and cannot access kernel
mappings. However, the IOMMU will still walk kernel-only page tables
all the way down to the leaf entries, where it realizes the mapping
is for the kernel and errors out. This means the IOMMU still caches
these intermediate page table entries, making the described vulnerability
a real concern.

To mitigate this, a new IOMMU interface is introduced to flush IOTLB
entries for the kernel address space. This interface is invoked from the
x86 architecture code that manages combined user and kernel page tables,
specifically when a kernel page table update requires a CPU TLB flush.

Fixes: 26b25a2b98e4 ("iommu: Bind process address spaces to devices")
Cc: stable@vger.kernel.org
Suggested-by: Jann Horn <jannh@google.com>
Co-developed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/iommu-sva.c | 29 ++++++++++++++++++++++++++++-
 include/linux/iommu.h     |  4 ++++
 mm/pgtable-generic.c      |  2 ++
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 1a51cfd82808..d236aef80a8d 100644
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
+			iommu_sva_present = true;
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
+			iommu_sva_present = false;
+	}
+
 	mutex_unlock(&iommu_sva_lock);
 	kfree(handle);
 }
@@ -312,3 +327,15 @@ static struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
 
 	return domain;
 }
+
+void iommu_sva_invalidate_kva_range(unsigned long start, unsigned long end)
+{
+	struct iommu_mm_data *iommu_mm;
+
+	guard(mutex)(&iommu_sva_lock);
+	if (!iommu_sva_present)
+		return;
+
+	list_for_each_entry(iommu_mm, &iommu_sva_mms, mm_list_elm)
+		mmu_notifier_arch_invalidate_secondary_tlbs(iommu_mm->mm, start, end);
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
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index cf884e8300ca..4c81ca8b196f 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -13,6 +13,7 @@
 #include <linux/swap.h>
 #include <linux/swapops.h>
 #include <linux/mm_inline.h>
+#include <linux/iommu.h>
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
 
@@ -430,6 +431,7 @@ static void kernel_pgtable_work_func(struct work_struct *work)
 	list_splice_tail_init(&kernel_pgtable_work.list, &page_list);
 	spin_unlock(&kernel_pgtable_work.lock);
 
+	iommu_sva_invalidate_kva_range(PAGE_OFFSET, TLB_FLUSH_ALL);
 	list_for_each_entry_safe(pt, next, &page_list, pt_list) {
 		list_del(&pt->pt_list);
 		__pagetable_free(pt);
-- 
2.43.0


