Return-Path: <stable+bounces-107919-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DCCA04D52
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 00:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BC1018844EC
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 23:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF28E1AAE2E;
	Tue,  7 Jan 2025 23:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gKU6SNoD"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DFC192598
	for <stable@vger.kernel.org>; Tue,  7 Jan 2025 23:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736291823; cv=none; b=I8v0AcBmGmTCwJKofMULLWjxxbHsoU/jbx355HS/6e6RKV8xJgLOEvkmx40RftN21D9vL2HnpgcxgcTdvSbpueIS0plJZZ8/p2YGAx37kHo1rNSDcb9ji4nWRyAACB3u6H/KxTj5P6IrN9GyfqrbsCc03PnL0T3B3OvioD6EeTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736291823; c=relaxed/simple;
	bh=d1Wf7HmzmZETrl4P5LdvbflK1KjFt7WH0v0l8Sg5MLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hc/LtJ0eLLlEyf9l04naCGXVzpl0iLtzClZKKARUGVT0JE+hsfJYbkhFhzaGm6Ayaxy4FQSa0QBkKWhI/GpfLV96ZxwSAmu/7w/MFP4JhLf4Ygv7AY2WNc05nE7/gmqb13ojbiHNb9fa6jkEk2XmFIAmpF7MkYHODO9i2g8hy24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gKU6SNoD; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-844e6d1283aso11200239f.1
        for <stable@vger.kernel.org>; Tue, 07 Jan 2025 15:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1736291821; x=1736896621; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mKvnqOoKREb9v40G02PEhw0Z/x0mrRRo+ZyEtkk9LsY=;
        b=gKU6SNoDDB1lgg80bYsjeqNN0puN5XpgSKjzO1p2TTvrIF6nxFJZMHQUHXIb+oA/cS
         84YiBySFa12fex3Yput+K/Tlotj2EXMiac4Ln1BHYUKtz/ZNN7flDrf0d/NJ52k5DJyl
         hFUCwLoljvsfoAfZCiMu/OMaBcVtYq3+ZiA0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736291821; x=1736896621;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mKvnqOoKREb9v40G02PEhw0Z/x0mrRRo+ZyEtkk9LsY=;
        b=rUD1lqd2cVSE2aX2SE5grm/1QdeAg9JT1wFyGoIPr22+BQwIox9xVhWGLkxR/OVekF
         sRgN1yTHnH+sK8+KbVKRjBh23UP1Fm0jIqc0th67c7YhCD7WW8Coklg//wxOyOrI2sD4
         vqUJMkWNHMxhJgn6fQxeEUV8umP3DcYk4n/8WnqkbSlkXxf4OD9czPI49YzhFD1Klf0C
         T0KGPLbhUQbmJXTRhGgcUovGajsuC63o4nMkMZg3+J4mk7WFkb8jnt/QVjzOLwetGzbv
         9bPrFmVsP1hDLWsxNUlZ5rfTfZf01jYsHB+0bmasAEikEzV9SjzrHSFgRLSm7iytDEbV
         OxXg==
X-Forwarded-Encrypted: i=1; AJvYcCWU39Jy/N7UTMDHmEbNlfjE6mnbgtgkTU0ES20Yt21iHI5Plla978Uwgse7rCL9Qr+KD+m4VlI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjdqg33phqdaWLmyXZIF3oGWzmlXAnQ9r8sY3rz/LF1JqjJHsM
	adRZn1fWeC7bAyIabGhukR8SnYBqaW4kRwnVrG6pNwf3xW+wGGfjwpyuvfr747o=
X-Gm-Gg: ASbGncsilPJf7m5OtbFwa9GgcwCVEDx7bhOYN+xFZBPJS80mlmneicjdkjOxD4iUBDi
	lb1XB+j+S5Knle2/JW2887r8XKjfGezCo0NIZDIwADWRCpocAQOyQQbTFHn1UgkKvRlBOWmwiKH
	YFn0H7pafqmDAu1hQLM5btFO6xKAHp3YYObBCdqgszu52My5snzR+tq8rP7Tk2qXCLGRMYr6fda
	+XStf24FEBx5942Cif4xDhwyRnrsZmBWdWW4VAl27JwomSh1vIf8OdvZD6qnKb6xiPt
X-Google-Smtp-Source: AGHT+IFjmbOFdzhWqE3/ofO2w/Dp/RPz2F3LP5aRucRpn/nz5bX6qFNn5WWbBrCkNDGpQEboNnwUbw==
X-Received: by 2002:a05:6602:4145:b0:841:8345:5eed with SMTP id ca18e2360f4ac-84cdf5ef66dmr83645939f.0.1736291821241;
        Tue, 07 Jan 2025 15:17:01 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8498d8aae0esm940816139f.33.2025.01.07.15.17.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 15:17:00 -0800 (PST)
Message-ID: <8bcd6f6d-5627-4f3d-a749-5cb84381ae62@linuxfoundation.org>
Date: Tue, 7 Jan 2025 16:16:59 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/93] 5.4.289-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250106151128.686130933@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250106151128.686130933@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/6/25 08:16, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.289 release.
> There are 93 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Jan 2025 15:11:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.289-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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

