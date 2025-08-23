Return-Path: <stable+bounces-172545-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52206B326A3
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 05:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ED4D5E3B3E
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 03:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00626218EA8;
	Sat, 23 Aug 2025 03:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CDOv36vf"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C442200132;
	Sat, 23 Aug 2025 03:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755919617; cv=none; b=t4lDY829Jkf66DSiVwb30cUfznUn92uhwIDmc0c2pphPCIm7h7BgxaQpYW2VIm192qI+z4qR1hcSygXviL5Db+C4Otiug+btxarlGEqdZO/xc+V0Slba20BlEfCafGk/Riq0FzANbRneg5lcdiRn+rRxxFFvt1KyLSwA+Jo4ElI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755919617; c=relaxed/simple;
	bh=mqnbMg0MWIDcmVD8c9mCyu/gfRSG6bU28qGSZAIcbaQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lBJx4YioSmOreK4buxNsPszfyj7YlxxZF0Mvu9rUueGHEx8K4L0IoSWjl4BLzhx8rTJ7J2bMV5w7tcn9YTGnoRicwivPx1k/RdckNYGhzIuTkdCLn+DnJxE3AWOrtxpwTbeu15poFaYRrKXX03uAzywQk/yhWMr/8Eimnl1I3VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CDOv36vf; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755919616; x=1787455616;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mqnbMg0MWIDcmVD8c9mCyu/gfRSG6bU28qGSZAIcbaQ=;
  b=CDOv36vfAWeniCx4KLAJjOPQouVGhBV3VrYXhGEpAlxbOo8S9Y+aGTUZ
   n38usaua2Fz7SAZo3IzJNNxu24w06GK6DZ7gUBZYNSjwzUaqjq+47JokB
   ZW3Gj6ker81vaDo/VpL6cEfZQGVTA2rzLNlE4KySMh57Tj91iylckkEfp
   qWxdN8wfOC58AHK4dKODuNtIOY/vhfaJhBWSQiU6MwnNJZKqhHUtg1Xna
   aVWFu4xqXKpXiT8db+YcJgRkh7mlPQxq/Px3s+sWDp56RO4MGUJYw2Sly
   nTUvlYz2mff6wMswWAOq9hJuuPIz9IK4rZRmjfzKLjPFKxNePJ9z6BtcT
   w==;
