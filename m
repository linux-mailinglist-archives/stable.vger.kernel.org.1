Return-Path: <stable+bounces-144499-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E53F1AB8286
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 11:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CE484C6BD2
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 09:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7333D296D09;
	Thu, 15 May 2025 09:27:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EC629672F;
	Thu, 15 May 2025 09:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747301246; cv=none; b=l0epWatkgoqywYETvaor5nDWqm6LR/CgJDP6j7lr+4Cz2zIzFaOiT8ZHeQ3h9amj6teMKInmqgEjUIqA/FrCPzm/Zfv61fVU+OmFBMJTbmBhsmaGnOSebRTLE32HekOjzKOT0Dq3yPJ4Rb/HiL3cyHZD3OSJxfovwYtThusvkr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747301246; c=relaxed/simple;
	bh=CG/LZ+w1W61yrSttG7fYTJQ0VMdFcH9K/FubTccL+i8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FI/EH6zN9lhop2JGEbCApCTeknrfeM0QddvMHfTmJzrsrgYhMjtp2yAUBN4/70siO+6ms1v5DAZhajWvIOL+GHqyb1NuOLgmA/reY75nGObwGy4nGlX32bQp+fUMyY9dJU/6Ekpb+UemxVEHJqsqyIqTc67NO3pGarxoTXP6tJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B583314BF;
	Thu, 15 May 2025 02:27:10 -0700 (PDT)
Received: from [10.162.40.26] (K4MQJ0H1H2.blr.arm.com [10.162.40.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54E303F5A1;
	Thu, 15 May 2025 02:27:19 -0700 (PDT)
Message-ID: <91fc96c3-4931-4f07-a0a9-507ac7b5ae6d@arm.com>
Date: Thu, 15 May 2025 14:57:16 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: Check pxd_leaf() instead of !pxd_table() while
 tearing down page tables
To: David Hildenbrand <david@redhat.com>, catalin.marinas@arm.com,
 will@kernel.org
Cc: ryan.roberts@arm.com, anshuman.khandual@arm.com, mark.rutland@arm.com,
 yang@os.amperecomputing.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
References: <20250515063450.86629-1-dev.jain@arm.com>
 <332ecda7-14c4-4dc3-aeff-26801b74ca04@redhat.com>
 <4904d02f-6595-4230-a321-23327596e085@arm.com>
 <6fe7848c-485e-4639-b65c-200ed6abe119@redhat.com>
 <35ef7691-7eac-4efa-838d-c504c88c042b@arm.com>
 <c06930f0-f98c-4089-aa33-6789b95fd08f@redhat.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <c06930f0-f98c-4089-aa33-6789b95fd08f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 15/05/25 2:23 pm, David Hildenbrand wrote:
> On 15.05.25 10:47, Dev Jain wrote:
>>
>>
>> On 15/05/25 2:06 pm, David Hildenbrand wrote:
>>> On 15.05.25 10:22, Dev Jain wrote:
>>>>
>>>>
>>>> On 15/05/25 1:43 pm, David Hildenbrand wrote:
>>>>> On 15.05.25 08:34, Dev Jain wrote:
>>>>>> Commit 9c006972c3fe removes the pxd_present() checks because the 
>>>>>> caller
>>>>>> checks pxd_present(). But, in case of vmap_try_huge_pud(), the caller
>>>>>> only
>>>>>> checks pud_present(); pud_free_pmd_page() recurses on each pmd 
>>>>>> through
>>>>>> pmd_free_pte_page(), wherein the pmd may be none.
>>>>> The commit states: "The core code already has a check for pXd_none()",
>>>>> so I assume that assumption was not true in all cases?
>>>>>
>>>>> Should that one problematic caller then check for pmd_none() instead?
>>>>
>>>>    From what I could gather of Will's commit message, my 
>>>> interpretation is
>>>> that the concerned callers are vmap_try_huge_pud and vmap_try_huge_pmd.
>>>> These individually check for pxd_present():
>>>>
>>>> if (pmd_present(*pmd) && !pmd_free_pte_page(pmd, addr))
>>>>      return 0;
>>>>
>>>> The problem is that vmap_try_huge_pud will also iterate on pte entries.
>>>> So if the pud is present, then pud_free_pmd_page -> pmd_free_pte_page
>>>> may encounter a none pmd and trigger a WARN.
>>>
>>> Yeah, pud_free_pmd_page()->pmd_free_pte_page() looks shaky.
>>>
>>> I assume we should either have an explicit pmd_none() check in
>>> pud_free_pmd_page() before calling pmd_free_pte_page(), or one in
>>> pmd_free_pte_page().
>>>
>>> With your patch, we'd be calling pte_free_kernel() on a NULL pointer,
>>> which sounds wrong -- unless I am missing something important.
>>
>> Ah thanks, you seem to be right. We will be extracting table from a none
>> pmd. Perhaps we should still bail out for !pxd_present() but without the
>> warning, which the fix commit used to do.
> 
> Right. We just make sure that all callers of pmd_free_pte_page() already 
> check for it.
> 
> I'd just do something like:
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 8fcf59ba39db7..e98dd7af147d5 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1274,10 +1274,8 @@ int pmd_free_pte_page(pmd_t *pmdp, unsigned long 
> addr)
> 
>          pmd = READ_ONCE(*pmdp);
> 
> -       if (!pmd_table(pmd)) {
> -               VM_WARN_ON(1);
> -               return 1;
> -       }
> +       VM_WARN_ON(!pmd_present(pmd));
> +       VM_WARN_ON(!pmd_table(pmd));

And also return 1?
Also we should BUG_ON(!pmd_present(pmd)) to avoid the null dereference?

> 
>          table = pte_offset_kernel(pmdp, addr);
>          pmd_clear(pmdp);
> @@ -1305,7 +1303,8 @@ int pud_free_pmd_page(pud_t *pudp, unsigned long 
> addr)
>          next = addr;
>          end = addr + PUD_SIZE;
>          do {
> -               pmd_free_pte_page(pmdp, next);
> +               if (pmd_present(*pmdp))
> +                       pmd_free_pte_page(pmdp, next);

Ah yes, the "caller" of pmd_free_pte_page() is not only 
vmap_try_huge_pmd but this also...my mind has been foggy lately...
need to solve a math problem or two to sharpen it :)

>          } while (pmdp++, next += PMD_SIZE, next != end);
> 
>          pud_clear(pudp);
> 
> 


