Return-Path: <stable+bounces-119425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2308DA430F6
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 00:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2E2918897CC
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 23:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE95C20C031;
	Mon, 24 Feb 2025 23:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SX8pR22G"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861E120764E
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 23:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740440050; cv=none; b=ScO9Ym3ed1H3vQEoV4YEf3LxsqdpQjPPQw0MMv24G0HMAHxD3mMT0r2TZdZ69i/uwSeluo2H0L260fmzYRVXi5U4TKiAZNwyInPMLkY7X+cliWMHecxccfvzbqgcYLijo6a+YgJOysX+GZbenQ5msW8Q2RvL3y2YZOowxhxpf84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740440050; c=relaxed/simple;
	bh=scb6E/iGLRkq80b8k6U/vzSP1FLlrDnpwz0XioeQPfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T2T3EOFlaHpWXyn2UmKAV6K1gMYG2gOe+GNUdZKtwzgwX5+KzzPl9rgtsgPgTYQKmed46IrohBOf1FvURrDPCcuKS5qH42QixqkjCRh3YU2UDkS1/3Rk+noDJUuO05I+Y9WnE3spsw4vdUBt/KARCaVpvF1Qd278W03tw3kNfrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SX8pR22G; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3d191bfeafbso17074225ab.0
        for <stable@vger.kernel.org>; Mon, 24 Feb 2025 15:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740440046; x=1741044846; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2KjhyzijhKip7FfXadwTT9xIm71M/ulVqGAx55Z5jtQ=;
        b=SX8pR22Gj3TXJYmXXCqsCnPFVWWewdXH4TswIyDJfLmoIvbenQb/FJsnKfnnyJzfXW
         utHKS3ze0RCsnbQp4oJ8O1smiEM+hfz9KzjtAGedGp9PVNmKDisl/rNZyeqg1VX14Z5L
         Om+SPYM6xgJWzlV5fMdhFg6HDUwO9x5n/hIpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740440046; x=1741044846;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2KjhyzijhKip7FfXadwTT9xIm71M/ulVqGAx55Z5jtQ=;
        b=IKKW8X0fXbMgJ6FcSlsr6GI+cA+Czs6hbIxPzjWoHRLo3bcUBwrAwcXdNnRcOIkbJy
         tF+XW7Uud6SwTL4PLDTTSvEQhRrhz00KDBHygzBoiaM5pYRmfWTszFXruxcCs55s9tUN
         ZN2fFB6Ay+te0pug6/R+hH7kYqLkqMw8kbe8Yp3gUBcMNj14REaGWDK13+8jfSXdCY9l
         7cEUx3jATjMjleNZha2CSSTJMgsmO87u3DjP8XU/ftxiBwR+5X2nNqrAyT8t5v0sApir
         lTc/tOxDwOaY1JpX76P8iwtFoHBOBKf05r0E6f2mSHjBJWAfZ+mL5S+Ph5fFNz8j30d5
         zggw==
X-Forwarded-Encrypted: i=1; AJvYcCWzhpBa5rSD8ytnUV+7wzVSm5Ao5AbWgIhXt/oV+JhragsKagvhcs5LnwdUuZA80HZjNVinf3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YydpnoIcuo1UXW884oeaf+/5gFJA18B5brIW50XzkCEh8nI/EgI
	9RL3IsnnyPh0FAdnz1mNOIheI+HG/Qx3koerBSD3WH3l7BUnKT+lT9ZJKpAFWso=
X-Gm-Gg: ASbGnct2UgzS1JKLxnzgZLtHB0MMvjikVy82Mkg9eIrl6oof7xqo2yh3s4kyrXDc5k5
	CsqzMOx01vlkAlihQ+MoGCbLsLwusdwDVaKRNzq5ZyxohGHb6otf3xcOyhr8Cy/JO/RvNfubUBF
	+Mmhs9bryHrCHsN/YC7AAxgd/YbZra+5QgeOwt8b6mYc67lBBWb0ezkG+hhhMxflH2NhuN2FpUb
	G+3StaNbBCD7AcG1WaHyMV+crkEITbczQef6gzfsPx6VMDmzUvi5mNcUPq2cSx0x0BR5Ssi9Kuu
	OjMej3zfnp2empQUXp9Ar56QNAX1W5+M+KOd
X-Google-Smtp-Source: AGHT+IGYWotOFGyKz9ftjHFF2iZ8yrfovvsX1YqrefW9illRRiARYFLhIqcWOCsOIn5Zr2EynOZ3XQ==
X-Received: by 2002:a05:6e02:16cf:b0:3d2:bac3:b45f with SMTP id e9e14a558f8ab-3d2fc0d9638mr14385945ab.4.1740440046590;
        Mon, 24 Feb 2025 15:34:06 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f04744ba1bsm131759173.25.2025.02.24.15.34.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 15:34:06 -0800 (PST)
Message-ID: <8685f243-b3d1-4ce2-bba3-8e9cd8a47caa@linuxfoundation.org>
Date: Mon, 24 Feb 2025 16:34:05 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/140] 6.6.80-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250224142602.998423469@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250224142602.998423469@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/24/25 07:33, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.80 release.
> There are 140 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 26 Feb 2025 14:25:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.80-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

