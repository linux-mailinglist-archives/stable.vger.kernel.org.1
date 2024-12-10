Return-Path: <stable+bounces-100394-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0DC9EADA0
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 11:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9E4C1883179
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 10:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F204C23DEA2;
	Tue, 10 Dec 2024 10:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UomKj/Oh"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034AB23DE8E
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 10:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733825439; cv=none; b=RLjazDSSm37mJdaVuzJ25I3O4k2mP5DilPPiMDY+To6EHkDwW4PqtLtBKEbPP2Tt9VbYCyV3yckdeJ65mXlxAAEZ9ibbsQ+hU2xpRtUuQWdnQ3RCJiNXnR15FLwgK6M6sWprLnMxud4XaBMHehVRYh4VLScwE6P13mvXaCyxTGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733825439; c=relaxed/simple;
	bh=HFMbe08H1k1y0mqVM0u4b8h/zU/qVcRKr7WB9uytT8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SBJdogL729NLEeCoBEGhcxY/Rw/928l7Z4NpR96c1h+6kXSjhSR0XkOoQpLxIQ1aRGgB5QPbo/EeUolTxq1Uu1Zfjc/ntZPHmyMxeQmICNU+ql8R6KV7+sDN047GzMem2rUB3Fn5YLnP17G36fPt4Res/+efDrnNdAKfJlxabXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UomKj/Oh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733825436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WHKaqHT8TmPKp+vfFyKZV4r9sjaGCxpUSBkDEyH4Mpw=;
	b=UomKj/Oh2j7xLqZFEUIC20ADp38z7b0nIv+JJuIkM2nH/o2500COwXfMY0SiZjPARcVDJ2
	vwZtaLsMhUuOQUbgp5+8PhGAkrloM3fXOiPgS3GKtlRMn5oOPWrhxPI3DMCIov8APt8PIN
	1S3gPMwGIpzs5fDZoCUpDUJYfAeDgso=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-gF8mYmS_OzyNOTB_zhG-NA-1; Tue, 10 Dec 2024 05:10:35 -0500
X-MC-Unique: gF8mYmS_OzyNOTB_zhG-NA-1
X-Mimecast-MFC-AGG-ID: gF8mYmS_OzyNOTB_zhG-NA
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-385e2579507so3106835f8f.1
        for <stable@vger.kernel.org>; Tue, 10 Dec 2024 02:10:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733825434; x=1734430234;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WHKaqHT8TmPKp+vfFyKZV4r9sjaGCxpUSBkDEyH4Mpw=;
        b=Vw1D4s5v0WtdI701SOnWOcz4MLlrqrmfZxRi3KCu4sn4Z4feLNrpFb248hf5P4aLRY
         449KNDyXhNPEcG++iLGa1Z7IFZPJQ2z//S6p5L/FAk1dQd6rLLxEBAzaptxAzvKSMbGm
         lmVng4TPs69ggyW/z5b8MvgdaJpN5nT2J1Qb2X9QAaArnvIqlUdE0T8knNt8kvYPFmgl
         tXWYqk+3pZWw3ik0hQUPLV7fXF8nYVbu2hKg4OKgyvj5XFJixzQryQIvV9RfRWHzeU6m
         bhs5th62PyDDMKL2XoicseUzdIF6zHKBqtdGzRKc7eMwduCV2gXRP2ZqmFGjpgi05ETY
         AKhQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5Xxw+Bwtwoj8si51jZXlOi4JeEJAfFXN2HahZuPS656zLApn5BxIlPNzCP7JavRgFnTgVsDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCMigVuQv2cyj6VoTDcloxb0ZhR0bqu8kIEl9GrlejVzpy8/dL
	foWQs7uHyjj6kvO+IJ1WU6nZcMFcdv9zHp5jC7gEJtpVFQdHsHB3mtxXk151bHGmSJf0dzn54nd
	1FY202GeA8laCotta8S4KdtyqF50Ok/KG0cOjhrWbdLNIWNIMD9NQdA==
