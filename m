Return-Path: <stable+bounces-169925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2FDB2999B
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 08:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02A0C170F29
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 06:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49354274669;
	Mon, 18 Aug 2025 06:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="al6ETEFm"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73794274649;
	Mon, 18 Aug 2025 06:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755498253; cv=none; b=FoqcjJhR1ckkdaxvaGsrAfe1DT97JcC+gGLR//7lBzlbeBf2hr4XCAyIuTSSrEX5MM1opW/rk5cAka6grcJ7lJkme20xJppH2+cjwMnLVE8UGgUaFXyYyRdGfnbkQUY+aNSyZyU1ZsiTwOoiY+SmoTJY9UTtz+y07r+s2X1CjF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755498253; c=relaxed/simple;
	bh=wBt2cAbWCIb16blRdEgE4Ev97VWf50shLoHWtIm12cg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lgFrh99JzDLdgQsCpeZKUUDwUZu4PBRYwNXoz4xT3ECHHjOBd0itdOE+RKiriBJvGPMJlF+KJjLrUSRwPHCebyeak8RnAPQd4n1tyNrhrN/zEVhBTxG8Pz/jzl8FHX6xeiayyjsQa3Lz7XU3kof2B1t/TqzocxG6xu64dMR7sDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=al6ETEFm; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755498252; x=1787034252;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wBt2cAbWCIb16blRdEgE4Ev97VWf50shLoHWtIm12cg=;
  b=al6ETEFmsE0XjlnlvZ3F6vmM1lzvBDC4pHESkWTin72oA2C1eWwrLMjh
   bMqltQqKoAw4eGUkYBEGl0LQH1aXjkCZxrkk5Azw3d0Itq4C5sZPxVyQb
   foDN0jT36Gmu8U1CmcfN1kwC6JOqDRkpb2ObzSHOwN1gNY4c3T4WKkB7R
   /jxD+gewQqCHSbSo5YLeRqImLBe994ODh+9O2gQNvXkEatX0zt0rebDzs
   6lj52rCKVNlQp45wreRD4ZiugWPyArTsTZtFcmuzsvtEgAnR89EFiv4Dp
   cuemSSAFEJEhO0nB/HwkKbMHAYek6cW3Uww1bLnPRIh3kEO6M99DHrWli
   Q==;
X-CSE-ConnectionGUID: IrEx8wovQc2ux1D7kfw0Wg==
X-CSE-MsgGUID: v+2WPDszSHS2kDQ7a+XbyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="57790382"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="57790382"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2025 23:24:11 -0700
X-CSE-ConnectionGUID: F72GGOsYTxOssHw4GGjltg==
X-CSE-MsgGUID: 9EgUT1MAQ9Wu5oRBtTcafQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="167469687"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2025 23:24:07 -0700
Message-ID: <87bfc80e-258e-4193-a56c-3096608aec30@linux.intel.com>
Date: Mon, 18 Aug 2025 14:21:55 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: "Hansen, Dave" <dave.hansen@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jann Horn <jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Alistair Popple <apopple@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, "Lai, Yi1" <yi1.lai@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "security@kernel.org" <security@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20250806052505.3113108-1-baolu.lu@linux.intel.com>
 <d646d434-f680-47a3-b6b9-26f4538c1209@intel.com>
 <20250806155223.GV184255@nvidia.com>
 <d02cb97a-7cea-4ad3-82b3-89754c5278ad@intel.com>
 <20250806160904.GX184255@nvidia.com>
 <62d21545-9e75-41e3-89a3-f21dda15bf16@intel.com>
 <4a8df0e8-bd5a-44e4-acce-46ba75594846@linux.intel.com>
 <20250807195154.GO184255@nvidia.com>
 <BN9PR11MB52762A47B347C99F0C0E4C288C2FA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52762A47B347C99F0C0E4C288C2FA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/8/25 10:57, Tian, Kevin wrote:
>> From: Jason Gunthorpe <jgg@nvidia.com>
>> Sent: Friday, August 8, 2025 3:52 AM
>>
>> On Thu, Aug 07, 2025 at 10:40:39PM +0800, Baolu Lu wrote:
>>> +static void kernel_pte_work_func(struct work_struct *work)
>>> +{
>>> +	struct page *page, *next;
>>> +
>>> +	iommu_sva_invalidate_kva_range(0, TLB_FLUSH_ALL);
>>> +
>>> +	guard(spinlock)(&kernel_pte_work.lock);
>>> +	list_for_each_entry_safe(page, next, &kernel_pte_work.list, lru) {
>>> +		list_del_init(&page->lru);
>>
>> Please don't add new usages of lru, we are trying to get rid of this. :(
>>
>> I think the memory should be struct ptdesc, use that..
>>
> 
> btw with this change we should also defer free of the pmd page:
> 
> pud_free_pmd_page()
> 	...
> 	for (i = 0; i < PTRS_PER_PMD; i++) {
> 		if (!pmd_none(pmd_sv[i])) {
> 			pte = (pte_t *)pmd_page_vaddr(pmd_sv[i]);
> 			pte_free_kernel(&init_mm, pte);
> 		}
> 	}
> 
> 	free_page((unsigned long)pmd_sv);
> 
> Otherwise the risk still exists if the pmd page is repurposed before the
> pte work is scheduled.


My understanding is that you were talking about pmd_free(), correct? It
appears that both pmd_free() and pte_free_kernel() call
pagetable_dtor_free(). If so, how about the following change?

diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index dbddacdca2ce..04f6b5bc212c 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -172,10 +172,8 @@ static inline pmd_t *pmd_alloc_one_noprof(struct 
mm_struct *mm, unsigned long ad
  #ifndef __HAVE_ARCH_PMD_FREE
  static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
  {
-       struct ptdesc *ptdesc = virt_to_ptdesc(pmd);
-
         BUG_ON((unsigned long)pmd & (PAGE_SIZE-1));
-       pagetable_dtor_free(ptdesc);
+       pte_free_kernel(mm, (pte_t *)pmd);
  }

> 
> another observation - pte_free_kernel is not used in remove_pagetable ()
> and __change_page_attr(). Is it straightforward to put it in those paths
> or do we need duplicate some deferring logic there?
> 

In both of these cases, pages in an array or list require deferred
freeing. I don't believe the previous approach, which calls
pagetable_dtor_free(), will still work here. Perhaps a separate list is
needed? What about something like the following?

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 76e33bd7c556..2e887463c165 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1013,7 +1013,10 @@ static void __meminit free_pagetable(struct page 
*page, int order)
                 free_reserved_pages(page, nr_pages);
  #endif
         } else {
-               free_pages((unsigned long)page_address(page), order);
+               if (IS_ENABLED(CONFIG_ASYNC_PGTABLE_FREE))
+                       kernel_pgtable_free_pages_async(page, order);
+               else
+                       free_pages((unsigned long)page_address(page), 
order);
         }
  }

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 8834c76f91c9..7e567bdfddce 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -436,9 +436,13 @@ static void cpa_collapse_large_pages(struct 
cpa_data *cpa)

         flush_tlb_all();

-       list_for_each_entry_safe(ptdesc, tmp, &pgtables, pt_list) {
-               list_del(&ptdesc->pt_list);
-               __free_page(ptdesc_page(ptdesc));
+       if (IS_ENABLED(CONFIG_ASYNC_PGTABLE_FREE)) {
+               kernel_pgtable_free_list_async(&pgtables);
+       } else {
+               list_for_each_entry_safe(ptdesc, tmp, &pgtables, pt_list) {
+                       list_del(&ptdesc->pt_list);
+                       __free_page(ptdesc_page(ptdesc));
+               }
         }
  }

diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 4938eff5b482..13bbe1588872 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -48,8 +48,12 @@ static inline pte_t 
*pte_alloc_one_kernel_noprof(struct mm_struct *mm)

  #ifdef CONFIG_ASYNC_PGTABLE_FREE
  void pte_free_kernel_async(struct ptdesc *ptdesc);
+void kernel_pgtable_free_list_async(struct list_head *list);
+void kernel_pgtable_free_pages_async(struct page *pages, int order);
  #else
  static inline void pte_free_kernel_async(struct ptdesc *ptdesc) {}
+static inline void kernel_pgtable_free_list_async(struct list_head 
*list) {}
+void kernel_pgtable_free_pages_async(struct page *pages, int order) {}
  #endif

  /**
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index b9a785dd6b8d..d1d19132bbe8 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -413,6 +413,7 @@ static void kernel_pte_work_func(struct work_struct 
*work);

  struct {
         struct list_head list;
+       struct list_head pages;
         spinlock_t lock;
         struct work_struct work;
  } kernel_pte_work = {
@@ -425,17 +426,24 @@ static void kernel_pte_work_func(struct 
work_struct *work)
  {
         struct ptdesc *ptdesc, *next;
         LIST_HEAD(free_list);
+       LIST_HEAD(pages_list);

         iommu_sva_invalidate_kva_range(0, TLB_FLUSH_ALL);

         spin_lock(&kernel_pte_work.lock);
         list_move(&kernel_pte_work.list, &free_list);
+       list_move(&kernel_pte_work.pages, &pages_list);
         spin_unlock(&kernel_pte_work.lock);

         list_for_each_entry_safe(ptdesc, next, &free_list, pt_list) {
                 list_del(&ptdesc->pt_list);
                 pagetable_dtor_free(ptdesc);
         }
+
+       list_for_each_entry_safe(ptdesc, next, &pages_list, pt_list) {
+               list_del(&ptdesc->pt_list);
+               __free_page(ptdesc_page(ptdesc));
+       }
  }

  void pte_free_kernel_async(struct ptdesc *ptdesc)
@@ -444,4 +452,25 @@ void pte_free_kernel_async(struct ptdesc *ptdesc)
         list_add(&ptdesc->pt_list, &kernel_pte_work.list);
         schedule_work(&kernel_pte_work.work);
  }
+
+void kernel_pgtable_free_list_async(struct list_head *list)
+{
+       guard(spinlock)(&kernel_pte_work.lock);
+       list_splice_tail(list, &kernel_pte_work.pages);
+       schedule_work(&kernel_pte_work.work);
+}
+
+void kernel_pgtable_free_pages_async(struct page *pages, int order)
+{
+       unsigned long nr_pages = 1 << order;
+       struct ptdesc *ptdesc;
+       int i;
+
+       guard(spinlock)(&kernel_pte_work.lock);
+       for (i = 0; i < nr_pages; i++) {
+               ptdesc = page_ptdesc(&pages[i]);
+               list_add(&ptdesc->pt_list, &kernel_pte_work.pages);
+       }
+       schedule_work(&kernel_pte_work.work);
+}
  #endif


Thanks,
baolu

