Return-Path: <stable+bounces-114235-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1210A2C079
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 11:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A5DC188AACE
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 10:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C3D1B4133;
	Fri,  7 Feb 2025 10:21:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E8D80BFF;
	Fri,  7 Feb 2025 10:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738923708; cv=none; b=e1Hgon0rESAQu4VkLqPTjUI5ooRBs5qYi/kWrUHrr8emK5RmtWfdalxbXm0Ii1qcboFoo7UApQWwVdB3gjOdgqnGIHoZjJnbOSQalbjdJOpbWy/8Fhr17kZbl7KsSv039akUHD0uYv7BOwdqgGhQpifkx02M47j24DXCcyBo+dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738923708; c=relaxed/simple;
	bh=Z9G/KBGEl6Byxr08x6OT7vhgRLei0KOl+J1GPs7OByM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OukmUJfkYWDiY9ewtvrzfxZnL36y0SyBT3flRKIRweShdvv9SEekLdFg60rpEYUQmpFW9h6HVc06Ff5JYyKzHVHyGGf0sSXR0jhXM/PNGTFDB4BnswTuzJYGgZlyh7NS8yxSmXVjJaZSgQwsWOC0AzIhk4KrMlXNSaDb4z4DKok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 927F2113E;
	Fri,  7 Feb 2025 02:22:08 -0800 (PST)
Received: from [10.162.16.89] (a077893.blr.arm.com [10.162.16.89])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 407113F63F;
	Fri,  7 Feb 2025 02:21:39 -0800 (PST)
Message-ID: <15660c4c-5c4d-4229-b5c5-abcabd402058@arm.com>
Date: Fri, 7 Feb 2025 15:51:37 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 13/16] mm: Don't skip arch_sync_kernel_mappings() in
 error paths
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
 <20250205151003.88959-14-ryan.roberts@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250205151003.88959-14-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/5/25 20:39, Ryan Roberts wrote:
> Fix callers that previously skipped calling arch_sync_kernel_mappings()
> if an error occurred during a pgtable update. The call is still required
> to sync any pgtable updates that may have occurred prior to hitting the
> error condition.
> 
> These are theoretical bugs discovered during code review.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 2ba3e6947aed ("mm/vmalloc: track which page-table levels were modified")
> Fixes: 0c95cba49255 ("mm: apply_to_pte_range warn and fail if a large pte is encountered")
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

This change could stand on its own and LGTM.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  mm/memory.c  | 6 ++++--
>  mm/vmalloc.c | 4 ++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 539c0f7c6d54..a15f7dd500ea 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3040,8 +3040,10 @@ static int __apply_to_page_range(struct mm_struct *mm, unsigned long addr,
>  		next = pgd_addr_end(addr, end);
>  		if (pgd_none(*pgd) && !create)
>  			continue;
> -		if (WARN_ON_ONCE(pgd_leaf(*pgd)))
> -			return -EINVAL;
> +		if (WARN_ON_ONCE(pgd_leaf(*pgd))) {
> +			err = -EINVAL;
> +			break;
> +		}
>  		if (!pgd_none(*pgd) && WARN_ON_ONCE(pgd_bad(*pgd))) {
>  			if (!create)
>  				continue;
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 6111ce900ec4..68950b1824d0 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -604,13 +604,13 @@ static int vmap_small_pages_range_noflush(unsigned long addr, unsigned long end,
>  			mask |= PGTBL_PGD_MODIFIED;
>  		err = vmap_pages_p4d_range(pgd, addr, next, prot, pages, &nr, &mask);
>  		if (err)
> -			return err;
> +			break;
>  	} while (pgd++, addr = next, addr != end);
>  
>  	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
>  		arch_sync_kernel_mappings(start, end);
>  
> -	return 0;
> +	return err;
>  }
>  
>  /*

