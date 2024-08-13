Return-Path: <stable+bounces-67508-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CA995088D
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 17:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABFF41F21C57
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 15:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE2A1A01B3;
	Tue, 13 Aug 2024 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iwd+N3sH"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3946B1A00C9
	for <stable@vger.kernel.org>; Tue, 13 Aug 2024 15:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723561759; cv=none; b=PfjI0lCpZAsGcP2Y9lAy1HxB5afbmNYMO7Ui57GoYuNdligAFc93yCEIc2Jp1Q/8xFfR5yGN+b5zHFX2G/wcqe7cY9AnN1BSdqp+upH/R9asjS7zcmoChpI5/OMWjmRSAnpK3fxGctypZgJ1UfZ6JRC89bC4DtguHZx60mywnWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723561759; c=relaxed/simple;
	bh=/GcEWWpZq8y+N37/E08NFUqXKYdVeGt36Z/qjZUVTW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ABIMEHmKA3fXpM1aLyIBOWUsjU1b3udPVUP/I8CplOfcGKO0x5N83DNklDT48GPf8TBR54XSTpOiJpsKwkV4c7hNG1I41zvmFSGFGnnh4n5OVReXvfmVyxIe3GZWei5vbQUrWkcwZo/qRblC2sOvINBpTcxShjCTu57jNadywdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Iwd+N3sH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723561757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tYfScfbGIJQnIlB+eAa395d/aizhLRfIRY/+GrJId/U=;
	b=Iwd+N3sHilbT/2UAxKcyw3PcoENphAmhhcNCq7fe7Dli5Va/YNk6xIwcHb85giZNxDUnsv
	N6awAN87a6771O6jpv1pwYGRT588rJenMCzfLCSYaboHxPqIxJglVt6dctLzGZEi4lF8dc
	IlTBYDa3JHAWhXHpb40V8LKM/izpwwM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-ByMen6SoPXifrg09BKlMvw-1; Tue, 13 Aug 2024 11:09:13 -0400
X-MC-Unique: ByMen6SoPXifrg09BKlMvw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3684ea1537fso2746356f8f.1
        for <stable@vger.kernel.org>; Tue, 13 Aug 2024 08:09:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723561752; x=1724166552;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tYfScfbGIJQnIlB+eAa395d/aizhLRfIRY/+GrJId/U=;
        b=vq45jlbYt6eknuwnFowtA0WMhabfVF6t0wFQUGZcVTuOxYI/I0s1+U1iDqHb9zoNNl
         dOKipy/X9moS+Hgv6BNigDK/hNpqC4qCU38HldJevcvOeVplTTfM7LLPqsYLOrgPcmHc
         CL3UrOjh8MsESJ92PivpTujk1u/xppNcggdQQleJIE90FVhSPIXihToB0JqW9JUlEqwG
         NGq97CzJZmcSnFa3sEqRDf3Rq7htG/nt6cRqEe4LkBi8SBRqpTBiRmRuK+LxdRBAsuqg
         XHyQbzfbpjTGGOCKEqHlDjTt9xXZZSQvg1V0jPPGYti45Zqd0sVpoGAlGP+iJkMtSMLh
         kTxg==
X-Forwarded-Encrypted: i=1; AJvYcCXucTLOvaEXG28ob+Fmm4CDP/nNklUBiptdzI8pbJ7QMoB87Lj6lYkqMPhneAL3LU/vZamrd1om0TDsENwbCC42h9D2oVmc
X-Gm-Message-State: AOJu0Yw6876ft/vqpT/JCwlZ/I/n2JTwjVrd8nB5UvM5sYhbpvEq3Bbk
	sImnGKv2bsyii6k54nkJ6EJvS7UNMCpGozh65tOtL8j9Gf8J8kA3PCeoS5grm+CzPRow22vyanX
	DvJFN1hd4giOhtdSPGHmSKd2u4xc/2yI5/6MD1ylxxpwL+AqkRj+GaA==
X-Received: by 2002:a5d:648f:0:b0:366:e9f3:c242 with SMTP id ffacd0b85a97d-3716ccf080emr2779667f8f.12.1723561751717;
        Tue, 13 Aug 2024 08:09:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmTz7CthlDbY7apOcB7y5Lbw2eI043yEX1VOouAoqnffjtEsqQdJRlQOGjfFnoZTDEUp7oCA==
X-Received: by 2002:a5d:648f:0:b0:366:e9f3:c242 with SMTP id ffacd0b85a97d-3716ccf080emr2779633f8f.12.1723561751189;
        Tue, 13 Aug 2024 08:09:11 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f09:3f00:d228:bd67:7baa:d604? (p200300d82f093f00d228bd677baad604.dip0.t-ipconnect.de. [2003:d8:2f09:3f00:d228:bd67:7baa:d604])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4c937bb9sm10678075f8f.34.2024.08.13.08.09.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 08:09:10 -0700 (PDT)
Message-ID: <be75dbc3-3137-44a2-af45-5454728c98a2@redhat.com>
Date: Tue, 13 Aug 2024 17:09:09 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] alloc_tag: mark pages reserved during CMA
 activation as not tagged
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, vbabka@suse.cz, pasha.tatashin@soleen.com,
 souravpanda@google.com, keescook@chromium.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, stable@vger.kernel.org
References: <20240813150758.855881-1-surenb@google.com>
 <20240813150758.855881-2-surenb@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240813150758.855881-2-surenb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.08.24 17:07, Suren Baghdasaryan wrote:
> During CMA activation, pages in CMA area are prepared and then freed
> without being allocated. This triggers warnings when memory allocation
> debug config (CONFIG_MEM_ALLOC_PROFILING_DEBUG) is enabled. Fix this
> by marking these pages not tagged before freeing them.
> 
> Fixes: d224eb0287fb ("codetag: debug: mark codetags for reserved pages as empty")
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Cc: stable@vger.kernel.org # v6.10
> ---
> Changes since v2 [1]:
> - Add and use clear_page_tag_ref helper, per David Hildenbrand
> 
> https://lore.kernel.org/all/20240812192428.151825-1-surenb@google.com/
> 
>   mm/mm_init.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 907c46b0773f..13c4060bb01a 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -2245,6 +2245,8 @@ void __init init_cma_reserved_pageblock(struct page *page)
>   
>   	set_pageblock_migratetype(page, MIGRATE_CMA);
>   	set_page_refcounted(page);
> +	/* pages were reserved and not allocated */
> +	clear_page_tag_ref(page);
>   	__free_pages(page, pageblock_order);
>   
>   	adjust_managed_page_count(page, pageblock_nr_pages);

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


