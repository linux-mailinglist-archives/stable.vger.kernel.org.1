Return-Path: <stable+bounces-26873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EA88729DC
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 22:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD64428CE3D
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 21:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA21712BF13;
	Tue,  5 Mar 2024 21:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iD+thwF2"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF1B134BD
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 21:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709675800; cv=none; b=r0DdgjT75gwl+S86NHQKeTWipylSLLOHP6vndJX2c07v7eD+/Jr9KdvcOymTvNSFoMIZDztYhX1Xo+e0gtAF/JCXemYu9Nl9s8/u3DeRvBJz3T9+5mmEhUq5lZdFEsoqbn5zmSRUX5zjITugYc5NieL4wM2d1rkPJCNyl9BjY/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709675800; c=relaxed/simple;
	bh=NWHcRR0XyP1Aa01kcMViE/37zvx05iOMTG+bG2Gd4fM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dKSxIDhspih58oEVd7atCjdgCPXFqTvsTh2TudDAZRq9xC4t9PvnXivANyoUtQc9wuZCanuFd0cwO69GBtpBexfV97gqEG7lcaB0BFsuZYtpgaJ2ld12+coObwgVVDYy+6GEVkgCfDi5eN+qQOlS1g1JVO2Q9Ndgz/D87kwAzM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iD+thwF2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709675798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EfR5ql1bnL1BBM4O2/FJCsNm9rdOQ7h22DgerCFUnxY=;
	b=iD+thwF2bBVQyXJ2yAXB8vr1HN0tT1rcQ72EMDpOvgNTI0FKUf9Iu2G+z+LzZW7A9xNRbI
	Jw+sVqxaAcdcVu/pcRVj1aKkdT6pvTH57UVP5/NJpvyFg1Qr9F1myg1TI9cDsCsyWtn8dB
	rq+suiK71BbIXbwDW7GSEmSeryDcuxM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-kLUNNMw9NWivgkqJi1cL5Q-1; Tue, 05 Mar 2024 16:56:36 -0500
X-MC-Unique: kLUNNMw9NWivgkqJi1cL5Q-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40e435a606aso7682575e9.3
        for <stable@vger.kernel.org>; Tue, 05 Mar 2024 13:56:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709675795; x=1710280595;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfR5ql1bnL1BBM4O2/FJCsNm9rdOQ7h22DgerCFUnxY=;
        b=e6hTXIBIPQjNjjeBH+W1iimYpbDijR5Vemxv9XMBj/zwBCMevYVhMdx5wfkI54fQvc
         z70AD7qxSeApNm4xzq6T7LiR2bdeuUBSg9OXPUnughz5YYzutqYJ8BVexdfkmSxtAS+v
         XH7TgCEKk/GFI1o9GmQvTE8ytPubac2TUqanc/kBVCJKmHHPoBdyxGae+ex2uZCiavPj
         pTPP9PuiSJPJRch4JjvUpuZUf0jRcAqHC9Nnpw5edrBkpaN8UGqNa0Qr/ggSqtKDqved
         BG4GZSeIyfW2Fp6fIhinHbmXfZZniUKBJbhub/UmZhIe7Oa4h4hUkWRq72PVd1MeSGvU
         JQCg==
X-Forwarded-Encrypted: i=1; AJvYcCXOtO1vlizwjumAPyx6kLvZBVorXIPDtYIs0dgEgahLmzj+SQaj9d4y9OxKXcmirhTIOffqdZWPuKhowrDlu9HU1eo7KyW7
X-Gm-Message-State: AOJu0Ywna5ou0R6WXb6ANcvi3iJrzlvPQnHg3Dl6WzGoWdev4c/Z6WDi
	MX1W+zh/to123QLC9GiYiInp8cPc7fINfSCZ3wqkeoocTS5yFhW8SmVaEpdMJtOoSkXyBakyAy7
	96gaDv5sOvKtu4+DcaPb3xJpgJDymFNJzYRx2hu65yMx0HzUMPz7pj6S3y96fUQ==
X-Received: by 2002:a05:600c:4e87:b0:412:95fb:e41 with SMTP id f7-20020a05600c4e8700b0041295fb0e41mr9998600wmq.24.1709675795511;
        Tue, 05 Mar 2024 13:56:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFthwWMomxIJeyQnmkjjNrB+bWUg2DKFGudpo6LYh3d3VBF4WtUVrMf4jtLNe9hKZDpbYYnQ==
X-Received: by 2002:a05:600c:4e87:b0:412:95fb:e41 with SMTP id f7-20020a05600c4e8700b0041295fb0e41mr9998593wmq.24.1709675795139;
        Tue, 05 Mar 2024 13:56:35 -0800 (PST)
Received: from ?IPV6:2003:cb:c73c:8100:600:a1e5:da94:a13a? (p200300cbc73c81000600a1e5da94a13a.dip0.t-ipconnect.de. [2003:cb:c73c:8100:600:a1e5:da94:a13a])
        by smtp.gmail.com with ESMTPSA id b17-20020a05600c4e1100b00412f428aedasm230912wmq.46.2024.03.05.13.56.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 13:56:34 -0800 (PST)
Message-ID: <ec222d40-a939-4fff-bdaa-345c5632fdb4@redhat.com>
Date: Tue, 5 Mar 2024 22:56:34 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH STABLE v5.4.y] mm/migrate: set swap entry values of THP
 tail pages properly.
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>, gregkh@linuxfoundation.org,
 stable@vger.kernel.org
Cc: linux-mm@kvack.org, Charan Teja Kalla <quic_charante@quicinc.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, Huang Ying
 <ying.huang@intel.com>, Naoya Horiguchi <naoya.horiguchi@linux.dev>
References: <20240305162946.94199-1-zi.yan@sent.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240305162946.94199-1-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.03.24 17:29, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> The tail pages in a THP can have swap entry information stored in their
> private field. When migrating to a new page, all tail pages of the new
> page need to update ->private to avoid future data corruption.
> 
> Corresponding swapcache entries need to be updated as well.
> e71769ae5260 ("mm: enable thp migration for shmem thp") fixed it already.
> 
> Closes: https://lore.kernel.org/linux-mm/1707814102-22682-1-git-send-email-quic_charante@quicinc.com/
> Fixes: 616b8371539a ("mm: thp: enable thp migration in generic path")
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>   mm/migrate.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 034b0662fd3b..9cfd53eaeb4e 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -441,8 +441,12 @@ int migrate_page_move_mapping(struct address_space *mapping,
>   	if (PageSwapBacked(page)) {
>   		__SetPageSwapBacked(newpage);
>   		if (PageSwapCache(page)) {
> +			int i;
> +
>   			SetPageSwapCache(newpage);
> -			set_page_private(newpage, page_private(page));
> +			for (i = 0; i < (1 << compound_order(page)); i++)
> +				set_page_private(newpage + i,
> +						 page_private(page + i));
>   		}
>   	} else {
>   		VM_BUG_ON_PAGE(PageSwapCache(page), page);

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


