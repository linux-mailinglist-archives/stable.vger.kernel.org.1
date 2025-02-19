Return-Path: <stable+bounces-116976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3BAA3B3BE
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2A3D3A9B5A
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 08:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE87C1C6889;
	Wed, 19 Feb 2025 08:29:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A101C5F2D;
	Wed, 19 Feb 2025 08:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953751; cv=none; b=bbJ2+UHmZLuePhL2R4AcuGSSzNiscP6U/DzG5hlmYJY+Q92lWQY0f3LBIdpPXU5yzirymzoq50wlDlcWtclxAxw3+pyxFvZgQ5CKY2TSQ2Rc+emHFXiNzBIhwA9FDHy/+XPWohSUKGselTYhIjHJJzJ5EsWQ/Cg8qygJEckc71s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953751; c=relaxed/simple;
	bh=DmBlM2Amou9IOO9lG847kMwpmvxngcDjmHNB4esG1Hw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UCn3BMciRUDHP68FdNcCE/aAcImhDe7U9Uh4ThLWou3LP2720mWS2CcjJw0qhmAdngmTcxJd9JIVY/rEx88NfbnU+S+Vtoulqqun8KBYfIjyf0kvXuUi/eyjWkLCahSWhzeNys0GGb10axwvPwc4scwWP1kAthKGttY50uvZtYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0329A1682;
	Wed, 19 Feb 2025 00:29:23 -0800 (PST)
