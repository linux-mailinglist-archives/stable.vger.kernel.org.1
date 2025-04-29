Return-Path: <stable+bounces-137105-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB14AA0F39
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 16:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEC1C164377
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 14:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFCC217712;
	Tue, 29 Apr 2025 14:41:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D201EEE0;
	Tue, 29 Apr 2025 14:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745937680; cv=none; b=NLUzuXlCF9SBSMjyZGILyK5QG3HKkaDuyCD9ePxqJVjMdCb7fS9W4HR66nm5EvsQ/HJ8Xrxp1SlDycVfe01bVjHXYNY1GgnnhkraGzew8OHAjeKEbLH9F0giVXQMyXMV6i1ZD5VWLtJs/u4TZPSe+tPfZRSvTzBYvRX1cMMMIBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745937680; c=relaxed/simple;
	bh=EVyL4Z5a7kTACOVEWyhmkbYR8V6HtQ5/sGuZ1jsdr6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=esjbK69J2kqnNODJHzRIN5GE85H2eEbTlFpDoU75ENYfODf9fEFLfRHq2OM0STTSNU/M96YLDqrloQQtojumHBPCov5Zam/LT7AzWAs0Ofmjkf8+jsTRwnf6px4C1sG359S9G2bh+DtUtS0psl5pz5A+XjIDazfaCDmA4jfc7Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A91C41515;
	Tue, 29 Apr 2025 07:41:04 -0700 (PDT)
Received: from [10.1.25.156] (XHFQ2J9959.cambridge.arm.com [10.1.25.156])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D7983F66E;
	Tue, 29 Apr 2025 07:41:10 -0700 (PDT)
Message-ID: <e9617001-da1d-4c4f-99f4-0e51d51d385e@arm.com>
Date: Tue, 29 Apr 2025 15:41:08 +0100
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
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <d53fd549-887f-4220-b0d1-ebc336eecb9f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 29/04/2025 15:29, David Hildenbrand wrote:
> On 29.04.25 16:22, Petr Vaněk wrote:
>> folio_pte_batch() could overcount the number of contiguous PTEs when
>> pte_advance_pfn() returns a zero-valued PTE and the following PTE in
>> memory also happens to be zero. The loop doesn't break in such a case
>> because pte_same() returns true, and the batch size is advanced by one
>> more than it should be.
>>
>> To fix this, bail out early if a non-present PTE is encountered,
>> preventing the invalid comparison.
>>
>> This issue started to appear after commit 10ebac4f95e7 ("mm/memory:
>> optimize unmap/zap with PTE-mapped THP") and was discovered via git
>> bisect.
>>
>> Fixes: 10ebac4f95e7 ("mm/memory: optimize unmap/zap with PTE-mapped THP")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Petr Vaněk <arkamar@atlas.cz>
>> ---
>>   mm/internal.h | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/mm/internal.h b/mm/internal.h
>> index e9695baa5922..c181fe2bac9d 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -279,6 +279,8 @@ static inline int folio_pte_batch(struct folio *folio,
>> unsigned long addr,
>>               dirty = !!pte_dirty(pte);
>>           pte = __pte_batch_clear_ignored(pte, flags);
>>   +        if (!pte_present(pte))
>> +            break;
>>           if (!pte_same(pte, expected_pte))
>>               break;
> 
> How could pte_same() suddenly match on a present and non-present PTE.
> 
> Something with XEN is really problematic here.
> 

We are inside a lazy MMU region (arch_enter_lazy_mmu_mode()) at this point,
which I believe XEN uses. If a PTE was written then read back while in lazy mode
you could get a stale value.

See
https://lore.kernel.org/all/912c7a32-b39c-494f-a29c-4865cd92aeba@agordeev.local/
for an example bug.


