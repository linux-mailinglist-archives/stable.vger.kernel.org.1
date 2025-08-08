Return-Path: <stable+bounces-166819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2784B1E196
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 07:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57B0E3B2D67
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 05:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E02C16DC28;
	Fri,  8 Aug 2025 05:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QgZ/bwSu"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C77F3C17;
	Fri,  8 Aug 2025 05:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754630233; cv=none; b=p/4wfH3osNOFORzvk+p/WY3HTidedb8rt9loQq4cU7xOLEtmhOjzhpDsjx7tcCZNjDgZacKEOkcOXp+kzhbX6acIsA9jPQfrY9wtcf1OwpX0a4E85LFJywsJuQXZNmj8l0NCPulvRQLtbkbHrzRaZIzK5hdg9GtlXqrTzsc70z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754630233; c=relaxed/simple;
	bh=OV45XsrkcfFJCl91T0aANLhMqM1x4PJEUmvBK6Hky+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NZsNRdLCcHkW4UMiRGpLZzMrIPEp09Ow7BcuWcQhaiEQs45GnU+bUqDG6bvVAl3QfgTsVZM/vy/WREYoHxI+WWHCG8kaJ7aXUVDTj31wOnNlpPOI5pbE0jwWHD5dev2q8ZcYe64D7YzhDqgL1X4pNFACZ/0siHl7mba5GOKm4+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QgZ/bwSu; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754630231; x=1786166231;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OV45XsrkcfFJCl91T0aANLhMqM1x4PJEUmvBK6Hky+0=;
  b=QgZ/bwSubo82epPYrC570t350Va8ZQwY84wabI1XFOeVwYwPWQin8DCg
   vISa4zajuE6aau28copRimzmaW6QZkf1tTPYYDFBbIGCJSwl2kRZqQqQY
   g3K2jYuCTD0yYYOeIeSooAVjp20FRFFTQ5wE7xHb5e0iHJsj3XVXaqwES
   reyKWvdz3ZIhPwuAPKWQKjifSp3Bu9v5M8iiV+N1LFVac1rf3G45dcfq+
   Xlqj5BuAqKtuyCVHMVQqN1dRbUvxE2KmetWlIvDLEjjL0s7VGhl+yZNmK
   OJqz1DwgmB93ZXhOUkPBbhA3CLdnk6sYXRT1AGxvxqK+hGheN3MrDI8jE
   A==;
X-CSE-ConnectionGUID: ZEPfypKwSjK2jwGNPRFxNg==
X-CSE-MsgGUID: mvcWL1iXSoirikU9f59BJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="57054750"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="57054750"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 22:17:11 -0700
X-CSE-ConnectionGUID: m9u5htjUSgamqgHN3ylsbg==
X-CSE-MsgGUID: 84kYWOcgQYSPTUbd0j0Cig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="169453259"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 22:17:06 -0700
Message-ID: <b6defa2a-164e-4c2f-ac55-fef5b4a9ba0f@linux.intel.com>
Date: Fri, 8 Aug 2025 13:15:12 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
To: Dave Hansen <dave.hansen@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Jann Horn <jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Alistair Popple <apopple@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
 iommu@lists.linux.dev, security@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250806052505.3113108-1-baolu.lu@linux.intel.com>
 <d646d434-f680-47a3-b6b9-26f4538c1209@intel.com>
 <20250806155223.GV184255@nvidia.com>
 <d02cb97a-7cea-4ad3-82b3-89754c5278ad@intel.com>
 <20250806160904.GX184255@nvidia.com>
 <62d21545-9e75-41e3-89a3-f21dda15bf16@intel.com>
 <4a8df0e8-bd5a-44e4-acce-46ba75594846@linux.intel.com>
 <4ce79c80-1fc8-4684-920a-c8d82c4c3dc8@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <4ce79c80-1fc8-4684-920a-c8d82c4c3dc8@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/7/25 23:31, Dave Hansen wrote:
