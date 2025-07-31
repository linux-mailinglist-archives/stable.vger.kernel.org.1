Return-Path: <stable+bounces-165641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B298AB16F50
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 12:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F33E618C21AD
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 10:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE561F4616;
	Thu, 31 Jul 2025 10:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XeaVayyu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA8118DB24
	for <stable@vger.kernel.org>; Thu, 31 Jul 2025 10:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753957067; cv=none; b=e5T+/GG9RfDL6FryN4v49HBVGCrtjidceMBHAl/jDH4+QcCjpHJ/IR9o1cycE9gerttaUyAzvsIy9kWNyj0J94b2eD9TWIdrwjVsv//eu3792ac5H6C+0PRtXY79P/2eqKHEq8Dys5tHXqjxZcxPyWpBGXBMgIYBjQ6lQCo9xNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753957067; c=relaxed/simple;
	bh=hM+vN759MW7T6McUKOpE6yy0OUNkDj+vOuX1teluI7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sCz5eN6dtaRZbRBwlc7BuIIODOrjkS/t7UiBPY51q7rezF6Kki1NPevXEhj4CGBOVyd019H+Ejp5lasqoEYlcIXa5qfUtt6ShJwH41+hs188w25s22rxP6O3y+FE1zfkpYriC+K2yDRJiQgeoG1RWZZJqmQQsClhChMNgp/Xx2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XeaVayyu; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b422863dda0so638953a12.3
        for <stable@vger.kernel.org>; Thu, 31 Jul 2025 03:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753957065; x=1754561865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBDjfpxOp54359rJYp6X3VeTm/Gx2u9kuRZ6HlzBXjQ=;
        b=XeaVayyu9lgpV8GKWdqTh4nS9DNC81JyFjbJiY+H1569OxQ3pQUx8q+5dfUNYXL+Tt
         R78Hyg4PaYJ39oLAdTlckxkPwMj1J0ZV1QGUG2RDLMcSE5lMHKTzkcgp+ZKV6ra/LEc8
         gdDkWa0tA1AV+A7zKxbF0D4EosP9+XC54qReFV7X4qJi6CwQjAPolm7S2qvCFuNXEzku
         FjXg3a6ijcu9+pUohpuNn6Z+NSGhwh6tVxuN8dpOjIuiQ/VQh/cggeyfipajz7Ea/c6V
         0geNYz16gaGzob+sQSDD6g/FeiyqL1os5CMuWTyiJHU7QKwPoJJpRxOzoax606xnpsd5
         U6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753957065; x=1754561865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GBDjfpxOp54359rJYp6X3VeTm/Gx2u9kuRZ6HlzBXjQ=;
        b=vzahwocODRnQG9ZGJGpWRM7EZhH9e+dN/0d8up+rM9IMGwiwdfg6MKNwPR1hQyTwOY
         7E9XsZNTiuTny6OPWxnJ4Qbso1gZyrY17tpEZ+G7pqKNRzPxNP4k+50gw4yVF2BIFrnQ
         uVXf0SxkEUEaH9++vPw9dYYidx2Wc4RbyACDLNLsTqSi9WMyrDOlVpbA4CbT2FK9vqD5
         FDv7JKpESOUyNhyk9R8RkMu5hlf8vpjlnkYcFuKMpvl1teVqYm+9mxo8oQHdC1/5ftJi
         iK45mv/wqBwfQEb4I9kHNo5PWojyIQ62YrMXIgI5PY+k9xzQB+jiif4bhQPlruWSwDzn
         vJdw==
X-Gm-Message-State: AOJu0YxASnmhbWeXUdNsNx048Fc63bKgfYIl3C9c94y9XsIxYnvAVSdH
	7sMjkaxYj2m0tppdWqao0MX7cJb8fT5zejyLg4basv/NXGr3v0VaexZAAkw1RIvYdIifVsMp82u
	/73l9vA0NYJ6RZnu0LQH3hICm9jEdukFNQBuKGv+7RA==
X-Gm-Gg: ASbGncv6IcLbcnP/r94eaAoXp2Z8V9J+v9f8eVdnuYerMqPVEzuy4yEpxvF59KxjkGb
	4PYwemONGTgX36gbUh5mzrJczx7wXqSSaN6ZKgRdHt75GYx8+crLDG8/tl3/3HkXQp7WckMT9xf
	mzsurXz6wX9J5WrIiKA0jmBEanfD3m/M6tQSQ+eVL4nbZS9eolfjGEUXanlDHWC8n0ORX5ALWpk
	S+3Rb+3AFIG7ige7yYpFKjF83D4gTZcKAP1HeE=
X-Google-Smtp-Source: AGHT+IFY7rsm5nJyelCwk45krzeSFkbdT/gaZZRziQDcrJRc1YFgekz9X2f2KbRKja2X5oCfA5pSOZbTF7vEdnduGXY=
X-Received: by 2002:a17:903:2347:b0:23f:c005:eab0 with SMTP id
 d9443c01a7336-24096bc792dmr90043015ad.40.1753957065109; Thu, 31 Jul 2025
 03:17:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730093230.629234025@linuxfoundation.org>
In-Reply-To: <20250730093230.629234025@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 31 Jul 2025 15:47:33 +0530
X-Gm-Features: Ac12FXzoAr2go-p-IHVBRyqSrYJLPAOBADLHi4dKBlyrvcJyd0ZMa9rnOXK21mE
Message-ID: <CA+G9fYtcgEX6gw6xV2hAT0ewbUbf0LWzv56QUQzT4rGw+dDbxA@mail.gmail.com>
Subject: Re: [PATCH 6.15 00/92] 6.15.9-rc1 review
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

On Wed, 30 Jul 2025 at 15:21, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.15.9 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 01 Aug 2025 09:32:07 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.15.9-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.15.9-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: d9420fe2ce8ce7d6f2f74f9b6608740432483932
* git describe: v6.15.8-93-gd9420fe2ce8c
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.15.y/build/v6.15=
.8-93-gd9420fe2ce8c

## Test Regressions (compared to v6.15.7-188-g81bcc8b99854)

## Metric Regressions (compared to v6.15.7-188-g81bcc8b99854)

## Test Fixes (compared to v6.15.7-188-g81bcc8b99854)

## Metric Fixes (compared to v6.15.7-188-g81bcc8b99854)

## Test result summary
total: 331512, pass: 309941, fail: 6639, skip: 14932, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 138 passed, 1 failed
* arm64: 57 total, 56 passed, 1 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 27 passed, 7 failed
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

