Return-Path: <stable+bounces-194516-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C58C4F5A5
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 19:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01BBA18C2B30
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 18:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFBE3A5E98;
	Tue, 11 Nov 2025 18:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aPnq99cS"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABA1377EB2
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 18:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762884016; cv=none; b=DlifWlvtb8BffoRqrU/ZXHURI4v5MBGXHDyDf8ZZtAgPN36hY+mHby8lhqWY21kziW99rpmrNi442y09bdzZCxhXZ/2koIk5Lp4h3Gb1cdde+P5gy3DDs7ockuF7JIqEBhJ3n13MQBXou4SxFDGWvQDFaJw3q61tUGxjj+T4hyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762884016; c=relaxed/simple;
	bh=8BGgfEn97snW7daOKRguJgMVYYh52RpW/KfSxw5SYYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SQDQYHjffxDT88e79LBVUfkZXwBTvK6r+nWCMBOG2Iwec8WX05yOzWtukEgUt0ooPDg4K1ATIjhQDzqPfa8Bh5vS0aGN9x8HI4kR2cKpS9PqNASor5AIv4y+2L0sclykRLqs41nYAwNbbevW/DhU48lsISNQU1rKz0zDHOEcvoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aPnq99cS; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-43377ee4825so19562745ab.2
        for <stable@vger.kernel.org>; Tue, 11 Nov 2025 10:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1762884013; x=1763488813; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zu4EHUDGvoxogQX+S3l1H2cM4F4fAMlTZfbToOtiANE=;
        b=aPnq99cSbrBKvJqc5odQzBgFGD+dhmjpJszk0EuKoTB1SITcDBRURFpwmNJd8fkekm
         EGSwwpPoagIxhUNWFrum2VfBYXI9t8MYJ1YQbSF7NM2wQrPx5OUbYGUgFlh3d20nDDQ/
         h+js+9Y/pMqU7JrPrYYVQ3sIDWsMMtTRzkHW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762884013; x=1763488813;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zu4EHUDGvoxogQX+S3l1H2cM4F4fAMlTZfbToOtiANE=;
        b=Cmtm+J7ccvgVDh65Z28/4KcvqxVfDcVtQ/4slw2M936OEHe/8za5mBVCWc5B+bPErg
         E0fRfHhwYAn9TK3S2dBH7Gn2bICEedTfTYq+Eb7aivO8tTmD3e9tbCFDULF3M9RvOUps
         9pHziVAhi1danBPsdWhV6JaY8nsbXyX2Ph+eD5Gf5Cb2R9avmW2UDtM63+6d4+FcXuFm
         11siO741UPxwVgQQMQt2/iLsQrtoHcbFj0Pku0geA0K+N+lao7RfLzflivNZLpWAOjrj
         GLDD95VeaBxA9c7J3hyTT+KguLL2XJJXYhIAa07MNXsH5Tl9+tQnphGwjj6q+wmUrBa9
         Ngmg==
X-Forwarded-Encrypted: i=1; AJvYcCVkSaOJPey7gQgPbsBnru6RvRo5h5hRGVbUGANKOvTfmrdlZrzf2DeXP6i+OgAiEEvowquqhZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP8Hod9q/l15qkTypdxfVCwTWnpGz/wnPFgkBUlskJFkDBBnRr
	dW0GoS4ECSCkkl6xgfUzhYlSGGz1NRxVpVNrcuP0045zGiSNvDbsT+RlxUrniSKz1yU=
X-Gm-Gg: ASbGnctPtTsnFE+XkvCKhiOXNwzzZvQzZa7MBgE9+HjMO9YL5+bWoOm3hO31v+Q1zZE
	AyX/xOrpawYExTU47XUIWxgSyzUn7bG5xh4JcmClDyXuqQdRIAEpDOs8JJmzsbYBTApza1u3r9x
	CQppd3d/yo1tzu2VHGrELW5Hy00njp9Tb+qkhyZBkeINgTN8LLUPr78Mw7UOjyNAD20/En1bfZO
	133WZ6ynsK/v1zs46irxf3YZFA9a06RY1J+dmt9B22uAfzilt+Ohui89Ww+6dMAuUFNt2321bJ5
	1Gt5OyqupJge3hzXUhqG7/iH9yXYvGj+/ZpvWDnf6r03bkHuBfKhCEyuCfZl6VcctesFUaqE7IO
	qP0FBqc0pbLeOm3K0OrviKm9MBbZuZHGtWAUVHfMf+lT7DnxDHbEeAJBny6luhzr4/xyiLxmWVQ
	IS4vv0CK4jzk31
X-Google-Smtp-Source: AGHT+IEQMr3Vpgo000GhycQVvJrz9u/ak9auHMJZ5/xjFusfwrcdqUjlULnvSbDKynTKwDNhnUux7Q==
X-Received: by 2002:a05:6e02:1fc3:b0:431:d7da:ee29 with SMTP id e9e14a558f8ab-43367e79e87mr145738845ab.28.1762884012698;
        Tue, 11 Nov 2025 10:00:12 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7ab11690fsm116564173.47.2025.11.11.10.00.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 10:00:12 -0800 (PST)
Message-ID: <641427c7-0069-4bee-8e6a-53347654a926@linuxfoundation.org>
Date: Tue, 11 Nov 2025 11:00:11 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/565] 6.12.58-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251111004526.816196597@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251111004526.816196597@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/10/25 17:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.58 release.
> There are 565 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 13 Nov 2025 00:43:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.58-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

I am seeing a build failure on my system - the following
commit could be the reason.

> 
> Heiner Kallweit <hkallweit1@gmail.com>
>      net: phy: fix phy_disable_eee
> 
drivers/net/phy/phy_device.c: In function ‘phy_disable_eee’:
drivers/net/phy/phy_device.c:3061:29: error: passing argument 1 of ‘linkmode_fill’ makes pointer from integer without a cast [-Wint-conversion]
  3061 |         linkmode_fill(phydev->eee_broken_modes);
       |                       ~~~~~~^~~~~~~~~~~~~~~~~~
       |                             |
       |                             u32 {aka unsigned int}

I will go build it without this and update you.

thanks,
-- Shuah


