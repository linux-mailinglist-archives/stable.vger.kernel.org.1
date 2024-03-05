Return-Path: <stable+bounces-26811-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1183A872411
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 17:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 350321C22DB7
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 16:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE40212882E;
	Tue,  5 Mar 2024 16:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jTVjaayJ"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5398128814
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 16:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709655739; cv=none; b=GCUXYvoHxpiRAoGvdKClSPB38BWz7BXgIxqqQ/n3LuKXvSDquY2UXJGpzRDPgspMoXwzcmtfWN5rJqLO7TJet1d85HeEA5Z57NySO+iI93ayffk+680QO9bpxTu36C+39AkpEo885zQ+ksCJV4H5+K+ag+rOxmzolcxURoV9Nbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709655739; c=relaxed/simple;
	bh=FZUe1ZaOG5MU6cBoGtM34e8xvQZb+J+lZMf3I2ITCZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qTMk+jxgO/jYr42bhcNhNdmFCwH+Zj3GmwYtF0Yu0E7ItwBL9QBS6qekM8KoE8/+OU5qdTGOjCb6Tob1xdTPcrjsNhoIXjgQWFMqRZsgDVwyNtzzTlux8jW482/3WiESlBj4Z68tJzHwmGrblsLfA9bPrhmL9jHqEInmJIuTUgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jTVjaayJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709655736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HP9C+rdgr4fOwFC+fJYUv+fItgUKFD8btPOgXvimh54=;
	b=jTVjaayJto2G5fh0ACv7DZXCb0u9Bp8uxBENIzLvRFHGaFF0PUqkpkor5Z1undHbWqa9/Y
	wpumK48cQpAdvpbwzXGkckS1GzSkwN7YF2sdrYDwz8S5NaFyx0YtylswRvj7Vk+c1QLG6V
	JFj6ptcYjgAD72njBLf8KLz0gc7gM5k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-xkoc-caKPI-5JQZqXrnl4g-1; Tue, 05 Mar 2024 11:22:10 -0500
X-MC-Unique: xkoc-caKPI-5JQZqXrnl4g-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-412de139895so13087035e9.0
        for <stable@vger.kernel.org>; Tue, 05 Mar 2024 08:22:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709655729; x=1710260529;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HP9C+rdgr4fOwFC+fJYUv+fItgUKFD8btPOgXvimh54=;
        b=QyFrNGzc9L6WChvOFoBNyIb9d2wdZsbm29yd/4uC3nZRaSII3B/A3Dtx+2NVUxYD+S
         mq2Ibk32/SevuaoTuHWgMnQ8108+iVpgj17O+T+jwNGYNJY9JHGNQgvlT0MipRymHblh
         uoM7wz+RYC6qHkcRlWzvkeeLa3Ojp6M+IXy0TteGaUVRZoHZhU64MC5TLXS8i4+89YeC
         oy4Tt/8sCKqyxabrtGKC/+7XrHRpx6uZMhdkctsSiCzDWqN47FZlt9vLAo4jSqJzV/Et
         d1G1QDEYjzApv7Q2P7rL2UdyTQ9yrLnLvSzSnj7DoVOQahtSDB7r9D9akn7gM2Xm30ll
         2BkA==
X-Forwarded-Encrypted: i=1; AJvYcCVI8PHGfnZYGmxvTi57z2+woa+F0oPxOGSjkfGIjvwD31EY4+f1wRj7SBEHQfYsSP7TeWH72LxT9V4J0fHwNKyQI3OcAKYK
X-Gm-Message-State: AOJu0Yx2RnbJWHTyEqyV7nUUgEFvKv2I9Kl6mS+d+rvKggO2g81Mp6Fd
	E36FUglNWNDPtXLSuYunmEie05Yqi5EKuogA/V3opjuSDMcHLgeEMr5txZK2MFqw1EiYwG+oUys
	G9YO4cCxe3O6oWFZQwiB7yAPGzgij5TZ5HjjUKBaKm8uR/qdrJpeiIA==
X-Received: by 2002:a05:600c:3846:b0:412:e568:a123 with SMTP id s6-20020a05600c384600b00412e568a123mr2788381wmr.10.1709655729026;
        Tue, 05 Mar 2024 08:22:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4rmScddkOzoQRTAWscoHiHRAJMlx5bhlP/Gy3d1Zo0RCrRIlqJ0Texua0xTBLdiCnIOX/5w==
X-Received: by 2002:a05:600c:3846:b0:412:e568:a123 with SMTP id s6-20020a05600c384600b00412e568a123mr2788357wmr.10.1709655728647;
        Tue, 05 Mar 2024 08:22:08 -0800 (PST)
Received: from ?IPV6:2003:cb:c73c:8100:600:a1e5:da94:a13a? (p200300cbc73c81000600a1e5da94a13a.dip0.t-ipconnect.de. [2003:cb:c73c:8100:600:a1e5:da94:a13a])
        by smtp.gmail.com with ESMTPSA id p15-20020a05600c468f00b00412b0e51ef9sm18506547wmo.31.2024.03.05.08.22.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 08:22:08 -0800 (PST)
Message-ID: <58812e2d-8f81-4760-aa6a-7a0fbe42170e@redhat.com>
Date: Tue, 5 Mar 2024 17:22:07 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH STABLE v6.1.y] mm/migrate: set swap entry values of THP
 tail pages properly.
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>, gregkh@linuxfoundation.org,
 stable@vger.kernel.org
Cc: linux-mm@kvack.org, Charan Teja Kalla <quic_charante@quicinc.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, Huang Ying
 <ying.huang@intel.com>, Naoya Horiguchi <naoya.horiguchi@linux.dev>
References: <20240305161313.90954-1-zi.yan@sent.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240305161313.90954-1-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.03.24 17:13, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> The tail pages in a THP can have swap entry information stored in their
> private field. When migrating to a new page, all tail pages of the new
> page need to update ->private to avoid future data corruption.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>   mm/migrate.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index c93dd6a31c31..c5968021fde0 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -423,8 +423,12 @@ int folio_migrate_mapping(struct address_space *mapping,
>   	if (folio_test_swapbacked(folio)) {
>   		__folio_set_swapbacked(newfolio);
>   		if (folio_test_swapcache(folio)) {
> +			int i;
> +
>   			folio_set_swapcache(newfolio);
> -			newfolio->private = folio_get_private(folio);
> +			for (i = 0; i < nr; i++)
> +				set_page_private(folio_page(newfolio, i),
> +					page_private(folio_page(folio, i)));
>   		}
>   		entries = nr;
>   	} else {

Hopefully Charan can run the reproducer against this.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


