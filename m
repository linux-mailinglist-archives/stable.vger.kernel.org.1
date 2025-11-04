Return-Path: <stable+bounces-192375-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FFAC31047
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 13:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84A0818843D1
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 12:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68C42BE62E;
	Tue,  4 Nov 2025 12:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0D1kAcx"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EBF86329
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 12:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762259801; cv=none; b=fhgGHawqXcOve3P1kGsJAgrFYMe+4iCTaQGm1QW4rNAJnSJJuhnqtRkW+JNv3yeXtJS1qCYPnIw3m2JqHObAGt7Esy2DwrNSUA1NCUpkUKbJdjdhVEg7FvVfixZIFlzEHxv1zX686v3i6p5wL4ezRHsTp8/HK3ynASF7JmUJL7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762259801; c=relaxed/simple;
	bh=OY6wmS2cjaoU74ByE55r3CESyyslJw59xMwwDbCQcNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ubs4FThnRfn3D4wn3/Jxb2cddKxZabC6LUJGzIMGEcERXzL2fJ0CFCsJrjwVDuqGUKpDWONOOSbIfnmY2a/zTYduoAd9i6o6siRu1ixuxzGfZHudcODzqi02+PL6cH++ntYOZkh4/pTWFxWqJ4WAZcCZAIDYf+TtxMo3sdT9GE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0D1kAcx; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-339d7c403b6so5096760a91.2
        for <stable@vger.kernel.org>; Tue, 04 Nov 2025 04:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762259799; x=1762864599; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YuYa8Vyc5g36zBbzEp6ohHNgPOjM03c64dcRTIxk/XA=;
        b=e0D1kAcxX/U2JrPsU6OZoYyaStafkLiLKMsT4xfwfjtykF5wtNbe3WZJTO3BsLzqY3
         k1FpVVc4jeUoX6wQabLcMaozAJud6YY0SDId2ZIxAi4mxaSlR/7yzYza737NALtoamdM
         AvsVKHu6SxYAS5LDjDB9lCBLmLHVLWCK+83xQ8Sdbv74fdW0vYl96JadzvHRxklYsw7q
         SqcJ7+FcZ+u55vuyZQh0VkmkLqk1wPbyYMUv9kwKOHMSIn8uv5eu/0x4iiSQveQ4W6Nj
         H9aT0tsu8HNI1FL4+12ggVwrzv1N/lEUwb0IAFhtpFyvEIG5ZXDM3zv+3v2lzxA7NgMN
         CF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762259799; x=1762864599;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YuYa8Vyc5g36zBbzEp6ohHNgPOjM03c64dcRTIxk/XA=;
        b=qrIqAcmQwEsrk2o20LS4lG6ytLl7ybD4Nd04/v3ZVRzhVIHsSZA3+sAe8ElbySNEh5
         FB2PDgFCeW3GxTlsVN7pX5qw/Ih7IChFG8+k1OPQTh5mhXuybNj3UbFb6FJxo65KV4/3
         wKXxD/b2nkYnpp8HPUUHyr+gZbClPLmSs+mjXL9OUocHcifgS8tOUFAanAvl3jyVobKp
         zuZBAMleobUixjV2U35g1n/M4RUUpFOP3ltQUdtYah0CRgkxoM4laU3LjwOCmxx5drc9
         /bCLAQUYljTdvzMUgwrFsXCb6Xfyb42gR5+uq7efkqVcwk4dNeXByJptBy+rot/qCPKY
         PzTQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+YiZl2aXMX1MmIZ2Qq5iFY/gTSkcbXcz3L/NtoBKAsXc5sYEW15v7rccjpHzpzVsTeL8wAr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YynxAsBWZz2sjPzk75NHQ1xYaG/BYmUlRkox2hyTtzAwrPGLyaD
	8VweEvqoffSSvEb1+Oe6ENZuXfswFgX4xR1YM/CW9QLbUOn50XeyDOTa
X-Gm-Gg: ASbGncuSNtfj6H8IYP01tWGoT0/VvHXhQ2arnhPNCATZPYxtRTUvib84cTtA4nmgIuJ
	qBucIHYA7MvTJsu9cwENYWwu0uDzYGdxHWmgc9GCHY/ibqIxzM4PusboX7GCNXDoK/Wy72JxaNs
	3uouFQj4ZsuYFRWYJxS0KW8dBrHu8on048Ce1XgTnkvERtFwPP44LfXbhe0kV0cQYRKsNb0bz/g
	z6WgYiW4DwWwXFn7io/Kn1g1BpBYECbaRoBCCfFbBhvTFfIyITH+DuoxrpeNBLGM55Knn9Drc7R
	+0htyrn8LOg6L5hMwAGu1ZMfetS1T/GeUaUZJk9mBTdQGGG3lENlTdYf5MCWuOddmJm50KzYh+X
	u7JxiIeo+V+sr/a3C/qKPkhVG73atqi/4S1w+2b2PatDnWtoqr0BaFOyzhhDb2/lSwazbAj9ohz
	Zv6E5/DgY+PZmdlh4yHrg=
X-Google-Smtp-Source: AGHT+IEqu3D4nCBfCW/PW2rcdwd+c+X0hF9STm+2SPgeMcdKeUwLd7lODO/G7LNmaVev7hTJtyCaaQ==
X-Received: by 2002:a17:90b:3c89:b0:32e:9f1e:4ee4 with SMTP id 98e67ed59e1d1-3408305863fmr23514216a91.17.1762259799323;
        Tue, 04 Nov 2025 04:36:39 -0800 (PST)
Received: from [10.189.138.37] ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341599f14bbsm4565467a91.13.2025.11.04.04.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 04:36:39 -0800 (PST)
Message-ID: <ffc08b98-403c-4d29-abbd-b599c7c5e3d7@gmail.com>
Date: Tue, 4 Nov 2025 20:36:33 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] block: add __must_check attribute to
 sb_min_blocksize()
To: Christoph Hellwig <hch@infradead.org>,
 Yongpeng Yang <yangyongpeng.storage@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo
 <sj1557.seo@samsung.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Jan Kara <jack@suse.cz>, Carlos Maiolino <cem@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 stable@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 "Darrick J . Wong" <djwong@kernel.org>,
 Yongpeng Yang <yangyongpeng@xiaomi.com>
References: <20251103164722.151563-2-yangyongpeng.storage@gmail.com>
 <20251103164722.151563-6-yangyongpeng.storage@gmail.com>
 <aQnd4-RRe4K_b4CA@infradead.org>
Content-Language: en-US
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
In-Reply-To: <aQnd4-RRe4K_b4CA@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/25 19:05, Christoph Hellwig wrote:
>> -extern int sb_min_blocksize(struct super_block *, int);
>> +extern int __must_check sb_min_blocksize(struct super_block *, int);
> 
> Please drop the pointless extern here, and spell out the parameter
> names.
> 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 

Thanks for the review. I'll send v6 and fix it.

Yongpeng,

