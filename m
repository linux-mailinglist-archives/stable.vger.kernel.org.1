Return-Path: <stable+bounces-176548-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1182FB3930B
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 07:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B11951741D8
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 05:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD001A3172;
	Thu, 28 Aug 2025 05:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dh6i+9SQ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2D41CAB3;
	Thu, 28 Aug 2025 05:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756359237; cv=none; b=cErq28hE6BafX8EfaF2zQMpZBp2mvc4Rgg4m0yyUZg9jb1lkn9VzBeg6m7oo8GgPXTemqUioeiYYjyakesRoIBMyIrKIdBEq/ocVetag1NeSSG+2P8IM7Akxgkl/Nt3QYHjoHHYuKni6Ax8JdGICbXjc+gY+NMQwauL2asxnABg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756359237; c=relaxed/simple;
	bh=GLUEu5zgZccd5toa70GzmnH9bIUm1D8cTWqulIwqRgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s7BFDDYIlPn9DCkD80jy5cpU/0uzCxr+YxpGK67sgTjVxUVsTItWgGyl8yNtt18BQ12wHeUbDQO/UmH4Xu5G8wb7lS183FQ35XYEWPJMZCgDF19ee3iATNEwU2WEIiYhM/v/gtQczQVZJT8+n+e6gLwqsqdBZ2+mEPFeHaubZRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dh6i+9SQ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756359236; x=1787895236;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GLUEu5zgZccd5toa70GzmnH9bIUm1D8cTWqulIwqRgM=;
  b=dh6i+9SQmHzBRbl7r57F2fgVUoUJhoDqJ1KgDtOfNhUOWd+z3zLhc8PA
   lvDn1b4S0WJwYDOfvElFCa9/KDTmIhr97DZoqHgbXrtmlE7Vskkb2s+KA
   cd1wSs8tdzvt4kSJtEmHCX6kLLj3BhddGcB3b9ei2Vj6vZUutASpwnYkT
   yoM9CVWQLbA0Bo0Cmz4f86oL6/XsBdADSw6/Y8/l3Ea0Z+1r6LJawNrSi
   3PBniUARfpINOtcn5N0C8UKGmE0J2Bvb3AKJy17+i4ep0r6jtUOze79Gy
   U3F6dXHjy3WkyrBKckfZy/UVw6YjGijTqIXT6Pm0c3oZkssWZTCZWM4nx
   g==;
X-CSE-ConnectionGUID: SecOUBuMRoayLKWK7Ef5zw==
X-CSE-MsgGUID: ViD3JLZyQG+K+SVKu3g4tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="68891340"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="68891340"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 22:33:55 -0700
X-CSE-ConnectionGUID: azKq+oyHQn6Wuxd+i4py/Q==
X-CSE-MsgGUID: 4AQXQLTzQ3KnR7I7eUP1FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="175315606"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 22:33:50 -0700
Message-ID: <ee44764b-b9fe-431d-8b84-08fce6b5df75@linux.intel.com>
Date: Thu, 28 Aug 2025 13:31:20 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
To: Dave Hansen <dave.hansen@intel.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Jann Horn <jannh@google.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Alistair Popple <apopple@nvidia.com>,
 Peter Zijlstra <peterz@infradead.org>, Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, "Lai, Yi1" <yi1.lai@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "security@kernel.org" <security@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, vishal.moola@gmail.com,
 Matthew Wilcox <willy@infradead.org>
References: <20250806052505.3113108-1-baolu.lu@linux.intel.com>
 <d646d434-f680-47a3-b6b9-26f4538c1209@intel.com>
 <20250806155223.GV184255@nvidia.com>
 <d02cb97a-7cea-4ad3-82b3-89754c5278ad@intel.com>
 <20250806160904.GX184255@nvidia.com>
 <62d21545-9e75-41e3-89a3-f21dda15bf16@intel.com>
 <4a8df0e8-bd5a-44e4-acce-46ba75594846@linux.intel.com>
 <20250807195154.GO184255@nvidia.com>
 <BN9PR11MB52762A47B347C99F0C0E4C288C2FA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87bfc80e-258e-4193-a56c-3096608aec30@linux.intel.com>
 <BN9PR11MB52766165393F7DD8209DA45A8C32A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <e321d374-38a7-4f60-b991-58458a2761b9@linux.intel.com>
 <9a649ff4-55fe-478a-bfd7-f3287534499a@intel.com>
 <b0f613ce-7aad-4b1d-b6a1-4acc1d6c489e@linux.intel.com>
 <dde6d861-daa3-49ed-ad4f-ff9dcaf1f2b8@linux.intel.com>
 <b57d7b97-8110-47c5-9c7a-516b7b535ce9@intel.com>
 <c69950ee-660b-4f51-9277-522470d0ce5d@linux.intel.com>
 <400cf9ab-de3f-4e8a-ab0a-4ac68c534bb8@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <400cf9ab-de3f-4e8a-ab0a-4ac68c534bb8@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/28/25 07:31, Dave Hansen wrote:
> On 8/27/25 03:58, Baolu Lu wrote:
>> Following the insights above, I wrote the code as follows. Does it look
>> good?
> 
> I'd really prefer an actual diff that compiles. Because:
> 
>> #ifdef CONFIG_ASYNC_PGTABLE_FREE
>> /* a 'struct ptdesc' that needs its destructor run */
>> #define ASYNC_PGTABLE_FREE_DTOR    BIT(NR_PAGEFLAGS)
> 
> This doesn't work, does it? Don't you need to _allocate_ a new bit?
> Wouldn't this die a hilariously horrible death if NR_PAGEFLAGS==64? ;)
> 
> Also, I'm pretty sure you can't just go setting random bits in this
> because it aliases with page flags.
> 
> ...
>> static void kernel_pgtable_work_func(struct work_struct *work)
>> {
>>      struct ptdesc *ptdesc, *next;
>>      LIST_HEAD(page_list);
>>
>>      spin_lock(&kernel_pgtable_work.lock);
>>      list_splice_tail_init(&kernel_pgtable_work.list, &page_list);
>>      spin_unlock(&kernel_pgtable_work.lock);
>>
>>      iommu_sva_invalidate_kva_range(0, TLB_FLUSH_ALL);
>>
>>      list_for_each_entry_safe(ptdesc, next, &page_list, pt_list) {
>>          list_del(&ptdesc->pt_list);
>>          if (ptdesc->__page_flags & ASYNC_PGTABLE_FREE_DTOR)
>>              pagetable_dtor_free(ptdesc);
>>          else
>>              __free_page(ptdesc_page(ptdesc));
>>      }
>> }
> What I had in mind was that kernel_pgtable_work_func() only does:
> 
> 	__free_pages(page, compound_order(page));
> 
> All of the things that queue gunk to the list do the legwork of making
> the work_func() simple. This also guides them toward proving a single,
> compound page because _they_ have to do the work if they don't want
> something simple.
> 
>> void kernel_pgtable_async_free_dtor(struct ptdesc *ptdesc)
>> {
>>      spin_lock(&kernel_pgtable_work.lock);
>>      ptdesc->__page_flags |= ASYNC_PGTABLE_FREE_DTOR;
>>      list_add(&ptdesc->pt_list, &kernel_pgtable_work.list);
>>      spin_unlock(&kernel_pgtable_work.lock);
>>
>>      schedule_work(&kernel_pgtable_work.work);
>> }
>>
>> void kernel_pgtable_async_free_page_list(struct list_head *list)
>> {
>>      spin_lock(&kernel_pgtable_work.lock);
>>      list_splice_tail(list, &kernel_pgtable_work.list);
>>      spin_unlock(&kernel_pgtable_work.lock);
>>
>>      schedule_work(&kernel_pgtable_work.work);
>> }
>>
>> void kernel_pgtable_async_free_page(struct page *page)
>> {
>>      spin_lock(&kernel_pgtable_work.lock);
>>      list_add(&page_ptdesc(page)->pt_list, &kernel_pgtable_work.list);
>>      spin_unlock(&kernel_pgtable_work.lock);
>>
>>      schedule_work(&kernel_pgtable_work.work);
>> }
> 
> I wouldn't have three of these, I'd have _one_. If you want to free a
> bunch of pages, then just call it a bunch of times. This is not
> performance critical.
> 
> Oh, and the ptdesc flag shouldn't be for "I need to be asynchronously
> freed". All kernel PTE pages should ideally set it at allocation so you
> can do this:
> 
> static inline void pagetable_free(struct ptdesc *pt)
> {
>          struct page *page = ptdesc_page(pt);
> 
> 	if (ptdesc->some_field | PTDESC_KERNEL)
> 		kernel_pgtable_async_free_page(page);
> 	else
> 	        __free_pages(page, compound_order(page));
> }
> 
> The folks that, today, call pagetable_dtor_free() don't have to do
> _anything_ at free time. They just set the PTDESC_KERNEL bit at
> allocation time.
> 
> See how that code reads? "If you have a kernel page table page, you must
> asynchronously free it." That's actually meaningful.
> 
> I'm pretty sure the lower 24 bits of ptdesc->__page_type are free. So
> I'd just do this:
> 
> #define PTDESC_TYPE_KERNEL BIT(0)
> 
> Then, something needs to set:
> 
> 	ptdesc->__page_type |= PTDESC_TYPE_KERNEL;
> 
> That could happen as late as here:
> 
> static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
> {
> 	struct ptdesc *ptdesc = virt_to_ptdesc(pte);
> 
> 	// here 	
> 
>          pagetable_dtor_free(ptdesc);
> }
> 
> Or as early as ptdesc allocation/constructor time. Then you check for
> PTDESC_TYPE_KERNEL in pagetable_free().

