Return-Path: <stable+bounces-121311-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA86A55640
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 20:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FE641896D1E
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 19:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F22E26D5B8;
	Thu,  6 Mar 2025 19:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2NLyz0L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F06263F5F
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 19:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741288290; cv=none; b=s55Si31F8MA5hfsouuBbeV7xes8zRxNer5sNd23t7i6YSH8C/u8KPRwF22WTWTbUYqOnqjjAXOEXpnnF/STQhamm1SSVofWsYjMZAV/y95tLqPBnJxd7y2RITekeYvQ+kVhRCEBygqB9AWowV2SQrg/LozvkfYtqZphZE8y+gso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741288290; c=relaxed/simple;
	bh=xtC4Ap5tLEMZIzqzkh9PV2oxOdOhVJAG5xPsjLoMEXw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aB0hdSu8owi1f2v0y6NSG42GcpNaLrA+IwBcrMd8+O0T0PftleVSx+JTuB55dbpC+FZDCi7LBfvFyH//c1sR0i85ettrdmJtHMFAYi/RhiZFnhJId5mJ012h5lVtgMwYWhGCugVZztcZV+DpM+tBTDb4xUhyjYF5a5Q3gkS57Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2NLyz0L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E134DC4CEE0;
	Thu,  6 Mar 2025 19:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741288290;
	bh=xtC4Ap5tLEMZIzqzkh9PV2oxOdOhVJAG5xPsjLoMEXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W2NLyz0LfKGdpFbDws927RAiZ9jXHFwmHA2HAYaKx2mRreOPWGGgR075dreyeQn7d
	 fGyJQbiL/PV087WmnqZg7x0ozldArzuLK66+AtVA6L7AffzOJk81f3kV+cOtyHELAb
	 +vipuO1PBQc4TklRChsUAi9mMKy5+3bcoEUZjTC99DXEL+cBHxX9EBD5Gb2cnPIeoo
	 2Sqqwyi5w91snBjv5S1iOUIcgn21B2nlrzzpMCRdpYLAoTYD467AKdeUhmqjqAD6Rb
	 N+QBkouJLx542ltOK3lrh2Liuu2z+1v4MFufL0vdAxWa7hTJqFmDmHWPjjTMqpPnN7
	 EdxTK+kZgj0uw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ryan.roberts@arm.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] mm: hugetlb: Add huge page size param to huge_ptep_get_and_clear()
Date: Thu,  6 Mar 2025 14:11:28 -0500
Message-Id: <20250306115456-fb0607449ea03461@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250306144716.71199-1-ryan.roberts@arm.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 02410ac72ac3707936c07ede66e94360d0d65319

