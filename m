Return-Path: <stable+bounces-131789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF901A80FFD
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 17:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C5313AB7C4
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 15:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1DD229B21;
	Tue,  8 Apr 2025 15:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SlBgCIex"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0600D22B8A1
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 15:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744125779; cv=none; b=VaJYCGi0UNhYoQRvhDK3LQhx3oXdx3uaOOXBrviMvT38PA87djlzicHKDP4SvxIhQ5KjNGNok3PB4h5gRBROIhuHdyimJnCbOLGj9919j4pw6rWndhsnnAq5c1rba4sD271lot3G2NL/c6C794X0KIrI7G/OsOqKEZLGUCxAxUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744125779; c=relaxed/simple;
	bh=3lpzITRPn00lYD/ndslRx6AUWRX254zjphl4pSWfNo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hyinWcaAZEIo/mw43J9msGh0a+hWIFjUlZN98NiX/8BEvApoLAi/cRCi5XI5SppFZeh2PW7M5SSuTt0ekYuZvsOJxwBjQlFO9Ewkd1I2QfjaO3GhieWcLF7iHwSOhYX08dJZX/4dMFX/yoStklwFwVW1njetrdabWzpLuYbmSa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SlBgCIex; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-86d377306ddso2457418241.2
        for <stable@vger.kernel.org>; Tue, 08 Apr 2025 08:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744125776; x=1744730576; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cxg9LKA6+kQvyEUrjxprc+UTcXgCvZJ1Wa5TchzdHtU=;
        b=SlBgCIexBNg9JgdgukxvMc1NlzxmsmSjw6EvTBALeRrNjiCk3Mxi4hkMsJe9a5qHOF
         kbjl1k7uapT68wIzrr8tsbYsbkVa50oO78+I89U/675QSAYWqCuWqwBBJr8sVcd2quoZ
         5s/ajZc6KiJdtb1VSyLeoa4nB2vOAmc5Ohh1RlqF8MeRGVI9WiHvZmgCTsXTDFhdtdzK
         XAOr7FvO7ga1JEPnKcP79qQ0FI3LNWBisPb3iCy22tsBCEOXT1U26YrZ40ZKCpVk8jez
         dmQByVz3nHS1xozJQjOzplaxUYj8A2B7XiyQnXMUrrEC3EFmCQ+lSgv7mPSsiWZl1BE/
         4wRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744125776; x=1744730576;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cxg9LKA6+kQvyEUrjxprc+UTcXgCvZJ1Wa5TchzdHtU=;
        b=pB9JrDE9DuHojukBWom+QuxA9ZC/u/38O7XMiWKRztF2wNzcPnHgbfvmpDIP8fMXlm
         /u2wfwQGl90sUToUv8b0SyJRrUvDP9XQ/knlP4qK9BTAoNdwXzoseZTgr4LpWS/HBKRX
         GpYyw1KsFQXY7r/8j9Vocy4smThP+Rig7+XOwGQODfFYLC4Qs5ZXPX9PEd5b2LfiQoVO
         VQCm2nQxNU5aTvyrQMrOUhiqK1RTfiQEBgOECke5Zn5pIh6LoyUb7Y1MT3sUeAK4bjev
         KJo56urrrxkO6nBeHz/K/NkvY3m//0ljzniLTaehUxaOmCWsOFAkjDi1XlCh+lZE9dOm
         S2Cw==
X-Gm-Message-State: AOJu0Yx55mkYyqvMWG38NCNHAM8nIwACcmyFKozcqJvbWlFFlCPn2SQs
	PsdVzr3yRRsnpk9/mkgcvoCS0XZazgBvNcUYWcc4rwqOEkNc+VpKU2IKfR2t6WYivK+u95oOuX1
	0sAki4+RqubO5S7cI4l3F8F97lCooWWc04oSp9g==
X-Gm-Gg: ASbGncv0xYx0QW39FLPFzX+sPiqewrwTSq0RQ9sOfLjdYYpXLPFQfHLbCN7ZZz6RMgZ
	Kx4zxZYayHf55EyZgFkJDtO0gnZ0IJAmyO5qmBZtNqRvLNXqPpTiiVStpwv/jcHN5jFCg83v5Pp
	Ecl5+LNkpOdBLMveja2g2QmLIbPliK60jk+5zSPWNagVArCpKo0l/keLwn23UGwLLcHjM=
