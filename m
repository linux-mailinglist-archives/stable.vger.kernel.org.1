Return-Path: <stable+bounces-105535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5CD9FA102
	for <lists+stable@lfdr.de>; Sat, 21 Dec 2024 15:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D91A7A051A
	for <lists+stable@lfdr.de>; Sat, 21 Dec 2024 14:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFD01F3D52;
	Sat, 21 Dec 2024 14:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DYdZPsPb"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FE41EE7B6
	for <stable@vger.kernel.org>; Sat, 21 Dec 2024 14:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734791720; cv=none; b=WRe6PgGHsW206bapaXsdg/TPnqj0JLg/PjVhPAWSB3oTtYOhUHv8TIvow46NM+8moK2cK7x7l68c5wCIejzBV0s4oORo0997I0ER7Oqf91GrJfg81J+b/HxPXIndQfH+eNx1H5FUTNPrPylzA54zXvyfcSiaRYMltJu69LTu0iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734791720; c=relaxed/simple;
	bh=IQsglHYRXE8CjRvUUHDEPq6WI3I9JLzPeAbbYKqIpDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hnReUv4e/2GZS/lQxjjG6L6GvGT28TrWHSHyYG1JOVcb3UVsdDt5+EUAA4naEY9KqbnxLA4lqxR7lg+odPa/I408P7VPCNw5TZgJXnJi+hoxoZs1MNqeghdvWPjmyyDWaSU/8R0vonP8ymZxXoiB5njjRA2agfIx5gALONeg2I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DYdZPsPb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734791716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=//qCf+WO4nGzY6JUI4A0T0LWR55S6LYahmmcQNagzuk=;
	b=DYdZPsPbcIXuTyYVhldqpauXdTSI+kwwVP8IsYFNoah+R2O0seep8327714NcDIBpFOzSn
	gfJXRDgPlQ+wpT9vDCqszscNsmVCfIRALrrXZumBSegXgHip7Kbux0lYMtXW2nFbV9m7Eq
	nYDzj0VkPWdkJeM+1RbFaFpMsnN+ynE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-_Ig72IPUNP-1VLmNimCf4Q-1; Sat, 21 Dec 2024 09:35:14 -0500
X-MC-Unique: _Ig72IPUNP-1VLmNimCf4Q-1
X-Mimecast-MFC-AGG-ID: _Ig72IPUNP-1VLmNimCf4Q
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4362552ce62so15585495e9.0
        for <stable@vger.kernel.org>; Sat, 21 Dec 2024 06:35:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734791713; x=1735396513;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=//qCf+WO4nGzY6JUI4A0T0LWR55S6LYahmmcQNagzuk=;
        b=EUZF/aSI62zc1ILYVLcRqewWFqpqLxfwawr95n3dtI0uTP/Kzwe1Sl95QnBLuwrsrS
         qfy2oYYTW0d1744/eEE8HTKoCt7hwy+52ekCltXy6pq2Jcd0TYIU4PnAAvAYvHfMiZdK
         mGKbrDYuaWoIsftsTnMSHobK4FR/YwdcZKhUvOzE1Xw1Dj1AMjWFzuhb9tVF0JV5Gw0V
         nJj9w3mpnWsnDRuW6RzQFtHURM+m1SOlYoOy3PpL9Za2wpqa+3lQWRbT6sBksoy2TTpy
         cgxFmY6IVjZA9IlrLMtahzJRneWBqm+ni/h8s2G3+6zUSSR8iZ84L78iIhV4mGmc/gFv
         hm3A==
X-Forwarded-Encrypted: i=1; AJvYcCWDjWI3V36KkISzKMiTtqP3uXpo6zjwA7IIL3qpufGVj8xTDvYoLptVQp6nm9Sibucq/UkYDzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YztAUOv4WJvzY041rGNyyeDYYtCZZZaNL+3kABGORcZlT32tOhh
	XxkqvLSssHh2cFhEJBNy77/M/nzJaXNBtxdMf2oL3+P0bnT8+YkWiAq5IiwnKuho/hrgfs2tnmH
	trBp2XaskXu+DW1Qr4xY63PUg7VVWKn5CWVncwKWC+ESTU/sw+Mh6tA==
X-Gm-Gg: ASbGncuv3KF/6ZugV/RPTaouv2N4eX5mAPoxDSECRMnWoT5hfJd1AM4333gSDr/XGNG
	Y4oS8uSrdH3wTW8qQUeeosElrstxrjxbhqCe8s1i+3dPU3d7dqKYwjuWIEDQQ8VYKRg0f4M82GF
	tUIjDltfY+RvCVylMuPVvqA1duGm+ukjjRUaOHAru2Zivob9inBxHKgVaL4Bg75wwPNYG3THBe8
	1pAp2BxCVtcXDWZXc7waEeO2wV9VTqTtlGTyVOVd7SpS6rxvcQ303jlR6kUT3IyxEwsiGrQWNgy
	CDl59TEkieTjFoS0ieZaaMRHUE9dfRySZNEWVK3XLeECEXB33ima21C/TaaRV8dKDTZh1Rp456j
	8onnJLiz8
X-Received: by 2002:a05:600c:4f94:b0:434:f871:1b96 with SMTP id 5b1f17b1804b1-43668b7a1dfmr56093335e9.29.1734791713286;
        Sat, 21 Dec 2024 06:35:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYeJPVAHDkbyltXUVYSZLMMBqKBwaY8misOuxyAOrPTAuLE8mn//XZSZQIwPfZVCmeDUjblg==
