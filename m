Return-Path: <stable+bounces-194564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B5EC50712
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 04:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5A3A1895D04
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 03:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3BB242D9B;
	Wed, 12 Nov 2025 03:47:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954AACA4B;
	Wed, 12 Nov 2025 03:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762919265; cv=none; b=MWFQHy/wo21d1BnVJenyqG4B8WcAH31WGyjUx4N0rKga8IO2zoKbISN1BxVk+ODurxidT+bxXyM+fo5rEhy19eIowRqvHkg7FdswiIVICxNTl3GcLtVib9s0uLC9yFcuyMJY4rdF/BQJA7AjBHYraoV8qPgx+frzdDAipiJ4CXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762919265; c=relaxed/simple;
	bh=QE3ejo4akh/Drs6MO5L3RaoOCLqO6gVOFN1aUjyEkDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z9yx9oSQpjSNHLW7UMcMiPZet5djX0SwkvVSf/btbPC+pSVAy4g1NsGdLs3TfbpNsgCHC8Kf/1ZPhZBijzNXZxBj1UlD/CvPx+RTnpSt+JdJNKFzZRbKmX22KF6DvpMQN7F/G7lHH8h3+S557LTWsk5gSoe7JfHqx+HICmzI7NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D65901515;
	Tue, 11 Nov 2025 19:47:34 -0800 (PST)