X-Google-Smtp-Source: AGHT+IEtePmmvCUqzXP4fQmhOiQg0gVcd3/T0A8xgplxbFp6FtfV9GDDW+Rjpln3N7ol4Kj4hD73PnpvQwrVCf9mnBM=
X-Received: by 2002:a05:6122:1d0a:b0:520:4996:7d2a with SMTP id
 71dfb90a1353d-527730f997amr9204517e0c.10.1744125775647; Tue, 08 Apr 2025
 08:22:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408104914.247897328@linuxfoundation.org>
In-Reply-To: <20250408104914.247897328@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 8 Apr 2025 20:52:44 +0530
X-Gm-Features: ATxdqUEXqLGH0AeyqvbH4fTDpyq3lu_NpjMbeRtitNjowMQG1rjdctxiPvSjWaY
Message-ID: <CA+G9fYu_OLOYK_+X6urte_9VA4jye7_GcTbDd1GzjnBB1VYtKg@mail.gmail.com>
Subject: Re: [PATCH 6.14 000/731] 6.14.2-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Apr 2025 at 16:36, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.14.2 release.
> There are 731 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 10 Apr 2025 10:47:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.14.2-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

1)
Regressions on arm64, 390 tinyconfig, allnoconfig builds with clang-20
and gcc-13 on the stable-rc 6.14.

2)
Regressions on arm, arm64 rustclang-lkftconfig-kselftest builds with
clang-20 and gcc-13 on the stable-rc 6.14.

First seen on the 6.14.2-rc1
Bad: v6.14.1-732-gabe68470bb82
Good: v6.14.1

* arm64 and s390, build
 - build/gcc-13-tinyconfig
 - build/clang-20-tinyconfig

* arm and arm64, build
 -  build/rustclang-lkftconfig-kselftest

Regression Analysis:
- New regression? Yes
- Reproducibility? Yes

Build regression: arm64 s390 tinyconfig undefined reference to
`dl_rebuild_rd_accounting'
Build regression: arm64 arm rust pci.rs cannot find type `Core` in
module `device`

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

1)
## Build log
aarch64-linux-gnu-ld: kernel/sched/build_utility.o: in function
`partition_sched_domains_locked':
build_utility.c:(.text+0x3668): undefined reference to
`dl_rebuild_rd_accounting'
build_utility.c:(.text+0x3668): relocation truncated to fit:
R_AARCH64_CALL26 against undefined symbol `dl_rebuild_rd_accounting

2)
## Build log rust
error[E0412]: cannot find type `Core` in module `device`
  --> /builds/linux/rust/kernel/pci.rs:69:58
   |
69 |         let pdev = unsafe { &*pdev.cast::<Device<device::Core>>() };
   |                                                          ^^^^ not
found in `device`


## Source
* Kernel version: 6.14.2-rc1
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* Git sha: abe68470bb82714d059d1df4a32cb6fd5466dc0e
* Git describe: v6.14.1-732-gabe68470bb82
* Project details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.14.y/build/v6.14.1-732-gabe68470bb82/

## Test
* Build log: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.14.y/build/v6.14.1-732-gabe68470bb82/testrun/27939968/suite/build/test/gcc-13-tinyconfig/log
* Build details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.14.y/build/v6.14.1-732-gabe68470bb82/testrun/27939968/suite/build/test/gcc-13-tinyconfig/details/
* Build history:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.14.y/build/v6.14.1-732-gabe68470bb82/testrun/27939968/suite/build/test/gcc-13-tinyconfig/history/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2vReGJ6wjd1n99Nsg9WaH58qupU/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2vReGJ6wjd1n99Nsg9WaH58qupU/config
* Build rust history:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.14.y/build/v6.14.1-732-gabe68470bb82/testrun/27940128/suite/build/test/rustclang-lkftconfig-kselftest/history/
* Build rust details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.14.y/build/v6.14.1-732-gabe68470bb82/testrun/27940128/suite/build/test/rustclang-lkftconfig-kselftest/details/
* Build rust log:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.14.y/build/v6.14.1-732-gabe68470bb82/testrun/27940128/suite/build/test/rustclang-lkftconfig-kselftest/log

## Steps to reproduce
 - tuxmake --runtime podman --target-arch arm64 --toolchain gcc-13
--kconfig tinyconfig

--
Linaro LKFT
https://lkft.linaro.org

