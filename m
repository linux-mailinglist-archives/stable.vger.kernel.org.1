Return-Path: <stable+bounces-185657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BC0BD9A3E
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 15:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36D4B188B619
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 13:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFF3319613;
	Tue, 14 Oct 2025 13:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D1srO15R"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728BA319600;
	Tue, 14 Oct 2025 13:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760447303; cv=none; b=aRy4AVQwoIBSiSoI1X3kBMKoltrrWChJCymsc9N53NMITVB4eyxgV2Es65Rcpn6m1bZS7NtjP2kyBWtsJMfFBJwOJKelyFoxsK/nMR68BnOZfYrJRnRbgdwTtyc0TT9CbjJklLpN7/7lRyMj7vm3d95T4cQbVSDP2FievSdPfLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760447303; c=relaxed/simple;
	bh=i9IOH9O/QwIEJOJX4Hmu4TbYsCb1D/4y6+SywTSOJWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OH5ArCG6LgVuiztDoqpbfDJvRNN0MEUiMWmCWmNAQwim7s7UPZuX9lqK1mL2AgX4aA52SRbD0yOp/js0CnNaZZcNv84tMOp1+KxofgZCm/p0Z2/lpDdGxyKK2ecukOAo/6mxlt8O+Hltds40fLc4HYXMi40joEYt98nOZ0Ckwyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D1srO15R; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760447302; x=1791983302;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i9IOH9O/QwIEJOJX4Hmu4TbYsCb1D/4y6+SywTSOJWg=;
  b=D1srO15RM0Gmo4UiVPf1izv1zpJjKaHumqUgW7BuMIO4wKzsynFbRuhJ
   d2zu/gia5D4GDpx7O8mQLkvppgri/vJBHyg2Mbn46WDgkX0i/72gKArbd
   VHkH/awaFyGhMd6PQjmEcydwQdgVUW5BiC1ysKmbdUrVFWyYp/MlBZOPh
   XiKuetaFRTE0dAK73WOgTqtTVGkMdWj0PycpWZGEgsE358eHWlwoUiiyo
   drGTm1FUivnrSq91PUdm2pCngwVaIdhR5eJmoP0o6UN5ki5VTFrzU4R1i
   TtfGDderCrnkkbH79dUoSErY2NyvS+pOsJKFBZI70L11oAqFCF7ByNqL8
   A==;
X-CSE-ConnectionGUID: MEkm/SdZTzSHkqR8yyPaJw==
X-CSE-MsgGUID: J5VHLOpFS4+1owjjQlt6Pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62515502"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62515502"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 06:08:21 -0700
X-CSE-ConnectionGUID: 53aYxaR4Qh2tVgAdaUeJww==
X-CSE-MsgGUID: cJiEiFtbThGI+AD5JzUPxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; 
   d="scan'208";a="182675720"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa010.fm.intel.com with ESMTP; 14 Oct 2025 06:08:13 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jann Horn <jannh@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>,
	Yi Lai <yi1.lai@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Cc: iommu@lists.linux.dev,
	security@kernel.org,
	x86@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v6 7/7] iommu/sva: Invalidate stale IOTLB entries for kernel address space
Date: Tue, 14 Oct 2025 21:04:37 +0800
Message-ID: <20251014130437.1090448-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014130437.1090448-1-baolu.lu@linux.intel.com>
References: <20251014130437.1090448-1-baolu.lu@linux.intel.com>
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
specifically before any kernel page table page is freed and reused.

This addresses the main issue with vfree() which is a common occurrence
and can be triggered by unprivileged users. While this resolves the
primary problem, it doesn't address some extremely rare case related to
memory unplug of memory that was present as reserved memory at boot,
which cannot be triggered by unprivileged users. The discussion can be
found at the link below.

Fixes: 26b25a2b98e4 ("iommu: Bind process address spaces to devices")
Cc: stable@vger.kernel.org
Suggested-by: Jann Horn <jannh@google.com>
Co-developed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/linux-iommu/04983c62-3b1d-40d4-93ae-34ca04b827e5@intel.com/
---
 include/linux/iommu.h     |  4 ++++
 drivers/iommu/iommu-sva.c | 29 ++++++++++++++++++++++++++++-
 mm/pgtable-generic.c      |  2 ++
 3 files changed, 34 insertions(+), 1 deletion(-)

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
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 1c7caa8ef164..8c22be79b734 100644
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
 	list_for_each_entry_safe(pt, next, &page_list, pt_list)
 		__pagetable_free(pt);
 }
-- 
2.43.0


