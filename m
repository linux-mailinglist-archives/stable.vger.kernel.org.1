Return-Path: <stable+bounces-160395-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D8BAFBADD
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 20:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D47834267C4
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 18:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF385262FD9;
	Mon,  7 Jul 2025 18:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tM4l6M15"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2542638B2
	for <stable@vger.kernel.org>; Mon,  7 Jul 2025 18:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913286; cv=none; b=lomf3m9HwZn0v53UnTrIRdRM/ustIdBZdvQ5DSNl/5xE8zISCeMT+RR98YV+srfhNhY4m5Z9NYcj5GoLbqO1v4dTG2KEGJP5s+9Ef/fPP+MCPQzEY69UHJf67Emuk8ENF7AmatQKkaF6FKJHpdXbfHxJUCgRdDZsVZx0vqvNWY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913286; c=relaxed/simple;
	bh=Um0oYyu7k4JpYbGqbsldakoUc2EQjiRUa3q9O9boM4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TOTvhp54vGTfz+HIKMQDu4FuQREiy3sjfEYXS6i9ibBv6dkLbDv03vwZ8jZRSCbsGf/nIscj4ZLt6bl0Fjug7b6EN9tZuNow9gpUHlg85TIy9Y74IUxhtZW7rxgq0gQFqgth6xkBcVqFcpJJWwFkPEb/FugHYwK4Yz6rt3Zc4jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tM4l6M15; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-313a188174fso3712789a91.1
        for <stable@vger.kernel.org>; Mon, 07 Jul 2025 11:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751913284; x=1752518084; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WcBksvQbypHtiAeUZ4HW01cr+T4SMyo2vgYr43Sj8Zg=;
        b=tM4l6M15lOz6P1ghCTssMKM/NAioUUWto/ecX5m0U+xzLQ9FFemIdUGrIZgrJ+MD8J
         vYQrHlpdtoybV+JZkfifhn/KR8V59ZVP4ivwXNx2JZXRKg5nbHtoLlx4pSWRGTj1C5sJ
         Orjc/EGnxFshjmhptGE4fM+KtAKlpeGFkN+WPPDSRg8JbK8RBgS1Zm+XAk9QqGZwqetr
         1OqToKD6FaTbCVoutpPEnMK0FNK1pdL1JWBShXm9SNW234jPCS/+S8NDCWsdUo23+2CB
         6Pa6MA203dVKMErrL1liBY93JvSSE69xQZZu6R34Vkc1+7H+sbnICZEn3zWq6ax/gvyf
         h72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751913284; x=1752518084;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WcBksvQbypHtiAeUZ4HW01cr+T4SMyo2vgYr43Sj8Zg=;
        b=UX4MdoeB/w8SkzhUlR1TMfgsEF821KmJ8rujCqSU6yASrFtzgfPJoMgkUo2t5/73Lh
         0rpEZMjtUlB7N4yvdmO3l1e7Xw+n3KamepMjppuq08g6NPTZiQzgF2GxN0ZfzeQFRwN4
         SVuQWQtqeEYGAtP/HHxxHsMnVDcTqbCnrpXZEYMB+jZF+83IYZZuIjxHLR2sizdDq6vc
         r020At6g8Hd2g4SePCjxY73nBvlfjpX2ndOjKvbb5uLH8EroGGUF30QIp3/aFoCfCu+o
         pTqEObR+CygYRs0IOAAFfc9xEiMVZuS5btGLvNl5wsZAVx9wKX5ODNBE1pdwnbgpeCpo
         3AYw==
X-Gm-Message-State: AOJu0YwoD7/NqdI3Sa31sO6PrCFey/tJ7Xt8sznIqhHKNrxL4cAiCn2S
	ZEOHI9RJRM79nK1DKgC236fSylHaP5pccrImYGBqCdpfuGNlv5kJ5B84hggCZaYJOaKJee0yPP8
	5887nUnTQsIrEPKzOqizJPoZ+K8nRh64XEsfYs2DOAg==
