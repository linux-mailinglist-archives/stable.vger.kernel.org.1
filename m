Return-Path: <stable+bounces-169706-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC1BB27A56
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 09:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CDD67B635F
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 07:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B647288C81;
	Fri, 15 Aug 2025 07:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YI7wFaKc"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34230277818;
	Fri, 15 Aug 2025 07:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755244116; cv=none; b=A5ZLOZ7h40m8EnC0WSSzuA1XGemALqezu+qTooVNDJ6zB0Ribrq2HENZDlZMQTq786L/4Jk3e+bUZhDtr6Bq4/fLTAdP+UZbXTGd3ecRMrXubExNVY+CwahP6yzXHJa8elN+RM/9aonX30OdrNieLEf/ZOnU9YRZ9gEYW+Y43So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755244116; c=relaxed/simple;
	bh=tNF0o99QKcDpQ8fe1vWdc2LTzNFJfqvpB0zorJHYEKI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jJej2a8mTNSRlPVM/fMyRXGPYcHDxeBzq2iUNGWhDlMQ4o3rKOo+Y4ysqMTF9LKzxsfI7ENCTM3zrL3EGOFeWOieCDgD1dWkbY+Ga8tBLwLNQ5p/c1U4KweOIwMh1gn70wxqRYiUPxYq23BtiEEzRhnMUBnE2uWs1CmEYSHJseo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YI7wFaKc; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755244115; x=1786780115;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tNF0o99QKcDpQ8fe1vWdc2LTzNFJfqvpB0zorJHYEKI=;
  b=YI7wFaKc8pDXmh443XJ1Dz8hqLxbRWxZbDJXgyhBq5KYFx7o0ilaFQ8j
   BkD057kZ59Cimst+NmFfgA5dsIo5lo/LLQjph9bQRAi/cWfytqg0l6ild
   DOO+kmWgWNX2VI8E+tjfmD7AXcixAnnVgyjTckse/3yKjsObGUnrONCii
   22QNFYxGamDfbkDwl+hQIQt9vEQ+L7PMeZRBppxhWXwsbFkkeWqQJbGRq
   5G/H/Z06FYB3UuZmS4HXMzair/MFi+h4trMYOoGNwi/jWmF2Gt16KTu5S
   b0vXY+P1Tn2sv6w7RYHIXBTLiIBUZJsHQCmtnb/VgbdRXXrAibmiBN6Xp
   A==;
X-CSE-ConnectionGUID: TCMKPHz9QEKBTdrucWUU1g==
X-CSE-MsgGUID: 93OI3vkPR6iig882xHhLNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="56776141"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="56776141"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 00:48:34 -0700
X-CSE-ConnectionGUID: WNX4u1PESKWAnE7QLwAACg==
X-CSE-MsgGUID: dJi2sKmCT/6pKE79EYStiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="167338723"
Received: from yongfeih-mobl5.ccr.corp.intel.com (HELO [10.124.241.96]) ([10.124.241.96])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 00:48:30 -0700
Message-ID: <206ed579-fba7-4329-a0a1-6bd287b9a54c@linux.intel.com>
Date: Fri, 15 Aug 2025 15:48:28 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev, security@kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
To: Ethan Zhao <etzhao1900@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Jann Horn <jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Dave Hansen <dave.hansen@intel.com>, Alistair Popple <apopple@nvidia.com>,
 Peter Zijlstra <peterz@infradead.org>, Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>
References: <20250806052505.3113108-1-baolu.lu@linux.intel.com>
 <6a61f3af-2d17-4261-8e54-c1117dbc289b@gmail.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <6a61f3af-2d17-4261-8e54-c1117dbc289b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/14/2025 12:48 PM, Ethan Zhao wrote:
