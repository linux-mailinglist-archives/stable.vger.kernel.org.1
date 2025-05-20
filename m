Return-Path: <stable+bounces-145047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC04ABD2F2
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 11:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EAB01BA2E1F
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 09:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7288F2676DF;
	Tue, 20 May 2025 09:13:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDB22676DC;
	Tue, 20 May 2025 09:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747732407; cv=none; b=e20Y0j1zQdVa4+fj8urAx7f1Ssoz/c9g9XEAx7xVHnBhVeT7AvwV0LG875jOVmFGSrwC9aGhFKwY3H2MWq2KIV7DZ8S4ClXXH4//nZqvVIFqrzmHIMXrJvn6sBSZhMwUBtdKU7AaAAXC7byJrW6Hxph4m7n2OuqE8I4btq5drmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747732407; c=relaxed/simple;
	bh=Hh9qJZdaF4ZQAaENwivk2JifLFjrU3RWeIo0TJd3veQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GCBwSvNx7VcMLMF3GOGwStgKDX7CLGMABx593J1ShbCUElaLM0QNcqux0bc2f/dPt9VbQtLlsWmHkNVn5FTtGuUPELKinuMhnMs+Nz1bK8ugzT1b+2H9BrPdHlEEUv+WdRk4G/mhN3b/e0Vj+tV6isdOTrM3GkRGKPd0WrUWrLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BBE2152B;
	Tue, 20 May 2025 02:13:11 -0700 (PDT)
Received: from [10.164.18.48] (unknown [10.164.18.48])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35A483F5A1;
	Tue, 20 May 2025 02:13:21 -0700 (PDT)
Message-ID: <7d5476a1-baa8-4bd0-965f-009bfa01c3c3@arm.com>
Date: Tue, 20 May 2025 14:43:10 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: Restrict pagetable teardown to avoid false
 warning
To: Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand
 <david@redhat.com>, catalin.marinas@arm.com, will@kernel.org
Cc: anshuman.khandual@arm.com, mark.rutland@arm.com,
 yang@os.amperecomputing.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
References: <20250518095445.31044-1-dev.jain@arm.com>
 <5763d921-f8a8-4ca6-b5b5-ad96eb5cda11@arm.com>
 <7680e775-d277-45ea-9b6c-1f16b8b55a3f@redhat.com>
 <df7eb016-bea4-489d-aecb-1a47eb5e33b2@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <df7eb016-bea4-489d-aecb-1a47eb5e33b2@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 19/05/25 6:17 pm, Ryan Roberts wrote:
> On 19/05/2025 13:16, David Hildenbrand wrote:
>> On 19.05.25 11:08, Ryan Roberts wrote:
>>> On 18/05/2025 10:54, Dev Jain wrote:
>>>> Commit 9c006972c3fe removes the pxd_present() checks because the caller
>>>
>>> nit: please use the standard format for describing commits: Commit 9c006972c3fe
>>> ("arm64: mmu: drop pXd_present() checks from pXd_free_pYd_table()")
>>>
>>>> checks pxd_present(). But, in case of vmap_try_huge_pud(), the caller only
>>>> checks pud_present(); pud_free_pmd_page() recurses on each pmd through
>>>> pmd_free_pte_page(), wherein the pmd may be none. Thus it is possible to
>>>> hit a warning in the latter, since pmd_none => !pmd_table(). Thus, add
>>>> a pmd_present() check in pud_free_pmd_page().
>>>>
>>>> This problem was found by code inspection.
>>>>
>>>> This patch is based on 6.15-rc6.
>>>
>>> nit: please remove this to below the "---", its not part of the commit log.
>>>
>>>>
>>>> Fixes: 9c006972c3fe (arm64: mmu: drop pXd_present() checks from
>>>> pXd_free_pYd_table())
>>>>
>>>
>>> nit: remove empty line; the tags should all be in a single block with no empty
>>> lines.
>>>
>>>> Cc: <stable@vger.kernel.org>
>>>> Reported-by: Ryan Roberts <ryan.roberts@arm.com>
>>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>>> ---
>>>> v1->v2:
>>>>    - Enforce check in caller
>>>>
>>>>    arch/arm64/mm/mmu.c | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>>> index ea6695d53fb9..5b1f4cd238ca 100644
>>>> --- a/arch/arm64/mm/mmu.c
>>>> +++ b/arch/arm64/mm/mmu.c
>>>> @@ -1286,7 +1286,8 @@ int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
>>>>        next = addr;
>>>>        end = addr + PUD_SIZE;
>>>>        do {
>>>> -        pmd_free_pte_page(pmdp, next);
>>>> +        if (pmd_present(*pmdp))
>>>
>>> pmd_free_pte_page() is using READ_ONCE() to access the *pmdp to ensure it can't
>>> be torn. I suspect we don't technically need that in these functions because
>>> there can be no race with a writer.
>>
>> Yeah, if there is no proper locking in place the function would already
>> seriously mess up (double freeing etc).
> 
> Indeed; there is no locking, but this portion of the vmalloc VA space has been
> allocated to us exclusively, so we know there can be no one else racing.
> 
>>
>>> But the arm64 arch code always uses
>>> READ_ONCE() for dereferencing pgtable entries for safely. Perhaps we should be
>>> consistent here?
>>
>> mm/vmalloc.c:   if (pmd_present(*pmd) && !pmd_free_pte_page(pmd, addr))
> 
> Yes, I saw that. I know that we don't technically need READ_ONCE(). I'm just
> proposng that for arm64 code we should be consistent with what it already does.
> See Commit 20a004e7b017 ("arm64: mm: Use READ_ONCE/WRITE_ONCE when accessing
> page tables")

(Sorry for the spam, managed to import the mbox into thunderbird)
So we can just pmdp_get() here?

> 
> Thanks,
> Ryan
> 
>>
>>
>> :)
>>
>> Acked-by: David Hildenbrand <david@redhat.com>
>>
> 