>> +void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
>> +{
>> +    struct page *page = virt_to_page(pte);
>> +
>> +    guard(spinlock)(&kernel_pte_work.lock);
>> +    list_add(&page->lru, &kernel_pte_work.list);
>> +    schedule_work(&kernel_pte_work.work);
>> +}
>> diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
>> index 3c8ec3bfea44..716ebab67636 100644
>> --- a/include/asm-generic/pgalloc.h
>> +++ b/include/asm-generic/pgalloc.h
>> @@ -46,6 +46,7 @@ static inline pte_t
>> *pte_alloc_one_kernel_noprof(struct mm_struct *mm)
>>   #define pte_alloc_one_kernel(...)
>> alloc_hooks(pte_alloc_one_kernel_noprof(__VA_ARGS__))
>>   #endif
>>
>> +#ifndef __HAVE_ARCH_PTE_FREE_KERNEL
>>   /**
>>    * pte_free_kernel - free PTE-level kernel page table memory
>>    * @mm: the mm_struct of the current context
>> @@ -55,6 +56,7 @@ static inline void pte_free_kernel(struct mm_struct
>> *mm, pte_t *pte)
>>   {
>>       pagetable_dtor_free(virt_to_ptdesc(pte));
>>   }
>> +#endif
>>
>>   /**
>>    * __pte_alloc_one - allocate memory for a PTE-level user page table
> I'd much rather the arch-generic code looked like this:
> 
> #ifdef CONFIG_ASYNC_PGTABLE_FREE
> // code and struct here, or dump them over in some
> // other file and do this in a header
> #else
> static void pte_free_kernel_async(struct page *page) {}
> #endif
> 
> void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
> {
>      struct page *page = virt_to_page(pte);
> 
>      if (IS_DEFINED(CONFIG_ASYNC_PGTABLE_FREE)) {
> 	pte_free_kernel_async(page);
>      else
> 	pagetable_dtor_free(page_ptdesc(page));
> }
> 
> Then in Kconfig, you end up with something like:
> 
> config ASYNC_PGTABLE_FREE
> 	def_bool y
> 	depends on INTEL_IOMMU_WHATEVER
> 
> That very much tells much more of the whole story in code. It also gives
> the x86 folks that compile out the IOMMU the exact same code as the
> arch-generic folks. It_also_ makes it dirt simple and obvious for the
> x86 folks to optimize out the async behavior if they don't like it in
> the future by replacing the compile-time IOMMU check with a runtime one.
> 
> Also, if another crazy IOMMU implementation comes along that happens to
> do what the x86 IOMMUs do, then they have a single Kconfig switch to
> flip. If they follow what this patch tries to do, they'll start by
> copying and pasting the x86 implementation.

I'll do it like this.  Does that look good to you?

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 70d29b14d851..6f1113e024fa 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -160,6 +160,7 @@ config IOMMU_DMA
  # Shared Virtual Addressing
  config IOMMU_SVA
  	select IOMMU_MM_DATA
+	select ASYNC_PGTABLE_FREE if X86
  	bool

  config IOMMU_IOPF
diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 3c8ec3bfea44..dbddacdca2ce 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -46,6 +46,19 @@ static inline pte_t 
*pte_alloc_one_kernel_noprof(struct mm_struct *mm)
  #define pte_alloc_one_kernel(...) 
alloc_hooks(pte_alloc_one_kernel_noprof(__VA_ARGS__))
  #endif

+#ifdef CONFIG_ASYNC_PGTABLE_FREE
+struct pgtable_free_work {
+	struct list_head list;
+	spinlock_t lock;
+	struct work_struct work;
+};
+extern struct pgtable_free_work kernel_pte_work;
+
+void pte_free_kernel_async(struct ptdesc *ptdesc);
+#else
+static inline void pte_free_kernel_async(struct ptdesc *ptdesc) {}
+#endif
+
  /**
   * pte_free_kernel - free PTE-level kernel page table memory
   * @mm: the mm_struct of the current context
@@ -53,7 +66,12 @@ static inline pte_t 
*pte_alloc_one_kernel_noprof(struct mm_struct *mm)
   */
  static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
  {
-	pagetable_dtor_free(virt_to_ptdesc(pte));
+	struct ptdesc *ptdesc = virt_to_ptdesc(pte);
+
+	if (IS_ENABLED(CONFIG_ASYNC_PGTABLE_FREE))
+		pte_free_kernel_async(ptdesc);
+	else
+		pagetable_dtor_free(ptdesc);
  }

  /**
diff --git a/mm/Kconfig b/mm/Kconfig
index e443fe8cd6cf..528550cfa7fe 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1346,6 +1346,13 @@ config LOCK_MM_AND_FIND_VMA
  config IOMMU_MM_DATA
  	bool

+config ASYNC_PGTABLE_FREE
+	bool "Asynchronous kernel page table freeing"
+	help
+	  Perform kernel page table freeing asynchronously. This is required
+	  for systems with IOMMU Shared Virtual Address (SVA) to flush IOTLB
+	  paging structure caches.
+
  config EXECMEM
  	bool

diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 567e2d084071..6639ee6641d4 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -13,6 +13,7 @@
  #include <linux/swap.h>
  #include <linux/swapops.h>
  #include <linux/mm_inline.h>
+#include <linux/iommu.h>
  #include <asm/pgalloc.h>
  #include <asm/tlb.h>

@@ -406,3 +407,32 @@ pte_t *__pte_offset_map_lock(struct mm_struct *mm, 
pmd_t *pmd,
  	pte_unmap_unlock(pte, ptl);
  	goto again;
  }
+
+#ifdef CONFIG_ASYNC_PGTABLE_FREE
+static void kernel_pte_work_func(struct work_struct *work);
+struct pgtable_free_work kernel_pte_work = {
+	.list = LIST_HEAD_INIT(kernel_pte_work.list),
+	.lock = __SPIN_LOCK_UNLOCKED(kernel_pte_work.lock),
+	.work = __WORK_INITIALIZER(kernel_pte_work.work, kernel_pte_work_func),
+};
+
+static void kernel_pte_work_func(struct work_struct *work)
+{
+	struct ptdesc *ptdesc, *next;
+
+	iommu_sva_invalidate_kva_range(0, TLB_FLUSH_ALL);
+
+	guard(spinlock)(&kernel_pte_work.lock);
+	list_for_each_entry_safe(ptdesc, next, &kernel_pte_work.list, pt_list) {
+		list_del_init(&ptdesc->pt_list);
+		pagetable_dtor_free(ptdesc);
+	}
+}
+
+void pte_free_kernel_async(struct ptdesc *ptdesc)
+{
+	guard(spinlock)(&kernel_pte_work.lock);
+	list_add(&ptdesc->pt_list, &kernel_pte_work.list);
+	schedule_work(&kernel_pte_work.work);
+}
+#endif
-- 
2.43.0


