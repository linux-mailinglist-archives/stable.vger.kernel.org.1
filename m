Return-Path: <stable+bounces-166792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF71AB1DAD6
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 17:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8FD9176186
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 15:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03F7137932;
	Thu,  7 Aug 2025 15:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lrY5n5nA"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700BE1A2389;
	Thu,  7 Aug 2025 15:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754580681; cv=none; b=slobYXMmMeLcSxrm2Lco1DLGCCB6R0XgNHCU3B9ORO1VDF2apJbJ178eRZ9hbTP9rMXvcYPVjsKuVviW9t+3XmKkZK664A4xu8OhaZ6owyZgBZcznTRVAIcepc218Mnv3XxoFofuJ1GdLWf7EptrNC43HzFwCMvnLPU6p0tSBIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754580681; c=relaxed/simple;
	bh=BW3DERsAQoNMGNbPOlfRsVVubSDCvjIEebztFwNfBEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pr9NrGoarS8APN5bZgWqyo2qcmeQWzy70IzR4Pgya00eMsJdSDBcX29eKzPE4Kk8ULKZzYdR4ItVQjs+4YPwD9A14FW1r2bXFmIdsCdPNP/jj8RVMoE5sFifAJoTtwmCjSaFnC3vB8IXEPrqKBRGf+mPuP0uY6pvfZ64LHeAH5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lrY5n5nA; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754580680; x=1786116680;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BW3DERsAQoNMGNbPOlfRsVVubSDCvjIEebztFwNfBEs=;
  b=lrY5n5nA2hZjqUv0CTsTVBjJ9k+xQ0RdLep6zYrWR5V1qLcve82CdxAy
   wTz4SceDWNAP/Rh4u5LZCRY5wAVjB2Tq6MIa1ixp1NTtqdCiw8/jSCSRY
   KHIegaF155Y4koA98iDCPd3IJCws2/66f0hX1MPtwwG2rasdVuGtTX6x5
   kxvBozSh5szr4f4qOswzsrrfKfVf7FwBXdZP2R0s59AD+VA6XZNwp0RWm
   A3fgcTD7+zRPt+IcY3Wt2A8DXVdH6jbnhRDhtqICva85CWPzEDiBUk3ZD
   2/PPk8egHk7yifl+Qybd6M+QGS8tV9D8GOvzFf0u5vgRX/Jnd9k9rjUFY
   A==;
X-CSE-ConnectionGUID: 2bN4e62mT0mBJYLK2jBHFQ==
X-CSE-MsgGUID: Cl1Sn9PhRhS8c2UCTNKzmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="74374706"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="74374706"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 08:31:19 -0700
X-CSE-ConnectionGUID: /fXF9q9ST8KLO1598FGT8A==
X-CSE-MsgGUID: FL5gAZeERuSnlQfzb7Vwsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="165096696"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO [10.125.110.207]) ([10.125.110.207])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 08:31:18 -0700
Message-ID: <4ce79c80-1fc8-4684-920a-c8d82c4c3dc8@intel.com>
Date: Thu, 7 Aug 2025 08:31:18 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
To: Baolu Lu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>
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
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <4a8df0e8-bd5a-44e4-acce-46ba75594846@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/7/25 07:40, Baolu Lu wrote:
...
> I refactored the code above as follows. It compiles but hasn't been
> tested yet. Does it look good to you?

As in, it takes the non-compiling gunk I spewed into my email client and
makes it compile, yeah. Sure. ;)

> diff --git a/arch/x86/include/asm/pgalloc.h b/arch/x86/include/asm/
> pgalloc.h
> index c88691b15f3c..d9307dd09f67 100644
> --- a/arch/x86/include/asm/pgalloc.h
> +++ b/arch/x86/include/asm/pgalloc.h
> @@ -10,9 +10,11 @@
> 
>  #define __HAVE_ARCH_PTE_ALLOC_ONE
>  #define __HAVE_ARCH_PGD_FREE
> +#define __HAVE_ARCH_PTE_FREE_KERNEL

But I think it really muddies the waters down here.

This kinda reads like "x86 has its own per-arch pte_free_kernel() that
it always needs". Which is far from accurate.

