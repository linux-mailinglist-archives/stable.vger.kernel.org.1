Return-Path: <stable+bounces-166789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD439B1DA08
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 16:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C37E162FB5
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 14:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE51B263892;
	Thu,  7 Aug 2025 14:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N0R0QUrk"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7179B227EA7;
	Thu,  7 Aug 2025 14:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754577648; cv=none; b=MmbWF2KMpuuC4f0fZAKGg4QxIkxb054GgKlRneFNZFI1LuLBbdeTCGmdTD/m4k6gafHoLz4XDcg55KDrZos2Fj4g3UkMsL/9pE/ASMCU8hx194GOBYWAjU0GCjrc4webNFoSSx15DQX5QTNEtq/BKbsP4YnAxEuCgUwrvbBBD4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754577648; c=relaxed/simple;
	bh=8rfAJxFmF2Pd+SoMjgyhcZjBC7s22/gkPAdrVPBV4AI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LDmKhvuxa+kW208DOHXWcmxLoxuLVOcYYpAFaPruqT2MEKx0cMRb+YSGpj/O2HlaK/6rNncQUndVFPLieq7Rfks6ZHvK+GNHTrphXr1UEgUDPyD7vfOFbSz0BCLtYKDMBnj0W3U33lCiC4aE5FU1O/9GAG5RRrc5cDhP+6b9yu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N0R0QUrk; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754577646; x=1786113646;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8rfAJxFmF2Pd+SoMjgyhcZjBC7s22/gkPAdrVPBV4AI=;
  b=N0R0QUrkJe09W4VFINvQcEBBL1PI8s/pH27A84YVYK28Qm86dWH+D61U
   MtwoeZH+7de8YkOva6HW7ceUVbep5thygJP+U/dx7m3laYq1tzMdpI6fj
   3w2To8I7AnsqQCcf2S+NLpBrejL9UGlKl3frXdOPDpmpyW4CkMT/7Ho8g
   2HM3q63QsrmVtb8mU4r0fars94jAdmKLZrBV9bfEsi8eTdkdd3Yh8zosk
   0RjTfirNhEjmFpsmPlOwCl6W1aBG+FoH+u08YJLrM8XnNDrs8bHdTqoJ0
   Yq2vqyM9R5eI6YPw0M68SpG4qVliUApt/UMmbNVC9IEYI6BMg3HQ5TXPC
   g==;
X-CSE-ConnectionGUID: iMHY/kpsQi67y0AjaC0oBg==
X-CSE-MsgGUID: f43SNLgSS9+hiaO1YqMwqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="67505970"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="67505970"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 07:40:45 -0700
X-CSE-ConnectionGUID: fsp0lPuhQciDk60mZELapQ==
X-CSE-MsgGUID: e/4uHLauQsuQAqNJE225sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="170340530"
Received: from xlan-mobl1.ccr.corp.intel.com (HELO [10.124.240.185]) ([10.124.240.185])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 07:40:41 -0700
Message-ID: <4a8df0e8-bd5a-44e4-acce-46ba75594846@linux.intel.com>
Date: Thu, 7 Aug 2025 22:40:39 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Jann Horn <jannh@google.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Alistair Popple <apopple@nvidia.com>,
 Peter Zijlstra <peterz@infradead.org>, Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
 iommu@lists.linux.dev, security@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v3 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
To: Dave Hansen <dave.hansen@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20250806052505.3113108-1-baolu.lu@linux.intel.com>
 <d646d434-f680-47a3-b6b9-26f4538c1209@intel.com>
 <20250806155223.GV184255@nvidia.com>
 <d02cb97a-7cea-4ad3-82b3-89754c5278ad@intel.com>
 <20250806160904.GX184255@nvidia.com>
 <62d21545-9e75-41e3-89a3-f21dda15bf16@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <62d21545-9e75-41e3-89a3-f21dda15bf16@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/7/2025 12:34 AM, Dave Hansen wrote:
