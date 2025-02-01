Return-Path: <stable+bounces-111888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF52FA249A5
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 16:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A5483A4BE3
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 15:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CFD1BEF6D;
	Sat,  1 Feb 2025 15:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sSx8ZhMZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97631BC077
	for <stable@vger.kernel.org>; Sat,  1 Feb 2025 15:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738422542; cv=none; b=BDSeUc2kIy0WJdpWU2Qn/XlwuUdWczXsXEo0i7M0wtygzwD4lLbx4oA1cGXYHYZh262rZS9nJDqm9AJELO7DuRUqRpAhtFayLV1krEEtL5pADTxmw/aojmveCvcMSVFByv5qolS+CocbaTW9Z1cZVgIDsG2I7nP/rKB1DQLFAKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738422542; c=relaxed/simple;
	bh=/A+QTl1o2pMWwHHZSSDAAVBWnvxOKJtC0s3Oj+lqgG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cuBL2ODbc84LVdG67eWMJSUQIPe0DNNc8yaiGTCrAZKwK3hmxKOWeYkOne515ibXYmMH0eaMQVs8XmatD5j2+OuSHy6M1BTZ71F5uzj0zzP/jA+1pSf07l//lJPHEtrhxRWLEEfI9Rohd0msrJGdOBWLFhN0Mfx0w6NfuYo5az8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sSx8ZhMZ; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4b11a11a4f0so914893137.3
        for <stable@vger.kernel.org>; Sat, 01 Feb 2025 07:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738422540; x=1739027340; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OBQ44SQyOeljO4HnDRpC4Y94XPsE5W9YvH9TivkW/8c=;
        b=sSx8ZhMZD9fCL06CCrywag5Vmm3SrlVuzg4RKS+Xqh13ObhQObwj1wgCU/h8K0gIw1
         qL/qgoQwPR11eqN3wl22FNoeiGze/SfcVFvYKZ/hi3w8sHZ3oIMOeYN+Iw3Uc3v1iLyp
         snb8U7+uePLPocm6qAZcU5iXaE5kc2F85ir1rxBSDcurtn5ya1Ybse4dx3H/iWN2ae0S
         8VAGdZDmsJUxFh0t9L11ALNc2707cnzLScM1JK9hdOTFHfwzOHFo7IuEJgTsju934Njl
         s8f1sArCJzhq5RrwK5S04mrzE/1eDEj1Lg5DvOv7GIBVnubZf1z1PgqyLjpIKPrgNzh3
         mR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738422540; x=1739027340;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OBQ44SQyOeljO4HnDRpC4Y94XPsE5W9YvH9TivkW/8c=;
        b=fqiuJOOC+Ocou+OullZyQIX0fxhr5bSqVJXy7fe/ol7gQxj6er3QycEx9DP6ewq/vr
         Bgt+bTqxieftJYxV4ewqTxPhwjHxCGHctI8ORG6JlqZ53LFxAKPmhufKVaMBJeBHg+n1
         Gb0Zt8WsY6OtOyJ69ctPpX9ajeEcs7aoA0cDYAFFLQJ8zaZ8Q39g9rclB6r2oEDnoauo
         crP/KxULMI5edK5KgYbMplNYz9OIdk4/4Nx7cWWRarDSb0exkABlSr7sP5w+wVKAbiU6
         wUTTB/n7kEb0yON5yicz6lgNGEYUnoiK/L5LiLy0ovncOwz/UsR1xRBh5YrsQ6lOgdn4
         xMww==
X-Gm-Message-State: AOJu0YzWLyB1YbiFxAAPhyflKHLI+wbPByeK0u34tP77yDlatqYOYKTl
	QyAaBhPJJDe61y5L20z5EWRhlFaDPo3yMvA/VL63m8HXcKvVgLd4IRlDpfv84eu4P1bmPFyQAZf
	hnHrvLFlnJLc2fQIsyATRHMkD6XoxjADwly43mg==
X-Gm-Gg: ASbGncthP9muYgx84I0olrXNGLu8kMSl+ir5GrKHbNJwZVa+ynXMwp8AjBFce70BVDk
	+0CQVUHJ696iaujuKfdu0OmXdh2bNpekRepNEexvAJTCDuSANnkxoSx4O7R5bIhwtNjXRxDwD4n
	A=
