Return-Path: <stable+bounces-57974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2521926808
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 20:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 119CF1C2131C
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 18:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A89C18732D;
	Wed,  3 Jul 2024 18:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="llSk4iQD"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574EA186E2D
	for <stable@vger.kernel.org>; Wed,  3 Jul 2024 18:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720030969; cv=none; b=oAjXw8ybX9sTaNX8PKgh3XWCl+pM08gnF2xdJAKTbuEjprBEWWFVjDeZIC5eG/olll7KsxoEI03ftr+esMIJmjRjKhzxAjymkTxHJXGvsilw8OfxXk0LmHyiL4ECAjeized1/IHyw+I2AByWYzGqyMYhexWvQssG88qZn44qRbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720030969; c=relaxed/simple;
	bh=/VpfopDdBJqybxcmcYuCrbmMEGO159jxoReMIiv7UxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eHNbi9xo/I/CTiw0RKyWQxo1WfbJJMKmcYijDJDAdy2H3mqsQccoJEDNmoiR+zNhTecHXX24WbaZ1CHmzcPnqwTh4pdgACQGv2X4wdkWOg2GaXZyBRe/C9KksDAg8cCDdbdtkIRmaAWU9v7sxwNEbddrA6xjpE2jid+fgV6oyF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=llSk4iQD; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-48f96098653so1490628137.3
        for <stable@vger.kernel.org>; Wed, 03 Jul 2024 11:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720030967; x=1720635767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lutnZZkFQNrPT1eWeDjIvCFMR4EQlZRCPH9vYtM3N5Y=;
        b=llSk4iQDCh8RWzORTtn1vGV/XbqM4H4IHGVqiBbM0fC0Bos8IslUwV/qJJ1AlYSOtE
         r4Stg/D7kfCuu7OiHL/lk6iX8UQIdFIw4piizW2h0rdkO7gBE5l5mFkXqOXsp7jyZ3Jt
         BEugU6sDvKiRE5UkUC30dWqbl9Ys0J/rT8+LGphz5wYU3lG64FBv8nJT6pV6O4MmrdAQ
         7HEJfuW3fS/MQwkWD4QeA2dyf0fy4xbcnz2L7SoW3zm59ca8j59bMlY5OYE2ej4BUqu5
         rA6F03goao3Ui+RZokTY1F+dlUPTtNk4cj1eByhl08IHeEI4VmLx6Iknz0XCiLtUjaW+
         xCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720030967; x=1720635767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lutnZZkFQNrPT1eWeDjIvCFMR4EQlZRCPH9vYtM3N5Y=;
        b=v6V7hCqULnWWX8E+W3Gi5wpdhhPqfOoWhC8A9oJvgxKC5wDiS6byHcH+PIqieJ01oq
         1JkppjXI3ddziA/t2Az8bd3Axia0lJ+KAmYVX/a/Oz1g7o9eFypVz6JCz7uNdnmoE8XC
         bpqTlwCcDA5ghOoOU0MjKEuJ/q+9Gz1OoVTTeIz8+lRhZwoCwBcZOfNzSU3EhqIwKLOb
         fh6WhVvAu1THc9rLrrhiBq25NIPrcwWVtmoIMOu9l3C7/cDwPH/VfpfBXELPNgIcKOic
         LmG5GXKoqS7BnEq4DrUab1uAAFuMu9qV/wEqKIZShYKJCQbkNdHyGf3zdMY1m219pOKR
         jidg==
X-Gm-Message-State: AOJu0Yx+5ziq5lTsFwmgq/kmnU3TGCAePyTTrfz25MBzItzH+i5TPXbD
	JUvR6C4sZcz2BeCASuGngfzZxGiCWLCz3RzPUjGVEUt4XQuuDezOv81CaZaw/gdC/B7m1Lkg6BN
	vx3OSu/wvXY/+Cllxh1z/gaqfTQo/adcucowOGg==
X-Google-Smtp-Source: AGHT+IFpo8fAUFUxFe0XR29oyqi5sap+b0XoPBzzgzJgzGnPTgyl68a3ag8cVeM9fud5rxa6d6z4HiMdoyBo7onLUX8=
X-Received: by 2002:a05:6102:549e:b0:48f:1bc6:345c with SMTP id
 ada2fe7eead31-48faf06a80bmr11310839137.14.1720030967212; Wed, 03 Jul 2024
 11:22:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702170226.231899085@linuxfoundation.org>
In-Reply-To: <20240702170226.231899085@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 3 Jul 2024 23:52:36 +0530
Message-ID: <CA+G9fYvvPTUkjTukNZ+Y0Cm5QdHocv1qHFzZkkB0mL86yPj1iA@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/128] 6.1.97-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2 Jul 2024 at 22:59, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.97 release.
> There are 128 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 04 Jul 2024 17:01:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.97-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.1.97-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 54f35067ea4e1147c1351417237ab846a0b37ed9
* git describe: v6.1.96-129-g54f35067ea4e
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.9=
6-129-g54f35067ea4e

## Test Regressions (compared to v6.1.94-218-g0891d95b9db3)

## Metric Regressions (compared to v6.1.94-218-g0891d95b9db3)

## Test Fixes (compared to v6.1.94-218-g0891d95b9db3)

## Metric Fixes (compared to v6.1.94-218-g0891d95b9db3)

## Test result summary
total: 223345, pass: 192480, fail: 2666, skip: 27820, xfail: 379

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 133 total, 133 passed, 0 failed
* arm64: 36 total, 36 passed, 0 failed
* i386: 27 total, 27 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 9 total, 9 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 31 total, 31 passed, 0 failed

## Test suites summary
* boot
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-exec
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-kcmp
* kselftest-membarrier
* kselftest-memfd
* kselftest-mincore
* kselftest-mqueue
* kselftest-net
* kselftest-net-mptcp
* kselftest-openat2
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user_events
* kselftest-vDSO
* kselftest-x86
* kunit
* kvm-unit-tests
* libgpiod
* libhugetlbfs
* log-parser-boot
* log-parser-test
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-crypto
* ltp-cve
* ltp-fcntl-locktests
* ltp-fs
* ltp-fs_bind
* ltp-fs_perms_simple
* ltp-hugetlb
* ltp-ipc
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-smoke
* ltp-smoketest
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

