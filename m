Return-Path: <stable+bounces-163094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE55DB072DE
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 12:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 602D53A998E
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 10:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E612F2C67;
	Wed, 16 Jul 2025 10:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NS5tQ5rF"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8C62BDC02
	for <stable@vger.kernel.org>; Wed, 16 Jul 2025 10:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752660768; cv=none; b=JYM3bPFXisaneTvzD8ZAzVYUDCQ3GGfRnf9nB4AuF7vZCvgQj6ONBRN96Cxy2bFk6ETQS9emobhg3NnXYUS00cQW9k3Cm2MwRKDjz8wFe5iTzQxHmK9ONnXdzh6n052gQb9Q7cjr7mIGgeKA2LQcOi7fmkc+AOk/HBOidNx89Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752660768; c=relaxed/simple;
	bh=BWD7VdphZFHKjWplKHCzBxyRhgPY80wzhcSlGMcOMuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CmZIlmWVbAJ1c5jzslv9hp49AyCfu91traydeLiGtLwedLqexsydv3UFLGx1EjKFa5OlwkBsxUqXnHObqjo/OznNRX/n+3c7TPIwipRZ2gFIVUvXZjShe2UJ053N9x2Fb6FVcF4IbbKDIjoDZ9+uf7FNVbPLY9xibVX1rpnaHyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NS5tQ5rF; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b390136ed88so4778867a12.2
        for <stable@vger.kernel.org>; Wed, 16 Jul 2025 03:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752660766; x=1753265566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/nyoacKNVKnvpDrNZJPu1NQrh/P0H/upYyJl85ifJE=;
        b=NS5tQ5rFqCo8jU6cQ5S5s7dKTcslga6BQotMiAi64aDMzisn6B0cwLfgAi9nV+ZX/d
         f+phXcxKRZihx+YUyfLASWPc31ZRgg7sOz4k73IfBHupCIonZrwPbHospi2ZTY55gxC8
         AC8HtevVADDmx/vtAthEdut8K40Yzyl/Ydu5f1TPdHmKCqM37ILBRrzKV2nj2kZakFHr
         pD8l6qBsJ51BbqtDFS2ignPriXaBTOkX5HpHqi3GqFJhA1WGmq97y3u6s9AQjToPvjgS
         3MqDCNvdA+T+DMk5QPKbfQBR+epESzLD7v4APgtSvIN1ZMkmtZN9dUMyGbnQIN6hnDD4
         0POQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752660766; x=1753265566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S/nyoacKNVKnvpDrNZJPu1NQrh/P0H/upYyJl85ifJE=;
        b=eFEx5ENeJ5hfeLcRZqImVELUirXAYuAKdGzwsyqwuzH7cr9LuUSisL562ohMuLhmxv
         Ym0o6K2uLjs2QT0Jhqna0YGDoZ6hYshB7UZG0AiBg0LbDFSYHXo0gtHSNbVwmYRdQXDB
         /wLbVDAjJRfQBxjMOExKEaFIQa4rlaDKDjp94Ru6qfW6A8Gijyk/KHNc9/rlMkBClyZg
         G/xe5qESd9mjgXXNsDlxADrI0f1T1iapx1+0BxihRNFVZKrtEFiwNC1VtpR+8ZNzkPBg
         g9qGYSmoAPBHMmSMl+LZxD7hNRqM5OHk2rtP+jzJ9ke5MygT+1/4Qkx/EEeg3bUQ8esh
         I0Wg==
X-Gm-Message-State: AOJu0YyB+r45LEyY64Viv6Ns6QLgETwD4XuyPN4+uM/NS1A1OUakyrwx
	WHw+iQRURnr0fSCG0vQRbCVMrTgKVUnZxfZ+qPNjAM0hfBLbMMkSdfi74SqnhgJ0lG198xxf4I4
	3bjV3Mnrxt9rDhYIxKU9V9gK7WOA1LvOW7KJqlO10AGKImDYNm4HZyC0=
X-Gm-Gg: ASbGnctRFxYu6sb57Zm+wU3tHBWHt9SZp72oP3MbRrl8AgpQeov/8ebz6DReNNfJCSB
	aCNOCDesZVNaKPqqDJv+A/PyWRM1DGK3dS0JQW8v0UMsMBpvuqFKd3GTNK+wp4YzweYi+60XkcY
	QNVBHWZ/6aZVv3bSMEBUucjorU5IECiIVYrkSJe0qICoYcqKgXeFMYQWsMTFE20aswdrJp2WQlg
	x24nmKSM+HvmkTcxMYpLL5PHu9lPfkuyY1V/Rx2
X-Google-Smtp-Source: AGHT+IHCb0k2dykBOSZ7iL2W5iDfYWIbDtl5cle0JXyRlnUFOcIwORjGAq1Aqe8xopL+PX/SJAo/C08ZtvLFCmyXFzA=
X-Received: by 2002:a17:90b:5587:b0:313:28e7:af14 with SMTP id
 98e67ed59e1d1-31c9e75a6demr3312358a91.19.1752660765786; Wed, 16 Jul 2025
 03:12:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715163544.327647627@linuxfoundation.org>
In-Reply-To: <20250715163544.327647627@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 16 Jul 2025 15:42:34 +0530
X-Gm-Features: Ac12FXwjod6LQ65gQdx5Ie_iLGC16oEaTsSpUdM10nJ-9OVQaXU9hzDA63_xjg8
Message-ID: <CA+G9fYuDFgV--q+e+gZe0heZeGsc1+wxkXTV21dUR7dD6AByjg@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/165] 6.12.39-rc2 review
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

On Tue, 15 Jul 2025 at 22:07, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.39 release.
> There are 165 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 17 Jul 2025 16:35:06 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.39-rc2.gz
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
* kernel: 6.12.39-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: d50d16f002928cde05a54e0049ddc203323ae7ac
* git describe: v6.12.37-168-gd50d16f00292
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12=
.37-168-gd50d16f00292

## Test Regressions (compared to v6.12.36-233-g3d503afbd029)

## Metric Regressions (compared to v6.12.36-233-g3d503afbd029)

## Test Fixes (compared to v6.12.36-233-g3d503afbd029)

## Metric Fixes (compared to v6.12.36-233-g3d503afbd029)

## Test result summary
total: 320456, pass: 294460, fail: 6894, skip: 18627, xfail: 475

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 137 passed, 2 failed
* arm64: 57 total, 57 passed, 0 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 40 passed, 0 failed
* riscv: 25 total, 23 passed, 2 failed
* s390: 22 total, 21 passed, 1 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 49 total, 49 passed, 0 failed

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

