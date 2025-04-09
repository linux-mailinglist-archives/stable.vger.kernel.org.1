Return-Path: <stable+bounces-131986-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 281B8A82F45
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 20:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0885E444AE4
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 18:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13AC27780B;
	Wed,  9 Apr 2025 18:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KtWfgqwM"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBC515624B
	for <stable@vger.kernel.org>; Wed,  9 Apr 2025 18:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224734; cv=none; b=re4pNZ4VuvN96DHpgTzaDfHQXdjFHrdUQTnVtxQGPDY4cPU8w1I8t4qRhEmlXKwBp4y7cEJl97ZpgzicAH4Z8Ri4HjE0Og+bcs2Yz7kyZkMSD1xHpDHW7sVPlq+pTqJLIk/TUILxgCCP+PwMhnFcS+5zf5HiMIYv+5OG9U0rNjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224734; c=relaxed/simple;
	bh=UYddorqevsRwxFwmg1do08PnXxZnhargYzpzeVk9+Lo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CS2wEwnrngddft2oYdYn/nRsKpSDV/D7Mz1O22/jhpy8CJ/jBlFEKDEnsj2duA7af5Sjm2EmqzRCZg1AFt7KbkXZwVGegbuQcr6S272jJrLjZL3xyRLeOoto7xl7eHvrsKreqkMeQOuJ+GygilDc+fccD0vU+TgYZRk53dakpfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KtWfgqwM; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3fe83c8cbdbso2424386b6e.3
        for <stable@vger.kernel.org>; Wed, 09 Apr 2025 11:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1744224731; x=1744829531; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6GibFRXqwcx9teBdvxC1Ow1/QUI0XP30meo2aqGd17M=;
        b=KtWfgqwMxjgv3tYpbz0XKxyPVTiAuA/9tq5neQ7x8o5D6hiFfwGsql9rTyN5cF3kbb
         qlqlgGGtsF10wdfvHwJjlM2zxaG+GAQ9waUa6USDAOpni4Sh1gDEmw8+7ylEDXxYmf6D
         3A9Vz5VLpzti4uVkTQAYmZ4Zkm00vjLjdQ96k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224731; x=1744829531;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6GibFRXqwcx9teBdvxC1Ow1/QUI0XP30meo2aqGd17M=;
        b=Xj/gdmCNs5gusTgQb+y6PR4EkZD6djElY/12dvrtoxWqQxbK23LMxk2WL4x6+jItn2
         wvRJ1y8miwlfYkxMeNKSUfU0jjLaHy4IYL26ak2X0bqsjREliJVMzrThnBYCoj9lHzQS
         xZyReTA9uD6aEZzjBMbKb9BQ2fFb291MNGu6GDq/c6P0V6m0jz/7itxvvc4uCHDLifDN
         Yim16dWP7bX7h2XbUWhSs72P52oqaj9q7mIeEEiYLLCPKoWNGWsE+UqVmMS5kobqq4fn
         Bppkvb/lcn1l1WACIeKCd632YSF0ChdWrYk4Q4F54ung6IczMzaF0MHflr+tQ1+KzvBq
         Vu2A==
X-Forwarded-Encrypted: i=1; AJvYcCWeXwmhTisEErGEemmYDgirKgvdbvxOl3VO2akrB12l/HVvRb9D6GidpCQvMCzAxkf11vfX2cY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7lvlTZ9gZ8xqRiE0zj6lhWeXcVssSOq3Ch3qsXp+1ba4VNa30
	SBGjY30THoFOk0p6tz/SdrVNfpPxsWQg+BRA7FlUwRQHADLSM/SeO7YPDlgTGnk=
X-Gm-Gg: ASbGncsmLwWx3JYoqkqHXPFxbDrzOP5/Y4bfcZOqozkA8aM+3ehCipLFq430hpfWSQm
	nzrTdhOpiXWFPPz/9nYhiijx8hxOq8RESt1aIkNHv49cuhutWxY3TEiFjAo0x7HBsbYL5rldWrY
	UgMNQO6qKfYkeSf5wq5J9siStsX3VMtU9He4RtQgYWo852WWtqLBjPDU7w+udw0eGawfbo7YD/7
	0ImmEoR5Pk4heYDP5lMxr1vAWZXQf+lheZCK/MG8kvGGmgj4QT/ZZR7HzoreCoLOmYL4nrmWFzN
	wccsZFbqI4l71iCQ8+M9OdA0lhna8xJtEdMKdE4vu1SbqK6Ktnw=
X-Google-Smtp-Source: AGHT+IFoOWUYGnhxYrZFsDOJwhFDr8tTOXYJZckfR4G3iPbT4vRE7iwS/DWM3qg2w//4iHId28KWdA==
X-Received: by 2002:a05:6808:218f:b0:3f8:498c:9ef7 with SMTP id 5614622812f47-400740bf168mr1827591b6e.24.1744224730849;
        Wed, 09 Apr 2025 11:52:10 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-400762eb331sm254058b6e.29.2025.04.09.11.52.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 11:52:10 -0700 (PDT)
Message-ID: <c1b5c202-5899-4a2e-abc9-93bd4b17ac87@linuxfoundation.org>
Date: Wed, 9 Apr 2025 12:52:08 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/269] 6.6.87-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250409115840.028123334@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250409115840.028123334@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/9/25 06:02, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.87 release.
> There are 269 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 11 Apr 2025 11:58:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.87-rc2.gz
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