> 
> 
> On 8/6/2025 1:25 PM, Lu Baolu wrote:
>> In the IOMMU Shared Virtual Addressing (SVA) context, the IOMMU hardware
>> shares and walks the CPU's page tables. The Linux x86 architecture maps
>> the kernel address space into the upper portion of every process’s page
>> table. Consequently, in an SVA context, the IOMMU hardware can walk and
>> cache kernel space mappings. However, the Linux kernel currently lacks
>> a notification mechanism for kernel space mapping changes. This means
>> the IOMMU driver is not aware of such changes, leading to a break in
>> IOMMU cache coherence.
>>
>> Modern IOMMUs often cache page table entries of the intermediate-level
>> page table as long as the entry is valid, no matter the permissions, to
>> optimize walk performance. Currently the iommu driver is notified only
>> for changes of user VA mappings, so the IOMMU's internal caches may
>> retain stale entries for kernel VA. When kernel page table mappings are
>> changed (e.g., by vfree()), but the IOMMU's internal caches retain stale
>> entries, Use-After-Free (UAF) vulnerability condition arises.
>>
>> If these freed page table pages are reallocated for a different purpose,
>> potentially by an attacker, the IOMMU could misinterpret the new data as
>> valid page table entries. This allows the IOMMU to walk into attacker-
>> controlled memory, leading to arbitrary physical memory DMA access or
>> privilege escalation.
>>
>> To mitigate this, introduce a new iommu interface to flush IOMMU caches.
>> This interface should be invoked from architecture-specific code that
>> manages combined user and kernel page tables, whenever a kernel page 
>> table
>> update is done and the CPU TLB needs to be flushed.
>>
>> Fixes: 26b25a2b98e4 ("iommu: Bind process address spaces to devices")
>> Cc: stable@vger.kernel.org
>> Suggested-by: Jann Horn <jannh@google.com>
>> Co-developed-by: Jason Gunthorpe <jgg@nvidia.com>
>> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
>> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
>> Tested-by: Yi Lai <yi1.lai@intel.com>
>> ---
>>   arch/x86/mm/tlb.c         |  4 +++
>>   drivers/iommu/iommu-sva.c | 60 ++++++++++++++++++++++++++++++++++++++-
>>   include/linux/iommu.h     |  4 +++
>>   3 files changed, 67 insertions(+), 1 deletion(-)
>>
>> Change log:
>> v3:
>>   - iommu_sva_mms is an unbound list; iterating it in an atomic context
>>     could introduce significant latency issues. Schedule it in a kernel
>>     thread and replace the spinlock with a mutex.
>>   - Replace the static key with a normal bool; it can be brought back if
>>     data shows the benefit.
>>   - Invalidate KVA range in the flush_tlb_all() paths.
>>   - All previous reviewed-bys are preserved. Please let me know if there
>>     are any objections.
>>
>> v2:
>>   - https://lore.kernel.org/linux-iommu/20250709062800.651521-1- 
>> baolu.lu@linux.intel.com/
>>   - Remove EXPORT_SYMBOL_GPL(iommu_sva_invalidate_kva_range);
>>   - Replace the mutex with a spinlock to make the interface usable in the
>>     critical regions.
>>
>> v1: https://lore.kernel.org/linux-iommu/20250704133056.4023816-1- 
>> baolu.lu@linux.intel.com/
>>
>> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
>> index 39f80111e6f1..3b85e7d3ba44 100644
>> --- a/arch/x86/mm/tlb.c
>> +++ b/arch/x86/mm/tlb.c
>> @@ -12,6 +12,7 @@
>>   #include <linux/task_work.h>
>>   #include <linux/mmu_notifier.h>
>>   #include <linux/mmu_context.h>
>> +#include <linux/iommu.h>
>>   #include <asm/tlbflush.h>
>>   #include <asm/mmu_context.h>
>> @@ -1478,6 +1479,8 @@ void flush_tlb_all(void)
>>       else
>>           /* Fall back to the IPI-based invalidation. */
>>           on_each_cpu(do_flush_tlb_all, NULL, 1);
>> +
>> +    iommu_sva_invalidate_kva_range(0, TLB_FLUSH_ALL);
> Establishing such a simple one-to-one connection between CPU TLB flush
> and IOMMU TLB flush is debatable. At the very least, not every process
> is attached to an IOMMU SVA domain. Currently, devices and IOMMU 
> operating in scalable mode are not commonly applied to every process.

You're right. As discussed, I'll defer the IOTLB invalidation to a
scheduled kernel work in pte_free_kernel(). The
sva_invalidation_kva_range() function on the IOMMU side is actually a
no-op if there's no SVA domain in use.

Thanks,
baolu

