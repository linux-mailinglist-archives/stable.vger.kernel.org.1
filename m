Return-Path: <stable+bounces-158526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A79A2AE7EE6
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 12:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65212189A665
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 10:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0A4286425;
	Wed, 25 Jun 2025 10:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j3qwddyl"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2EA1F4612
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 10:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750846572; cv=none; b=uAlxTcB25AHKtlSlXjLO11+lYe0h+ZfV0TGMh6Y9k6vAaMSjaIIYR6QM33E7+E5Oi5Q3RLZ4J5iyByHc+auX3D+5/4Q+qmkTzP3lSs1M6WY2wDNHCOos5akjTe3NwXAQODo4wjZPznGgixzxNq/1Fb2mdrujygQW1qn5qpS3k/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750846572; c=relaxed/simple;
	bh=/pP/DMCn/BG2BmwgbyypJMnbvQ1FiiNc5slgttyyyNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U45pMuCkdXvW+02VpucPEzz5W9z3BMJoQ9hzOJ7E+5Zq5Xw14+EslFD7L1pkwB2i+zR7WDQAGHF0K2jWjV8sqMg33WmCG4F+8ixw47V6BBFOmbwdaarNaSOSd9hyLqHkuXlTXEg27YJsm8D7eqj12m3O7TFMqeg27xlvG/9aTu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j3qwddyl; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b31befde0a0so4180264a12.0
        for <stable@vger.kernel.org>; Wed, 25 Jun 2025 03:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750846570; x=1751451370; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AG6xDQrINUokgKFDlCqXGxqgTNa8CWmIrqjoT7AtA8o=;
        b=j3qwddylbTS841ssnCi28oHD20g9sOjOmE5JB2G6+teNIC91VfKvztVHfT3Ux8Yp1T
         IJ8XrlmGGHOfMiFLQ+mapojEXRmRFTUlDyQMaDNYsnijNz7nIH5gUKqe+xPnawa7//y8
         ovx4TqNn5Us+GBl8TbZI+cbxebEsensagZPwgCAC+9vNmjob/NouofrVJnSC9+ak78OK
         JJ/TM/yJkZ3laZdtpvkkDyb0xq+sPQsqmMG5tx3699pnEfbo4XqYy7N1Jmx4DNcaDH3J
         jYbTD4m5vbmku3sob9tDJcyZCZeLlW+KS0C0hu60rZHNyErrFB83HYd38aSTzzHzx/nL
         lJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750846570; x=1751451370;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AG6xDQrINUokgKFDlCqXGxqgTNa8CWmIrqjoT7AtA8o=;
        b=SZkjpHmaNdo+7PuDWAGGdKCDXD31J+jkKqD4k82H3k2kfAExp7tCY1SQKF0vR5m2A7
         K2d5scwjkPsutF1bclRjk4aMDMw4cbO3WDhs2dQUE9rsVDSfDsZkCoBLyGf6CYpXS4ue
         e/v6ALNAtnuCxO2gRsu5p3KPLPI0+LtBwYYdxdYkzJ+rhnKGI4J2TK9QbPZGjSnvIUtU
         9OerYv99HXc1dFpq6S7dzgsYpX6t/hUWbIGZK7ioVPJj6cuAwvaPYMskFEyWNeo6p978
         FtPgnMGGHlz5qiZH1l8nqzs3IdDdNU9Gy/XTzCGUrOYSK/O/NgCC30KyDQFZh8zI1v28
         yQeA==
X-Gm-Message-State: AOJu0YypdbamZTYEjhPL64ONuQEf1/6FBjnjV8iK4KvbY4ZyMNU35GOX
	Mz+zLSYfHJ2tdj03Idl445FpY/xxTRmziQUyDkXSubCFnJBUXDUxZMvYti1OlMGM2ezwzHP9TX6
	/ImR6KGqO77jIHOCxXzkeNjhZmiAjcH6cUe8jNZZvMQ==
X-Gm-Gg: ASbGncuSNF8zoLuzIJFelkm7beOF6i9aNSSBdIypQtOAdE1EExKiB2JI/Pn4nlrPe5d
	9lM/eR+vEVMTn1QmnHlrrvx6oJNlHAs4oDIfIEsaQhAlqlkBNPsNhs4PfFs6VeCjMAIt+4owcZH
	2nkNVx9LBAXLD1oTrQzUDnpePJV419iMTzw42eFKZuDu1jix6lzV6D4g0xLDo5EwGi+hKuLDchP
	b2a
X-Google-Smtp-Source: AGHT+IFVAx09tJ/W+hcxC15Z++m4Fnij2LfPD0+rSVnQD7OzPyB5OrVIKV6garKV25gdDWYrE+xpu+RhOM7N7/rV8Bw=
X-Received: by 2002:a17:90b:2b4e:b0:311:f30b:c21 with SMTP id
 98e67ed59e1d1-315f269d920mr3170155a91.26.1750846570290; Wed, 25 Jun 2025
 03:16:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624121449.136416081@linuxfoundation.org>
