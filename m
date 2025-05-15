Return-Path: <stable+bounces-144533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EEFAB8798
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 15:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 176B11BA24FE
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 13:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78C629A9DA;
	Thu, 15 May 2025 13:14:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532191BC4E;
	Thu, 15 May 2025 13:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314869; cv=none; b=D1wezY7J659P9W6T9uaO0K+0sNt/wow6MqDXpQydn5WsxflF8U+66Qpt5HZoNqFsium1ETXvdBhAAEldvZCZevhiGZKi/fQn4MnBJkh/6d/9xYh6PbKmB9wQsg46j+YOSWQAZlPBeTNRkOOr/EPHBAiQoWEn5n99N2891xL2TVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314869; c=relaxed/simple;
	bh=/hLA+6nCAyhMG0wsMlOqsGR2pq4/83HOduMcfHlrHlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hOp21qmv/YuKbD85qo+d8juGiZe5sgUwW62YSPTqyjzL3z656VzXaN+A6SFib1OJyVgVBt5RwSCKeQiRKA+K2j7XgJY5Ak6r5HhTDWxZoE4al8bDeIkXo8ep7rsIr+AaXtCM+drpVZPZRBagJLXH+JYlYG9/lNCtzfB3WtF7iM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C99E91595;
	Thu, 15 May 2025 06:14:14 -0700 (PDT)
Received: from [10.1.32.187] (XHFQ2J9959.cambridge.arm.com [10.1.32.187])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A4AC3F5A1;
	Thu, 15 May 2025 06:14:25 -0700 (PDT)
Message-ID: <bfd07631-fece-48fe-90a3-778ce9abfbf1@arm.com>
Date: Thu, 15 May 2025 14:14:23 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: Check pxd_leaf() instead of !pxd_table() while
 tearing down page tables
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, Dev Jain <dev.jain@arm.com>,
 catalin.marinas@arm.com, will@kernel.org
Cc: anshuman.khandual@arm.com, mark.rutland@arm.com,
 yang@os.amperecomputing.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
References: <20250515063450.86629-1-dev.jain@arm.com>
 <332ecda7-14c4-4dc3-aeff-26801b74ca04@redhat.com>
 <4904d02f-6595-4230-a321-23327596e085@arm.com>
 <6fe7848c-485e-4639-b65c-200ed6abe119@redhat.com>
 <35ef7691-7eac-4efa-838d-c504c88c042b@arm.com>
 <c06930f0-f98c-4089-aa33-6789b95fd08f@redhat.com>
 <bac0d8e2-6219-4eb2-b4c8-b82b208808b5@arm.com>
 <3aeb6b8e-040c-47ae-8b46-1ef66d5f11e4@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <3aeb6b8e-040c-47ae-8b46-1ef66d5f11e4@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15/05/2025 14:01, David Hildenbrand wrote:
