Return-Path: <stable+bounces-177581-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 937A9B41831
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 10:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 173131B21AB8
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 08:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DED92E9EAE;
	Wed,  3 Sep 2025 08:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xt5ls8Ci"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0907B2DE71D
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 08:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756887384; cv=none; b=e7qinerZjynmbBhmSoN64MS4YLSIOtFC6rwdNXnQDQCNbcsTrmczx5XHY46tcOHyd78rmvwPY8VPXs2tWUYJzJ6XawMvzYB7B9a8pjKD1KQydykhWHIt+nGMenW9ySbrEpCwLRFf1CTKYzGyNX242PBddyEZKTZq9GYsYmHMTvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756887384; c=relaxed/simple;
	bh=W7FUojUFnzxGTg8A+tqGW/iXc3ML/j8Xn4Q+Vbq/A34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b0Yy77NDT0TjDNHO8KKeCxDbpSSEv5TJVUmJjtXVHRhAWvwMZGFXTU9eAw4qRM34CUkqr9tY/yeDyzi8B1dXQ75tOlFNmh+kbf9t9atC9d9g1mlyGurZxLDuweOq7TxgAdww98bFrW51U2a/yJqChdndiUlSE314bfkxovyBd4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xt5ls8Ci; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2445806e03cso74207795ad.1
        for <stable@vger.kernel.org>; Wed, 03 Sep 2025 01:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756887380; x=1757492180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYJgan4idEGWGAUXtzh/kv+BKTRh2JOtbApGJr0y8I0=;
        b=xt5ls8CiVyfc+//TEZlWQYATP3uySmz/t3o/Q7S1U/WY1zV3SFOzgv8rCg9EnBdZid
         ERdRlKiKftV9EFGrKzMw1/hqJmo6Rpa8eSQ9wMNaxwdpmpzNfC9JcY0Cc9mWDx4dX4Ws
         KwpQZd9J2dPJd+VRHD0rGDOqiXj8DBJxkGC4rmjA+TE5QmpgY/M+cuFSkM5+IwJ5rwJr
         Xor77827Jy3rATSrA7RE62CzmTBETbtf6YMp5QNvf4kufeXAfukv4D0KHF+D457QTzLe
         azIRbpQq0H38nYaBdTEwT8UlBNcSWohyBIWVIPk44618KuDifsoGrbQNVoTvSdRTJYds
         0DoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756887380; x=1757492180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kYJgan4idEGWGAUXtzh/kv+BKTRh2JOtbApGJr0y8I0=;
        b=rYZmvegTkG2+pAyjWaBXusptD7pJI3laLQG4Kr6vH7+6GlFOYRQjWGBkug79m3wiSV
         piobs2zq0IfecvkM+DriSyRys7OdevrqNX79DmlLE/II/c89MDU4pN/q6vkrItCgultx
         r8ePvBjvuCJTiQfIrrzJdiUkoBp+WUjzA2vIFrl8qbV40bTTL+3NwYCeoO77bOSHy7BX
         htQ4AeLObMYA7eJgXXBg+LC4iCNGWTmmYBxtHqgoaSZQ+rVYYdsF4Rn9GNrADMwFP2gr
         2afdK1JKrN7F44JTDjlArcV+uUOi0U6tkhaI+mvs6+3x2fhjiUXOMdJ1MjEPGEDYCkWW
         dnFQ==
X-Gm-Message-State: AOJu0Yx9ea0CtMav4VKpa5TAEwgrkNWoqXMkVzs2+ak5gIoYXJIfDrz+
	uX7RoJ9wVh9sO1aDBnvWxdBao79oAjvl4/gVZg+6M7KsE9UDPDIPD7GW+RPOxKs0aX841Pl026e
	+BqFRuSZAsaoooPTWNLParJJOdR7kOYzGwGi5lSGrCw==
X-Gm-Gg: ASbGncurQyoUgq5m+AiqDXyOLFTk3gIC9XI/uSJPdTZrdxA5AISoWWaIXOx+M8dtQ+L
	6h3qZZJYl/toEQ58uSJ54+iSgOgwzQAu+QGFyzsc/4s8anjNGoVpJNGcD4+yDceENoXULz1FMQZ
	YE7jX0nDKeUNqis2zAAdDLMGXv3dCLHp7dfh5B7Q+5ndAhrSyGLm4kmFAkAdf5kPpE7uIvCmbKl
	sx112Qr0Rg/SiH6mUs3IwnsLNNzgaBbqPzWArby
X-Google-Smtp-Source: AGHT+IHotd1w9hgcJaMKlGGOglODYjS7R49yIJBnZVxlXGew4GiiU6D6repM/2G+4YASZCQw7uWImmyPlSqOToqx6T4=
X-Received: by 2002:a17:902:f642:b0:240:11ba:3842 with SMTP id
 d9443c01a7336-24944a9a70emr181326735ad.35.1756887380252; Wed, 03 Sep 2025
 01:16:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902131939.601201881@linuxfoundation.org>
In-Reply-To: <20250902131939.601201881@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 3 Sep 2025 13:46:08 +0530
X-Gm-Features: Ac12FXxkjRNh-TPz8gdmB62ta4_Qq5beeBKaO__NWn-nGW7c-Cjby8qjDju_5Wg
Message-ID: <CA+G9fYvEyFjh6k02caEL5JYd56A0Xv5e_RSRxkDZeX3A17UTGg@mail.gmail.com>
Subject: Re: [PATCH 6.12 00/95] 6.12.45-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2 Sept 2025 at 19:01, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.45 release.
> There are 95 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 04 Sep 2025 13:19:14 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.45-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.12.45-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 4459b7afd68d8c7f767bfedcb8ce7b7973caee3a
* git describe: v6.12.44-96-g4459b7afd68d
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12=
.44-96-g4459b7afd68d

## Test Regressions (compared to v6.12.43-323-gc7e1bbb35205)

## Metric Regressions (compared to v6.12.43-323-gc7e1bbb35205)

## Test Fixes (compared to v6.12.43-323-gc7e1bbb35205)

## Metric Fixes (compared to v6.12.43-323-gc7e1bbb35205)

## Test result summary
total: 323915, pass: 299363, fail: 6744, skip: 17352, xfail: 456

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 137 passed, 2 failed
* arm64: 57 total, 56 passed, 1 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 40 passed, 0 failed
* riscv: 25 total, 22 passed, 3 failed
* s390: 22 total, 21 passed, 1 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 49 total, 48 passed, 1 failed

## Test suites summary
* boot
* commands
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-efivarfs
* kselftest-exec
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-kcmp
* kselftest-kvm
* kselftest-livepatch
* kselftest-membarrier
* kselftest-memfd
* kselftest-mincore
* kselftest-mm
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
* kselftest-tc-testing
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user_events
* kselftest-vDSO
* kselftest-x86
* kunit
* kvm-unit-tests
* lava
* libgpiod
* libhugetlbfs
* log-parser-boot
* log-parser-build-clang
* log-parser-build-gcc
* log-parser-test
* ltp-capability
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-cpuhotplug
* ltp-crypto
* ltp-cve
* ltp-dio
* ltp-fcntl-locktests
* ltp-fs
* ltp-fs_bind
* ltp-fs_perms_simple
* ltp-hugetlb
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-smoke
* ltp-syscalls
* ltp-tracing
* modules
* perf
* rcutorture
* rt-tests-cyclicdeadline
* rt-tests-pi-stress
* rt-tests-pmqtest
* rt-tests-rt-migrate-test
* rt-tests-signaltest

--
Linaro LKFT
https://lkft.linaro.org

