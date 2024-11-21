Return-Path: <stable+bounces-94505-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5354E9D48E3
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 09:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 146E82822B5
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 08:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CA61B0109;
	Thu, 21 Nov 2024 08:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rc09t0l3"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BB823099D
	for <stable@vger.kernel.org>; Thu, 21 Nov 2024 08:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732177944; cv=none; b=tpj4OKcCURO46IoDsjLhvCZoMdqby0i/hWeo5IVU+uJZzJM0JB4Z8u6P9vHiaP9VylhdWSKbwuQh29eOsYFmUmqiDN0JOdVJN/Y7g8afn9XFfCm5nF8+RVlmgF+VhsvIJPDDA9dMmkTMCYBZDlFcmhGXHKjsnaoeD693FtpQxVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732177944; c=relaxed/simple;
	bh=Gn9ucZ9E0EcmFZeWjEiR1DeUxpJLBsnQNs9UtTwvmg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rhxdnDBWAwqDT/ep3vmMp0uzYzBeUvN3MwT5l8yIb67Hq2Tm4xqtTU4DHF7FDeAad/VPgVwY6DySe4u3kU74PKpjjcl3GCT/ueMFzLzEwdlwSlGa5CJgTyR3vfUiMQDP72Yrou4ujoMgMJq3royS48Ejk1lhcBKF58bYpqRXJRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rc09t0l3; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5101c718439so303965e0c.1
        for <stable@vger.kernel.org>; Thu, 21 Nov 2024 00:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732177940; x=1732782740; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/hfnq9261uIaSvMuhYRCBIshixxVJLL7UsduaU963dM=;
        b=rc09t0l3r7ZBHplGTIoEU253BzoVlYaex49SCx4x1FzZde7Q8kCfLsfXYxBBVLGrdB
         CyLCfzHtXeGM6F7aSTQK9i4JIxBS8g52WTEaOjkTT5Mxfc7AIxov4fBiLmyKzqAd+YVa
         PoxjKMY3WP0pEifKEcHsC8HmN7+JFdfxY0QcGlFhMp46WtxM+nNiDPV/L2EWcNIGPF7z
         TCPqoYo5O2x9Go8hoxsbAYpEXItzVy7qj5XbsAVIHjGza232/ho2K38XYn0eNrX+hHNe
         ZIyLuqhHmZted2eK0CyX6Lvs6KrQInM3Jmny58e5LXpmuRbKs2Uc2vsEpdXSEg//rNR4
         0gAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732177940; x=1732782740;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/hfnq9261uIaSvMuhYRCBIshixxVJLL7UsduaU963dM=;
        b=vFj69St3QDxrHwpCF4XKuE0+b83aYMhaIXjdxWxf2RgGhNYRmlQyoSFy7NUq6T7riT
         PdefO10PFFnC7WByGt5W70+BA+qFe1xlZDdPK9eM+YdfTVuAPjenvXeNEEf6kXrKqRPX
         Z+DhvhO7o9JHAn6J0vnbBoxPMbKA1MydqVGrB9es04n/18Ro2WjV/O2qPmlnXg8WODgD
         37dlZxO+lmlrtHeGYvDQ1PQ/nxZ7lD/dSleJyE6plU50tMVpgnhkXxXAq8QAH1/tHf8e
         nlAvLPsO60+NkncYalHHXqE7o9GeRMZ/qAxIGLhP/4rdb0b4GYi37xGQs2kbB7zuUMAr
         J82g==
X-Gm-Message-State: AOJu0YxsC9ov/zhca2jKu29xZgo0IElFNmrjVXa5TxOYFPrXzafOXiyf
	PZBm/iJA44uYsaxG36us0fC45oC460Qj+uVRTDFP5OVf49aknka/1TRMuhb3tFZY0Uu4boSAayx
	dVt80kta2fL0aaaydDAk4iG+tW9zQH1+o5avdS/6ZnRz5t6Odi+o=
X-Gm-Gg: ASbGncv4uKIU7tpzoYD2iI6dS5wOo9fcgK7nqbSG6bo0lHfyQVAL6iJFN2jSaj5+Vvd
	LWe4YoYY7yRslpodm0MUQZYpIltf++CGrxg==
X-Google-Smtp-Source: AGHT+IHVDE8AvaZkTUEg9c6y8xfUST+4vKOew4KzEHJoiByr/mrf+Yzrqp+6Ius/EEVjXJgp83zkEWRA31bEbTyqeek=
X-Received: by 2002:a05:6122:a0b:b0:50d:3ec1:1531 with SMTP id
 71dfb90a1353d-514cfb79818mr6386395e0c.8.1732177940674; Thu, 21 Nov 2024
 00:32:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120125809.623237564@linuxfoundation.org>
In-Reply-To: <20241120125809.623237564@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 21 Nov 2024 14:02:09 +0530
Message-ID: <CA+G9fYt=ntvdU30W2jZRSUcAqzrKyuCfDH3nDwRB3STd6uOnPw@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/73] 6.1.119-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Nov 2024 at 18:31, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.119 release.
> There are 73 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 22 Nov 2024 12:57:58 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.119-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The parisc builds failed on stable-rc linux-6.1.y.

* parisc, build
  - gcc-11-allmodconfig
  - gcc-11-allnoconfig
  - gcc-11-defconfig
  - gcc-11-tinyconfig

Build log:
---------
In file included from include/linux/skbuff.h:31,
                 from include/net/net_namespace.h:43,
                 from fs/nfs_common/grace.c:9:
include/linux/dma-mapping.h:546:47: error: macro "cache_line_size"
passed 1 arguments, but takes just 0
  546 | static inline int dma_get_cache_alignment(void)
      |

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.118-74-g43ca6897c30a/testrun/25943312/suite/build/test/gcc-11-defconfig/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.118-74-g43ca6897c30a/testrun/25943312/suite/build/test/gcc-11-defconfig/details/

## Build
* kernel: 6.1.119-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: 43ca6897c30a8511928abff403a2977ca7b33ab8
* git describe: v6.1.118-74-g43ca6897c30a
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.118-74-g43ca6897c30a

## Test Regressions (compared to v6.1.116-139-gb9e54d0ed258)

* parisc, build
  - gcc-11-allmodconfig
  - gcc-11-allnoconfig
  - gcc-11-defconfig
  - gcc-11-tinyconfig

## Metric Regressions (compared to v6.1.116-139-gb9e54d0ed258)

## Test Fixes (compared to v6.1.116-139-gb9e54d0ed258)

## Metric Fixes (compared to v6.1.116-139-gb9e54d0ed258)

## Test result summary
total: 93097, pass: 73479, fail: 1803, skip: 17732, xfail: 83

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 134 total, 134 passed, 0 failed
* arm64: 40 total, 40 passed, 0 failed
* i386: 27 total, 25 passed, 2 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 0 passed, 4 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 14 total, 14 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 32 total, 32 passed, 0 failed

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
* kselftest-watchdog
* kselftest-x86
* kunit
* kvm-unit-tests
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

