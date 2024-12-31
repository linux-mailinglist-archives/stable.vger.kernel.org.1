Return-Path: <stable+bounces-106610-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2119FEE91
	for <lists+stable@lfdr.de>; Tue, 31 Dec 2024 10:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9E913A2111
	for <lists+stable@lfdr.de>; Tue, 31 Dec 2024 09:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F2A19CC1F;
	Tue, 31 Dec 2024 09:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u2CHxj76"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCFC199EBB
	for <stable@vger.kernel.org>; Tue, 31 Dec 2024 09:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735638307; cv=none; b=eA1t2ec/4zr2GlVXPdJtZK5Olzu9L4UQ+QzwXmox/trCeMj57hFpVq2oq+olJKo69858Cx1yGhKKnvDS55t9nd9eoxKFxmr9WyvYAWFkFdHqQ6EDCmN55oQyYjMHKY7+E4V3+4nDrcqi4VjU6hyLcnyEOJaw/b6gjycjJ1u+hd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735638307; c=relaxed/simple;
	bh=vZzXRSW8LNmKF7shAa0pA4su8bnEZsaXYeuxwqbkaOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nPap6VgqJxaVQOcMMoqVOZf3DCXxFfGcY+v4hJBg0rGkM3fwVAzIC1PwqbdpWXg60iwS1LtzO8nR2pzaO21JCtLuHvpJtc9/fM0r5PeTjSvXsL2nGUvITkZlUMOECP7t14AGG7GuUNuuQRP/GGIEi8NfS52EDjVyn8Tu2p541Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u2CHxj76; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5160f1870f3so3083115e0c.0
        for <stable@vger.kernel.org>; Tue, 31 Dec 2024 01:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735638304; x=1736243104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJ1YfmX2yTTzmASmFkNHi9BM3gjTBDFTOWrs3hxm6Rk=;
        b=u2CHxj76MJXl4DTsMc1owPv5XPMHujEsc4pL34ZrOtbxXQpfZF4N86xuTzAERFKHwi
         Z6OHgC4AimGqqVUBjQBD8hZhcsMnlqGqXkLCBZzWPbGIlheVxrNOTQWPA585UM+nKMAf
         RYfT1RMu+IQfhALSB0cV0TPyAcKBhpMjQQo9xVxcb7rM5sDZTTWi33CgJ/2F79utEudb
         jIYRzlvqTD0KlCveyplZLS8F3eWo9ApfCyqyYC8kWcT0KO31zbCF+7Ecf6M0BQKnfy3u
         7AIpsPmJowo0wNE+00acUMLuxbRHX90523nu5xGNRjjZ4lm7fp2BBWUMHz556y1Vm43g
         X0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735638304; x=1736243104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJ1YfmX2yTTzmASmFkNHi9BM3gjTBDFTOWrs3hxm6Rk=;
        b=v8orMUUZYNztlKjmpvrVr9ZT8Yelu5aEGr3H5xGrJISMpvCWDMHIIw5Xrf9At/T9bR
         +U9bRpcSViXqIO+0t4x4hNlaN0qsz/Z/X6JIzyKrK58Sn/TdgK7fZoKkGKtHf/Dr9Gjj
         copQeB1LwQ3b/juWB+dflo9MsO7pR+vleCTA0gCnmZaBpC5EDvTAxkkPHDW6sYpUlIpS
         D0WDULgxRyDBOUHI95q5PM3tjvoVtQJ9D3FpKTDSlbuVAQTkU6C4f62mson+PXd4Vw3q
         nr5ZX4gtnvYM02ISFMuPkkJV1WhiKybofS+Xg59G17FIV5OaSrwjC0cP7OgtxLfmoxJP
         1fGg==
X-Gm-Message-State: AOJu0YxylG0vK8qGBdBMCHM7gv6qUejHXbSjeMbT7aeGfCQJvOTppB2U
	/OxW3FT+WoTfp1BJ6AK2aS6OmDpcMSilDNnUlfYSaXGQbsDn1GA4z+OnKHysqb+p/LrOwV3+Pkl
	E9tClYKoUsKgd6z7R/yR3zLeBoPIcKtxzem24jw==
X-Gm-Gg: ASbGnctL7uB49elRQwDpUxuilcDAIM6RB6Ur7AIsEGwAci/a+Wz/kCRhVu4MS+TEbkt
	kIE/lvBJAocfbVLlVw+p6pwAfTa7GQGeeva3q1V1NChkN+M7cFMjfd2DcgbRBv0ZJHb1uWJM=
X-Google-Smtp-Source: AGHT+IFDThRheLm9ugI2RUUmmJkz1dEPU+7fmTpZGyI2alfuX0n1UnJfxN9nHjSlRuvd4Y/HRRLdxaes2sAGfoYOlRo=
X-Received: by 2002:a05:6102:5123:b0:4b1:ed1:569d with SMTP id
 ada2fe7eead31-4b2cc4afcd4mr29331894137.27.1735638304569; Tue, 31 Dec 2024
 01:45:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241230154207.276570972@linuxfoundation.org>
In-Reply-To: <20241230154207.276570972@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 31 Dec 2024 15:14:53 +0530
Message-ID: <CA+G9fYvTpk-FRH1Su1C=YGrz_Lihi1UONjUOJL4zTsJgco4JjA@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/60] 6.1.123-rc1 review
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

On Mon, 30 Dec 2024 at 21:15, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.123 release.
> There are 60 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 01 Jan 2025 15:41:48 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.123-rc1.gz
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
* kernel: 6.1.123-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 519f5e9fdadee615a2a0e2f03840ddc2c938c9c4
* git describe: v6.1.122-61-g519f5e9fdade
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
22-61-g519f5e9fdade

## Test Regressions (compared to v6.1.121-84-g7823105d258c)

## Metric Regressions (compared to v6.1.121-84-g7823105d258c)

## Test Fixes (compared to v6.1.121-84-g7823105d258c)

## Metric Fixes (compared to v6.1.121-84-g7823105d258c)

## Test result summary
total: 113502, pass: 88713, fail: 4842, skip: 19868, xfail: 79

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 138 total, 138 passed, 0 failed
* arm64: 44 total, 42 passed, 2 failed
* i386: 31 total, 27 passed, 4 failed
* mips: 30 total, 25 passed, 5 failed
* parisc: 5 total, 5 passed, 0 failed
* powerpc: 36 total, 33 passed, 3 failed
* riscv: 14 total, 13 passed, 1 failed
* s390: 18 total, 17 passed, 1 failed
* sh: 12 total, 10 passed, 2 failed
* sparc: 9 total, 8 passed, 1 failed
* x86_64: 36 total, 36 passed, 0 failed

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
* kselftest-filesystems
* kselftest-filesystems-binderfs
* kselftest-filesystems-epoll
* kselftest-firmware
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

