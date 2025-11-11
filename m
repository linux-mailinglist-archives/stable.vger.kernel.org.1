Return-Path: <stable+bounces-194459-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06256C4D2B7
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 11:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81201189D183
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 10:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDCF351FA5;
	Tue, 11 Nov 2025 10:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eMlD9tXU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A07350D4C
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 10:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858094; cv=none; b=fE7vgFbHmdC6faVDVP4YInAlENWwLbxUni9ojuBkA/fLBggQ2Yp1uX+rZYnWf8hde+Gmcc25YoxasKcVh1cWDNk43snWTDTMc+bdmSF6G0NwoobRSoNdS+Fs3ZCA7z3Gg7YXFFgavHkMk4hjSaCzj7203itAUg1S4YM0b7sZ9iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858094; c=relaxed/simple;
	bh=bD+R5u9IlPvwBZGtlBwpRrQZGIJ6U/j8hSw8QCdfnSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o7hect1EVaUqo884CBGYf5r3uZyIYZdAbsp42bpPWn5JBOY1z1d4NR9EniLF27VeLvwGTBqSQJPj6bzcQu6l6dcrzYX/XFzxQN0fmQjZDyWK6s1jqhPuEGhdleMkDTCvEXhAQ3ittuDIbTMUinnfj2lOqEFtNWpfY3s+9Ts0QkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eMlD9tXU; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-297dd95ffe4so31192665ad.3
        for <stable@vger.kernel.org>; Tue, 11 Nov 2025 02:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762858092; x=1763462892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ma0936PLaG7xVo6vcy1wxniBnOai4MhijJryYDzlRRA=;
        b=eMlD9tXULfFexZ+T91DhtpgeRCjqkFFvI4GdTc+cZvM0AlZ+LmdeQSLSH9jHc3oQme
         jmSsHuz85YQC7wXg+nWjCDrQY8UyalzuFCVnfEBUrE2IVUqYNA/vDh3SRuhx2jDGuJKu
         QkYDLeJ/uZsSqGsJ3i9PVqVj8mDWvLUQbre38NnkHiY0BIj1vJWSJRqXZswzAFHgDEcV
         UulfZwtdcLfCbby1yw7X2TOebv7ivwuuo/wNzxrIIVD/ArfMirfUY2lpQfB3MxEDnDbe
         AMb9ubx6QxnJ00pdxmEu2xGZBgBJ8s40b+9pfXGrvyjJL9y5XqmR3+kV3MiwNI2Cawr8
         p4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762858092; x=1763462892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ma0936PLaG7xVo6vcy1wxniBnOai4MhijJryYDzlRRA=;
        b=wLwvVmr3speF1cVnSY7cM2gW4Znl+ZQURPBgeQwg4MylyBoW+fzBAjS4f8pGm+NfJk
         QuBJdhA891Gco3p3kxsiqwUX1cXlYwy9B1bapWr9tY8vy2rjGZ3zktfFbuiXR3lh5flS
         39C4pEXTNjXJKy9zQhcRKJDK1ULYdrWfTRwwLeDRFZZZmEORbG2cqSjx+q+JHFlAHoAv
         H/OLmgUBUsMzRFCsymmztCbFW+GhY/Fqbiyukc8j5JSRZ1EDXK+N1HFJEQL5QjRxksEC
         eS3pvBoRxcYGxeRAQWUYf9enabgid7hgA4wQdCEd9zoBTet0E1ado9fBVMkVTJdLSjG6
         +DEA==
X-Gm-Message-State: AOJu0YyUAHWSJeHjb2WOnh9SbhsCoEH4DJyOQcKbppciqKlhgyQVWWqZ
	tffuz137Fd0JH59AP02sJm8BzOhsqAIsw4eDCcywGX2fZ5znRCurbdjjXg8eXgDvRJpWAIsOuof
	yNBI1kSFgyxrmS7Ypjo/bVroApmiJ/xlaJ0rBJgF6rw==
X-Gm-Gg: ASbGncsrkw6jHFZs7+6p19klG66i+ufYcCitzgxdFpMbGJAGqzcFq+Qo6wonvNN7uve
	u+Shi+YMwZxYwxshbxw2qDEq+kRCN1hWwNkPMx44vNb12uW58YmqALY9wnT750VvxDP1NTZoG/D
	IM6i/VoAFani5HAMq1KcoA9B3d5zxfxTdVorkpFePmaV9lgNWgtdXY+baUtwWj2nVV4ErkDBIcP
	lxBqPePw0r9k5tsB/KdYW9y4qqzzAJsMPybEMjIEGKmnf8ff2krv7Mwm0K1MnEezNhvTTtHemge
	hBxTLN6fNxfPp80bTagUxhc1ju/D
X-Google-Smtp-Source: AGHT+IGlxZ3D/M8Qal50sIGorQGC2iE46S1vgJuEvrgOBj6Q/H48IKlRoDRYSyp8cXr3EuE7VIGJ78ND1PHoKyJVEVk=
X-Received: by 2002:a17:903:944:b0:296:3f23:b910 with SMTP id
 d9443c01a7336-297e5619f92mr130510975ad.9.1762858091667; Tue, 11 Nov 2025
 02:48:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111004536.460310036@linuxfoundation.org>
In-Reply-To: <20251111004536.460310036@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 11 Nov 2025 16:18:00 +0530
X-Gm-Features: AWmQ_blF9FjAmnxDm-OEcifjrwJ-MY93UlczB0ZdxrxOQ1Q0-Lu0Mfk5wdB590A
Message-ID: <CA+G9fYusa6ihh0LaYkFzZLoRMbEVm0U6DkHOxY9kXnh2mvB0mg@mail.gmail.com>
Subject: Re: [PATCH 6.17 000/849] 6.17.8-rc1 review
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

On Tue, 11 Nov 2025 at 06:17, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.8 release.
> There are 849 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 13 Nov 2025 00:43:57 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.17.8-rc1.gz
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
* kernel: 6.17.8-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: a0476dc10cb160082a35b307f8dbfe4a066d41ec
* git describe: v6.17.6-886-ga0476dc10cb1
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.17.y/build/v6.17=
.6-886-ga0476dc10cb1

## Test Regressions (compared to v6.17.6-36-g7914a8bbc909)

## Metric Regressions (compared to v6.17.6-36-g7914a8bbc909)

## Test Fixes (compared to v6.17.6-36-g7914a8bbc909)

## Metric Fixes (compared to v6.17.6-36-g7914a8bbc909)

## Test result summary
total: 126378, pass: 106987, fail: 4241, skip: 15150, xfail: 0

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

