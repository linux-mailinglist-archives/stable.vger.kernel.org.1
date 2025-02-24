Return-Path: <stable+bounces-118710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F68A416EC
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 09:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEC883A6F37
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 08:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B231DAC81;
	Mon, 24 Feb 2025 08:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WDtL7Ii3"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD13217548
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 08:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740384631; cv=none; b=MZmVgiSVfGAu2FJOhy2iwA6KEMGYUFA3x0HT2BevZWbXGgHFpJVkoB7119aPy7D0Kjhz+PLEUFS7ACokc0Z4SafIpX/l/3urxWOnOoh657ygmN9kVDbkyz0/3aknplHLa4ONoYjFZE0CAP+M2xUckcLXrUJ/6yNp1eVKRRCgT10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740384631; c=relaxed/simple;
	bh=u8TrK9hYcC65/WeviX8JWvUBq96uK8ZgDDuf0b8u/ew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KImR5MfDIEA71Si48jFv9rqdM3HnjjmHf7LB3YDOd3et88IN+UVHQ2U2KHUwCnx4hm7JNItYRsg9gyG8UtSGRFbkWDblJec25mBwEcBkMtXdRrETK73dsj587lo3iPZG5Lt/nFE0C3XtL2KPgP5XufwNLk7cEn+F9qNDZeg/2MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WDtL7Ii3; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-868fa40bb9aso1244686241.1
        for <stable@vger.kernel.org>; Mon, 24 Feb 2025 00:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740384628; x=1740989428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rAfh0+TUi6TP02l6JXkpyL3aEAeCTCEFN0Bf4ro6c4=;
        b=WDtL7Ii3e5ZCQ+E5MAdnHj3IMXVFC4PGp9uY9bQZ6doH2gSTSW7u+wOANozq0gjsBr
         A1rD1fgXmpQd0EJAXfE+rABAsKDmjdw8q6c26SUXqc3oRc9j4ldslefh7K69bcU6rn0M
         m3KBevC0UK1L2BObnjH8uYfq8E3PQwzYYSx6csEdQZLgQHUCwK+HLppkZ09QJSn+O1Fw
         bxYlxavX7rIyGT/hgrcSJbyOBkhphWv6zXBHPO/nrCa9sY5OGIGT7TkYA+OvhQRN4mny
         H+sFi0qS67k1WYO4sd2pYRWk2XWrGxXrMZJDwidFlj19EGqEhZhiBq7Is7Nr/4vAox9Y
         58Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740384628; x=1740989428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5rAfh0+TUi6TP02l6JXkpyL3aEAeCTCEFN0Bf4ro6c4=;
        b=XXcQ7CZGKdcd+hNFSt6UIuAYGAtpaamq+L85qMbiK5pZJTZWGMYHxL/psCZOK2h7G8
         Gzl875RixPG7m0/4UG3mDJei0IczJM45ZvuiVbQ6R/3cLg1l6IDhurH0c9dH2d3XV2ND
         Zf8vgaDUdU2Kv6hdphQu9JN7ZZh9CyzZAEKDSS/avMklRI+AJNlL2sTJPoBbEHyqLweR
         blzm2xdgD7EAOXF7ZEdtOhFV1WIWJGllRak/upxYW+VDPs1TN1iDiRcJNT11HboRN/ZJ
         vaqAKKurpooAXOoPKD2JisqT0jQYU8GCLWzwgTMXmasf8gBJARJl0o47UpwsgZz+2cOO
         plHw==
X-Gm-Message-State: AOJu0YyQpfsCom4NnNNEzgjak9N3yoQexve3LsUtn6W1hX8eJSSyZw10
	EkW7F+X3l0/Oro2QO8sBc5WYow65uX50vBjtw+DINNdDEeN35rufSbXLQI55pszECA16znUyr/q
	wmH+fXkR8Rzx4bpr0ZoPh1OdB9ZcwE4oEuVameQ==
X-Gm-Gg: ASbGncvlttsqYP+98qwqoO/6T1Xcl/qJ8Axck+a07i2ygjhiiT8iZ1d7Yg7JhDOnEuu
	/pmQfhPDIxBt7dOT/cdfgS2CcsaOELaJiGZpNq+vQKuBIDr5g+6k65dipex1FJDKrzFo2JCIhc7
	W1spmj7jvdpxXAs2Jlu2gg4eE085OwA5h0ShoRL6XU
X-Google-Smtp-Source: AGHT+IFtTzjpecd4WNbfJBrPmnNi8gxRNYitwtUYtxG//98YquxYsUWInAxrtNW/QbRt9da1gEn7CzWKqroyZsH5TV8=
X-Received: by 2002:a05:6102:c8c:b0:4bb:e8c5:b172 with SMTP id
 ada2fe7eead31-4bfc0098918mr5692399137.8.1740384628553; Mon, 24 Feb 2025
 00:10:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220104545.805660879@linuxfoundation.org>
In-Reply-To: <20250220104545.805660879@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 24 Feb 2025 13:40:16 +0530
X-Gm-Features: AWEUYZkqBO2UQkfmgOsDe-rD71hPOBWtwJTpV4dFszBoXqdjV-sFVpZiDA8Hqo4
Message-ID: <CA+G9fYuoYfGft-2D88dCVQeB5mTvyf6ADkWau172BZs2SD99VQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/569] 6.1.129-rc2 review
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

On Thu, 20 Feb 2025 at 16:28, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.129 release.
> There are 569 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 22 Feb 2025 10:44:04 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.129-rc2.gz
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
* kernel: 6.1.129-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: fdd3f50c8e3e56aa4407011c21e440d1f39bf99f
* git describe: v6.1.128-570-gfdd3f50c8e3e
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
28-570-gfdd3f50c8e3e

## Test Regressions (compared to v6.1.126-65-gc5148ca733b3)

## Metric Regressions (compared to v6.1.126-65-gc5148ca733b3)

## Test Fixes (compared to v6.1.126-65-gc5148ca733b3)

## Metric Fixes (compared to v6.1.126-65-gc5148ca733b3)

## Test result summary
total: 104367, pass: 81540, fail: 3794, skip: 18597, xfail: 436

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 133 total, 133 passed, 0 failed
* arm64: 20 total, 20 passed, 0 failed
* i386: 26 total, 22 passed, 4 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 31 total, 30 passed, 1 failed
* riscv: 9 total, 9 passed, 0 failed
* s390: 11 total, 11 passed, 0 failed
* sh: 12 total, 10 passed, 2 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 32 total, 32 passed, 0 failed

## Test suites summary
* boot
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-exec
* kselftest-fpu
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
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