Very appreciated for your review comments. I changed the patch
accordingly like this:

[PATCH 1/2] mm: Conditionally defer freeing of kernel page table pages

On x86 and other architectures that map the kernel's virtual address space
into the upper portion of every process's page table, the IOMMU's paging
structure caches can become stale when the CPU page table is shared with
IOMMU in the Shared Virtual Address (SVA) context. This occurs when a page
used for the kernel's page tables is freed and reused without the IOMMU
being notified.

While the IOMMU driver is notified of changes to user virtual address
mappings, there is no similar notification mechanism for kernel page
table changes. This can lead to data corruption or system instability
when Shared Virtual Address (SVA) is enabled, as the IOMMU's internal
caches may retain stale entries for kernel virtual addresses.

This introduces a conditional asynchronous mechanism, enabled by
CONFIG_ASYNC_PGTABLE_FREE. When enabled, this mechanism defers the freeing
of pages that are used as page tables for kernel address mappings. These
pages are now queued to a work struct instead of being freed immediately.

This deferred freeing provides a safe context for a future patch to add
an IOMMU-specific callback, which might be expensive on large-scale
systems. This ensures the necessary IOMMU cache invalidation is performed
before the page is finally returned to the page allocator outside of any
critical, non-sleepable path.

In the current kernel, some page table pages are allocated with an
associated struct ptdesc, while others are not. Those without a ptdesc are
freed using free_pages() and its variants, which bypasses the destructor
that pagetable_dtor_free() would run. While the long-term plan is to
convert all page table pages to use struct ptdesc, this uses a temporary
flag within ptdesc to indicate whether a page needs a destructor,
considering that this aims to fix a potential security issue in IOMMU SVA.
The flag and its associated logic can be removed once the conversion is
complete.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
  arch/x86/mm/init_64.c         |  9 ++++++-
  arch/x86/mm/pat/set_memory.c  |  5 +++-
  arch/x86/mm/pgtable.c         |  9 ++++++-
  include/asm-generic/pgalloc.h | 15 +++++++++++-
  include/linux/mm_types.h      |  8 ++++++-
  mm/Kconfig                    |  3 +++
  mm/pgtable-generic.c          | 45 +++++++++++++++++++++++++++++++++++
  7 files changed, 89 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 76e33bd7c556..8a050cfa0f8d 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1013,7 +1013,14 @@ static void __meminit free_pagetable(struct page 
*page, int order)
  		free_reserved_pages(page, nr_pages);
  #endif
  	} else {
-		free_pages((unsigned long)page_address(page), order);
+		/*
+		 * 'order == 0' means a kernel page table page, otherwise it's
+		 * data pages pointed by a huge page leaf pte.
+		 */
+		if (IS_ENABLED(CONFIG_ASYNC_PGTABLE_FREE) && !order)
+			kernel_pgtable_async_free(page_ptdesc(page));
+		else
+			free_pages((unsigned long)page_address(page), order);
  	}
  }

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 8834c76f91c9..9a552e93d1f1 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -438,7 +438,10 @@ static void cpa_collapse_large_pages(struct 
cpa_data *cpa)

  	list_for_each_entry_safe(ptdesc, tmp, &pgtables, pt_list) {
  		list_del(&ptdesc->pt_list);
-		__free_page(ptdesc_page(ptdesc));
+		if (IS_ENABLED(CONFIG_ASYNC_PGTABLE_FREE))
+			kernel_pgtable_async_free(ptdesc);
+		else
+			__free_page(ptdesc_page(ptdesc));
  	}
  }

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index ddf248c3ee7d..6f400cff2ad4 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -757,7 +757,14 @@ int pud_free_pmd_page(pud_t *pud, unsigned long addr)

  	free_page((unsigned long)pmd_sv);

-	pmd_free(&init_mm, pmd);
+	if (IS_ENABLED(CONFIG_ASYNC_PGTABLE_FREE)) {
+		struct ptdesc *ptdesc = virt_to_ptdesc(pmd);
+
+		ptdesc->__page_type |= PTDESC_TYPE_KERNEL;
+		kernel_pgtable_async_free(ptdesc);
+	} else {
+		pmd_free(&init_mm, pmd);
+	}

  	return 1;
  }
diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 3c8ec3bfea44..d92dc5289ef4 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -46,6 +46,12 @@ static inline pte_t 
*pte_alloc_one_kernel_noprof(struct mm_struct *mm)
  #define pte_alloc_one_kernel(...) 
alloc_hooks(pte_alloc_one_kernel_noprof(__VA_ARGS__))
  #endif

+#ifdef CONFIG_ASYNC_PGTABLE_FREE
+void kernel_pgtable_async_free(struct ptdesc *ptdesc);
+#else
+static inline void kernel_pgtable_async_free(struct ptdesc *ptdesc) {}
+#endif
+
  /**
   * pte_free_kernel - free PTE-level kernel page table memory
   * @mm: the mm_struct of the current context
@@ -53,7 +59,14 @@ static inline pte_t 
*pte_alloc_one_kernel_noprof(struct mm_struct *mm)
   */
  static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
  {
-	pagetable_dtor_free(virt_to_ptdesc(pte));
+	struct ptdesc *ptdesc = virt_to_ptdesc(pte);
+
+	ptdesc->__page_type |= PTDESC_TYPE_KERNEL;
+
+	if (IS_ENABLED(CONFIG_ASYNC_PGTABLE_FREE))
+		kernel_pgtable_async_free(ptdesc);
+	else
+		pagetable_dtor_free(ptdesc);
  }

  /**
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 08bc2442db93..f74c6b167e6a 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -539,7 +539,7 @@ FOLIO_MATCH(compound_head, _head_3);
   * @pt_share_count:   Used for HugeTLB PMD page table share count.
   * @_pt_pad_2:        Padding to ensure proper alignment.
   * @ptl:              Lock for the page table.
- * @__page_type:      Same as page->page_type. Unused for page tables.
+ * @__page_type:      Same as page->page_type.
   * @__page_refcount:  Same as page refcount.
   * @pt_memcg_data:    Memcg data. Tracked for page tables here.
   *
@@ -637,6 +637,12 @@ static inline void ptdesc_pmd_pts_init(struct 
ptdesc *ptdesc)
  }
  #endif

+/*
+ * Used by ptdesc::__page_type to indicate a page for kernel address page
+ * table mapping.
+ */
+#define PTDESC_TYPE_KERNEL	BIT(0)
+
  /*
   * Used for sizing the vmemmap region on some architectures
   */
diff --git a/mm/Kconfig b/mm/Kconfig
index e443fe8cd6cf..369f3259e6da 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1346,6 +1346,9 @@ config LOCK_MM_AND_FIND_VMA
  config IOMMU_MM_DATA
  	bool

+config ASYNC_PGTABLE_FREE
+	bool
+
  config EXECMEM
  	bool

diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 567e2d084071..024d42480c51 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -406,3 +406,48 @@ pte_t *__pte_offset_map_lock(struct mm_struct *mm, 
pmd_t *pmd,
  	pte_unmap_unlock(pte, ptl);
  	goto again;
  }
+
+#ifdef CONFIG_ASYNC_PGTABLE_FREE
+static void kernel_pgtable_work_func(struct work_struct *work);
+
+static struct {
+	struct list_head list;
+	/* protect above ptdesc lists */
+	spinlock_t lock;
+	struct work_struct work;
+} kernel_pgtable_work = {
+	.list = LIST_HEAD_INIT(kernel_pgtable_work.list),
+	.lock = __SPIN_LOCK_UNLOCKED(kernel_pgtable_work.lock),
+	.work = __WORK_INITIALIZER(kernel_pgtable_work.work, 
kernel_pgtable_work_func),
+};
+
+static void kernel_pgtable_work_func(struct work_struct *work)
+{
+	struct ptdesc *ptdesc, *next;
+	LIST_HEAD(page_list);
+
+	spin_lock(&kernel_pgtable_work.lock);
+	list_splice_tail_init(&kernel_pgtable_work.list, &page_list);
+	spin_unlock(&kernel_pgtable_work.lock);
+
+	list_for_each_entry_safe(ptdesc, next, &page_list, pt_list) {
+		list_del(&ptdesc->pt_list);
+		if (ptdesc->__page_type & PTDESC_TYPE_KERNEL) {
+			pagetable_dtor_free(ptdesc);
+		} else {
+			struct page *page = ptdesc_page(ptdesc);
+
+			__free_pages(page, compound_order(page));
+		}
+	}
+}
+
+void kernel_pgtable_async_free(struct ptdesc *ptdesc)
+{
+	spin_lock(&kernel_pgtable_work.lock);
+	list_add(&ptdesc->pt_list, &kernel_pgtable_work.list);
+	spin_unlock(&kernel_pgtable_work.lock);
+
+	schedule_work(&kernel_pgtable_work.work);
+}
+#endif
-- 
2.43.0

Thanks,
baolu

