Return-Path: <stable+bounces-4828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D742D806DCC
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 12:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9A1F1C20AC2
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 11:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB303172E;
	Wed,  6 Dec 2023 11:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h0IoElf3"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81372D3
	for <stable@vger.kernel.org>; Wed,  6 Dec 2023 03:23:20 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-46486775ad7so1213936137.2
        for <stable@vger.kernel.org>; Wed, 06 Dec 2023 03:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701861799; x=1702466599; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gliW0I2EfN36qnQKowmOwEBc+x7UD9fKDOIjdkW4NnA=;
        b=h0IoElf3Sicz56LW6nX/TqbVrT9AM2b67DFBVy0FGLKqOaPv/Iq+BiN2Yq3XRoP1HF
         744ePZB64UKlYpKPq3fsy0H3ZfIDF40FrtVRap5jXLkU+B09kZKxcmBMr/aJW8HvcMKi
         RowBnGQb6If1lgEoKKjSi9eGoaCwJXnXwEnVTCwlPuvirOpCzih42jBQlT+8aZ/0A+3x
         8i3cJlSc09PYMT6Y/x0a5cylIAMIwP8oezwPCfmC1BXaQ2+xXVccrO6122K28uzxe+GK
         atCFmIL3xYMTZEIDmIuI9kYDeu8ST1IYzWMBTWC8rmiD9V6KuveYLyHLkQKVCuZLpstH
         eR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701861799; x=1702466599;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gliW0I2EfN36qnQKowmOwEBc+x7UD9fKDOIjdkW4NnA=;
        b=Orqe9BWX+k2L/dErJ7YRA20HtrKQJyX7i9Q85TkY/jmd8Ub9qQuNXkUnXktRiA3MXc
         OQqJH0W6VPzu51EVmfzc6mZlvy9U0xqfoxQKUj1y8CKzGgKAJL8RZLDcLGemfK+8kbJq
         pE0NlqPx3XbDR2Kb1ai/PoZs8EbIZn/V3+NubvCQ362NfuICL+Vy2gbCz/JhnYwxWATb
         mEh0S8/zJ4kSlbfVpmWOHNR6rTT62FdnQ+PjFD5iqCAvJC5B0CBvbUQlb3C5ovFGkg8T
         pPjN6BupY/P2dLWO8ByAX8JiKJs+yP5eoc/hqPz56KBctjDGmfXOUaSjMzVJhnPoF3Gl
         TuxQ==
X-Gm-Message-State: AOJu0YzHYyklR379HUqW54nCWn52kTE26b/EUUAzGj1b6TOzlIQbXMw5
	t8GzvsHl1jyM6oXQg1eKTxmQm8K+7PNCFg3dgV6GSA==
X-Google-Smtp-Source: AGHT+IGSmBwVl6smCPmKLJnEE0Yg3TaWvcZySYJu9zhZ4JV3Rfz72PbzYymCZvFv9IJuwZeHm7TJQe6PgD3T6C3zGu0=
X-Received: by 2002:a05:6102:4404:b0:464:837e:2f84 with SMTP id
 df4-20020a056102440400b00464837e2f84mr837945vsb.6.1701861799590; Wed, 06 Dec
 2023 03:23:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205183238.954685317@linuxfoundation.org>
In-Reply-To: <20231205183238.954685317@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 6 Dec 2023 16:53:08 +0530
Message-ID: <CA+G9fYvPD35zcGHGZx8CrZ42C4sAxuA5-KnyYsD4XP6LUMfhLw@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/64] 5.15.142-rc2 review
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
> This is the start of the stable review cycle for the 5.15.142 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 07 Dec 2023 18:32:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.142-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.15.142-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: fef113ea8057148a392215b58a5901786c11dbf7
* git describe: v5.15.141-65-gfef113ea8057
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.141-65-gfef113ea8057

## Test Regressions (compared to v5.15.141)

## Metric Regressions (compared to v5.15.141)

## Test Fixes (compared to v5.15.141)

## Metric Fixes (compared to v5.15.141)

## Test result summary
total: 92831, pass: 73975, fail: 2202, skip: 16582, xfail: 72

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 117 total, 116 passed, 1 failed
* arm64: 44 total, 43 passed, 1 failed
* i386: 34 total, 34 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 26 total, 26 passed, 0 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 11 total, 11 passed, 0 failed
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
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-splice
* kselftest-static_keys
* kselftest-sync
* kselftest-sysctl
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
* network-basic-tests
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

