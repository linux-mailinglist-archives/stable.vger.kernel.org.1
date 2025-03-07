Return-Path: <stable+bounces-121396-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B630EA56A75
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 15:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2D021897BEE
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 14:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D353021B8F5;
	Fri,  7 Mar 2025 14:35:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EE518DF65;
	Fri,  7 Mar 2025 14:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741358120; cv=none; b=raYMGwcf9yMxtD+zEx4Djxqjp0ki3/2e/w8bjbptvoRYqgp3R7YINuNE2xX8SZAzzGXmVJAyDxYuygJgBiNBL1cO/cKgrxYgMq8AKteSjFcIqQ6IZSyzCdFqCTE+wveaGOapqluippbE/JeDsxtlq/4pY4QqfKvUXkl9/ZB16+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741358120; c=relaxed/simple;
	bh=7Vf0Y705dKsymaGrvDkZTnEO2pehEA545N3LsrhjSUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JXJHO8RTw3FoB50CZ8SQaz4C5VC9wqku3u0tOjZE2g4dihjxQSCSXIJr3OBElrso2mx65uJexKAcmlDSkma5+1HnKSJ+2+wohz8jHZ4NV+UCvpR19HRCixpqD1zS3iixUU3tJqx9sYkAbcELpOa3pqfCbX+hogGoZkL5igp+j5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 845D01424;
	Fri,  7 Mar 2025 06:35:27 -0800 (PST)
Received: from [10.57.84.99] (unknown [10.57.84.99])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0082E3F66E;
	Fri,  7 Mar 2025 06:35:13 -0800 (PST)
Message-ID: <2308a4d0-273e-4cf8-9c9f-3008c42b6d18@arm.com>
Date: Fri, 7 Mar 2025 14:35:12 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/madvise: Always set ptes via arch helpers
Content-Language: en-GB
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250307123307.262298-1-ryan.roberts@arm.com>
 <dbdeb4d7-f7b9-4b10-ada3-c2d37e915f6d@lucifer.local>
 <03997253-0717-4ecb-8ac8-4a7ba49481a3@arm.com>
 <3653c47f-f21a-493e-bcc4-956b99b6c501@lucifer.local>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <3653c47f-f21a-493e-bcc4-956b99b6c501@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/03/2025 13:59, Lorenzo Stoakes wrote:
> On Fri, Mar 07, 2025 at 01:42:13PM +0000, Ryan Roberts wrote:
>> On 07/03/2025 13:04, Lorenzo Stoakes wrote:
>>> On Fri, Mar 07, 2025 at 12:33:06PM +0000, Ryan Roberts wrote:
>>>> Instead of writing a pte directly into the table, use the set_pte_at()
>>>> helper, which gives the arch visibility of the change.
>>>>
>>>> In this instance we are guaranteed that the pte was originally none and
>>>> is being modified to a not-present pte, so there was unlikely to be a
>>>> bug in practice (at least not on arm64). But it's bad practice to write
>>>> the page table memory directly without arch involvement.
>>>>
>>>> Cc: <stable@vger.kernel.org>
>>>> Fixes: 662df3e5c376 ("mm: madvise: implement lightweight guard page mechanism")
>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>> ---
>>>>  mm/madvise.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/madvise.c b/mm/madvise.c
>>>> index 388dc289b5d1..6170f4acc14f 100644
>>>> --- a/mm/madvise.c
>>>> +++ b/mm/madvise.c
>>>> @@ -1101,7 +1101,7 @@ static int guard_install_set_pte(unsigned long addr, unsigned long next,
>>>>  	unsigned long *nr_pages = (unsigned long *)walk->private;
>>>>
>>>>  	/* Simply install a PTE marker, this causes segfault on access. */
>>>> -	*ptep = make_pte_marker(PTE_MARKER_GUARD);
>>>> +	set_pte_at(walk->mm, addr, ptep, make_pte_marker(PTE_MARKER_GUARD));
>>>
>>> I agree with you, but I think perhaps the arg name here is misleading :) If
>>> you look at mm/pagewalk.c and specifically, in walk_pte_range_inner():
>>>
>>> 		if (ops->install_pte && pte_none(ptep_get(pte))) {
>>> 			pte_t new_pte;
>>>
>>> 			err = ops->install_pte(addr, addr + PAGE_SIZE, &new_pte,
>>> 					       walk);
>>> 			if (err)
>>> 				break;
>>>
>>> 			set_pte_at(walk->mm, addr, pte, new_pte);
>>>
>>> 			...
>>> 		}
>>>
>>> So the ptep being assigned here is a stack value, new_pte, which we simply
>>> assign to, and _then_ the page walker code handles the set_pte_at() for us.
>>>
>>> So we are indeed doing the right thing here, just in a different place :P
>>
>> Ahh my bad. In that case, please ignore the patch.
>>
>> But out of interest, why are you doing it like this? I find it a bit confusing
>> as all the other ops (e.g. pte_entry()) work directly on the pgtable's pte
>> without the intermediate.
> 
> In those cases it's read-only, the data's already there, you can just go ahead
> and manipulate it (and would expect to be able to do so).

It's certainly not read-only in general. Just having a quick look to verify, the
very first callback I landed on was clear_refs_pte_range(), which implements
.pmd_entry to clear the softdirty and access flags from a leaf pmd or from all
the child ptes.

> 
> When setting things are a little different, I'd rather not open up things to a
> user being able to do *whatever*, but rather limit to the smallest scope
> possible for installing the PTE.

Understandable, but personally I think it will lead to potential misunderstandings:

 - it will get copy/pasted as an example of how to set a pte (which is wrong;
you have to use set_pte_at()/set_ptes()). There is currently only a single other
case of direct dereferencing a pte to set it (in write_protect_page()).

 - new users of .install_pte may assume (like I did) that the passed in ptep is
pointing to the pgtable and they will manipulate it with arch helpers. arm64
arch helpers all assume they are only ever passed pointers into pgtable memory.
It will end horribly if that is not the case.

> 
> And also of course, it allows us to _mandate_ that set_pte_at() is used so we do
> the right thing re: arches :)
> 
> I could have named the parameter better though, in guard_install_pte_entry()
> would be better to have called it 'new_pte' or something.

I'd suggest at least describing this in the documentation in pagewalk.h. Or
better yet, you could make the pte the return value for the function. Then it is
clear because you have no pointer. You'd lose the error code but the only user
of this currently can't fail anyway.

Anyway, just my 2 pence.

Thanks,
Ryan

> 
>>
>> Thanks,
>> Ryan
>>
>>>
>>>>  	(*nr_pages)++;
>>>>
>>>>  	return 0;
>>>> --
>>>> 2.43.0
>>>>
>>
> 
> Thanks for looking at this by the way, obviously I appreciate your point in
> chasing up cases like this as endeavoured to do the right thing here, albeit
> abstracted away :)


