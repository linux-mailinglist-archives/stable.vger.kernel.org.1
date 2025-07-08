Return-Path: <stable+bounces-160444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3798BAFC239
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 07:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCB177A2639
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 05:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502A621771B;
	Tue,  8 Jul 2025 05:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mjn+8cyZ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4175A1F63F9;
	Tue,  8 Jul 2025 05:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751953477; cv=none; b=WnP1ncN+/vDzdSlNJXGgpa3vHeryObIgPXFrUzkqzyY1NWJm5DoDpjPr7vJhiFlpnGclFkjuivYP1IiFAcdx9opGyc/AqNyQ65ACv0HqDOigIvZLDzDche2SGJzNJwWDXtanlWBgMfzGJOkAAfy8mn0+Bhq3ogjXZF5gRTZ6lTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751953477; c=relaxed/simple;
	bh=2MSzcLmjrDyb+tddwM6V/FNq8UQtXCxqT8+XY/RoWAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SWfecpuyzG5s+D91u/ZiambBmYZJswAob0rbMAZY2IRLrz7FPGGKJ4KCbla+yx3JzWD5YsUze9hH+DWmR4iA7FnMy6snxDLjVQntMe3PyuVE3lPj2KncVKthyqISagbNv9ksLTgquTfFRJuyrJNHOtKGLCIdyVvt8BW0kzBKcWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mjn+8cyZ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751953475; x=1783489475;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2MSzcLmjrDyb+tddwM6V/FNq8UQtXCxqT8+XY/RoWAc=;
  b=mjn+8cyZ2HMqKy8cN7kt/yxGUscM0d2CE/K3N7anbeMIYxYJ13UsAvOv
   uCxz1vfqUGzWGoI0uSNndV0c0sDpTmuoI3gtihiDdJf6xM29DGF1yDwVj
   ZMuqXfV/mYn/hggeU6BJaed3+NN9UiTO3UsYbKfih5HSLxjrQMPcmI9Lt
   WfP4BfzMUqi6lxFYfIOgfGCj9jm2m2X55a05LwpUXKO1wEwqZ9mIStBvS
   YkYqYHwhPgSXeBC+0oT+pA7osQbc0w4a35QL1GqylExW0RoL2xwMtyxLp
   cI5Z5ey/VQbu+xzx8fVB3/FsShcQ96EWtZ1m4tKXZehAhvnhxUYDo8ycc
   A==;
X-CSE-ConnectionGUID: eGobbhZhQnizdkZTOies9Q==
X-CSE-MsgGUID: ZeeFFtm3TUW2Z+bE8zrzKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="79612979"
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; 
   d="scan'208";a="79612979"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 22:44:34 -0700
X-CSE-ConnectionGUID: L/RW08drRfyq5qChP0o7HA==
X-CSE-MsgGUID: ULmZc5CCTfavzTnUQNBpww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; 
   d="scan'208";a="186428000"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 22:44:30 -0700
Message-ID: <0c6f6b3e-d68d-4deb-963e-6074944afff7@linux.intel.com>
Date: Tue, 8 Jul 2025 13:42:53 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/sva: Invalidate KVA range on kernel TLB flush
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Jann Horn <jannh@google.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Dave Hansen <dave.hansen@intel.com>,
 Alistair Popple <apopple@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>
