Return-Path: <stable+bounces-209968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EC5D290F7
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 23:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E9A13029C5D
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 22:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF7B32ED5C;
	Thu, 15 Jan 2026 22:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JoI8apCC"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57B932C92B
	for <stable@vger.kernel.org>; Thu, 15 Jan 2026 22:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768516828; cv=none; b=FH2Zx6fmgFevGiSZSAyie2sjMeoJcm98J6tCuCQLZPilnD26iE8QUfmHMO18F+oS5eA5TL48M80Gc9XauVebS7MtPKHS0z7f7jhgk+UgiS0nX4aDjH+EF9cC7O/ERDCWaRul4t+/qsRR3U9UNkg3Cur62eYT6uVN7UW3SBkGgLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768516828; c=relaxed/simple;
	bh=HMNbA5LmXmY7WPBtXg5bBxhtTEiQsyJQyW1+KaxbvYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B3PCqxVGTd2+KXJl3GRYdAHJUzwnIQcluSaHCCLNr3EQsfm2EW8GKQ+DnZbNHgbOfUiUWQAG6OITFYcnc/L0+vykvS/KM3PBeJmR0WUjKX7uYbVvKQlTRsjML9LAUHRYWmLKF3UFAi88HiO/DQDfo+NCEUiTgBBvBZv0qXPRq6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JoI8apCC; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-40423f8c5faso966779fac.0
        for <stable@vger.kernel.org>; Thu, 15 Jan 2026 14:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1768516825; x=1769121625; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=svh+3n6w4xdcsiONDBlL2rmEv+7D9XR3KOYEj4trX4w=;
        b=JoI8apCCPa1DqZ+oyDXaCOtZjqXsP/soOqGcAOalr7S/RaoRv6THvp/nd93/fNRG5j
         +gXSe7z0aiS6LbUN1Q1zofH/86mC67ZaAv2lAqSQSYq40qXhRVwOnLddqHg91PrmtPDt
         uc6d/+H3lxG/aE0IIwhtlLNqIlT9SZfmNSUUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768516825; x=1769121625;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=svh+3n6w4xdcsiONDBlL2rmEv+7D9XR3KOYEj4trX4w=;
        b=jcrfLdF2FbmPfP6VVzwvuLDmj3TE3du0Ouj9z+uNgYFHgQVekMO/zFSt1mNVbtevuk
         uqohLo6rMhElqkITD1dnqFCF3fME5CefgSKJD2qyZQpoRnOvmyzFf7GZYAgjvkQ5L2Bf
         wnijdxU5sCY8zBpyQnSQ746e1qK+1pjfyeaHuLr3xwYn2trYlenqLb1n6BIHMzxbtZuV
         79PRr4Sx7b9ILtMtCT1hSd/DgWL/d7emUTOKKuqvWa6n9TcoZ6QrKb/a8T0AnrJo9kAX
         ReaB/ocbYmzbV1iVGWi2w1rd9+KmAORHqhdZ9ZGismkFyYOECak3u6f33A7fmaE/Pli/
         UsVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVu1AJdT3YwfeD420PANUqH5XhU4AZaGEM3mfgrE/3p4VY0YVLoD0xR9l1xX7M0IdBpj1n4cLI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygb9LChIj9HWN0+UUrpzmDAjjqbczAdHRiUKigqzeQEriWRgFH
	J/+AFhGT74tS9/ZAV6aVJC2k5xfTe+ValEZAiUpuVUsUJ9nC6F0hVcZq88b2M/trIClTS82/eQp
	BsIiL
X-Gm-Gg: AY/fxX4nYBw3oUu11axt71ndZwWuwCtoBg0DxPyJqLFref+5zt4a2n0iNyyUBhyoEKT
	aqjFOjVVSWUoj09HwA4HEmuPj5OVvjUo5gP/tzAc/0G3erO7acHnIuUjs/z9pafCT6FF0d9O35S
	ndg1XP5PlxfjEZZe/FHD+Hbw0qppXFZZPOAiBxkXh894Ei5faaj7+8ZT1RBkTCkD6BSOf6wu8B1
	izWOoPrGZK3j5A4Ulv/5ff5ADsf1ufrHVoDarFOjJRIQ1Xw0xoXpznekq8y0EJ2X92YNDpK9856
	/qps2qJ019s7ZJjCIXrjtcUIkR/VSHvNC54mth5bE1k9aExfWyPBxcJLzQ7YYJtVpHxG8TqU1va
	NeKtjdwEO618wjm0vXHjr7uv6x+Gyea6j8iQ/QQ6zm0RQbXTB3jYreAbQtWlLw9UCP5lhIzgK1D
	LWTJ4XS6otU3xrw7xUQJQwN8E=
X-Received: by 2002:a05:6808:1a0e:b0:44f:8f02:cf5e with SMTP id 5614622812f47-45c9bf58363mr555672b6e.18.1768516825585;
        Thu, 15 Jan 2026 14:40:25 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45c9dffa9f4sm371115b6e.10.2026.01.15.14.40.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 14:40:25 -0800 (PST)
Message-ID: <b3f9430f-4226-4fc2-8825-8618b8caeec2@linuxfoundation.org>
Date: Thu, 15 Jan 2026 15:40:23 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/181] 6.18.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260115164202.305475649@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260115164202.305475649@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/15/26 09:45, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.6 release.
> There are 181 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 17 Jan 2026 16:41:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
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

