Return-Path: <stable+bounces-118375-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 081F1A3D16F
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 07:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30D453BAC32
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 06:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A66E1E0E15;
	Thu, 20 Feb 2025 06:38:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF50D18C322;
	Thu, 20 Feb 2025 06:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740033482; cv=none; b=VPe9/CSnTkf+gOunB6QrJi1cbFdcOns9WNAukVnoax84Dt75DxUzURHDzqqrVxI7lZbh283mI9X4u/qHz/uTTJCLhF1xWWl8lB5ZLB2voMZUMmWtdHSgXOQPf5njFPKYYO7hs1AOx32SuYPcMIFddb0WAlMKWnHHWycvgVDxoyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740033482; c=relaxed/simple;
	bh=5P/NTNSv/R2aP04bJprG/OCuWTP8sVyWpcqLOD5cSXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pSgVHbf5O6zvNeNSgJ+Tm1qlCJKZBbp2OjhLrO1+sALGyeN7IaexAjckHGVjx97lefFBMGoi+XyIvyh96/kBRQa47ISaSDgp1wEWqA/ZHHWKEwmxbzCKF/aGiXLQY/WwHZ6T40ry8hRRzo71W24dLW6nxcjhO70A2qVf+l4XebI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 020DE2A2A;
	Wed, 19 Feb 2025 22:38:16 -0800 (PST)
