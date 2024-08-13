Return-Path: <stable+bounces-67434-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A05C7950121
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 11:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD7F71C210AE
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 09:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9831917B43F;
	Tue, 13 Aug 2024 09:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bWQeLvXt"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A35914D42C
	for <stable@vger.kernel.org>; Tue, 13 Aug 2024 09:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723541127; cv=none; b=XEId17YrJl9GCS4vIJ2lzjzE+gbdLvq3ldW8SPmV9SjXw0C5+VZBCSw6HQm01CEc4eXfiXe3xZSu1Ungh50sJeEftJ37Eh/+oFxHg3yBea1Phddzd6k0AqSl0n139rLvvl+017OOhNcJoyj5W6EsJpuJGqetaeUImaGlMPaztPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723541127; c=relaxed/simple;
	bh=DbZ0wZSRnMMYewpbZV7hcFD2tQTCIeyXImBJMTREptk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OtRPJBTtJ9uD5SEE7M3Thi20kPiYw1Dx5giaZjbDczTsXfBo8ntfKaOtMMVD+XUDU1+2DzUD29Umdnw5aSlz9FQ4u+ilM9FgOmU6l78gBmPergYA5POYoADYhw6HPK9/WJ5ShAcFN510vk2voU0+DbDHERXsc4bDYmuXuY+Cvus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bWQeLvXt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723541124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/Sw+Mc2t+6eXwT6xt1L1ljV7cdp2IkgMruryZxwvVX4=;
	b=bWQeLvXtHNs3ntMhzg67oSESHw7qd5zQ1z3LAutbLuoeavav9WX++SI0nTZisJgkCOoz7f
	EXIyMCCR1neMPxcqB4W1YhwQ8dOVw9urV9FGtDf07/913hB9h+hCVe/QmWvC0+eOJ/yhZG
	s3qL9nGW/ZFsqf/qausuJ1HJp+MUX0M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-9F2Ak17wNiWTIJbxZAKksg-1; Tue, 13 Aug 2024 05:25:22 -0400
X-MC-Unique: 9F2Ak17wNiWTIJbxZAKksg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-428076fef5dso39097525e9.2
        for <stable@vger.kernel.org>; Tue, 13 Aug 2024 02:25:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723541121; x=1724145921;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/Sw+Mc2t+6eXwT6xt1L1ljV7cdp2IkgMruryZxwvVX4=;
        b=QMQD+kpueWRGmlsiiGSib1YEuiUece348O9LUDNPiFlCJbHRe4n0zrVolj4nRHU5un
         NfuCTck3UdtZcDaSnLFiNHPyuOo8C8fwyDhXc9FJRIHgd+UvVUgm+XBRsC3HnGsihtcA
         +bRESmj67HBjpFUoXpZX2XITFeklf4rKuCsdI7Y6uGiL+CIDfdbX7Zy2Arlb3cul42Z+
         2Ti/8w17otSFf1m8iHNSOmzxKBwekF13fiw1K8HkidsZEeGYAXcK67etUm9JvZVuqh0O
         8n/CWl6R5iq32cbN5AL8IoT26+GCDChyXYWeN6pwF4u/f9Q6r7gGWwpSUhjNq9Pglods
         ttTg==
X-Forwarded-Encrypted: i=1; AJvYcCX7hfP7FtneYDOLzZSTg73PLftxniS5R+UMuA52QVmbF0phXV0QJG/dFvAcIAqVVO2c/LOALUiJV/N9I7v3rnAUPs+hqioL
X-Gm-Message-State: AOJu0YySrMryy/6lGaM1u8J8ySIsH4b7RBpVzLG5PBUIwGxcOv6T+d3k
	uXJqPEH3flvkSFmuFcYgS7IYH3IfnIAZAIGl2hMi5PoZxy3ImuFWotSLXyH8uaO/cLwKDMmBcKz
	CIMQAxna4cmwT8xIinjTeVvrQXS1ntMAryKohAeJFyeYHKGHhE8MDMA==
X-Received: by 2002:a05:600c:310c:b0:428:10d7:a4b1 with SMTP id 5b1f17b1804b1-429d48736e3mr21245985e9.25.1723541121294;
        Tue, 13 Aug 2024 02:25:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBxteN7SWDtiCUL3jeHX4PpQ4G1qTpWADiDYhX5ACMmGGBqxeMswt2HTwf3rOoBRlQElOaZg==
X-Received: by 2002:a05:600c:310c:b0:428:10d7:a4b1 with SMTP id 5b1f17b1804b1-429d48736e3mr21245755e9.25.1723541120741;
        Tue, 13 Aug 2024 02:25:20 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f09:3f00:d228:bd67:7baa:d604? (p200300d82f093f00d228bd677baad604.dip0.t-ipconnect.de. [2003:d8:2f09:3f00:d228:bd67:7baa:d604])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c776074asm130978685e9.48.2024.08.13.02.25.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 02:25:20 -0700 (PDT)
Message-ID: <471af0a8-92fc-4fe0-85e4-193d713d4e57@redhat.com>
Date: Tue, 13 Aug 2024 11:25:19 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] alloc_tag: mark pages reserved during CMA
 activation as not tagged
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, vbabka@suse.cz, pasha.tatashin@soleen.com,
 souravpanda@google.com, keescook@chromium.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, stable@vger.kernel.org
References: <20240812192428.151825-1-surenb@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240812192428.151825-1-surenb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.08.24 21:24, Suren Baghdasaryan wrote:
> During CMA activation, pages in CMA area are prepared and then freed
> without being allocated. This triggers warnings when memory allocation
> debug config (CONFIG_MEM_ALLOC_PROFILING_DEBUG) is enabled. Fix this
> by marking these pages not tagged before freeing them.
> 
> Fixes: d224eb0287fb ("codetag: debug: mark codetags for reserved pages as empty")
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Cc: stable@vger.kernel.org # v6.10
> ---
> changes since v1 [1]
> - Added Fixes tag
> - CC'ed stable
> 
> [1] https://lore.kernel.org/all/20240812184455.86580-1-surenb@google.com/
> 
>   mm/mm_init.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 75c3bd42799b..ec9324653ad9 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -2245,6 +2245,16 @@ void __init init_cma_reserved_pageblock(struct page *page)
>   
>   	set_pageblock_migratetype(page, MIGRATE_CMA);
>   	set_page_refcounted(page);
> +
> +	/* pages were reserved and not allocated */
> +	if (mem_alloc_profiling_enabled()) {
> +		union codetag_ref *ref = get_page_tag_ref(page);
> +
> +		if (ref) {
> +			set_codetag_empty(ref);
> +			put_page_tag_ref(ref);
> +		}
> +	}

Should we have a helper like clear_page_tag_ref() that wraps this?

-- 
Cheers,

David / dhildenb