X-Gm-Gg: ASbGncvfclGG3Q5gOkYbnJcm3eRzEHoUTmU2N62tr5Aktk3lPGrr3GdtS2mNTNLfI6L
	sxWAbGsQRSPprZWH1HtXcHSw3J8E4uD1Tzzuh9SB2svyTbK5sNad2uIiRE/ImjHi/YMNBifucBA
	2Ly1xw989Znx+fKmBajiDZ8ElSNOa2o+sx3nbZQhS+VyWt9GoVGBN/twICkULPubSowiGN89Grq
	NK1
X-Google-Smtp-Source: AGHT+IF4DHMtu/8XzqyyjksrX7oYkB2E3adFdnp5Z4MPmxgZAGZEnl1dF828ysLD318xNtfPVJSGgCHuAZthONd3KV4=
X-Received: by 2002:a17:90b:3dc8:b0:312:e73e:cded with SMTP id
 98e67ed59e1d1-31c20ee73bamr657740a91.16.1751913283927; Mon, 07 Jul 2025
 11:34:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704125604.759558342@linuxfoundation.org> <CA+G9fYvidpyHTQ179dAJ4TSdhthC-Mtjuks5iQjMf+ovfPQbTg@mail.gmail.com>
In-Reply-To: <CA+G9fYvidpyHTQ179dAJ4TSdhthC-Mtjuks5iQjMf+ovfPQbTg@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 8 Jul 2025 00:04:32 +0530
X-Gm-Features: Ac12FXw91HKsheSK6jhmieYW1joU8vjVobkJPgsXFAIzdUhWT_mURweSl-tFB_Q
Message-ID: <CA+G9fYub_Ln=EPp2mgL4-2ewvorZ6O7btM97Ka6RrWhO1o0Liw@mail.gmail.com>
Subject: Re: [PATCH 6.15 000/263] 6.15.5-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Anders Roxell <anders.roxell@linaro.org>, jakub.lewalski@nokia.com, 
	Elodie Decerle <elodie.decerle@nokia.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 6 Jul 2025 at 15:50, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Fri, 4 Jul 2025 at 20:14, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.15.5 release.
> > There are 263 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sun, 06 Jul 2025 12:55:09 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.5-rc2.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.15.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
> Approximately 20% of devices are experiencing intermittent boot failures
> with this kernel version. The issue appears to be related to auto login
> failures, where an incorrect password is being detected on the serial
> console during the login process.

Reported issue is also noticed on Linux tree 6.16-rc5 build.

