Return-Path: <stable+bounces-189149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F73C025EB
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 18:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 57932563FF4
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 16:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B32E2877F2;
	Thu, 23 Oct 2025 16:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O4kSxcFr"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9191B28507E
	for <stable@vger.kernel.org>; Thu, 23 Oct 2025 16:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761236014; cv=none; b=eRdi3erm9MJAzCBX9I3fzGU3x/OHjQooquGHiYFEU9bFYyZFHJwc/SuW7UoDP9iNeOXGUoG/iCZfozCoatgptlY3tbFSmgqyAm+FZRRyl43Jw/vqhLWGQ95rqKK/ptylM7z3MWee5ET9W7KZWtd0GwY5ASi4siw76OaXO1iyGSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761236014; c=relaxed/simple;
	bh=5ZbYpXwMEDonxiJlAkt2uKMw0L1kxi32qzZgFk4LN8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g/LBktAAGr0Gu848umdu9uFLiDriTINRyhnrejPLfc1/U/GHvo7ap0gyISkS0BcEioolx4Q7Z68kvl13GAS7VMGjWkCiZzjvZarpQaSnPcrYeAbFJXRPyFr9rrBoO6UZeKZ1BjYiR4GzS3D1lc48bURsu8XwPm5kqgIig3Y8mpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O4kSxcFr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761236010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ig3HQ8bYhCVLH2BAUocbNQ6YHiWBZLmjBb9TUrUsFyA=;
	b=O4kSxcFrYrd7qBzsgs0fVLd127wpkN4f260T+XCHedTgToTNTnzbPfg2V1CQX5Ejp6913X
	inYCXNMPsonIPxsccZrTdLK8c3nYRh3ln4lT412LDD0G6IhnjEA7E8TxdxN/QRfC0pSN8C
	nF/56cj4tZ79fm9e09FFZbkdJ0/wTmA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-ikLEkNFFM_K-6-l1vCGFZQ-1; Thu, 23 Oct 2025 12:13:28 -0400
X-MC-Unique: ikLEkNFFM_K-6-l1vCGFZQ-1
X-Mimecast-MFC-AGG-ID: ikLEkNFFM_K-6-l1vCGFZQ_1761236008
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4711899ab0aso7142975e9.2
        for <stable@vger.kernel.org>; Thu, 23 Oct 2025 09:13:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761236007; x=1761840807;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ig3HQ8bYhCVLH2BAUocbNQ6YHiWBZLmjBb9TUrUsFyA=;
        b=CnUsb15G4VUc1Q8LYftcz4UaBUFXIuE1J6nJb/3OOyWz1fHYOUNfl0fCFTNYPyUhKr
         9Z+AZmvdRutcMJECg1ryNsJ96zeqVv8cfR0tVC6BfbbNMQV9irsN4Rn/VqN72FaXHx3Z
         fQd21zbIXxjJ/eBV4lmIt51ju5a8wmjTwC6UbvaKEu66x00nN0xYBbx3Aw8d/suAnroh
         6PcdXr0hNwqkLILxOjmYLCjpzD98I1kF1y/cqBAxrJPCvkuafESw+AIq1aVTdeHU3GEb
         gfr54wyMV7S2F3U2AwYs8xdKWzD9W8HKzCT/1ORdIMGAAKXfo7arYW8axdKosriEoNS/
         HNbg==
X-Forwarded-Encrypted: i=1; AJvYcCWSed5TXFx3KGHB8GMdd1Tmp1+0xMlUmmyxgDca1vOnNsYyctbf8NxLgLU2T6/Y/MOJDj03TbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbSTETZkrCxgFKmefVZW9xfYFT55kelMfWsDFC2XuA6/VPNWUw
	bqtGL7oRuQP7EiZ4I6OsuG2xQymgpujG6be2rO7D50jKTOo6TzFvivVSf+s73yLk9HSj+FbPMZI
	UCnQyoMowXLHVMnjAQ20002tJXqGpAew3jOZWJ0hTlnUp2hDd3QiWT5GxHg==
