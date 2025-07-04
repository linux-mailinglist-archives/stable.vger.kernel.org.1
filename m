Return-Path: <stable+bounces-160176-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9A1AF90D6
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 12:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADD211C8602F
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 10:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91DF29A310;
	Fri,  4 Jul 2025 10:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D0boC3jd"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4C624A066
	for <stable@vger.kernel.org>; Fri,  4 Jul 2025 10:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751625745; cv=none; b=tDfoaf0NMrXHLq7Th2636Z6Fa+qbygPF/9vJio5Yxae3BCg9iT1froXpL40qOlIW3xMVVbh+NrJaGgFhR2c2gLGDSvncQRClOFZAsyvxayHkU5RzP6GQHTo87i16hPU2w+mMWMzt7yMnUUBUXGVvXFUGpizaodCsxEVWvoftvgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751625745; c=relaxed/simple;
	bh=MZa71W+swZHtAuBchjrGy62g5I5ixhRPzSjn15utSJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZH7YohUigMm07jKQA94LP5wBGI4vKh2bxdhskLyKdaV59JVcScXrMMwJsCOUuCQWSakGyeb7MykKR9j34aPwZbjjmY3yzT8dnAU23NcRhogYDoem5OxQrjIhQsyEcZvJpoKRLVmCnrHY6nGLQBzIs+AYrPvSWOtlrE15OZuV42k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D0boC3jd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751625743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pDYDx7CpjYf5Q8KMXZMdVSh7J69mEM1VNNLfTxrJ8A0=;
	b=D0boC3jd7BplI6kYumDPGTIY2aly/1Hf30YtLzWn8Qm7IOLrymXK2rSNHL8pVM8JB/elXa
	WZsMgPlv3r/08BCS0Lzy43oqjfeSNQ9d8vbPZ17icslVXv/UrG+vl1d92qoIciokvplf6f
	SS02QrNz7ndFNN5AH04HGNSWw9BszZA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-RB8WqihjNviFOziRSbfqxA-1; Fri, 04 Jul 2025 06:42:21 -0400
X-MC-Unique: RB8WqihjNviFOziRSbfqxA-1
X-Mimecast-MFC-AGG-ID: RB8WqihjNviFOziRSbfqxA_1751625741
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a5058f9ef4so334785f8f.2
        for <stable@vger.kernel.org>; Fri, 04 Jul 2025 03:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751625740; x=1752230540;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pDYDx7CpjYf5Q8KMXZMdVSh7J69mEM1VNNLfTxrJ8A0=;
        b=K0mb7sba17UeOmWQ2uW+6yRuf2x9vBWKB6qaAk0Rl0/C7hQFLKiG1o0gGp1o7cX2Qs
         bH85Adc4LQLQJANQK5K03GifuRogbIPqGFna+rB2zb4g1/BkxSIX+luuomW5Z298p3OC
         s7CxhIQjpyYFpl4kmsmsH1LH7Y4iSuruDT1ZFDHYJ2dRHwu+jyJ/XKe+BWYehk2QGXXG
         oWfTFBtHW19RHNq2SUwAFdXrpCeRR+jYNi4OnWBlEBY3J9V28gt48THHmc7gDkuP/NS9
         QqSFYYL1swXLYygYAt5M5Grd5Jn8u4sJ1e1uM6vek1cq4dfXyZ/35Ut/VHTeYBwcgRO+
         nyow==
X-Forwarded-Encrypted: i=1; AJvYcCWhUtjn4YOCcbex/gMrWceXRkW6jYEqnB6wyLtXFg8ojnN+DFwupcm693dxtdtE6C41rzILER0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3mTPPiTpIh6nHe3dqnyWxZyCwLcrnjhW3ySg0+ltMpP+/VnSS
	fryo6YFTYPwhHW7IwUo/iByGP+Gv61Smbpi+faV395CfCb2KoWUSH1vt2h/tYLuBC5vRYuGXhJc
	ULqhWHpUrRcmc3fWmceMK+TCT+MfnwDDAlx0P7FW2Kr2Gtkn6NPGbhFU81w==
