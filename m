Return-Path: <stable+bounces-161385-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD78BAFDFF4
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 08:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 325187A8381
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 06:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA1121ABC8;
	Wed,  9 Jul 2025 06:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SfATefAx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1A5AD24;
	Wed,  9 Jul 2025 06:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752042626; cv=none; b=Raz/zc0AyGGS65HQegmzHTrajdQDGwwXYeykDk9SP++su1N6o5rtZMrS0+KKHyc/nk1dQsP9JRCJ/cGn498w36cIyWQ9e1mr/k2YK2yUs9M/ezuzPhJWmZac7UxkJnnZmgdLvKdDA8CWRDfzWdt12VaFt0cOdB/UCrAVnPsUNUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752042626; c=relaxed/simple;
	bh=ztwWtVLvW2JDQVkityE8xy5rSww8WpTrou8OU/HC1cY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PehPEeaWKKZXJWH86TAsS0StjVuuVHL5kdnYYK9t0qBKuPxf4aBJmo74GiHxWW9FTvgunLeSvmfZ31w7xyuMNKRZp7CE4nnvPHO989TXZqGFKIvdIXqwqjxb08hpttJds9b8wnb2t1lUunQfbVGj2bqc8YgkN/FZ4Il4WAxSDEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SfATefAx; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752042625; x=1783578625;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ztwWtVLvW2JDQVkityE8xy5rSww8WpTrou8OU/HC1cY=;
  b=SfATefAxhrxYC6fxqHngDSYQpgapPk8AG1psjklAeueWx7l6w+2j414Z
   zU9i9ZOLPKaTtPdx/cfNcBpouA0o4Kp4Ztv852BLHJLuK9hqqs3Pa/LE+
   1KbVyPcTgnErLY4P2jvz+E/CF6CgrCOrki1NCwx7hRP2HmkfoPgpUyuba
   VbAefHCFyCQKldB+kfnTa6BC6aWQ8prP2kGTt9AttyKF6W6j5s88iSBEM
   uETWzM5uxu2a54POv1/exMPOuyG6SwXJFZjfgaTxi0mkrLPxaMq6N/np4
   SX9ERbmXXf5+DM2Ix+jlVX71zhazH7zIS3FtBL+fTZL/A1QnkBcCCzZnV
   g==;
X-CSE-ConnectionGUID: 29cogkrMT/qTyb3gE/qQGw==
X-CSE-MsgGUID: 2lpt8Xi2SYCAna1YixaZgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="64875340"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="64875340"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 23:30:24 -0700
X-CSE-ConnectionGUID: dUdpESooS/GLZSNpGEz/0Q==
X-CSE-MsgGUID: dQGpmv9ETgmAFGNTOWGd0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="159723285"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa003.fm.intel.com with ESMTP; 08 Jul 2025 23:30:20 -0700
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
	"Tested-by : Yi Lai" <yi1.lai@intel.com>
Cc: iommu@lists.linux.dev,
	security@kernel.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/1] iommu/sva: Invalidate KVA range on kernel TLB flush
Date: Wed,  9 Jul 2025 14:28:00 +0800
Message-ID: <20250709062800.651521-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vmalloc() and vfree() functions manage virtually contiguous, but not
necessarily physically contiguous, kernel memory regions. When vfree()
unmaps such a region, it tears down the associated kernel page table
entries and frees the physical pages.

In the IOMMU Shared Virtual Addressing (SVA) context, the IOMMU hardware
shares and walks the CPU's page tables. Architectures like x86 share
static kernel address mappings across all user page tables, allowing the
IOMMU to access the kernel portion of these tables.

Modern IOMMUs often cache page table entries to optimize walk performance,
even for intermediate page table levels. If kernel page table mappings are
changed (e.g., by vfree()), but the IOMMU's internal caches retain stale
entries, Use-After-Free (UAF) vulnerability condition arises. If these
freed page table pages are reallocated for a different purpose, potentially
by an attacker, the IOMMU could misinterpret the new data as valid page
table entries. This allows the IOMMU to walk into attacker-controlled
memory, leading to arbitrary physical memory DMA access or privilege
escalation.

To mitigate this, introduce a new iommu interface to flush IOMMU caches
and fence pending page table walks when kernel page mappings are updated.
This interface should be invoked from architecture-specific code that
manages combined user and kernel page tables.

Fixes: 26b25a2b98e4 ("iommu: Bind process address spaces to devices")
Cc: stable@vger.kernel.org
Reported-by: Jann Horn <jannh@google.com>
Co-developed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
---
 arch/x86/mm/tlb.c         |  2 ++
 drivers/iommu/iommu-sva.c | 34 +++++++++++++++++++++++++++++++++-
 include/linux/iommu.h     |  4 ++++
 3 files changed, 39 insertions(+), 1 deletion(-)

