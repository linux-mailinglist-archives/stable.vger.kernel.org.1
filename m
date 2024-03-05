Return-Path: <stable+bounces-26812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5F987241C
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 17:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C7941C22144
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 16:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42856128834;
	Tue,  5 Mar 2024 16:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WzSgyWli"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D211A12D20E
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 16:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709655773; cv=none; b=lMoWo8hYhJfYqiomHN6rxaanncKXA1pfg9uqyTFFzg7TyesvlkJnfe37dwtBL4j4D9CY/YG9D48fpILpgdQU6qGYrd0wSfxmSI9VscLy6+oYNFzPeACfaWUQRsmnCQ2Kf82IsvDkzHxVbUM5F5gx9kTyHopz7kM0Qj68rlZVQfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709655773; c=relaxed/simple;
	bh=H2nHiqePsRNB1GrM04uJm+jed+bQMZUxi8z+I4qSaSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=La0Y54Ks9qrMKCNrDatx8l4wGs6P36ckgBCJDCcxWSyDbENvsv3hPSLMpoV/MvvSZ8Tko4umBDd1YWmCnM1w1vtwa3krjLx/leboMGTTOwMauFIjIdiiV7zWHKHfzP9Wcif3sqpAfQXhYP6vgGAxT+zrbzP0iNdXLZ1JMf7IdQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WzSgyWli; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709655754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eB5ZE4IeUzrBERTZCyEgwgZexKLULw6UXvqACkDYvNQ=;
	b=WzSgyWlixha+aIUlG9gF+d8zSJ9h0a7+LDEpxz3W/gYoua5H6VLQRgAXo7A6bxEoOZWf7h
	kp3zrQAZ60K3nIw0xAWinSVTot0DXZ/Rl9QAmIcyVbNe0V5Xi6v2GgcznUKoMvu0pja4zA
	AibAdMey+ZYzdX0iIq5ozZ6JCppWhoo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-oR25JlfuNFG-qpjJeWf6TA-1; Tue, 05 Mar 2024 11:22:32 -0500
X-MC-Unique: oR25JlfuNFG-qpjJeWf6TA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-412e79148d8so10481845e9.1
        for <stable@vger.kernel.org>; Tue, 05 Mar 2024 08:22:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709655751; x=1710260551;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eB5ZE4IeUzrBERTZCyEgwgZexKLULw6UXvqACkDYvNQ=;
        b=w2MSlH82BALy/qNCOsrULEgt+ZOOurEOFJmNHTaXQrjS12Y6aRqLnt5OXok/YgE7bk
         pVnDOiTsDwiCuTlnrwUSQOZY8gbZKquYMtNHFAtX5O1qn8zZtY62MtRW8Vf1WmL5PusB
         jQUVPaW1304s08r8Dmd7NNASSzPwTKqIj3U+B97Yv0d3Wr8yoWgmjk4Z//DBTQczm4Fd
         J1K76NhrP9p6eXhWybcmyWpXq5ElLocyHZLael32v0JoK1Gy0GJMngrIgfxSnyAbzkA5
         dC0YmkysFsZQOrqQUrh9Avr0eOAQdWAao1VqkrZNiPYt8g9qeiGsxzcWDK3fgE8D49CF
         HF6w==
X-Forwarded-Encrypted: i=1; AJvYcCVfWjUrT5JVXWNTCPYIjk1xyBnJO1b1woCkzeMaPYlRaDc9bAALS3BTNo71LWADKaDQUXAgL5xpV7tQbPh0l6xcI1X9u/LG
X-Gm-Message-State: AOJu0YwBxO5eBCx7rzyIbMonJtzlFtOeL2Qu1wsrUr6+Q64wYpbkSkjM
	0/UtdZy1Rj8R5YfXFDgpR6vnlHNmPRgG5PDTIUTceMJgH06rAGpmscseYHXAwMgd+A9PF+n5xj+
	7x1H5WaY1HSHKMhtWess21vusFMeQrqMQ+iPT8m5SA4TmPdGRikeyaw==
X-Received: by 2002:a05:600c:4ed2:b0:412:7218:bda4 with SMTP id g18-20020a05600c4ed200b004127218bda4mr8553455wmq.19.1709655751523;
        Tue, 05 Mar 2024 08:22:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDPBJuGfflpwUZv/PW8XFBFl2UFZBLK4M5CY79mfSt1bOPfFRZbuNZR2mV/9NV8CxVGjNBmw==
X-Received: by 2002:a05:600c:4ed2:b0:412:7218:bda4 with SMTP id g18-20020a05600c4ed200b004127218bda4mr8553443wmq.19.1709655751154;
        Tue, 05 Mar 2024 08:22:31 -0800 (PST)
Received: from ?IPV6:2003:cb:c73c:8100:600:a1e5:da94:a13a? (p200300cbc73c81000600a1e5da94a13a.dip0.t-ipconnect.de. [2003:cb:c73c:8100:600:a1e5:da94:a13a])
        by smtp.gmail.com with ESMTPSA id p15-20020a05600c468f00b00412b0e51ef9sm18506547wmo.31.2024.03.05.08.22.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 08:22:30 -0800 (PST)
Message-ID: <0b44996f-2e1e-4427-91a6-15d6e4820faf@redhat.com>
Date: Tue, 5 Mar 2024 17:22:30 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH STABLE v5.15.y] mm/migrate: set swap entry values of THP
 tail pages properly.
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>, gregkh@linuxfoundation.org,
 stable@vger.kernel.org
Cc: linux-mm@kvack.org, Charan Teja Kalla <quic_charante@quicinc.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, Huang Ying
 <ying.huang@intel.com>, Naoya Horiguchi <naoya.horiguchi@linux.dev>
References: <20240305161941.92021-1-zi.yan@sent.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240305161941.92021-1-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.03.24 17:19, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> The tail pages in a THP can have swap entry information stored in their
> private field. When migrating to a new page, all tail pages of the new
> page need to update ->private to avoid future data corruption.
> 
> Corresponding swapcache entries need to be updated as well.
> e71769ae5260 ("mm: enable thp migration for shmem thp") fixed it already.
> 
> Fixes: 616b8371539a ("mm: thp: enable thp migration in generic path")
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>   mm/migrate.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index c7d5566623ad..c37af50f312d 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -424,8 +424,12 @@ int migrate_page_move_mapping(struct address_space *mapping,
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


