Return-Path: <stable+bounces-207924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1E6D0C98A
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 01:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C83D03027E27
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 00:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21547340274;
	Fri,  9 Jan 2026 23:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RpsyHZsC"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2949C338590
	for <stable@vger.kernel.org>; Fri,  9 Jan 2026 23:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768003198; cv=none; b=Votke3WH9f00SVECmRkNmwRd6IAacSjMDvakW4cknJPQB+WGIBtwA3ulZFmmUUhT3x6S2rm4ZSHZzKiIoX4qn4zbz73Vuib2F2OKX3fJgYuobyNBXllcNVxiJJffk2ZGPgXxUAoW0j2f1BZYAApEAORpYofWFs3Al8g8TnEhlgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768003198; c=relaxed/simple;
	bh=uWSitvL2b4yQ1p4cBPEe/a2jacnqOWLqFz5hk4wicZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zp9iKuWBgD/hj46t/aklbdCVDenFqCP/6rmM1nMaIIBkjPb3wH33v57E9u7clAesKSFz2YncgsyTwuVe14vBVSpbDunpAVf/NDTayEGsATBlzSNQlyD4n2CN+8bgCuItmWPSlhuVLBRiFhWEDWBnTtIBt3lKCqw+Mj3imgUduAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RpsyHZsC; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7cae2330765so2439327a34.0
        for <stable@vger.kernel.org>; Fri, 09 Jan 2026 15:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1768003195; x=1768607995; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F4P0AoPZlzsAr9oF8m3u3/s9r9MBsSXnvxpJP0li1qg=;
        b=RpsyHZsCc4O6tsuYDX5VWOE+cgSEn9WiMcilg+6pKNEMDvsMSa5TKvN1PvHImnDhKb
         ScIF50k2pcXGYTLDxAK6dYgygG/PPME8Cz0w/N9xtu6uBsPQvicyewShnw+HjzKfTC/u
         CX+tfttwcHc7k9zApFLO3FV+k+9k/st83XFMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768003195; x=1768607995;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F4P0AoPZlzsAr9oF8m3u3/s9r9MBsSXnvxpJP0li1qg=;
        b=TwghCdet8G3JtTfESXhntdqELGs6frRli+lmbfK7OTtvWBS6xA10Gr9Tfj0fGtEoZK
         tNPvNvQ+KgMXPCuARYyQO9VXUOhzJRFi+G9D0yvhtBC9zCfa61CB8Cr/9u7d0s4u7cNn
         k7TTDB/NEo1Tr053BpjZ4bZcuzOTOIng5prHhnxnhMQmSKvQgE+N0filY6Dp0fbY+DxU
         QAVSlydhHza2bT89I5VwOoOyJIbGwfBYgKYalEqKtBqpj+Fc8MLDxE5kxpfiXrWwmVak
         NT5ZjVW/axnMvZRPRyjBBN0cvjGqIbHGoMmdO+KRjS/j2AkNpT2gshyo0cYAqeYvJzgm
         tSoA==
X-Forwarded-Encrypted: i=1; AJvYcCUupd8YI57okEOwf4o0zWZN9GwkyiZ1rKgJLBdCy6PyUD+oDHqZML+oyl2tesF2fWGCpU4Xwh8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8UF3aGkLzbXZrDyw9CrxM0DFrasfwTKSOtgMZ1wd81xu6yy9n
	aYUyYKNT+tMvdnMfewGItIidz17Uviv2FWRY53aWFMzxtpRVZmfya+8aBGQk3C6S/BA=
X-Gm-Gg: AY/fxX7dI2fmlK5Yw+uXLUMCA1v9AbTHNd2mUeSivY+lCbvDGzzUcmJqX1OxWBZsGE6
	56N3wDCV3osN7Y8xYmFps4ctZwKQfX2UkGMpaeh04NCDaXQ3drCGk/+fRS6dEKwGcUbBXiE4+NX
	9YyRA22POUtDOnZhSeJ5yjhnzUgEYkInzNXZ+HjyZXYMiSbXRvXgkkdfvaOy0LpVCG2QZzFGMfX
	pr0OBxqXXH7gWVVXuGMtNeIFf9ZH9Gh7GTlcS4Gx1TESP4Y2BtmJY7b5DJDeJZxou4x5myC1ydz
	hdGaqvtnD9ScWHSixPwzRpQM4z79+LQdZwEXWM8J6ekLldG665EHkvFI2c4SiyF1Qg9FBy0oiSj
	5bKkzpyRWDplqGBI5OonUtkAUjxfLUbUkTbkaP49wXo053kD6MQl+sWaBL7iX+7aFbnrvA5ThAY
	hlNH5+r27+csbyo44CQR2nDAQ=
X-Google-Smtp-Source: AGHT+IEZE1mIp47OiCnx57Ey17H3QmxJjSntd9n3xE4Ci5YznpqJ7xdvsZjlH6bqf0UIhw9xAHqbZQ==
X-Received: by 2002:a05:6830:6383:b0:7c7:7f85:d19 with SMTP id 46e09a7af769-7ce50a8df3emr7733025a34.8.1768003195093;
        Fri, 09 Jan 2026 15:59:55 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce47820f06sm8132481a34.11.2026.01.09.15.59.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 15:59:54 -0800 (PST)
Message-ID: <6af37bb5-1948-4a79-93c0-402213762ef4@linuxfoundation.org>
Date: Fri, 9 Jan 2026 16:59:53 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/737] 6.6.120-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260109112133.973195406@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260109112133.973195406@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/9/26 04:32, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.120 release.
> There are 737 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 11 Jan 2026 11:19:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.120-rc1.gz
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

