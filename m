Return-Path: <stable+bounces-192386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A6DC31365
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 14:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24529189A25F
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 13:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819D6320CD5;
	Tue,  4 Nov 2025 13:22:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D88F2F691B;
	Tue,  4 Nov 2025 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762262577; cv=none; b=p5wvNTWY18mB5yPzNzfddO6vZKAofyZ+VgOX7JSraTq8VKpQ49zO8HGfJSlTqqUiHLmSO8s9vNmzW8bhgF14s2tyEFlhBORDA5joV/qhYQnPGnY2PHrnQFnIS8LUKdJ7Kn/POTzx9EZuQ6hKVfmf3XfB0wchTiuGDIRYumXalCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762262577; c=relaxed/simple;
	bh=w1EXmzaomt43Vs7KKsVgrSwxeKJ4lAKIlz7ba/TQnoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TfGi8IPEhrlPk9tfJTqoPRaEyHG6LzQyUYXLvT+9qr3/719QciST2wIoL318YPGDfOcVH0aEFy/ube4IF3iTL1r0uzLLTHu5gCtfgfYuw4v5bBdMBYshk4IceRDcHFb5r2vL5ThG/GIo2p5wAl7tH8Osgylcxa/hADF0cPp55NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B4EB1CE0;
	Tue,  4 Nov 2025 05:22:47 -0800 (PST)
Received: from [10.164.18.64] (unknown [10.164.18.64])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 225613F66E;
	Tue,  4 Nov 2025 05:22:51 -0800 (PST)
Message-ID: <9f55664b-c510-4565-943b-0bed2d43898d@arm.com>
Date: Tue, 4 Nov 2025 18:52:49 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/pageattr: Propagate return value from
 __change_memory_common
To: Will Deacon <will@kernel.org>
Cc: Yang Shi <yang@os.amperecomputing.com>, catalin.marinas@arm.com,
 ryan.roberts@arm.com, rppt@kernel.org, shijie@os.amperecomputing.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20251103061306.82034-1-dev.jain@arm.com>
 <aQjHQt2rYL6av4qw@willie-the-truck>
 <f594696b-ba33-4c04-9cf5-e88767221ae0@os.amperecomputing.com>
 <f8b899cf-d377-4dc7-a57c-82826ea5e1ea@arm.com>
 <aQn4EwKar66UZ7rz@willie-the-truck>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <aQn4EwKar66UZ7rz@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 04/11/25 6:26 pm, Will Deacon wrote:
> On Tue, Nov 04, 2025 at 09:06:12AM +0530, Dev Jain wrote:
>> On 04/11/25 12:15 am, Yang Shi wrote:
>>> On 11/3/25 7:16 AM, Will Deacon wrote:
>>>> On Mon, Nov 03, 2025 at 11:43:06AM +0530, Dev Jain wrote:
>>>>> Post a166563e7ec3 ("arm64: mm: support large block mapping when
>>>>> rodata=full"),
>>>>> __change_memory_common has a real chance of failing due to split
>>>>> failure.
>>>>> Before that commit, this line was introduced in c55191e96caa,
>>>>> still having
>>>>> a chance of failing if it needs to allocate pagetable memory in
>>>>> apply_to_page_range, although that has never been observed to be true.
>>>>> In general, we should always propagate the return value to the caller.
>>>>>
>>>>> Cc: stable@vger.kernel.org
>>>>> Fixes: c55191e96caa ("arm64: mm: apply r/o permissions of VM
>>>>> areas to its linear alias as well")
>>>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>>>> ---
>>>>> Based on Linux 6.18-rc4.
>>>>>
>>>>>    arch/arm64/mm/pageattr.c | 5 ++++-
>>>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
>>>>> index 5135f2d66958..b4ea86cd3a71 100644
>>>>> --- a/arch/arm64/mm/pageattr.c
>>>>> +++ b/arch/arm64/mm/pageattr.c
>>>>> @@ -148,6 +148,7 @@ static int change_memory_common(unsigned
>>>>> long addr, int numpages,
>>>>>        unsigned long size = PAGE_SIZE * numpages;
>>>>>        unsigned long end = start + size;
>>>>>        struct vm_struct *area;
>>>>> +    int ret;
>>>>>        int i;
>>>>>          if (!PAGE_ALIGNED(addr)) {
>>>>> @@ -185,8 +186,10 @@ static int change_memory_common(unsigned
>>>>> long addr, int numpages,
>>>>>        if (rodata_full && (pgprot_val(set_mask) == PTE_RDONLY ||
>>>>>                    pgprot_val(clear_mask) == PTE_RDONLY)) {
>>>>>            for (i = 0; i < area->nr_pages; i++) {
>>>>> - __change_memory_common((u64)page_address(area->pages[i]),
>>>>> +            ret =
>>>>> __change_memory_common((u64)page_address(area->pages[i]),
>>>>>                               PAGE_SIZE, set_mask, clear_mask);
>>>>> +            if (ret)
>>>>> +                return ret;
>>>> Hmm, this means we can return failure half-way through the operation. Is
>>>> that something callers are expecting to handle? If so, how can they tell
>>>> how far we got?
>>> IIUC the callers don't have to know whether it is half-way or not
>>> because the callers will change the permission back (e.g. to RW) for the
>>> whole range when freeing memory.
>> Yes, it is the caller's responsibility to set VM_FLUSH_RESET_PERMS flag.
>> Upon vfree(), it will change the direct map permissions back to RW.
> Ok, but vfree() ends up using update_range_prot() to do that and if we
> need to worry about that failing (as per your commit message), then
> we're in trouble because the calls to set_area_direct_map() are unchecked.
>
> In other words, this patch is either not necessary or it is incomplete.

I think we had concluded in the discussion of the linear map series that those
calls will always succeed - I'll refresh my memory on that and get back to you later!

>
> Will