Received: from [10.163.38.27] (unknown [10.163.38.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8BF183F5A1;
	Wed, 19 Feb 2025 22:37:39 -0800 (PST)
Message-ID: <50f48574-241d-42d8-b811-3e422c41e21a@arm.com>
Date: Thu, 20 Feb 2025 12:07:35 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] arm64: hugetlb: Fix huge_ptep_get_and_clear() for
 non-present ptes
To: Ryan Roberts <ryan.roberts@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>,
 Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 David Hildenbrand <david@redhat.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Mark Rutland <mark.rutland@arm.com>, Dev Jain <dev.jain@arm.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250217140419.1702389-1-ryan.roberts@arm.com>
 <20250217140419.1702389-3-ryan.roberts@arm.com>
 <e26a59a1-ff9a-49c7-b10a-c3f5c096a2c4@arm.com>
 <5477d161-12e7-4475-a6e9-ff3921989673@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <5477d161-12e7-4475-a6e9-ff3921989673@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/19/25 14:28, Ryan Roberts wrote:
> On 19/02/2025 08:45, Anshuman Khandual wrote:
>>
>>
>> On 2/17/25 19:34, Ryan Roberts wrote:
>>> arm64 supports multiple huge_pte sizes. Some of the sizes are covered by
>>> a single pte entry at a particular level (PMD_SIZE, PUD_SIZE), and some
>>> are covered by multiple ptes at a particular level (CONT_PTE_SIZE,
>>> CONT_PMD_SIZE). So the function has to figure out the size from the
>>> huge_pte pointer. This was previously done by walking the pgtable to
>>> determine the level and by using the PTE_CONT bit to determine the
>>> number of ptes at the level.
>>>
>>> But the PTE_CONT bit is only valid when the pte is present. For
>>> non-present pte values (e.g. markers, migration entries), the previous
>>> implementation was therefore erroniously determining the size. There is

typo - s/erroniously/erroneously   ^^^^^^

>>> at least one known caller in core-mm, move_huge_pte(), which may call
>>> huge_ptep_get_and_clear() for a non-present pte. So we must be robust to
>>> this case. Additionally the "regular" ptep_get_and_clear() is robust to
>>> being called for non-present ptes so it makes sense to follow the
>>> behaviour.
>>>
>>> Fix this by using the new sz parameter which is now provided to the
>>> function. Additionally when clearing each pte in a contig range, don't
>>> gather the access and dirty bits if the pte is not present.
>>>
>>> An alternative approach that would not require API changes would be to
>>> store the PTE_CONT bit in a spare bit in the swap entry pte for the
>>> non-present case. But it felt cleaner to follow other APIs' lead and
>>> just pass in the size.
>>>
>>> As an aside, PTE_CONT is bit 52, which corresponds to bit 40 in the swap
>>> entry offset field (layout of non-present pte). Since hugetlb is never
>>> swapped to disk, this field will only be populated for markers, which
>>> always set this bit to 0 and hwpoison swap entries, which set the offset
>>> field to a PFN; So it would only ever be 1 for a 52-bit PVA system where
>>> memory in that high half was poisoned (I think!). So in practice, this
>>> bit would almost always be zero for non-present ptes and we would only
>>> clear the first entry if it was actually a contiguous block. That's
>>> probably a less severe symptom than if it was always interpretted as 1

typo - s/interpretted/interpreted			    ^^^^^^


>>> and cleared out potentially-present neighboring PTEs.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 66b3923a1a0f ("arm64: hugetlb: add support for PTE contiguous bit")
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> ---
>>>  arch/arm64/mm/hugetlbpage.c | 40 ++++++++++++++++---------------------
>>>  1 file changed, 17 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
>>> index 06db4649af91..614b2feddba2 100644
>>> --- a/arch/arm64/mm/hugetlbpage.c
>>> +++ b/arch/arm64/mm/hugetlbpage.c
>>> @@ -163,24 +163,23 @@ static pte_t get_clear_contig(struct mm_struct *mm,
>>>  			     unsigned long pgsize,
>>>  			     unsigned long ncontig)
>>>  {
>>> -	pte_t orig_pte = __ptep_get(ptep);
>>> -	unsigned long i;
>>> -
>>> -	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++) {
>>> -		pte_t pte = __ptep_get_and_clear(mm, addr, ptep);
>>> -
>>> -		/*
>>> -		 * If HW_AFDBM is enabled, then the HW could turn on
>>> -		 * the dirty or accessed bit for any page in the set,
>>> -		 * so check them all.
>>> -		 */
>>> -		if (pte_dirty(pte))
>>> -			orig_pte = pte_mkdirty(orig_pte);
>>> -
>>> -		if (pte_young(pte))
>>> -			orig_pte = pte_mkyoung(orig_pte);
>>> +	pte_t pte, tmp_pte;
>>> +	bool present;
>>> +
>>> +	pte = __ptep_get_and_clear(mm, addr, ptep);
>>> +	present = pte_present(pte);
>>
>> pte_present() may not be evaluated for standard huge pages at [PMD|PUD]_SIZE
>> e.g when ncontig = 1 in the argument.
> 
> Sorry I'm not quite sure what you're suggesting here? Are you proposing that
> pte_present() should be moved into the loop so that we only actually call it
> when we are going to consume it? I'm happy to do that if it's the preference,

Right, pte_present() is only required for the cont huge pages but not for the
normal huge pages. 

> but I thought it was neater to hoist it out of the loop.

Agreed, but when possible pte_present() cost should be avoided for the normal
huge pages where it is not required.

> 
>>
>>> +	while (--ncontig) {
>>
>> Should this be converted into a for loop instead just to be in sync with other
>> similar iterators in this file.
>>
>> for (i = 1; i < ncontig; i++, addr += pgsize, ptep++)
>> {
>> 	tmp_pte = __ptep_get_and_clear(mm, addr, ptep);
>> 	if (present) {
>> 		if (pte_dirty(tmp_pte))
>> 			pte = pte_mkdirty(pte);
>> 		if (pte_young(tmp_pte))
>> 			pte = pte_mkyoung(pte);
>> 	}
>> }
> 
> I think the way you have written this it's incorrect. Let's say we have 16 ptes
> in the block. We want to iterate over the last 15 of them (we have already read
> pte 0). But you're iterating over the first 15 because you don't increment addr
> and ptep until after you've been around the loop the first time. So we would
> need to explicitly increment those 2 before entering the loop. But that is only
> neccessary if ncontig > 1. Personally I think my approach is neater...

Thinking about this again. Just wondering should not a pte_present()
check on each entries being cleared along with (ncontig > 1) in this
existing loop before transferring over the dirty and accessed bits -
also work as intended with less code churn ?

static pte_t get_clear_contig(struct mm_struct *mm,
                             unsigned long addr,
                             pte_t *ptep,
                             unsigned long pgsize,
                             unsigned long ncontig)
{
       pte_t orig_pte = __ptep_get(ptep);
       unsigned long i;

        for (i = 0; i < ncontig; i++, addr += pgsize, ptep++) {
                pte_t pte = __ptep_get_and_clear(mm, addr, ptep);
		
		if (ncontig > 1 && !pte_present(pte))
                        continue;

                /*
                 * If HW_AFDBM is enabled, then the HW could turn on
                 * the dirty or accessed bit for any page in the set,
                 * so check them all.
                 */
                if (pte_dirty(pte))
                        orig_pte = pte_mkdirty(orig_pte);

                if (pte_young(pte))
                        orig_pte = pte_mkyoung(orig_pte);
        }
        return orig_pte;
}

* Normal huge pages

	- enters the for loop just once
	- clears the single entry
	- always transfers dirty and access bits
		- pte_present() does not matter as ncontig = 1

* Contig huge pages

	- enters the for loop ncontig times - for each sub page
	- clears all sub page entries
	- transfers dirty and access bits only when pte_present()
		- pte_present() is relevant as ncontig > 1

> 
>>
>>> +		ptep++;
>>> +		addr += pgsize;
>>> +		tmp_pte = __ptep_get_and_clear(mm, addr, ptep);
>>> +		if (present) {
>>> +			if (pte_dirty(tmp_pte))
>>> +				pte = pte_mkdirty(pte);
>>> +			if (pte_young(tmp_pte))
>>> +				pte = pte_mkyoung(pte);
>>> +		}
>>>  	}
>>> -	return orig_pte;
>>> +	return pte;
>>>  }
>>>  
>>>  static pte_t get_clear_contig_flush(struct mm_struct *mm,
>>> @@ -401,13 +400,8 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
>>>  {
>>>  	int ncontig;
>>>  	size_t pgsize;
>>> -	pte_t orig_pte = __ptep_get(ptep);
>>> -
>>> -	if (!pte_cont(orig_pte))
>>> -		return __ptep_get_and_clear(mm, addr, ptep);
>>> -
>>> -	ncontig = find_num_contig(mm, addr, ptep, &pgsize);
>>>  
>>> +	ncontig = num_contig_ptes(sz, &pgsize);
>>>  	return get_clear_contig(mm, addr, ptep, pgsize, ncontig);
>>>  }
>>>  
> 

