Return-Path: <stable+bounces-183365-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B6CBB8CF8
	for <lists+stable@lfdr.de>; Sat, 04 Oct 2025 13:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6BA324E314E
	for <lists+stable@lfdr.de>; Sat,  4 Oct 2025 11:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E0C26F467;
	Sat,  4 Oct 2025 11:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rmJlTZNj"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE3B158DAC
	for <stable@vger.kernel.org>; Sat,  4 Oct 2025 11:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759578572; cv=none; b=G8F2Nt142HmWtNI/XN2Vr/6k+RBZHhLTR3YjdBVg4JH15OsuTqe4shXzOVefDfblrAiKiF2ondwQF+uooIOFvoNoUF/YUc1e/DEigczSUtA9WMKS6uJQids6zzP4z1WlzQqCfBdvzTfooezQg0HtlT+r5y0sISuozAWk1xA3eMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759578572; c=relaxed/simple;
	bh=pkDwk8SjdRqCiJc5hSKeWuyIKUzjlG4TUuSd6ZQX3HQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PcFjhCSMX+RNFlJjdwhkuoXGLVx1VwQMssfTvuMfNasnf7witrGXA7DngYr5lVRRk1WguzNuGmDoAzY1FTOSWHJYQkYqr8acVICl7TzXaQ6yZreY36vaFEvI0MIEvrC3G8t7cZ7MKFUsTOTQGPCnd2ytbjL0Sk95jRQrqwWEvn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rmJlTZNj; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-26983b5411aso21562815ad.1
        for <stable@vger.kernel.org>; Sat, 04 Oct 2025 04:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759578570; x=1760183370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LcTUdgesWfT+Mzq+dtlZbSTiYi31AaGTxu4nWfR3YM0=;
        b=rmJlTZNjjIzSM5YTKkl9z3+waq/X3tsquhxfBAe+PEa0zP7TDVSN5vNymsScwXq1+c
         MXwhNEIMrfEdZ3DOVgknsSdjhfYmjWm//rmRoO2oKZaf4CdKzHZ65Gt+0QgifuJ08XTU
         jy8WEtZGVa6kgb/LWg2UmURchu5KB6Yj6JckxBfmS39vhnkNF/7Z2xTsRsKgDKB+GpTx
         yfhKQWOs+HxEwBhL+pXRy5qk/grAvbV88QXE3LJqlGNBQK5uUwOlxYcsc55a6Q0f/wgp
         jwcd48jjxFbWOqkSIjjM/Rg5dqjRiFXQjkxE4wX42ZTZjXIfuKiRJJ9UJY6SLlDgrww5
         S/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759578570; x=1760183370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LcTUdgesWfT+Mzq+dtlZbSTiYi31AaGTxu4nWfR3YM0=;
        b=eBNoXTYfcxF8bPJHvqdVXWuKEK+OwDA0y7NAv10/66x5XBDqtIbQHAXoR5zID+7k7U
         meTHHvqFzu2EZglc3U9BrTwiBpIsPHj6dvIdci6AuDjOZT3IfdfKyBmIstu629T68vB7
         6MTjVfXWcSWfNtS4+tJQM1COAcpaJvYA4HcZDqzNHT6gukrYUuczdrwaF+THm/U/vpns
         cH+9zYS4grVV74tWxpqcuOjMMhR+2bjJRTcIIMeMFT+yhawhwmo2ZcjfdsZPGcmh9WzD
         PeHUpLsn/OUTNdAZIaPh+1XdEzWpa3sruQQRWCV21NP5YUmFnFvqZ8H1FkKKAGWbfmno
         6ROw==
X-Gm-Message-State: AOJu0Yx+zjxqXq0sx7s3d+FKG2LRLoFj1VSgHZw5I+DJ+EW1xIpZk9Sr
	em1kKkpVEGK5OI8PfVd1WPF0NZKLELavQ9RYAtDZfF+ZzxsRTa0TO4I/WmJAGFmWlqGOKxlaldz
	fEUOn5haEuQCAj0tVFULx2Hb/FOzR4cqEAuDgyWXsvg==
X-Gm-Gg: ASbGncusPVG92r667UCZXs6Tf6uR2Z8LjheESpWOqudFvoDAm4V33TDHjsOU+2MZleD
	rSuE29Uj39dLL26AEYDjIHqDKcpvGWLtwpPVmY0HAdhsfev+HZm61GjsYjdEHNcfddFUJlQVafl
	RiyaVolVlUJD9nL6kdYzc6jARPLwERnAGNTFyKU29tpdi7IjFpl73Rm9YyCFZ3exd+aE2nE6vJn
	DcXdkRMKCwUA5SyZjtbcYDd0ea7nPIc9J78V9UtUQlOXwTApUNwadZSnTRvrItHI871iGm4bL74
	+TQgNbRYqN9i5ecu3M4K7tgk
X-Google-Smtp-Source: AGHT+IGR+4ZoxTrGQ2mwM3T3Xs48koDKoSlzjpywHqi9I3UCgz7/U5A0yFN9OxuNUTRLiQOO55AwrEpYyVtoI0/jDYU=
X-Received: by 2002:a17:902:da91:b0:28e:78b9:5780 with SMTP id
 d9443c01a7336-28e9a665ce6mr92230575ad.47.1759578570192; Sat, 04 Oct 2025
 04:49:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003160352.713189598@linuxfoundation.org>
In-Reply-To: <20251003160352.713189598@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 4 Oct 2025 17:19:18 +0530
X-Gm-Features: AS18NWA81e55FQMABFWQN53g5Opr6JiuVi-7M3ZefmVGyxBOciifUBnGhnH7Bdo
Message-ID: <CA+G9fYvC3zw7ZDXfSi5Odi79yR7OqP0-5+nB4WtexXZtWQXCxw@mail.gmail.com>
Subject: Re: [PATCH 6.16 00/14] 6.16.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 3 Oct 2025 at 21:38, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.16.11 release.
> There are 14 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 05 Oct 2025 16:02:25 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.16.11-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.16.11-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 13cc90c947b1412899e3166281ce75d1bf1ae157
* git describe: v6.16.10-15-g13cc90c947b1
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.16.y/build/v6.16=
.10-15-g13cc90c947b1

## Test Regressions (compared to v6.16.9-144-ge1acc616e91a)

## Metric Regressions (compared to v6.16.9-144-ge1acc616e91a)

## Test Fixes (compared to v6.16.9-144-ge1acc616e91a)

## Metric Fixes (compared to v6.16.9-144-ge1acc616e91a)

## Test result summary
total: 160076, pass: 136235, fail: 4547, skip: 19294, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 137 passed, 2 failed
* arm64: 57 total, 51 passed, 6 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 39 passed, 1 failed
* riscv: 25 total, 24 passed, 1 failed
* s390: 22 total, 21 passed, 1 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 49 total, 46 passed, 3 failed

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

