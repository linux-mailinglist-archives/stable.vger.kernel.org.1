Return-Path: <stable+bounces-118911-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1215A41EA2
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 13:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D59621888F6C
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6714C21931D;
	Mon, 24 Feb 2025 12:11:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78627219301;
	Mon, 24 Feb 2025 12:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740399089; cv=none; b=dVuukpq+KeVcIp+SLuzLkDQz0TM0KT7jYnSnWrYUBQcfUeKdSOm0hlr5Tpy4caipeZGxfcG9pWuLV4EQbzdzO7CI3pxfAjulSD1yyPyz8vR5Lj+RXmoXJ8x7uXz25LZmwphM8ZhQWvSC8s4RkP4m6q0MG4hmuaNAXgLH//nu4V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740399089; c=relaxed/simple;
	bh=Xm82ZS2iY1ImNq6BnOwcA9Je945VDDSXP6JhRRG4EGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=My0jiHqgiCN/iv/2yJipO5gC+PfOTRWQPLrc5JDLE53i+XisMbBwAdjC5auOzASUd/5zyfxTJTZHhXUqbjmMWYhq/+Q+qQLZiw6dWsE6Lkb96BWsuVjrzMcgH6+z5vxl2t+DbKTPyk39YWoTI91zxjss9LZ5B/c95JtbfcJAHl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 554841756;
	Mon, 24 Feb 2025 04:11:43 -0800 (PST)
Received: from [10.1.27.150] (XHFQ2J9959.cambridge.arm.com [10.1.27.150])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D6963F6A8;
	Mon, 24 Feb 2025 04:11:21 -0800 (PST)
Message-ID: <6ebf36f2-2e55-49b2-8764-90fd972d6e66@arm.com>
Date: Mon, 24 Feb 2025 12:11:19 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] arm64: hugetlb: Fix huge_ptep_get_and_clear() for
 non-present ptes
Content-Language: en-GB
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
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
 Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Dev Jain <dev.jain@arm.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250217140419.1702389-1-ryan.roberts@arm.com>
 <20250217140419.1702389-3-ryan.roberts@arm.com>
 <20250221153156.GC20567@willie-the-truck>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250221153156.GC20567@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/02/2025 15:31, Will Deacon wrote:
> On Mon, Feb 17, 2025 at 02:04:15PM +0000, Ryan Roberts wrote:
>> arm64 supports multiple huge_pte sizes. Some of the sizes are covered by
>> a single pte entry at a particular level (PMD_SIZE, PUD_SIZE), and some
>> are covered by multiple ptes at a particular level (CONT_PTE_SIZE,
>> CONT_PMD_SIZE). So the function has to figure out the size from the
>> huge_pte pointer. This was previously done by walking the pgtable to
>> determine the level and by using the PTE_CONT bit to determine the
>> number of ptes at the level.
>>
>> But the PTE_CONT bit is only valid when the pte is present. For
>> non-present pte values (e.g. markers, migration entries), the previous
>> implementation was therefore erroniously determining the size. There is
>> at least one known caller in core-mm, move_huge_pte(), which may call
>> huge_ptep_get_and_clear() for a non-present pte. So we must be robust to
>> this case. Additionally the "regular" ptep_get_and_clear() is robust to
>> being called for non-present ptes so it makes sense to follow the
>> behaviour.
>>
>> Fix this by using the new sz parameter which is now provided to the
>> function. Additionally when clearing each pte in a contig range, don't
>> gather the access and dirty bits if the pte is not present.
>>
>> An alternative approach that would not require API changes would be to
>> store the PTE_CONT bit in a spare bit in the swap entry pte for the
>> non-present case. But it felt cleaner to follow other APIs' lead and
>> just pass in the size.
>>
>> As an aside, PTE_CONT is bit 52, which corresponds to bit 40 in the swap
>> entry offset field (layout of non-present pte). Since hugetlb is never
>> swapped to disk, this field will only be populated for markers, which
>> always set this bit to 0 and hwpoison swap entries, which set the offset
>> field to a PFN; So it would only ever be 1 for a 52-bit PVA system where
>> memory in that high half was poisoned (I think!). So in practice, this
>> bit would almost always be zero for non-present ptes and we would only
>> clear the first entry if it was actually a contiguous block. That's
>> probably a less severe symptom than if it was always interpretted as 1
>> and cleared out potentially-present neighboring PTEs.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 66b3923a1a0f ("arm64: hugetlb: add support for PTE contiguous bit")
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>  arch/arm64/mm/hugetlbpage.c | 40 ++++++++++++++++---------------------
>>  1 file changed, 17 insertions(+), 23 deletions(-)
>>
>> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
>> index 06db4649af91..614b2feddba2 100644
>> --- a/arch/arm64/mm/hugetlbpage.c
>> +++ b/arch/arm64/mm/hugetlbpage.c
>> @@ -163,24 +163,23 @@ static pte_t get_clear_contig(struct mm_struct *mm,
>>  			     unsigned long pgsize,
>>  			     unsigned long ncontig)
>>  {
>> -	pte_t orig_pte = __ptep_get(ptep);
>> -	unsigned long i;
>> -
>> -	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++) {
>> -		pte_t pte = __ptep_get_and_clear(mm, addr, ptep);
>> -
>> -		/*
>> -		 * If HW_AFDBM is enabled, then the HW could turn on
>> -		 * the dirty or accessed bit for any page in the set,
>> -		 * so check them all.
>> -		 */
>> -		if (pte_dirty(pte))
>> -			orig_pte = pte_mkdirty(orig_pte);
>> -
>> -		if (pte_young(pte))
>> -			orig_pte = pte_mkyoung(orig_pte);
>> +	pte_t pte, tmp_pte;
>> +	bool present;
>> +
>> +	pte = __ptep_get_and_clear(mm, addr, ptep);
>> +	present = pte_present(pte);
>> +	while (--ncontig) {
>> +		ptep++;
>> +		addr += pgsize;
>> +		tmp_pte = __ptep_get_and_clear(mm, addr, ptep);
>> +		if (present) {
>> +			if (pte_dirty(tmp_pte))
>> +				pte = pte_mkdirty(pte);
>> +			if (pte_young(tmp_pte))
>> +				pte = pte_mkyoung(pte);
>> +		}
>>  	}
> 
> nit: With the loop now structured like this, we really can't handle
> num_contig_ptes() returning 0 if it gets an unknown size. Granted, that
> really shouldn't happen, but perhaps it would be better to add a 'default'
> case with a WARN() to num_contig_ptes() and then add an early return here?

Looking at other users of num_contig_ptes() it looks like huge_ptep_get()
already assumes at least 1 pte (it calls __ptep_get() before calling
num_contig_ptes()) and set_huge_pte_at() assumes 1 pte for the "present and
non-contig" case. So num_contig_ptes() returning 0 is already not really
consumed consistently.

How about we change the default num_contig_ptes() return value to 1 and add a
warning if size is invalid:

---8<---
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 614b2feddba2..b3a7fafe8892 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -100,20 +100,11 @@ static int find_num_contig(struct mm_struct *mm, unsigned
long addr,

 static inline int num_contig_ptes(unsigned long size, size_t *pgsize)
 {
-       int contig_ptes = 0;
+       int contig_ptes = 1;

        *pgsize = size;

        switch (size) {
-#ifndef __PAGETABLE_PMD_FOLDED
-       case PUD_SIZE:
-               if (pud_sect_supported())
-                       contig_ptes = 1;
-               break;
-#endif
-       case PMD_SIZE:
-               contig_ptes = 1;
-               break;
        case CONT_PMD_SIZE:
                *pgsize = PMD_SIZE;
                contig_ptes = CONT_PMDS;
@@ -122,6 +113,8 @@ static inline int num_contig_ptes(unsigned long size, size_t
*pgsize)
                *pgsize = PAGE_SIZE;
                contig_ptes = CONT_PTES;
                break;
+       default:
+               WARN_ON(!__hugetlb_valid_size(size));
        }

        return contig_ptes;
---8<---


> 
> Will