In-Reply-To: <20250624121449.136416081@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 25 Jun 2025 15:45:58 +0530
X-Gm-Features: Ac12FXzd8RthilNJCW7WcxXTXyjhhbTTiUyFCV2MP6xvuvJz3W9NZP8_1yYKzMM
Message-ID: <CA+G9fYuvqFY46E+UNzbH-b+dhf3SQPXUOdpCnxYkZ7iSX=NyCA@mail.gmail.com>
Subject: Re: [PATCH 6.15 000/588] 6.15.4-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Jun 2025 at 18:00, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.15.4 release.
> There are 588 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 26 Jun 2025 12:13:28 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.4-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Regressions noticed on arm64 and x86_64 devices while running
LTP syscalls readahead01 test case on the stable-rc 6.15.4-rc1 and
6.15.4-rc2.

Test environments:
 - Dragonboard-410c
 - Dragonboard-845c
 - e850-96
 - Juno-r2
 - rk3399-rock-pi-4b
 - qemu-arm64
 - qemu-x86_64
 - x86_64

Regression Analysis:
 - New regression? Yes
 - Reproducibility? Yes

Build regression: stable-rc 6.15.4-rc2 LTP syscalls TFAIL: readahead()
on epoll succeeded

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Test log
readahead01 readahead01
readahead01.c:34: TPASS: readahead() with fd = -1 : EBADF (9)
readahead01.c:41: TPASS: readahead() with invalid fd : EBADF (9)
readahead01.c:62: TPASS: readahead() on O_PATH file : EBADF (9)
readahead01.c:62: TPASS: readahead() on directory : EINVAL (22)
readahead01.c:62: TPASS: readahead() on /dev/zero : EINVAL (22)
readahead01.c:62: TPASS: readahead() on pipe read end : EINVAL (22)
readahead01.c:62: TPASS: readahead() on pipe write end : EBADF (9)
readahead01.c:62: TPASS: readahead() on unix socket : EINVAL (22)
readahead01.c:62: TPASS: readahead() on inet socket : EINVAL (22)
readahead01.c:62: TFAIL: readahead() on epoll succeeded
readahead01.c:62: TFAIL: readahead() on eventfd succeeded
readahead01.c:62: TFAIL: readahead() on signalfd succeeded
readahead01.c:62: TFAIL: readahead() on timerfd succeeded
readahead01.c:62: TFAIL: readahead() on fanotify succeeded
readahead01.c:62: TFAIL: readahead() on inotify succeeded
readahead01.c:62: TFAIL: readahead() on perf event succeeded
readahead01.c:62: TFAIL: readahead() on io uring succeeded
readahead01.c:62: TFAIL: readahead() on bpf map succeeded
readahead01.c:62: TFAIL: readahead() on fsopen succeeded
readahead01.c:62: TFAIL: readahead() on fspick succeeded
readahead01.c:62: TPASS: readahead() on open_tree : EBADF (9)

## Test logs
* Build details:
https://regressions.linaro.org/lkft/linux-stable-rc-linux-6.15.y/v6.15.3-589-g0e4c88a0cd37/ltp-syscalls/readahead01/
* Test log: https://qa-reports.linaro.org/api/testruns/28870061/log_file/
* Test LAVA job 1:
https://lkft.validation.linaro.org/scheduler/job/8330087#L31908
* Test LAVA job 2:
https://lkft.validation.linaro.org/scheduler/job/8329545#L28983
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2yxHG8Ax1HJmLWLj50iRxkZE4Lv/
* Build config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2yxHG8Ax1HJmLWLj50iRxkZE4Lv/config

## Build
* kernel: 6.15.4-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: 0e4c88a0cd37e785c1dbe6b9a9394d649a77cab4
* git describe: v6.15.3-589-g0e4c88a0cd37
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.15.y/build/v6.15.3-589-g0e4c88a0cd37

## Test Regressions (compared to v6.15.1-816-gd878a60be557)
* ltp-syscalls
  - readahead01

## Metric Regressions (compared to v6.15.1-816-gd878a60be557)

## Test Fixes (compared to v6.15.1-816-gd878a60be557)

## Metric Fixes (compared to v6.15.1-816-gd878a60be557)

## Test result summary
total: 256258, pass: 235037, fail: 6140, skip: 15081, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 133 passed, 2 failed, 4 skipped
* arm64: 57 total, 51 passed, 0 failed, 6 skipped
* i386: 18 total, 17 passed, 0 failed, 1 skipped
* mips: 34 total, 27 passed, 6 failed, 1 skipped
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 39 passed, 1 failed
* riscv: 25 total, 24 passed, 0 failed, 1 skipped
* s390: 22 total, 22 passed, 0 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 49 total, 48 passed, 0 failed, 1 skipped

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