X-Gm-Gg: ASbGncv8wQCs46r7jTU71vF3GDzVrAq4ulJ3L5YBVVT91XvH7G/BqamlKhZfNbtlQ3Q
	9rLWnmI7FrY/uuJTHCu/idaY/z6APwqDSo3ogNGTNNN/bJAa7Ic1nRw+oQ4Cclca9YKcgr6kRtS
	fj5lVEKqoekiGp5wFMrW7eEbwSl4L3439hb1ImU9Q+Enwit1isH2EoAIJAElTEPrw6TBybfzfC0
	hcPhwO2qb1lz4ubLakl7x3Akpku8VbBIsApiMZUbRs6I5+1aTfPz17q9xxwevbJqTN31kxfTSRd
	XJTEJxuJFn+CVn3IHjqOJlMFmEuxR1WGX5RQoxpgmAMbidwLhdIBGWdKmGxE47dyLw/pOTTB6iY
	x/VYp/pfM0Y7K7ONYkztg0gWucK/asfSGGdgS9Wuh07zkI2N/zVTmx4tGbcqqi25AxtDLRwUWwH
	tego/1sDemZprL7jLHwoOTAHZr+vo=
X-Received: by 2002:a05:600d:8231:b0:471:1db3:6105 with SMTP id 5b1f17b1804b1-4711db36173mr118254065e9.33.1761236007591;
        Thu, 23 Oct 2025 09:13:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIBFxSSw3+IKAFXz0EGdOjGrB1iGECsd05YGqHD0B7YU/PNcL8LH4TmKfjCrviJIPRDDTiVA==
X-Received: by 2002:a05:600d:8231:b0:471:1db3:6105 with SMTP id 5b1f17b1804b1-4711db36173mr118253775e9.33.1761236007181;
        Thu, 23 Oct 2025 09:13:27 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475caf4642fsm42674025e9.17.2025.10.23.09.13.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 09:13:26 -0700 (PDT)
Message-ID: <774c443f-f12f-4d4f-93b1-8913734b62b2@redhat.com>
Date: Thu, 23 Oct 2025 18:13:25 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/shmem: fix THP allocation and fallback loop
To: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Hugh Dickins
 <hughd@google.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Liam Howlett <liam.howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Mariano Pache <npache@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Ryan Roberts <ryan.roberts@arm.com>, Zi Yan <ziy@nvidia.com>,
 linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>,
 stable@vger.kernel.org
References: <20251023065913.36925-1-ryncsn@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251023065913.36925-1-ryncsn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.10.25 08:59, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> The order check and fallback loop is updating the index value on every
> loop, this will cause the index to be wrongly aligned by a larger value
> while the loop shrinks the order.
> 
> This may result in inserting and returning a folio of the wrong index
> and cause data corruption with some userspace workloads [1].
> 
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/linux-mm/CAMgjq7DqgAmj25nDUwwu1U2cSGSn8n4-Hqpgottedy0S6YYeUw@mail.gmail.com/ [1]
> Fixes: e7a2ab7b3bb5d ("mm: shmem: add mTHP support for anonymous shmem")
> Signed-off-by: Kairui Song <kasong@tencent.com>
> 
> ---
> 
> Changes from V2:
> - Introduce a temporary variable to improve code,
>    no behavior change, generated code is identical.
> - Link to V2: https://lore.kernel.org/linux-mm/20251022105719.18321-1-ryncsn@gmail.com/
> 
> Changes from V1:
> - Remove unnecessary cleanup and simplify the commit message.
> - Link to V1: https://lore.kernel.org/linux-mm/20251021190436.81682-1-ryncsn@gmail.com/
> 
> ---
>   mm/shmem.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index b50ce7dbc84a..e1dc2d8e939c 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1882,6 +1882,7 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
>   	struct shmem_inode_info *info = SHMEM_I(inode);
>   	unsigned long suitable_orders = 0;
>   	struct folio *folio = NULL;
> +	pgoff_t aligned_index;
>   	long pages;
>   	int error, order;
>   
> @@ -1895,10 +1896,12 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
>   		order = highest_order(suitable_orders);
>   		while (suitable_orders) {
>   			pages = 1UL << order;
> -			index = round_down(index, pages);
> -			folio = shmem_alloc_folio(gfp, order, info, index);
> -			if (folio)
> +			aligned_index = round_down(index, pages);
> +			folio = shmem_alloc_folio(gfp, order, info, aligned_index);
> +			if (folio) {
> +				index = aligned_index;
>   				goto allocated;
> +			}

Was the found by code inspection or was there a report about this?

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


