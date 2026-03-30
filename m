Return-Path: <stable+bounces-231241-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ON/DMuNymn09gUAu9opvQ
	(envelope-from <stable+bounces-231241-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 16:50:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FB135D2BE
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 16:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 165E0316AA0C
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 14:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFB43033C9;
	Mon, 30 Mar 2026 14:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdAsOAK2"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5748E3002D1
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 14:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774881535; cv=none; b=WIFFTv1iehQDU1duEV9YYsSe8mJMRLj/rjpjI88IsC2DwYata5NkbVfhXFuTCoHXTbAc/+R1FTlmfsvjsXPLu6Sy26rypXPO50vVQi7jVedbD89Ephg8Q8TGTS5le5sllerQ1fzYKYAuYM8eT+5Uonjjc7BnauLFfn2a4/hmBbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774881535; c=relaxed/simple;
	bh=koix8bOEomZhxXXqSljRHzrLE4EdrdQWjNIZqocOroI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=W6hqUz4o99GcWjej7aCr8lnOunIyt/eRAD1AFHlxCFoaVjrel5v6U2B9azZSj0qpF3lOXnHkrQwUNYNj2MhMyXem7SKQUjcU4LdM5Ro76zQBVqfz3N3r01YXQO1T69OoBlx2E8Pw58LgKNS5VgnkwSTS3TNTFvxpGSts9iMTUvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GdAsOAK2; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-486fc49c5c0so7572195e9.1
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 07:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774881532; x=1775486332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ig7fKYjfwkrimY9Uw52BzM2CblH3tO3yAFQK+rKl0qE=;
        b=GdAsOAK2dSnJuDuhV4LG++DtX3frXATlaQQyeutv7A8dl6nj2JxRQa6hbZUdzb3FZG
         GXXKWJgNlepXtKHDHm4OLCmmJXBeRLfgRUMZAy9oMNSI2z/k7V1oFhNsgz6IKklnKu87
         UwrqmV85K/X3A61EG/Zd1BYUO6MPxetMKvXpJvaCb/3o9hIdufndBQIG5itR39wzd6Te
         u0fAAe35szsotJEvLyZPVvctl9HMzH36OhaKpWvgDMZI39HcV03thKq64HwQT12ei5FZ
         ehzQD2Pe/9w6oemGGNhbhd52+eZanCLqYv9TvGE3yFLZh2t57ia7lm2gQKHzoCCkexQl
         B/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774881532; x=1775486332;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ig7fKYjfwkrimY9Uw52BzM2CblH3tO3yAFQK+rKl0qE=;
        b=bmauNNke8E1cFrZgipHI07wsjriLGGbPY4TbjDFSgsjm3xZSCTR5Cqa6oQ+h6Z98EU
         SWO2RmozQbZrH01+GBfZjYoFSs6n8JjtCubUOCZNKPl7x+rs36EmSPfPtT8B5jB4crWF
         LqXTWJdRFeTdYbEsU6uBehsjlG864oXjW72KIZhjMNPR/py3PsefDe+R6xjs9Ln4ybc1
         IULPcm3ERZyTEPU7ZRo1ug3LR2LaMjoP6Mp3+N0dJjqi8VXSyRehZErhM4KFX1GEKwjK
         U/otn7ftxwNma6LYHXBJhMJf4r3KL5VOIrw7BPj0/X31ymEJwYGf7jb80ZLU9aebzgGB
         wB9g==
X-Gm-Message-State: AOJu0Yyj1ohAOa/3NXOhNJmi6sbkhM8s8SI2KJrrdbDvqIBoXf8dvNDs
	XdUqRnEio8Jj2l6+0FoaTZgtJrsq2KiEwlmQKwV/CXa6yKjhHsGFF9tg
X-Gm-Gg: ATEYQzx+qqOImQUIt7GhhdyuzpkyqiqQ8GY5YKUx6G2SvW+/LbgQr5dkQWcQ7QvZg/l
	CV/ha0g7vj9rCuG862fW2Decu87jeZmTyLOHAaWopJFphlf+p/FB9a0Wy/6fcUQCbJ34qhEvYbm
	GU+/7tsowIyjycjaIzK6dHmnGfjbSoZaDzc7Ktrzyow3lju8EYjniFVNd+6/H96YNVt+BBvccYp
	8XXmoJKoMvkJo9Q9AVR2jA0znsX09xtVepTxMcXvPQSjev6YsFxJwj7ps9mM0aUkufgwdizZM7l
	wG63OcpI/r4N1mSurs0o1LhSt4jT+dECJjEp/YKwyGFJJhFcPLgHS24n55v5HGYIp7OgknJ26fO
	+/r2JL+fOr/uCORo6UxiG1DVrWxtLOcMndsEsALUwXRIXVgd/I3Niu7KFSSB4D8LDjVFQ23GcJ8
	ZCKFjUD7U6BmSoz6fCJt52onFN74EAfH7zBXbjyc34lBTvikdoLHLn4qe4M99xy5VcFg==
X-Received: by 2002:a05:600c:4f84:b0:486:fcf9:5ba with SMTP id 5b1f17b1804b1-48727f774b5mr127792725e9.7.1774881531411;
        Mon, 30 Mar 2026 07:38:51 -0700 (PDT)
Received: from [128.93.82.131] (wifi-pro-82-131.paris.inria.fr. [128.93.82.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4873bbcac33sm85585965e9.15.2026.03.30.07.38.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 07:38:51 -0700 (PDT)
Message-ID: <6c016af0-718c-4986-b707-c4ce74b72739@gmail.com>
Date: Mon, 30 Mar 2026 16:38:50 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thomas Fourier <fourier.thomas@gmail.com>
Subject: Re: [PATCH] crypto: eip93 - Fix dma_unmap_single() direction in
 eip93_hash_handle_result()
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: stable@vger.kernel.org, Antoine Tenart <atenart@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Richard van Schagen <vschagen@icloud.com>, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260330091817.25797-2-fourier.thomas@gmail.com>
 <69ca4458.050a0220.3569e7.2980@mx.google.com>
Content-Language: en-US, fr
In-Reply-To: <69ca4458.050a0220.3569e7.2980@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231241-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gondor.apana.org.au,davemloft.net,icloud.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fourierthomas@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B2FB135D2BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 30/03/2026 11:37, Christian Marangi wrote:
> On Mon, Mar 30, 2026 at 11:18:14AM +0200, Thomas Fourier wrote:
> 
> Hi,
> 
> was this tested with the crypto self test?
This was only compile tested. The change is based on the documentation which 
states that dma_map_single() and dma_unmap_single() should take all the same 
parameters. From what I understand, it could cause issues with bounce buffers 
and IOMMU permission if it is activated.
>
> I need to check the code again but in theory with handle result, we should
> get the data from device in sa_state and cache should be invalidated. If we
> want to use matching maybe we should change to BIDIRECTIONAL?
Yes, sa_state is set before the mapping for the device and read after the 
unmapping so I think the BIDIRECTIONAL tag is required.

Should I split the changes between eip93-common.c which seem good regarding that 
as is, and eip93-hash.c and change the direction to BIDIRECTIONNAL?
> 
> The mismatched flag was to invalidate relevant cache on tramissing to device and
> then invalidate relevant cache when reading it.
> 
>> ---
>>   drivers/crypto/inside-secure/eip93/eip93-common.c | 4 ++--
>>   drivers/crypto/inside-secure/eip93/eip93-hash.c   | 2 +-
>>   2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/crypto/inside-secure/eip93/eip93-common.c b/drivers/crypto/inside-secure/eip93/eip93-common.c
>> index f4ad6beff15e..75659a45ea5a 100644
>> --- a/drivers/crypto/inside-secure/eip93/eip93-common.c
>> +++ b/drivers/crypto/inside-secure/eip93/eip93-common.c
>> @@ -687,12 +687,12 @@ void eip93_handle_result(struct eip93_device *eip93, struct eip93_cipher_reqctx
>>   	if (rctx->sa_state_ctr)
>>   		dma_unmap_single(eip93->dev, rctx->sa_state_ctr_base,
>>   				 sizeof(*rctx->sa_state_ctr),
>> -				 DMA_FROM_DEVICE);
>> +				 DMA_TO_DEVICE);
>>   
>>   	if (rctx->sa_state)
>>   		dma_unmap_single(eip93->dev, rctx->sa_state_base,
>>   				 sizeof(*rctx->sa_state),
>> -				 DMA_FROM_DEVICE);
>> +				 DMA_TO_DEVICE);
>>   
>>   	if (!IS_ECB(rctx->flags))
>>   		memcpy(reqiv, rctx->sa_state->state_iv, rctx->ivsize);
>> diff --git a/drivers/crypto/inside-secure/eip93/eip93-hash.c b/drivers/crypto/inside-secure/eip93/eip93-hash.c
>> index 2705855475b2..19a41a0db667 100644
>> --- a/drivers/crypto/inside-secure/eip93/eip93-hash.c
>> +++ b/drivers/crypto/inside-secure/eip93/eip93-hash.c
>> @@ -67,7 +67,7 @@ void eip93_hash_handle_result(struct crypto_async_request *async, int err)
>>   	int i;
>>   
>>   	dma_unmap_single(eip93->dev, rctx->sa_state_base,
>> -			 sizeof(*sa_state), DMA_FROM_DEVICE);
>> +			 sizeof(*sa_state), DMA_TO_DEVICE);
>>   
>>   	/*
>>   	 * With partial_hash assume SHA256_DIGEST_SIZE buffer is passed.
>> -- 
>> 2.43.0
>>
> 


