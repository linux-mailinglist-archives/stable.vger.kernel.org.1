Return-Path: <stable+bounces-111133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F53A21E29
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 14:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E432A188624F
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 13:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C633CA6B;
	Wed, 29 Jan 2025 13:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sairon.cz header.i=@sairon.cz header.b="cehzsnkw"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6061FDD
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 13:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738158607; cv=none; b=CltrSc/ZDX2pIFWASonYJ9q+xH8J67ZAFWGTSmU6LJ9WSqbgU3kUq8J5pLRfsUtuCpSwhHnKedlva/EyF0ohp6PfwC462+nmXbDPKgFqq/H81lrwCBFz+JMVr2K9NlRJZlre6DHYk/FWgIHnODWshAb/a+RjpAKvvpvM5l/6OZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738158607; c=relaxed/simple;
	bh=dBykreLn8k1vK7gxPzsq0gNUUkHEVGmtIIocx/HeIro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UkTrpB2BBMcYdD80hK5pDcRhRGUQ+QWPiZMdOHUmNNXJjPFM9A2kGHrZvxFS41IyoaJGvFacgbA0S3NEySVq3r3zlbVl97qb1CrpgRlBBxXAcVG17JWLvsajD0BgqaRbVet8dOoymOyTBiuGfGfpOswWoeea2zZA/5e6HCN3EOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sairon.cz; spf=pass smtp.mailfrom=sairon.cz; dkim=pass (2048-bit key) header.d=sairon.cz header.i=@sairon.cz header.b=cehzsnkw; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sairon.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sairon.cz
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9e44654ae3so1099666066b.1
        for <stable@vger.kernel.org>; Wed, 29 Jan 2025 05:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sairon.cz; s=google; t=1738158604; x=1738763404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=75Qk36IR/Lj4/0wn0Q30039CDztY8/cW9oi3X8VH8Mo=;
        b=cehzsnkw2X/CfpQB8nRcQCr47vxZvMlu/krQD/45xAQRNDIIOYKeQ7eT8LHKvcOmds
         TcVVERyQgxXyjNgw26tKRY9K3yWWKPIAfshqGlUwgQOeQ+7nu/UUrobWCz9iYZy0UMz7
         iNEAHTJ5ssDmcBcBhWmTOZKuPoIqR6tDNmojRcMM4XwvqZjfl/GEHzdkh4BXmjuoYdQ3
         Urmdox+qdLauv6SE5OBkGQw1/hyI4l0xlsuu5bN2o9jZMyjMs8VHyZSict/UjQdRe7x8
         eyUUtCjv8z7my/OtD68OlA0jMWAWH5fnPDLpLGwQ8kP4Yxx3k4Le98NnsjC6FLKHqOnV
         U3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738158604; x=1738763404;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=75Qk36IR/Lj4/0wn0Q30039CDztY8/cW9oi3X8VH8Mo=;
        b=GUmTsoPyiW/QeB1GmdlR+41lWvhL9SNBIc+GZAIX+oYlgAOQ+/7ELI7f8EoiJ6mygb
         NnzHIxxF6kNhjOv94ZOQWTdpVLdjuRVEGUk9rv/DveXqaJA4otcPBkd7UguxiLYxrXwf
         UBdtL4RF4eBTdlR5gR37JrQDUthZ+aGSk3twweOBsyzXs1TfZ5DCEUXT+TFd4r7DmMti
         oLa8diWxwdhPMhbJdKjT1nyvS/y7jrv5FFLJMoGIS1m6ddvL9z2J97ukU/zVW5pZf3TZ
         Tc8BMPhFJTpA4H6Rh7YiCzcW+WR9fxUQnD/lGqVnVVzU7Ie3JBxFYrLaUtC2zHhagA7R
         BlzQ==
X-Gm-Message-State: AOJu0YzmFvNBqSVtmDOKI3U1Qy5cYEZbaYjVBhv8MP7Uxirbfo54Bk3/
	HycIcqkhIJeOBaI4wuqF453fc3COfzOzdxagl+1qDb0b4WwLNy9lxAMGtfGEn1o=
X-Gm-Gg: ASbGncupRkv5TTbKcf2TY9FNWFA7u23GMKf+aERGfOQw4DFPjwn0cRNb0500Mtv9nR8
	vU6hrUz7PMm2kDGqBzrN/NiLk+W0/qKK7iMXyTvFRmXCwzLPoav6F6TCMShzKpOxA0HUJwgNnCC
	UnK/1ziQ1v7a1svyu2YNj195swFJUv4dcoe561YfcSbFa695YcYAv0hzgBOzByW9XxlhP3Npjgq
	G6JvBwlDTniCXi+KuRogwyJLV6rlYXcm185wcrA9bah2d2Xh/CvLmg/QzpRlUnHoes8i8ZWOvBu
	en1lvTKcnhO+xT3Bjdbidpmchqtk0ruD2hBMTl5K60EMpGSixA==
X-Google-Smtp-Source: AGHT+IF6V6wMn2HQMQcoHVmacevAxcGpFMu1haNotIgNNU36OH5DU9Ha/1LoSQoaqi7BQjhYZAfmvQ==
X-Received: by 2002:a17:907:7dab:b0:aa6:7cf3:c6ef with SMTP id a640c23a62f3a-ab6cfcdf31emr325837266b.15.1738158603380;
        Wed, 29 Jan 2025 05:50:03 -0800 (PST)
Received: from [192.168.127.42] (ip-89-103-66-201.bb.vodafone.cz. [89.103.66.201])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6760ab0bcsm985438766b.95.2025.01.29.05.50.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 05:50:02 -0800 (PST)
Message-ID: <4eb662b7-f15f-40f2-aa10-5a3a5c1fc8a0@sairon.cz>
Date: Wed, 29 Jan 2025 14:50:12 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] USB 3 and PCIe broken on rk356x due to missing phy
 reset
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, FUKAUMI Naoki <naoki@radxa.com>,
 Michael Zimmermann <sigmaepsilon92@gmail.com>,
 Chukun Pan <amadeus@jmu.edu.cn>, Heiko Stuebner <heiko@sntech.de>,
 Vinod Koul <vkoul@kernel.org>, regressions@lists.linux.dev
References: <20241230154211.711515682@linuxfoundation.org>
 <20241230154212.527901746@linuxfoundation.org>
 <91993fed-6398-4362-8c62-87beb9ade32b@sairon.cz>
 <2025012925-stammer-certify-68db@gregkh>
Content-Language: en-US
From: =?UTF-8?B?SmFuIMSMZXJtw6Fr?= <sairon@sairon.cz>
In-Reply-To: <2025012925-stammer-certify-68db@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29. 01. 25 14:36, Greg Kroah-Hartman wrote:
> So where should it be reverted from, 6.6.y and 6.12.y?  Or should a
> different specific commit be backported instead?

I think this is for the others in the CC to call what should be done. 
Heiko said that backporting the DTS changes (the other commit in the 
series) is no-go to guarantee backward device tree compatibility, so if 
this commit should be kept here (and in other branches where it was 
backported to without the compatible device tree), patch like [1] needs 
to be added too. But AFAIK there is no such commit available.

> And this isn't an issue on 6.13, right?

Haven't tested it but it should be alright thanks to 
8b9c12757f919157752646faf3821abf2b7d2a64 present there.

Regards,
Jan

[1] https://lore.kernel.org/all/20250103033016.79544-1-amadeus@jmu.edu.cn/

