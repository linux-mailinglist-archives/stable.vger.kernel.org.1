Return-Path: <stable+bounces-91804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EA99C0538
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 13:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A9F3280A83
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 12:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754951DDA3B;
	Thu,  7 Nov 2024 12:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KBjduNja"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CAA20F5B9
	for <stable@vger.kernel.org>; Thu,  7 Nov 2024 12:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730981080; cv=none; b=DSpXPC/kfh+GPcsV8zaiNOb2Or3eA+puWwiCbWSMcayIs9u75n9wtOtczJ/xJ6a7D78DjTFuEGoUMnaKSX67JMJc4KJfV3FGk7nbN+bRNrId4QkGBWPeiwLybAV4/ZYagZOF+FLmABNryPyblanTKnzhpVOiQz3YPibPzxBlkfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730981080; c=relaxed/simple;
	bh=AzJOLBzYiO/aaprDLbfnvaUSgq/KldF/W0iqEHK+o4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WzMcI/qQssXP7Q33vrTQl8lEVWJM9YAEuE9YcywXQzVWZY3xMsP6TxL4lKK+sjaqlnjp3Uxb8bcjU42DOn5iUVs3VHhPLAWP7lGBiYB595g/xtbjMVpDhaokh2QP92QpEXkd4U8EQwIXFXPqmg2MVRPFC4TqsVPmkhkVasS8ShA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KBjduNja; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730981076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=B5+vZDmkrf1avaWGcD/MhpIJkSW85xJ3HGW972ay+qs=;
	b=KBjduNjaqJrTIb1duZD5DAssgLRF7vpxgj94FUXkL9sJ3w0T14jh7HSsgZumhVTddT8GuI
	9P2m+wQqDyQkDK3ZHenh+b1u9CDkRwNp32F/4U6DTeVlDfvTMMLH3pZ22wmlMIJbY0qIYt
	WOMZgUtoHZEOi4SNStIUGu8p0/oRunM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-ujR9KHZINIKBD945Gu6bNQ-1; Thu, 07 Nov 2024 07:04:35 -0500
X-MC-Unique: ujR9KHZINIKBD945Gu6bNQ-1
X-Mimecast-MFC-AGG-ID: ujR9KHZINIKBD945Gu6bNQ
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4315eaa3189so8190315e9.1
        for <stable@vger.kernel.org>; Thu, 07 Nov 2024 04:04:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730981074; x=1731585874;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B5+vZDmkrf1avaWGcD/MhpIJkSW85xJ3HGW972ay+qs=;
        b=d64zvNhmxb1xBasLPToU84m+7Xqpkjki1Ub9sHPDvzl1thf9yeCSCd0yBexQv5Ss9k
         hLNsG7BDuZOvV3w73TzqclT1U7rtQ2dNv0NV7H5pZfQTe1zco8q3JrO28C6mLm58KTtT
         QXZf4ms8hxHSUa1ch5YcUuU40pLNU06gnf004oC9Rm/v2hO3ytCQ43Hvm3I84rQyGnW5
         amDxwpvQSGeqd7dFtZBtf5mJz1w7leROKeiLo4we7rlGhgQQY4UDHoSr5XM9PxS57zA1
         Hzw7zGu4oxlK4GPdWjAwI/1ZFJnOuh3/XiMvrjpJEFWtlPEYnNGY3rxAaLeTSJgTwhPO
         lxow==
X-Forwarded-Encrypted: i=1; AJvYcCVqz1dbIyPVeiTXYYtAeJcWtymqFxRSBEhr5MnwIYAZ1bZFSZclq46TCpmUkSC5OB53WMlWyLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpFeu/bx9UTXKmNFlbEbltusbnD7xEp9SexOotwQo08jPZCEmq
	DsVIRZQJCJj/sZ47rU7fVWJK0zWK24eKZNZGrT/U6yNA4o5VFwww52e0GVAEqegssdFh2newYC0
	3vbRbO6/fapNFBH7y7YR8ZGLPEPePrBLZRugIIFhDELqSxf47Ph9iFg==
X-Received: by 2002:a05:600c:444d:b0:42f:75e0:780e with SMTP id 5b1f17b1804b1-4328324ad00mr242896885e9.10.1730981074008;
        Thu, 07 Nov 2024 04:04:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3lXGq6xDxKBR/CQvZy5DO6U1eWql6WfDOCx037KzREk66lI1J4aMmIQDDc9WaWiP/L6MQEg==
X-Received: by 2002:a05:600c:444d:b0:42f:75e0:780e with SMTP id 5b1f17b1804b1-4328324ad00mr242896655e9.10.1730981073664;
        Thu, 07 Nov 2024 04:04:33 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:7900:b88e:c72a:abbd:d3d9? (p200300cbc7087900b88ec72aabbdd3d9.dip0.t-ipconnect.de. [2003:cb:c708:7900:b88e:c72a:abbd:d3d9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa6c037bsm57190955e9.22.2024.11.07.04.04.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 04:04:32 -0800 (PST)
Message-ID: <2a3d6cd7-ee80-4a60-939c-129e7d3e169d@redhat.com>
Date: Thu, 7 Nov 2024 13:04:31 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: fix a possible null pointer dereference in
 setup_zone_pageset()
To: Qiu-ji Chen <chenqiuji666@gmail.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
 stable@vger.kernel.org
References: <20241107113447.402194-1-chenqiuji666@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241107113447.402194-1-chenqiuji666@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.11.24 12:34, Qiu-ji Chen wrote:
> The function call alloc_percpu() returns a pointer to the memory address,
> but it hasn't been checked. Our static analysis tool indicates that null
> pointer dereference may exist in pointer zone->per_cpu_pageset. It is
> always safe to judge the null pointer before use.
> 
> Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
> Cc: stable@vger.kernel.org
> Fixes: 9420f89db2dd ("mm: move most of core MM initialization to mm/mm_init.c")
> ---
>   mm/page_alloc.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 8afab64814dc..5deae1193dc3 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5703,8 +5703,14 @@ void __meminit setup_zone_pageset(struct zone *zone)
>   	/* Size may be 0 on !SMP && !NUMA */
>   	if (sizeof(struct per_cpu_zonestat) > 0)
>   		zone->per_cpu_zonestats = alloc_percpu(struct per_cpu_zonestat);
> +	if (!zone->per_cpu_pageset)
> +		return;

Don't we initialize this for all with &boot_pageset? How could this ever 
happen?

>   
>   	zone->per_cpu_pageset = alloc_percpu(struct per_cpu_pages);
> +	if (!zone->per_cpu_pageset) {
> +		free_percpu(zone->per_cpu_pageset);
> +		return;

If it's NULL, we free it. Why?

> +	}
>   	for_each_possible_cpu(cpu) {
>   		struct per_cpu_pages *pcp;
>   		struct per_cpu_zonestat *pzstats;

Also, how could core code ever recover if this function would return 
early, leaving something partially initialized?


The missing NULL check is concerning, but looking into alloc_percpu() we 
treat these as atomic allocations and would print a warning in case this 
would ever happen. So likely it never really happens in practice.

I wonder if we simply want to leave it unmodified (IOW set to 
&boot_pageset) in case the allocation fails. We'd already print a 
warning in this unexpected scenario.

-- 
Cheers,

David / dhildenb


