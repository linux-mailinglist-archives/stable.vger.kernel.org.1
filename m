Return-Path: <stable+bounces-200744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E45ACB3E0E
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 20:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B802B303D6AC
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 19:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9172C32693E;
	Wed, 10 Dec 2025 19:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+uoWZPu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0C830498D
	for <stable@vger.kernel.org>; Wed, 10 Dec 2025 19:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765395735; cv=none; b=XlgX2ZR7QnjX2N6PJp6RdWryw6mI8JKDu4sGX4WGPwriC+qw8x8Ope9NP2zHjgFT9OtUNdKWKMx+NSy3uyUbKe6A4iiYz92KK1smoyuUqnA+Yw8nsVZYHgwxizVcKAfquGqiITkS5J1WZ4+87WLFR40U7V5f3MjSi3kLMkvxarc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765395735; c=relaxed/simple;
	bh=Bjoh0cs9hp+8i2oA+nrPBeqcL2Xj0JTkD+Sc2wWIqE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ifm9NGM1BSp9hV4RTmGqzi6Zv+vwFFz5BdZ1pt7YASGLjpOafOiB4xbDhEexpgn3H16ki1IODsvH46U4OCGNGeFGidFwz6ziyAPquyw2bBE1sXQEqKWzZE5XiEM9mv6WX6WqvVFkZLF4Gp7cgwwcX1WplD3ezh7qs/BdqH0d248=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+uoWZPu; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2984dfae0acso3728875ad.0
        for <stable@vger.kernel.org>; Wed, 10 Dec 2025 11:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765395733; x=1766000533; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rTXG3UAeZ+4nWsAK7nRjvI8ENM1F6qzEUo7eddhOpFs=;
        b=Y+uoWZPu+kC31I0WDJcVmpesDN/1okym2mqB247qk79Ou2uLO4aRBGlqh1K/6v4Vm1
         AZ8EFysxJ6cqYscfVYs+L7QVmPY25HgkwDjsdCD/z5VZ3Ui2fz5r0vTeoDH2NCdydQqF
         mkEsxyT/nF7gho/zgvkLhHNtkflrv8i3R5FPcSHeY07ysYPq8xOXmSGX23WZPWD/9g2u
         Gu/CnfGfZZ9nIfCaa/+CNVmDiRWXJ/3jK6nSZ8m1XOjhu+dqcLK5vsb9qSl2BxelDYZd
         Q8gBmxHu1y1DnsNyvEWAzKcKAeRMugQrDGqxAX+ZqIcLNh/iTIDcFLya3h1yaO9Hm9zo
         IWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765395733; x=1766000533;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rTXG3UAeZ+4nWsAK7nRjvI8ENM1F6qzEUo7eddhOpFs=;
        b=G/uwtrqnOQvEoEDcXZGJMtRrBkp4cXLXL9GTX4RsTePGReKfsCKgAyV0NzoyuCq4VW
         YRoPdSKzTfB54RwaKwXH2Bx4iFhn2HXj7kmWpxl6fqOrZM6tGTas12ldHy5x2aYalMFx
         77XCM4RKseYXLJL2NfaLGJWyapOjQCpR40Va86x2464AYukBVg9ov0NFt5a2ig1XFqNo
         M+j1fO65iWBESfeaPRTwsyxj3jaVamcVlIqQJ0U8fiViCLrrrQsxr6p9V9c7sZvio24p
         +NCehqylACaac53MxHXx2/csMgryXtXtYFIQszjk+sPv1ZyO0KwdNz7XotBquvbR1zWQ
         3Lfw==
X-Forwarded-Encrypted: i=1; AJvYcCWKq+rWWx6ElAP/l1NHplgNws1bB3lbQwX4Tjvk7MoP0sE94n7bRKQtJD7XrWDRjE+uQIL2DVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGXregWUOdIeKk9fzrVypaj8qQuEoyXZ5VquJQMG9Z0/MZkxNU
	VwEpghyqBZSj1IZZIcY6c/SK2qQ8cnKq8hBgrHeZCPojNvaleNV/43IG
X-Gm-Gg: AY/fxX7e5vFJROxCA/J1qYaHQy1/UloOGhhvUwq6w/q3RyxDL+UiYg2blzoO8zGeMoI
	pMcZecv76Wth9Se7BaBwpXkkLvFhdjlzzR5AWKZEjUdBAl0EZkLC7sepXjDhoMu6Gx3kzmSQtQs
	BJDy4KFiHN5k5uQnAJzNQD82qnvqD+c1AbGNnT9VQbQWF0jPX1NWlb7vKI77iNjnSMWlPLCI2f8
	Dr6Sgvq5lklPyAKJbO1Gcptq8b69GhEK64CZIvrjddafUOOVwReU+TT3azGKHElMpi0qygGhRyw
	zlw0E1qjpdAc5VnxbPC8LyGSEny49bqcjhvyhH7xpvNavkBUIVgUuFioacaixiY3QNlqTbVaM/4
	BQ4Fzx62X9zXFtLTL5XIz8dZmtnmxbVTwZRiyOLm48eo7C+9dhLLDY9Y7M3XeRKG4OLDiN8SoHq
	oMREDkNzk1Sb9O8w7sIQcTf56LI6XNlHCqqcq8Xw==
X-Google-Smtp-Source: AGHT+IG8hL7rlUSmacHXNh1bW7WDqPze385dRlSXQp83wkIks0EMXedpKzK0WJcW3BsUifno/jpftA==
X-Received: by 2002:a17:902:dac2:b0:26d:d860:3dae with SMTP id d9443c01a7336-29ec22e3df4mr36371385ad.3.1765395733348;
        Wed, 10 Dec 2025 11:42:13 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29eea01723bsm1436855ad.62.2025.12.10.11.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Dec 2025 11:42:10 -0800 (PST)
Message-ID: <4b1a256f-5d1d-489a-9c87-c38b4465a6bc@gmail.com>
Date: Wed, 10 Dec 2025 11:42:08 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 00/29] 6.18.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20251210072944.363788552@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251210072944.363788552@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/9/25 23:30, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.1 release.
> There are 29 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 12 Dec 2025 07:29:36 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
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

