Return-Path: <stable+bounces-40032-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8861F8A728E
	for <lists+stable@lfdr.de>; Tue, 16 Apr 2024 19:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D93A1C21379
	for <lists+stable@lfdr.de>; Tue, 16 Apr 2024 17:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6904D134403;
	Tue, 16 Apr 2024 17:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mgy1JR3E"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A403013342E
	for <stable@vger.kernel.org>; Tue, 16 Apr 2024 17:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713289311; cv=none; b=lp1n7laYkm+ScowDtaKu/5EobUNDy+vke+eba3AigYF/6saUiLnD8c9hlmlVR5lzLXsEVEfzIzs+eElbMJIjw8w9zhH0iMKzw7AWhsYOigszIS+/2UIHqxjiSOKs34hMvEck5vFq85R1ZGAFEFfxDQcll3dhfQ93qNQWuxkA4nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713289311; c=relaxed/simple;
	bh=uKVZxVZlSo4tSfHTbZrt8QwnCT7MxtMg82Aru1PM+u8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=slGejDErBdH5y3TNU/mezvjjtL2oA8FiT1H+KEWseZpYj0GnwkjA+7g6M9guHRjNLE2WjnJxgFyOcZGU26QPbaOixO98VggHmJ0MwAyVfjPKZCCtHvyrgab+A96oC12MRa2uF/QG9UEKtGq9Kk433IP9RSEEs+7ToyQtOfAtnDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mgy1JR3E; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-479edfd02e4so1187352137.2
        for <stable@vger.kernel.org>; Tue, 16 Apr 2024 10:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713289307; x=1713894107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WnPrPrshaoqEgDMfeskW4XuFf5a8CzPJbeeAH4eg1mE=;
        b=Mgy1JR3E9Vsur5ZlHMWzpTWsyNILiUCWGhzslPjYUNRww5e2xPpD+XivgOpASyZ1D1
         GLkYFUheF/nwvu5YHjIfbAi/6Ax1SJPA13zPmGvR2TLo5putFx+oYTUQSVYosD56OtHE
         IncOhxn/CygVBU95NtRKVougqP8jwWOLkBbmzQdTjMMUWTsx3l1ewyLw0R8awEo8qgfs
         U4U5pWYiOmQRR/kQ2R5+11UvgHWlYhapvWp7U8aivSccF0zZiwqJ3gAZUKuqaQIXCH1M
         lSSwE5n+cSDyHt/VpRxpX8gQFoYzjyv13rZLsvxLq5f0TYRfRiAqAfpNlNXJvLAcZ5Ga
         tTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713289307; x=1713894107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WnPrPrshaoqEgDMfeskW4XuFf5a8CzPJbeeAH4eg1mE=;
        b=f9czEmd/gD3+JGkhaKVrJ6Xx7P29uZCrCZJ17DL7466vuJexOfdCGd9LLAXhFfGES8
         3mCuHCdIJGh/bE8DWNKEohBQLY4G/iMG/4bIifIRElaotAu+E4ApBY9QMg/ugrbFBeEr
         nAhGSHr3A0mA2g4YCSSNs7qF+tb6OVHkTCbJRBwLQ9mJ28qcQJrEVAHCZow0bPTTJx2y
         uKAOY/rIOnj65oEq/LxFiW9mNTjkLUu7N6VQoqh2/rnzS7ESXQzz7KeSCrdqIasDfu+5
         MyWdqOe6qc1gRfY7hFrFzXxDOWBOXJLH3Q8tcUdX9qQchxxQCtosV9qAJLHDKhuSOFH7
         UQeg==
X-Gm-Message-State: AOJu0Yw8MaiQpFlpr3v3/aBbOSeKRjrGeFCKVqcqMTpkhPlA/L5/spUO
	sr983F+6NuWkbidPUFg0K1jmKhgxjm/FuAUdgOHb5tS2vou45akNrqmBddVJO9fuFkXK7inwn+5
	VFeEnkDlfJg25DWCgjznkCq7QtuzLe1d20sGYQw==
X-Google-Smtp-Source: AGHT+IGQOiRJVB0i9nfTAHucMka5bk9jMtq3i/B9OdHXAz7Tlx+yTSFzDhb7vY49vXsiPkVKXzwjOnCxxwy7cZedC4E=
X-Received: by 2002:a05:6102:1629:b0:47b:a037:99ca with SMTP id
 cu41-20020a056102162900b0047ba03799camr1332168vsb.1.1713289306728; Tue, 16
 Apr 2024 10:41:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415141959.976094777@linuxfoundation.org>
In-Reply-To: <20240415141959.976094777@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 16 Apr 2024 23:11:35 +0530
Message-ID: <CA+G9fYscTZr0qJH5k8eycnD7Mj50XGgNbzcmk65=RKtme1tVpg@mail.gmail.com>
Subject: Re: [PATCH 6.8 000/172] 6.8.7-rc1 review
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

On Mon, 15 Apr 2024 at 19:54, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.8.7 release.
> There are 172 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 17 Apr 2024 14:19:30 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.8.7-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.8.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.8.7-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.8.y
* git commit: 367141eaada2c7635234576914bcd1f480d62731
* git describe: v6.8.6-173-g367141eaada2
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.8.y/build/v6.8.6=
-173-g367141eaada2

## Test Regressions (compared to v6.8.6)

## Metric Regressions (compared to v6.8.6)

## Test Fixes (compared to v6.8.6)

## Metric Fixes (compared to v6.8.6)

## Test result summary
total: 285130, pass: 247210, fail: 3619, skip: 33930, xfail: 371

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 133 total, 131 passed, 2 failed
* arm64: 41 total, 41 passed, 0 failed
* i386: 32 total, 32 passed, 0 failed
* mips: 25 total, 25 passed, 0 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 36 passed, 0 failed
* riscv: 19 total, 19 passed, 0 failed
* s390: 13 total, 13 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 6 passed, 2 failed
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
* ltp-io[
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

