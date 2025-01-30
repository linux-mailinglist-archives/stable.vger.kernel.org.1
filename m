Return-Path: <stable+bounces-111753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEE6A2370F
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 23:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAA7E1887CB6
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 22:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCD41F1312;
	Thu, 30 Jan 2025 22:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W592Nsvp"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ED82F30;
	Thu, 30 Jan 2025 22:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738274782; cv=none; b=X+0BuKP7CdK6GaCIqBu8AHlCEjdt/3JRmUIZVoZnFlrcssNHRM1h+nmhREWZHMZY8TcyHMVegRoESfTllDRVU7qH99czjbJGX7myDn5IWdvMjNbOUZGHnEgp210Y40eofsF5ekrHqXQxxFKpJicXMOBtOiTCTgyLAHNi+EY+oeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738274782; c=relaxed/simple;
	bh=5lEC08sQ45BWRKvBeSxhzF5Asn+GGYKoB7BnCyLSFIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R/NCtvDkBEzBcPYKggXImMrlSztNZPj0DmwKti5VQIlvF0YlzRPaCygQpLY6S1uWNLd1pSSNxESszeukDTQcsXfvjyeEaOSG4KRtEPPwfdyPlfhoZ9hUubxrTgFFYTBSOr579Nr+goM+VLwzOC9Mffv2JtYGLJ900bc+j+U4s7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W592Nsvp; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2f43d17b0e3so2312095a91.0;
        Thu, 30 Jan 2025 14:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738274780; x=1738879580; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=h+KGY4xkvjExborrXb6BKz+ldoEdbJd47bX8fucEoLw=;
        b=W592NsvpWbLaPAFlQTRgPJZXG4z0xkhqxDhjJtwP0wPjuVm6u6tQoZFQ4SXm9HbekQ
         QPK1XhlJtRS5tk9HqMHaBZnsm2gXStOf9DxHbw7Im0Fl0zHPgh4aaFfDg4X+G7zX8fI2
         qYodmTVQiU0rXC9qU/7HM/Kqv717AwiwnHf6IWqc2eOBshlUeZjqCHIlp52fLDXnMR3J
         bl7ayfs/EYcpiI7CbsvRYYpCDmg02J9inKUfx9lDm2I9vRHNUygT7UEnidtIejgtp4bm
         LgB2J0DrNTocQ1EXW+3VqeuUmC9J2QwrrbbpExfLX/gxsFHeJdZbYnl9o/DDQKzkepex
         8Dbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738274780; x=1738879580;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+KGY4xkvjExborrXb6BKz+ldoEdbJd47bX8fucEoLw=;
        b=mEh9y5gI04ZvcSFAZEqhL9QZDKba4arwkxQtRZdRNnuJyaNf/dsmTelI9tYqZ5LMJO
         4UO5NmFvaJQFTgkJ/LxgjeYOD87LgpqUIj0hTtrTflppBjqeNvU6G8GP4RS3rT5sQ7qT
         B0m/Poem/aVZIrLTLMP6RtLk+CF3KWnDzmCgFbA16/klEu+RmiFn1lqmyPKLV6UUiQ3I
         wuwm49aDC8QiYnSb0oi7tBPk+i0yHDB9ZBq+E516/xpbVJyljubG1n7H2pvu55N00LIJ
         Yiqb3fhKDX7A7IYcgm+Mw87yfiaoroG27hjN6TUOcNC7kfFPSc/JtnvFlACXd3ppg33c
         4mbQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7sUWGc/mLvEOgsoBYOAJo83GjkXJ8VwyiqeIkQ4pGqYr/VI2qUeXMwm+QxSbqJD3FeEOk5lX2@vger.kernel.org, AJvYcCWk/GcNe0dLZLbgbf5M4VvOJER49JKogGYUDhULT9EGcLhJG6Q6jtfuhPRM91/R8oveLnb2kh6tj4MyRPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI4Zz2h5I9MeXsbGrt/y4rwaMhOWFK6IfOAoZhGyJ6BR9XlDoj
	SjPwbcsW2J86xQHf8sAldXZ7qM3TWA6YXzJlzDIOMQA92UNqWB7z
X-Gm-Gg: ASbGncuGNg0RFQTAG1L1Cu0SCXEl1opQkciYv6lU6L8/Mu/dikHnFoJRCZqSzMAkvAh
	/Ondj7B7jB9BEhs6ZPiBYJjCavNGCH+wGngKF/bhnfZSKaodCBBwsAcp/nwTHRaWjKFMLTgGc4Y
	oTweAuj9e+49asbYlPRrIq4t2f0+FDHvqxrjIpPPql+C5nP8/+oDJ3gDClfUipu5TdEDeVwxbTN
	Qo6t3c8sY2UYcB18pfGtmjTSXnTqFwCDDWLYvs/SrOosMDz3QBMFqFH+H5p/nK+V3v0k0C5H/Bn
	NtHHX7x9qPibjKoQI2XxwUUgqyIShrsnT/YaHEIVnps=
X-Google-Smtp-Source: AGHT+IHfBEjg++wRUJoKnQ1aYa+pX53QXbQxObY6l+yadiqvDfPrRgMU+ak1UJ3HUfHlhF+Y5c129A==
X-Received: by 2002:a17:90b:37c3:b0:2ee:8ea0:6b9c with SMTP id 98e67ed59e1d1-2f83abda22dmr14722035a91.12.1738274779720;
        Thu, 30 Jan 2025 14:06:19 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f8489d3db2sm2239038a91.26.2025.01.30.14.06.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 14:06:19 -0800 (PST)
Message-ID: <0fe1555d-855d-4fab-970f-69bd7119946d@gmail.com>
Date: Thu, 30 Jan 2025 14:06:17 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.13 00/25] 6.13.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250130133456.914329400@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
In-Reply-To: <20250130133456.914329400@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/30/25 05:58, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.1 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 01 Feb 2025 13:34:42 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.13.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

cpupower does not build on 6.13 because this fix made it too late:

3075476a7af666de3ec10b4f35d8e62db8fd5b6d ("pm: cpupower: Makefile: Fix 
cross compilation")

Do you mind picking it up so 6.13.1 builds without any special 
configuration required on my side?

Thanks!
-- 
Florian

