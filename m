Return-Path: <stable+bounces-121348-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 958B5A5634F
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 10:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE6C817501D
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 09:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7936B1EA7E5;
	Fri,  7 Mar 2025 09:11:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B83C1A8F60
	for <stable@vger.kernel.org>; Fri,  7 Mar 2025 09:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741338680; cv=none; b=bdnZNu02I/8lUwJkaCzlnGipIPtxbKgLkYR53y14gqtH6Nrk4SyNzpRK/R3zpYG+ZMVLYV6c7JbsVsHXHhppM5J/QnKqn9GesKDnB9ZDNBWpAlwfD776eyoBn+4d9v8s2KNjI0eFaI74McQy1A28MWXtWbFFuuZostgU50cD6Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741338680; c=relaxed/simple;
	bh=sHQ6fPpIZ/xgxPDWFTNuvjItDQG3Q/aAEHACQpwLCq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oE6WOBdLyUXMkUySV9kDYq7GANaI+d0T2BCRfhXIoT8TsKPt8pK6kpht/F0lcdovGLxWO9UUITYCTLVWVLitS4Tg34xWU+U5wUzomGMejvuxkX1HybHa95ey3YJ0Irs9JaqDa9OLWp0aPKEmiwbq8bWh5n8n+5qxum9ua0x0VKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CF831477;
	Fri,  7 Mar 2025 01:11:27 -0800 (PST)
Received: from [10.57.84.99] (unknown [10.57.84.99])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BE283F66E;
	Fri,  7 Mar 2025 01:11:14 -0800 (PST)
Message-ID: <518c5b76-5c49-40ad-a781-6dd82417d3f5@arm.com>
Date: Fri, 7 Mar 2025 09:11:12 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6.y] mm: hugetlb: Add huge page size param to
 huge_ptep_get_and_clear()