Note: The patch differs from the upstream commit:
---
1:  02410ac72ac37 ! 1:  db66591c2390e mm: hugetlb: Add huge page size param to huge_ptep_get_and_clear()
    @@ Commit message
         Acked-by: Alexander Gordeev <agordeev@linux.ibm.com> # s390
         Link: https://lore.kernel.org/r/20250226120656.2400136-2-ryan.roberts@arm.com
         Signed-off-by: Will Deacon <will@kernel.org>
    +    (cherry picked from commit 02410ac72ac3707936c07ede66e94360d0d65319)
    +    Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
     
      ## arch/arm64/include/asm/hugetlb.h ##
     @@ arch/arm64/include/asm/hugetlb.h: extern int huge_ptep_set_access_flags(struct vm_area_struct *vma,
    @@ arch/arm64/include/asm/hugetlb.h: extern int huge_ptep_set_access_flags(struct v
     
      ## arch/arm64/mm/hugetlbpage.c ##
     @@ arch/arm64/mm/hugetlbpage.c: void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
    - 		__pte_clear(mm, addr, ptep);
    + 		pte_clear(mm, addr, ptep);
      }
      
     -pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
    @@ arch/arm64/mm/hugetlbpage.c: bool __init arch_hugetlb_valid_size(unsigned long s
      {
     +	unsigned long psize = huge_page_size(hstate_vma(vma));
     +
    - 	if (alternative_has_cap_unlikely(ARM64_WORKAROUND_2645198)) {
    + 	if (IS_ENABLED(CONFIG_ARM64_ERRATUM_2645198) &&
    + 	    cpus_have_const_cap(ARM64_WORKAROUND_2645198)) {
      		/*
    - 		 * Break-before-make (BBM) is required for all user space mappings
     @@ arch/arm64/mm/hugetlbpage.c: pte_t huge_ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr
    - 		if (pte_user_exec(__ptep_get(ptep)))
    + 		if (pte_user_exec(READ_ONCE(*ptep)))
      			return huge_ptep_clear_flush(vma, addr, ptep);
      	}
     -	return huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
    @@ arch/loongarch/include/asm/hugetlb.h: static inline void huge_pte_clear(struct m
     +					    unsigned long sz)
      {
      	pte_t clear;
    - 	pte_t pte = ptep_get(ptep);
    + 	pte_t pte = *ptep;
     @@ arch/loongarch/include/asm/hugetlb.h: static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
      					  unsigned long addr, pte_t *ptep)
      {
    @@ arch/parisc/include/asm/hugetlb.h: void set_huge_pte_at(struct mm_struct *mm, un
     -			      pte_t *ptep);
     +			      pte_t *ptep, unsigned long sz);
      
    - #define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
    - static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
    + /*
    +  * If the arch doesn't supply something else, assume that hugepage
     
      ## arch/parisc/mm/hugetlbpage.c ##
     @@ arch/parisc/mm/hugetlbpage.c: void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
    @@ arch/parisc/mm/hugetlbpage.c: void set_huge_pte_at(struct mm_struct *mm, unsigne
      
     
      ## arch/powerpc/include/asm/hugetlb.h ##
    -@@ arch/powerpc/include/asm/hugetlb.h: void set_huge_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
    +@@ arch/powerpc/include/asm/hugetlb.h: void hugetlb_free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
      
      #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
      static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
    @@ arch/riscv/mm/hugetlbpage.c: int huge_ptep_set_access_flags(struct vm_area_struc
      	int pte_num;
     
      ## arch/s390/include/asm/hugetlb.h ##
    -@@ arch/s390/include/asm/hugetlb.h: void __set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
    - #define __HAVE_ARCH_HUGE_PTEP_GET
    - pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
    - 
    +@@ arch/s390/include/asm/hugetlb.h: void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
    + void __set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
    + 		     pte_t *ptep, pte_t pte);
    + pte_t huge_ptep_get(pte_t *ptep);
    +-pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
    +-			      unsigned long addr, pte_t *ptep);
     +pte_t __huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
     +				pte_t *ptep);
     +
    - #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
    --pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
     +static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
     +					    unsigned long addr, pte_t *ptep,
     +					    unsigned long sz)
    @@ arch/s390/include/asm/hugetlb.h: void __set_huge_pte_at(struct mm_struct *mm, un
     +	return __huge_ptep_get_and_clear(mm, addr, ptep);
     +}
      
    - static inline void arch_clear_hugetlb_flags(struct folio *folio)
    - {
    + /*
    +  * If the arch doesn't supply something else, assume that hugepage
     @@ arch/s390/include/asm/hugetlb.h: static inline void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
      static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
      					  unsigned long address, pte_t *ptep)
    @@ arch/s390/include/asm/hugetlb.h: static inline void huge_pte_clear(struct mm_str
     +	return __huge_ptep_get_and_clear(vma->vm_mm, address, ptep);
      }
      
    - #define  __HAVE_ARCH_HUGE_PTEP_SET_ACCESS_FLAGS
    + static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
     @@ arch/s390/include/asm/hugetlb.h: static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
    - 	int changed = !pte_same(huge_ptep_get(vma->vm_mm, addr, ptep), pte);
    - 
    + {
    + 	int changed = !pte_same(huge_ptep_get(ptep), pte);
      	if (changed) {
     -		huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
     +		__huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
    @@ arch/s390/include/asm/hugetlb.h: static inline int huge_ptep_set_access_flags(st
      {
     -	pte_t pte = huge_ptep_get_and_clear(mm, addr, ptep);
     +	pte_t pte = __huge_ptep_get_and_clear(mm, addr, ptep);
    - 
      	__set_huge_pte_at(mm, addr, ptep, pte_wrprotect(pte));
      }
    + 
     
      ## arch/s390/mm/hugetlbpage.c ##
    -@@ arch/s390/mm/hugetlbpage.c: pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
    +@@ arch/s390/mm/hugetlbpage.c: pte_t huge_ptep_get(pte_t *ptep)
      	return __rste_to_pte(pte_val(*ptep));
      }
      
    @@ arch/s390/mm/hugetlbpage.c: pte_t huge_ptep_get(struct mm_struct *mm, unsigned l
     +pte_t __huge_ptep_get_and_clear(struct mm_struct *mm,
     +				unsigned long addr, pte_t *ptep)
      {
    - 	pte_t pte = huge_ptep_get(mm, addr, ptep);
    + 	pte_t pte = huge_ptep_get(ptep);
      	pmd_t *pmdp = (pmd_t *) ptep;
     
      ## arch/sparc/include/asm/hugetlb.h ##
    @@ mm/hugetlb.c: static void move_huge_pte(struct vm_area_struct *vma, unsigned lon
      
     -	pte = huge_ptep_get_and_clear(mm, old_addr, src_pte);
     +	pte = huge_ptep_get_and_clear(mm, old_addr, src_pte, sz);
    + 	set_huge_pte_at(mm, new_addr, dst_pte, pte, sz);
      
    - 	if (need_clear_uffd_wp && pte_marker_uffd_wp(pte))
    - 		huge_pte_clear(mm, new_addr, dst_pte, sz);
    + 	if (src_ptl != dst_ptl)
     @@ mm/hugetlb.c: void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
      			set_vma_resv_flags(vma, HPAGE_RESV_UNMAPPED);
      		}
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