X-Gm-Gg: ASbGnctS7s4SkxZ190ekxDuSIcrzt1nxsU8L8XRq5d7oiNO6J4I26+upYBmm8xKRD6l
	99T+Pd7dF2tXab+ek2qdQFUigapYhDae/AiLAz/65vUqyhH4OTd9hJe1PmCrB+LVBiGLQX76UMI
	vCj2GOGRTQtorM5jKjE28KKy245k+MvMcfsE0c/d1JKVzIC24z8nLDtfMoH/rojvsyd+CL31Mrt
	mfcXIRzuArE6lfqYWVnrAc6THte61SzeE+kehKgbgJ/RzlCvsrr8BZ3XMem3EE8wN36PcdtyT2M
	b5DkPEYLR2d8++Tta9WHegO1X+6kyKtuSVf2Nr04Uvxx/nvKRiAw1Sq20HsDNDCHc53+oSV5h1z
	Y7tHGBY2UzPO0XouMAg3GYIbYAZGVd6S5teAfmz2baZHXO1I=
X-Received: by 2002:a5d:5d81:0:b0:3a4:edf5:b942 with SMTP id ffacd0b85a97d-3b4966048a9mr1541930f8f.57.1751625740439;
        Fri, 04 Jul 2025 03:42:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGI62JyhkVkZCDi3vTcH6ZUUy5ZMEU30PKZLPD9SUhqXYP1UC5bvM6fEyvquBWJFnSmFvVdtg==
X-Received: by 2002:a5d:5d81:0:b0:3a4:edf5:b942 with SMTP id ffacd0b85a97d-3b4966048a9mr1541903f8f.57.1751625739929;
        Fri, 04 Jul 2025 03:42:19 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2c:5500:988:23f9:faa0:7232? (p200300d82f2c5500098823f9faa07232.dip0.t-ipconnect.de. [2003:d8:2f2c:5500:988:23f9:faa0:7232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47225a755sm2159792f8f.78.2025.07.04.03.42.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 03:42:19 -0700 (PDT)
Message-ID: <44d462b0-b72e-4eb5-a5ae-07319f6a6e80@redhat.com>
Date: Fri, 4 Jul 2025 12:42:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 mm-hotfixes] mm/zsmalloc: do not pass __GFP_MOVABLE if
 CONFIG_COMPACTION=n
To: Harry Yoo <harry.yoo@oracle.com>, akpm@linux-foundation.org,
 Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-mm@kvack.org, stable@vger.kernel.org
References: <20250704103053.6913-1-harry.yoo@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250704103053.6913-1-harry.yoo@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.07.25 12:30, Harry Yoo wrote:
> Commit 48b4800a1c6a ("zsmalloc: page migration support") added support
> for migrating zsmalloc pages using the movable_operations migration
> framework. However, the commit did not take into account that zsmalloc
> supports migration only when CONFIG_COMPACTION is enabled.
> Tracing shows that zsmalloc was still passing the __GFP_MOVABLE flag
> even when compaction is not supported.
> 
> This can result in unmovable pages being allocated from movable page
> blocks (even without stealing page blocks), ZONE_MOVABLE and CMA area.
> 
> Clear the __GFP_MOVABLE flag when !IS_ENABLED(CONFIG_COMPACTION).
> 
> Cc: stable@vger.kernel.org
> Fixes: 48b4800a1c6a ("zsmalloc: page migration support")
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> ---
>   mm/zsmalloc.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 999b513c7fdf..f3e2215f95eb 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -1043,6 +1043,9 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
>   	if (!zspage)
>   		return NULL;
>   
> +	if (!IS_ENABLED(CONFIG_COMPACTION))
> +		gfp &= ~__GFP_MOVABLE;
> +
>   	zspage->magic = ZSPAGE_MAGIC;
>   	zspage->pool = pool;
>   	zspage->class = class->index;

IIUC, the real problem was exposed once zsmalloc allocation users 
started passing __GFP_MOVABLE.

Probably zpool_malloc_support_movable() was used for determining that at 
some point.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


