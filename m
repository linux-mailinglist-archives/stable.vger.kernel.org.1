Return-Path: <stable+bounces-93589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED409CF4B0
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 20:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8541B38441
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 19:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E026B1E1C1F;
	Fri, 15 Nov 2024 18:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Js6NczSv"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3248E38DD8;
	Fri, 15 Nov 2024 18:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731697195; cv=none; b=rzcgWAr0zg16c+2rlZWX6OX5KU0200dCPdqSP28ttrjwXaSKLancO2NvXUkfU2UxGVBT2CZIHsKz4kw4pCFKTNtnWDXJ0v7OYE+dNxjyI/CmlmdVvNhhqQjWqJv94aGoAmEclzPVZr/uB8w4pEvveoGQ06doxAIj1959HnWngnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731697195; c=relaxed/simple;
	bh=KR5oP9tE662kE6uTjO8rCTmgLGM98xX+MI/0w1vBkOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uvTrlvLfLRvbq38QKsRHBeg7vBfPFI0VAtadYl+eXK3DxITsEl4YDmyiTR+AHFb42+jND+DTgvrZdhQNM6vNP58xJA3mPDmSjw3mSK9Av4QdYpR1bl6tCdfa0Kt0l1a/zyXBkLnx5V9HNRY2ZVnPePg9f6BjMBy1oOk6LY13bmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Js6NczSv; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b1434b00a2so135492285a.0;
        Fri, 15 Nov 2024 10:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731697193; x=1732301993; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FPsf/V+2PGpZp6PnhMaBNff/izXWPKZjj6qfEQOXwDU=;
        b=Js6NczSvwbKW5Nh+oGIqopmH0t8JVd7R7KMC8dq2n+flnF1Qke3u4zv+MndiBAk0CC
         Wp8Vy5b/H6Hi98/8ArH54HnEKkybSMW3XyXe/54T4tw24ZFEVz4ZkbjyAIZQYpqY/vXA
         4XIVJIYkRL3cUtKfzJg1XZkY2+b4qVt/XlAGdnpqjmf8j7yci3nhMWTwyKD0T75edmsZ
         mFE0nCOe2FsUojY5kizgHrfl2SxRis2190fD5IDpZeK33prl2iwkk2M3cBBPoub+50v9
         LtoFOYr91VBWqfXf8TdYuhBgwclsqmu7vbUbOhn8xtMqiYweONkbpig1TUzCSzDnR4M1
         NRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731697193; x=1732301993;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPsf/V+2PGpZp6PnhMaBNff/izXWPKZjj6qfEQOXwDU=;
        b=EtxSPajsvutlPW5LG6obmNyDPUxqW6NX7eXgtPaRZFzpJ67kBi1u+HWhsIQZwDLFDp
         pNBVZuzajmMktSP/Fj5EOHy1O/JjAzE3mdtzJ3VIxyl1/ikttVUpB6a7cCBFsEUuGr9a
         ZBss/HmBHsUqzVfWeYz9pPxhNg+gGT8PYFNMKc3DLZNS9EgJo99vFER+MXfJT4POT7PB
         F08LzAC6qhT9CJCOPx+nvGVw95zSaE+4ns5hH07MTM/7Iy6agDy8Cqddi3b+4QhjWcZV
         /uKIZ0KKOtx7HCv4deSv0NjpliovmN5TKUy6cfORrfZdts9b4uS+ocMQGcpw6LEdl2Pu
         W2+g==
X-Forwarded-Encrypted: i=1; AJvYcCWBKyV6cx2MG8RbCizBfvW0vGnkEk9rYcqD3RtKpbsnk/uqsFVpVvb9nCx+keH0PkAphNrxxbft/LxH1DQ=@vger.kernel.org, AJvYcCXR3OrkXnLrGirhT6jcpGJaMzyuyPC45CvyZcX8hQH9taebk7JrzVzu4Je/tlzzuVlzkxNPXTQv@vger.kernel.org
X-Gm-Message-State: AOJu0YzBLf0KqtAq9paVjei/Da1iTzk1XMmAL5Ohy+TRCoOjFj3/52HR
	9aTyve/D3+d+EfaF7mat8YFD/PGvk4A8k+HfSHz8p6OJjX0cGCbx
X-Google-Smtp-Source: AGHT+IG6Ag601z6CPTLNzPq43TOQN/ERKSEGO5xo8OQv22zqvsEbKTLMQC5Yxma5POAHIwP5N/YbEg==
X-Received: by 2002:a05:6214:dce:b0:6d4:12c:c6ce with SMTP id 6a1803df08f44-6d4012ccd49mr32716346d6.42.1731697193008;
        Fri, 15 Nov 2024 10:59:53 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3ee8f3640sm21071066d6.91.2024.11.15.10.59.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 10:59:51 -0800 (PST)
Message-ID: <f74536e3-ab1e-4949-b004-7d9c71b86f43@gmail.com>
Date: Fri, 15 Nov 2024 10:59:48 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/22] 5.15.173-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241115063721.172791419@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
In-Reply-To: <20241115063721.172791419@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/14/24 22:38, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.173 release.
> There are 22 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 17 Nov 2024 06:37:07 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.173-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested with 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

