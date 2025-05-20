Return-Path: <stable+bounces-145708-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5FDABE3D5
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 21:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEF533BAC37
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 19:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EC426B2CC;
	Tue, 20 May 2025 19:39:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF7722DA0D;
	Tue, 20 May 2025 19:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747769992; cv=none; b=rp2+O6qOXZsvPmqV6wscVzOzyZ3ro3AabcxpHCt3sBpc7qRN0Rgf3E7V0v3VhohhZLBMkO3hgQwReqZBTZIH3Zwc4mmpnalGRt+AgoCoD5xu6nfN+AccPj9C257WNAX5ObdD8+Hu7FG/Cjaw9xjxcWeHPq1LsOcF3K4F++LZZWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747769992; c=relaxed/simple;
	bh=75F8BZwSWDSrqGudZvElei0KYaFv2MODy/UlW3wQAAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hOYnIUGpshzeYK9I/Cd9C2/mLGlnhqHlU3jG2TpMgC6JY5l70K34HBLRT0TYVVZuThK4ARChwDvbmYJjVhUgB5cd8Oh7KDKDp/zTxKPpIPCZCvf0YbXuCaTRpubkPMBs85KnHtVlIVAEsDkDIwYnBdREasGAKe3l1QH3DvJwIjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D533339;
	Tue, 20 May 2025 12:39:35 -0700 (PDT)
Received: from [10.57.93.184] (unknown [10.57.93.184])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86A723F6A8;
	Tue, 20 May 2025 12:39:47 -0700 (PDT)
Message-ID: <a64cd485-310f-4d4c-a3da-2d8c35d7f343@arm.com>
Date: Tue, 20 May 2025 20:39:45 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: Restrict pagetable teardown to avoid false
 warning
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, Dev Jain <dev.jain@arm.com>
Cc: anshuman.khandual@arm.com, catalin.marinas@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 mark.rutland@arm.com, stable@vger.kernel.org, will@kernel.org,
 yang@os.amperecomputing.com
References: <df7eb016-bea4-489d-aecb-1a47eb5e33b2@arm.com>
 <20250520090501.27273-1-dev.jain@arm.com>
 <021dfe38-f786-46d0-a43f-769aff07b3f0@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <021dfe38-f786-46d0-a43f-769aff07b3f0@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/05/2025 10:10, David Hildenbrand wrote:
> On 20.05.25 11:05, Dev Jain wrote:
>> On 19/05/2025 13:16, David Hildenbrand wrote:
>>> On 19.05.25 11:08, Ryan Roberts wrote:
>>>> On 18/05/2025 10:54, Dev Jain wrote:
>>>>> Commit 9c006972c3fe removes the pxd_present() checks because the caller
>>>>
>>>> nit: please use the standard format for describing commits: Commit 9c006972c3fe
>>>> ("arm64: mmu: drop pXd_present() checks from pXd_free_pYd_table()")
>>>>
>>>>> checks pxd_present(). But, in case of vmap_try_huge_pud(), the caller only
>>>>> checks pud_present(); pud_free_pmd_page() recurses on each pmd through
>>>>> pmd_free_pte_page(), wherein the pmd may be none. Thus it is possible to
>>>>> hit a warning in the latter, since pmd_none => !pmd_table(). Thus, add
>>>>> a pmd_present() check in pud_free_pmd_page().
>>>>>
>>>>> This problem was found by code inspection.
>>>>>
>>>>> This patch is based on 6.15-rc6.
>>>>
>>>> nit: please remove this to below the "---", its not part of the commit log.
>>>>
>>>>>
>>>>> Fixes: 9c006972c3fe (arm64: mmu: drop pXd_present() checks from
>>>>> pXd_free_pYd_table())
>>>>>
>>>>
>>>> nit: remove empty line; the tags should all be in a single block with no empty
>>>> lines.
>>>>
>>>>> Cc: <stable@vger.kernel.org>
>>>>> Reported-by: Ryan Roberts <ryan.roberts@arm.com>
>>>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>>>> ---
>>>>> v1->v2:
>>>>>    - Enforce check in caller
>>>>>
>>>>>    arch/arm64/mm/mmu.c | 3 ++-
>>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>>>> index ea6695d53fb9..5b1f4cd238ca 100644
>>>>> --- a/arch/arm64/mm/mmu.c
>>>>> +++ b/arch/arm64/mm/mmu.c
>>>>> @@ -1286,7 +1286,8 @@ int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
>>>>>        next = addr;
>>>>>        end = addr + PUD_SIZE;
>>>>>        do {
>>>>> -        pmd_free_pte_page(pmdp, next);
>>>>> +        if (pmd_present(*pmdp))
>>>>
>>>> pmd_free_pte_page() is using READ_ONCE() to access the *pmdp to ensure it can't
>>>> be torn. I suspect we don't technically need that in these functions because
>>>> there can be no race with a writer.
>>>
>>> Yeah, if there is no proper locking in place the function would already
>>> seriously mess up (double freeing etc).
>>
>> Indeed; there is no locking, but this portion of the vmalloc VA space has been
>> allocated to us exclusively, so we know there can be no one else racing.
>>
>>>
>>>> But the arm64 arch code always uses
>>>> READ_ONCE() for dereferencing pgtable entries for safely. Perhaps we should be
>>>> consistent here?
>>>
>>> mm/vmalloc.c:   if (pmd_present(*pmd) && !pmd_free_pte_page(pmd, addr))
>>
>> Yes, I saw that. I know that we don't technically need READ_ONCE(). I'm just
>> proposng that for arm64 code we should be consistent with what it already does.
>> See Commit 20a004e7b017 ("arm64: mm: Use READ_ONCE/WRITE_ONCE when accessing
>> page tables")
>>
>> So I'll just use pmdp_get()?
> 
> Maybe that's the cleanest approach. 

Yeah let's do that.

> Likely also common code should use that at
> some point @Ryan?

This is a bit of a can of worms... :)

Potted history: I converted all non-arch and arm64 code to use ptep_get() a
while back. That was necessary because for contpte mappings, arm64 needs to do
more than just read the pte, so that provided the needed hook.

Anshuman had a go at converting all generic code to use pXdp_get() last year as
a means to help arm64 move to supporting 128-bit pgtables - the arm64 compiler
doesn't gurrantee to emit ldp ("load pair") when dereferencing a 128-bit type
but it does guarrantee to emit ldr ("load register") when dereferencing a 64-bit
type, so we don't get single-copy atomicity for *pmdp with 128-bit pgtables but
we do for 64-bit. So we thought we would just convert all the accesses to
pXdp_get() which would allow us to wrap and make the guarrantee.

Some places (GUP, ...) were already using READ_ONCE() so we thought we would
just default pXdp_get() to READ_ONCE() (even for the previously *pmdp case). But
that caused issues with folded pgtable levels; the compiler was no longer able
to optimize out the loads and arm32 and powerpc complained.

We looked at implementing pXdp_get() as either READ_ONCE(*pXdp) or *pXdp
depending on if the level was folded, but I never really convinced myself that
it was definitely safe for cases that were previously unconditionally
READ_ONCE(*pXdp).

So that leaves us with needing 2 variants of the accessors, which is horrible IMHO.

But ultimately I don't think the vast majority of existing *pXdp accesses even
need single-copy atomicity guarrantees, so perhaps from the arm64 128-bit
pgtables PoV it simpler just to leave it all as is and make READ_ONCE() work
with 128-bit types (but that has a downside because arm64 can only support the
required READ_ONCE() semantics if the HW supports it, which we don't know until
boot time. READ_ONCE() wants the compiler to raise an error if trying to use it
with an unsupported type).

In general, it would be nice to use accessors everywhere, but I haven't figured
how to make it all work with a single accessor per level so I'm now trying to
side step it.

In hindsight I'm not sure you really asked for all this detail :)

Thanks,
Ryan