> @@ -844,3 +845,42 @@ void arch_check_zapped_pud(struct vm_area_struct
> *vma, pud_t pud)
>      /* See note in arch_check_zapped_pte() */
>      VM_WARN_ON_ONCE(!(vma->vm_flags & VM_SHADOW_STACK) && pud_shstk(pud));
>  }
> +
> +static void kernel_pte_work_func(struct work_struct *work);
> +
> +static struct {
> +    struct list_head list;
> +    spinlock_t lock;
> +    struct work_struct work;
> +} kernel_pte_work = {
> +    .list = LIST_HEAD_INIT(kernel_pte_work.list),
> +    .lock = __SPIN_LOCK_UNLOCKED(kernel_pte_work.lock),
> +    .work = __WORK_INITIALIZER(kernel_pte_work.work,
> kernel_pte_work_func),
> +};
> +
> +static void kernel_pte_work_func(struct work_struct *work)
> +{
> +    struct page *page, *next;
> +
> +    iommu_sva_invalidate_kva_range(0, TLB_FLUSH_ALL);
> +
> +    guard(spinlock)(&kernel_pte_work.lock);
> +    list_for_each_entry_safe(page, next, &kernel_pte_work.list, lru) {
> +        list_del_init(&page->lru);
> +        pagetable_dtor_free(page_ptdesc(page));
> +    }
> +}
> +
> +/**
> + * pte_free_kernel - free PTE-level kernel page table memory
> + * @mm: the mm_struct of the current context
> + * @pte: pointer to the memory containing the page table
> + */

The kerneldoc here is just wasted bytes, IMNHO. Why not use those bytes
to actually explain what the heck is going on here?

> +void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
> +{
> +    struct page *page = virt_to_page(pte);
> +
> +    guard(spinlock)(&kernel_pte_work.lock);
> +    list_add(&page->lru, &kernel_pte_work.list);
> +    schedule_work(&kernel_pte_work.work);
> +}
> diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
> index 3c8ec3bfea44..716ebab67636 100644
> --- a/include/asm-generic/pgalloc.h
> +++ b/include/asm-generic/pgalloc.h
> @@ -46,6 +46,7 @@ static inline pte_t
> *pte_alloc_one_kernel_noprof(struct mm_struct *mm)
>  #define pte_alloc_one_kernel(...)
> alloc_hooks(pte_alloc_one_kernel_noprof(__VA_ARGS__))
>  #endif
> 
> +#ifndef __HAVE_ARCH_PTE_FREE_KERNEL
>  /**
>   * pte_free_kernel - free PTE-level kernel page table memory
>   * @mm: the mm_struct of the current context
> @@ -55,6 +56,7 @@ static inline void pte_free_kernel(struct mm_struct
> *mm, pte_t *pte)
>  {
>      pagetable_dtor_free(virt_to_ptdesc(pte));
>  }
> +#endif
> 
>  /**
>   * __pte_alloc_one - allocate memory for a PTE-level user page table

I'd much rather the arch-generic code looked like this:

#ifdef CONFIG_ASYNC_PGTABLE_FREE
// code and struct here, or dump them over in some
// other file and do this in a header
#else
static void pte_free_kernel_async(struct page *page) {}
#endif

void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
{
    struct page *page = virt_to_page(pte);

    if (IS_DEFINED(CONFIG_ASYNC_PGTABLE_FREE)) {
	pte_free_kernel_async(page);
    else
	pagetable_dtor_free(page_ptdesc(page));
}

Then in Kconfig, you end up with something like:

config ASYNC_PGTABLE_FREE
	def_bool y
	depends on INTEL_IOMMU_WHATEVER

That very much tells much more of the whole story in code. It also gives
the x86 folks that compile out the IOMMU the exact same code as the
arch-generic folks. It _also_ makes it dirt simple and obvious for the
x86 folks to optimize out the async behavior if they don't like it in
the future by replacing the compile-time IOMMU check with a runtime one.

Also, if another crazy IOMMU implementation comes along that happens to
do what the x86 IOMMUs do, then they have a single Kconfig switch to
flip. If they follow what this patch tries to do, they'll start by
copying and pasting the x86 implementation.

