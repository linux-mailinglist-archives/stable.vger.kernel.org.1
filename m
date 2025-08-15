Return-Path: <stable+bounces-169709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4527B27CFA
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 11:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3EBD620233
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 09:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD65C253B71;
	Fri, 15 Aug 2025 09:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gylnJGc4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD2B253358;
	Fri, 15 Aug 2025 09:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755249401; cv=none; b=ArsSbXW1OzhjLRu2zY3rh8ICgI7GCBzIPOyzw+B5gfsdjG0XfZsEF/+TNAaiARLHI0VIUwEbHYhJzPby/FWHfqkzSJva7ktOPulDncuEFT2OQMoTduT0RcyOWpFgFTyyrfxjLSLa7shrKrkdS0jQ8F7o0BrhskBfCKR5YfB+PIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755249401; c=relaxed/simple;
	bh=RnALg3zNiXJMXGB95axE2CNi1u5Yu0VmjW8MGBkdvZE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EDn6dZDLm8AlGlw18Cgm26U+C1nUQ0jpfO+PIRwrzJIgcWmNdbWj9KSZqPVD3sHwm1cQiCRHDmI2LVgxZs+Ls0tAXdhn6Zotjf5/tBdR+/zspk2xESpPw1m+gOlRyucrXjy7K8FFY+enNfR55EQUqGYiryiW1xe66FXLTy8ZZbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gylnJGc4; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755249399; x=1786785399;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RnALg3zNiXJMXGB95axE2CNi1u5Yu0VmjW8MGBkdvZE=;
  b=gylnJGc46UXG4ejIlyN4MSkIBoQ/e5QXVnuDddb2LryTJGiy1+UtRj/Y
   8i11j7I+nFWXfCTDCQZnvUDhf1GnGnx71uzpOWoC6v3dsRqdrzSi9/MxL
   LcKNLfiVBk2E3T/R5Fbws4vP+/lO8evWPFOGWN9phe+c40fwEw3iOo3aG
   YqDiX7zAgvNv4+nPIzy+Vj65G0d4LrRDD3DNpURZF1h/Hr5vg0kG1uITm
   ebypeOvmkyNMKBdnFIFjJK3TtPrFe5mfsimxYzMn6POpFTXMW2xjlpeh4
   LVRb+0Vf5r67MxVZLtF5Y2FRnQl4YLBgGd6N/cuY1/c+btRFQMcRPSMo+
   A==;
X-CSE-ConnectionGUID: CfnL4v5uQjKWGzIHbotRXQ==
X-CSE-MsgGUID: brcC6KJrQWms7a83pknSBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="56780912"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="56780912"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 02:16:39 -0700
X-CSE-ConnectionGUID: PTJorfpnQzO0PoBIuqFskA==
X-CSE-MsgGUID: LRywybBFR4ehjrv9KSMe8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="204158562"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.241.96]) ([10.124.241.96])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 02:16:35 -0700
Message-ID: <3f7a0524-75e1-447f-bdf5-db3f088a0ca9@linux.intel.com>
Date: Fri, 15 Aug 2025 17:16:32 +0800
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
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52762A47B347C99F0C0E4C288C2FA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/8/2025 10:57 AM, Tian, Kevin wrote:
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

You're right that freeing high-level page table pages also requires an
IOTLB flush before the pages are freed. But I question the practical
risk of the race given the extremely small time window. If this is a
real concern, a potential mitigation would be to clear the U/S bits in
all page table entries for kernel address space? But I am not confident
in making that change at this time as I am unsure of the side effects it
might cause.

> 
> another observation - pte_free_kernel is not used in remove_pagetable ()
> and __change_page_attr(). Is it straightforward to put it in those paths
> or do we need duplicate some deferring logic there?

The remove_pagetable() function is called in the path where memory is
hot-removed from the system, right? If so, there should be no issue, as
the threat model here is a page table page being freed and repurposed
while it's still cached in the IOTLB. In the hot-remove case, the memory
is removed and will not be reused, so that's fine as far as I can see.

The same to __change_page_attr(), which only changes the attributes of a
page table entry while the underlying page remains in use.

Thanks,
baolu