Content-Language: en-GB
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
References: <20250306115456-fb0607449ea03461@stable.kernel.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250306115456-fb0607449ea03461@stable.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06/03/2025 19:11, Sasha Levin wrote:
> [ Sasha's backport helper bot ]
> 
> Hi,
> 
> Summary of potential issues:
> ⚠️ Found matching upstream commit but patch is missing proper reference to it

Hi,

I'm not sure what the issue is here? I've added the line:

(cherry picked from commit 02410ac72ac3707936c07ede66e94360d0d65319)

to the commit log. Is that not the correct/sufficient thing to do?

Thanks,
Ryan

> 
> Found matching upstream commit: 02410ac72ac3707936c07ede66e94360d0d65319
> 
> Note: The patch differs from the upstream commit:
> ---
> 1:  02410ac72ac37 ! 1:  db66591c2390e mm: hugetlb: Add huge page size param to huge_ptep_get_and_clear()
>     @@ Commit message
>          Acked-by: Alexander Gordeev <agordeev@linux.ibm.com> # s390
>          Link: https://lore.kernel.org/r/20250226120656.2400136-2-ryan.roberts@arm.com
>          Signed-off-by: Will Deacon <will@kernel.org>
>     +    (cherry picked from commit 02410ac72ac3707936c07ede66e94360d0d65319)
>     +    Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>      
>       ## arch/arm64/include/asm/hugetlb.h ##
>      @@ arch/arm64/include/asm/hugetlb.h: extern int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>     @@ arch/arm64/include/asm/hugetlb.h: extern int huge_ptep_set_access_flags(struct v
>      
>       ## arch/arm64/mm/hugetlbpage.c ##
>      @@ arch/arm64/mm/hugetlbpage.c: void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
>     - 		__pte_clear(mm, addr, ptep);
>     + 		pte_clear(mm, addr, ptep);
>       }
>       
>      -pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
>     @@ arch/arm64/mm/hugetlbpage.c: bool __init arch_hugetlb_valid_size(unsigned long s
>       {
>      +	unsigned long psize = huge_page_size(hstate_vma(vma));
>      +
>     - 	if (alternative_has_cap_unlikely(ARM64_WORKAROUND_2645198)) {
>     + 	if (IS_ENABLED(CONFIG_ARM64_ERRATUM_2645198) &&
>     + 	    cpus_have_const_cap(ARM64_WORKAROUND_2645198)) {
>       		/*
>     - 		 * Break-before-make (BBM) is required for all user space mappings
>      @@ arch/arm64/mm/hugetlbpage.c: pte_t huge_ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr
>     - 		if (pte_user_exec(__ptep_get(ptep)))
>     + 		if (pte_user_exec(READ_ONCE(*ptep)))
>       			return huge_ptep_clear_flush(vma, addr, ptep);
>       	}
>      -	return huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
>     @@ arch/loongarch/include/asm/hugetlb.h: static inline void huge_pte_clear(struct m
>      +					    unsigned long sz)
>       {
>       	pte_t clear;
>     - 	pte_t pte = ptep_get(ptep);
>     + 	pte_t pte = *ptep;
>      @@ arch/loongarch/include/asm/hugetlb.h: static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
>       					  unsigned long addr, pte_t *ptep)
>       {
>     @@ arch/parisc/include/asm/hugetlb.h: void set_huge_pte_at(struct mm_struct *mm, un
>      -			      pte_t *ptep);
>      +			      pte_t *ptep, unsigned long sz);
>       
>     - #define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
>     - static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
>     + /*
>     +  * If the arch doesn't supply something else, assume that hugepage
>      
>       ## arch/parisc/mm/hugetlbpage.c ##
>      @@ arch/parisc/mm/hugetlbpage.c: void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
>     @@ arch/parisc/mm/hugetlbpage.c: void set_huge_pte_at(struct mm_struct *mm, unsigne
>       
>      
>       ## arch/powerpc/include/asm/hugetlb.h ##
>     -@@ arch/powerpc/include/asm/hugetlb.h: void set_huge_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
>     +@@ arch/powerpc/include/asm/hugetlb.h: void hugetlb_free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
>       
>       #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
>       static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
>     @@ arch/riscv/mm/hugetlbpage.c: int huge_ptep_set_access_flags(struct vm_area_struc
>       	int pte_num;
>      
>       ## arch/s390/include/asm/hugetlb.h ##
>     -@@ arch/s390/include/asm/hugetlb.h: void __set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
>     - #define __HAVE_ARCH_HUGE_PTEP_GET
>     - pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
>     - 
>     +@@ arch/s390/include/asm/hugetlb.h: void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
>     + void __set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
>     + 		     pte_t *ptep, pte_t pte);
>     + pte_t huge_ptep_get(pte_t *ptep);
>     +-pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
>     +-			      unsigned long addr, pte_t *ptep);
>      +pte_t __huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
>      +				pte_t *ptep);
>      +
>     - #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
>     --pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
>      +static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
>      +					    unsigned long addr, pte_t *ptep,
>      +					    unsigned long sz)
>     @@ arch/s390/include/asm/hugetlb.h: void __set_huge_pte_at(struct mm_struct *mm, un
>      +	return __huge_ptep_get_and_clear(mm, addr, ptep);
>      +}
>       
>     - static inline void arch_clear_hugetlb_flags(struct folio *folio)
>     - {
>     + /*
>     +  * If the arch doesn't supply something else, assume that hugepage
>      @@ arch/s390/include/asm/hugetlb.h: static inline void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
>       static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
>       					  unsigned long address, pte_t *ptep)
>     @@ arch/s390/include/asm/hugetlb.h: static inline void huge_pte_clear(struct mm_str
>      +	return __huge_ptep_get_and_clear(vma->vm_mm, address, ptep);
>       }
>       
>     - #define  __HAVE_ARCH_HUGE_PTEP_SET_ACCESS_FLAGS
>     + static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>      @@ arch/s390/include/asm/hugetlb.h: static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>     - 	int changed = !pte_same(huge_ptep_get(vma->vm_mm, addr, ptep), pte);
>     - 
>     + {
>     + 	int changed = !pte_same(huge_ptep_get(ptep), pte);
>       	if (changed) {
>      -		huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
>      +		__huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
>     @@ arch/s390/include/asm/hugetlb.h: static inline int huge_ptep_set_access_flags(st
>       {
>      -	pte_t pte = huge_ptep_get_and_clear(mm, addr, ptep);
>      +	pte_t pte = __huge_ptep_get_and_clear(mm, addr, ptep);
>     - 
>       	__set_huge_pte_at(mm, addr, ptep, pte_wrprotect(pte));
>       }
>     + 
>      
>       ## arch/s390/mm/hugetlbpage.c ##
>     -@@ arch/s390/mm/hugetlbpage.c: pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
>     +@@ arch/s390/mm/hugetlbpage.c: pte_t huge_ptep_get(pte_t *ptep)
>       	return __rste_to_pte(pte_val(*ptep));
>       }
>       
>     @@ arch/s390/mm/hugetlbpage.c: pte_t huge_ptep_get(struct mm_struct *mm, unsigned l
>      +pte_t __huge_ptep_get_and_clear(struct mm_struct *mm,
>      +				unsigned long addr, pte_t *ptep)
>       {
>     - 	pte_t pte = huge_ptep_get(mm, addr, ptep);
>     + 	pte_t pte = huge_ptep_get(ptep);
>       	pmd_t *pmdp = (pmd_t *) ptep;
>      
>       ## arch/sparc/include/asm/hugetlb.h ##
>     @@ mm/hugetlb.c: static void move_huge_pte(struct vm_area_struct *vma, unsigned lon
>       
>      -	pte = huge_ptep_get_and_clear(mm, old_addr, src_pte);
>      +	pte = huge_ptep_get_and_clear(mm, old_addr, src_pte, sz);
>     + 	set_huge_pte_at(mm, new_addr, dst_pte, pte, sz);
>       
>     - 	if (need_clear_uffd_wp && pte_marker_uffd_wp(pte))
>     - 		huge_pte_clear(mm, new_addr, dst_pte, sz);
>     + 	if (src_ptl != dst_ptl)
>      @@ mm/hugetlb.c: void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
>       			set_vma_resv_flags(vma, HPAGE_RESV_UNMAPPED);
>       		}
> ---
> 
> Results of testing on various branches:
> 
> | Branch                    | Patch Apply | Build Test |
> |---------------------------|-------------|------------|
> | stable/linux-6.6.y        |  Success    |  Success   |


