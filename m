Return-Path: <stable+bounces-55882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16103919887
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 21:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66F56B20D08
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 19:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1C11922E5;
	Wed, 26 Jun 2024 19:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s8FvtpXL"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B921C19149B
	for <stable@vger.kernel.org>; Wed, 26 Jun 2024 19:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719431486; cv=none; b=BJYS8VeJ+n1MWfLClpgJMkGsAorG/5vlcyvx31Z8IOTSW5SxBA7AHmKN6adsc8bK4y6Ecf5t6OUljGILOYgAuoKFXlIXEotntzlfWnAJhfJeiU0hySkiIqjdwILbBxR1o1avugvr/N2VbbhDoknyfGDnhSb+FasUK7A0WU3w/Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719431486; c=relaxed/simple;
	bh=wHznnM78MYZ8sRXjvyDL3Ud+SD69Me0ZAd2Rh2id1As=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=giOq+v5JawMt/EhAN7EqrNBELbEQHBBRnyUKIytOwQ29YtA5dwUvbmYHCmycDugyEHcj7UeYjmRO3yDV6UNiVUxwzGBe5XWNaR31yh7BEQJGneLH8bv3Zf3eehnhXZzZRATNxOD2U8rtPyxf48Vs8n7q0j/r7AvIMNJDR2H9rig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s8FvtpXL; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57d1d45ba34so864227a12.3
        for <stable@vger.kernel.org>; Wed, 26 Jun 2024 12:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719431483; x=1720036283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9wy7DyYPhVWOxmxXBwLSUmvyHRJRdJyP7og1FLAuaU=;
        b=s8FvtpXLv2bDdDCeErwHGlzQo4XFUev5K/D/lY7fuIi/hUKiVDTRGRBdxX3L2vJmll
         OOXl/PkLmDfjWNKkNp98YxYv8L6BXuG4S/cnoKJsRHn5aMb92mE6qMhBOe01RVx3pxLK
         lSHqaEnzHSGrDVi6U9wo8GFxfIcnsityyxRc3B8hKIg/vvy4C2R5hp089+ylPdki5Q9k
         IaM8OwM2HE4Y/tKQFQZUXw9gbJG+GmIqyKQur4rMTUzu2i/pwbs1fgIiwmNl2sfx6Gue
         nK0T/pAoh9Z9dZlOK5Ljvx/43y5QtXT2er3azo5E45VuUxrfu1OiqyBJn160nGERaplp
         cCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719431483; x=1720036283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/9wy7DyYPhVWOxmxXBwLSUmvyHRJRdJyP7og1FLAuaU=;
        b=XsjRTxrWFcJrbt2hpFqMqza7bAaw1/7jEaqfbjtf5z4EOHh5cg+HiQCepeYTrOEzVg
         zbvRFuIa0DVJy8f4D3TN7uydOaGWNXNFedymn/cNf19kysr2UQ2UyEVdvwJ5IjPcYcy3
         2mSodhS9D+Ootdd59ltRNnSvNdMnOk+rIDMTK41xI+O1AELQ0rnuIYIeBbv4JXmpz76+
         ifnmR79FihQfQglNzPZN210cfKfHbwWQ3lJHlq5IDbIGg8WRMspZXEw1FTPkpsLNfm1Q
         sgZ98fDoVFz79+3PbUlgFK/MMTbHMhJi7pXQqQTtjyABLspzctdvCo1lBB34GRNg5NqW
         /ssQ==
X-Gm-Message-State: AOJu0Yyug2P15jdfwL7IenXERPM2N0zxtMpsflGk3CjZdbMOYmG1+euN
	ZcE1KGCurrmMx5r0vlbySymnnXteqjI5bE82b2yAgA9+X/6lF32r8G/ACfEQjwrw5aSeRNo4rC4
	VZA8P5oh6Fc3JcQGVm1yAQ8BJ4g5Oia/LNrPhqg==
X-Google-Smtp-Source: AGHT+IFtl2JuRCY1sm+cgT5dlCY0NBxa6gNIDGmESPez43089CZJjtIzEUHE9NB+Jp3sKGTdotqHG+Syxm6o8J3p7xk=
X-Received: by 2002:a50:c2c2:0:b0:57c:c171:2fb5 with SMTP id
 4fb4d7f45d1cf-57d7002209amr4698203a12.5.1719431482998; Wed, 26 Jun 2024
 12:51:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625085525.931079317@linuxfoundation.org>
In-Reply-To: <20240625085525.931079317@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 27 Jun 2024 01:21:10 +0530
Message-ID: <CA+G9fYu7SvvK41RVCLgDBoV0phAMbfASkw++HP-prWo532KUJQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/131] 6.1.96-rc1 review
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

On Tue, 25 Jun 2024 at 15:28, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.96 release.
> There are 131 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 27 Jun 2024 08:54:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.96-rc1.gz
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
* kernel: 6.1.96-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 80ee32f97e81cdbd2585b8b81e943f50e8078a08
* git describe: v6.1.95-132-g80ee32f97e81
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.9=
5-132-g80ee32f97e81

## Test Regressions (compared to v6.1.94-218-g0891d95b9db3)

## Metric Regressions (compared to v6.1.94-218-g0891d95b9db3)

## Test Fixes (compared to v6.1.94-218-g0891d95b9db3)

## Metric Fixes (compared to v6.1.94-218-g0891d95b9db3)

## Test result summary
total: 237419, pass: 204833, fail: 2499, skip: 29697, xfail: 390

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 133 total, 133 passed, 0 failed
* arm64: 37 total, 37 passed, 0 failed
* i386: 27 total, 27 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 9 total, 9 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 31 total, 31 passed, 0 failed

## Test suites summary
* boot
* kselft[
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
* kselftest-timesync-off
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user_events
* kselftest-vDSO
* kselftest-watchdog
* kselftest-x86
* kunit
* kvm-unit-tests
* libgpiod
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

