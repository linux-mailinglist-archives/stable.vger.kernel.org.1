Return-Path: <stable+bounces-161470-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF20AFEE15
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 17:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C703D168357
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 15:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B208B2E973E;
	Wed,  9 Jul 2025 15:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oj+7/dOZ"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC08C2E888D;
	Wed,  9 Jul 2025 15:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752076322; cv=none; b=Di8P9fAFtR4iLqzTZqDtpCI/eoLBYGL8auqJ2KOq+f27MNctYcd6J3D2IcYTgUo7J0lc6K6uy0lBb1AaGzDoJ/GVyZehyBBJNqhSP0Bc91FXw8X8IUnW/lBuIhGhH31Od/jApKg0i4/WUpglqotpoXheqxb57RgNh2qM1XsZRaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752076322; c=relaxed/simple;
	bh=3DsDfdqkVv4ziBEj/VU8EFLsz6DVoisR6+XDdFomHgY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ObhZ1notqGKvqSmzKH0PFmz6UQoC10OHPFhHaeSryIFfLeGYtMe7Ifh5t0LUulRapB/9jSeS++HrukZywRdAzrnsKQQMFz1Kff3yb93seAdsjLCyPX+xZBOOHCvFW8CTIwGhkxzYIJjqz7R+Kaw9LaP8B0SqF2kGsWnk+TUH9ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=oj+7/dOZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-0403QTC. (unknown [52.148.138.235])
	by linux.microsoft.com (Postfix) with ESMTPSA id 03C51201B1AB;
	Wed,  9 Jul 2025 08:51:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 03C51201B1AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752076320;
	bh=z9h/G1eX2eJTFIHCs2wISp++Fjv12UbzFJY2WerW6rE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Reply-To:From;
	b=oj+7/dOZdVMG+aRN78QlQwoZDDwcmA+CtpB/jmBDyR4fZTLlJtN4/QTDkxKkGARCb
	 IoRsDMx1V2MB7Zm5s2/8FpbcItosvocFltDI3rJu3I+uvaWXumLlj6zAzbWdpatlFv
	 zLbtlmoabEdXdAuFTurgZIGx08h8cbQUTQKy9Nms=
Date: Wed, 9 Jul 2025 08:51:58 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin
 Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, Jason
 Gunthorpe <jgg@nvidia.com>, Jann Horn <jannh@google.com>, Vasant Hegde
 <vasant.hegde@amd.com>, Dave Hansen <dave.hansen@intel.com>, Alistair
 Popple <apopple@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
 Uladzislau Rezki <urezki@gmail.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>, Andy Lutomirski <luto@kernel.org>,
 iommu@lists.linux.dev, security@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH 1/1] iommu/sva: Invalidate KVA range on kernel TLB flush
Message-ID: <20250709085158.0f050630@DESKTOP-0403QTC.>
In-Reply-To: <20250704133056.4023816-1-baolu.lu@linux.intel.com>
References: <20250704133056.4023816-1-baolu.lu@linux.intel.com>
Reply-To: jacob.pan@linux.microsoft.com
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi BaoLu,

On Fri,  4 Jul 2025 21:30:56 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> The vmalloc() and vfree() functions manage virtually contiguous, but
> not necessarily physically contiguous, kernel memory regions. When
> vfree() unmaps such a region, it tears down the associated kernel
> page table entries and frees the physical pages.
>
> In the IOMMU Shared Virtual Addressing (SVA) context, the IOMMU
> hardware shares and walks the CPU's page tables. Architectures like
> x86 share static kernel address mappings across all user page tables,
> allowing the IOMMU to access the kernel portion of these tables.
Is there a use case where a SVA user can access kernel memory in the
first place? It seems VT-d code does not set supervisor request (SRE)
for the user PASID, I don't see SRE equivalent in AMD IOMMU GCR3 table.
So the PTE U/S bit will prevent kernel memory access, no?

> Modern IOMMUs often cache page table entries to optimize walk
> performance, even for intermediate page table levels. If kernel page
Just wondering if this patch has anything specific to "intermediate page
table", since invalidation hint is always 0 so the intermediate TLBs
are always flushed.

