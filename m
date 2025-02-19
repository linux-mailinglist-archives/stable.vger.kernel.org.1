Return-Path: <stable+bounces-116999-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35228A3B3F1
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AB47188D733
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 08:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA9F1CAA6F;
	Wed, 19 Feb 2025 08:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NChX05j4"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D54B18C011
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 08:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953895; cv=none; b=duy7yJxkUwXDuDBPC+7y2JCj3SVWxGUDnFna+haeZXGIhXo/pTFkc1mfqh8L83Rn76N95FnP4X0uXUvyEAc/lFRb07pu0O/hg085owoqGUCPe3yk0+mXvsKTGrZQz14WDc+AcIyg2jae4DQlaU7cj13zgdOskHyzcC8JkV1XrdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953895; c=relaxed/simple;
	bh=p3tn8ZFvwYniuzNcC0kQzM+giQ6RuUeu8skJy3DQIc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tsVTNskkDx08QaMrOCPAa8AL84sv1nxW9HsALoe8buM4a7Lsign5ICh1VLWMSBeNn5klGKpYGU/yYqdWJ13MqBN3D/SVhdTU4fyc1eWsElzR0R1cv5fbJFYOeMqJzTqdLVFQuVqN73DtO+qq8YO4O88as6BuUtX7UYIJczisEhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NChX05j4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739953888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xoSWF7ivtka5y/2Lzuv5kTt8fFZFrxCYIT9YBSjbXpw=;
	b=NChX05j4IsOTX1LkjZjo7G6DBFEy8UAsRNMFfmXmWHlddPni+HqSmb4jtMPSXJSERgAn/U
	GplwY0PP8irYjIVumkzB8asOdIN+kymDSplbOpJpkMHvW0qeJbzg2A33n6iMGjSTZC3vjO
	5jYzQiz2VlxwlMk6DMWjMxGCiUXdOsI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-Mbbuo-vdMhCn08o-VJRv-Q-1; Wed, 19 Feb 2025 03:31:26 -0500
X-MC-Unique: Mbbuo-vdMhCn08o-VJRv-Q-1
X-Mimecast-MFC-AGG-ID: Mbbuo-vdMhCn08o-VJRv-Q_1739953885
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38f4e3e9c5bso1138591f8f.1
        for <stable@vger.kernel.org>; Wed, 19 Feb 2025 00:31:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739953885; x=1740558685;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xoSWF7ivtka5y/2Lzuv5kTt8fFZFrxCYIT9YBSjbXpw=;
        b=qFvlhNa0pYvPu/7HDlB4fV8836N2XRA2t7P8RerNXmDXZxHBsFonIOYJjgS/bAGQ1d
         EN+4YijCumqo2lkpaQT5i954w5QChC8IgoplYk9+t0/n7+yfFdcABbBsoLX+GZCJEv6t
         s5ARK/RW04ljxvOrlUMkuGxkIOOSU9wMiMAPVkp43sN+oFmyEx3AoWzcRTrC88L/jU0H
         8jQSoW5SiZMOytf+9+YK9s9PMI7AuOMlUeOLyDhvzYR6A76tGwpDXmCO8hHqxcRfhH5h
         smFiPgsdQQZ1mCnE6D2yKD684KByAD4MVCWcN5Dk3rnb1PcosBuR4vGSLa7j5VZ8eP/l
         e45w==
X-Forwarded-Encrypted: i=1; AJvYcCVz9nY1d6Yr5SYIVO+tGWaRaROhuVmnE7gIDH2mL5hn2NiXl/hKseBRKDmlraAmgTDBIcF7HpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNdVUCLlY6nuuTOljDgUIxG6QVIvrxufOo/lYA5y3Y6e/BxqYY
	2ZAKYbbFrEy7DJUUXJhGBqD2YXuhshIZWaw0ShDAMpC1x0//u4fjW+Kap5w8K4pgkdMy4wcLYLD
	FxcRyW85tp2x5rr7eYWnWwCqiiHQR/7wfhR+DOI+XWt41l54wYMUbqA==
X-Gm-Gg: ASbGncuBjBXiLEzq/I+2vRSB9sJOR8AoFT+O2Q+iRmtAuVS1LoQQBOlF9JLnLEdzP1v
	H0Ga+0Qe/ApkTpkvYKZAmbl+AAxDltzoAIBHmfmL3WRbCgj6tpm2a1B4H3jPjHa0FDCFzgQsxQT
	xE3vhHbEI6i0C2OL5bAA1sezevdd85wdtaQJVs97yi7nWd8JaLCqF/6YqDX/uOVNunIbXyTgJVB
	yR4FhoxK4QxRrustqxoAm0dC4oTuIv0dnRVz0aU7xNrKwH5TxKcEwsq+zgr1cdYFxZZ266kBGiq
	3sEiCRMmHH3jDSqfNcv6Cixi0W0FZ7HqvZo=
X-Received: by 2002:a5d:64ac:0:b0:38f:48ee:ddb1 with SMTP id ffacd0b85a97d-38f48eedf3fmr8557561f8f.18.1739953885416;
        Wed, 19 Feb 2025 00:31:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmsKGZq+Fp0+1s4eiZUBJ9pyIlcY4KLYJbrhzT3N8ksvnD77OiS9Ha0P/hFRqGHnQx0Q1d7w==
X-Received: by 2002:a5d:64ac:0:b0:38f:48ee:ddb1 with SMTP id ffacd0b85a97d-38f48eedf3fmr8557526f8f.18.1739953884984;
        Wed, 19 Feb 2025 00:31:24 -0800 (PST)
