Return-Path: <stable+bounces-166706-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3335B1C827
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 17:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DCA07B1A98
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 15:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581C7221F15;
	Wed,  6 Aug 2025 15:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WCKKdgV5"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7482428A3EF;
	Wed,  6 Aug 2025 15:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754492626; cv=none; b=LcGyYaYgmXx0WuT76zx5UBNqIKPCeuBcI6yq9UC4WBR+h/z3GIvLCEwVQeDrQPF4swCzKo69z6lZnGJMy3HbsQT8IyZvJANTGUxAMb6F+Su2DMSqQtLH2O1Tn+Lbvyy76xi/KwGqcJv/1MDLWKlCxpK0zcU0kl58uexQ4IMfk0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754492626; c=relaxed/simple;
	bh=wdiYcNegFicgzpgADBcjLzFzlcAMVMRfyPUSZVy6GKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o7Qb9B49AJsbf4i6LxBTBd0H7vs5F4iMdJx7gDP8U89VaoHXD4pAG9Vx05z0rol523utya4tUKWshaQJw6+eOc3hfJdW+XOe6+vfuQc1g4iwee+KAuxWk7Mt7d4v8j2vWn+j5sSsWeW49P0F1GWyBd7GrtxenUhqoVB1fzC2pwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WCKKdgV5; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754492624; x=1786028624;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wdiYcNegFicgzpgADBcjLzFzlcAMVMRfyPUSZVy6GKU=;
  b=WCKKdgV561707ysgbzzXDQJ/rT9W3LpUWCT9b9AgllNoKV07VX/A4CSF
   Vxf0z4vp86MlRO561+s+c/jsSiwMH24pPJBUKFdz7ACgPx4gF66PCdvRZ
   nLn4Z+WedqC82MkoJTbuF8i+/Ue4vZ7tTmQ8Yrd+/lROUGbOBkFwKz5Qa
   TOXGTz5iRiOEXDSr0bv3cQl+gFu8M4uazaJZsvjGkTpANPprz9FWTATgM
   9T3N2frteWbFS8K4T5+izl7qoG873q9hDL9bGuaUCKg7m4FTO4+kciCvP
   8gG8jUgO4MFuqvV7UqdTHNPucN9zcjB2xXtvR9z9+eo2Ht0Y87/5a6jTE
   g==;
X-CSE-ConnectionGUID: FbfhpeXMQtu7wrle0TTpAg==
X-CSE-MsgGUID: udWTgBReRVWAlp06nXd45A==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56679710"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="56679710"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 08:03:44 -0700
X-CSE-ConnectionGUID: 5xu9Y3mXSUisgm+r2wso9g==
X-CSE-MsgGUID: Vs+rQt+yRVSaKhOCP5XJuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="164466068"
Received: from kcaccard-desk.amr.corp.intel.com (HELO [10.125.110.154]) ([10.125.110.154])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 08:03:43 -0700
Message-ID: <d646d434-f680-47a3-b6b9-26f4538c1209@intel.com>
Date: Wed, 6 Aug 2025 08:03:42 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Jann Horn <jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Alistair Popple <apopple@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>
Cc: iommu@lists.linux.dev, security@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250806052505.3113108-1-baolu.lu@linux.intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20250806052505.3113108-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/5/25 22:25, Lu Baolu wrote:
> In the IOMMU Shared Virtual Addressing (SVA) context, the IOMMU hardware
> shares and walks the CPU's page tables. The Linux x86 architecture maps
> the kernel address space into the upper portion of every process’s page
> table. Consequently, in an SVA context, the IOMMU hardware can walk and
> cache kernel space mappings. However, the Linux kernel currently lacks
> a notification mechanism for kernel space mapping changes. This means
> the IOMMU driver is not aware of such changes, leading to a break in
> IOMMU cache coherence.

FWIW, I wouldn't use the term "cache coherence" in this context. I'd
probably just call them "stale IOTLB entries".

I also think this over states the problem. There is currently no problem
with "kernel space mapping changes". The issue is solely when kernel
page table pages are freed and reused.

> Modern IOMMUs often cache page table entries of the intermediate-level
> page table as long as the entry is valid, no matter the permissions, to
> optimize walk performance. Currently the iommu driver is notified only
> for changes of user VA mappings, so the IOMMU's internal caches may
> retain stale entries for kernel VA. When kernel page table mappings are
> changed (e.g., by vfree()), but the IOMMU's internal caches retain stale
> entries, Use-After-Free (UAF) vulnerability condition arises.
> 
> If these freed page table pages are reallocated for a different purpose,
> potentially by an attacker, the IOMMU could misinterpret the new data as
> valid page table entries. This allows the IOMMU to walk into attacker-
> controlled memory, leading to arbitrary physical memory DMA access or
> privilege escalation.

Note that it's not just use-after-free. It's literally that the IOMMU
will keep writing Accessed and Dirty bits while it thinks the page is
still a page table. The IOMMU will sit there happily setting bits. So,
it's _write_ after free too.

> To mitigate this, introduce a new iommu interface to flush IOMMU caches.
> This interface should be invoked from architecture-specific code that
> manages combined user and kernel page tables, whenever a kernel page table
> update is done and the CPU TLB needs to be flushed.

There's one tidbit missing from this:

	Currently SVA contexts are all unprivileged. They can only
	access user mappings and never kernel mappings. However, IOMMU
	still walk kernel-only page tables all the way down to the leaf
	where they realize that the entry is a kernel mapping and error
	out.


> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 39f80111e6f1..3b85e7d3ba44 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -12,6 +12,7 @@
>  #include <linux/task_work.h>
>  #include <linux/mmu_notifier.h>
>  #include <linux/mmu_context.h>
> +#include <linux/iommu.h>
>  
>  #include <asm/tlbflush.h>
>  #include <asm/mmu_context.h>
> @@ -1478,6 +1479,8 @@ void flush_tlb_all(void)
>  	else
>  		/* Fall back to the IPI-based invalidation. */
>  		on_each_cpu(do_flush_tlb_all, NULL, 1);
> +
> +	iommu_sva_invalidate_kva_range(0, TLB_FLUSH_ALL);
>  }
>  
>  /* Flush an arbitrarily large range of memory with INVLPGB. */
> @@ -1540,6 +1543,7 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
>  		kernel_tlb_flush_range(info);
>  
>  	put_flush_tlb_info();
> +	iommu_sva_invalidate_kva_range(start, end);
>  }

These desperately need to be commented. They especially need comments
that they are solely for flushing the IOMMU mid-level paging structures
after freeing a page table page.

>  /*
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index 1a51cfd82808..d0da2b3fd64b 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -10,6 +10,8 @@
>  #include "iommu-priv.h"
>  
>  static DEFINE_MUTEX(iommu_sva_lock);
> +static bool iommu_sva_present;
> +static LIST_HEAD(iommu_sva_mms);
>  static struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
>  						   struct mm_struct *mm);
>  
> @@ -42,6 +44,7 @@ static struct iommu_mm_data *iommu_alloc_mm_data(struct mm_struct *mm, struct de
>  		return ERR_PTR(-ENOSPC);
>  	}
>  	iommu_mm->pasid = pasid;
> +	iommu_mm->mm = mm;
>  	INIT_LIST_HEAD(&iommu_mm->sva_domains);
>  	/*
>  	 * Make sure the write to mm->iommu_mm is not reordered in front of
> @@ -132,8 +135,13 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
>  	if (ret)
>  		goto out_free_domain;
>  	domain->users = 1;
> -	list_add(&domain->next, &mm->iommu_mm->sva_domains);
>  
> +	if (list_empty(&iommu_mm->sva_domains)) {
> +		if (list_empty(&iommu_sva_mms))
> +			WRITE_ONCE(iommu_sva_present, true);
> +		list_add(&iommu_mm->mm_list_elm, &iommu_sva_mms);
> +	}
> +	list_add(&domain->next, &iommu_mm->sva_domains);
>  out:
>  	refcount_set(&handle->users, 1);
>  	mutex_unlock(&iommu_sva_lock);
> @@ -175,6 +183,13 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
>  		list_del(&domain->next);
>  		iommu_domain_free(domain);
>  	}
> +
> +	if (list_empty(&iommu_mm->sva_domains)) {
> +		list_del(&iommu_mm->mm_list_elm);
> +		if (list_empty(&iommu_sva_mms))
> +			WRITE_ONCE(iommu_sva_present, false);
> +	}
> +
>  	mutex_unlock(&iommu_sva_lock);
>  	kfree(handle);
>  }
> @@ -312,3 +327,46 @@ static struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
>  
>  	return domain;
>  }
> +
> +struct kva_invalidation_work_data {
> +	struct work_struct work;
> +	unsigned long start;
> +	unsigned long end;
> +};
> +
> +static void invalidate_kva_func(struct work_struct *work)
> +{
> +	struct kva_invalidation_work_data *data =
> +		container_of(work, struct kva_invalidation_work_data, work);
> +	struct iommu_mm_data *iommu_mm;
> +
> +	guard(mutex)(&iommu_sva_lock);
> +	list_for_each_entry(iommu_mm, &iommu_sva_mms, mm_list_elm)
> +		mmu_notifier_arch_invalidate_secondary_tlbs(iommu_mm->mm,
> +				data->start, data->end);
> +
> +	kfree(data);
> +}
> +
> +void iommu_sva_invalidate_kva_range(unsigned long start, unsigned long end)
> +{
> +	struct kva_invalidation_work_data *data;
> +
> +	if (likely(!READ_ONCE(iommu_sva_present)))
> +		return;

It would be nice to hear a few more words about why this is safe without
a lock.

> +	/* will be freed in the task function */
> +	data = kzalloc(sizeof(*data), GFP_ATOMIC);
> +	if (!data)
> +		return;
> +
> +	data->start = start;
> +	data->end = end;
> +	INIT_WORK(&data->work, invalidate_kva_func);
> +
> +	/*
> +	 * Since iommu_sva_mms is an unbound list, iterating it in an atomic
> +	 * context could introduce significant latency issues.
> +	 */
> +	schedule_work(&data->work);
> +}

Hold on a sec, though. the problematic caller of this looks something
like this (logically):

	pmd_free_pte_page()
	{
	        pte = pmd_page_vaddr(*pmd);
	        pmd_clear(pmd);
		flush_tlb_kernel_range(...); // does schedule_work()
		pte_free_kernel(pte);
	}

It _immediately_ frees the PTE page. The schedule_work() work will
probably happen sometime after the page is freed.

Isn't that still a use-after-free? It's for some arbitrary amount of
time and better than before but it's still a use-after-free.

