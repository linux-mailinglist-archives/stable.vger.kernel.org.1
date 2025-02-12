Return-Path: <stable+bounces-115060-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB50A328E9
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 15:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8324C18850F6
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 14:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79032101AB;
	Wed, 12 Feb 2025 14:44:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7BC20E314;
	Wed, 12 Feb 2025 14:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739371490; cv=none; b=c5XUbi6rCfNrlr5MHorhAlB59SMXUlcBITETu89qjYqSiPOxqL0Aq0WuNS8tdjO4AZOzml8UTL5CfW0p/AsWU5fZR2Cfw+La1sl2XuNLHf3LnjeGAExeODqaxP5QfHsxK/lMV//lEnZTsR9bepTWjNZmp7JqVTcZxDNhcgrx5c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739371490; c=relaxed/simple;
	bh=XfitAFqPDqbf+t1RDk+0+jtBp+nPKjIX31JflvdkYZQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=J8bv/yS4/017bJrb+SYxjo6bBkw9oxih32k+81H20Pz2P9+NNZaCoUEB/21BonoLxMI0yT7vorFkfh/UVmuYGUVG1nI2BaFGzeM3gGgKe4fJQRbQCEe7R1SGzuF36G2gHkJRVuQ8bnzxRekqQVZfVXI9jBkJZeLhc70LtrSxdMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 748B512FC;
	Wed, 12 Feb 2025 06:45:07 -0800 (PST)
Received: from [10.57.81.93] (unknown [10.57.81.93])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B62FD3F6A8;
	Wed, 12 Feb 2025 06:44:43 -0800 (PST)
Message-ID: <deeb5864-449c-419e-9b45-abf8003b7b6a@arm.com>
Date: Wed, 12 Feb 2025 14:44:42 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/16] arm64: hugetlb: Fix huge_ptep_get_and_clear()
 for non-present ptes
Content-Language: en-GB
From: Ryan Roberts <ryan.roberts@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Muchun Song <muchun.song@linux.dev>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 Dev Jain <dev.jain@arm.com>, Alexandre Ghiti <alexghiti@rivosinc.com>,
 Steve Capper <steve.capper@linaro.org>, Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250205151003.88959-1-ryan.roberts@arm.com>
 <20250205151003.88959-3-ryan.roberts@arm.com>
 <83103cbb-e2b8-4177-aeaf-c3b6e6b08008@arm.com>
 <25155f6e-8a62-405e-852d-c07a55be0ac5@arm.com>
