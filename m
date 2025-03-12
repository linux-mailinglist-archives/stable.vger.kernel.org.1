Return-Path: <stable+bounces-124140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A112FA5DA77
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 11:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A65416C78E
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 10:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C085723C8C9;
	Wed, 12 Mar 2025 10:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rKlg7GPd"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEFF23E324
	for <stable@vger.kernel.org>; Wed, 12 Mar 2025 10:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741775596; cv=none; b=N8TlG2Q0Rj1y9Xk/+H46SJETte0RRKXorRm8wxn2zCaDH+m4hWYHtrgq/Bb8OhMjqMwrT9k5CR4jzOTfSW4Jtq/QUEnt5NxZFABHb7cVfKvHyUh1jI4sC6gFv73ew6ZuorlKCutJtAY8sdhX4Tn1PQa3I4urPUV/TNU5ArdnPcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741775596; c=relaxed/simple;
	bh=OxNjpOJ6VfzOUaMrWleIBMA1ReLbN1SeLEL4b38qWME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ITcDjAF4H40irylpho+XLbd+FzRkn2jhE/e2LyIqRLp3HpZ8Sqm8zftAH+2ETxQJMRBtPGLCC5aJh17nfelNtpxhl29AaqqHGI7IQFnPtMCGE8qj8vwuO1EXBPs54EQl97RYTMOK64O37xJ9c4XZxUeunqhPz4L2PWfJUBMt3HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rKlg7GPd; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-524125f6cadso2078697e0c.2
        for <stable@vger.kernel.org>; Wed, 12 Mar 2025 03:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741775593; x=1742380393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KM0MvCdNVxzxXgBH2Q5bQqwEpszrc8WPfw4cYOnLhIo=;
        b=rKlg7GPd+4NurfyBuZvh1oVboFFdhto0nKlucl3hRnN3sQM2FCpVzxWUQRgHTl7di0
         CjbKETL4J9yiurUbb2thbiDL8fe8AoZPkQNrh8uAPggHMxE7bj1bMcqpLvwtlmYegPBd
         W5YXD6uoYq7eVSwyxPu865mw97HnVN09/KqfKDeH8Dmu6K87IkoX8wn3fDsE/XO+W5gT
         wyNMDs9QLWfzwZW7Lx6vj8HLxCRASQTK+rt4R4BSlHDeH/zN5tw/39pVhIHRK6i+dQ8H
         KrXd6TxU6M5PE4iFA7MJBmNtFIgJX0Krmj6wPJyGL7/TfXmC3FL5csVWOvBG0TIspUhP
         y1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741775593; x=1742380393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KM0MvCdNVxzxXgBH2Q5bQqwEpszrc8WPfw4cYOnLhIo=;
        b=hkBuBZ8+uR1ksUx19n778ut6JKaeOQYt/zlAtHBAogCbAeRbcytMxT254lodRbPu1n
         z1zOZZxXYrwnkDYbrlBg6d3L8r1O/BSYRG/XSUL4seQ/JflBT4QTgR2Bz+PAnJS5Vr+I
         TntuHIIzy4Bw+ivqglHaYjApG3EOMVDxjn5v9I+4B/Qc0N3cSBKCvUkrZOL/tTLZ39Xn
         kqlmYdeYT/lRfsqe5hVuV/d8b6C5ZWE3eQPUHUfZ35ad4C20PjpbhkjQ/3C66S69LQow
         biMKCVV6/3P+K7UVqlsh5zt0RqB8Z6edkV446VIikGjQzbOHz5ivJZhsrnmDzMXHsg6H
         ltqw==
X-Gm-Message-State: AOJu0YxS+kihLWw8CGuzqNqBtMbQvu6sY0bDmDQh3OvnsFecK6s5VZAG
	a3eVa3XQdtIuTQ7InPh0w7qeqmGY7u+OzIA4f+tADJpDo6UnNwpS6m6qeY+bSRkqLXX1wkFQKNS
	tV9Eq02hut8YKfAY/VkZdolQtwtSM2qhWWd1ncg==
X-Gm-Gg: ASbGnctXbSR2u5BCQYK3BSfkVYsg+K6dE9VXH3hd5RhlTPP90Y4gBw4J39BM050o894
	pRMItblBkFdw4Wl+14EsPkkieBXpJPJSb9XDP71NZStloVGgs8yLiyxqWnSBGns8KyE3Zl1VA13
	Fpu0uYD92SrrhB8eNevPm+Vuq9ZYnP3ThXjDMNvWEJFtkNtfkeAjrqzrgO14Y=
X-Google-Smtp-Source: AGHT+IFlw8H9uqBvw9xXA5rE2InxUbS79lI5zq6VR1c4tWkxgj7QEGwJsPaP1vOJJJKSz6buJDR0kzLt/Wt2JZPh3lA=
X-Received: by 2002:a05:6122:8297:b0:520:5a87:66f0 with SMTP id
 71dfb90a1353d-523e3d8de95mr13152498e0c.0.1741775593628; Wed, 12 Mar 2025
 03:33:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311135648.989667520@linuxfoundation.org>
In-Reply-To: <20250311135648.989667520@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 12 Mar 2025 16:03:01 +0530
X-Gm-Features: AQ5f1Jp-kXQi5W-EyPUYylM5Jm9lw1_VYlNpkYa3ZexnBwthVaba4bKA-pk1Paw
Message-ID: <CA+G9fYs0W=2xDtFzNhwg8pipi_iXiEZFNvD4tz8stZL=1fKWAg@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/144] 6.6.83-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Mar 2025 at 19:32, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.83 release.
> There are 144 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 13 Mar 2025 13:56:12 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.83-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.6.83-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: e7347110295b72c0d0c942ed260f679edf70f859
* git describe: v6.6.81-152-ge7347110295b
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.8=
1-152-ge7347110295b

## Test Regressions (compared to v6.6.78-442-g8f0527d547fe)

## Metric Regressions (compared to v6.6.78-442-g8f0527d547fe)

## Test Fixes (compared to v6.6.78-442-g8f0527d547fe)

## Metric Fixes (compared to v6.6.78-442-g8f0527d547fe)

## Test result summary
total: 122461, pass: 100025, fail: 3148, skip: 18798, xfail: 490

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 133 total, 133 passed, 0 failed
* arm64: 46 total, 42 passed, 4 failed
* i386: 31 total, 26 passed, 5 failed
* mips: 30 total, 25 passed, 5 failed
* parisc: 5 total, 5 passed, 0 failed
* powerpc: 36 total, 33 passed, 3 failed
* riscv: 23 total, 22 passed, 1 failed
* s390: 18 total, 14 passed, 4 failed
* sh: 12 total, 10 passed, 2 failed
* sparc: 9 total, 8 passed, 1 failed
* x86_64: 38 total, 37 passed, 1 failed

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
* ltp-filecaps
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
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