Received: from [192.168.3.141] (p5b0c68c8.dip0.t-ipconnect.de. [91.12.104.200])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a04f208sm204390315e9.6.2025.02.19.00.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 00:31:23 -0800 (PST)
Message-ID: <04f2a081-b267-42de-881f-14cb16ab0e3c@redhat.com>
Date: Wed, 19 Feb 2025 09:31:22 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] mm/hugetlb: wait for hugetlb folios to be freed
To: yangge1116@126.com, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 21cnbao@gmail.com, baolin.wang@linux.alibaba.com, muchun.song@linux.dev,
 osalvador@suse.de, liuzixing@hygon.cn
References: <1739936804-18199-1-git-send-email-yangge1116@126.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1739936804-18199-1-git-send-email-yangge1116@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.02.25 04:46, yangge1116@126.com wrote:
> From: Ge Yang <yangge1116@126.com>
> 
> Since the introduction of commit c77c0a8ac4c52 ("mm/hugetlb: defer freeing
> of huge pages if in non-task context"), which supports deferring the
> freeing of hugetlb pages, the allocation of contiguous memory through
> cma_alloc() may fail probabilistically.
> 
> In the CMA allocation process, if it is found that the CMA area is occupied
> by in-use hugetlb folios, these in-use hugetlb folios need to be migrated
> to another location. When there are no available hugetlb folios in the
> free hugetlb pool during the migration of in-use hugetlb folios, new folios
> are allocated from the buddy system. A temporary state is set on the newly
> allocated folio. Upon completion of the hugetlb folio migration, the
> temporary state is transferred from the new folios to the old folios.
> Normally, when the old folios with the temporary state are freed, it is
> directly released back to the buddy system. However, due to the deferred
> freeing of hugetlb pages, the PageBuddy() check fails, ultimately leading
> to the failure of cma_alloc().
> 
> Here is a simplified call trace illustrating the process:
> cma_alloc()
>      ->__alloc_contig_migrate_range() // Migrate in-use hugetlb folios
>          ->unmap_and_move_huge_page()
>              ->folio_putback_hugetlb() // Free old folios
>      ->test_pages_isolated()
>          ->__test_page_isolated_in_pageblock()
>               ->PageBuddy(page) // Check if the page is in buddy
> 
> To resolve this issue, we have implemented a function named
> wait_for_freed_hugetlb_folios(). This function ensures that the hugetlb
> folios are properly released back to the buddy system after their migration
> is completed. By invoking wait_for_freed_hugetlb_folios() before calling
> PageBuddy(), we ensure that PageBuddy() will succeed.
> 
> Fixes: c77c0a8ac4c52 ("mm/hugetlb: defer freeing of huge pages if in non-task context")
> Signed-off-by: Ge Yang <yangge1116@126.com>
> Cc: <stable@vger.kernel.org>
> ---
> 
> V4:
> - add a check to determine if hpage_freelist is empty suggested by David
> 
> V3:
> - adjust code and message suggested by Muchun and David
> 
> V2:
> - flush all folios at once suggested by David
> 
>   include/linux/hugetlb.h |  5 +++++
>   mm/hugetlb.c            |  8 ++++++++
>   mm/page_isolation.c     | 10 ++++++++++
>   3 files changed, 23 insertions(+)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 6c6546b..0c54b3a 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -697,6 +697,7 @@ bool hugetlb_bootmem_page_zones_valid(int nid, struct huge_bootmem_page *m);
>   
>   int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list);
>   int replace_free_hugepage_folios(unsigned long start_pfn, unsigned long end_pfn);
> +void wait_for_freed_hugetlb_folios(void);
>   struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>   				unsigned long addr, bool cow_from_owner);
>   struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
> @@ -1092,6 +1093,10 @@ static inline int replace_free_hugepage_folios(unsigned long start_pfn,
>   	return 0;
>   }
>   
> +static inline void wait_for_freed_hugetlb_folios(void)
> +{
> +}
> +
>   static inline struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>   					   unsigned long addr,
>   					   bool cow_from_owner)
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 30bc34d..8801dbc 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2955,6 +2955,14 @@ int replace_free_hugepage_folios(unsigned long start_pfn, unsigned long end_pfn)
>   	return ret;
>   }
>   
> +void wait_for_freed_hugetlb_folios(void)
> +{
> +	if (llist_empty(&hpage_freelist))
> +		return;
> +
> +	flush_work(&free_hpage_work);
> +}
> +
>   typedef enum {
>   	/*
>   	 * For either 0/1: we checked the per-vma resv map, and one resv
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index 8ed53ee0..b2fc526 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -615,6 +615,16 @@ int test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn,
>   	int ret;
>   
>   	/*
> +	 * Due to the deferred freeing of hugetlb folios, the hugepage folios may
> +	 * not immediately release to the buddy system. This can cause PageBuddy()
> +	 * to fail in __test_page_isolated_in_pageblock(). To ensure that the
> +	 * hugetlb folios are properly released back to the buddy system, we
> +	 * invoke the wait_for_freed_hugetlb_folios() function to wait for the
> +	 * release to complete.
> +	 */
> +	wait_for_freed_hugetlb_folios();
> +
> +	/*
>   	 * Note: pageblock_nr_pages != MAX_PAGE_ORDER. Then, chunks of free
>   	 * pages are not aligned to pageblock_nr_pages.
>   	 * Then we just check migratetype first.


Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


