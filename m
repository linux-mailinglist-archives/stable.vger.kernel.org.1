Return-Path: <stable+bounces-131866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF31A81914
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 00:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F10C21B82F84
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 22:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095B3255E44;
	Tue,  8 Apr 2025 22:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtYp6JAk"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594361990CD;
	Tue,  8 Apr 2025 22:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744153176; cv=none; b=dE5qYXdiGYLjWSZkNOwhxjdXjicN78q/hyqJn1bao/sX/DgllV9wVqKakc3S3udPWAlgpMNB0dsfQViCQk0SVWFONsyVDs+OrMeb2W8QReIi4htYSSz3gpOM7nKkxORZUzQtVwe846a2XomkPfh+4/2/n45nwYsp6ktDdKwFgHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744153176; c=relaxed/simple;
	bh=l/3XS5nIqJsAU3kB74Nag1324TqFZCJpfxHsp40JYXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QUuyoYrH+MFs7z/Z1Q2rdepi28MtyRwDV1Mv1oTIOeq5Tq3HiydCAKandgcHIUvbmIU52tFI+4TOfJUGKld0X9+3fw5BDdXaqkg2OZzVjkXbKWh07PtZFqsVcI7kOD1QIn7nREpxGDcNu48KLElNkQO+p/eotqzecIRHOz4/8qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jtYp6JAk; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2c1caacc1f7so3695936fac.3;
        Tue, 08 Apr 2025 15:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744153174; x=1744757974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pkDcBJ/oOVKPcufA8BKKqayVLGOZ4HCiJgAEI5ThhLg=;
        b=jtYp6JAk4666BQPI0iymZrq+XWefkjMFUVNPz6bY10Y1R87DoeGyRUYlwJYLaeen1a
         pv/aEmT9HWPxEWzr8RzG8oAxuyCntckijjkLwJK+oa7XN0vlLPf5k8cCQZ5auKtqJgJY
         VtvLN5zIs2d9bJl9zCgCZ/k1yE0JMWpD7tqL8S0dq7CWCfrx/IuX2Z2VL4i7aq7Hh75S
         Jclwj+3k/bQbVVRVFPmWKOEl3rDEaPkO+2MQU5VjxP9tzZDZKKJmj+7aRGCM4WS1ybZQ
         IuDhbFzq06n12L4KHgW9bFOk+GSrwttQEY51nMrOq9r7Lj4ajdATaekFJ5MnvHntpRJO
         S7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744153174; x=1744757974;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkDcBJ/oOVKPcufA8BKKqayVLGOZ4HCiJgAEI5ThhLg=;
        b=eJWltND3vAQkLhHn2nFrv7SjlAojqbVDtTEIMW3FmhtH9CPJiSckMFxvYDf3HWDznZ
         3kF9HSBgYqMWaruulCJh2RHHBkFuW3/PrE9edxvoMvhk7l/PhItxbKQxxKr/YJ06anOC
         Eolx395bAsNAB6SSxBbB8M/+q1EjWfdkSTTfn1EgqDLdVsb7oHmmFoKlkTPvmWmMFnMN
         VzVSwLfssnGRPva1HIQwpWYTfCrOsCSt45HKe3Uvij5gW/rl362KVi7moXYPRjnAFuIg
         SZCktW5kgzSh4Z1DW8ikZ4WC9bSub+EsR5JY4jRiLjoNObWY3URRwnzGmCO2jWDOxJvN
         dTXg==
X-Forwarded-Encrypted: i=1; AJvYcCW9M0VIK7gQan1jS1Mm71JmSBd37AVrCmKtsrtX84TZmX3E0JEndwYLBZTWuM9mJ0zWWH3PyTR4@vger.kernel.org, AJvYcCXSY04JK5HGhM74k18pLmDkqTVWStBK3uIJInzA6ltQ43fZifAAQhsemfhPTuiiHe/fTWk7CY4s5HjSdKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgYpeIQwIZ++qMk5i0wm54nFA07LgRTehFM97dAT6y3XFC4g30
	Qp6Gn20fD/sXknrxMu9XsY/RIogOcAKQnZKQkl30KLtSEhV18wNk
X-Gm-Gg: ASbGncsZF4xKd9pT2+jFeA6cJaD7Z+6yvJIuhI4gE8sjj34THl9ri3bc6nr6X6w+idr
	8x2CBhrRZL0Q7khkP/S/o084KQziIKIFgaM2JV7bcOgt+ad1raoWOH3TvLkgYd/xX4IXP1HdaVy
	GiZaDNZ9FVbeLbyh4pMvos89IDgIHKuG79fjCsTnAS+TIcKx5By7GBVuJE5qona/MmiRw9WOmlN
	M4P3FkvJkuh1OsWcveCXLx49Aa+L/lGDm80j3dyz+srL0Pbca3WbOxpgnxDDMAUEHnu3YbOOldJ
	VZJqKYSbTRDINgAwMqiMDCY4U1gZN8RO5pNLOyNxOicWjVZmeQUOgsF77vWACBiy9A8yuwwA
X-Google-Smtp-Source: AGHT+IHpim01rEPiZ6UQ/H6fSpIL5PifTJj3vLc9mXL8VSN6dgPKWlZ1swy0NMpJLPIS+W4pMfJzqA==
X-Received: by 2002:a05:6871:6504:b0:2cc:3586:294f with SMTP id 586e51a60fabf-2d08dd7faddmr514579fac.9.1744153174245;
        Tue, 08 Apr 2025 15:59:34 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72e6515c503sm624443a34.11.2025.04.08.15.59.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 15:59:33 -0700 (PDT)
Message-ID: <c3a72fdd-6344-4f53-b4a7-eb87e346cd1f@gmail.com>
Date: Tue, 8 Apr 2025 15:59:31 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.13 000/500] 6.13.11-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250408154123.083425991@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250408154123.083425991@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/25 08:54, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.11 release.
> There are 500 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Apr 2025 15:40:28 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.11-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.13.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

