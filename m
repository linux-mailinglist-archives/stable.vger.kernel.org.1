Return-Path: <stable+bounces-124350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC46A5FF3C
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 19:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEE273BE2E2
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 18:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD23189BB3;
	Thu, 13 Mar 2025 18:28:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CF91E8353;
	Thu, 13 Mar 2025 18:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741890539; cv=none; b=i2JvKND2jA3V38GIk/OrNp2ND2DzMy/C3Z9iCrS6IVxdJ6CeeBVvYcfse1/OV5uHYlKU7uBX53oR6ChbBMyaDngj3EDrTDdXSypIZhm+gUR2hO63wXYEMV96dR6p6f7PfSMqkgRyscaAPYEAB2ehn8BaVgeVpJ/gR7M+hViLKA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741890539; c=relaxed/simple;
	bh=tx9JS9G/kHbaD5Ns9JpObQjxriVwr2WEuboziKWYE04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U6hudZrdq8W22UwSPeqGI+/qn+AkWhnQVwVwbhNFBsG9RfEhj1Tfl/JNatMgGSzQskm46J/Cj+lg0hDSyHqd6KeJ+b0CWf+rSXDIim97m9kF8arRceIKcO9H1Hfvymx0ziPVLzSbXio1qLZoHjeYuTOeFZKC497R1FkVUEj8Z2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99AB01477;
	Thu, 13 Mar 2025 11:29:07 -0700 (PDT)
Received: from [10.163.42.238] (unknown [10.163.42.238])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F3953F694;
	Thu, 13 Mar 2025 11:28:52 -0700 (PDT)
Message-ID: <495ec80f-6cf1-4be8-bc2a-9115562fe60d@arm.com>
Date: Thu, 13 Mar 2025 23:58:48 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Update mask post pxd_clear_bad()
To: jroedel@suse.de, akpm@linux-foundation.org
Cc: ryan.roberts@arm.com, david@redhat.com, willy@infradead.org, hch@lst.de,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250313181414.78512-1-dev.jain@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250313181414.78512-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/03/25 11:44 pm, Dev Jain wrote:
> Since pxd_clear_bad() is an operation changing the state of the page tables,
> we should call arch_sync_kernel_mappings() post this.
> 
> Fixes: e80d3909be42 ("mm: track page table modifications in __apply_to_page_range()")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>   mm/memory.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 78c7ee62795e..9a4a8c710be0 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2987,6 +2987,7 @@ static int apply_to_pmd_range(struct mm_struct *mm, pud_t *pud,
>   			if (!create)
>   				continue;
>   			pmd_clear_bad(pmd);
> +			*mask = PGTBL_PMD_MODIFIED;

Oh well, I guess these should have been *mask |= PGTBL_PMD_MODIFIED.


>   		}
>   		err = apply_to_pte_range(mm, pmd, addr, next,
>   					 fn, data, create, mask);
> @@ -3023,6 +3024,7 @@ static int apply_to_pud_range(struct mm_struct *mm, p4d_t *p4d,
>   			if (!create)
>   				continue;
>   			pud_clear_bad(pud);
> +			*mask = PGTBL_PUD_MODIFIED;
>   		}
>   		err = apply_to_pmd_range(mm, pud, addr, next,
>   					 fn, data, create, mask);
> @@ -3059,6 +3061,7 @@ static int apply_to_p4d_range(struct mm_struct *mm, pgd_t *pgd,
>   			if (!create)
>   				continue;
>   			p4d_clear_bad(p4d);
> +			*mask = PGTBL_P4D_MODIFIED;
>   		}
>   		err = apply_to_pud_range(mm, p4d, addr, next,
>   					 fn, data, create, mask);
> @@ -3095,6 +3098,7 @@ static int __apply_to_page_range(struct mm_struct *mm, unsigned long addr,
>   			if (!create)
>   				continue;
>   			pgd_clear_bad(pgd);
> +			mask = PGTBL_PGD_MODIFIED;
>   		}
>   		err = apply_to_p4d_range(mm, pgd, addr, next,
>   					 fn, data, create, &mask);


