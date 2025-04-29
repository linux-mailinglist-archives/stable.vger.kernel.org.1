Return-Path: <stable+bounces-137110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1ACAA0FE6
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 440FC4A4CE5
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 15:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711E121C19F;
	Tue, 29 Apr 2025 15:02:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F69C2D1;
	Tue, 29 Apr 2025 15:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745938938; cv=none; b=q235yVlIsZNfHCAdqztYUiJFB3uDvCgO+Y7mUsTnlzLP0Ac6qMHf+iLsZ7Kp76iJefnKecZld6LAlhznLMCJRzcX/plrvsKOybRdZ1ub8Lygh7b+l5d3Mi8W2j8y0iqzzwwK7Q3/FAMTxLl+tdNGx6FtsMQWfFmh61G37Ak/MTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745938938; c=relaxed/simple;
	bh=nPG+BgRfSzlu72qtVpculB1B811fjqa1f4HvppaeY38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jycgqTS44zVKR/sO1jrJ/2Uhc+bsOyMBaeEexvjIUzKD0QI73mofS2MUFdV51ALPJ4jjXdx7SDdWpzRaOXcKWtpevjSFP8D0r24MM4HhwjsHaRIbW/EtoOyvuMqHh3iFUBWgwdhW2WlzGFNBMZg0H1/RSyjokoE8XdIKgAqg1gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6911D1515;
	Tue, 29 Apr 2025 08:02:06 -0700 (PDT)
Received: from [10.1.25.156] (XHFQ2J9959.cambridge.arm.com [10.1.25.156])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DC8D3F673;
	Tue, 29 Apr 2025 08:02:12 -0700 (PDT)
Message-ID: <cac9bf3c-5af1-41be-86a5-bf76384b5e3b@arm.com>
Date: Tue, 29 Apr 2025 16:02:10 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm: Fix folio_pte_batch() overcount with zero PTEs
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, =?UTF-8?Q?Petr_Van=C4=9Bk?=
 <arkamar@atlas.cz>, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 stable@vger.kernel.org
References: <20250429142237.22138-1-arkamar@atlas.cz>
 <20250429142237.22138-2-arkamar@atlas.cz>
 <d53fd549-887f-4220-b0d1-ebc336eecb9f@redhat.com>
 <e9617001-da1d-4c4f-99f4-0e51d51d385e@arm.com>
 <bb24f0d3-cbbf-4323-a9e6-09a627c8559b@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <bb24f0d3-cbbf-4323-a9e6-09a627c8559b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 29/04/2025 15:46, David Hildenbrand wrote:
> On 29.04.25 16:41, Ryan Roberts wrote:
>> On 29/04/2025 15:29, David Hildenbrand wrote:
>>> On 29.04.25 16:22, Petr Vaněk wrote:
>>>> folio_pte_batch() could overcount the number of contiguous PTEs when
>>>> pte_advance_pfn() returns a zero-valued PTE and the following PTE in
>>>> memory also happens to be zero. The loop doesn't break in such a case
>>>> because pte_same() returns true, and the batch size is advanced by one
>>>> more than it should be.
>>>>
>>>> To fix this, bail out early if a non-present PTE is encountered,
>>>> preventing the invalid comparison.
>>>>
>>>> This issue started to appear after commit 10ebac4f95e7 ("mm/memory:
>>>> optimize unmap/zap with PTE-mapped THP") and was discovered via git
>>>> bisect.
>>>>
>>>> Fixes: 10ebac4f95e7 ("mm/memory: optimize unmap/zap with PTE-mapped THP")
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Petr Vaněk <arkamar@atlas.cz>
>>>> ---
>>>>    mm/internal.h | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/mm/internal.h b/mm/internal.h
>>>> index e9695baa5922..c181fe2bac9d 100644
>>>> --- a/mm/internal.h
>>>> +++ b/mm/internal.h
>>>> @@ -279,6 +279,8 @@ static inline int folio_pte_batch(struct folio *folio,
>>>> unsigned long addr,
>>>>                dirty = !!pte_dirty(pte);
>>>>            pte = __pte_batch_clear_ignored(pte, flags);
>>>>    +        if (!pte_present(pte))
>>>> +            break;
>>>>            if (!pte_same(pte, expected_pte))
>>>>                break;
>>>
>>> How could pte_same() suddenly match on a present and non-present PTE.
>>>
>>> Something with XEN is really problematic here.
>>>
>>
>> We are inside a lazy MMU region (arch_enter_lazy_mmu_mode()) at this point,
>> which I believe XEN uses. If a PTE was written then read back while in lazy mode
>> you could get a stale value.
>>
>> See
>> https://lore.kernel.org/all/912c7a32-b39c-494f-a29c-4865cd92aeba@agordeev.local/
>> for an example bug.
> 
> So if we cannot trust ptep_get() output, then, ... how could we trust anything
> here and ever possibly batch?

The point is that for a write followed by a read to the same PTE, the read may
not return what was written. It could return the value of the PTE at the point
of entry into the lazy mmu mode.

I guess one quick way to test is to hack out lazy mmu support. Something like
this? (totally untested):

----8<----
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index c4c23190925c..1f0a1a713072 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -541,22 +541,6 @@ static inline void arch_end_context_switch(struct
task_struct *next)
        PVOP_VCALL1(cpu.end_context_switch, next);
 }

-#define  __HAVE_ARCH_ENTER_LAZY_MMU_MODE
-static inline void arch_enter_lazy_mmu_mode(void)
-{
-       PVOP_VCALL0(mmu.lazy_mode.enter);
-}
-
-static inline void arch_leave_lazy_mmu_mode(void)
-{
-       PVOP_VCALL0(mmu.lazy_mode.leave);
-}
-
-static inline void arch_flush_lazy_mmu_mode(void)
-{
-       PVOP_VCALL0(mmu.lazy_mode.flush);
-}
-
 static inline void __set_fixmap(unsigned /* enum fixed_addresses */ idx,
                                phys_addr_t phys, pgprot_t flags)
 {
----8<----


