Return-Path: <stable+bounces-199943-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F917CA1FB7
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 00:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 415633008E8A
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 23:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1EB2DFF3F;
	Wed,  3 Dec 2025 23:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VSYHvcNA"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FE42DF141
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 23:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764805402; cv=none; b=eJ35UtE/LG/mUzVJqYuuoMIaz/nNE4PCO5AWIvJvZnUHi7cMuq7DJzALWnGSH8eQc05cYOomvHFj5ONYsyBSoXXDYd1KLZvhqkYyhbg8EHF/7xp1NWvcj9crfMBhIjWUkkDPIY8a/RUvChcfx8dfuJmqrD7fSdiXDyrV7ibCSfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764805402; c=relaxed/simple;
	bh=KbKr01owsmLxfyhnVDZLYeAz4isyRyyTzNwUMiogW6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sxnX7uR6SSS81UVtPpxJRrnO/xbYHTMvyvi17OCM7kSM8ZIXj4h8yBiY39sO6MM7gyfnm1e3S7UHlLe7ovevxvePNIl5fyze28/MsTGJUlHmclCOBsKl1ZqN7TVjFLmdfykTSC/GJIDkzboYT+EshpY3LSOUJ+iEhtOHPjPey9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VSYHvcNA; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-30cce892b7dso202725fac.1
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 15:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1764805399; x=1765410199; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wQUjSkRA7o9gYvCUhGv5afQrDSP5yNWAQozka/JiI88=;
        b=VSYHvcNAhYLrN7gGM7Yijuemqp5Ut158Z0yZc/e4BP9bTFdVCRIKKXFS++F2QR2e14
         UAb4kazt7+JYcLbHrzM4TSt5/rCFakto/XHCOfE1PA9iyHjLt52zWnBFvqgmAioEbPfB
         24ndWeduhiC25RFXY2SxPSGAztKjKvytK6MGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764805399; x=1765410199;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wQUjSkRA7o9gYvCUhGv5afQrDSP5yNWAQozka/JiI88=;
        b=Vu3rysHD7jR3T+7xxSYMbBC6cL0I9wbmabaFnpyr6zXnpwXUN6kZBqwmhxeUUy/F1+
         ADC9Nri58QJvv3uNc80XR7N+B8uB35GkNKeRbNKFcB39nWxfpUaU6ZR4Eaeqd/RWdu9x
         oR93Dm5rTpXqcaAK5hxG7Ey0UWQxqkB7varoEQIGyeHnX+R1X5Y+tc2EV7r2LJGM8oIX
         MlXAWQ6O6u4F57uAG6XWoBPc8KWp5UWCVjoGye7DNFbHOAH4W7d1RBdA0Vh6wzIrRWjK
         JiTUaDT65/bf955kr6yTLsVF6/Azz9nKwQVwOVsz7B8FMaDcfOYR3tc1aojXJL2/r2Gi
         IS7g==
X-Forwarded-Encrypted: i=1; AJvYcCUY50s6CE50qXlWNphNV48YshKVZctFLcyCe4x75GN6SrlEyCJBSIP7rRtS8rNk2EoOZxPqXhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJUUNYefxpjirmS8ynbuYcgvAWoLCKLudWxV2QxKupLlTfqPl0
	DYVR6PfoxYpM35nZCJZOYnZHKirrudithrcZzpPfNZjRMNXyPzbp5/QMqDXBc70ve1M=
X-Gm-Gg: ASbGnctWB0WjQKwlPkqgvNgGJHPZqpR1wee6PSaI/eKOdmzIP5syVlUWMJ/UB8qO+uF
	AQ5WNv3DiSTuKyOUI+KKrKE4BJXvjO51EePCxVTlSngwLSp+lpC7t3t+xF0B5C503THulIyoPlK
	FjrkmCtQr4c88gEjzOOJMS1mzJOkwr403M2sEOT8cZZ0w3ndbvsnhNtTP8pL9KFz1o9kbuHkJpF
	NX7sb5uh9ItmdyMTYuthi41RvnBe6pldmnYEln0kS2yuNqCj3DX1wxW0Ha5F1hge3q6P53uz6Qd
	4syD5yR/3Y2WykY8LsyOWM6bSKyXUst4OvcDF9nEYA385QwqYpilICWd7qQnMufLpfoOmOUYt7/
	2CffBRdRsZhn7/1dBO40UkyKq/dJM3/GiWBakL0dnPOSUHjeXUGTpdcb56tJNKwxhI2iDrGnuoY
	Z3ZfGRfHAzpow79zr/xO9ID1E=
X-Google-Smtp-Source: AGHT+IFIJiKlAtzn6hk6GTPwPglZddtGPgAdQrCquTbSFirZZ8ZbYvXEtSwr0mcfRLe8YWeWF9T+1Q==
X-Received: by 2002:a05:6808:300e:b0:450:d056:e0f0 with SMTP id 5614622812f47-4536e3dcb62mr2315210b6e.2.1764805399523;
        Wed, 03 Dec 2025 15:43:19 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f50b5123f5sm117756fac.13.2025.12.03.15.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 15:43:18 -0800 (PST)
Message-ID: <1615358d-5443-482c-95d3-e7d3c6e318fa@linuxfoundation.org>
Date: Wed, 3 Dec 2025 16:43:17 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17 000/146] 6.17.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251203152346.456176474@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251203152346.456176474@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/3/25 08:26, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.11 release.
> There are 146 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 05 Dec 2025 15:23:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
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