Received: from [10.164.136.35] (unknown [10.164.136.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1CCD3F66E;
	Tue, 11 Nov 2025 19:47:39 -0800 (PST)
Message-ID: <55be2604-e70e-4529-ab2c-7df26dc32e4a@arm.com>
Date: Wed, 12 Nov 2025 09:17:36 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/pageattr: Propagate return value from
 __change_memory_common
To: Yang Shi <yang@os.amperecomputing.com>, Will Deacon <will@kernel.org>
Cc: catalin.marinas@arm.com, ryan.roberts@arm.com, rppt@kernel.org,
 shijie@os.amperecomputing.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251103061306.82034-1-dev.jain@arm.com>
 <aQjHQt2rYL6av4qw@willie-the-truck>
 <f594696b-ba33-4c04-9cf5-e88767221ae0@os.amperecomputing.com>
 <f8b899cf-d377-4dc7-a57c-82826ea5e1ea@arm.com>
 <aQn4EwKar66UZ7rz@willie-the-truck>
 <586b8d19-a5d2-4248-869b-98f39b792acb@arm.com>
 <17eed751-e1c5-4ea5-af1d-e96da16d5e26@arm.com>
 <c1701ce9-c8b7-4ac8-8dd4-930af3dad7d2@os.amperecomputing.com>
 <938fc839-b27a-484f-a49c-6dc05b3e9983@arm.com>
 <94c91f8f-cd8f-4f51-961f-eb2904420ee4@os.amperecomputing.com>
 <47f0fe70-5359-4b98-8a23-c09ab20bd6d9@arm.com>
 <ca628d43-502a-42f1-be57-bcb37103ddf8@os.amperecomputing.com>
 <19def538-3fb6-48a1-ae8b-a82139b8bbb9@arm.com>
 <5cd5fe49-42e9-41b4-8bf1-6b5136c88693@os.amperecomputing.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <5cd5fe49-42e9-41b4-8bf1-6b5136c88693@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/11/25 5:15 am, Yang Shi wrote:
>
>
> On 11/10/25 9:12 PM, Dev Jain wrote:
>>
>> On 11/11/25 10:38 am, Yang Shi wrote:
>>>
>>>
>>> On 11/10/25 8:55 PM, Dev Jain wrote:
>>>>
>>>> On 11/11/25 10:14 am, Yang Shi wrote:
>>>>>
>>>>>
>>>>> On 11/10/25 8:37 PM, Dev Jain wrote:
>>>>>>
>>>>>> On 11/11/25 9:47 am, Yang Shi wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 11/10/25 7:39 PM, Dev Jain wrote:
>>>>>>>>
>>>>>>>> On 05/11/25 9:27 am, Dev Jain wrote:
>>>>>>>>>
>>>>>>>>> On 04/11/25 6:26 pm, Will Deacon wrote:
>>>>>>>>>> On Tue, Nov 04, 2025 at 09:06:12AM +0530, Dev Jain wrote:
>>>>>>>>>>> On 04/11/25 12:15 am, Yang Shi wrote:
>>>>>>>>>>>> On 11/3/25 7:16 AM, Will Deacon wrote:
>>>>>>>>>>>>> On Mon, Nov 03, 2025 at 11:43:06AM +0530, Dev Jain wrote:
>>>>>>>>>>>>>> Post a166563e7ec3 ("arm64: mm: support large block 
>>>>>>>>>>>>>> mapping when
>>>>>>>>>>>>>> rodata=full"),
>>>>>>>>>>>>>> __change_memory_common has a real chance of failing due 
>>>>>>>>>>>>>> to split
>>>>>>>>>>>>>> failure.
>>>>>>>>>>>>>> Before that commit, this line was introduced in 
>>>>>>>>>>>>>> c55191e96caa,
>>>>>>>>>>>>>> still having
>>>>>>>>>>>>>> a chance of failing if it needs to allocate pagetable 
>>>>>>>>>>>>>> memory in
>>>>>>>>>>>>>> apply_to_page_range, although that has never been 
>>>>>>>>>>>>>> observed to be true.
>>>>>>>>>>>>>> In general, we should always propagate the return value 
>>>>>>>>>>>>>> to the caller.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Cc: stable@vger.kernel.org
>>>>>>>>>>>>>> Fixes: c55191e96caa ("arm64: mm: apply r/o permissions of VM
>>>>>>>>>>>>>> areas to its linear alias as well")
>>>>>>>>>>>>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>> Based on Linux 6.18-rc4.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>    arch/arm64/mm/pageattr.c | 5 ++++-
>>>>>>>>>>>>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> diff --git a/arch/arm64/mm/pageattr.c 
>>>>>>>>>>>>>> b/arch/arm64/mm/pageattr.c
>>>>>>>>>>>>>> index 5135f2d66958..b4ea86cd3a71 100644
>>>>>>>>>>>>>> --- a/arch/arm64/mm/pageattr.c
>>>>>>>>>>>>>> +++ b/arch/arm64/mm/pageattr.c
>>>>>>>>>>>>>> @@ -148,6 +148,7 @@ static int change_memory_common(unsigned
>>>>>>>>>>>>>> long addr, int numpages,
>>>>>>>>>>>>>>        unsigned long size = PAGE_SIZE * numpages;
>>>>>>>>>>>>>>        unsigned long end = start + size;
>>>>>>>>>>>>>>        struct vm_struct *area;
>>>>>>>>>>>>>> +    int ret;
>>>>>>>>>>>>>>        int i;
>>>>>>>>>>>>>>          if (!PAGE_ALIGNED(addr)) {
>>>>>>>>>>>>>> @@ -185,8 +186,10 @@ static int 
>>>>>>>>>>>>>> change_memory_common(unsigned
>>>>>>>>>>>>>> long addr, int numpages,
>>>>>>>>>>>>>>        if (rodata_full && (pgprot_val(set_mask) == 
>>>>>>>>>>>>>> PTE_RDONLY ||
>>>>>>>>>>>>>> pgprot_val(clear_mask) == PTE_RDONLY)) {
>>>>>>>>>>>>>>            for (i = 0; i < area->nr_pages; i++) {
>>>>>>>>>>>>>> - __change_memory_common((u64)page_address(area->pages[i]),
>>>>>>>>>>>>>> +            ret =
>>>>>>>>>>>>>> __change_memory_common((u64)page_address(area->pages[i]),
>>>>>>>>>>>>>>                               PAGE_SIZE, set_mask, 
>>>>>>>>>>>>>> clear_mask);
>>>>>>>>>>>>>> +            if (ret)
>>>>>>>>>>>>>> +                return ret;
>>>>>>>>>>>>> Hmm, this means we can return failure half-way through the 
>>>>>>>>>>>>> operation. Is
>>>>>>>>>>>>> that something callers are expecting to handle? If so, how 
>>>>>>>>>>>>> can they tell
>>>>>>>>>>>>> how far we got?
>>>>>>>>>>>> IIUC the callers don't have to know whether it is half-way 
>>>>>>>>>>>> or not
>>>>>>>>>>>> because the callers will change the permission back (e.g. 
>>>>>>>>>>>> to RW) for the
>>>>>>>>>>>> whole range when freeing memory.
>>>>>>>>>>> Yes, it is the caller's responsibility to set 
>>>>>>>>>>> VM_FLUSH_RESET_PERMS flag.
>>>>>>>>>>> Upon vfree(), it will change the direct map permissions back 
>>>>>>>>>>> to RW.
>>>>>>>>>> Ok, but vfree() ends up using update_range_prot() to do that 
>>>>>>>>>> and if we
>>>>>>>>>> need to worry about that failing (as per your commit 
>>>>>>>>>> message), then
>>>>>>>>>> we're in trouble because the calls to set_area_direct_map() 
>>>>>>>>>> are unchecked.
>>>>>>>>>>
>>>>>>>>>> In other words, this patch is either not necessary or it is 
>>>>>>>>>> incomplete.
>>>>>>>>>
>>>>>>>>> Here is the relevant email, in the discussion between Ryan and 
>>>>>>>>> Yang:
>>>>>>>>>
>>>>>>>>> https://lore.kernel.org/all/fe52a1d8-5211-4962-afc8-c3f9caf64119@os.amperecomputing.com/ 
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> We had concluded that all callers of set_memory_ro() or 
>>>>>>>>> set_memory_rox() (which require the
>>>>>>>>> linear map perm change back to default, upon vfree() ) will 
>>>>>>>>> call it for the entire region (vm_struct).
>>>>>>>>> So, when we do the set_direct_map_invalid_noflush, it is 
>>>>>>>>> guaranteed that the region has already
>>>>>>>>> been split. So this call cannot fail.
>>>>>>>>>
>>>>>>>>> https://lore.kernel.org/all/f8898c87-8f49-4ef2-86ae-b60bcf67658c@os.amperecomputing.com/ 
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> This email notes that there is some code doing set_memory_rw() 
>>>>>>>>> and unnecessarily setting the VM_FLUSH_RESET_PERMS
>>>>>>>>> flag, but in that case we don't care about the 
>>>>>>>>> set_direct_map_invalid_noflush call failing because the 
>>>>>>>>> protections
>>>>>>>>> are already RW.
>>>>>>>>>
>>>>>>>>> Although we had also observed that all of this is fragile and 
>>>>>>>>> depends on the caller doing the
>>>>>>>>> correct thing. The real solution should be somehow getting rid 
>>>>>>>>> of the BBM style invalidation.
>>>>>>>>> Ryan had proposed some methods in that email thread.
>>>>>>>>>
>>>>>>>>> One solution which I had thought of, is that, observe that we 
>>>>>>>>> are doing an overkill by
>>>>>>>>> setting the linear map to invalid and then default, for the 
>>>>>>>>> *entire* region. What we
>>>>>>>>> can do is iterate over the linear map alias of the vm_struct 
>>>>>>>>> *area and only change permission
>>>>>>>>> back to RW for the pages which are *not* RW. And, those 
>>>>>>>>> relevant mappings are guaranteed to
>>>>>>>>> be split because they were changed from RW to not RW.
>>>>>>>>
>>>>>>>> @Yang and Ryan,
>>>>>>>>
>>>>>>>> I saw Yang's patch here:
>>>>>>>> https://lore.kernel.org/all/20251023204428.477531-1-yang@os.amperecomputing.com/ 
>>>>>>>>
>>>>>>>> and realized that currently we are splitting away the linear 
>>>>>>>> map alias of the *entire* region.
>>>>>>>>
>>>>>>>> Shouldn't this then imply that set_direct_map_invalid_noflush 
>>>>>>>> will never fail, since even
>>>>>>>>
>>>>>>>> a set_memory_rox() call on a single page will split the linear 
>>>>>>>> map for the entire region,
>>>>>>>>
>>>>>>>> and thus there is no fragility here which we were discussing 
>>>>>>>> about? I may be forgetting
>>>>>>>>
>>>>>>>> something, this linear map stuff is confusing enough already.
>>>>>>>
>>>>>>> It still may fail due to page table allocation failure when 
>>>>>>> doing split. But it is still fine. We may run into 3 cases:
>>>>>>>
>>>>>>> 1. set_memory_rox succeed to split the whole range, then 
>>>>>>> set_direct_map_invalid_noflush() will succeed too
>>>>>>> 2. set_memory_rox fails to split, for example, just change 
>>>>>>> partial range permission due to page table allocation failure, 
>>>>>>> then set_direct_map_invalid_noflush() may
>>>>>>>    a. successfully change the permission back to default till 
>>>>>>> where set_memory_rox fails at since that range has been 
>>>>>>> successfully split. It is ok since the remaining range is 
>>>>>>> actually not changed to ro by set_memory_rox at all
>>>>>>>    b. successfully change the permission back to default for the 
>>>>>>> whole range (for example, memory pressure is mitigated when 
>>>>>>> set_direct_map_invalid_noflush() is called). It is definitely 
>>>>>>> fine as well
>>>>>>
>>>>>> Correct, what I mean to imply here is that, your patch will break 
>>>>>> this? If set_memory_* is applied on x till y, your patch changes 
>>>>>> the linear map alias
>>>>>>
>>>>>> only from x till y - set_direct_map_invalid_noflush instead 
>>>>>> operates on 0 till size - 1, where 0 <=x <=y <= size - 1. So, it 
>>>>>> may encounter a -ENOMEM
>>>>>>
>>>>>> on [0, x) range while invalidating, and that is *not* okay 
>>>>>> because we must reset back [0, x) to default?
>>>>>
>>>>> I see your point now. But I think the callers need to guarantee 
>>>>> they call set_memory_rox and set_direct_map_invalid_noflush on the 
>>>>> same range, right? Currently kernel just calls them on the whole 
>>>>> area.
>>>>
>>>> Nope. The fact that the kernel changes protections, and undoes the 
>>>> changed protections, on the *entire* alias of the vm_struct region, 
>>>> protects us from the fragility we were talking about earlier.
>>>
>>> This is what I meant "kernel just calls them on the whole area".
>>>
>>>>
>>>> Suppose you have a range from 0 till size - 1, and you call 
>>>> set_memory_* on a random point (page) p. The argument we discussed 
>>>> above is independent of p, which lets us drop our
>>>>
>>>> previous erroneous conclusion that all of this works because no 
>>>> caller does a partial set_memory_*.
>>>
>>> Sorry I don't follow you. What "erroneous conclusion" do you mean? 
>>> You can call set_memory_* on a random point, but 
>>> set_direct_map_invalid_noflush() should be called on the random 
>>> point too. The current code of set_area_direct_map() doesn't 
>>> consider this case because there is no such call. Is this what you 
>>> meant?
>>
>>
>> I was referring to the discussion in the linear map work - I think we 
>> had concluded that we don't need to worry about the BBM style 
>> invalidation failing, *because* no one does a partial set_memory_*.
>
> Yes, we don't have to worry about it.
>
>>
>> What I am saying - we don't care whether caller does a partial or a 
>> full set_memory_*, we are still safe, because the linear map alias 
>> change on both sides (set_memory_* -> __change_memory_common, and 
>> vm_reset_perms -> set_area_direct_map() )
>>
>> operate on the entire region.
>
> Yes, this is the current behavior. My patch changes 
> change_memory_common() to just do permission update for the requested 
> range from the callers instead of assuming change the entire region, 
> although there is no one calls set_memory_* on a partial range. Shall 
> set_area_direct_map() be aware of potential partial range change from 
> set_memory_*()? Maybe. But it is just called from vfree() which just 
> free the entire region.
>
> What happened if someone does something crazy, for example, call 
> set_memory_* on a partial range, then call vfree? IIUC, it is fine as 
> well. It is still covered by the 3 cases that I mentioned in the 
> previous email if I don't miss anything, right?

Assuming the caller also does set_vm_flush_reset_perms(), the 3 cases 
will work out.


>
> Thanks,
> Yang
>
>>
>>
>>>
>>>>
>>>>
>>>> I would like to send a patch clearly documenting this behaviour, 
>>>> assuming no one else finds a hole in this reasoning.
>>>
>>> Proper comment to explain the subtle behavior is definitely welcome.
>>>
>>> Thanks,
>>> Yang
>>>
>>>>
>>>>
>>>>>
>>>>> Thanks,
>>>>> Yang
>>>>>
>>>>>>
>>>>>>
>>>>>>>
>>>>>>> Hopefully I don't miss anything.
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Yang
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Will
>>>>>>>>>
>>>>>>>
>>>>>
>>>
>