> table mappings are changed (e.g., by vfree()), but the IOMMU's
> internal caches retain stale entries, Use-After-Free (UAF)
> vulnerability condition arises. If these freed page table pages are
> reallocated for a different purpose, potentially by an attacker, the
> IOMMU could misinterpret the new data as valid page table entries.
> This allows the IOMMU to walk into attacker-controlled memory,
> leading to arbitrary physical memory DMA access or privilege
> escalation.
> 
> To mitigate this, introduce a new iommu interface to flush IOMMU
> caches and fence pending page table walks when kernel page mappings
> are updated. This interface should be invoked from
> architecture-specific code that manages combined user and kernel page
> tables.
> 
> Fixes: 26b25a2b98e4 ("iommu: Bind process address spaces to devices")
> Cc: stable@vger.kernel.org
> Co-developed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  arch/x86/mm/tlb.c         |  2 ++
>  drivers/iommu/iommu-sva.c | 32 +++++++++++++++++++++++++++++++-
>  include/linux/iommu.h     |  4 ++++
>  3 files changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 39f80111e6f1..a41499dfdc3f 100644
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
> @@ -1540,6 +1541,7 @@ void flush_tlb_kernel_range(unsigned long
> start, unsigned long end) kernel_tlb_flush_range(info);
>  
>  	put_flush_tlb_info();
> +	iommu_sva_invalidate_kva_range(start, end);
>  }
>  
>  /*
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index 1a51cfd82808..154384eab8a3 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -10,6 +10,8 @@
>  #include "iommu-priv.h"
>  
>  static DEFINE_MUTEX(iommu_sva_lock);
> +static DEFINE_STATIC_KEY_FALSE(iommu_sva_present);
> +static LIST_HEAD(iommu_sva_mms);
>  static struct iommu_domain *iommu_sva_domain_alloc(struct device
> *dev, struct mm_struct *mm);
>  
> @@ -42,6 +44,7 @@ static struct iommu_mm_data
> *iommu_alloc_mm_data(struct mm_struct *mm, struct de return
> ERR_PTR(-ENOSPC); }
>  	iommu_mm->pasid = pasid;
> +	iommu_mm->mm = mm;
>  	INIT_LIST_HEAD(&iommu_mm->sva_domains);
>  	/*
>  	 * Make sure the write to mm->iommu_mm is not reordered in
> front of @@ -132,8 +135,13 @@ struct iommu_sva
> *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm if
> (ret) goto out_free_domain;
>  	domain->users = 1;
> -	list_add(&domain->next, &mm->iommu_mm->sva_domains);
>  
> +	if (list_empty(&iommu_mm->sva_domains)) {
> +		if (list_empty(&iommu_sva_mms))
> +			static_branch_enable(&iommu_sva_present);
> +		list_add(&iommu_mm->mm_list_elm, &iommu_sva_mms);
> +	}
> +	list_add(&domain->next, &iommu_mm->sva_domains);
>  out:
>  	refcount_set(&handle->users, 1);
>  	mutex_unlock(&iommu_sva_lock);
> @@ -175,6 +183,13 @@ void iommu_sva_unbind_device(struct iommu_sva
> *handle) list_del(&domain->next);
>  		iommu_domain_free(domain);
>  	}
> +
> +	if (list_empty(&iommu_mm->sva_domains)) {
> +		list_del(&iommu_mm->mm_list_elm);
> +		if (list_empty(&iommu_sva_mms))
> +			static_branch_disable(&iommu_sva_present);
> +	}
> +
>  	mutex_unlock(&iommu_sva_lock);
>  	kfree(handle);
>  }
> @@ -312,3 +327,18 @@ static struct iommu_domain
> *iommu_sva_domain_alloc(struct device *dev, 
>  	return domain;
>  }
> +
> +void iommu_sva_invalidate_kva_range(unsigned long start, unsigned
> long end) +{
> +	struct iommu_mm_data *iommu_mm;
> +
> +	might_sleep();
> +
> +	if (!static_branch_unlikely(&iommu_sva_present))
> +		return;
> +
> +	guard(mutex)(&iommu_sva_lock);
> +	list_for_each_entry(iommu_mm, &iommu_sva_mms, mm_list_elm)
> +
> mmu_notifier_arch_invalidate_secondary_tlbs(iommu_mm->mm, start,
> end); +} +EXPORT_SYMBOL_GPL(iommu_sva_invalidate_kva_range);
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 156732807994..31330c12b8ee 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -1090,7 +1090,9 @@ struct iommu_sva {
>  
>  struct iommu_mm_data {
>  	u32			pasid;
> +	struct mm_struct	*mm;
>  	struct list_head	sva_domains;
> +	struct list_head	mm_list_elm;
>  };
>  
>  int iommu_fwspec_init(struct device *dev, struct fwnode_handle
> *iommu_fwnode); @@ -1571,6 +1573,7 @@ struct iommu_sva
> *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm);
>  void iommu_sva_unbind_device(struct iommu_sva *handle);
>  u32 iommu_sva_get_pasid(struct iommu_sva *handle);
> +void iommu_sva_invalidate_kva_range(unsigned long start, unsigned
> long end); #else
>  static inline struct iommu_sva *
>  iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
> @@ -1595,6 +1598,7 @@ static inline u32 mm_get_enqcmd_pasid(struct
> mm_struct *mm) }
>  
>  static inline void mm_pasid_drop(struct mm_struct *mm) {}
> +static inline void iommu_sva_invalidate_kva_range(unsigned long
> start, unsigned long end) {} #endif /* CONFIG_IOMMU_SVA */
>  
>  #ifdef CONFIG_IOMMU_IOPF


