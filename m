Return-Path: <stable+bounces-114036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D84CBA2A167
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 07:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6194188906F
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 06:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A45226198;
	Thu,  6 Feb 2025 06:46:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E862253F1;
	Thu,  6 Feb 2025 06:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738824373; cv=none; b=SzvPVRAaRSjNQVeAkyjHsvPrLML4NNNvqHP3rzyOkQmQIvKqPQHBZ7yDu+g8BTyVNu9BtmqeVHixQA4Qs3YT2dtd3X2Hpxn9EzbI6xJc/Dz6bwvWIE5H+29Y6u2hBd4qMqseKWfYYBdrOh6L3xz2Sq7wanHjYshUJPWf7VDxZeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738824373; c=relaxed/simple;
	bh=kEfJ8FJZ8PSQhGxvagxS6l5va98/m+qIsGY2YwfS1Ok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W8geAPzyziWTvVrSjXr7B6iRxdbr0TMS+EKunlfSmAZVUvwbCY9xFTF65tDMctAEKA92m3RZgD0BFiq1Kly1KiGbsZot7WyUBHTnWuLjjzwyXJPX+h/UmLL2LliemOXIZZqHOH0MwoY4stHXbq17NYc5RbNOe3USi/3qDEQzLm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 406B112FC;
	Wed,  5 Feb 2025 22:46:34 -0800 (PST)
Received: from [10.163.34.115] (unknown [10.163.34.115])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BC903F63F;
	Wed,  5 Feb 2025 22:46:04 -0800 (PST)
Message-ID: <e2809c59-6453-4a90-88ad-0b22e82f869f@arm.com>
Date: Thu, 6 Feb 2025 12:16:02 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/16] arm64: hugetlb: Fix flush_hugetlb_tlb_range()
 invalidation level
To: Ryan Roberts <ryan.roberts@arm.com>,
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
 <20250205151003.88959-4-ryan.roberts@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250205151003.88959-4-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/5/25 20:39, Ryan Roberts wrote:
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
> Cc: <stable@vger.kernel.org>
> Fixes: c910f2b65518 ("arm64/mm: Update tlb invalidation routines for FEAT_LPA2")
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  arch/arm64/include/asm/hugetlb.h | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
> index 03db9cb21ace..8ab9542d2d22 100644
> --- a/arch/arm64/include/asm/hugetlb.h
> +++ b/arch/arm64/include/asm/hugetlb.h
> @@ -76,12 +76,20 @@ static inline void flush_hugetlb_tlb_range(struct vm_area_struct *vma,
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
> +	case PUD_SIZE:
> +		__flush_tlb_range(vma, start, end, PUD_SIZE, false, 1);
> +		break;

Just wondering - should not !__PAGETABLE_PMD_FOLDED and pud_sect_supported()
checks also be added here for this PUD_SIZE case ?

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

