Return-Path: <stable+bounces-169923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA14B29945
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 08:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7140C3AA1DF
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 06:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9966F267F57;
	Mon, 18 Aug 2025 06:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BugMUOrX"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69016194A60;
	Mon, 18 Aug 2025 06:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755496873; cv=none; b=TPJerY6Os1aPBXjSoYw3EKb/HaMO3zDey+ThHOis9VoXyreqzkhrswiRL0W+XUD1EX51O4+eufGkTuTbJqyOfRGhspBpfmcahID64oFkb9jZ4b6rx192nudQmY7l+X4+m+PRuOkzhB/7ZlA/JXdd+9UJ+uEyiN05tPF0K24eDQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755496873; c=relaxed/simple;
	bh=Owzhv78wvzeUNZIC26mOPDcOynSZFk/t10RJOAQzxEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NO4lQClxzlndc2yiWnx3769e5aqwYi90G28Dqdhi597XMkzMHR0bP0a+hQUWIAggvj1pdtnQ3qEM/hIGGucvbuXnN2EAgY7jUXua24BJU6xJV+P8s6SL43WFfVaCPFJoVwmiwWsp0G9eV7Tlyd1xHtqoCyYWSPcVykuGRskQ3Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BugMUOrX; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755496872; x=1787032872;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Owzhv78wvzeUNZIC26mOPDcOynSZFk/t10RJOAQzxEE=;
  b=BugMUOrX3YTdVB3pCgAZlsc5rDpst4r5nd3R4NI0Z0ZuGvAo/sxYzy2/
   K363badT2VGiXjCDKOy7dfOUoLsns5DNPK215btIrPsXF6cq/EVrae7U8
   OgOT18e5yK4WI64U01bVjVCdyXMdf0DZAqnhdOF3oka5ty41/lnhthyGP
   xKyVamze2bkjoXLRC3VuAL9k43sRn7M6VX1Gwjm5uAHNeK1+h8mwpplDF
   JNY4Yd+LAJVqXMwPbb763icJpy8yK74lgjJ7D8qZQvfn4+h/xJrV/5boz
   DeIs19o1cxytS41ehzo5iiKcOfjJPRWvL+GIu7MQWtvMAqLWatFWVJKur
   g==;
X-CSE-ConnectionGUID: p1A2CV18TZO5Ljq6sxXkwg==
X-CSE-MsgGUID: PkCx3wMeSy6bJn2PTo8+Gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="57623545"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="57623545"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2025 23:01:10 -0700
X-CSE-ConnectionGUID: fLM7iKa9QOWQn/vVg6dlbA==
X-CSE-MsgGUID: fwzt4GRcQG6B/+pmyIwEiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="167884111"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2025 23:01:07 -0700
Message-ID: <c534dd05-c1b3-4ed3-bcde-83849d779f32@linux.intel.com>
Date: Mon, 18 Aug 2025 13:58:55 +0800
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
 <3f7a0524-75e1-447f-bdf5-db3f088a0ca9@linux.intel.com>
 <BN9PR11MB52760702D919B524849F08F28C34A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52760702D919B524849F08F28C34A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/15/25 17:46, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Friday, August 15, 2025 5:17 PM
>>
>> On 8/8/2025 10:57 AM, Tian, Kevin wrote:
>>>> From: Jason Gunthorpe <jgg@nvidia.com>
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
>>>>
>>>> Please don't add new usages of lru, we are trying to get rid of this. :(
>>>>
>>>> I think the memory should be struct ptdesc, use that..
>>>>
>>>
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
>> You're right that freeing high-level page table pages also requires an
>> IOTLB flush before the pages are freed. But I question the practical
>> risk of the race given the extremely small time window. If this is a
> 
> It's already extremely difficult to conduct a real attack even w/o this
> fix. I'm not sure the criteria how small we consider acceptable in this
> specific case. but leaving an incomplete fix in code doesn't sound clean...
> 
>> real concern, a potential mitigation would be to clear the U/S bits in
>> all page table entries for kernel address space? But I am not confident
>> in making that change at this time as I am unsure of the side effects it
>> might cause.
> 
> I think there was already consensus that clearing U/S bits in all entries
> doesn't prevent the IOMMU caching them and setting A/D bits on
> the freed pagetable.
> 
>>
>>>
>>> another observation - pte_free_kernel is not used in remove_pagetable ()
>>> and __change_page_attr(). Is it straightforward to put it in those paths
>>> or do we need duplicate some deferring logic there?
>>
>> The remove_pagetable() function is called in the path where memory is
>> hot-removed from the system, right? If so, there should be no issue, as
>> the threat model here is a page table page being freed and repurposed
>> while it's still cached in the IOTLB. In the hot-remove case, the memory
>> is removed and will not be reused, so that's fine as far as I can see.
> 
> what about the page is hot-added back while the stale entry pointing to
> it is still valid in the IOMMU, theoretically? 😊
> 
>>
>> The same to __change_page_attr(), which only changes the attributes of a
>> page table entry while the underlying page remains in use.
>>
> 
> it may lead to cpa_collapse_large_pages() if changing attribute leads to
> all adjacent 4k pages in 2M range are with same attribute. Then page
> table might be freed:
> 
> cpa_collapse_large_pages():
>          list_for_each_entry_safe(ptdesc, tmp, &pgtables, pt_list) {
>                  list_del(&ptdesc->pt_list);
>                  __free_page(ptdesc_page(ptdesc));
>          }

All look fair enough to me. I will handle all the cases and make it
complete.

Thanks,
baolu