> We are investigating this problem.
>
> Test environments:
>  - dragonboard-410c
>  - dragonboard-845c
>  - e850-96
>  - juno-r2
>  - rk3399-rock-pi-4b
>  - x86
>
> Regression Analysis:
> - New regression? Yes
> - Reproducibility? 20% only
>
> Test regression: 6.15.5-rc2 auto login failed Login incorrect
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> ## log in problem
>
> runner-ns46nmmj-project-40964107-concurrent-0 login: #
> Password:
> Login incorrect
> runner-ns46nmmj-project-40964107-concurrent-0 login:
>
> * log 1: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.15.y/build/v6.15.4-264-gf6977c36decb/testrun/29021685/suite/boot/test/clang-20-lkftconfig/log
> * log 2: https://qa-reports.linaro.org/api/testruns/29021720/log_file/
> * Boot test: https://regressions.linaro.org/lkft/linux-stable-rc-linux-6.15.y/v6.15.4-264-gf6977c36decb/boot/clang-20-lkftconfig/
> * LAVA jobs 1: https://lkft.validation.linaro.org/scheduler/job/8344153#L1186
> * LAVA jobs 2: https://lkft.validation.linaro.org/scheduler/job/8343870#L1266
>
> ## Build
> * kernel: 6.15.5-rc2
> * git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> * git commit: f6977c36decb0875e78bdb8599749bce1e84c753
> * git describe: v6.15.4-264-gf6977c36decb
> * test details:
> https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.15.y/build/v6.15.4-264-gf6977c36decb
>
> ## Test Regressions (compared to v6.15.3-590-gd93bc5feded1)
> * dragonboard-410c, boot
>   - clang-20-lkftconfig
>   - clang-nightly-lkftconfig-kselftest
>   - gcc-13-lkftconfig-debug
>
> * dragonboard-845c, boot
>   - clang-20-lkftconfig
>   - korg-clang-20-lkftconfig-lto-thing
>
> * dragonboard-845c-compat, boot
>   - gcc-13-lkftconfig-compat
>
> * e850-96, boot
>   - gcc-13-lkftconfig-no-kselftest-frag
>
> * juno-r2, boot
>   - clang-20-lkftconfig
>   - gcc-13-lkftconfig-debug
>   - gcc-13-lkftconfig-kselftest
>
> * rk3399-rock-pi-4b, boot
>   - clang-20-lkftconfig
>
> * x86, boot
>   - clang-20-lkftconfig
>   - clang-20-lkftconfig-no-kselftest-frag
>   - clang-nightly-lkftconfig-kselftest
>   - clang-nightly-lkftconfig-lto-thing
>   - gcc-13-defconfig-preempt_rt
>   - gcc-13-lkftconfig-no-kselftest-frag
>
> ## Metric Regressions (compared to v6.15.3-590-gd93bc5feded1)
>
> ## Test Fixes (compared to v6.15.3-590-gd93bc5feded1)
>
> ## Metric Fixes (compared to v6.15.3-590-gd93bc5feded1)
>
> ## Test result summary
> total: 259237, pass: 235906, fail: 6376, skip: 16955, xfail: 0
>
> ## Build Summary
> * arc: 5 total, 5 passed, 0 failed
> * arm: 139 total, 138 passed, 1 failed
> * arm64: 57 total, 57 passed, 0 failed
> * i386: 18 total, 18 passed, 0 failed
> * mips: 34 total, 27 passed, 7 failed
> * parisc: 4 total, 4 passed, 0 failed
> * powerpc: 40 total, 39 passed, 1 failed
> * riscv: 25 total, 25 passed, 0 failed
> * s390: 22 total, 22 passed, 0 failed
> * sh: 5 total, 5 passed, 0 failed
> * sparc: 4 total, 3 passed, 1 failed
> * x86_64: 49 total, 49 passed, 0 failed
>
> ## Test suites summary
> * boot
> * commands
> * kselftest-arm64
> * kselftest-breakpoints
> * kselftest-capabilities
> * kselftest-cgroup
> * kselftest-clone3
> * kselftest-core
> * kselftest-cpu-hotplug
> * kselftest-cpufreq
> * kselftest-efivarfs
> * kselftest-exec
> * kselftest-fpu
> * kselftest-ftrace
> * kselftest-futex
> * kselftest-gpio
> * kselftest-intel_pstate
> * kselftest-ipc
> * kselftest-kcmp
> * kselftest-kvm
> * kselftest-livepatch
> * kselftest-membarrier
> * kselftest-memfd
> * kselftest-mincore
> * kselftest-mm
> * kselftest-mqueue
> * kselftest-net
> * kselftest-net-mptcp
> * kselftest-openat2
> * kselftest-ptrace
> * kselftest-rseq
> * kselftest-rtc
> * kselftest-rust
> * kselftest-seccomp
> * kselftest-sigaltstack
> * kselftest-size
> * kselftest-tc-testing
> * kselftest-timers
> * kselftest-tmpfs
> * kselftest-tpm2
> * kselftest-user_events
> * kselftest-vDSO
> * kselftest-x86
> * kunit
> * kvm-unit-tests
> * lava
> * libgpiod
> * libhugetlbfs
> * log-parser-boot
> * log-parser-build-clang
> * log-parser-build-gcc
> * log-parser-test
> * ltp-capability
> * ltp-commands
> * ltp-containers
> * ltp-controllers
> * ltp-cpuhotplug
> * ltp-crypto
> * ltp-cve
> * ltp-dio
> * ltp-fcntl-locktests
> * ltp-fs
> * ltp-fs_bind
> * ltp-fs_perms_simple
> * ltp-hugetlb
> * ltp-math
> * ltp-mm
> * ltp-nptl
> * ltp-pty
> * ltp-sched
> * ltp-smoke
> * ltp-syscalls
> * ltp-tracing
> * modules
> * perf
> * rcutorture
> * rt-tests-cyclicdeadline
> * rt-tests-pi-stress
> * rt-tests-pmqtest
> * rt-tests-rt-migrate-test
> * rt-tests-signaltest
>
> --
> Linaro LKFT
> https://lkft.linaro.org

