Return-Path: <stable+bounces-3637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 675CD800B89
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 14:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 227992815FE
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 13:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E3F2576D;
	Fri,  1 Dec 2023 13:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z4N7S12T"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F8510D
	for <stable@vger.kernel.org>; Fri,  1 Dec 2023 05:14:46 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6ce322b62aeso259601a34.3
        for <stable@vger.kernel.org>; Fri, 01 Dec 2023 05:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701436485; x=1702041285; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0W16F4lcpZ8yLA66z8Ns7cQEkaAJSZRgZlujODAFBjY=;
        b=Z4N7S12TIhIjHH/WEkMDl5I9O60qpLL9cSuzvzU7C1WWVdfP8+/I0k3Z7UhJJ9zzLs
         9VIXwU8wVaiDpV8lPHDwUd63py464PJCsj5FzKuBzWInbh1fTI9KIdZ0t2trc/0RMqeK
         EZm9TECSWZC/py5gLDxSSh4tioaPv9lcEZ0ONGOq34zaIga7+HG4XbiJDP741V0Vo31Q
         ebktrHaI86VaF/le0ReJ3KTrXdjNhHDbeK+sHceLf3WjV19gSHS8yM6pHk5DlwAzMCUw
         N/7KD8RuBKrE+7tpXJ1Jdi0iqU3eKx+2izV5RUF6XFv89ST9XkV3HgHgrlKAbY58bBS5
         2leQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701436485; x=1702041285;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0W16F4lcpZ8yLA66z8Ns7cQEkaAJSZRgZlujODAFBjY=;
        b=KaNiDNWl0I9ou6NP0KRnlfqTaP9H5pFqaAbjgy1uuXYmFIaaj77REW8Bc11DhxkimP
         ZWccx1qQ5QVFl9sJ6MS85sWX5/rl7SMU0xYjcoQV3HZNEZQoHvGw9edjZxwCt0lSGGxH
         JM9rYPX+dSyupBKPXCqDGre6lPava6fiNyjvnHRLMpxRNkz0y4LdOxjBXdeMuDeKzsla
         mGVRnw4GZ0k1MUZqlb+sLqMwiK2qmrSYlN3hbHQuctf27s2b/02agbxhaTVqbjgd0mOP
         7abJnC/9eRZvY9k3sRAU6UBqjM1c5jMx1Fr0c2EFoOSoAK7qI8gghTljESvF9E6Sbd0w
         XevQ==
X-Gm-Message-State: AOJu0YynU2TVa8iJk9pVMAqvKv3h4SOM81jxG4YcOoDEP4SwvhSnzo30
	Y9L6+08fkCizI9e0VGsARDzvWsABRqq1tpMLQFUVDuN81cTV8bl8joY=
X-Google-Smtp-Source: AGHT+IFXeQf2TOaP+x86KeVNznhphAjy5NQ2X3ZGv+eAupqFUPllnCV4oSIRSe387vTiOXL/OxelT7sLz3tjjeaLbt8=
X-Received: by 2002:a05:6830:1011:b0:6d8:6c3f:50a2 with SMTP id
 a17-20020a056830101100b006d86c3f50a2mr1432559otp.6.1701436485512; Fri, 01 Dec
 2023 05:14:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130162140.298098091@linuxfoundation.org>
In-Reply-To: <20231130162140.298098091@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 1 Dec 2023 18:44:33 +0530
Message-ID: <CA+G9fYuaN6uYzfKn1wc3-_9TFAQeRt8mTGi+WwB8WkH151P0FQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/112] 6.6.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 Nov 2023 at 21:53, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.4 release.
> There are 112 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 02 Dec 2023 16:21:18 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.4-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.6.4-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.6.y
* git commit: 6ed60a9257c16a5f571b2354c4c0178caa70fc71
* git describe: v6.6.3-113-g6ed60a9257c1
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.3-113-g6ed60a9257c1

## Test Regressions (compared to v6.6.3)

## Metric Regressions (compared to v6.6.3)

## Test Fixes (compared to v6.6.3)

## Metric Fixes (compared to v6.6.3)

## Test result summary
total: 154229, pass: 132702, fail: 2283, skip: 19120, xfail: 124

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 145 total, 145 passed, 0 failed
* arm64: 52 total, 50 passed, 2 failed
* i386: 41 total, 40 passed, 1 failed
* mips: 26 total, 26 passed, 0 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 36 passed, 0 failed
* riscv: 25 total, 25 passed, 0 failed
* s390: 13 total, 13 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 46 total, 46 passed, 0 failed

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
* kselftest-vm
* kselftest-watchdog
* kselftest-x86
* kselftest-zram
* kunit
* libgpiod
* libhugetlbfs
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
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org

