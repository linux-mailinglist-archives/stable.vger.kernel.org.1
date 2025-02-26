Return-Path: <stable+bounces-119679-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2B4A4618D
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 15:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FD0F16B570
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 14:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0588818DB36;
	Wed, 26 Feb 2025 14:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CGmdkjvn"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C8C4B5AE;
	Wed, 26 Feb 2025 14:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740578486; cv=none; b=BZBwGokan87bVCLxhB6kLNHRMVbHBgWRTON5aTss5oTfLFiGB/4fuIdVXl8ZEbiAGM8x9KOAYgLKaHEychCnu7fqYnOswdLf0glKXjFOm9Cfk4Yyb+WHGEKOLws4UQP4/NmN3MPtr65sl993m4QFQs93GXjcxP+lrlK4usfnMS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740578486; c=relaxed/simple;
	bh=rHMjOtqxgbVpvS+WWBALdWb1OeNYK+WZdzX/5F8nUcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T213zwpVT4MLzdLDanAeTtQyt8ObGErwdZCwmODCRRgs641q/yNPkSCCvu1khWspTcqYZYnwDbIQVSuexgeVngww6WYlu7lnua7QMkUzNsi5i+qp5RQpQF6TI+SfxKsm8KOXf70uVm4cgsNM54+eTuPlf5dpqE3fyMkUHzCWOY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CGmdkjvn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QBa535013048;
	Wed, 26 Feb 2025 14:00:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=QYTl6s6abT311ctNgFeH3uZqM7omSx
	jv0zbkBRaFwns=; b=CGmdkjvn+2xajShNZ+lxlxwZELsQv8gh6iW3OHDZPYu5vp
	u8F93xGoPOkRUgMpR1/b1n/lui+k1OWWcMmxGkGqkAiuToroE6Xzxr3uWihTONYV
	2b6tRQMkoyHD7g2tn0UKFUz2kiz97UAm3nx6Rnen149SauPAEy8YW538FfDNJPEs
	bwPKLAdpX/D2m1dWNEkwkt+xz9/Ah8uCIrC8V1PHT0STpnHAO3Xq6j8rOKulRbGR
	/MzCFN8seJbbZNyh5uPe28tkAEN3B0xSu65hZEMBWCntsWG60deG9HM3q0QYO1ur
	cGXdh3bF44TkTJ2zkRUyuIVq3rfteNvtbSzVDEow==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 451s19b2ph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 14:00:42 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51QE0gZg022779;
	Wed, 26 Feb 2025 14:00:42 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 451s19b2pe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 14:00:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51QCWcBh027479;
	Wed, 26 Feb 2025 14:00:40 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44ytdkjubt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 14:00:40 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51QE0aAN55247202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 14:00:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99EEC2004D;
	Wed, 26 Feb 2025 14:00:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0451520043;
	Wed, 26 Feb 2025 14:00:36 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 26 Feb 2025 14:00:35 +0000 (GMT)
Date: Wed, 26 Feb 2025 15:00:34 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Dev Jain <dev.jain@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/3] mm: hugetlb: Add huge page size param to
 huge_ptep_get_and_clear()
Message-ID: <Z78eglxQbl1+E+2z@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20250226120656.2400136-1-ryan.roberts@arm.com>
 <20250226120656.2400136-2-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226120656.2400136-2-ryan.roberts@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: s_YdaBVwtjVAKpirmh4MQMhBb0iDQFXY
X-Proofpoint-ORIG-GUID: 1tUKVvQju-YVCUZtfsna3wQvsmiy0plX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_03,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=976 mlxscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260112

On Wed, Feb 26, 2025 at 12:06:51PM +0000, Ryan Roberts wrote:
> In order to fix a bug, arm64 needs to be told the size of the huge page
> for which the huge_pte is being cleared in huge_ptep_get_and_clear().
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
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com> # riscv
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
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
>  arch/s390/include/asm/hugetlb.h      | 16 ++++++++++++----
>  arch/s390/mm/hugetlbpage.c           |  4 ++--
>  arch/sparc/include/asm/hugetlb.h     |  2 +-
>  arch/sparc/mm/hugetlbpage.c          |  2 +-
>  include/asm-generic/hugetlb.h        |  2 +-
>  include/linux/hugetlb.h              |  4 +++-
>  mm/hugetlb.c                         |  4 ++--
>  16 files changed, 46 insertions(+), 27 deletions(-)
...
> diff --git a/arch/s390/include/asm/hugetlb.h b/arch/s390/include/asm/hugetlb.h
> index 7c52acaf9f82..663e87220e89 100644
> --- a/arch/s390/include/asm/hugetlb.h
> +++ b/arch/s390/include/asm/hugetlb.h
> @@ -25,8 +25,16 @@ void __set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
>  #define __HAVE_ARCH_HUGE_PTEP_GET
>  pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
>  
> +pte_t __huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
> +				pte_t *ptep);
> +
>  #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
> -pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
> +static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
> +					    unsigned long addr, pte_t *ptep,
> +					    unsigned long sz)
> +{
> +	return __huge_ptep_get_and_clear(mm, addr, ptep);
> +}
>  
>  static inline void arch_clear_hugetlb_flags(struct folio *folio)
>  {
> @@ -48,7 +56,7 @@ static inline void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
>  static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
>  					  unsigned long address, pte_t *ptep)
>  {
> -	return huge_ptep_get_and_clear(vma->vm_mm, address, ptep);
> +	return __huge_ptep_get_and_clear(vma->vm_mm, address, ptep);
>  }
>  
>  #define  __HAVE_ARCH_HUGE_PTEP_SET_ACCESS_FLAGS
> @@ -59,7 +67,7 @@ static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>  	int changed = !pte_same(huge_ptep_get(vma->vm_mm, addr, ptep), pte);
>  
>  	if (changed) {
> -		huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
> +		__huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
>  		__set_huge_pte_at(vma->vm_mm, addr, ptep, pte);
>  	}
>  	return changed;
> @@ -69,7 +77,7 @@ static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>  static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
>  					   unsigned long addr, pte_t *ptep)
>  {
> -	pte_t pte = huge_ptep_get_and_clear(mm, addr, ptep);
> +	pte_t pte = __huge_ptep_get_and_clear(mm, addr, ptep);
>  
>  	__set_huge_pte_at(mm, addr, ptep, pte_wrprotect(pte));
>  }
> diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
> index d9ce199953de..2e568f175cd4 100644
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
...

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com> # s390

Thanks!