Received: from [10.162.42.6] (unknown [10.162.42.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF78B3F5A1;
	Wed, 19 Feb 2025 00:28:51 -0800 (PST)
Message-ID: <01358598-c359-4dd8-bfa5-50483b427c03@arm.com>
Date: Wed, 19 Feb 2025 13:58:48 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] mm: hugetlb: Add huge page size param to
 huge_ptep_get_and_clear()
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
 <20250217140419.1702389-2-ryan.roberts@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250217140419.1702389-2-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/17/25 19:34, Ryan Roberts wrote:
> In order to fix a bug, arm64 needs to be told the size of the huge page
> for which the huge_pte is being set in huge_ptep_get_and_clear().
> Provide for this by adding an `unsigned long sz` parameter to the
> function. This follows the same pattern as huge_pte_clear() and
> set_huge_pte_at().
> 
> This commit makes the required interface modifications to the core mm as
> well as all arches that implement this function (arm64, loongarch, mips,
> parisc, powerpc, riscv, s390, sparc). The actual arm64 bug will be fixed
> in a separate commit.
> 
> Cc: stable@vger.kernel.org
> Fixes: 66b3923a1a0f ("arm64: hugetlb: add support for PTE contiguous bit")
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

LGTM

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  arch/arm64/include/asm/hugetlb.h     |  4 ++--
>  arch/arm64/mm/hugetlbpage.c          |  8 +++++---
>  arch/loongarch/include/asm/hugetlb.h |  6 ++++--
>  arch/mips/include/asm/hugetlb.h      |  6 ++++--
>  arch/parisc/include/asm/hugetlb.h    |  2 +-
>  arch/parisc/mm/hugetlbpage.c         |  2 +-
>  arch/powerpc/include/asm/hugetlb.h   |  6 ++++--
>  arch/riscv/include/asm/hugetlb.h     |  3 ++-
>  arch/riscv/mm/hugetlbpage.c          |  2 +-
>  arch/s390/include/asm/hugetlb.h      | 12 ++++++++----
>  arch/s390/mm/hugetlbpage.c           | 10 ++++++++--
>  arch/sparc/include/asm/hugetlb.h     |  2 +-
>  arch/sparc/mm/hugetlbpage.c          |  2 +-
>  include/asm-generic/hugetlb.h        |  2 +-
>  include/linux/hugetlb.h              |  4 +++-
>  mm/hugetlb.c                         |  4 ++--
>  16 files changed, 48 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
> index c6dff3e69539..03db9cb21ace 100644
> --- a/arch/arm64/include/asm/hugetlb.h
> +++ b/arch/arm64/include/asm/hugetlb.h
> @@ -42,8 +42,8 @@ extern int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>  				      unsigned long addr, pte_t *ptep,
>  				      pte_t pte, int dirty);
>  #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
> -extern pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
> -				     unsigned long addr, pte_t *ptep);
> +extern pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
> +				     pte_t *ptep, unsigned long sz);
>  #define __HAVE_ARCH_HUGE_PTEP_SET_WRPROTECT
>  extern void huge_ptep_set_wrprotect(struct mm_struct *mm,
>  				    unsigned long addr, pte_t *ptep);
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index 98a2a0e64e25..06db4649af91 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -396,8 +396,8 @@ void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
>  		__pte_clear(mm, addr, ptep);
>  }
>  
> -pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
> -			      unsigned long addr, pte_t *ptep)
> +pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
> +			      pte_t *ptep, unsigned long sz)
>  {
>  	int ncontig;
>  	size_t pgsize;
> @@ -549,6 +549,8 @@ bool __init arch_hugetlb_valid_size(unsigned long size)
>  
>  pte_t huge_ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
>  {
> +	unsigned long psize = huge_page_size(hstate_vma(vma));
> +
>  	if (alternative_has_cap_unlikely(ARM64_WORKAROUND_2645198)) {
>  		/*
>  		 * Break-before-make (BBM) is required for all user space mappings
> @@ -558,7 +560,7 @@ pte_t huge_ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr
>  		if (pte_user_exec(__ptep_get(ptep)))
>  			return huge_ptep_clear_flush(vma, addr, ptep);
>  	}
> -	return huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
> +	return huge_ptep_get_and_clear(vma->vm_mm, addr, ptep, psize);
>  }
>  
>  void huge_ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep,
> diff --git a/arch/loongarch/include/asm/hugetlb.h b/arch/loongarch/include/asm/hugetlb.h
> index c8e4057734d0..4dc4b3e04225 100644
> --- a/arch/loongarch/include/asm/hugetlb.h
> +++ b/arch/loongarch/include/asm/hugetlb.h
> @@ -36,7 +36,8 @@ static inline void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
>  
>  #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
>  static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
> -					    unsigned long addr, pte_t *ptep)
> +					    unsigned long addr, pte_t *ptep,
> +					    unsigned long sz)
>  {
>  	pte_t clear;
>  	pte_t pte = ptep_get(ptep);
> @@ -51,8 +52,9 @@ static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
>  					  unsigned long addr, pte_t *ptep)
>  {
>  	pte_t pte;
> +	unsigned long sz = huge_page_size(hstate_vma(vma));
>  
> -	pte = huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
> +	pte = huge_ptep_get_and_clear(vma->vm_mm, addr, ptep, sz);
>  	flush_tlb_page(vma, addr);
>  	return pte;
>  }
> diff --git a/arch/mips/include/asm/hugetlb.h b/arch/mips/include/asm/hugetlb.h
> index d0a86ce83de9..fbc71ddcf0f6 100644
> --- a/arch/mips/include/asm/hugetlb.h
> +++ b/arch/mips/include/asm/hugetlb.h
> @@ -27,7 +27,8 @@ static inline int prepare_hugepage_range(struct file *file,
>  
>  #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
>  static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
> -					    unsigned long addr, pte_t *ptep)
> +					    unsigned long addr, pte_t *ptep,
> +					    unsigned long sz)
>  {
>  	pte_t clear;
>  	pte_t pte = *ptep;
> @@ -42,13 +43,14 @@ static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
>  					  unsigned long addr, pte_t *ptep)
>  {
>  	pte_t pte;
> +	unsigned long sz = huge_page_size(hstate_vma(vma));
>  
>  	/*
>  	 * clear the huge pte entry firstly, so that the other smp threads will
>  	 * not get old pte entry after finishing flush_tlb_page and before
>  	 * setting new huge pte entry
>  	 */
> -	pte = huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
> +	pte = huge_ptep_get_and_clear(vma->vm_mm, addr, ptep, sz);
>  	flush_tlb_page(vma, addr);
>  	return pte;
>  }
> diff --git a/arch/parisc/include/asm/hugetlb.h b/arch/parisc/include/asm/hugetlb.h
> index 5b3a5429f71b..21e9ace17739 100644
> --- a/arch/parisc/include/asm/hugetlb.h
> +++ b/arch/parisc/include/asm/hugetlb.h
> @@ -10,7 +10,7 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
>  
>  #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
>  pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
> -			      pte_t *ptep);
> +			      pte_t *ptep, unsigned long sz);
>  
>  #define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
>  static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
> diff --git a/arch/parisc/mm/hugetlbpage.c b/arch/parisc/mm/hugetlbpage.c
> index e9d18cf25b79..a94fe546d434 100644
> --- a/arch/parisc/mm/hugetlbpage.c
> +++ b/arch/parisc/mm/hugetlbpage.c
> @@ -126,7 +126,7 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
>  
>  
>  pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
> -			      pte_t *ptep)
> +			      pte_t *ptep, unsigned long sz)
>  {
>  	pte_t entry;
>  
> diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
> index dad2e7980f24..86326587e58d 100644
> --- a/arch/powerpc/include/asm/hugetlb.h
> +++ b/arch/powerpc/include/asm/hugetlb.h
> @@ -45,7 +45,8 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
>  
>  #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
>  static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
> -					    unsigned long addr, pte_t *ptep)
> +					    unsigned long addr, pte_t *ptep,
> +					    unsigned long sz)
>  {
>  	return __pte(pte_update(mm, addr, ptep, ~0UL, 0, 1));
>  }
> @@ -55,8 +56,9 @@ static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
>  					  unsigned long addr, pte_t *ptep)
>  {
>  	pte_t pte;
> +	unsigned long sz = huge_page_size(hstate_vma(vma));
>  
> -	pte = huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
> +	pte = huge_ptep_get_and_clear(vma->vm_mm, addr, ptep, sz);
>  	flush_hugetlb_page(vma, addr);
>  	return pte;
>  }
> diff --git a/arch/riscv/include/asm/hugetlb.h b/arch/riscv/include/asm/hugetlb.h
> index faf3624d8057..446126497768 100644
> --- a/arch/riscv/include/asm/hugetlb.h
> +++ b/arch/riscv/include/asm/hugetlb.h
> @@ -28,7 +28,8 @@ void set_huge_pte_at(struct mm_struct *mm,
>  
>  #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
>  pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
> -			      unsigned long addr, pte_t *ptep);
> +			      unsigned long addr, pte_t *ptep,
> +			      unsigned long sz);
>  
>  #define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
>  pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
> diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
> index 42314f093922..b4a78a4b35cf 100644
> --- a/arch/riscv/mm/hugetlbpage.c
> +++ b/arch/riscv/mm/hugetlbpage.c
> @@ -293,7 +293,7 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>  
>  pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
>  			      unsigned long addr,
> -			      pte_t *ptep)
> +			      pte_t *ptep, unsigned long sz)
>  {
>  	pte_t orig_pte = ptep_get(ptep);
>  	int pte_num;
> diff --git a/arch/s390/include/asm/hugetlb.h b/arch/s390/include/asm/hugetlb.h
> index 7c52acaf9f82..420c74306779 100644
> --- a/arch/s390/include/asm/hugetlb.h
> +++ b/arch/s390/include/asm/hugetlb.h
> @@ -26,7 +26,11 @@ void __set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
>  pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
>  
>  #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
> -pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
> +pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
> +			      unsigned long addr, pte_t *ptep,
> +			      unsigned long sz);
> +pte_t __huge_ptep_get_and_clear(struct mm_struct *mm,
> +			      unsigned long addr, pte_t *ptep);
>  
>  static inline void arch_clear_hugetlb_flags(struct folio *folio)
>  {
> @@ -48,7 +52,7 @@ static inline void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
>  static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
>  					  unsigned long address, pte_t *ptep)
>  {
> -	return huge_ptep_get_and_clear(vma->vm_mm, address, ptep);
> +	return __huge_ptep_get_and_clear(vma->vm_mm, address, ptep);
>  }
>  
>  #define  __HAVE_ARCH_HUGE_PTEP_SET_ACCESS_FLAGS
> @@ -59,7 +63,7 @@ static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>  	int changed = !pte_same(huge_ptep_get(vma->vm_mm, addr, ptep), pte);
>  
>  	if (changed) {
> -		huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
> +		__huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
>  		__set_huge_pte_at(vma->vm_mm, addr, ptep, pte);
>  	}
>  	return changed;
> @@ -69,7 +73,7 @@ static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>  static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
>  					   unsigned long addr, pte_t *ptep)
>  {
> -	pte_t pte = huge_ptep_get_and_clear(mm, addr, ptep);
> +	pte_t pte = __huge_ptep_get_and_clear(mm, addr, ptep);
>  
>  	__set_huge_pte_at(mm, addr, ptep, pte_wrprotect(pte));
>  }
> diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
> index d9ce199953de..52ee8e854195 100644
> --- a/arch/s390/mm/hugetlbpage.c
> +++ b/arch/s390/mm/hugetlbpage.c
> @@ -188,8 +188,8 @@ pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
>  	return __rste_to_pte(pte_val(*ptep));
>  }
>  
> -pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
> -			      unsigned long addr, pte_t *ptep)
> +pte_t __huge_ptep_get_and_clear(struct mm_struct *mm,
> +				unsigned long addr, pte_t *ptep)
>  {
>  	pte_t pte = huge_ptep_get(mm, addr, ptep);
>  	pmd_t *pmdp = (pmd_t *) ptep;
> @@ -202,6 +202,12 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
>  	return pte;
>  }
>  
> +pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
> +			      unsigned long addr, pte_t *ptep, unsigned long sz)
> +{
> +	return __huge_ptep_get_and_clear(mm, addr, ptep);
> +}
> +
>  pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
>  			unsigned long addr, unsigned long sz)
>  {
> diff --git a/arch/sparc/include/asm/hugetlb.h b/arch/sparc/include/asm/hugetlb.h
> index c714ca6a05aa..e7a9cdd498dc 100644
> --- a/arch/sparc/include/asm/hugetlb.h
> +++ b/arch/sparc/include/asm/hugetlb.h
> @@ -20,7 +20,7 @@ void __set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
>  
>  #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
>  pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
> -			      pte_t *ptep);
> +			      pte_t *ptep, unsigned long sz);
>  
>  #define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
>  static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
> diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
> index eee601a0d2cf..80504148d8a5 100644
> --- a/arch/sparc/mm/hugetlbpage.c
> +++ b/arch/sparc/mm/hugetlbpage.c
> @@ -260,7 +260,7 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
>  }
>  
>  pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
> -			      pte_t *ptep)
> +			      pte_t *ptep, unsigned long sz)
>  {
>  	unsigned int i, nptes, orig_shift, shift;
>  	unsigned long size;
> diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
> index f42133dae68e..2afc95bf1655 100644
> --- a/include/asm-generic/hugetlb.h
> +++ b/include/asm-generic/hugetlb.h
> @@ -90,7 +90,7 @@ static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
>  
>  #ifndef __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
>  static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
> -		unsigned long addr, pte_t *ptep)
> +		unsigned long addr, pte_t *ptep, unsigned long sz)
>  {
>  	return ptep_get_and_clear(mm, addr, ptep);
>  }
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index ec8c0ccc8f95..bf5f7256bd28 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -1004,7 +1004,9 @@ static inline void hugetlb_count_sub(long l, struct mm_struct *mm)
>  static inline pte_t huge_ptep_modify_prot_start(struct vm_area_struct *vma,
>  						unsigned long addr, pte_t *ptep)
>  {
> -	return huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
> +	unsigned long psize = huge_page_size(hstate_vma(vma));
> +
> +	return huge_ptep_get_and_clear(vma->vm_mm, addr, ptep, psize);
>  }
>  #endif
>  
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 65068671e460..de9d49e521c1 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5447,7 +5447,7 @@ static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
>  	if (src_ptl != dst_ptl)
>  		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
>  
> -	pte = huge_ptep_get_and_clear(mm, old_addr, src_pte);
> +	pte = huge_ptep_get_and_clear(mm, old_addr, src_pte, sz);
>  
>  	if (need_clear_uffd_wp && pte_marker_uffd_wp(pte))
>  		huge_pte_clear(mm, new_addr, dst_pte, sz);
> @@ -5622,7 +5622,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  			set_vma_resv_flags(vma, HPAGE_RESV_UNMAPPED);
>  		}
>  
> -		pte = huge_ptep_get_and_clear(mm, address, ptep);
> +		pte = huge_ptep_get_and_clear(mm, address, ptep, sz);
>  		tlb_remove_huge_tlb_entry(h, tlb, ptep, address);
>  		if (huge_pte_dirty(pte))
>  			set_page_dirty(page);

