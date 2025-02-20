Return-Path: <stable+bounces-118468-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE035A3E02E
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 17:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 437C93B0BC3
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 16:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E2B204698;
	Thu, 20 Feb 2025 16:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b0vAPQ2/"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2934E1CDFA6
	for <stable@vger.kernel.org>; Thu, 20 Feb 2025 16:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740067997; cv=none; b=JWDR8/uFEg1pIlocuC9AHBY/Aqkem0Soaq483KLi+VeODpsA42KZXyTa2Oed5uY9vI+90iDrNqGnqmlWIHNhONOBSwV5VWI0xceSBC1Zk8ZxiGdUDObrqzWzIrkZ6tge6xoRTkpB9Ob8AvS4Yg1LKIXCNc6XGuKGkOn06FdP4GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740067997; c=relaxed/simple;
	bh=ge8tDROtqPFb3OtBLB+xMWyNR3arwxc6s3la74fZId4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KS9dgV5QNkWLsd9DS1YeyNzLnV98SCvYdQ6HxIhh5QY4uotjcZBc1aQyqnwRp+ujAGGY8HNZeDnRCNB45oG4cpuoDjzTAf1aIiyw1DgiAnCdWuFpyIGP35c38zo5GmQEpDY9pm5ZD57ckLwzbiNtL8Hc9hkvUcR15lJsNf/hLw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b0vAPQ2/; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-8559020a76aso30774739f.2
        for <stable@vger.kernel.org>; Thu, 20 Feb 2025 08:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740067993; x=1740672793; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o64MbyeNKxrYo9iiqLxo3YEJFFUOkSLGKF7YrDzWVuU=;
        b=b0vAPQ2/RzxAogh3CjiBH2LkjKWzTD0GoENlrqJHXZ7HrRcxffR7fwOQ9V3czL3i7a
         k9MBwkdgJNxaz8eiPCWXctZrWtAdf5cG+sjVbM4MU0KZNBt4vlVAAaup4mzGU5H18bjE
         JoLjro84wN4xjg7W4wWzC2MtUST4VsIiVPvzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740067993; x=1740672793;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o64MbyeNKxrYo9iiqLxo3YEJFFUOkSLGKF7YrDzWVuU=;
        b=FCavthIVKYQfld1zORA6O88uGBzN8aIw3hd9cyRCvvlP7a5NXUQwzjrOR0uur8gpWx
         CCsZlEisZDRdM2mlWBrCCRIlns82DdPY2csYvOWaSt9oeg/N6mMLf0p3oLylfXg83Bfc
         xTwDI8bcPNTQZ3stRoVhXG7w68hRpFYYxELjCKibSut4+ys5juGLayiEWELaPSnApIFF
         TiMdtuyEqBCkL8cE7WHHNepOug/u8YghpiYGvHcyZZj0Tt5qQGy595j2A6a0HVeuOT+d
         a/94EXvLMWw0pHywPUYTfZIwya9WXbBvmdePC2NyTSl++UF+D7qAzqWBRqxAI8XAcYZD
         d05Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjRepVPNPSSe1+AUgqg1plSHJSUSD+sRTDqnjmWKvbX9JrpCtN/s9zTpHJbXPaNNKEDgKf0gI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBLtGBAqxl8u58BX+MjB1ohGY9hq1WuGsN0/HMLZ8E8HpVp1El
	3Kpu5OsSMUprlizthNIOI+gLsF0FTK+y75ezP4PkTwImtJb8caZvzbdY7x00sR8=
X-Gm-Gg: ASbGncvZvtMD2ljCZOE1jrxXYx9lkiOQnu7K09PNwAO1eCLiPJPDBEGAR27708G+4sW
	0u0ZXYEn97xvvYzi0lcyjyMBH15RyzgijXEM94efPOJpDiIhXcN4H4HfARRe8F5ZpvG4turQgz4
	mxrkXN3IE+BKjP0nPnAQMJ54c5h8epadI0Ce1s/SaoVdnAdwTJt7uRsCSUvsut/Vn1M4YGNBz43
	ioTjguoa8BftKLgCkVxEJlA4GBkKUz2HFpb4+PsBdXu9xNyZUkM9GQkzBR23oelTYQYzO+XY5Wh
	/3a3qivn2mHw5fGbBToJBFKtuA==
X-Google-Smtp-Source: AGHT+IFlFgsDehQjT4J7TYSzBZJFTYe25Dkt/CW5UyAf97Mbw/pAy0RXZVZebdzjiAytc48LSVF+oQ==
X-Received: by 2002:a05:6602:1607:b0:855:d60d:1115 with SMTP id ca18e2360f4ac-855d60d1332mr118178739f.13.1740067993088;
        Thu, 20 Feb 2025 08:13:13 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-855921817b2sm180941739f.17.2025.02.20.08.13.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 08:13:12 -0800 (PST)
Message-ID: <ec8f098b-c157-4ac3-b109-2e7be64d8747@linuxfoundation.org>
Date: Thu, 20 Feb 2025 09:13:11 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.13 000/274] 6.13.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250219082609.533585153@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250219082609.533585153@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/19/25 01:24, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.4 release.
> There are 274 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 21 Feb 2025 08:25:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.13.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