> On 8/6/25 09:09, Jason Gunthorpe wrote:
>>>>
>>>> You can't do this approach without also pushing the pages to freed on
>>>> a list and defering the free till the work. This is broadly what the
>>>> normal mm user flow is doing..
>>> FWIW, I think the simplest way to do this is to plop an unconditional
>>> schedule_work() in pte_free_kernel(). The work function will invalidate
>>> the IOTLBs and then free the page.
>>>
>>> Keep the schedule_work() unconditional to keep it simple. The
>>> schedule_work() is way cheaper than all the system-wide TLB invalidation
>>> IPIs that have to get sent as well. No need to add complexity to
>>> optimize out something that's in the noise already.
>> That works also, but now you have to allocate memory or you are
>> dead.. Is it OK these days, and safe in this code which seems a little
>> bit linked to memory management?
>>
>> The MM side avoided this by putting the list and the rcu_head in the
>> struct page.
> 
> I don't think you need to allocate memory. A little static structure
> that uses the page->list and has a lock should do. Logically something
> like this:
> 
> struct kernel_pgtable_work
> {
> 	struct list_head list;
> 	spinlock_t lock;
> 	struct work_struct work;
> } kernel_pte_work;
> 
> pte_free_kernel()
> {
> 	struct page *page = ptdesc_magic();
> 
> 	guard(spinlock)(&kernel_pte_work.lock);
> 	
> 	list_add(&page->list, &kernel_pte_work.list);
> 	schedule_work(&kernel_pte_work.work);
> }
> 
> work_func()
> {
> 	iommu_sva_invalidate_kva();
> 
> 	guard(spinlock)(&kernel_pte_work.lock);
> 
> 	list_for_each_safe() {
> 		page = container_of(...);
> 		free_whatever(page);
> 	}
> }
> 
> The only wrinkle is that pte_free_kernel() itself still has a pte and
> 'ptdesc', not a 'struct page'. But there is ptdesc->pt_list, which
> should be unused at this point, especially for non-pgd pages on x86.
> 
> So, either go over to the 'struct page' earlier (maybe by open-coding
> pagetable_dtor_free()?), or just use the ptdesc.

I refactored the code above as follows. It compiles but hasn't been
tested yet. Does it look good to you?

diff --git a/arch/x86/include/asm/pgalloc.h b/arch/x86/include/asm/pgalloc.h
index c88691b15f3c..d9307dd09f67 100644
--- a/arch/x86/include/asm/pgalloc.h
+++ b/arch/x86/include/asm/pgalloc.h
@@ -10,9 +10,11 @@

  #define __HAVE_ARCH_PTE_ALLOC_ONE
  #define __HAVE_ARCH_PGD_FREE
+#define __HAVE_ARCH_PTE_FREE_KERNEL
  #include <asm-generic/pgalloc.h>

  static inline int  __paravirt_pgd_alloc(struct mm_struct *mm) { return 
0; }
+void pte_free_kernel(struct mm_struct *mm, pte_t *pte);

  #ifdef CONFIG_PARAVIRT_XXL
  #include <asm/paravirt.h>
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index ddf248c3ee7d..f9f6738dd3cc 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -2,6 +2,7 @@
  #include <linux/mm.h>
  #include <linux/gfp.h>
  #include <linux/hugetlb.h>
+#include <linux/iommu.h>
  #include <asm/pgalloc.h>
  #include <asm/tlb.h>
  #include <asm/fixmap.h>
@@ -844,3 +845,42 @@ void arch_check_zapped_pud(struct vm_area_struct 
*vma, pud_t pud)
  	/* See note in arch_check_zapped_pte() */
  	VM_WARN_ON_ONCE(!(vma->vm_flags & VM_SHADOW_STACK) && pud_shstk(pud));
  }
+
+static void kernel_pte_work_func(struct work_struct *work);
+
+static struct {
+	struct list_head list;
+	spinlock_t lock;
+	struct work_struct work;
+} kernel_pte_work = {
+	.list = LIST_HEAD_INIT(kernel_pte_work.list),
+	.lock = __SPIN_LOCK_UNLOCKED(kernel_pte_work.lock),
+	.work = __WORK_INITIALIZER(kernel_pte_work.work, kernel_pte_work_func),
+};
+
+static void kernel_pte_work_func(struct work_struct *work)
+{
+	struct page *page, *next;
+
+	iommu_sva_invalidate_kva_range(0, TLB_FLUSH_ALL);
+
+	guard(spinlock)(&kernel_pte_work.lock);
+	list_for_each_entry_safe(page, next, &kernel_pte_work.list, lru) {
+		list_del_init(&page->lru);
+		pagetable_dtor_free(page_ptdesc(page));
+	}
+}
+
+/**
+ * pte_free_kernel - free PTE-level kernel page table memory
+ * @mm: the mm_struct of the current context
+ * @pte: pointer to the memory containing the page table
+ */
+void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
+{
+	struct page *page = virt_to_page(pte);
+
+	guard(spinlock)(&kernel_pte_work.lock);
+	list_add(&page->lru, &kernel_pte_work.list);
+	schedule_work(&kernel_pte_work.work);
+}
diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 3c8ec3bfea44..716ebab67636 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -46,6 +46,7 @@ static inline pte_t 
*pte_alloc_one_kernel_noprof(struct mm_struct *mm)
  #define pte_alloc_one_kernel(...) 
alloc_hooks(pte_alloc_one_kernel_noprof(__VA_ARGS__))
  #endif

+#ifndef __HAVE_ARCH_PTE_FREE_KERNEL
  /**
   * pte_free_kernel - free PTE-level kernel page table memory
   * @mm: the mm_struct of the current context
@@ -55,6 +56,7 @@ static inline void pte_free_kernel(struct mm_struct 
*mm, pte_t *pte)
  {
  	pagetable_dtor_free(virt_to_ptdesc(pte));
  }
+#endif

  /**
   * __pte_alloc_one - allocate memory for a PTE-level user page table
-- 
2.43.0

Thanks,
baolu

