Return-Path: <stable+bounces-40074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3A38A7D53
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 09:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B7531C20AEA
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 07:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085C46CDA9;
	Wed, 17 Apr 2024 07:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qj1zIwYP"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2C8184D
	for <stable@vger.kernel.org>; Wed, 17 Apr 2024 07:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713339828; cv=none; b=cz4qnBA2dmIi0KUYYR2WmB2uZN8V1qq/MI+N9Sd/foisNPZcToFxvfKNAzrywCsIV/HZYoJ/EriiPZn35KkAPH8mk3T7Xp5Z82z1rYlM5fPA6CAQ59h7LNQ48fK9R7/T/BSM0fyE85NAvtqljnvWevY/ulaRpgrNRHK+RnGGUUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713339828; c=relaxed/simple;
	bh=h8c3gJb9ZG5Vj1Znka0shDUGDwvzYy+8bgKQ4ihTSRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EJ9EQQVfLHKZdz0L1VCvIkeOnJQEmGIkkd8LE5+v9P7mrfhJzTJbgs8pk1OCJQYcFc/6h96p0nVujcbnUxq6NQW9/lREQ29rQSNFvQASagtIGRiZMBYopezhsFzdhIqezEjpjIdPh65Gykg5mWvEtNFjzv2oF8/n2pjNoqpI9h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qj1zIwYP; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7e7b473bc62so1083774241.2
        for <stable@vger.kernel.org>; Wed, 17 Apr 2024 00:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713339826; x=1713944626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Phf0FF6NStVSDXIMMyMNZP1z+jfYnoekO6QoTXZR0Wg=;
        b=qj1zIwYPlt6xaJlB7omqQA7a5UnVRF38TI5yMi8HzSkghQ+oBiM6XeEXiN8NZLGHKj
         e9asYIaSa1LEg4Yixtg0hfH4uimOEtg9JuZxGcf3GyoGcCLeRvmuaeeOT9RfB7h6wHVp
         pT4cq625a6bhaT0HPMl1gweXvEioe5yO4Ln2VLM6+kVYGoq3vljM51RMjILWA78pKtx7
         JnV03Q+/AsgO5HCYFNoxqRme5dpq8kkBq8sYDs8mobmc+MPna7897E7rv/cq7egGjpnK
         sYo/Na973gnsCNwq+gJZBGaXXbnZFuX96Vyg70fBJDG1liawDtmt3cbIAEYQ7hDeD75d
         KWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713339826; x=1713944626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Phf0FF6NStVSDXIMMyMNZP1z+jfYnoekO6QoTXZR0Wg=;
        b=uf+e8QIi/5gVRVQspkXcpb1rq/f9b8XgLghLw7qN1E70eKj3DDcBaeODVGrpfr3j8c
         Fofjzfmx2IqbwyxQe7TRCeNOf2LqY1e3GeNUlqGc7TddBDSEfFZG8ZA1JxuNogcbictB
         DfV27BkE1XeB0f+bF1+ovqfhNqfkB301y++sq/vGomXLStCesxuc9fEicQ8py5mwZjBW
         V+kjlkSeSxoWYBoecvjjMMolVK07IFw+I/eHCdUWO4VHEhWTvD4/lZE2VfY7vJIldEjZ
         /UvdpLGj6thnxEaLFeIflPX1m7sTwgzC3O9nDJ3Smj0GuzHaR7e02KQc2CdcOOK+qS3E
         czGg==
X-Gm-Message-State: AOJu0YwZIbHSkR/pXA5UdSJaEA44p0HIzfF9LfHtZ4Zdyo5aVl1c8RxF
	LYnUdRMDFbmbjzNmLz0X6WZc0vDq4ygzTHwGswBvpxCelZceQ58HlhW25V5kZeJdrP1Ql2sfjo5
	btPt99L7RS8FattXLe9rFcshmS9H4xBBBM8Rb8g==
X-Google-Smtp-Source: AGHT+IGKIXyPa/nU2wtBFQ2i7XYjjJSCtGr11a/Jxi4Ce0+hrTHgJNre43i0/FxzDMGJ3Dw/GOVllDLGg6pbXxrS2Ac=
X-Received: by 2002:a05:6122:1d8c:b0:4da:c699:de98 with SMTP id
 gg12-20020a0561221d8c00b004dac699de98mr12138986vkb.16.1713339826114; Wed, 17
 Apr 2024 00:43:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415141946.165870434@linuxfoundation.org>
In-Reply-To: <20240415141946.165870434@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 17 Apr 2024 13:13:34 +0530
Message-ID: <CA+G9fYu=tSQw-bmr8eQvifTKV67H01H63R9qPEkY-RSFOxoTNQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/69] 6.1.87-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Apr 2024 at 20:09, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.87 release.
> There are 69 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 17 Apr 2024 14:19:30 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.87-rc1.gz
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
* kernel: 6.1.87-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: 6745a5f2c8063076bb5a9cd18ede5a5559258492
* git describe: v6.1.86-70-g6745a5f2c806
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.8=
6-70-g6745a5f2c806

## Test Regressions (compared to v6.1.86)

## Metric Regressions (compared to v6.1.86)

## Test Fixes (compared to v6.1.86)

## Metric Fixes (compared to v6.1.86)

## Test result summary
total: 237743, pass: 204447, fail: 4019, skip: 28994, xfail: 283

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 138 total, 138 passed, 0 failed
* arm64: 41 total, 41 passed, 0 failed
* i386: 31 total, 31 passed, 0 failed
* mips: 26 total, 26 passed, 0 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 36 passed, 0 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 15 total, 15 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 37 total, 36 passed, 1 failed

## Test suites summary
* boot
* kselftest-android
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-drivers-dma-buf
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
* kselftest-ir
* kselftest-kcmp
* kselftest-kexec
* kselftest-kvm
* kselftest-lib
* kselftest-livepatch
* kselftest-membarrier
* kselftest-memfd
* kselftest-memory-hotplug
* kselftest-mincore
* kselftest-mm
* kselftest-mount
* kselftest-mqueue
* kselftest-net
* kselftest-net-forwarding
* kselftest-net-mptcp
* kselftest-netfilter
* kselftest-nsfs
* kselftest-openat2
* kselftest-pid_namespace
* kselftest-pidfd
* kselftest-proc
* kselftest-pstore
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-splice
* kselftest-static_keys
* kselftest-sync
* kselftest-sysctl
* kselftest-tc-testing
* kselftest-timens
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-user_events
* kselftest-vDSO
* kselftest-watchdog
* kselftest-x86
* kselftest-zram
* kunit
* libgpiod
* log-parser-boot
* log-parser-test
* ltp-cap_bounds
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
* ltp-io
* ltp-ipc
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-securebits
* ltp-smoke
* ltp-smoketest
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

