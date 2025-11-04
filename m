Return-Path: <stable+bounces-192329-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E618C2F2D8
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 04:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DF912349EA6
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 03:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3215B2980A8;
	Tue,  4 Nov 2025 03:36:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFAC2877D9;
	Tue,  4 Nov 2025 03:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762227382; cv=none; b=NOgKygHQ2BbBxnWoEUfZL+4rSgoa/Iv1Gt0tPYh8tUYy39ouWHz+MiJLXqQZfGTzPVoJwlfUJbn3ALyOef4r//n8k+pIObLuNHGd29p0q+nCj2iorOKlolNLyBUo0XErsVNJQJmBwkl1tKr/xIjZUjSk32QoCei5wxU3AMhm598=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762227382; c=relaxed/simple;
	bh=yWT+oaIy6Zb9pUiGpobZ0cTjAIt5SrcuCSvT/kJOCeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ko3yIHyw9rymvbJgyTaVzWrAlRulhphWfafAkMMepZjgrIq5osA3Hiu9ZO93ID9b99c3dG9cTzThKXg4jHDZ8yqB0bCJXaFnlMlxzk7AC3ZC+Sxp/NcYEq1TGyBfDdPM4neN/34x8iTLOuGsQzfdPLsY+jYKjpE/YEw81LQZPXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3549F1C2B;
	Mon,  3 Nov 2025 19:36:11 -0800 (PST)
Received: from [10.164.136.37] (unknown [10.164.136.37])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02B543F63F;
	Mon,  3 Nov 2025 19:36:15 -0800 (PST)
Message-ID: <f8b899cf-d377-4dc7-a57c-82826ea5e1ea@arm.com>
Date: Tue, 4 Nov 2025 09:06:12 +0530
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
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <f594696b-ba33-4c04-9cf5-e88767221ae0@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 04/11/25 12:15 am, Yang Shi wrote:
>
>
> On 11/3/25 7:16 AM, Will Deacon wrote:
>> On Mon, Nov 03, 2025 at 11:43:06AM +0530, Dev Jain wrote:
>>> Post a166563e7ec3 ("arm64: mm: support large block mapping when 
>>> rodata=full"),
>>> __change_memory_common has a real chance of failing due to split 
>>> failure.
>>> Before that commit, this line was introduced in c55191e96caa, still 
>>> having
>>> a chance of failing if it needs to allocate pagetable memory in
>>> apply_to_page_range, although that has never been observed to be true.
>>> In general, we should always propagate the return value to the caller.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: c55191e96caa ("arm64: mm: apply r/o permissions of VM areas 
>>> to its linear alias as well")
>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>> ---
>>> Based on Linux 6.18-rc4.
>>>
>>>   arch/arm64/mm/pageattr.c | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
>>> index 5135f2d66958..b4ea86cd3a71 100644
>>> --- a/arch/arm64/mm/pageattr.c
>>> +++ b/arch/arm64/mm/pageattr.c
>>> @@ -148,6 +148,7 @@ static int change_memory_common(unsigned long 
>>> addr, int numpages,
>>>       unsigned long size = PAGE_SIZE * numpages;
>>>       unsigned long end = start + size;
>>>       struct vm_struct *area;
>>> +    int ret;
>>>       int i;
>>>         if (!PAGE_ALIGNED(addr)) {
>>> @@ -185,8 +186,10 @@ static int change_memory_common(unsigned long 
>>> addr, int numpages,
>>>       if (rodata_full && (pgprot_val(set_mask) == PTE_RDONLY ||
>>>                   pgprot_val(clear_mask) == PTE_RDONLY)) {
>>>           for (i = 0; i < area->nr_pages; i++) {
>>> - __change_memory_common((u64)page_address(area->pages[i]),
>>> +            ret = 
>>> __change_memory_common((u64)page_address(area->pages[i]),
>>>                              PAGE_SIZE, set_mask, clear_mask);
>>> +            if (ret)
>>> +                return ret;
>> Hmm, this means we can return failure half-way through the operation. Is
>> that something callers are expecting to handle? If so, how can they tell
>> how far we got?
>
> IIUC the callers don't have to know whether it is half-way or not 
> because the callers will change the permission back (e.g. to RW) for 
> the whole range when freeing memory.

Yes, it is the caller's responsibility to set VM_FLUSH_RESET_PERMS flag. 
Upon vfree(), it will change the direct map permissions back to RW.

>
> Thanks,
> Yang
>
>>
>> Will
>

