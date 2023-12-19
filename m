Return-Path: <stable+bounces-7867-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D898A818276
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 08:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFFC91C23344
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 07:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5071CC2CF;
	Tue, 19 Dec 2023 07:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FzR+lBK8"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B4611736
	for <stable@vger.kernel.org>; Tue, 19 Dec 2023 07:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4b6cf8b2799so1029968e0c.1
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 23:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702971778; x=1703576578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCXN6sLxwBKli2IAyjRtXOTr0z8s92RUcQ5p1T54R/k=;
        b=FzR+lBK8Xc+AVn7T7BqpVjZabBAa0YAR/HJZOPLl68YTyQobLd05QGnZjIhj8W75mL
         Eg8kJ/f+dikmmXsIifMkzlMpQ/AFcNOLuDWWlOBg5u6C4HATZpW6CJSzFrjufG08ksdK
         MLUVJPGdwV8xk1AYQeYTWYbWCuiQpPhSmPAXrokTOCb6rdsqSvOhmMTrw/OHXATbLTjR
         YJLBnIjhjy+XaxdNkXHlQ+c7aWWGmM261ZBhDyfBHoWeek7oSTdzGM4uQleNEuiI7XO6
         OmzYP+ToFEbmIv9zS4KMbAibw59x3ncCZpHsQuzFGvpFeloF1e+VIO/pvX9WORy5Cj7i
         AuZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702971778; x=1703576578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vCXN6sLxwBKli2IAyjRtXOTr0z8s92RUcQ5p1T54R/k=;
        b=offVYTMowhR/TtIPXVAOAcdGAU/wJbVJD6Eymj4pa0jj3olCAdPT1dl6c7jMhuDkXy
         iTb3IPGN0t3pWfE75WdSIA7qOSh6CnehbdBWlPW14dzX9uMzoLueR9IPvE5N/TGWOJt5
         /EHbsYRYxzRFlWa9fo9Ha7IaSBO87OEsxO6QEcuqZk98Rn+l3r42M8MXlAhLnRyEQueO
         kFBAGX+PyM9JMQ4unYr7zYhbFJvhMVfm2Ro0jzHEUFsPAdJkVNZebc92yjuT/6guTebM
         TPC4LwG15kyr/5ft/ggqx99K+PYhoqdePiQYR7+AYfAeMCTzrpKKi6bYfZG7zhN+YrD8
         XMBw==
X-Gm-Message-State: AOJu0Yxew5ZcHmvNwS26jI1olJ+yv/fjuyUadTb68KhvWsHlAGC35OPx
	pAKPQLjqH8TmobxXDu4+6G48HQzGZUZ8ecww2JGgWtjC/pc5wA==
X-Google-Smtp-Source: AGHT+IFfqCcnJgM42ybIzXQhXsxSiYmlcetEOO1f9WWuqJqF3VuloTEtCYGForTTtx5je1XbT8xvwcQqR29/Gw1sgf8=
X-Received: by 2002:a05:6122:548:b0:4b6:daae:5d26 with SMTP id
 y8-20020a056122054800b004b6daae5d26mr431016vko.11.1702971778366; Mon, 18 Dec
 2023 23:42:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231218135055.005497074@linuxfoundation.org>
In-Reply-To: <20231218135055.005497074@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 19 Dec 2023 13:12:47 +0530
Message-ID: <CA+G9fYvmxWCeP0o+eiR11Pvbf3eM=xaXuWpzyiXwMHO24mxLqQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/106] 6.1.69-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 18 Dec 2023 at 19:26, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.69 release.
> There are 106 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 20 Dec 2023 13:50:31 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.69-rc1.gz
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
* kernel: 6.1.69-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: d4e0eced630816f1c7a6d389a4cb6233a606eeea
* git describe: v6.1.68-107-gd4e0eced6308
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.6=
8-107-gd4e0eced6308

## Test Regressions (compared to v6.1.68)

## Metric Regressions (compared to v6.1.68)

## Test Fixes (compared to v6.1.68)

## Metric Fixes (compared to v6.1.68)

## Test result summary
total: 136350, pass: 115596, fail: 2705, skip: 17912, xfail: 137

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 151 total, 150 passed, 1 failed
* arm64: 52 total, 52 passed, 0 failed
* i386: 39 total, 39 passed, 0 failed
* mips: 26 total, 26 passed, 0 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 36 passed, 0 failed
* riscv: 15 total, 15 passed, 0 failed
* s390: 16 total, 16 passed, 0 failed
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
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org

