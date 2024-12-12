Return-Path: <stable+bounces-100897-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 298499EE573
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 12:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED21E188811C
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 11:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD63E2054E8;
	Thu, 12 Dec 2024 11:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BrreSJWm"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BDE1DDA14;
	Thu, 12 Dec 2024 11:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734004252; cv=none; b=HtTuS+w5e4NWj4OXPqjT36HD7+grJIDpsMIuA0865HXxA+2lbQSe+zVwsHo2gSlXBdQEFDbQelYvw7Wagq5VRHBJr7tlWusxY14gTFXr96h44unmutuZTMN+N7pKeU0vezmm1CXvYVz/vS9mfkHN0Uk4cu2yVQM3sSy7ObUO1eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734004252; c=relaxed/simple;
	bh=2/8fmd5VgNpqXW8dgj2xXxLShUyEn/GWqhefyS6zZpE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=g1SUizGhFlzmgq0gphLEYhX4Pff+kvMV6Tv6VEudFwyzuaYmJqldudUz3X4Uh82lYRMeZCgq/ORbMiFqqLB3XNAFQ1NjKl8zkca1MztgcWqtIa8y11uL07vc39qEnPQoYe2a9dqZ0dDREJdx9Y/2i3reTZ2ghg8wFydCTq2imxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BrreSJWm; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734004250; x=1765540250;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2/8fmd5VgNpqXW8dgj2xXxLShUyEn/GWqhefyS6zZpE=;
  b=BrreSJWm/tIG53eKo3nqAvWld83KELsHtUNXp8VpAv4NcNtxeKgdqZWG
   vtZCvjLN05hU13iFHkOFoMv5Yhv68DqC6oxbKQ/YbHCy6NWzPOHUKk8QM
   8koKIISAwyt43eG0D1MF+2MRbMkYUUanqdVO91wl6aGlAFaz6gqmtwRe2
   PH7zp22qS70+amrb8LwGY3SHpS4SYgvbXhrR0IdgVsDS1ZCyOe1R4tqsa
   aG6htvjgo4C7Tu0X83GaDpAom0dB44K9KuBkMk8eOtxPrfPwXeOo+XmEc
   4l1uvBZi9q99KI+DX4Tn8/nZolV5NEkqnsXKdHNn/wVfweJwlrmMpkuzc
   w==;
X-CSE-ConnectionGUID: tnW+HF6TReC0eS1hM8sR7g==
X-CSE-MsgGUID: L99WMWKITyOwIHhvA5gDpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45425350"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="45425350"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 03:50:50 -0800
X-CSE-ConnectionGUID: pCHZ+7xkQRazneLp6duE3w==
X-CSE-MsgGUID: o+ihlf8nT/ydIgQYoL/whA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="96442071"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.241.18]) ([10.124.241.18])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 03:50:46 -0800
Message-ID: <65f58697-3899-41eb-892b-44f66df97876@linux.intel.com>
Date: Thu, 12 Dec 2024 19:50:43 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] iommu/vt-d: Fix kernel NULL pointer dereference in
 cache_tag_flush_range_np()
To: Yi Liu <yi.l.liu@intel.com>, "Duan, Zhenzhong"
 <zhenzhong.duan@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20241212072419.480967-1-zhenzhong.duan@intel.com>
 <760e2a44-299a-4369-a416-ead01d109514@intel.com>
 <SJ0PR11MB6744E3960431FEB30C36DE7A923F2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <c97bdf1b-2f18-4168-8d75-052f6bff4c53@intel.com>
 <SJ0PR11MB6744EF3EB81780C1EA07FB1F923F2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <9a52713b-3a33-4e64-ad8d-8394e9504d75@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <9a52713b-3a33-4e64-ad8d-8394e9504d75@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/12/12 19:00, Yi Liu wrote:
