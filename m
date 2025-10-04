Return-Path: <stable+bounces-183368-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF86BB8D1A
	for <lists+stable@lfdr.de>; Sat, 04 Oct 2025 14:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F0354E2BB4
	for <lists+stable@lfdr.de>; Sat,  4 Oct 2025 12:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6027426E143;
	Sat,  4 Oct 2025 12:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b0jTYyUe"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA5E26A1B9
	for <stable@vger.kernel.org>; Sat,  4 Oct 2025 12:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759580039; cv=none; b=Vw5P5lrtxO+4Crv7FK7ce2KK5HGSoxrBJiZrM5I9/G+VemBzOqygRkQjPu7MWvX5skEN2/p8fqX0+NoPXXWws8AwlbnFkhkBEsw5siyz+74oyJp7DMyRY1AZyS5xLy76cHApkx8eNiUV0rzAs57KraIQ8xUlgJRutlsQJTrY1F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759580039; c=relaxed/simple;
	bh=XQxVEshz28IKhO0p+ZQMpTW7xOSwxxB1o6rEgJHFH6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ti8L9W4EN07XfUiqjKuKcu9LuiZQ8hxx2BLIDeDlxqVxYqJhSCCHF0oBu4ea+h2KXgCxmmsjpFqlE4mgj7wOi/EY2i/h/2ByWQIGHVkd8lQziPtQDeBayt59wtd9rTPr4rsVcVomzj/BgMI1CpgXua1xPaKH0CeQPTK6fhhsVq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b0jTYyUe; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-271d1305ad7so45368525ad.2
        for <stable@vger.kernel.org>; Sat, 04 Oct 2025 05:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759580037; x=1760184837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dhEvWiXk60BQY92FOylfO8eNaNBD8kDsdejX07MfHU4=;
        b=b0jTYyUehc5p9Goc69Tk1KLVN3AxyI+foDJpG5YEimdlQDF9bCH1exIjaQ1g4wk/lc
         aniFcu3lT8msm9ivR3jDeI5DmkTMQStg75qumuFY7s3h4CUTlM4wFTk1w7HU3egqllL7
         9wpN4+D9L+jsEwqnNC0Ubp0hV/fpv7gQYaNiJqcSYUiQ+aO1dw0odky5TuakJCSGzkIG
         vCizreFc0jn4mQOP7jCPOIq1GxNWucXoUFtmL7NghZZTlO4q8c6BpHtzk1ZmwmSrnHw0
         E4TBKU4VJ5n7+o5G90HQq2/oIXhCL4quXMu/20b7E1dOaz8Kqgp643/s/NaqS5rRFR95
         CWSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759580037; x=1760184837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dhEvWiXk60BQY92FOylfO8eNaNBD8kDsdejX07MfHU4=;
        b=jsi6cQjGrNUOSd6wjdmS9FB/p0kmWXS9CvfbOHGFqoVK6FeiQZO7EjjdcjgntRbw1n
         dIQubhSN1XDTl3rPK4Yuuib2NU/myRDXkkPCrLAdK1PahKApAd0iozJzb7koSyW4yWfa
         FeuU7en09l9afKv1lv/GaGJZXXUkvmDMQNXiIyq0pBw1mcCZi2NzIb+E33XOgVa1hjsl
         xYNINlkT2e066UDGQXUNMPb9h7+oufFxqWgzZvmwTY3iuA7OOLO3yBjPnYjbb1ncvkiK
         xMJze5BABZxq19kZIWySGqtlKuT1nULShugNkmNI0HqQJDJCY556s0wUgLe51ZrW7KwM
         XN4A==
X-Gm-Message-State: AOJu0YxJQUqHMpuOfszbxgWk9nAQhqjil9u25TAWSykVAPWhQnRTjf7C
	mghDqPErgBDis8JCIfgY2Vh4Lmd+rm+kCqKkjS9GklkHovtnfpNpr96OicFGxOe945CN1Wb9+Qc
	4raeUjuaILSbIBQ11bojKlFqEt1kI5s2upphYdNSJ0w==
X-Gm-Gg: ASbGncsI9e/9ga+Qtxpag+JZz+yYm8aKawAollhnQ4LOW2QMeJeXBAXAqTMY4sIM5mz
	DP510j/ZYsMgn8A7JLVZCH+XlvKIKf6o2BpzFah7fjJwaNwwzEqCjtGUPFKNCo7vXRDxJZqBIvf
	XScjXMHbF+exI4V1d3c6OkOtUxEeFS0f5g3wN0t/NJuWCKeSk+/R850EIskxMLVOye4+Gdm84Yl
	UAUFAxl346Zv7zX058M26RXAejFZY/Q3+N120RkQSNq1CwguhnVrcaZldNXsXkeHm7mC0u/2fli
	AMLRmOMVQUXQASEie2pFlxA2RqcqOeAvRHI=
X-Google-Smtp-Source: AGHT+IE9EcSqKs9pW7HpnTAx+2XrLnXQii3siZ9Bu3lX8wr5mdTW4z/DbBU7rWeDupsrW/IY1PfSanz3+PPWrpWVzrM=
X-Received: by 2002:a17:903:234b:b0:275:1833:96e5 with SMTP id
 d9443c01a7336-28e9a5beed8mr79039585ad.24.1759580036770; Sat, 04 Oct 2025
 05:13:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003160338.463688162@linuxfoundation.org>
In-Reply-To: <20251003160338.463688162@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 4 Oct 2025 17:43:45 +0530
X-Gm-Features: AS18NWDKQHmwVr2XeBE_n915Zz4jcEjLc8nkYxw_IvMT8WzsEY2RMYkVEVebbNo
Message-ID: <CA+G9fYsjU1tMnt3E055cBCzA_wk3H7LHa=Qy5Kat05xAJFgD2w@mail.gmail.com>
Subject: Re: [PATCH 6.12 00/10] 6.12.51-rc1 review
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
> This is the start of the stable review cycle for the 6.12.51 release.
> There are 10 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 05 Oct 2025 16:02:25 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.51-rc1.gz
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
* kernel: 6.12.51-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 791ab27b9c005e9996ed4ff5785a84890ea86f8b
* git describe: v6.12.50-11-g791ab27b9c00
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12=
.50-11-g791ab27b9c00

## Test Regressions (compared to v6.12.49-90-g8e6ad214c7b3)

## Metric Regressions (compared to v6.12.49-90-g8e6ad214c7b3)

## Test Fixes (compared to v6.12.49-90-g8e6ad214c7b3)

## Metric Fixes (compared to v6.12.49-90-g8e6ad214c7b3)

## Test result summary
total: 156220, pass: 132956, fail: 4989, skip: 17711, xfail: 564

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

