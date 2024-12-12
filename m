Return-Path: <stable+bounces-103907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1929EFA60
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 19:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87A8E28D351
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADE6231A3A;
	Thu, 12 Dec 2024 18:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hvBlVNQY"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8FB23098A
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 18:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026725; cv=none; b=sjHRaHyRcQkBZq97zWTwNs4o3xkFKgO0zvIF+T5bpuuDcu5ct0w3NW8L5CjgaCoOQfGT7cmkGcW6zDFuybqaOh7GymuJLVSvfbOlCdf8WJEP/VvOYBi9bf5+j5edV2jMPvHseHfrtdTN6/RT9RTjgECNjtX57sig+M7vqoXvF+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026725; c=relaxed/simple;
	bh=GnTV6Da5YELPXMcORuq9yXyw8ZWX24rsUjlfFf5wTMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a2MoVoIejcjbMTeh9rGkXNiWzjOh2sMn+xiQ2hWxSVGFxB29QbjiDTaThNiuFrW9/MppRa1vpXrRWJrTOFWKmwnhmr/7KgtsTozlmd8bUH36fNGq4a92N5AHFVgYfqhOZ41w08Hq00frGVX7mtCyr/6WpgvaEIuvbc1GuUzDzyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hvBlVNQY; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6d91653e9d7so8985696d6.1
        for <stable@vger.kernel.org>; Thu, 12 Dec 2024 10:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734026722; x=1734631522; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0ACbT2hrUAn63fc+9lLjJy9djGKWLbWmKIxJyevbg8Q=;
        b=hvBlVNQYJGcWRJLpa2eP1TY6zv3u1HTv5pfRvvXV5ZCETQGtqmkawsHLAXZYphAHmk
         LzLkcSpPXCFFPAc9dO/LtZ0jJeBSqmBV54WBmLC6qZRemJrTKA9Xm0BHn1hRdEFpmKF6
         zv8N5l5zGItEr/W0LnI3bTB4N4M6Ad9EZ3TGNO63WgwXmEfB8f+sBKEEBOS/BxspLZAe
         8T60jnymhiOjk1WaiMFDB4VxV0FjUwNotaU9djgI6pow73wEeOgTdfcNEfqz1n6luNq+
         vYtbOsLFKCGqT2WUqXjvBFzr9iKUOb7748rNiV+gJrBeHHHmUuSqYN18fMWgbmG+Td+V
         17Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026722; x=1734631522;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ACbT2hrUAn63fc+9lLjJy9djGKWLbWmKIxJyevbg8Q=;
        b=rOYRUBoEsnIFZxitzmO2E38LUqLTpGgC0fvegnfvp/D1KkEm4yEeQ6K1u5gebxiCfB
         Hz9k9qi/SV/fLX6whUSlxDDk1Q/D4U3Ks9hxf/nauAHGEszURz6kTyyoMY1x65jEcaBk
         MD151/v6/Xbu1GVAXEPJFXCjkcRBqVqTmMTNtQN7Olp6sKywYG3u0XzXPxIkBICJZZAV
         Vz+dM7UUwtpac137wUTOJZXFPkd6Wp0Mv59UdtWpR2f32Ng+Vv9o7zS7ZlyGx43M+oks
         q6dCW63gxjOYfwpEDJ8xgxCO4C6TiO5Zf/FGugwqp27BXENcIQ8ToSVbVmJVZP+UX240
         B7/Q==
X-Gm-Message-State: AOJu0Yxmk5I6A74Yhz1qPtIVQBpwunFAADmL5dMKv62P4/BoLCgBq7dR
	vOwXY+pIf5YiKfWsxBhDHcxfAHzu+oRFPe1usyymZod5n61u0iGd0yqlnbV5OYL3SKzSrbmpq0s
	XsD5vAvBukwUt0QeOML/yf8/bB7gBZx4Z+0gLJw==
X-Gm-Gg: ASbGncsO0FqpWsL6P8ic98+tfmypD+9g43yIOfO0Z4ChNg7N4stV5yXHuoFr4ukJUCq
	FLoz3E+X1HnP2/2vNCHeKKv428kx/6olb3bs7
X-Google-Smtp-Source: AGHT+IHG/uFO/ewrJZj42vcEKEa3DNJ0EvDn2NCbKG87UO1uP4jMl3G4T3F9G2Z6947ZPgYyKqumWNWDItutLlRMg3k=
X-Received: by 2002:ad4:4ee6:0:b0:6d8:a1b4:b591 with SMTP id
 6a1803df08f44-6db0f77b2f3mr18289156d6.23.1734026722575; Thu, 12 Dec 2024
 10:05:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212144306.641051666@linuxfoundation.org>
In-Reply-To: <20241212144306.641051666@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 12 Dec 2024 23:35:11 +0530
Message-ID: <CA+G9fYuX2BsEOCZPC+2aJZ6mEh10kGY69pEQU3oo1rmK-8kTRg@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/466] 6.12.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Dec 2024 at 20:30, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.5 release.
> There are 466 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 14 Dec 2024 14:41:35 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.5-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The riscv builds failed on Linux stable-rc linux-6.12.y due to following build
warnings / errors.

riscv:
  * build/gcc-13-defconfig
  * build/clang-19-defconfig
  * build/clang-nightly-defconfig
  * build/gcc-8-defconfig

First seen on Linux stable-rc linux-6.12.y v6.12.4-467-g3f47dc0fd5b1,
  Good: v6.12.4
  Bad:  6.12.5-rc1


Build log:
-----------
kernel/time/timekeeping.c: In function 'timekeeping_debug_get_ns':
kernel/time/timekeeping.c:263:17: error: too few arguments to function
'clocksource_delta'
  263 |         delta = clocksource_delta(now, last, mask);
      |                 ^~~~~~~~~~~~~~~~~
In file included from kernel/time/timekeeping.c:30:
kernel/time/timekeeping_internal.h:18:19: note: declared here
   18 | static inline u64 clocksource_delta(u64 now, u64 last, u64
mask, u64 max_delta)
      |                   ^~~~~~~~~~~~~~~~~
make[5]: *** [scripts/Makefile.build:229: kernel/time/timekeeping.o] Error 1

Links:
-------
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12.4-467-g3f47dc0fd5b1/testrun/26281169/suite/build/test/gcc-13-defconfig/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12.4-467-g3f47dc0fd5b1/testrun/26281169/suite/build/test/gcc-13-defconfig/history/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12.4-467-g3f47dc0fd5b1/testrun/26281169/suite/build/test/gcc-13-defconfig/details/

Steps to reproduce:
------------
# tuxmake --runtime podman --target-arch riscv --toolchain gcc-13
--kconfig defconfig

metadata:
----
  git describe:  v6.12.4-467-g3f47dc0fd5b1
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git sha: 3f47dc0fd5b11e6655e9fa78a350d64c0a3d53d3
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2q7Ekivz3juYAyrxbUVAOGrVOAe/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2q7Ekivz3juYAyrxbUVAOGrVOAe/
  toolchain: gcc-13 and clang
  config: gcc-13-defconfig
  arch: riscv


 --
Linaro LKFT
https://lkft.linaro.org

