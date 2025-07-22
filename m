Return-Path: <stable+bounces-164288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F933B0E3CC
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 20:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA9C61C833E4
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 18:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0E9283695;
	Tue, 22 Jul 2025 18:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehcCtPAg"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A13280329;
	Tue, 22 Jul 2025 18:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753210739; cv=none; b=Mu5fRlJXW3GuNJywJurDY4K1GBTwKZvRZI/Oowfpdp1yj9gcpCA3jI1UwN/nBNGXZnDcXsKnmEHQlB70HvQke/V3jf7C/JUixodh466247QSF5vYDG57KqX2wZYqWxWB/bHSvAQw2bfGtWFyiqcCHwOCp7pkbHk4zWBTKpjtQfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753210739; c=relaxed/simple;
	bh=N7GByMny1k3/yqgJsp+bBxpQFQT00pm91LAc9vzwlYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PIlwG0Ydq0VIPBRt0KVPSmE3eYJS/G4sCGBGkACrKg0zATMEMDnVK+N6aee1vlmkR5cztXk6erEV4hVg/V6T3Rnm4E4vvgD0yMhh3tFsXX+r3ctfgEMTWKeK3WKb0gipMnbQtAnOZo3phLPItaFCi/y+8d8ebl5Hm74BQ9q4Xxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehcCtPAg; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7d45f5fde50so510968585a.2;
        Tue, 22 Jul 2025 11:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753210737; x=1753815537; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fVbE4RK4S9rwPovm9fDcB/zDyFXGIyGpTxBbbBTCpHs=;
        b=ehcCtPAg2urJkaL6SEGsc8si+pN5qhtDPTyRpxkK5loZTgIN/3JXvCA9ZfznwtN/n3
         dzghWaDwAijF2yYoXrngFBdjBX06/1++85w1ZXH8Lc08fmgcQWkfla2a7HVP8sVKnFbi
         xZNioMbEQFz/n7qeJOxYKFmSH5u8vEgAZacxlviO8CGltBInQ1r+c753i3YxDB0I7mWg
         qS+h9fsE1v5T0l4C4brMeWSlCsAWuNz0cSVptGb5Nkb32dzAALpD2UzKCtGOLNvEGa3y
         5IqhOKI55w3OgRsaCOIFRBZuYolNOUiDYyccN0rpLYF9wjVMs+O6WhyoqU0nTEHoneL7
         ihug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753210737; x=1753815537;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fVbE4RK4S9rwPovm9fDcB/zDyFXGIyGpTxBbbBTCpHs=;
        b=Ik/LQxRISMjHbDx6AtldK8b2XI5ws/3TAAtsq5k2hu+p+OolOzfccw4/jcN6Aw/fSt
         sDarhe082YqW7BXDrC8fgeACoiIWKpkTJYxYHtIKlp5ddaq8ls3l7JhM9qOss7ef2GD2
         IU8FZyWLQVKdFFr5eLEcOJJ7gTSYm5DK18WsXyyey7cFYJs0VBgxqjGNGkHZ8IKrUxAX
         k3JZrpAJcZqHI5nqjOs0Dfz2sFwAXeRwh+sy/YJKdt98OkcaYonTJaDHtPDJriEK2rXm
         7T/PbMXIdw1jZY84m4m3BrvMcYpBztzbdf4yw4WpcByd6J4hEXkInjo0KAW0GzP4hxFK
         oj5A==
X-Forwarded-Encrypted: i=1; AJvYcCUtK5IllYjtGowKxuX4qkEOm5YDVXqQH+RalGEMpCBcQIQio+qW+LXGliEuFdc1k/xEOB16IquM@vger.kernel.org, AJvYcCVh4RL8yJseslX3ME6IQVS9bvVkVT2dy6d10fzbZGmx4QWGIrxrjJdN9BLw8q8lZDF4fQDZ408iQ5klkmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYlWgnCYtqwU0E5OdWKk5Wic/cZxqqeCpUvJfsfO6NWxf5eu2C
	fj8H/juwpmsJXGJDf7UgNX3ElO6l/wQ1+86XsJYLga6vXJwHDVNb4Lcm
X-Gm-Gg: ASbGncum1YhQXfElF+yY1g1K5NehDy3q85+i8TpKGw26Ik3TCojDVlzb6O/TD0QcDMH
	cLdUbybaKxRbjGpOlK3cr37bYh58QXZRpO8Pw8NN7ciHJVjdEJqNEnBAe+SIIMtO3dw0WXxMmjA
	glhzD5mrgPBF0l88QE0yd4iQFZ40+G5Y6m8KJaMg0h83LSgPUDj0vQMecE5TjzCLTYRP2z11KFY
	37PGN+cNNY292AKVw8850OriQGk1gZRChUXNzxAUZvXLMEWkkYur2hNgAJs82uLLjKFL68oG0EC
	dADMZ+7h58gVycdfX22nutK7Z3UyiYKHaIN9Wy8iwCjmcMA2Vga7At2vPxPWFb1AlMYLj4on9zP
	qtDTk47/pcb5XDO6i5PSWYE+sSG2C8+ZeDMMmeBRWgswe0E1YM8/H4PD2aOE3
X-Google-Smtp-Source: AGHT+IEIF2TNXdYOuGMFTTJ2GPum/UbyklvK4DCR69cWLNA+Jo5lf2NWQszfa0MRRNlxBIP3eX3BRg==
X-Received: by 2002:a05:620a:25c6:b0:7d5:2332:2830 with SMTP id af79cd13be357-7e62a157177mr47446285a.33.1753210736974;
        Tue, 22 Jul 2025 11:58:56 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c4780esm553532385a.55.2025.07.22.11.58.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 11:58:56 -0700 (PDT)
Message-ID: <75309d78-2be2-4054-9632-ebbe1086f490@gmail.com>
Date: Tue, 22 Jul 2025 11:58:49 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/111] 6.6.100-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250722134333.375479548@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250722134333.375479548@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/22/25 06:43, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.100 release.
> There are 111 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 24 Jul 2025 13:43:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.100-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

