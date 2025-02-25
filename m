Return-Path: <stable+bounces-119528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0CBA444C4
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 16:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A88623BCFBE
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 15:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE1D156236;
	Tue, 25 Feb 2025 15:43:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90FD1514EE;
	Tue, 25 Feb 2025 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740498193; cv=none; b=QBiXPvQYVy6nj6hQgSlTbcW8rgjfxJJHJ2p65R/aTWGYE0oHFjPMYttbIvxGKnMCpKY0IAJzuYM6YITAhKOflo75RSzn3gXrqk0Q0hccE1E6vovRpGN0LG7rtG9z25No0bnuS3qiMBsKvy+p8NWqIdJoULbNCRylePVSWbdP2iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740498193; c=relaxed/simple;
	bh=xAP+47DZFKHEnYSdNqrf7th9LYPiSBegW0KKE2VHFYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VaVG6hHgJQjbiyKLNhIZrrFD80KQ5WgipSQowSfJpPLHa215f/Pk6sPWuRsC8HANJ3PjgCJ0Sfzq29z2yQul5PKx69C/7ANXcDRspey0/8mWB0CchxHLb6b9/faVm2BIK7SAqOQawkx4T5BnTTcQbLwWrLxA77N3syGLKPuBxsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A0CD1BCB;
	Tue, 25 Feb 2025 07:43:27 -0800 (PST)
Received: from [10.1.27.154] (XHFQ2J9959.cambridge.arm.com [10.1.27.154])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF7D43F5A1;
	Tue, 25 Feb 2025 07:43:05 -0800 (PST)
Message-ID: <290f858c-07d4-4690-998c-2aefac664d7b@arm.com>
Date: Tue, 25 Feb 2025 15:43:04 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] mm: hugetlb: Add huge page size param to
 huge_ptep_get_and_clear()
Content-Language: en-GB
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
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
 <20250217140419.1702389-2-ryan.roberts@arm.com>
 <Z73Szw4rSHSyfpoy@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <Z73Szw4rSHSyfpoy@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/02/2025 14:25, Alexander Gordeev wrote:
> On Mon, Feb 17, 2025 at 02:04:14PM +0000, Ryan Roberts wrote:
> 
> Hi Ryan,
> 
>> In order to fix a bug, arm64 needs to be told the size of the huge page
>> for which the huge_pte is being set in huge_ptep_get_and_clear().
>> Provide for this by adding an `unsigned long sz` parameter to the
>> function. This follows the same pattern as huge_pte_clear() and
>> set_huge_pte_at().
>>
>> This commit makes the required interface modifications to the core mm as
>> well as all arches that implement this function (arm64, loongarch, mips,
>> parisc, powerpc, riscv, s390, sparc). The actual arm64 bug will be fixed
>> in a separate commit.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 66b3923a1a0f ("arm64: hugetlb: add support for PTE contiguous bit")
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
> ...
>> diff --git a/arch/s390/include/asm/hugetlb.h b/arch/s390/include/asm/hugetlb.h
>> index 7c52acaf9f82..420c74306779 100644
>> --- a/arch/s390/include/asm/hugetlb.h
>> +++ b/arch/s390/include/asm/hugetlb.h
>> @@ -26,7 +26,11 @@ void __set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
>>  pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
>>  
>>  #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
>> -pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
>> +pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
>> +			      unsigned long addr, pte_t *ptep,
>> +			      unsigned long sz);
> 
> Please, format parameters similarily to set_huge_pte_at() few lines above.

Appologies. I've fixed this for the next version.

> 
>> +pte_t __huge_ptep_get_and_clear(struct mm_struct *mm,
>> +			      unsigned long addr, pte_t *ptep);
> 
> The formatting is broken, but please see below.

Formatting fixed here too.

> 
>>  static inline void arch_clear_hugetlb_flags(struct folio *folio)
>>  {
>> @@ -48,7 +52,7 @@ static inline void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
>>  static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
>>  					  unsigned long address, pte_t *ptep)
>>  {
>> -	return huge_ptep_get_and_clear(vma->vm_mm, address, ptep);
>> +	return __huge_ptep_get_and_clear(vma->vm_mm, address, ptep);
>>  }
>>  
>>  #define  __HAVE_ARCH_HUGE_PTEP_SET_ACCESS_FLAGS
>> @@ -59,7 +63,7 @@ static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>>  	int changed = !pte_same(huge_ptep_get(vma->vm_mm, addr, ptep), pte);
>>  
>>  	if (changed) {
>> -		huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
>> +		__huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
>>  		__set_huge_pte_at(vma->vm_mm, addr, ptep, pte);
>>  	}
>>  	return changed;
>> @@ -69,7 +73,7 @@ static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>>  static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
>>  					   unsigned long addr, pte_t *ptep)
>>  {
>> -	pte_t pte = huge_ptep_get_and_clear(mm, addr, ptep);
>> +	pte_t pte = __huge_ptep_get_and_clear(mm, addr, ptep);
>>  
>>  	__set_huge_pte_at(mm, addr, ptep, pte_wrprotect(pte));
>>  }
>> diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
>> index d9ce199953de..52ee8e854195 100644
>> --- a/arch/s390/mm/hugetlbpage.c
>> +++ b/arch/s390/mm/hugetlbpage.c
>> @@ -188,8 +188,8 @@ pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
>>  	return __rste_to_pte(pte_val(*ptep));
>>  }
>>  
>> -pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
>> -			      unsigned long addr, pte_t *ptep)
>> +pte_t __huge_ptep_get_and_clear(struct mm_struct *mm,
>> +				unsigned long addr, pte_t *ptep)
>>  {
>>  	pte_t pte = huge_ptep_get(mm, addr, ptep);
>>  	pmd_t *pmdp = (pmd_t *) ptep;
>> @@ -202,6 +202,12 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
>>  	return pte;
>>  }
>>  
>> +pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
>> +			      unsigned long addr, pte_t *ptep, unsigned long sz)
>> +{
>> +	return __huge_ptep_get_and_clear(mm, addr, ptep);
>> +}
> 
> Is there a reason why this is not a header inline, as other callers of
> __huge_ptep_get_and_clear()?

I was trying to make the change as uninvasive as possible, so didn't want to
change the linkage in case I accidentally broke something. Happy to make this an
inline in the header though, if you prefer?

Thanks,
Ryan

> 
>>  pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
>>  			unsigned long addr, unsigned long sz)
>>  {
> ...
> 
> Thanks!