Cc: iommu@lists.linux.dev, security@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250704133056.4023816-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250704133056.4023816-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/4/25 21:30, Lu Baolu wrote:
> The vmalloc() and vfree() functions manage virtually contiguous, but not
> necessarily physically contiguous, kernel memory regions. When vfree()
> unmaps such a region, it tears down the associated kernel page table
> entries and frees the physical pages.
> 
> In the IOMMU Shared Virtual Addressing (SVA) context, the IOMMU hardware
> shares and walks the CPU's page tables. Architectures like x86 share
> static kernel address mappings across all user page tables, allowing the
> IOMMU to access the kernel portion of these tables.
> 
> Modern IOMMUs often cache page table entries to optimize walk performance,
> even for intermediate page table levels. If kernel page table mappings are
> changed (e.g., by vfree()), but the IOMMU's internal caches retain stale
> entries, Use-After-Free (UAF) vulnerability condition arises. If these
> freed page table pages are reallocated for a different purpose, potentially
> by an attacker, the IOMMU could misinterpret the new data as valid page
> table entries. This allows the IOMMU to walk into attacker-controlled
> memory, leading to arbitrary physical memory DMA access or privilege
> escalation.
> 
> To mitigate this, introduce a new iommu interface to flush IOMMU caches
> and fence pending page table walks when kernel page mappings are updated.
> This interface should be invoked from architecture-specific code that
> manages combined user and kernel page tables.
> 
> Fixes: 26b25a2b98e4 ("iommu: Bind process address spaces to devices")
> Cc:stable@vger.kernel.org
> Co-developed-by: Jason Gunthorpe<jgg@nvidia.com>
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>
> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> ---
>   arch/x86/mm/tlb.c         |  2 ++
>   drivers/iommu/iommu-sva.c | 32 +++++++++++++++++++++++++++++++-
>   include/linux/iommu.h     |  4 ++++
>   3 files changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 39f80111e6f1..a41499dfdc3f 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -12,6 +12,7 @@
>   #include <linux/task_work.h>
>   #include <linux/mmu_notifier.h>
>   #include <linux/mmu_context.h>
> +#include <linux/iommu.h>
>   
>   #include <asm/tlbflush.h>
>   #include <asm/mmu_context.h>
> @@ -1540,6 +1541,7 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
>   		kernel_tlb_flush_range(info);
>   
>   	put_flush_tlb_info();
> +	iommu_sva_invalidate_kva_range(start, end);
>   }
>   
>   /*
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index 1a51cfd82808..154384eab8a3 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -10,6 +10,8 @@
>   #include "iommu-priv.h"
>   
>   static DEFINE_MUTEX(iommu_sva_lock);
> +static DEFINE_STATIC_KEY_FALSE(iommu_sva_present);
> +static LIST_HEAD(iommu_sva_mms);
>   static struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
>   						   struct mm_struct *mm);
>   
> @@ -42,6 +44,7 @@ static struct iommu_mm_data *iommu_alloc_mm_data(struct mm_struct *mm, struct de
>   		return ERR_PTR(-ENOSPC);
>   	}
>   	iommu_mm->pasid = pasid;
> +	iommu_mm->mm = mm;
>   	INIT_LIST_HEAD(&iommu_mm->sva_domains);
>   	/*
>   	 * Make sure the write to mm->iommu_mm is not reordered in front of
> @@ -132,8 +135,13 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
>   	if (ret)
>   		goto out_free_domain;
>   	domain->users = 1;
> -	list_add(&domain->next, &mm->iommu_mm->sva_domains);
>   
> +	if (list_empty(&iommu_mm->sva_domains)) {
> +		if (list_empty(&iommu_sva_mms))
> +			static_branch_enable(&iommu_sva_present);
> +		list_add(&iommu_mm->mm_list_elm, &iommu_sva_mms);
> +	}
> +	list_add(&domain->next, &iommu_mm->sva_domains);
>   out:
>   	refcount_set(&handle->users, 1);
>   	mutex_unlock(&iommu_sva_lock);
> @@ -175,6 +183,13 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
>   		list_del(&domain->next);
>   		iommu_domain_free(domain);
>   	}
> +
> +	if (list_empty(&iommu_mm->sva_domains)) {
> +		list_del(&iommu_mm->mm_list_elm);
> +		if (list_empty(&iommu_sva_mms))
> +			static_branch_disable(&iommu_sva_present);
> +	}
> +
>   	mutex_unlock(&iommu_sva_lock);
>   	kfree(handle);
>   }
> @@ -312,3 +327,18 @@ static struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
>   
>   	return domain;
>   }
> +
> +void iommu_sva_invalidate_kva_range(unsigned long start, unsigned long end)
> +{
> +	struct iommu_mm_data *iommu_mm;
> +
> +	might_sleep();

Yi Lai <yi1.lai@intel.com> reported an issue here. This interface could
potentially be called in a non-sleepable context.

[    4.605633] BUG: sleeping function called from invalid context at 
drivers/iommu/iommu-sva.c:335
[    4.606433] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1, 
name: swapper/0
[    4.606975] preempt_count: 1, expected: 0
[    4.607210] RCU nest depth: 0, expected: 0
[    4.607467] 1 lock held by swapper/0/1:
[    4.607773]  #0: ffffffff8743b5c8 (vmap_purge_lock){+.+.}-{4:4}, at: 
_vm_unmap_aliases+0xcd/0x800
[    4.608304] Preemption disabled at:
[    4.608308] [<ffffffff81413f2a>] flush_tlb_kernel_range+0x2a/0x420
[    4.608841] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 
6.16.0-rc5-e864c1d7585d+ #1 PREEMPT(voluntary)
[    4.608851] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[    4.608856] Call Trace:
[    4.608862]  <TASK>
[    4.608867]  dump_stack_lvl+0x121/0x150
[    4.608887]  dump_stack+0x19/0x20
[    4.608894]  __might_resched+0x37b/0x5a0
[    4.608910]  __might_sleep+0xa3/0x170
[    4.608919]  iommu_sva_invalidate_kva_range+0x32/0x140
[    4.608939]  flush_tlb_kernel_range+0x2d1/0x420
[    4.608951]  __purge_vmap_area_lazy+0x5ae/0xc60
[    4.608964]  _vm_unmap_aliases+0x653/0x800
[    4.608973]  ? kmemdup_noprof+0x37/0x70
[    4.608985]  ? __pfx__vm_unmap_aliases+0x10/0x10
[    4.608992]  ? ret_from_fork_asm+0x1a/0x30
[    4.609004]  ? __free_frozen_pages+0x493/0x1000
[    4.609014]  ? __free_frozen_pages+0x493/0x1000
[    4.609025]  vm_unmap_aliases+0x22/0x30
[    4.609032]  change_page_attr_set_clr+0x272/0x4c0
[    4.609046]  ? __pfx_change_page_attr_set_clr+0x10/0x10
[    4.609059]  ? __this_cpu_preempt_check+0x21/0x30
[    4.609078]  ? kasan_save_track+0x18/0x40
[    4.609099]  set_memory_nx+0xbd/0x110
[    4.609115]  ? __pfx_set_memory_nx+0x10/0x10
[    4.609128]  free_init_pages+0x82/0xd0
[    4.609137]  ? __pfx_kernel_init+0x10/0x10
[    4.609148]  mem_encrypt_free_decrypted_mem+0x4e/0x70
[    4.609173]  free_initmem+0x1c/0x40
[    4.609179]  kernel_init+0x4a/0x2f0
[    4.609190]  ret_from_fork+0x38e/0x490
[    4.609201]  ? __pfx_kernel_init+0x10/0x10
[    4.609212]  ret_from_fork_asm+0x1a/0x30
[    4.609227]  </TASK>


So we might need a spinlock to protect the sva mm_struct list? An
additional change like this:

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index f6fe250d12e5..d503dd95e4e5 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -12,6 +12,7 @@
  static DEFINE_MUTEX(iommu_sva_lock);
  static DEFINE_STATIC_KEY_FALSE(iommu_sva_present);
  static LIST_HEAD(iommu_sva_mms);
+static DEFINE_SPINLOCK(iommu_mms_lock);
  static struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
  						   struct mm_struct *mm);

@@ -137,9 +138,11 @@ struct iommu_sva *iommu_sva_bind_device(struct 
device *dev, struct mm_struct *mm
  	domain->users = 1;

  	if (list_empty(&iommu_mm->sva_domains)) {
+		spin_lock(&iommu_mms_lock);
  		if (list_empty(&iommu_sva_mms))
  			static_branch_enable(&iommu_sva_present);
  		list_add(&iommu_mm->mm_list_elm, &iommu_sva_mms);
+		spin_unlock(&iommu_mms_lock);
  	}
  	list_add(&domain->next, &iommu_mm->sva_domains);
  out:
@@ -185,9 +188,11 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
  	}

  	if (list_empty(&iommu_mm->sva_domains)) {
+		spin_lock(&iommu_mms_lock);
  		list_del(&iommu_mm->mm_list_elm);
  		if (list_empty(&iommu_sva_mms))
  			static_branch_disable(&iommu_sva_present);
+		spin_unlock(&iommu_mms_lock);
  	}

  	mutex_unlock(&iommu_sva_lock);
@@ -332,12 +337,10 @@ void iommu_sva_invalidate_kva_range(unsigned long 
start, unsigned long end)
  {
  	struct iommu_mm_data *iommu_mm;

-	might_sleep();
-
  	if (!static_branch_unlikely(&iommu_sva_present))
  		return;

-	guard(mutex)(&iommu_sva_lock);
+	guard(spinlock)(&iommu_mms_lock);
  	list_for_each_entry(iommu_mm, &iommu_sva_mms, mm_list_elm)
  		mmu_notifier_arch_invalidate_secondary_tlbs(iommu_mm->mm, start, end);
  }
-- 
2.43.0

> +
> +	if (!static_branch_unlikely(&iommu_sva_present))
> +		return;
> +
> +	guard(mutex)(&iommu_sva_lock);
> +	list_for_each_entry(iommu_mm, &iommu_sva_mms, mm_list_elm)
> +		mmu_notifier_arch_invalidate_secondary_tlbs(iommu_mm->mm, start, end);
> +}

Thanks,
baolu

