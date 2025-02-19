Return-Path: <stable+bounces-117472-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43335A3B6F2
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7860717C176
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F071EEA27;
	Wed, 19 Feb 2025 08:56:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4441CAA65;
	Wed, 19 Feb 2025 08:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739955397; cv=none; b=qqCtBkBVaVIkrNHk1/ASO4m8/AH5EnH+pkncP7DrQcr+MjZbe2CP4ICdVscRR8AA9jnNdwmSLzIfbrLI0ifCyogrWWwJO5JD5fCuOXwuX4sdQkpCzUgkbYNSip12JbChpGP8qjNNstTSkahXnMGdDalmiiij2l16L1B3W0gO44w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739955397; c=relaxed/simple;
	bh=abNsQdu3JhM7h7rMfFp3U0VqkyS8CqdHzs/8jrwx3bc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VuPKBHQkmekVRiFJnymFda88z+6ub85goPzPTmOuvv6JdLbNzVcVHMBIi5G1KYYeqoDN/bH4+vVlW3IzEcJNffzCwnWTu6Vv3B7uS40NuENlUy7o0n7oACGHQtx3BrDbNH8jAPGp+ZWk9xBcgBvePlKwnaYYuRzUPjuwCzxQ+20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 003F11682;
	Wed, 19 Feb 2025 00:56:53 -0800 (PST)
Received: from [10.162.42.6] (unknown [10.162.42.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4EF9A3F5A1;
	Wed, 19 Feb 2025 00:56:21 -0800 (PST)
Message-ID: <5fbfd74e-7f87-4f4f-86a7-7d4c38e0b4ba@arm.com>
Date: Wed, 19 Feb 2025 14:26:19 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] arm64: hugetlb: Fix flush_hugetlb_tlb_range()
 invalidation level
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
 <20250217140419.1702389-4-ryan.roberts@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250217140419.1702389-4-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/17/25 19:34, Ryan Roberts wrote:
> commit c910f2b65518 ("arm64/mm: Update tlb invalidation routines for
> FEAT_LPA2") changed the "invalidation level unknown" hint from 0 to
> TLBI_TTL_UNKNOWN (INT_MAX). But the fallback "unknown level" path in
> flush_hugetlb_tlb_range() was not updated. So as it stands, when trying
> to invalidate CONT_PMD_SIZE or CONT_PTE_SIZE hugetlb mappings, we will
> spuriously try to invalidate at level 0 on LPA2-enabled systems.
> 
> Fix this so that the fallback passes TLBI_TTL_UNKNOWN, and while we are
> at it, explicitly use the correct stride and level for CONT_PMD_SIZE and
> CONT_PTE_SIZE, which should provide a minor optimization.
> 
> Cc: stable@vger.kernel.org
> Fixes: c910f2b65518 ("arm64/mm: Update tlb invalidation routines for FEAT_LPA2")
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

LGTM

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  arch/arm64/include/asm/hugetlb.h | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
> index 03db9cb21ace..07fbf5bf85a7 100644
> --- a/arch/arm64/include/asm/hugetlb.h
> +++ b/arch/arm64/include/asm/hugetlb.h
> @@ -76,12 +76,22 @@ static inline void flush_hugetlb_tlb_range(struct vm_area_struct *vma,
>  {
>  	unsigned long stride = huge_page_size(hstate_vma(vma));
>  
> -	if (stride == PMD_SIZE)
> -		__flush_tlb_range(vma, start, end, stride, false, 2);
> -	else if (stride == PUD_SIZE)
> -		__flush_tlb_range(vma, start, end, stride, false, 1);
> -	else
> -		__flush_tlb_range(vma, start, end, PAGE_SIZE, false, 0);
> +	switch (stride) {
> +#ifndef __PAGETABLE_PMD_FOLDED
> +	case PUD_SIZE:
> +		__flush_tlb_range(vma, start, end, PUD_SIZE, false, 1);
> +		break;
> +#endif
> +	case CONT_PMD_SIZE:
> +	case PMD_SIZE:
> +		__flush_tlb_range(vma, start, end, PMD_SIZE, false, 2);
> +		break;
> +	case CONT_PTE_SIZE:
> +		__flush_tlb_range(vma, start, end, PAGE_SIZE, false, 3);
> +		break;
> +	default:
> +		__flush_tlb_range(vma, start, end, PAGE_SIZE, false, TLBI_TTL_UNKNOWN);
> +	}
>  }
>  
>  #endif /* __ASM_HUGETLB_H */

