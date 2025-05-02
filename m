Return-Path: <stable+bounces-139427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1278FAA68E3
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 04:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C66D4A60AF
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 02:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C492618DB19;
	Fri,  2 May 2025 02:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SBjSPeOt"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5B3219E8
	for <stable@vger.kernel.org>; Fri,  2 May 2025 02:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746154483; cv=none; b=DriGBNenczMoodwLENSLBOp5yUjW/+fYmCDsSBJBxPHXXsJAtGweFPscmZnGbeiGjlNRkncxCpop0wsMZKIZ8PZj0WiB1Ptn0Dl0jvg3udX4h80EIzKMVmA4OvYfC/dm61wwGkvqlxKPJLCcKhl/9xKjkMBLLk8wTu7gCgPP3YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746154483; c=relaxed/simple;
	bh=0hYuoJkG1HiS0affuKYm7oyM12/o0VWgq0bU7+BeSQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IowlXjmDM0DjUJSAD5qmEyhqvUraTPB8DxP+HlocxMCAYSwnjvceSZtXbN6AXYqxFm4kyPBz8hWeYtQNzyWY3mg7GFXOmSM6+nsVWSTIr0fmT9z2jo5cptBmmMg9A2jM/KqiiSgwq/oRACV19kOswRgu6000ZvZaqbhYCdZO56M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SBjSPeOt; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-86d377306ddso401211241.2
        for <stable@vger.kernel.org>; Thu, 01 May 2025 19:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746154480; x=1746759280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cEZEuaBQX0F2OnwvUEVgaG6Yg7wPrQNQ4N5MN97UuLA=;
        b=SBjSPeOt95dFiUepEpTQUCMS1VUVv6kF0LLVUVN8UoyayJJZyXIVn0gb4TQfsmMLAU
         B4EjYALG1f0MJkcr9pH5atpwCzInMXi3WA+wx0K6HfVNkjKd3hu7aW/td3A+6vf7SN75
         lYU+r27Uj7R6a6cjOjVy2pU+g13ZJQxBDZRCYBneG3PqORZWhQ+cidT4EnoPEBPiOt1N
         711it0IobiqmKs922h1fsAWW8JKQ1sQyVPD2bjNyhJQVsdZ8n/DP2zJwKHNkTqstGPP/
         e8nhYpFVFYlDqAOi4fcJpH6zAWcT05B42kHRaiPWcHDevqlVycJHzy0bmtk/DRW7R+Be
         FMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746154480; x=1746759280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cEZEuaBQX0F2OnwvUEVgaG6Yg7wPrQNQ4N5MN97UuLA=;
        b=QRoRJ9q4Qzsz4usiJ1pnwlM3m8r+CdSFYUxMWOIN5ldSFOcebWfNeNVrzaBMGm++28
         ZF8MUUJPLmxOsdgmdBM+mVv4oQJ1qh1/NB/Si12vJhIrtpPibBUNMAwUS2MDpAp7Eon0
         R7OuACc0Q8bm+63wxCKIPOF3ZEVh9haBYjIB+ZvB1L1F42TnJ0iFeegYz9DGIqXtYNqU
         LYZMQ821SPSuRygCBjIgO3nSjHOt4T57myX10XczjeekQHd5LqWH0x6ZrDP7AwgAKvXA
         pKW3fmanheas3FeQzevmwwF7RpzBb34NpbvxFMsFHn9UpY+rRryJuzNUuHG384icjCgT
         xkoQ==
X-Gm-Message-State: AOJu0YxkvuCzsdTEfSzF9/l0tqeuumsQ1nHOrFC9AIkLQPEQJxq8Gj0P
	hfavXnDf0ZGVDS0XsNd5H+YaviSOIz3cArvLOvoujcLNFMFIx5zMVwAS2ie58Ln9y6H7MK1XRXE
	7pYHlZaY7FM7wm8DgCRogTr5ir021bMMUO81KSw==
X-Gm-Gg: ASbGncunewpeJvMYe6/Qs7lBFvV2t+S8Pc+lh4YGAt1sVLGqTYUM0Nj+DqJSZYONtOK
	pqIN7lxijMY96rkxsP6yhii5As2VX8NaAAn79m5k9SITRMWzPa/28RJ6fW3aJjeWDWhhVzt8Rny
	cggQ99W9E0y2Tl6hanK8yX
X-Google-Smtp-Source: AGHT+IEDIdOj9oMB0nKvbGRJkCmB7KOZ3tGAGHP+ARfItXrPW4FpkddRtuJsISkNkowV55n2pzm5c2j+ozEWBz9kQVI=
X-Received: by 2002:a67:e7ca:0:b0:4d5:cbbf:456f with SMTP id
 ada2fe7eead31-4dafb4fae17mr976341137.10.1746154480135; Thu, 01 May 2025
 19:54:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501081459.064070563@linuxfoundation.org>
In-Reply-To: <20250501081459.064070563@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 2 May 2025 08:24:28 +0530
X-Gm-Features: ATxdqUETEfbQXoB7koW_BPnoWBWbalINWlkur-9r8oo5Yb17vFPnHyQy6r5AsNo
Message-ID: <CA+G9fYtLUfJs2zAzvVhKN4Mo=3ZH455dnfQwc+Ck7HYJEhDUUA@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/368] 5.15.181-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 1 May 2025 at 13:48, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.181 release.
> There are 368 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 03 May 2025 08:13:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.181-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.15.181-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 85e697938eb09a3beb10ccd150f64f998876c4cc
* git describe: v5.15.180-369-g85e697938eb0
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.180-369-g85e697938eb0

## Test Regressions (compared to v5.15.180)

## Metric Regressions (compared to v5.15.180)

## Test Fixes (compared to v5.15.180)

## Metric Fixes (compared to v5.15.180)

## Test result summary
total: 76543, pass: 58926, fail: 3514, skip: 13517, xfail: 586

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 102 total, 102 passed, 0 failed
* arm64: 30 total, 30 passed, 0 failed
* i386: 22 total, 20 passed, 2 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 22 total, 22 passed, 0 failed
* riscv: 8 total, 8 passed, 0 failed
* s390: 9 total, 9 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 26 total, 26 passed, 0 failed

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
* kselftest-seccomp
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
* kvm-unit-tests
* lava
* libgpiod
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

