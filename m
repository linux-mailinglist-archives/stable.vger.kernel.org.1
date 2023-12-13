Return-Path: <stable+bounces-6566-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0BF810A3E
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 07:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55F5C281CED
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 06:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE0DFBE5;
	Wed, 13 Dec 2023 06:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zZoQYcFf"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BECAD
	for <stable@vger.kernel.org>; Tue, 12 Dec 2023 22:26:43 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-7cac4a9c5b5so1635724241.1
        for <stable@vger.kernel.org>; Tue, 12 Dec 2023 22:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702448802; x=1703053602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ryCEu48eUmxPP9GQqL9AHFaoE514bwONp0zHyCua5pk=;
        b=zZoQYcFfHnLLWKY/HGeqmE2tiMDdR0mbUB5XKN7Ia4KOeMYnLkk57Bqi1QRnDieF3w
         qxIjx+BYgToh9PzVCu6p8dCNNWLa0oXsr6AsrnBHqYcNNyDriAz/galpr3AByXzi6Pqd
         8N+SzXl+0De7BDuIfTi0eL6RzlEEiZycJpFaDZhN4WdXKXv+0rnPznrUsE/UNS3nCV5w
         W645phMCSOzYn0XFHjm36ksajmcp95fO2wDLoCawNSmWbrxG0COr8gNJ9gTLXxJ0CJVE
         oAhTJQ/CLyqQgBDBfGyovh1tygoTtSxI4DMhWdhkqjaTlbPeYJSMRIVNfix2D4hGRW3D
         jL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702448802; x=1703053602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ryCEu48eUmxPP9GQqL9AHFaoE514bwONp0zHyCua5pk=;
        b=Q9PwAF2UNLwj7OJKYViehlrdjWCXu4qYxx8xp/Fh/s+2TXGx/7C9JEneIMLHBrOvch
         cwke7+Ba5R+cpVj0Ll/+hHrE6ad3lj9KxfAhJF/3aObmdDJe9b3MKiWb7pBUb38mkvNz
         bpLBp8nxb2z4EU0KmGLWEJyfXFHMQOAG27OhLP/aQLW51RFyEQJBvp0c+cpeUMf7G7ZX
         gHX8bZ7mTWHnAk+3n4j8FKzgRJjpDEHR5xWmw2+YizJjsYkI+kOf12qc/aiwHw5i3b0S
         IysY/tDYx30wJZJE8UB0BrcFtRctc+lJYxJGrmxJ1bi1uq7qpZFOZ6+d7paTa+5DBp7G
         HHqg==
X-Gm-Message-State: AOJu0YxnELYHn5Pyn72lyX2dFHKsiNaX9+x5/fJEsO/MdLKQROcKoArv
	GG63Pu5Uw+BI7s2uIFIuZP0FHSOsF17P+tA45hUDHg==
X-Google-Smtp-Source: AGHT+IE3A8Ed8eaDWU5zKh/jzWxbUFJO8WH0pwo+X34lGkKWDhF8k9z1qeRJ5iKHhBajzWLC1POJ7NRiZRinHLbkW0E=
X-Received: by 2002:a05:6102:510a:b0:462:8ca2:1bb0 with SMTP id
 bm10-20020a056102510a00b004628ca21bb0mr5336003vsb.20.1702448801091; Tue, 12
 Dec 2023 22:26:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212120154.063773918@linuxfoundation.org>
In-Reply-To: <20231212120154.063773918@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 13 Dec 2023 11:56:30 +0530
Message-ID: <CA+G9fYsprWr-ZcSE_bAvuXA-sXbQwgjLJUcP0i-6QB5FGbKDVA@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/53] 4.19.302-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 12 Dec 2023 at 17:35, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.302 release.
> There are 53 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 14 Dec 2023 12:01:29 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.302-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.19.302-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.19.y
* git commit: a7780f896379de16bc4e805ecf216959b5b876a4
* git describe: v4.19.301-54-ga7780f896379
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19=
.301-54-ga7780f896379

## Test Regressions (compared to v4.19.301)

## Metric Regressions (compared to v4.19.301)

## Test Fixes (compared to v4.19.301)

## Metric Fixes (compared to v4.19.301)

## Test result summary
total: 55035, pass: 46309, fail: 1569, skip: 7122, xfail: 35

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 111 total, 105 passed, 6 failed
* arm64: 37 total, 32 passed, 5 failed
* i386: 21 total, 18 passed, 3 failed
* mips: 20 total, 20 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 24 total, 24 passed, 0 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 31 total, 26 passed, 5 failed

## Test suites summary
* boot
* kselftest-android
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-drivers-dma-buf
* kselftest-efivarfs
* kselftest-filesystems
* kselftest-filesystems-binderfs
* kselftest-filesystems-epoll
* kselftest-firmware
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-ipc
* kselftest-ir
* kselftest-kcmp
* kselftest-kexec
* kselftest-kvm
* kselftest-lib
* kselftest-membarrier
* kselftest-memfd
* kselftest-memory-hotplug
* kselftest-mincore
* kselftest-mount
* kselftest-mqueue
* kselftest-net
* kselftest-net-forwarding
* kselftest-net-mptcp
* kselftest-netfilter
* kselftest-nsfs
* kselftest-openat2
* kselftest-pid_namespace
* kselftest-pidfd
* kselftest-proc
* kselftest-pstore
* kselftest-rseq
* kselftest-rtc
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-splice
* kselftest-static_keys
* kselftest-sync
* kselftest-sysctl
* kselftest-tc-testing
* kselftest-timens
* kselftest-user
* kselftest-vm
* kselftest-zram
* kunit
* log-parser-boot
* log-parser-test
* ltp-cap_bounds
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-crypto
* ltp-cve
* ltp-fcntl-locktests
* ltp-filecaps
* ltp-fs
* ltp-fs_bind
* ltp-fs_perms_simple
* ltp-fsx
* ltp-hugetlb
* ltp-io
* ltp-ipc
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-securebits
* ltp-smoke
* ltp-syscalls
* ltp-tracing
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