> On 15.05.25 12:07, Ryan Roberts wrote:
>> On 15/05/2025 09:53, David Hildenbrand wrote:
>>> On 15.05.25 10:47, Dev Jain wrote:
>>>>
>>>>
>>>> On 15/05/25 2:06 pm, David Hildenbrand wrote:
>>>>> On 15.05.25 10:22, Dev Jain wrote:
>>>>>>
>>>>>>
>>>>>> On 15/05/25 1:43 pm, David Hildenbrand wrote:
>>>>>>> On 15.05.25 08:34, Dev Jain wrote:
>>>>>>>> Commit 9c006972c3fe removes the pxd_present() checks because the caller
>>>>>>>> checks pxd_present(). But, in case of vmap_try_huge_pud(), the caller
>>>>>>>> only
>>>>>>>> checks pud_present(); pud_free_pmd_page() recurses on each pmd through
>>>>>>>> pmd_free_pte_page(), wherein the pmd may be none.
>>>>>>> The commit states: "The core code already has a check for pXd_none()",
>>>>>>> so I assume that assumption was not true in all cases?
>>>>>>>
>>>>>>> Should that one problematic caller then check for pmd_none() instead?
>>>>>>
>>>>>>     From what I could gather of Will's commit message, my interpretation is
>>>>>> that the concerned callers are vmap_try_huge_pud and vmap_try_huge_pmd.
>>>>>> These individually check for pxd_present():
>>>>>>
>>>>>> if (pmd_present(*pmd) && !pmd_free_pte_page(pmd, addr))
>>>>>>       return 0;
>>>>>>
>>>>>> The problem is that vmap_try_huge_pud will also iterate on pte entries.
>>>>>> So if the pud is present, then pud_free_pmd_page -> pmd_free_pte_page
>>>>>> may encounter a none pmd and trigger a WARN.
>>>>>
>>>>> Yeah, pud_free_pmd_page()->pmd_free_pte_page() looks shaky.
>>>>>
>>>>> I assume we should either have an explicit pmd_none() check in
>>>>> pud_free_pmd_page() before calling pmd_free_pte_page(), or one in
>>>>> pmd_free_pte_page().
>>>>>
>>>>> With your patch, we'd be calling pte_free_kernel() on a NULL pointer,
>>>>> which sounds wrong -- unless I am missing something important.
>>>>
>>>> Ah thanks, you seem to be right. We will be extracting table from a none
>>>> pmd. Perhaps we should still bail out for !pxd_present() but without the
>>>> warning, which the fix commit used to do.
>>>
>>> Right. We just make sure that all callers of pmd_free_pte_page() already check
>>> for it.
>>>
>>> I'd just do something like:
>>
>> I just reviewed the patch and had the same feedback as David. I agree with the
>> patch below, with some small mods...
>>
>>>
>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>> index 8fcf59ba39db7..e98dd7af147d5 100644
>>> --- a/arch/arm64/mm/mmu.c
>>> +++ b/arch/arm64/mm/mmu.c
>>> @@ -1274,10 +1274,8 @@ int pmd_free_pte_page(pmd_t *pmdp, unsigned long addr)
>>>            pmd = READ_ONCE(*pmdp);
>>>   -       if (!pmd_table(pmd)) {
>>> -               VM_WARN_ON(1);
>>> -               return 1;
>>> -       }
>>> +       VM_WARN_ON(!pmd_present(pmd));
>>> +       VM_WARN_ON(!pmd_table(pmd));
>>
>> You don't need both of these warnings; pmd_table() is only true if the pmd is
>> present (well actually only if it's _valid_ which is more strict than present),
>> so the second one is sufficient on its own.
> 
> Ah, right.
> 
>>
>>>            table = pte_offset_kernel(pmdp, addr);
>>>          pmd_clear(pmdp);
>>> @@ -1305,7 +1303,8 @@ int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
>>
>> Given you are removing the runtime check and early return in
>> pmd_free_pte_page(), I think you should modify this function to use the same
>> style too.
> 
> BTW, the "return 1" is weird. But looking at x86, we seem to be making a private
> copy of the page table first, to defer freeing the page tables after the TLB flush.
> 
> I wonder if there isn't a better way (e.g., clear PUDP + flush tlb, then walk
> over the effectively-disconnected page table). But I'm sure there is a good
> reason for that.

As I understand it, the actual TLB entries should have been invalidated when the
previous mappings we vfree'd. So the single page __flush_tlb_kernel_pgtable()
calls here are to zap any table entries that may be in the walk cache. We could
do an all-levels TLBI for the entire range, but for a system that doesn't
support the tlbi-range operations, we would end up issuing a tlbi per page
across the whole range which I think would be much slower than the one tlbi per
pgtable we have here.

Things could be rearranged a bit so that we issue all the tlbis with only a
single set of barriers (currently each __flush_tlb_kernel_pgtable() issues it's
own barriers), but I'm not sure how important that micro-optimization is given I
guess we never even call pud_free_pmd_page() in practice given we have had no
reports of the warning tripping.

> 
>>
>>>          next = addr;
>>>          end = addr + PUD_SIZE;
>>>          do {
>>> -               pmd_free_pte_page(pmdp, next);
>>> +               if (pmd_present(*pmdp))
>>
>> question: I wonder if it is better to use !pmd_none() as the condition here? It
>> should either be none or a table at this point, so this allows the warning in
>> pmd_free_pte_page() to catch more error conditions. No strong opinion though.
> 
> Same here. The existing callers check pmd_present().

Yeah fair let's be consistent and use pmd_present().

Thanks,
Ryan


