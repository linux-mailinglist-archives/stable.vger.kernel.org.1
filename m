Return-Path: <stable+bounces-110255-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA44BA19FE7
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 09:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 559737A125D
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 08:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD43B20C03B;
	Thu, 23 Jan 2025 08:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yPb9shSm"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D3320C013
	for <stable@vger.kernel.org>; Thu, 23 Jan 2025 08:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737620831; cv=none; b=OrLwni1v1m5ughD2VCMmLgYO5Gf0rb/aIhFfBkReaEWteApNhNLnZXMneNAH1gP7o/WmxrUzSxLR199hXy12GeqtYDsG5a9bdLxsspE1YLRE5gkDpz/8gVYe8tOwHYnHgPWBma1tVoCtBAFJdxmj7quq3tCNbr9DVCGVcaEzVMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737620831; c=relaxed/simple;
	bh=L322Utr6J8zVV4lpTR+PtuxY5mRFcRCy5yeMqhu3irE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OrjreS3fxat6yoA2GJiWsdxgt6JaRj1lxYSFQQTV+lX6Z069SBRkCgFh4ZXKgFtYQM8dxpWKwbAANu7p/Qmz2X27lIAfQwTKjmsIQ8I9foyeO+UbqQTxNZVGoCZAGbxgT2Mtjl7ZfxojMgRgMbhLlgGn+zbiP8f695EuFHMPQSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yPb9shSm; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-51cd9115009so208627e0c.3
        for <stable@vger.kernel.org>; Thu, 23 Jan 2025 00:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737620828; x=1738225628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6jclPLjrwga2DiBE7oCd45pavQD/4g/MMHO5//z3b4=;
        b=yPb9shSmLRnkHpenrNlTnVJKj6PyfK667tzhLPzcbG3f4S6OvZmmgxh4BO6bE58cXt
         pNmqx0lvCZPGIQWLPyVf5HIZ4PKxatAD+NYTvjV7asXoaEPsEKj2Qt16Z5NDTRHCrWEb
         yYiHgzDBgNMw79LBCG4hEMdA/1SYHvhe8l723Nz1bEftRAHG5I6mLASzxcpfInRIzPi3
         5Kp1KhsqoYraE4GCk2nezPGqRnztwWLegUZr3yLlrm8kynPF9hXR2eUdZof2xjM+rt3+
         vCXEBddgCMhCnT2XtVaWc1Dh45W5y3BkPnQ/3wuZiVogDmPW5u1dbgqIv+s3i4nQyrQL
         rxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737620828; x=1738225628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P6jclPLjrwga2DiBE7oCd45pavQD/4g/MMHO5//z3b4=;
        b=szyht4I0wldPS098EtU/Hj6xlwLAWWQH67kUTdgN841kUeVTrzAdWo9uuAAv7L4dnb
         YldI2xwd7gR4HMxn3JsGMN7WvFMNAo8Rj1gQsAt76a9AB2LUcmPhxLtbVZZGXi4Zd/th
         QbnBLQsPO09mdAFBqEIRYu900UN9/mdhkKAE4RZ8z9bMknxg7gFbTiJV540Cas1wUxpS
         wkHw4BCeOmUpCee6IpVfTXl2q/rF+oc9unysArgraLxA+kDLh0wUcyKF1FETuFJg7pIF
         j3hphuQo3PKyj5fHGtzSVpqWSPT0i/jJCudSEkEv4xwGgtI3R5j4Y5iRbp2+4Th0sQun
         hU0w==
X-Gm-Message-State: AOJu0YzN/WTC8cK4Y0jd1EpA41s/WdL3MXSt1FWvgbbHkJ4l225pp3CO
	uQQhOsJsenQ5KFGQ1pAf4rdouHWmWBwlCj5310QE2hJTSE3ux3BMbqIc6IVDFOiWlrWi2vfmxU9
	RhwgwyxPP5zJsZNYlwZ9hFOJijkYRx5bbXNgluw==
X-Gm-Gg: ASbGncvESuVNyJn8wNWTsiUnJ925t5UvXYusKb0ussnTrJSPQFlWWEQLqkEpLhr8Ikf
	AJYn8gxaUtW/qFVjVPAiVNadUG9yhi5KMt/kPUritmCW9R7eYoKti5cJVYf+/Rbk=
X-Google-Smtp-Source: AGHT+IHQm8f861mhiPICLot9dmANF5a8TDYEm1Zvl+JaFZN/KfkIuLR0vWEvxdP92bFL5poM5v/usA2MXSxvoECS9lk=
X-Received: by 2002:a05:6122:4fa1:b0:4f5:199b:2a61 with SMTP id
 71dfb90a1353d-51d5b30c771mr21183949e0c.9.1737620828020; Thu, 23 Jan 2025
 00:27:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122093007.141759421@linuxfoundation.org>
In-Reply-To: <20250122093007.141759421@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 23 Jan 2025 13:56:56 +0530
X-Gm-Features: AWEUYZk2YHSIi9OyXlh8K5Gbw7CUiK8lE3haSlXHvUFB4un6zyfmd5icX109F_4
Message-ID: <CA+G9fYuev+wW8U2-d7QZ6tx+TxqLmPAshw63UgdsDs+_Q4zvcw@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/121] 6.12.11-rc2 review
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

On Wed, 22 Jan 2025 at 15:00, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.11 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 24 Jan 2025 09:29:33 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.11-rc2.gz
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
* kernel: 6.12.11-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 0bde21f273434bad90411f296c22f02c62c07b2e
* git describe: v6.12.10-122-g0bde21f27343
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12=
.10-122-g0bde21f27343

## Test Regressions (compared to v6.12.9-190-gd056ad259f16)

## Metric Regressions (compared to v6.12.9-190-gd056ad259f16)

## Test Fixes (compared to v6.12.9-190-gd056ad259f16)

## Metric Fixes (compared to v6.12.9-190-gd056ad259f16)

## Test result summary
total: 114776, pass: 91853, fail: 4843, skip: 18005, xfail: 75

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 143 total, 137 passed, 6 failed
* arm64: 58 total, 56 passed, 2 failed
* i386: 22 total, 19 passed, 3 failed
* mips: 38 total, 33 passed, 5 failed
* parisc: 5 total, 3 passed, 2 failed
* powerpc: 44 total, 40 passed, 4 failed
* riscv: 27 total, 24 passed, 3 failed
* s390: 26 total, 22 passed, 4 failed
* sh: 6 total, 5 passed, 1 failed
* sparc: 5 total, 3 passed, 2 failed
* x86_64: 50 total, 49 passed, 1 failed

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