Change log:
v2:
 - Remove EXPORT_SYMBOL_GPL(iommu_sva_invalidate_kva_range);
 - Replace the mutex with a spinlock to make the interface usable in the
   critical regions.

v1: https://lore.kernel.org/linux-iommu/20250704133056.4023816-1-baolu.lu@linux.intel.com/

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 39f80111e6f1..a41499dfdc3f 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -12,6 +12,7 @@
 #include <linux/task_work.h>
 #include <linux/mmu_notifier.h>
 #include <linux/mmu_context.h>
+#include <linux/iommu.h>
 
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
@@ -1540,6 +1541,7 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 		kernel_tlb_flush_range(info);
 
 	put_flush_tlb_info();
+	iommu_sva_invalidate_kva_range(start, end);
 }
 
 /*
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 1a51cfd82808..fd76aefa5a88 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -10,6 +10,9 @@
 #include "iommu-priv.h"
 
 static DEFINE_MUTEX(iommu_sva_lock);
+static DEFINE_STATIC_KEY_FALSE(iommu_sva_present);
+static LIST_HEAD(iommu_sva_mms);
+static DEFINE_SPINLOCK(iommu_mms_lock);
 static struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
 						   struct mm_struct *mm);
 
@@ -42,6 +45,7 @@ static struct iommu_mm_data *iommu_alloc_mm_data(struct mm_struct *mm, struct de
 		return ERR_PTR(-ENOSPC);
 	}
 	iommu_mm->pasid = pasid;
+	iommu_mm->mm = mm;
 	INIT_LIST_HEAD(&iommu_mm->sva_domains);
 	/*
 	 * Make sure the write to mm->iommu_mm is not reordered in front of
@@ -132,8 +136,15 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 	if (ret)
 		goto out_free_domain;
 	domain->users = 1;
-	list_add(&domain->next, &mm->iommu_mm->sva_domains);
 
+	if (list_empty(&iommu_mm->sva_domains)) {
+		scoped_guard(spinlock_irqsave, &iommu_mms_lock) {
+			if (list_empty(&iommu_sva_mms))
+				static_branch_enable(&iommu_sva_present);
+			list_add(&iommu_mm->mm_list_elm, &iommu_sva_mms);
+		}
+	}
+	list_add(&domain->next, &iommu_mm->sva_domains);
 out:
 	refcount_set(&handle->users, 1);
 	mutex_unlock(&iommu_sva_lock);
@@ -175,6 +186,15 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
 		list_del(&domain->next);
 		iommu_domain_free(domain);
 	}
+
+	if (list_empty(&iommu_mm->sva_domains)) {
+		scoped_guard(spinlock_irqsave, &iommu_mms_lock) {
+			list_del(&iommu_mm->mm_list_elm);
+			if (list_empty(&iommu_sva_mms))
+				static_branch_disable(&iommu_sva_present);
+		}
+	}
+
 	mutex_unlock(&iommu_sva_lock);
 	kfree(handle);
 }
@@ -312,3 +332,15 @@ static struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
 
 	return domain;
 }
+
+void iommu_sva_invalidate_kva_range(unsigned long start, unsigned long end)
+{
+	struct iommu_mm_data *iommu_mm;
+
+	if (!static_branch_unlikely(&iommu_sva_present))
+		return;
+
+	guard(spinlock_irqsave)(&iommu_mms_lock);
+	list_for_each_entry(iommu_mm, &iommu_sva_mms, mm_list_elm)
+		mmu_notifier_arch_invalidate_secondary_tlbs(iommu_mm->mm, start, end);
+}
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 156732807994..31330c12b8ee 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1090,7 +1090,9 @@ struct iommu_sva {
 
 struct iommu_mm_data {
 	u32			pasid;
+	struct mm_struct	*mm;
 	struct list_head	sva_domains;
+	struct list_head	mm_list_elm;
 };
 
 int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode);
@@ -1571,6 +1573,7 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev,
 					struct mm_struct *mm);
 void iommu_sva_unbind_device(struct iommu_sva *handle);
 u32 iommu_sva_get_pasid(struct iommu_sva *handle);
+void iommu_sva_invalidate_kva_range(unsigned long start, unsigned long end);
 #else
 static inline struct iommu_sva *
 iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
@@ -1595,6 +1598,7 @@ static inline u32 mm_get_enqcmd_pasid(struct mm_struct *mm)
 }
 
 static inline void mm_pasid_drop(struct mm_struct *mm) {}
+static inline void iommu_sva_invalidate_kva_range(unsigned long start, unsigned long end) {}
 #endif /* CONFIG_IOMMU_SVA */
 
 #ifdef CONFIG_IOMMU_IOPF
-- 
2.43.0