X-CSE-ConnectionGUID: jQ2XRgKMSvysguBXQvGmDw==
X-CSE-MsgGUID: 4c2tp3HYTvGu2fbNrCcwYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="61868249"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61868249"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 20:26:55 -0700
X-CSE-ConnectionGUID: 4QTbX6BRQHOADo2sDsVERA==
X-CSE-MsgGUID: NLOJDnkoR4Scj5FcDuyuOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="168752473"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.239.20]) ([10.124.239.20])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 20:26:51 -0700
Message-ID: <e321d374-38a7-4f60-b991-58458a2761b9@linux.intel.com>
Date: Sat, 23 Aug 2025 11:26:47 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "Hansen, Dave" <dave.hansen@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Jann Horn <jannh@google.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Alistair Popple <apopple@nvidia.com>,
 Peter Zijlstra <peterz@infradead.org>, Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, "Lai, Yi1" <yi1.lai@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "security@kernel.org" <security@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
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
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52766165393F7DD8209DA45A8C32A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/21/2025 3:05 PM, Tian, Kevin wrote:
>> From: Baolu Lu<baolu.lu@linux.intel.com>
>> Sent: Monday, August 18, 2025 2:22 PM
>>
>> On 8/8/25 10:57, Tian, Kevin wrote:
>>>> From: Jason Gunthorpe<jgg@nvidia.com>
>>>> Sent: Friday, August 8, 2025 3:52 AM
>>>>
>>>> On Thu, Aug 07, 2025 at 10:40:39PM +0800, Baolu Lu wrote:
>>>>> +static void kernel_pte_work_func(struct work_struct *work)
>>>>> +{
>>>>> +	struct page *page, *next;
>>>>> +
>>>>> +	iommu_sva_invalidate_kva_range(0, TLB_FLUSH_ALL);
>>>>> +
>>>>> +	guard(spinlock)(&kernel_pte_work.lock);
>>>>> +	list_for_each_entry_safe(page, next, &kernel_pte_work.list, lru) {
>>>>> +		list_del_init(&page->lru);
>>>> Please don't add new usages of lru, we are trying to get rid of this. 🙁
>>>>
>>>> I think the memory should be struct ptdesc, use that..
>>>>
>>> btw with this change we should also defer free of the pmd page:
>>>
>>> pud_free_pmd_page()
>>> 	...
>>> 	for (i = 0; i < PTRS_PER_PMD; i++) {
>>> 		if (!pmd_none(pmd_sv[i])) {
>>> 			pte = (pte_t *)pmd_page_vaddr(pmd_sv[i]);
>>> 			pte_free_kernel(&init_mm, pte);
>>> 		}
>>> 	}
>>>
>>> 	free_page((unsigned long)pmd_sv);
>>>
>>> Otherwise the risk still exists if the pmd page is repurposed before the
>>> pte work is scheduled.
>>
>> My understanding is that you were talking about pmd_free(), correct? It
> yes
> 
>> appears that both pmd_free() and pte_free_kernel() call
>> pagetable_dtor_free(). If so, how about the following change?
>>
>> diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
>> index dbddacdca2ce..04f6b5bc212c 100644
>> --- a/include/asm-generic/pgalloc.h
>> +++ b/include/asm-generic/pgalloc.h
>> @@ -172,10 +172,8 @@ static inline pmd_t *pmd_alloc_one_noprof(struct
>> mm_struct *mm, unsigned long ad
>>    #ifndef __HAVE_ARCH_PMD_FREE
>>    static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
>>    {
>> -       struct ptdesc *ptdesc = virt_to_ptdesc(pmd);
>> -
>>           BUG_ON((unsigned long)pmd & (PAGE_SIZE-1));
>> -       pagetable_dtor_free(ptdesc);
>> +       pte_free_kernel(mm, (pte_t *)pmd);
>>    }
> better to rename pte_free_kernel_async() to pagetable_free_kernel_async()
> and call it directly here like you did in pte_free_kernel(). otherwise it's
> a bit weird to call a pte helper for pmd.
> 
> accordingly do we need a new helper pmd_free_kernel()? Now there is
> no restriction that pmd_free() can only be called on kernel entries. e.g.
> mop_up_one_pmd() (only in PAE and KPTI), destroy_args() if
> CONFIG_DEBUG_VM_PGTABLE, etc.
> 
>>> another observation - pte_free_kernel is not used in remove_pagetable ()
>>> and __change_page_attr(). Is it straightforward to put it in those paths
>>> or do we need duplicate some deferring logic there?
>>>
>> In both of these cases, pages in an array or list require deferred
>> freeing. I don't believe the previous approach, which calls
>> pagetable_dtor_free(), will still work here. Perhaps a separate list is
> this is the part which I don't quite understand. Is there guarantee that
> page tables removed in those path are not allocated with any
> pagetable_ctor helpers? Otherwise some state might be broken w/o
> proper pagetable_dtor().
> 
> Knowing little here, so likely I missed some basic context.
> 
>> needed? What about something like the following?
>>
>> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
>> index 76e33bd7c556..2e887463c165 100644
>> --- a/arch/x86/mm/init_64.c
>> +++ b/arch/x86/mm/init_64.c
>> @@ -1013,7 +1013,10 @@ static void __meminit free_pagetable(struct page
>> *page, int order)
>>                   free_reserved_pages(page, nr_pages);
>>    #endif
>>           } else {
>> -               free_pages((unsigned long)page_address(page), order);
>> +               if (IS_ENABLED(CONFIG_ASYNC_PGTABLE_FREE))
>> +                       kernel_pgtable_free_pages_async(page, order);
>> +               else
>> +                       free_pages((unsigned long)page_address(page),
>> order);
>>           }
>>    }
>>
>> diff --git a/arch/x86/mm/pat/set_memory.c
>> b/arch/x86/mm/pat/set_memory.c
>> index 8834c76f91c9..7e567bdfddce 100644
>> --- a/arch/x86/mm/pat/set_memory.c
>> +++ b/arch/x86/mm/pat/set_memory.c
>> @@ -436,9 +436,13 @@ static void cpa_collapse_large_pages(struct
>> cpa_data *cpa)
>>
>>           flush_tlb_all();
>>
>> -       list_for_each_entry_safe(ptdesc, tmp, &pgtables, pt_list) {
>> -               list_del(&ptdesc->pt_list);
>> -               __free_page(ptdesc_page(ptdesc));
>> +       if (IS_ENABLED(CONFIG_ASYNC_PGTABLE_FREE)) {
>> +               kernel_pgtable_free_list_async(&pgtables);
>> +       } else {
>> +               list_for_each_entry_safe(ptdesc, tmp, &pgtables, pt_list) {
>> +                       list_del(&ptdesc->pt_list);
>> +                       __free_page(ptdesc_page(ptdesc));
>> +               }
>>           }
>>    }
>>
>> diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
>> index 4938eff5b482..13bbe1588872 100644
>> --- a/include/asm-generic/pgalloc.h
>> +++ b/include/asm-generic/pgalloc.h
>> @@ -48,8 +48,12 @@ static inline pte_t
>> *pte_alloc_one_kernel_noprof(struct mm_struct *mm)
>>
>>    #ifdef CONFIG_ASYNC_PGTABLE_FREE
>>    void pte_free_kernel_async(struct ptdesc *ptdesc);
>> +void kernel_pgtable_free_list_async(struct list_head *list);
>> +void kernel_pgtable_free_pages_async(struct page *pages, int order);
>>    #else
>>    static inline void pte_free_kernel_async(struct ptdesc *ptdesc) {}
>> +static inline void kernel_pgtable_free_list_async(struct list_head
>> *list) {}
>> +void kernel_pgtable_free_pages_async(struct page *pages, int order) {}
>>    #endif
>>
>>    /**
>> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
>> index b9a785dd6b8d..d1d19132bbe8 100644
>> --- a/mm/pgtable-generic.c
>> +++ b/mm/pgtable-generic.c
>> @@ -413,6 +413,7 @@ static void kernel_pte_work_func(struct work_struct
>> *work);
>>
>>    struct {
>>           struct list_head list;
>> +       struct list_head pages;
> the real difference between the two lists is about whether to use
> pagetable_dtor_free() or __free_page(). Then clearer to call them
> 'pages_dtor' and 'pages'?
> 
>>           spinlock_t lock;
>>           struct work_struct work;
>>    } kernel_pte_work = {
>> @@ -425,17 +426,24 @@ static void kernel_pte_work_func(struct
>> work_struct *work)
>>    {
>>           struct ptdesc *ptdesc, *next;
>>           LIST_HEAD(free_list);
>> +       LIST_HEAD(pages_list);
>>
>>           iommu_sva_invalidate_kva_range(0, TLB_FLUSH_ALL);
>>
>>           spin_lock(&kernel_pte_work.lock);
>>           list_move(&kernel_pte_work.list, &free_list);
>> +       list_move(&kernel_pte_work.pages, &pages_list);
>>           spin_unlock(&kernel_pte_work.lock);
>>
>>           list_for_each_entry_safe(ptdesc, next, &free_list, pt_list) {
>>                   list_del(&ptdesc->pt_list);
>>                   pagetable_dtor_free(ptdesc);
>>           }
>> +
>> +       list_for_each_entry_safe(ptdesc, next, &pages_list, pt_list) {
>> +               list_del(&ptdesc->pt_list);
>> +               __free_page(ptdesc_page(ptdesc));
>> +       }
>>    }
>>
>>    void pte_free_kernel_async(struct ptdesc *ptdesc)
>> @@ -444,4 +452,25 @@ void pte_free_kernel_async(struct ptdesc *ptdesc)
>>           list_add(&ptdesc->pt_list, &kernel_pte_work.list);
>>           schedule_work(&kernel_pte_work.work);
>>    }
>> +
>> +void kernel_pgtable_free_list_async(struct list_head *list)
>> +{
>> +       guard(spinlock)(&kernel_pte_work.lock);
>> +       list_splice_tail(list, &kernel_pte_work.pages);
>> +       schedule_work(&kernel_pte_work.work);
>> +}
>> +
>> +void kernel_pgtable_free_pages_async(struct page *pages, int order)
>> +{
>> +       unsigned long nr_pages = 1 << order;
>> +       struct ptdesc *ptdesc;
>> +       int i;
>> +
>> +       guard(spinlock)(&kernel_pte_work.lock);
>> +       for (i = 0; i < nr_pages; i++) {
>> +               ptdesc = page_ptdesc(&pages[i]);
>> +               list_add(&ptdesc->pt_list, &kernel_pte_work.pages);
>> +       }
> there is a side-effect here. Now a contiguous range of pages (order=N)
> are freed one-by-one, so they are first fed back to the order=0 free list
> with possibility of getting split due to small order allocations before
> having chance to lift back to the order=N list. then the number of
> available huge pages is unnecessarily reduced.
> 
> but look at the code probably we don't need to handle the order>0 case?
> 
> now only free_hugepage_table() may free a huge page, called from
> remove_pmd_table() when a pmd is a*leaf* entry pointing to a
> vmemmap huge page. So it's not a real page table. I'm not sure why
> it's piggybacked in a pagetable helper, but sounds like a case we
> can ignore in this mitigation...

I am not sure about this context either. My understanding is that
"order > 0" is used for the batch deallocation of page table pages that
were created to map large, contiguous blocks of memory.

Thanks for your comments. I have created a new patch to introduce the
asynchronous page table page free mechanism, taking the above comments
into consideration. Let me post it below for further review.

mm: Conditionally defer freeing of kernel page table pages

On x86 and other architectures that map the kernel's virtual address space
into the upper portion of every process's page table, the IOMMU's paging
structure caches can become stale. This occurs when a page used for the
kernel's page tables is freed and reused without the IOMMU being notified.

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

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
  arch/x86/mm/init_64.c         |   5 +-
  arch/x86/mm/pat/set_memory.c  |  10 +++-
  arch/x86/mm/pgtable.c         |   5 +-
  include/asm-generic/pgalloc.h |  17 +++++-
  mm/Kconfig                    |   3 +
  mm/pgtable-generic.c          | 106 ++++++++++++++++++++++++++++++++++
  6 files changed, 140 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 76e33bd7c556..bf06d815d214 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1013,7 +1013,10 @@ static void __meminit free_pagetable(struct page 
*page, int order)
  		free_reserved_pages(page, nr_pages);
  #endif
  	} else {
-		free_pages((unsigned long)page_address(page), order);
+		if (IS_ENABLED(CONFIG_ASYNC_PGTABLE_FREE))
+			kernel_pgtable_async_free_pages(page, order);
+		else
+			free_pages((unsigned long)page_address(page), order);
  	}
  }

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 8834c76f91c9..97d4f39cae7d 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -436,9 +436,13 @@ static void cpa_collapse_large_pages(struct 
cpa_data *cpa)

  	flush_tlb_all();

-	list_for_each_entry_safe(ptdesc, tmp, &pgtables, pt_list) {
-		list_del(&ptdesc->pt_list);
-		__free_page(ptdesc_page(ptdesc));
+	if (IS_ENABLED(CONFIG_ASYNC_PGTABLE_FREE)) {
+		kernel_pgtable_async_free_page_list(&pgtables);
+	} else {
+		list_for_each_entry_safe(ptdesc, tmp, &pgtables, pt_list) {
+			list_del(&ptdesc->pt_list);
+			__free_page(ptdesc_page(ptdesc));
+		}
  	}
  }

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index ddf248c3ee7d..45268f009cb0 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -757,7 +757,10 @@ int pud_free_pmd_page(pud_t *pud, unsigned long addr)

  	free_page((unsigned long)pmd_sv);

-	pmd_free(&init_mm, pmd);
+	if (IS_ENABLED(CONFIG_ASYNC_PGTABLE_FREE))
+		kernel_pgtable_async_free_dtor(virt_to_ptdesc(pmd));
+	else
+		pmd_free(&init_mm, pmd);

  	return 1;
  }
diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 3c8ec3bfea44..baa9780cad71 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -46,6 +46,16 @@ static inline pte_t 
*pte_alloc_one_kernel_noprof(struct mm_struct *mm)
  #define pte_alloc_one_kernel(...) 
alloc_hooks(pte_alloc_one_kernel_noprof(__VA_ARGS__))
  #endif

+#ifdef CONFIG_ASYNC_PGTABLE_FREE
+void kernel_pgtable_async_free_dtor(struct ptdesc *ptdesc);
+void kernel_pgtable_async_free_page_list(struct list_head *list);
+void kernel_pgtable_async_free_pages(struct page *pages, int order);
+#else
+static inline void kernel_pgtable_async_free_dtor(struct ptdesc *ptdesc) {}
+static inline void kernel_pgtable_async_free_page_list(struct list_head 
*list) {}
+static inline void kernel_pgtable_async_free_pages(struct page *pages, 
int order) {}
+#endif
+
  /**
   * pte_free_kernel - free PTE-level kernel page table memory
   * @mm: the mm_struct of the current context
@@ -53,7 +63,12 @@ static inline pte_t 
*pte_alloc_one_kernel_noprof(struct mm_struct *mm)
   */
  static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
  {
-	pagetable_dtor_free(virt_to_ptdesc(pte));
+	struct ptdesc *ptdesc = virt_to_ptdesc(pte);
+
+	if (IS_ENABLED(CONFIG_ASYNC_PGTABLE_FREE))
+		kernel_pgtable_async_free_dtor(ptdesc);
+	else
+		pagetable_dtor_free(ptdesc);
  }

  /**
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
index 567e2d084071..d2751da58c94 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -406,3 +406,109 @@ pte_t *__pte_offset_map_lock(struct mm_struct *mm, 
pmd_t *pmd,
  	pte_unmap_unlock(pte, ptl);
  	goto again;
  }
+
+#ifdef CONFIG_ASYNC_PGTABLE_FREE
+static void kernel_pgtable_work_func(struct work_struct *work);
+
+static struct {
+	/* list for pagetable_dtor_free() */
+	struct list_head dtor;
+	/* list for __free_page() */
+	struct list_head page;
+	/* list for free_pages() */
+	struct list_head pages;
+	/* protect all the ptdesc lists */
+	spinlock_t lock;
+	struct work_struct work;
+} kernel_pgtable_work = {
+	.dtor = LIST_HEAD_INIT(kernel_pgtable_work.dtor),
+	.page = LIST_HEAD_INIT(kernel_pgtable_work.page),
+	.pages = LIST_HEAD_INIT(kernel_pgtable_work.pages),
+	.lock = __SPIN_LOCK_UNLOCKED(kernel_pgtable_work.lock),
+	.work = __WORK_INITIALIZER(kernel_pgtable_work.work, 
kernel_pgtable_work_func),
+};
+
+struct async_free_data {
+	struct list_head node;
+	unsigned long addr;
+	int order;
+};
+
+static void kernel_pgtable_work_func(struct work_struct *work)
+{
+	struct async_free_data *data, *temp;
+	struct ptdesc *ptdesc, *next;
+	LIST_HEAD(pages_list);
+	LIST_HEAD(dtor_list);
+	LIST_HEAD(page_list);
+
+	spin_lock(&kernel_pgtable_work.lock);
+	list_splice_tail_init(&kernel_pgtable_work.dtor, &dtor_list);
+	list_splice_tail_init(&kernel_pgtable_work.page, &page_list);
+	list_splice_tail_init(&kernel_pgtable_work.pages, &pages_list);
+	spin_unlock(&kernel_pgtable_work.lock);
+
+	list_for_each_entry_safe(ptdesc, next, &dtor_list, pt_list) {
+		list_del(&ptdesc->pt_list);
+		pagetable_dtor_free(ptdesc);
+	}
+
+	list_for_each_entry_safe(ptdesc, next, &page_list, pt_list) {
+		list_del(&ptdesc->pt_list);
+		__free_page(ptdesc_page(ptdesc));
+	}
+
+	list_for_each_entry_safe(data, temp, &pages_list, node) {
+		list_del(&data->node);
+		free_pages(data->addr, data->order);
+		kfree(data);
+	}
+}
+
+void kernel_pgtable_async_free_dtor(struct ptdesc *ptdesc)
+{
+	spin_lock(&kernel_pgtable_work.lock);
+	list_add(&ptdesc->pt_list, &kernel_pgtable_work.dtor);
+	spin_unlock(&kernel_pgtable_work.lock);
+
+	schedule_work(&kernel_pgtable_work.work);
+}
+
+void kernel_pgtable_async_free_page_list(struct list_head *list)
+{
+	spin_lock(&kernel_pgtable_work.lock);
+	list_splice_tail(list, &kernel_pgtable_work.page);
+	spin_unlock(&kernel_pgtable_work.lock);
+
+	schedule_work(&kernel_pgtable_work.work);
+}
+
+void kernel_pgtable_async_free_pages(struct page *pages, int order)
+{
+	struct async_free_data *data;
+
+	if (order == 0) {
+		spin_lock(&kernel_pgtable_work.lock);
+		list_add(&page_ptdesc(pages)->pt_list, &kernel_pgtable_work.page);
+		spin_unlock(&kernel_pgtable_work.lock);
+
+		goto out;
+	}
+
+	data = kzalloc(sizeof(*data), GFP_ATOMIC);
+	if (!data) {
+		free_pages((unsigned long)page_address(pages), order);
+		goto out;
+	}
+
+	data->addr = (unsigned long)page_address(pages);
+	data->order = order;
+
+	spin_lock(&kernel_pgtable_work.lock);
+	list_add(&data->node, &kernel_pgtable_work.pages);
+	spin_unlock(&kernel_pgtable_work.lock);
+
+out:
+	schedule_work(&kernel_pgtable_work.work);
+}
+#endif
-- 
2.43.0

Thanks,
baolu

