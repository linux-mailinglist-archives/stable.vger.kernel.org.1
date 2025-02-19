Return-Path: <stable+bounces-117275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE58A3B5BD
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BBA3189D795
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 08:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAEC1F463E;
	Wed, 19 Feb 2025 08:46:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135D01F2BA1;
	Wed, 19 Feb 2025 08:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739954762; cv=none; b=BTxK2TTjUvplNezL7MJn4RoqRvGW4jZbrn3gvCUIlGZmUXAz59sWa5B3/NuMlX0V2qgQVghGfF4KWelCGTRjgmG5ZVO9ivhwEELbGsV7UER+nkUfLw0nouUNrJSf54qwcw28TLrLvv5ijThbfmB2zVw+ObQnoDp1nHRmwtAPNTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739954762; c=relaxed/simple;
	bh=/YM69NyeXToXoYl863l8m7IiKZJ+g4qrds2ofWwdqjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RmEf31y2ET93FCcs2M+JpEhL5Df/9tvHuti9ZwP9sRBsYYN0rLlAn5I79F9iXe5N7k79/ugleijl1yVeXnNVGNoFJxvXrC0OHZQooII4PHRWNiR+ZQd4wVCGQ/SXNCLBr8RHolTKHjsupS4xvnD1VKhJYRr2gapIYLwUOm29SKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAC461682;
	Wed, 19 Feb 2025 00:46:18 -0800 (PST)
Received: from [10.162.42.6] (unknown [10.162.42.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E695D3F5A1;
	Wed, 19 Feb 2025 00:45:47 -0800 (PST)
Message-ID: <e26a59a1-ff9a-49c7-b10a-c3f5c096a2c4@arm.com>
Date: Wed, 19 Feb 2025 14:15:44 +0530
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
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250217140419.1702389-3-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/17/25 19:34, Ryan Roberts wrote:
> arm64 supports multiple huge_pte sizes. Some of the sizes are covered by
> a single pte entry at a particular level (PMD_SIZE, PUD_SIZE), and some
> are covered by multiple ptes at a particular level (CONT_PTE_SIZE,
> CONT_PMD_SIZE). So the function has to figure out the size from the
> huge_pte pointer. This was previously done by walking the pgtable to
> determine the level and by using the PTE_CONT bit to determine the
> number of ptes at the level.
> 
> But the PTE_CONT bit is only valid when the pte is present. For
> non-present pte values (e.g. markers, migration entries), the previous
> implementation was therefore erroniously determining the size. There is
> at least one known caller in core-mm, move_huge_pte(), which may call
> huge_ptep_get_and_clear() for a non-present pte. So we must be robust to
> this case. Additionally the "regular" ptep_get_and_clear() is robust to
> being called for non-present ptes so it makes sense to follow the
> behaviour.
> 
> Fix this by using the new sz parameter which is now provided to the
> function. Additionally when clearing each pte in a contig range, don't
> gather the access and dirty bits if the pte is not present.
> 
> An alternative approach that would not require API changes would be to
> store the PTE_CONT bit in a spare bit in the swap entry pte for the
> non-present case. But it felt cleaner to follow other APIs' lead and
> just pass in the size.
> 
> As an aside, PTE_CONT is bit 52, which corresponds to bit 40 in the swap
> entry offset field (layout of non-present pte). Since hugetlb is never
> swapped to disk, this field will only be populated for markers, which
> always set this bit to 0 and hwpoison swap entries, which set the offset
> field to a PFN; So it would only ever be 1 for a 52-bit PVA system where
> memory in that high half was poisoned (I think!). So in practice, this
> bit would almost always be zero for non-present ptes and we would only
> clear the first entry if it was actually a contiguous block. That's
> probably a less severe symptom than if it was always interpretted as 1
> and cleared out potentially-present neighboring PTEs.
> 
> Cc: stable@vger.kernel.org
> Fixes: 66b3923a1a0f ("arm64: hugetlb: add support for PTE contiguous bit")
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  arch/arm64/mm/hugetlbpage.c | 40 ++++++++++++++++---------------------
>  1 file changed, 17 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index 06db4649af91..614b2feddba2 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -163,24 +163,23 @@ static pte_t get_clear_contig(struct mm_struct *mm,
>  			     unsigned long pgsize,
>  			     unsigned long ncontig)
>  {
> -	pte_t orig_pte = __ptep_get(ptep);
> -	unsigned long i;
> -
> -	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++) {
> -		pte_t pte = __ptep_get_and_clear(mm, addr, ptep);
> -
> -		/*
> -		 * If HW_AFDBM is enabled, then the HW could turn on
> -		 * the dirty or accessed bit for any page in the set,
> -		 * so check them all.
> -		 */
> -		if (pte_dirty(pte))
> -			orig_pte = pte_mkdirty(orig_pte);
> -
> -		if (pte_young(pte))
> -			orig_pte = pte_mkyoung(orig_pte);
> +	pte_t pte, tmp_pte;
> +	bool present;
> +
> +	pte = __ptep_get_and_clear(mm, addr, ptep);
> +	present = pte_present(pte);

pte_present() may not be evaluated for standard huge pages at [PMD|PUD]_SIZE
e.g when ncontig = 1 in the argument.

> +	while (--ncontig) {

Should this be converted into a for loop instead just to be in sync with other
similar iterators in this file.

for (i = 1; i < ncontig; i++, addr += pgsize, ptep++)
{
	tmp_pte = __ptep_get_and_clear(mm, addr, ptep);
	if (present) {
		if (pte_dirty(tmp_pte))
			pte = pte_mkdirty(pte);
		if (pte_young(tmp_pte))
			pte = pte_mkyoung(pte);
	}
}

> +		ptep++;
> +		addr += pgsize;
> +		tmp_pte = __ptep_get_and_clear(mm, addr, ptep);
> +		if (present) {
> +			if (pte_dirty(tmp_pte))
> +				pte = pte_mkdirty(pte);
> +			if (pte_young(tmp_pte))
> +				pte = pte_mkyoung(pte);
> +		}
>  	}
> -	return orig_pte;
> +	return pte;
>  }
>  
>  static pte_t get_clear_contig_flush(struct mm_struct *mm,
> @@ -401,13 +400,8 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
>  {
>  	int ncontig;
>  	size_t pgsize;
> -	pte_t orig_pte = __ptep_get(ptep);
> -
> -	if (!pte_cont(orig_pte))
> -		return __ptep_get_and_clear(mm, addr, ptep);
> -
> -	ncontig = find_num_contig(mm, addr, ptep, &pgsize);
>  
> +	ncontig = num_contig_ptes(sz, &pgsize);
>  	return get_clear_contig(mm, addr, ptep, pgsize, ncontig);
>  }
>  

