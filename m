Return-Path: <stable+bounces-93638-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6E19CFEDE
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 13:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C15DF287A4B
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 12:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08DA1922C6;
	Sat, 16 Nov 2024 12:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Txm3fLVo"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC6A16631C
	for <stable@vger.kernel.org>; Sat, 16 Nov 2024 12:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731761504; cv=none; b=Sx3SHwVnH4rRH/AjqkgUXYIGah9RF9GRc48dzJzgtFpP4wZLxJKFND6U/BdRDKoGEfzAhBNz+1azC2CcIhruVq4VbzYI29UOC1FrLcQKP8TZxFeRa0NXRNFns5JOS/8l8RgORqYe1Ybc6JAmmrlWgOw0vr35Hls0yCueISjaCo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731761504; c=relaxed/simple;
	bh=yZ9spXyy1JHGFxTbJ+E/XSPQJIJou0UXNJ58XA/89fE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ttulrmawPKordQpk3FJ3oulllGSWD4V84NiwiOfujzW+aB5dWc5cFm7kdnz0OHN/MJ2mI8eY5dgnnfqY+hJvP7YHKKdJSxMRx065TTLFM9BmoweLCr4t7zBaSXQsGg6DufW2yjiLJoUgX9DRnBYK/xDdfCl/bNP78nlDKG4utGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Txm3fLVo; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-85700088a4dso73076241.1
        for <stable@vger.kernel.org>; Sat, 16 Nov 2024 04:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731761501; x=1732366301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gHVrsBBGX1xiJdji2Ax4tKFi+Wtxl7VnBxvhnAp2Rw=;
        b=Txm3fLVoXkB8v69+tBNh31v/0yIJJZOmUcL0wW6IlXvgQA5aQ7p0OodjyQ7fm2a6zm
         FcDlXHPDGu9SpNEWhgwCyQ0oE22hwakMnDS95wFhEJ5FAv79bk2vAsUP0jxe/YouRpTy
         MKzxL3YD36sKlDF7cT7dMHxL1PzVfJ/T4fiHj+MFTakPFDC67FnWR48OezPNNxZBF2M7
         YzWncfHlCefFqKucQeopWytMLs29+e2YrPy4hIsimve1tsNtpcW/or1meq8mz7r8ak1/
         plTyoyKTaq7edc9PFxZmu4y1+eWYoy+i48lL6jKztxMvechDHuzmcU0aocK+HdIZUOQg
         zRpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731761501; x=1732366301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1gHVrsBBGX1xiJdji2Ax4tKFi+Wtxl7VnBxvhnAp2Rw=;
        b=ks7d8S9yf3PZzEDdsHP/SIw+1VXgUb9uQwTn8dLt2k7X6RRAj3JH7PoxkqZmYp2xgh
         jAX/PIpmferu19RxW92SJBlQIB+G5wNSm2Y75d0rdu0ldAKCav5BtLlJYuDZKSk6I+p1
         4PZ0LYO6ejtZurFJrp0MX8Rzd3vo9iQb5e0cPJ7KrTnzG3nU93hr6WhC+ZMcXSk1clAc
         zbKENYw+hlT2eIN+5NFsHLB+NafqDGhK5z/H3iiPX43PD/g8qNR5nKCTw9SbZjCggisW
         7oILTAGxoWg4wYtvjVx0C82NEz8Y30+v8Vvu2aoFf7/1HyAthy/snHkkdw0Pqw3yw2+1
         lYmg==
X-Gm-Message-State: AOJu0YyBQx856eUaA6tJCpCsRstiQTzizVdM2fBDij7pqdVinglENjdU
	jxWFQhMh9/BuqBWT//Pb7wvVOnRN8NubI8r0sO9Tr34VismrfumN2tBYsc+o5MKAAuI62NoupeV
	wCTQxpbONSSr33rRyKrldnbX/At21PXiTephs3g==
X-Google-Smtp-Source: AGHT+IGKHfsegjA71cHf5q+QphFydcypRPh+ZCbZqZcBzqCCohTQJ3bMMjes+Oi1iKLmwyariK60DCyrq6WLrqc74lU=
X-Received: by 2002:a05:6102:54a1:b0:4ad:5686:21e0 with SMTP id
 ada2fe7eead31-4ad62c40328mr6417722137.21.1731761500832; Sat, 16 Nov 2024
 04:51:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115063725.561151311@linuxfoundation.org>
In-Reply-To: <20241115063725.561151311@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 16 Nov 2024 18:21:29 +0530
Message-ID: <CA+G9fYtsjLQOQFJsK8BBvEe03B+PJp0dSjpobbT+65Qhgaeoxw@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/82] 5.10.230-rc1 review
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

On Fri, 15 Nov 2024 at 12:26, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.230 release.
> There are 82 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 17 Nov 2024 06:37:07 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.230-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.10.230-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: d7359abfa20de2d21fb8189353e5c82b34ecc0e8
* git describe: v5.10.229-83-gd7359abfa20d
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.229-83-gd7359abfa20d

## Test Regressions (compared to v5.10.227-164-g5d5f7338c1ba)

## Metric Regressions (compared to v5.10.227-164-g5d5f7338c1ba)

## Test Fixes (compared to v5.10.227-164-g5d5f7338c1ba)

## Metric Fixes (compared to v5.10.227-164-g5d5f7338c1ba)

## Test result summary
total: 63187, pass: 46635, fail: 2066, skip: 14420, xfail: 66

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 101 total, 101 passed, 0 failed
* arm64: 28 total, 28 passed, 0 failed
* i386: 22 total, 22 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 21 total, 21 passed, 0 failed
* riscv: 9 total, 9 passed, 0 failed
* s390: 9 total, 9 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 24 total, 24 passed, 0 failed

## Test suites summary
* boot
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
* kselftest-sigaltstack
* kselftest-size
* kselftest-tc-testing
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user_events
* kselftest-vDSO
* kselftest-watchdog
* kselftest-x86
* kunit
* libgpiod
* libhugetlbfs
* log-parser-boot
* log-parser-test
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

