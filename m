Return-Path: <stable+bounces-50105-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9295902666
	for <lists+stable@lfdr.de>; Mon, 10 Jun 2024 18:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6087B2779A
	for <lists+stable@lfdr.de>; Mon, 10 Jun 2024 16:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773C4142E67;
	Mon, 10 Jun 2024 16:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pLHiNpte"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969AF1422D5
	for <stable@vger.kernel.org>; Mon, 10 Jun 2024 16:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718036027; cv=none; b=tvqgcUAstqDLO+1+Ly3rDmK6Tcl4gFaUWGeV1jMdfJb+NT3+v+SuJ0iCTOC/bjhGVe2V0Gr7nnOYpJCPNopriOQvUA+k1/y5gVsq5Q8XKXDvefwQPEGnq66Sto8yK4G1Yq84Yi8NlzQc6V0RF9hADgYECNUoYoYkBLWW8KY0fas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718036027; c=relaxed/simple;
	bh=ANFTp/weWFW5AIvaKB0ZVMJypGvMDeYp+xero9WkTJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IOJwBPIkqltifBwyxIT6cYZ/easx+EA1V1THsVluZZoFWw1q6bjDVHNeQ9oUKGShmQhH4lJMdoUf6W4krLIV3HTYkGB+6iggW1uPUlP3jnwGJHiUsKqG8oh684rwa/Cjru66mclqxjyRDoqBDvhs6Ujk7PdM4C8J1BnDimLIOTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pLHiNpte; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4eb0c729c2eso1230560e0c.3
        for <stable@vger.kernel.org>; Mon, 10 Jun 2024 09:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718036024; x=1718640824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zy3UT0yyFkK2jWmjzHRfhvJ0XhcxX+WMOHBbMX7TWw=;
        b=pLHiNpteIO8TsSwvYR6sokualV4gUCv3lS7JSxVX7HpJR99UHpkJXDr3nRw0MS1ZYV
         DiMiqXQjUGnl43BR2qFUV7UX8ytaCRq4S4kwWANiVJTpa/PSHKrDTHAMpFNnn1LyJhhk
         ifZGCJFjmjfZDX7YAqq3wYeYUGQZM7WBu+hKTKeRwcAI2t7WF75JaAzh7IernLcsqZLR
         JQHT5vZLpZtb6FTKvlIARHRhwKholHhlGK1PQQDl787Fey/pXZZeFQF6ChTLsG5nVQn0
         fWCfZzIaa2L1TYtwNyg6E0rQ0o5MkT2gzmMISSUCfniR1ZcGwKhQsJ8UEr3bs4henof9
         q4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718036024; x=1718640824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8zy3UT0yyFkK2jWmjzHRfhvJ0XhcxX+WMOHBbMX7TWw=;
        b=qP7q9tgfcVGl3CBoUNYVeGpJZNSHUsSmGOKF8vAyE36aFAo0hj/3E5XXKfGwT8CuY6
         MTlxi7e556hE+pZ3gNJ62h8+Ccoe5ZKSFYm7/mX6MbQy90Pyu911loHR3j/KBU9o8cYi
         IH2uj4XUePfps4m3wdNptgIAY81IrX5yi1X5JK8cq71ykM8o83J0uYZQ89tmqiloZlgC
         pJNo5XoPhr5FIfbf9oEUbxNacRIiWtseBPz+PhsJqMj3YOOhXJb1eQA4Dni35w0ILT7A
         m4P0BngRAU5u8o66mXbbMaVB+MFs+YqsM76QAvjJF3MbhuGI0lRUkOC4500VCw8tNuv/
         A4mQ==
X-Gm-Message-State: AOJu0Ywv3XD98WYbSo3iLsEB1VPUGBVH/EzEmQV0+NuAdKIHtobIGBCo
	pPX+7nFr7tQQIcc6y0bvQGtTzdtxKONwp/yY3UornJfgnnzwdawuLjiWWbeGA3TaRy5rU93Xz6q
	DQdzfQmy62H671G+tH+5aWHvAKV91/t5IXLW/nA==
X-Google-Smtp-Source: AGHT+IFq6tlHdLaJg531GvEs5Ls9kVx7hFFfOKyJyNs5KOTU6Hb1F914Fr2+LSfszlTrbFZPfiOV2GgueH98JuMbDak=
X-Received: by 2002:a1f:cd87:0:b0:4e9:7f87:4c2b with SMTP id
 71dfb90a1353d-4eb5621cd6cmr8361323e0c.3.1718036024400; Mon, 10 Jun 2024
 09:13:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240609113803.338372290@linuxfoundation.org>
In-Reply-To: <20240609113803.338372290@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 10 Jun 2024 21:43:32 +0530
Message-ID: <CA+G9fYuXrS3vphJ-2keKTN4Voc6gRAkUPJYD10uBrp6LjA3z8Q@mail.gmail.com>
Subject: Re: [PATCH 6.9 000/368] 6.9.4-rc2 review
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

On Sun, 9 Jun 2024 at 17:11, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.9.4 release.
> There are 368 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 11 Jun 2024 11:36:08 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.9.4-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.9.4-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.9.y
* git commit: 4aee3af1daf2e1e4f2ff4e124cae1ef79b118e90
* git describe: v6.9.2-797-g4aee3af1daf2
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.9.y/build/v6.9.2=
-797-g4aee3af1daf2

## Test Regressions (compared to v6.9.2)

## Metric Regressions (compared to v6.9.2)

## Test Fixes (compared to v6.9.2)

## Metric Fixes (compared to v6.9.2)

## Test result summary
total: 229325, pass: 170430, fail: 35789, skip: 23106, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 129 passed, 0 failed
* arm64: 38 total, 38 passed, 0 failed
* i386: 29 total, 29 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 17 total, 17 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 33 total, 33 passed, 0 failed

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