In-Reply-To: <25155f6e-8a62-405e-852d-c07a55be0ac5@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/02/2025 12:55, Ryan Roberts wrote:
> On 06/02/2025 06:15, Anshuman Khandual wrote:
>> On 2/5/25 20:39, Ryan Roberts wrote:
>>> arm64 supports multiple huge_pte sizes. Some of the sizes are covered by
>>> a single pte entry at a particular level (PMD_SIZE, PUD_SIZE), and some
>>> are covered by multiple ptes at a particular level (CONT_PTE_SIZE,
>>> CONT_PMD_SIZE). So the function has to figure out the size from the
>>> huge_pte pointer. This was previously done by walking the pgtable to
>>> determine the level, then using the PTE_CONT bit to determine the number
>>> of ptes.
>>
>> Actually PTE_CONT gets used to determine if the entry is normal i.e
>> PMD/PUD based huge page or cont PTE/PMD based huge page just to call
>> into standard __ptep_get_and_clear() or specific get_clear_contig(),
>> after determining find_num_contig() by walking the page table.
>>
>> PTE_CONT presence is only used to determine the switch above but not
>> to determine the number of ptes for the mapping as mentioned earlier.
> 
> Sorry I don't really follow your distinction; PTE_CONT is used to decide whether
> we are operating on a single entry (pte_cont()==false) or on multiple entires
> (pte_cont()==true). For the multiple entry case, the level tells you the exact
> number.
> 
> I can certainly tidy up this description a bit, but I think we both agree that
> the value of PTE_CONT is one of the inputs into deciding how many entries need
> to be operated on?
> 
>>
>> There are two similar functions which determines the 
>>
>> static int find_num_contig(struct mm_struct *mm, unsigned long addr,
>>                            pte_t *ptep, size_t *pgsize)
>> {
>>         pgd_t *pgdp = pgd_offset(mm, addr);
>>         p4d_t *p4dp;
>>         pud_t *pudp;
>>         pmd_t *pmdp;
>>
>>         *pgsize = PAGE_SIZE;
>>         p4dp = p4d_offset(pgdp, addr);
>>         pudp = pud_offset(p4dp, addr);
>>         pmdp = pmd_offset(pudp, addr);
>>         if ((pte_t *)pmdp == ptep) {
>>                 *pgsize = PMD_SIZE;
>>                 return CONT_PMDS;
>>         }
>>         return CONT_PTES;
>> }
>>
>> find_num_contig() already assumes that the entry is contig huge page and
>> it just finds whether it is PMD or PTE based one. This always requires a
>> prior PTE_CONT bit being set determination via pte_cont() before calling
>> find_num_contig() in each instance.
> 
> Agreed.
> 
>>
>> But num_contig_ptes() can get the same information without walking the
>> page table and thus without predetermining if PTE_CONT is set or not.
>> size can be derived from VMA argument when present.
> 
> Also agreed. But VMA is not provided to this function. And because we want to
> use it for kernel space mappings, I think it's a bad idea to pass VMA.
> 
>>
>> static inline int num_contig_ptes(unsigned long size, size_t *pgsize)
>> {
>>         int contig_ptes = 0;
>>
>>         *pgsize = size;
>>
>>         switch (size) {
>> #ifndef __PAGETABLE_PMD_FOLDED
>>         case PUD_SIZE:
>>                 if (pud_sect_supported())
>>                         contig_ptes = 1;
>>                 break;
>> #endif
>>         case PMD_SIZE:
>>                 contig_ptes = 1;
>>                 break;
>>         case CONT_PMD_SIZE:
>>                 *pgsize = PMD_SIZE;
>>                 contig_ptes = CONT_PMDS;
>>                 break;
>>         case CONT_PTE_SIZE:
>>                 *pgsize = PAGE_SIZE;
>>                 contig_ptes = CONT_PTES;
>>                 break;
>>         }
>>
>>         return contig_ptes;
>> }
>>
>> On a side note, why cannot num_contig_ptes() be used all the time and
>> find_num_contig() be dropped ? OR am I missing something here.
> 
> There are 2 remaining users of find_num_contig() after my series:
> huge_ptep_set_access_flags() and huge_ptep_set_wrprotect(). Both of them can
> only be legitimately called for present ptes (so its safe to check pte_cont()).
> huge_ptep_set_access_flags() already has the VMA so it would be easy to convert
> to num_contig_ptes(). huge_ptep_set_wrprotect() doesn't have the VMA but I guess
> you could do the trick where you take the size of the folio that the pte points to?
> 
> So yes, I think we could drop find_num_contig() and I agree it would be an
> improvement.
> 
> But to be honest, grabbing the folio size also feels like a hack to me (we do
> this in other places too). While today, the folio size is guarranteed to be be
> the same size as the huge pte in practice, I'm not sure there is any spec that
> mandates that?
> 
> Perhaps the most robust thing is to just have a PTE_CONT bit for the swap-pte so
> we can tell the size of both present and non-present ptes, then do the table
> walk trick to find the level. Shrug.
> 
>>
>>>
>>> But the PTE_CONT bit is only valid when the pte is present. For
>>> non-present pte values (e.g. markers, migration entries), the previous
>>> implementation was therefore erroniously determining the size. There is
>>> at least one known caller in core-mm, move_huge_pte(), which may call
>>> huge_ptep_get_and_clear() for a non-present pte. So we must be robust to
>>> this case. Additionally the "regular" ptep_get_and_clear() is robust to
>>> being called for non-present ptes so it makes sense to follow the
>>> behaviour.
>>
>> With VMA argument and num_contig_ptes() dependency on PTE_CONT being set
>> and the entry being mapped might not be required.
>>>>
>>> Fix this by using the new sz parameter which is now provided to the
>>> function. Additionally when clearing each pte in a contig range, don't
>>> gather the access and dirty bits if the pte is not present.
>>
>> Makes sense.
>>
>>>
>>> An alternative approach that would not require API changes would be to
>>> store the PTE_CONT bit in a spare bit in the swap entry pte. But it felt
>>> cleaner to follow other APIs' lead and just pass in the size.
>>
>> Right, changing the arguments in the API will help solve this problem.
>>
>>>
>>> While we are at it, add some debug warnings in functions that require
>>> the pte is present.
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
>>> and cleared out potentially-present neighboring PTEs.
>>>
>>> Cc: <stable@vger.kernel.org>
>>> Fixes: 66b3923a1a0f ("arm64: hugetlb: add support for PTE contiguous bit")
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> ---
>>>  arch/arm64/mm/hugetlbpage.c | 54 ++++++++++++++++++++-----------------
>>>  1 file changed, 29 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
>>> index 06db4649af91..328eec4bfe55 100644
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
>>> +	while (--ncontig) {
>>
>> Although this does the right thing by calling __ptep_get_and_clear() once
>> for non-contig huge pages but wondering if cont/non-cont separation should
>> be maintained in the caller huge_ptep_get_and_clear(), keeping the current
>> logical bifurcation intact.
> 
> To what benefit?
> 
>>
>>> +		ptep++;
>>> +		addr += pgsize;
>>> +		tmp_pte = __ptep_get_and_clear(mm, addr, ptep);
>>> +		if (present) {
>>
>> Checking for present entries makes sense here.
>>
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
>>
>> __ptep_get_and_clear() can still be called here if 'ncontig' is
>> returned as 0 indicating a normal non-contig huge page thus
>> keeping get_clear_contig() unchanged just to handle contig huge
>> pages.
> 
> I think you're describing the case where num_contig_ptes() returns 0? The
> intention, from my reading of the function, is that num_contig_ptes() returns
> the number of ptes that need to be operated on (e.g. 1 for a single entry or N
> for a contig block). It will only return 0 if called with an invalid huge size.
> I don't believe it will ever "return 0 indicating a normal non-contig huge page".
> 
> Perhaps the right solution is to add a warning if returning 0?
> 
>>
>>>  	return get_clear_contig(mm, addr, ptep, pgsize, ncontig);
>>>  }
>>>  
>>> @@ -451,6 +445,8 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>>>  	pgprot_t hugeprot;
>>>  	pte_t orig_pte;
>>>  
>>> +	VM_WARN_ON(!pte_present(pte));
>>> +
>>>  	if (!pte_cont(pte))
>>>  		return __ptep_set_access_flags(vma, addr, ptep, pte, dirty);
>>>  
>>> @@ -461,6 +457,7 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>>>  		return 0;
>>>  
>>>  	orig_pte = get_clear_contig_flush(mm, addr, ptep, pgsize, ncontig);
>>> +	VM_WARN_ON(!pte_present(orig_pte));
>>>  
>>>  	/* Make sure we don't lose the dirty or young state */
>>>  	if (pte_dirty(orig_pte))
>>> @@ -485,7 +482,10 @@ void huge_ptep_set_wrprotect(struct mm_struct *mm,
>>>  	size_t pgsize;
>>>  	pte_t pte;
>>>  
>>> -	if (!pte_cont(__ptep_get(ptep))) {
>>> +	pte = __ptep_get(ptep);
>>> +	VM_WARN_ON(!pte_present(pte));
>>> +
>>> +	if (!pte_cont(pte)) {
>>>  		__ptep_set_wrprotect(mm, addr, ptep);
>>>  		return;
>>>  	}
>>> @@ -509,8 +509,12 @@ pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
>>>  	struct mm_struct *mm = vma->vm_mm;
>>>  	size_t pgsize;
>>>  	int ncontig;
>>> +	pte_t pte;
>>>  
>>> -	if (!pte_cont(__ptep_get(ptep)))
>>> +	pte = __ptep_get(ptep);
>>> +	VM_WARN_ON(!pte_present(pte));
>>> +
>>> +	if (!pte_cont(pte))
>>>  		return ptep_clear_flush(vma, addr, ptep);
>>>  
>>>  	ncontig = find_num_contig(mm, addr, ptep, &pgsize);
>>
>> In all the above instances should not num_contig_ptes() be called to determine
>> if a given entry is non-contig or contig huge page, thus dropping the need for
>> pte_cont() and pte_present() tests as proposed here.
> 
> Yeah maybe. But as per above, we have options for how to do that. I'm not sure
> which is preferable at the moment. What do you think? Regardless, I think that
> cleanup would be a separate patch (which I'm happy to add for v2). For this bug
> fix, I was trying to do the minimum.

I took another look at this; I concluded that we should switch from
find_num_contig() to num_contig_ptes() for the 2 cases where we have the vma and
can therefore directly get the huge_ptep size.

That leaves one callsite in huge_ptep_set_wrprotect(), which doesn't have the
vma. One approach would be to grab the folio out of the pte and use the size of
the folio. That's already done in huge_ptep_get(). But actually I think that's a
very brittle approach because there is nothing stoping the size of the folio
from changing in future (you could have a folio twice the size mapped by 2
huge_ptes for example). So I'm actually proposing to keep find_num_contig() and
use it additionally in huge_ptep_get(). That will mean we end up with 2
callsites for find_num_contig(), and 0 places that infer the huge_pte size from
the folio size. I think that's much cleaner personally. I'll do this for v2.

Thanks,
Ryan

> 
> Thanks,
> Ryan
> 
> 


