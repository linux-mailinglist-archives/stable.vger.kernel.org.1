Return-Path: <stable+bounces-61914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2140393D7C1
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 19:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 918321F225E0
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 17:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BA917D36F;
	Fri, 26 Jul 2024 17:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tsnih71t"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E82117D36B
	for <stable@vger.kernel.org>; Fri, 26 Jul 2024 17:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722015692; cv=none; b=GRMnQgPuNRVibwc+My4BpQ7XebNDBh+ZMnPD4qAjqCp7WublihIyYKS5X2Qz7iCc64frODI5Tz3LMbX3dA/rq1E1ZL3LgLD6B3BdCLEvyvzU0qaU+pA/zdxT8Xn7Z5odOMRkSFV2IqrC3kFpusY/3cDjupq1q/NaSnO5fOiDyNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722015692; c=relaxed/simple;
	bh=VOVTe8AbHTWQ9OIxXLbvHyvVlS+/yu3LH1L02ekm+vU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4FMzQTK11KWTOk8rh+O07jBojMvrtdtAS/R2crOLBqFemzl1DCY0ezD570E34mwhB7NJunxa4qeGyNCpXuLdPEmpg7MtkY/fJfJTmARpkH9afz95qtQRDjmqVjRgqVqYoFxHGnJ0RLyJgg4JOja5Jj5UcK9TO4ZakfuK+EggQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tsnih71t; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4f6c136a947so484110e0c.1
        for <stable@vger.kernel.org>; Fri, 26 Jul 2024 10:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722015689; x=1722620489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NyV4Ranv8hjbex09xbs1+X1ftbwqkjv5OZ97MPZTSe8=;
        b=Tsnih71ta8ZpJ13NASl90l5xUtOcbjsR+7/eGLLj1WUfsU3hhAgGp5Cq6FLYuYyJDL
         iznumbUKcQ9U6yKCpMHbS+FCQCAwR2gVZYHveNTD2Evrjq6UFUkDTAHSIeXu655TXZCr
         3WRsWvl47FedOvr6mZqua2dkEX9WdFdYFcasGOMQy9SaEHJL6qlxBthyHXqnCcoMQ5FR
         fS5PxJE+3aLhj/oyV5gmumO3wjHgMykp9x8vdDIToTOYxlulsa5iH7+NV+J58y5OsVHW
         WAYpmxQR8zLQa4SsPxtskHWYABcKzVmHlxMuhJEu/PjjiyVUQLp4p+KPeTw5nvn9XWma
         Y/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722015689; x=1722620489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NyV4Ranv8hjbex09xbs1+X1ftbwqkjv5OZ97MPZTSe8=;
        b=mkss+cdIUyTr5K7LzCmMaQR3Z8Lu4+RvbxNl5wvScV3zhbax5+pUu97oTm9xrDaxps
         VXwSYUMSxX7Ca039v33YA9KdB9htJJa45jvZ9PMB3gExO40kl65ypSOMWHHEF00DEyir
         ULsYdWTV7vM1L0Ut0DgJ2mkdkR5msFKR+XqPvLJpMYZsi+RFlFBZk6zW8AqTj0J0pr2z
         om+vSRFimojxpO2F5Ke+KlJ/MMDnxt2jLvch/8kziSeF23aG7aI8sCgADtJuxSNv5UdF
         SXSmkar1hJUsUSjidvr337aaXlVCGqThUBXcythKIjG8lqopvHBG2W2J+oAxv9+/tUdU
         B2zA==
X-Gm-Message-State: AOJu0YwkY2OZEYBL2O9BW3Zx9aNUtUCss35vK6puHzsOVb5XmDskn9Zn
	8wPByJPSLIcWYCZjgx7W+1rnE6kFakAR6DUToaWi/L3v5qWilSeaEpVf6+QPTNTcgEze1mwxTHo
	FfuH8EoQ6O/xgayavUUvMNXI+7PorOKWgtoS7Iw==
X-Google-Smtp-Source: AGHT+IEokeUJzGuoeN1XnSD/FY3MN6iOE9X1osOhH1tB1eHXiIhNcjJ4EsQVCYkzHJarrfr3qgb1AqKBU+goVcyYVFs=
X-Received: by 2002:a05:6122:4124:b0:4f2:ebd9:8e12 with SMTP id
 71dfb90a1353d-4f6e68e2368mr177253e0c.5.1722015689388; Fri, 26 Jul 2024
 10:41:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725142728.905379352@linuxfoundation.org>
In-Reply-To: <20240725142728.905379352@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 26 Jul 2024 23:11:18 +0530
Message-ID: <CA+G9fYvsiw97j1nr1ckBtR28bWsbWLpHkCkw13U51nUemfMGkQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/16] 6.6.43-rc1 review
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

On Thu, 25 Jul 2024 at 20:15, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.43 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 27 Jul 2024 14:27:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.43-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.6.43-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: e83c1018357355c0547e7887022ef46510253e60
* git describe: v6.6.42-17-ge83c10183573
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.4=
2-17-ge83c10183573

## Test Regressions (compared to v6.6.41-130-gc74fd6c58fb1)

## Metric Regressions (compared to v6.6.41-130-gc74fd6c58fb1)

## Test Fixes (compared to v6.6.41-130-gc74fd6c58fb1)

## Metric Fixes (compared to v6.6.41-130-gc74fd6c58fb1)

## Test result summary
total: 208041, pass: 178672, fail: 4082, skip: 24852, xfail: 435

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 127 total, 127 passed, 0 failed
* arm64: 36 total, 36 passed, 0 failed
* i386: 27 total, 27 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 17 total, 17 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 31 total, 30 passed, 1 failed

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
* ltp-smoketest
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

