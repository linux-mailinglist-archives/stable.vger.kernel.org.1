Return-Path: <stable+bounces-9919-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AED888257A5
	for <lists+stable@lfdr.de>; Fri,  5 Jan 2024 17:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F628B25582
	for <lists+stable@lfdr.de>; Fri,  5 Jan 2024 16:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C082E84F;
	Fri,  5 Jan 2024 16:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CHemGbsT"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6E1328D0
	for <stable@vger.kernel.org>; Fri,  5 Jan 2024 16:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6dbcebaf9a9so937243a34.3
        for <stable@vger.kernel.org>; Fri, 05 Jan 2024 08:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704470692; x=1705075492; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g/cqkHT4FbEcLpTCBsflcScZ0SAC3mcZJQ2qbWtluSE=;
        b=CHemGbsT18NCME8Uab5DVY7E6KNmhvGfRmrrlmm9tiCYLtr2qfocwRk4l1jpRMLnKt
         d6PKxurjEWYTJblr8paIGyoLV7Ig42RIR0oL5V1cXrHsmMb4kYdP5UrYEIWto71ZF2Ls
         5qh1TVpfhClWG6f3wjJW0hWmAD5yvWHmrwYMdid4w9wrDFi7QwsdpF8TmdEZ6nXH8wCK
         GhgH9Xx/r4SONK4WNXYKwx7BTCwzLrLiciDlMaz5dp+0LH5I1hMv7HmOLsVcpDAvPhrl
         x7g44WU33TMW6n7d1GFzdyU09j8wZBainWJQ17i73r7yE+fFRKeEiRCbH72BRf3xjztd
         0hsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704470692; x=1705075492;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g/cqkHT4FbEcLpTCBsflcScZ0SAC3mcZJQ2qbWtluSE=;
        b=RCskXYv03C4mGo6Nuoqv3XT91zcMmCC/Yo8JPwJIHH8KYZlxHcOOe3JAxngsVXEjuo
         q5eSuXOmNWkkChiXIjLgscp1k7vDF5G7paqHZRXdK1WCH4mNtqBxR9D6Qv75FjbyQnp3
         gc2awCqHSGBQ8IgQpeML4RnqM+enFAwKxQcT3TGVbbyruN3My+IyEE7hLcppOTgOmnIP
         ZDBr8AYvLIHZ3KmXdUk+KyV8BuvnpNEyYTu124pQTkX0LDUjwLH50elkdvkN0n+lvMGe
         iQzM1RwoW77U8nrfF+u1WaqwugZTVoOlaWeNOfK9aaWIvdDZbJETQ64Rd8eryuuhPyqM
         eEyg==
X-Gm-Message-State: AOJu0YzfNsJ0Dqbo+x86TYsSaDNsTstyv1e0TeS1ZIzuk2SQ1+pMb0MP
	fZTsmMtD09LLsnXdZaUVMOkJYvA0kFtnXA==
X-Google-Smtp-Source: AGHT+IHoqgc/4KxOLgqUZ3DBIB/H9/F5fTAwUyj3GQ1drQDOpDweX5+WGWBedMdanPP/4rhq1Xq6UQ==
X-Received: by 2002:a9d:7748:0:b0:6dc:a1:90bb with SMTP id t8-20020a9d7748000000b006dc00a190bbmr2385822otl.69.1704470692568;
        Fri, 05 Jan 2024 08:04:52 -0800 (PST)
Received: from [192.168.17.16] ([138.84.62.70])
        by smtp.gmail.com with ESMTPSA id c21-20020a9d6c95000000b006dbd51a58b8sm409667otr.37.2024.01.05.08.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jan 2024 08:04:52 -0800 (PST)
Message-ID: <77569e45-ab73-4049-b90e-cd60cbb872ef@linaro.org>
Date: Fri, 5 Jan 2024 10:04:49 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/47] 5.4.266-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20240105143815.541462991@linuxfoundation.org>
From: =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20240105143815.541462991@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello!

On 05/01/24 8:38 a. m., Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.266 release.
> There are 47 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 07 Jan 2024 14:38:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.266-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Quick note that there are Arm32 failures:

-----8<-----
   /builds/linux/drivers/bus/ti-sysc.c: In function 'sysc_reset':
   /builds/linux/drivers/bus/ti-sysc.c:1847:4: error: implicit declaration of function 'fsleep'; did you mean 'ssleep'? [-Werror=implicit-function-declaration]
    1847 |    fsleep(ddata->cfg.srst_udelay);
         |    ^~~~~~
         |    ssleep
   cc1: some warnings being treated as errors
   make[3]: *** [/builds/linux/scripts/Makefile.build:262: drivers/bus/ti-sysc.o] Error 1
----->8-----

This is with the following configurations:
* clang-17-defconfig
* clang-17-lkftconfig
* clang-17-lkftconfig-no-kselftest-frag
* clang-17-omap2plus_defconfig
* clang-lkftconfig
* clang-nightly-defconfig
* clang-nightly-lkftconfig
* clang-nightly-lkftconfig-kselftest
* clang-nightly-omap2plus_defconfig
* gcc-8-defconfig
* gcc-8-omap2plus_defconfig
* gcc-10-lkftconfig
* gcc-10-lkftconfig-debug
* gcc-10-lkftconfig-debug-kmemleak
* gcc-10-lkftconfig-kselftest-kernel
* gcc-10-lkftconfig-libgpiod
* gcc-10-lkftconfig-perf-kernel
* gcc-10-lkftconfig-rcutorture
* gcc-12-defconfig
* gcc-12-lkftconfig
* gcc-12-lkftconfig-debug
* gcc-12-lkftconfig-debug-kmemleak
* gcc-12-lkftconfig-kasan
* gcc-12-lkftconfig-kselftest
* gcc-12-lkftconfig-kunit
* gcc-12-lkftconfig-libgpiod
* gcc-12-lkftconfig-no-kselftest-frag
* gcc-12-lkftconfig-perf
* gcc-12-lkftconfig-rcutorture
* gcc-12-omap2plus_defconfig

A reproducer:

   tuxmake --runtime podman --target-arch arm --toolchain gcc-12 --kconfig defconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


Greetings!

Daniel Díaz
daniel.diaz@linaro.org


