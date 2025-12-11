Return-Path: <stable+bounces-200771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C30CB4DE3
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 07:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9941301098C
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 06:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23385285CA3;
	Thu, 11 Dec 2025 06:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fs3Saqdx"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41379279DAF
	for <stable@vger.kernel.org>; Thu, 11 Dec 2025 06:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765434238; cv=none; b=Er6S80wiBIZl9ipy7996isUNXTxG52ZXW5N70cuSmFRBOBd2Il3V5EVryKu0Kdy2cqAe4QjE8fBx2iGT8TUuzogJclfxMCf5ML1cbWydRQ6IZrDsHsjXKfpOx4v+/F7/1m3I4LEEmFR/Zl6awIPPcH06dWEdKqrGl9lVjx3x4es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765434238; c=relaxed/simple;
	bh=+Ea/t9Gzvkzqy7qyNNB2KfWfIh3PKgywyC9p5zSkt8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X2ijadcZADxKYgKx7xKBl+Lnm7+Ri1ixe7QJC251wrenukEaKc7OBDP1HfKABiVG82y08vBGGgJnIXBRhevwplL9UD00uhe5GjsNRLivJs1wcX2wR9kV6/ACT4DtyeBjXScQeFujb1JHGbzGYMQ5AVe6VvSiO759gkT5NAam31c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fs3Saqdx; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-bc8ceb76c04so444254a12.1
        for <stable@vger.kernel.org>; Wed, 10 Dec 2025 22:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765434235; x=1766039035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNkVbuY3usTKHCsWOGhWZWGyB86GCzXVbCkYK/l5WJc=;
        b=Fs3SaqdxO40nc17sHxz3L8e4MFXbhyybLgNU7JpjDbxuGPM0Qnp3IYV/BEwV1qEOL8
         VJbIolLFswz9zBs8m0JwCCGaS/DqYU4wnF7mDU7CHgK8k8Z5ov83exmVTnmK4n6oD5KG
         zXXpTSC/62ELSBnAOQ/dwiBXu8tYVxxfxvBCie+rVXFnk01hnHUXjveUceZCn28USZnD
         /h/4CJMIrQmQYJHtxmkV9U0/mbc+w+BCAgguxqgnSoupJ2qmQ6cwtKEPi7NLQBo/e+qx
         P3GJ/5Wbq0FCF/XYWm904jjU0PIWptw89zPoPgnGsXiC+YYfoZrhIqfujIWdVMvQ8z/7
         9bBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765434235; x=1766039035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yNkVbuY3usTKHCsWOGhWZWGyB86GCzXVbCkYK/l5WJc=;
        b=CYPZn+JX+bEfmYjuSjXE0W0HaChZOC99hVeJOwKmVQtqKEeYikplXS7rjh0WLqxrjA
         drDldae30JnarCzIIuZX71IpJDw/SnMzVIu3FPBdKaF9UKH5Z8V0at8QKm/ba+sBmxNn
         rH3hguQqszJqkSzfS7nQRQm03FC+8KylpJUJCrhh3BVErSonDCkSL+eS4qT6PJ6IEMKe
         U2mRoxdal1km2XGL/vYuM1yr8EDhXDztBWJYTO6U47gsgj+cwqhgPwJvcRZcxBnz4K+D
         yp4tb+473J3CDvFonJHf7oCZ25bUWdGFb+IEKKjcbF6bbH9tMALgJbnFjoxseG3ankLx
         9XCA==
X-Gm-Message-State: AOJu0YzQ2F2eJJHxPBbYPl/PD78KuRUig+1epcW/TGwd5UMsWekWLUQJ
	uVqDYALv8PLBSNPaP9tQLbiPMla8AisbSHmKAWm933ztqZRg69JCh9+L7j0l+Q/dOfkF7f8DpFH
	9+zEEiYhTyUIeux/f3vopSwf/VY4jWk033EhZZQNSmQ==
X-Gm-Gg: AY/fxX68IeH9G5kt1MiCgHZqgzyNgjnWqWmIYuG+btOf4jUzvGgh+bBIjjgxDi0uFGT
	lpOKRoD2F/kHihzHswD7AdLXQQnWexSlNEQWhNpYSF8SZVf3rPwzIJYrS9bH/ErEIB8T9buGP/v
	eQaGyhX+yPt1DWaGptA4oA1kDTCm2F5NJ6Rj9YiE+2ZpeQbN1xLwfuulpdSmDKCjUdmiThgDR45
	7IAxPzvVoBH5UDupAhtWNcOWe4q7oQZJMZkQyqxmBZzjXAzYhO5z0yPQGY5IDyBYN66lSvjwm8M
	saekH8BmMyjyVmmk/HjerSctsxSisw==
X-Google-Smtp-Source: AGHT+IGVxhAUv3cl81I8lkaEMdy/a72TP9vctXDJDJTWxE5FmtXceYhvpxR3BE0Jmi5uzyOFWesP4W0n7csc6GC3IS8=
X-Received: by 2002:a05:7301:428e:b0:2ac:1c50:f900 with SMTP id
 5a478bee46e88-2ac1c5101e0mr692552eec.34.1765434235378; Wed, 10 Dec 2025
 22:23:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210072947.850479903@linuxfoundation.org>
In-Reply-To: <20251210072947.850479903@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 11 Dec 2025 11:53:40 +0530
X-Gm-Features: AQt7F2p22RbIhZwEd5TrSspQvQY1KIbWLmV1jiNB8KMKbUqYqiz3PuuMvzz2x-4
Message-ID: <CA+G9fYtGdn8Gqy3kWWRF_SrauO6Ax+TXR3hAH_hirjxJCAYdSQ@mail.gmail.com>
Subject: Re: [PATCH 6.17 00/60] 6.17.12-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Dec 2025 at 13:03, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.12 release.
> There are 60 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 12 Dec 2025 07:29:37 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.17.12-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.17.12-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: e7c0ca6d291c41a8a9648a5016ce9b73e492aa3d
* git describe: v6.17.10-208-ge7c0ca6d291c
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.17.y/build/v6.17=
.10-208-ge7c0ca6d291c

## Test Regressions (compared to v6.17.10-147-gc434a9350a1d)

## Metric Regressions (compared to v6.17.10-147-gc434a9350a1d)

## Test Fixes (compared to v6.17.10-147-gc434a9350a1d)

## Metric Fixes (compared to v6.17.10-147-gc434a9350a1d)

## Test result summary
total: 116299, pass: 98676, fail: 3761, skip: 13862, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 139 passed, 0 failed
* arm64: 57 total, 54 passed, 3 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 39 passed, 1 failed
* riscv: 25 total, 25 passed, 0 failed
* s390: 22 total, 22 passed, 0 failed
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
* kselftest-rust
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