X-Google-Smtp-Source: AGHT+IH7T6QC4q6y+mz61X4xpvHGlTS39L2ylkM87/l7P1wwnD6uiiVDv2UkuNHu2hOsDyXn2EEd/LstB/US+7N5sY8=
X-Received: by 2002:a05:6102:226a:b0:4b9:bdd8:2091 with SMTP id
 ada2fe7eead31-4b9bdd82bf9mr5310702137.14.1738422539748; Sat, 01 Feb 2025
 07:08:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131112114.030356568@linuxfoundation.org>
In-Reply-To: <20250131112114.030356568@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 1 Feb 2025 20:38:48 +0530
X-Gm-Features: AWEUYZnyrR7OVlFtKvwhUCRfS8uIdoOK5ivjSB1JA_uPY3K9dVpszefiacUBc1k
Message-ID: <CA+G9fYtT36DGS=6+2u35Ki1nyo0UR2A1ee3ifUfqga6D+K2egg@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/94] 5.4.290-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 Jan 2025 at 16:51, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.290 release.
> There are 94 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 02 Feb 2025 11:20:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.290-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

As other reported,
the riscv build failed with defconfig with gcc and clang toolchain on the
stable-rc 5.4.290-rc1 and 5.4.290-rc2

* riscv, build
  - clang-19-allnoconfig
  - clang-19-allyesconfig
  - clang-19-defconfig
  - clang-19-tinyconfig
  - gcc-12-allnoconfig
  - gcc-12-allyesconfig
  - gcc-12-defconfig
  - gcc-12-tinyconfig
  - gcc-8-allnoconfig
  - gcc-8-allyesconfig
  - gcc-8-defconfig
  - gcc-8-tinyconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Build regression: riscv kernel traps.c error: use of undeclared
identifier 'handle_exception'

Build error:
---
arch/riscv/kernel/traps.c:164:23: error: use of undeclared identifier
'handle_exception'
  164 |         csr_write(CSR_TVEC, &handle_exception);
      |                              ^
1 warning and 1 error generated

Links:
---
build log: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.289-95-gb4cc7cb40189/testrun/27103461/suite/build/test/clang-19-defconfig/log
history: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.289-95-gb4cc7cb40189/testrun/27103461/suite/build/test/clang-19-defconfig/history/
build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2sOPMVgFZtEG3dgzhD7rgdCoAsj/
kernel config: https://storage.tuxsuite.com/public/linaro/lkft/builds/2sOPMVgFZtEG3dgzhD7rgdCoAsj/config

## Build
* kernel: 5.4.290-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: b4cc7cb40189a3206ae81247a0596c4a2b4a9f69
* git describe: v5.4.289-95-gb4cc7cb40189
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.289-95-gb4cc7cb40189

## Test Regressions (compared to v5.4.288-94-g0578e8d64d90)
* riscv, build
  - clang-19-allnoconfig
  - clang-19-allyesconfig
  - clang-19-defconfig
  - clang-19-tinyconfig
  - gcc-12-allnoconfig
  - gcc-12-allyesconfig
  - gcc-12-defconfig
  - gcc-12-tinyconfig
  - gcc-8-allnoconfig
  - gcc-8-allyesconfig
  - gcc-8-defconfig
  - gcc-8-tinyconfig


## Metric Regressions (compared to v5.4.288-94-g0578e8d64d90)

## Test Fixes (compared to v5.4.288-94-g0578e8d64d90)

## Metric Fixes (compared to v5.4.288-94-g0578e8d64d90)

## Test result summary
total: 44418, pass: 28423, fail: 4303, skip: 11414, xfail: 278

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 136 total, 136 passed, 0 failed
* arm64: 37 total, 35 passed, 2 failed
* i386: 22 total, 16 passed, 6 failed
* mips: 29 total, 27 passed, 2 failed
* parisc: 4 total, 0 passed, 4 failed
* powerpc: 30 total, 28 passed, 2 failed
* riscv: 12 total, 0 passed, 12 failed
* s390: 8 total, 8 passed, 0 failed
* sh: 12 total, 10 passed, 2 failed
* sparc: 8 total, 7 passed, 1 failed
* x86_64: 33 total, 33 passed, 0 failed

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
* kselftest-x86
* kunit
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