> 
> 
> On 2024/12/12 18:01, Duan, Zhenzhong wrote:
>> Hi Yi,
>>
>>> -----Original Message-----
>>> From: Liu, Yi L <yi.l.liu@intel.com>
>>> Sent: Thursday, December 12, 2024 5:29 PM
>>> Subject: Re: [PATCH] iommu/vt-d: Fix kernel NULL pointer dereference in
>>> cache_tag_flush_range_np()
>>>
>>> On 2024/12/12 16:19, Duan, Zhenzhong wrote:
>>>>
>>>>
>>>>> -----Original Message-----
>>>>> From: Liu, Yi L <yi.l.liu@intel.com>
>>>>> Sent: Thursday, December 12, 2024 3:45 PM
>>>>> Subject: Re: [PATCH] iommu/vt-d: Fix kernel NULL pointer 
>>>>> dereference in
>>>>> cache_tag_flush_range_np()
>>>>>
>>>>> On 2024/12/12 15:24, Zhenzhong Duan wrote:
>>>>>> When setup mapping on an paging domain before the domain is 
>>>>>> attached to
>>>>> any
>>>>>> device, a NULL pointer dereference triggers as below:
>>>>>>
>>>>>>     BUG: kernel NULL pointer dereference, address: 0000000000000200
>>>>>>     #PF: supervisor read access in kernel mode
>>>>>>     #PF: error_code(0x0000) - not-present page
>>>>>>     RIP: 0010:cache_tag_flush_range_np+0x114/0x1f0
>>>>>>     ...
>>>>>>     Call Trace:
>>>>>>      <TASK>
>>>>>>      ? __die+0x20/0x70
>>>>>>      ? page_fault_oops+0x80/0x150
>>>>>>      ? do_user_addr_fault+0x5f/0x670
>>>>>>      ? pfn_to_dma_pte+0xca/0x280
>>>>>>      ? exc_page_fault+0x78/0x170
>>>>>>      ? asm_exc_page_fault+0x22/0x30
>>>>>>      ? cache_tag_flush_range_np+0x114/0x1f0
>>>>>>      intel_iommu_iotlb_sync_map+0x16/0x20
>>>>>>      iommu_map+0x59/0xd0
>>>>>>      batch_to_domain+0x154/0x1e0
>>>>>>      iopt_area_fill_domains+0x106/0x300
>>>>>>      iopt_map_pages+0x1bc/0x290
>>>>>>      iopt_map_user_pages+0xe8/0x1e0
>>>>>>      ? xas_load+0x9/0xb0
>>>>>>      iommufd_ioas_map+0xc9/0x1c0
>>>>>>      iommufd_fops_ioctl+0xff/0x1b0
>>>>>>      __x64_sys_ioctl+0x87/0xc0
>>>>>>      do_syscall_64+0x50/0x110
>>>>>>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>>>>
>>>>>> qi_batch structure is allocated when domain is attached to a 
>>>>>> device for the
>>>>>> first time, when a mapping is setup before that, qi_batch is 
>>>>>> referenced to
>>>>>> do batched flush and trigger above issue.
>>>>>>
>>>>>> Fix it by checking qi_batch pointer and bypass batched flushing if no
>>>>>> device is attached.
>>>>>>
>>>>>> Cc: stable@vger.kernel.org
>>>>>> Fixes: 705c1cdf1e73 ("iommu/vt-d: Introduce batched cache 
>>>>>> invalidation")
>>>>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>>>> ---
>>>>>>     drivers/iommu/intel/cache.c | 2 +-
>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/ 
>>>>>> cache.c
>>>>>> index e5b89f728ad3..bb9dae9a7fba 100644
>>>>>> --- a/drivers/iommu/intel/cache.c
>>>>>> +++ b/drivers/iommu/intel/cache.c
>>>>>> @@ -264,7 +264,7 @@ static unsigned long
>>>>> calculate_psi_aligned_address(unsigned long start,
>>>>>>
>>>>>>     static void qi_batch_flush_descs(struct intel_iommu *iommu, 
>>>>>> struct
>>> qi_batch
>>>>> *batch)
>>>>>>     {
>>>>>> -    if (!iommu || !batch->index)
>>>>>> +    if (!iommu || !batch || !batch->index)
>>>>>
>>>>> this is the same issue in the below link. 🙂 And we should fix it by
>>>>> allocating the qi_batch for parent domains. The nested parent 
>>>>> domains is
>>>>> not going to be attached to device at all. It acts more as a 
>>>>> background
>>>>> domain, so this fix will miss the future cache flushes. It would have
>>>>> bigger problems. 🙂
>>>>>
>>>>> https://lore.kernel.org/linux-iommu/20241210130322.17175-1-
>>>>> yi.l.liu@intel.com/
>>>>
>>>> Ah, just see this😊
>>>> This patch tries to fix an issue that mapping setup on a paging 
>>>> domain before
>>>> it's attached to a device, your patch fixed an issue that nested parent
>>>> domain's qi_batch is not allocated even if nested domain is attached to
>>>> a device. I think they are different issues?
>>>
>>> Oops. I see. I think your case is allocating a hwpt based on an IOAS 
>>> that
>>> already has mappings. When the hwpt is added to it, all the mappings of
>>> this IOAS would be pushing to the hwpt. But the hwpt has not been 
>>> attached
>>> yet, so hit this issue. I remember there is a immediate_attach bool 
>>> to let
>>> iommufd_hwpt_paging_alloc() do an attach before calling
>>> iopt_table_add_domain() which pushes the IOAS mappings to domain.
>>>
>>> One possible fix is to set the immediate_attach to be true. But I 
>>> doubt if
>>> it will be agreed since it was introduced due to some gap on ARM 
>>> side. If
>>> that gap has been resolved, this behavior would go away as well.
>>>
>>> So back to this issue, with this change, the flush would be skipped. It
>>> looks ok to me to skip cache flush for map path. And we should not 
>>> expect
>>> any unmap on this domain since there is no device attached (parent 
>>> domain
>>> is an exception), hence nothing to be flushed even there is unmap in the
>>> domain's IOAS. So it appears to be a acceptable fix. @Baolu, your 
>>> opinion?
>>
>> Hold on, it looks I'm wrong on analyzing related code 
>> qi_batch_flush_descs().
>> The iommu should always be NULL in my suspected case, so
>> qi_batch_flush_descs() will return early without issue.
>>
>> I reproduced the backtrace when playing with iommufd qemu nesting, I 
>> think your
>> previous comment is correct, I misunderstood the root cause of it, 
>> it's indeed
>> due to nesting parent domain not paging domain. Please ignore this patch.
> 
> Great. I also had a try to allocate hwpt with an IOAS that has already got
> a bunch of mappings, it can work as the iommu is null.
> 
> @Baolu, you may ignore this patch as it's already fixed.

Okay, thank you!