X-Gm-Gg: ASbGncv3V1LowmebfiMmcgiLdIpjOdTtpQTJI3A2RjignydEqfSSCzxIZFVapPY5z0q
	j9j3GOQb4yV7ly/HeQ2z+1iftQ0QLs/t7jyzydj009FtBP19lkrHZcxJlzRt6g6cdBDnpV2MOKb
	BBiYpakCEgjbUjN2ehRkffHs9zv8jkjdhFEMBmTyqrYf4o5/0CjBKRjzdjIwVVTqkvpELglk2FJ
	eJy1u6SI/qT4Tban3zJh+AkVL/hIV0VFF5Fc6PKsUyfj8+veC+4IvbmQ73qTqRH6+Nm5JNCBrJe
	3HjyNgcYpsI68P5eGV/j1KU61AL22oVYWsBESm+hhBET7uU8HLdvSiHSnsy30Z7j97f9SQzRvF9
	S4SUErg==
X-Received: by 2002:a5d:5f8e:0:b0:386:3803:bbd8 with SMTP id ffacd0b85a97d-3863803bdc1mr8557224f8f.59.1733825434214;
        Tue, 10 Dec 2024 02:10:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+VnuFpTTDtc9IBkNAkw6YO/9HOkWYUVF564g0JrmQz1f6HgbOaLN8ZjLolBzYrdtJsxAHDQ==
X-Received: by 2002:a5d:5f8e:0:b0:386:3803:bbd8 with SMTP id ffacd0b85a97d-3863803bdc1mr8557197f8f.59.1733825433837;
        Tue, 10 Dec 2024 02:10:33 -0800 (PST)
Received: from ?IPV6:2003:cb:c723:b800:9a60:4b46:49f9:87f3? (p200300cbc723b8009a604b4649f987f3.dip0.t-ipconnect.de. [2003:cb:c723:b800:9a60:4b46:49f9:87f3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da0d26b0sm190812545e9.9.2024.12.10.02.10.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 02:10:32 -0800 (PST)
Message-ID: <69d2c332-04f1-43df-950f-931f20ad725e@redhat.com>
Date: Tue, 10 Dec 2024 11:10:31 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/page_alloc: don't call pfn_to_page() on possibly
 non-existent PFN in split_large_buddy()
To: Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 Yu Zhao <yuzhao@google.com>, stable@vger.kernel.org
References: <20241210093437.174413-1-david@redhat.com>
 <c06e7552-bcce-49b9-8d77-72de48014a56@suse.cz>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <c06e7552-bcce-49b9-8d77-72de48014a56@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.12.24 10:48, Vlastimil Babka wrote:
> On 12/10/24 10:34, David Hildenbrand wrote:
>> In split_large_buddy(), we might call pfn_to_page() on a PFN that might
>> not exist. In corner cases, such as when freeing the highest pageblock in
>> the last memory section, this could result with CONFIG_SPARSEMEM &&
>> !CONFIG_SPARSEMEM_EXTREME in __pfn_to_section() returning NULL and
>> and __section_mem_map_addr() dereferencing that NULL pointer.
>>
>> Let's fix it, and avoid doing a pfn_to_page() call for the first
>> iteration, where we already have the page.
>>
>> So far this was found by code inspection, but let's just CC stable as
>> the fix is easy.
>>
>> Fixes: fd919a85cd55 ("mm: page_isolation: prepare for hygienic freelists")
>> Reported-by: Vlastimil Babka <vbabka@suse.cz>
>> Closes: https://lkml.kernel.org/r/e1a898ba-a717-4d20-9144-29df1a6c8813@suse.cz
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Yu Zhao <yuzhao@google.com>
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

BTW, staring at nr_isolate_pageblock accounting, I just stumbled over 
prep_move_freepages_block(), and I am not sure about the 
zone_spans_pfn() checks in there.

With overlapping zones, these are not reliably, which makes me believe 
that maybe these checks are not required at all. Or that there is a bug. 
Or that there is some implication that these checks are only required on 
systems without overlapping zones :)

-- 
Cheers,

David / dhildenb