X-Received: by 2002:a05:600c:4f94:b0:434:f871:1b96 with SMTP id 5b1f17b1804b1-43668b7a1dfmr56093215e9.29.1734791712907;
        Sat, 21 Dec 2024 06:35:12 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:d000:4622:73e7:6184:8f0d? (p200300cbc70ed000462273e761848f0d.dip0.t-ipconnect.de. [2003:cb:c70e:d000:4622:73e7:6184:8f0d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b3b207sm110304915e9.32.2024.12.21.06.35.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Dec 2024 06:35:12 -0800 (PST)
Message-ID: <0ca35fe5-9799-4518-9fb1-701c88501a8d@redhat.com>
Date: Sat, 21 Dec 2024 15:35:10 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] replace free hugepage folios after migration
To: yangge1116@126.com, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 21cnbao@gmail.com, baolin.wang@linux.alibaba.com, muchun.song@linux.dev,
 liuzixing@hygon.cn
References: <1734503588-16254-1-git-send-email-yangge1116@126.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1734503588-16254-1-git-send-email-yangge1116@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.12.24 07:33, yangge1116@126.com wrote:
> From: yangge <yangge1116@126.com>
> 
> My machine has 4 NUMA nodes, each equipped with 32GB of memory. I
> have configured each NUMA node with 16GB of CMA and 16GB of in-use
> hugetlb pages. The allocation of contiguous memory via the
> cma_alloc() function can fail probabilistically.
> 
> The cma_alloc() function may fail if it sees an in-use hugetlb page
> within the allocation range, even if that page has already been
> migrated. When in-use hugetlb pages are migrated, they may simply
> be released back into the free hugepage pool instead of being
> returned to the buddy system. This can cause the
> test_pages_isolated() function check to fail, ultimately leading
> to the failure of the cma_alloc() function:
> cma_alloc()
>      __alloc_contig_migrate_range() // migrate in-use hugepage
>      test_pages_isolated()
>          __test_page_isolated_in_pageblock()
>               PageBuddy(page) // check if the page is in buddy
> 
> To address this issue, we will add a function named
> replace_free_hugepage_folios(). This function will replace the
> hugepage in the free hugepage pool with a new one and release the
> old one to the buddy system. After the migration of in-use hugetlb
> pages is completed, we will invoke the replace_free_hugepage_folios()
> function to ensure that these hugepages are properly released to
> the buddy system. Following this step, when the test_pages_isolated()
> function is executed for inspection, it will successfully pass.
> 
> Signed-off-by: yangge <yangge1116@126.com>
> ---
>   include/linux/hugetlb.h |  6 ++++++
>   mm/hugetlb.c            | 37 +++++++++++++++++++++++++++++++++++++
>   mm/page_alloc.c         | 13 ++++++++++++-
>   3 files changed, 55 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index ae4fe86..7d36ac8 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -681,6 +681,7 @@ struct huge_bootmem_page {
>   };
>   
>   int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list);
> +int replace_free_hugepage_folios(unsigned long start_pfn, unsigned long end_pfn);
>   struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>   				unsigned long addr, int avoid_reserve);
>   struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
> @@ -1059,6 +1060,11 @@ static inline int isolate_or_dissolve_huge_page(struct page *page,
>   	return -ENOMEM;
>   }
>   
> +int replace_free_hugepage_folios(unsigned long start_pfn, unsigned long end_pfn)
> +{
> +	return 0;
> +}
> +
>   static inline struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>   					   unsigned long addr,
>   					   int avoid_reserve)
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 8e1db80..a099c54 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2975,6 +2975,43 @@ int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list)
>   	return ret;
>   }
>   
> +/*
> + *  replace_free_hugepage_folios - Replace free hugepage folios in a given pfn
> + *  range with new folios.
> + *  @stat_pfn: start pfn of the given pfn range
> + *  @end_pfn: end pfn of the given pfn range
> + *  Returns 0 on success, otherwise negated error.
> + */
> +int replace_free_hugepage_folios(unsigned long start_pfn, unsigned long end_pfn)
> +{
> +	struct hstate *h;
> +	struct folio *folio;
> +	int ret = 0;
> +
> +	LIST_HEAD(isolate_list);
> +
> +	while (start_pfn < end_pfn) {
> +		folio = pfn_folio(start_pfn);
> +		if (folio_test_hugetlb(folio)) {
> +			h = folio_hstate(folio);
> +		} else {
> +			start_pfn++;
> +			continue;
> +		}
> +
> +		if (!folio_ref_count(folio)) {
> +			ret = alloc_and_dissolve_hugetlb_folio(h, folio, &isolate_list);
> +			if (ret)
> +				break;
> +
> +			putback_movable_pages(&isolate_list);
> +		}
> +		start_pfn++;
> +	}
> +
> +	return ret;
> +}
> +
>   struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>   				    unsigned long addr, int avoid_reserve)
>   {
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index dde19db..1dcea28 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6504,7 +6504,18 @@ int alloc_contig_range_noprof(unsigned long start, unsigned long end,
>   	ret = __alloc_contig_migrate_range(&cc, start, end, migratetype);
>   	if (ret && ret != -EBUSY)
>   		goto done;
> -	ret = 0;
> +
> +	/*
> +	 * When in-use hugetlb pages are migrated, they may simply be
> +	 * released back into the free hugepage pool instead of being
> +	 * returned to the buddy system. After the migration of in-use
> +	 * huge pages is completed, we will invoke the
> +	 * replace_free_hugepage_folios() function to ensure that
> +	 * these hugepages are properly released to the buddy system.
> +	 */

As mentioned in my other mail, what I don't like about this is, IIUC, 
the pages can get reallocated anytime after we successfully migrated 
them, or is there  anything that prevents that?

Did you ever try allocating a larger range with a single 
alloc_contig_range() call, that possibly has to migrate multiple hugetlb 
folios in one go (and maybe just allocates one of the just-freed hugetlb 
folios as migration target)?


-- 
Cheers,

David / dhildenb


