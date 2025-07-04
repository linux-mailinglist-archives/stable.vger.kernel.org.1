Return-Path: <stable+bounces-160198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F02BDAF9442
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 15:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3AFF7B16AD
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 13:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777652FC000;
	Fri,  4 Jul 2025 13:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hKb2A09a"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5938C2BF3CA;
	Fri,  4 Jul 2025 13:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751636007; cv=none; b=Nurqy/pW1eqRNf+GQY3Z+xLz/+lw9jHLZL0huAN+mJKwu9iIg871+7z3wd8XsRh7dTFEFfZov/Ko8GQWXOQv+m9/fzPxjXWellJxgLTLke/eKXv1KfuzambFJLJztDv+1ucMrZ3+xeAEdO4KvASDBwfh9OXSYc6E/JDtzQ4WqAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751636007; c=relaxed/simple;
	bh=z42LDkuolS9YgXumBsS3MC4BEk9xN8qz+yiSbmoxW6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G5qu1VZ0lhSLwA5WMOqikWLGQnT1uqo4X00usHmFZfnrII8qgh9TT4EeWzJYcmsKYr+idzMY84/diYUalI1a6XH3o80LswYq/XSS+dk+Xxl7x+4WrqoBpjPuW1mDFe9A8I82dt+nqiC6cVkbXf3Dg3S0XN5EDipXmT2UFLrIaCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hKb2A09a; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751636004; x=1783172004;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=z42LDkuolS9YgXumBsS3MC4BEk9xN8qz+yiSbmoxW6o=;
  b=hKb2A09a2WuV/VKTinHiada7s4Dn7VIsjROhpOSk92Cq/rk1DJGEzgzM
   X/lu6Sh6INqnLalN8QWK4ajte+MRTEn9L5fzJGulM+j2OGyGq3PIcwwTX
   g9sRA+FOsuJQ+D4GNYXhEIkV83Wh0Ll3lOwAhG74aCyew+js+X4jIYdXR
   DHqNqj3ZTT8gehNpUGjfY207Pajtn4+upDaipX44B1c2m/1wqUCOTAdAv
   FNGnKWgTEzXLC+zQID0/LQI3Vvb2PM9byTWwY8GuvN/QSe6D/q957WWzz
   lYVuTHsdIv1Ha3WWErvidIvF3CjYlyi1mtOomHKnk71TETQLrBOAOAgX3
   A==;
X-CSE-ConnectionGUID: sEqPZKkrQI2JsKB3agHqGQ==
X-CSE-MsgGUID: 8BA8hnquTL2HEI78Wa01HQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11484"; a="57745467"
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; 
   d="scan'208";a="57745467"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 06:33:23 -0700
X-CSE-ConnectionGUID: rvD1co8HREGar8mrGv+E+A==
X-CSE-MsgGUID: flIxni0MRcifNrAf8V4YHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; 
   d="scan'208";a="155407459"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa010.fm.intel.com with ESMTP; 04 Jul 2025 06:33:19 -0700
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
	Andy Lutomirski <luto@kernel.org>
Cc: iommu@lists.linux.dev,
	security@kernel.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] iommu/sva: Invalidate KVA range on kernel TLB flush
Date: Fri,  4 Jul 2025 21:30:56 +0800
Message-ID: <20250704133056.4023816-1-baolu.lu@linux.intel.com>
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
Co-developed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 arch/x86/mm/tlb.c         |  2 ++
 drivers/iommu/iommu-sva.c | 32 +++++++++++++++++++++++++++++++-
 include/linux/iommu.h     |  4 ++++
 3 files changed, 37 insertions(+), 1 deletion(-)

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
index 1a51cfd82808..154384eab8a3 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -10,6 +10,8 @@
 #include "iommu-priv.h"
 
 static DEFINE_MUTEX(iommu_sva_lock);
+static DEFINE_STATIC_KEY_FALSE(iommu_sva_present);
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
+			static_branch_enable(&iommu_sva_present);
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
+			static_branch_disable(&iommu_sva_present);
+	}
+
 	mutex_unlock(&iommu_sva_lock);
 	kfree(handle);
 }
@@ -312,3 +327,18 @@ static struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
 
 	return domain;
 }
+
+void iommu_sva_invalidate_kva_range(unsigned long start, unsigned long end)
+{
+	struct iommu_mm_data *iommu_mm;
+
+	might_sleep();
+
+	if (!static_branch_unlikely(&iommu_sva_present))
+		return;
+
+	guard(mutex)(&iommu_sva_lock);
+	list_for_each_entry(iommu_mm, &iommu_sva_mms, mm_list_elm)
+		mmu_notifier_arch_invalidate_secondary_tlbs(iommu_mm->mm, start, end);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_invalidate_kva_range);
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


