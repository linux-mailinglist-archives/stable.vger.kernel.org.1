Return-Path: <stable+bounces-4830-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A19806E26
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 12:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A542E1F21371
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 11:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDC031A97;
	Wed,  6 Dec 2023 11:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lR5weGfe"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FC3D4B
	for <stable@vger.kernel.org>; Wed,  6 Dec 2023 03:38:06 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-7c4adc5dcdaso2364162241.2
        for <stable@vger.kernel.org>; Wed, 06 Dec 2023 03:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701862685; x=1702467485; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vqiXsfY2To4PHI6eJQCHduTSebcEXd5uADmfhHEO5xo=;
        b=lR5weGfeGEsG+Gqj9mP9Z2cl5t+alFDxYQKdGX+HIZoX0aXDO52sETrUy5GW/DJ8Xp
         YjLjk+N3PVCv6puwUccKgFcRFAUeiEDY6B9jNKsz1Ul56JFNp/Y/3InyYNJI5xlM5ed0
         7KN/b3DQDxjLcyJMDxsNrVYO19RzbBWy8VWhtdpha0JlXjyuaeHbMfXSRvaBEKi7VOf7
         vE6QPMLthWj6C6Bw7zRiv3JZ+XJAKXhoE0lzL///6xJrR+L4QSRKEoCl/QnnsCWc7+2G
         b38IYVL2Q2WxZGzIi1Goz0RVeIO60Ix/4EHlZo5Tb6CjN93YB1MmkFO3r3EH5tnpKnBI
         Bgeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701862685; x=1702467485;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vqiXsfY2To4PHI6eJQCHduTSebcEXd5uADmfhHEO5xo=;
        b=u8z887YzDQNq1d0lMf5UjQsZPAoTEd+9WIrneGFGCXecXfPUbANJmgorC1hpnt1QYI
         MqByOQqtO0ym6atXmsmHkqR+8Uxzcr08pf/q7PMbBwObeBX2IuGKhGU7PqJSD9/1X9CZ
         CDx5SJUmMFePBaB8UeBTAwgglAgwhLY3bjK/o7oEhLcPCbdj23gOsuL5ESwdElqhkrgL
         itwEKB/d6OB6onGjq/5w3LrDNUXCyRTBnbpLpjbJ7VeDijit6HczjYUUjgTQS66iYosa
         prVb6kbO76bjKIAouNboEwBsRl6igFzvqexh2HrfqwDqU3jFPZd7ZuOImzzwxZIdp/+L
         epsA==
X-Gm-Message-State: AOJu0YwY8Au/DAM1yfD/bdaLUz2gLQO0j4Lj1ltMleK8TqAjv+u3W6nt
	RHHXU1iAgnVznLUoidWiWrULSVFueUtBOhi4J9tf6w==
X-Google-Smtp-Source: AGHT+IHourNTb7WMH0K3D31guA9V35xLG/P7Tn9mTPPu0kJQ1+4eDDR2yXdz5EU4bC5uAzOSV87KWRPhW1gtjYwiyX8=
X-Received: by 2002:a67:ee1b:0:b0:464:7f57:b474 with SMTP id
 f27-20020a67ee1b000000b004647f57b474mr567721vsp.19.1701862685076; Wed, 06 Dec
 2023 03:38:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205183249.651714114@linuxfoundation.org>
In-Reply-To: <20231205183249.651714114@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 6 Dec 2023 17:07:53 +0530
Message-ID: <CA+G9fYsQLS9sksdRLphmSJ+K7bYDsdiq--xe+eivsOfAeM2Oxg@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/131] 5.10.203-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Dec 2023 at 00:52, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.203 release.
> There are 131 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 07 Dec 2023 18:32:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.203-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.10.203-rc3
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.10.y
* git commit: 3e5897d7b3637fe06435b1b778ed77c76ef7612d
* git describe: v5.10.202-132-g3e5897d7b363
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10.202-132-g3e5897d7b363

## Test Regressions (compared to v5.10.202)

## Metric Regressions (compared to v5.10.202)

## Test Fixes (compared to v5.10.202)

## Metric Fixes (compared to v5.10.202)

## Test result summary
total: 86943, pass: 67634, fail: 3147, skip: 16110, xfail: 52

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 117 total, 116 passed, 1 failed
* arm64: 44 total, 43 passed, 1 failed
* i386: 35 total, 35 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 25 total, 25 passed, 0 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 38 total, 38 passed, 0 failed

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
* kselftest-membarrier
* kselftest-memfd
* kselftest-memory-hotplug
* kselftest-mincore
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
* kselftest-sigaltstack
* kselftest-size
* kselftest-tc-testing
* kselftest-timens
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-user_events
* kselftest-vDSO
* kselftest-vm
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
* ltp-fsx
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
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org

