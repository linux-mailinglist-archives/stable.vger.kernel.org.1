Return-Path: <stable+bounces-182969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29395BB1377
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 18:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D194D4C25B8
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 16:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A472836A0;
	Wed,  1 Oct 2025 16:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="heg1YGWj"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE98248F72
	for <stable@vger.kernel.org>; Wed,  1 Oct 2025 16:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759334893; cv=none; b=ObArfCuJxKnMiIQR5Xme3U0v2yRUqbxD6SXvyWTNeet2zWCD6lFzsgOBgqGIupq8tmrcYSila8j5ytaXYRogJ0bZVz1enZcoWuNmc2tKSZrkMGr5bwohu5q9ZOGDmUoP6bXyfzAMnLjm0HDmHhnblhOSofwdF92bexnZjMHBG+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759334893; c=relaxed/simple;
	bh=4zahqbZVB1dViemCcCJZXwgbp6DQIyBEEvtQ06hxhqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o9l+e6WG629qs9Sef8kF7NqIzzpLvT652rmQSqor3mo0unsfTSo2MEn4YeaOYA9zkXClySarcwNMN+vlLMpc01BN5gZ7e7dP9LWlXoisH5D8sTbMg7bcwAWQTtdhxtx4pdBO5HHPG8opqcOc+4ZNMfEF85trdntp0VZ98ScvPy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=heg1YGWj; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-425715aeccdso47825ab.2
        for <stable@vger.kernel.org>; Wed, 01 Oct 2025 09:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1759334891; x=1759939691; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pqQen5bgeQftZhhWpYC9UuT0CiCA9aQdBdei0IUghxQ=;
        b=heg1YGWjlvnJelgV1a27kkwArU8gcsO92xWVgrjtN+xIINPJ+CET2YFecj5/AUkZjK
         EGRtbor3pxoMAY7LT09SIi4MxUCAoYxSXhunqdFegBkzGnT0apNl6UdI0o+HleA4BrWN
         J1FVJRHe+10ffQ/nE82hDcW6ZUkrcoDuY7ObU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759334891; x=1759939691;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pqQen5bgeQftZhhWpYC9UuT0CiCA9aQdBdei0IUghxQ=;
        b=pSCum34m2lPt5MLQPWS9P8E3oOf1s5llxsRQTTc+DPwhKApkRPC7L06nut3m064ewh
         x2tv9zlVXgDsgJEq3QZdsfzQ8eOYzsxIKZEssocbRX5y0uuRfLl8/Odz2fICLnQTbth1
         4B0ERmDItI/k5AiWCe7PjO+kfAtv1D0+1JsKHVqClcPSFIfOc/W83yO94WDbVG0/XU4D
         gy2+2eBW4gRXHPmzJr0dHHuBmzBZ7/Vr24zKxIeb7yl0szyeo/tIxywKYkmfWntbsIA9
         lZQAwpfnt/d8JQHQogVKTo+F/d0c5G4FsjXu1FPhW3x/Efwgf/u6iU+2gyJXFJZsBcoA
         95Hw==
X-Forwarded-Encrypted: i=1; AJvYcCVf7ABLB9wPi4VKI9A08C/liKkGjxASwNp5w0Mhz0p3cY9+MqzuqzNp0eDeNaCL3EC1QtDsVvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN1BcMtidMyel51JrXNoGPw38JcA/VJJCku/z6hT7MwbqQ7fW9
	jF6E0vMq2f+5Fjddb3bYFG8VIRHCWt8yAduUJW8LzN1sQe88VBRYxvgy6wusF4j7QUs=
X-Gm-Gg: ASbGnctDuG2nTECzPNmrnov2tWgUUj5kWjX6frVMvlK7glMmedU0EwuFX/o06QQFK14
	5hGU7JG6PS//NyZbxcvjtJ+iu57IeMWyFvuY3YATsQWo6BE8BEPkyh3C0i4LhXrPsDKRNmbY4mB
	W/sWlCT+kBy8KlxMO8MORYn5rU30kPY3zUSwg1Oh3mmyVp5JZU0xqjHuIB+KOEO3k6BO24TWtwb
	BzcvULnspOyXO/hmMjPi+scxcKZq9FWxsnLq+dZgHm0fy9tBZaXV/mFlgQUU/W5WI+Wrla2SpTn
	lkY2wiKipGtySl/1Ajz0HfYyvco8VDpONwpGQceGUbyOdQRl0sWgqaYC2EURlvm+rG880vWyV5h
	A51YyIw4/IyIvi/QB39sUHN+prlK1WsBiqu6fv1W+PtKkLqDFBRjXdtHy7UE=
X-Google-Smtp-Source: AGHT+IFRMvxEYLeNKDQ1JmK6xJLRr7HtLVjyjPoczJKg+MoqWy9AxaHGv9UkUjU5GqojzD4dh8HSSg==
X-Received: by 2002:a05:6e02:194e:b0:425:7974:fe21 with SMTP id e9e14a558f8ab-42d8167e8bbmr55614135ab.22.1759334890495;
        Wed, 01 Oct 2025 09:08:10 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42d8b28153asm215225ab.20.2025.10.01.09.08.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 09:08:09 -0700 (PDT)
Message-ID: <ec7fbcc9-cf19-4fa9-9e4a-73133203aad1@linuxfoundation.org>
Date: Wed, 1 Oct 2025 10:08:08 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/91] 6.6.109-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250930143821.118938523@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250930143821.118938523@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/25 08:46, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.109 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.109-rc1.gz
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

