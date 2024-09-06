Return-Path: <stable+bounces-73704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8634896EBDB
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 09:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0CA5B20D60
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 07:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B62514B955;
	Fri,  6 Sep 2024 07:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t4TX1s5H"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EB21494AC
	for <stable@vger.kernel.org>; Fri,  6 Sep 2024 07:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725607355; cv=none; b=A2Z4l4vyodEg758M3Yc0EPcVTBKIA9GwJ70Hn/RCDSPxqI31nu14EJwle5q+GOpuQXmyP8VNN91g2qTj/dDp2z23JlwcCwft5ivGlGLnVuRmegXjOBbWNJEU+Q8VQWKzJdl4UWBLoBVHwhXHISOw9O811y+PyNZl6nKd7+K9zyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725607355; c=relaxed/simple;
	bh=KwZZ+AnanxgAt3VuNvV+WPnAmgNU40hFKMZuWq+2Lh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AhXgvkjjgpeVm38+alZ3RVbvmmLjnGhyG/DE33/DT4PKEUx5mnMypY+IKG93wUfLgMQQJaecEfMhhGi4fvZzZPWD8SORXEtY+cNBcD392X8NyoQ5yAMVwPbIORdZvXg2uDyxZPbNf1a1HAYT2ObDIEpoTu3vy8CRNYOcjpZ6aPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t4TX1s5H; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4fe97b060e2so547864e0c.3
        for <stable@vger.kernel.org>; Fri, 06 Sep 2024 00:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725607353; x=1726212153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uhgpt3bI2E2g8xPhmof7AuwEUjN30/Xo3LJgy3GqQN4=;
        b=t4TX1s5H9fxKSfJ+8ThH0GcqFobrj2bPo2ZtNX36MAVSVQyZa97ko2VpP3wQFDdlJ9
         sVoB90TbaFv4izRNbyyUr2+Sm72qdVTm2Sx5jq0rpcCazA+CpTZEzMqTqrbEo49jw5dz
         G4cf+r4FKNzHNeMrdkd6LDO6tT2x1Yj3nmZ+jvwJwbNXRtC0MWLJwNGQn3j9YGuNDs0O
         9j3+ty9ri+9nnrE3Q6p0ZwpdVUsnJfusjIuzuqM5LZXn/xJUC47c/kq6POWxlLbq+s1z
         SvxbAnatGZQ/box7ljcNIngjWswYGHKWN20OEVlPwgF6+Lb/s2H5XCqsRs5btB72iEae
         injA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725607353; x=1726212153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uhgpt3bI2E2g8xPhmof7AuwEUjN30/Xo3LJgy3GqQN4=;
        b=ItS3/QthjgwwUSrC+NKP4OWo5FrscDtZpYUcRa0slt3zDG+r6R+TaPVv1IkHcD9WOf
         IShel9czdr4HMghQjoIACzNbIawNRu+t4DxyTYXbULAqUQj39MB16Suk+XUeSUVJ4JHv
         zQPvF6ibLi8hznCJLcsUEemcoh0jEF13ZBU7uQYYqST0pyT7ADJJvhTulB2BE/nbunA9
         H8LfNKUVrKtUwF1EWN4DsqPpui9DaCuHCgrROhRuI6ctrKErLGEne+fSkD2n0HVKk4HU
         kb1CSIxFBjZop86kRWXvXm+KzD+XaVAmeD7XP+fMiDjZehAtkgpIQIgYeUWubQEUy3zA
         Rt7g==
X-Gm-Message-State: AOJu0YyB0B5wikDHzcbcH3/3DqR6sTYU83ibHHHpgcAzhgs2mC4GD0ry
	wqZMkFag8RAXyxyAFa3MVO1BINxfMOw6/QjB8QMBucdm1haKFdrFVSUC0RKzWaiSuC+fRdReeHq
	t540ONjS5JwU8Uu3UQxrLsg3uHAv87kXqPtI5Yxalo+7Y/kpv2kE=
X-Google-Smtp-Source: AGHT+IH+SAfQDvH2kLpxnbDKDzaFOm1dacngrzZ/IHWoVFUo66Sq45cgx2tjWkq5kjOIC40bYvIZf/noAiB9QAWi0i4=
X-Received: by 2002:a05:6122:3123:b0:4ef:678e:8a90 with SMTP id
 71dfb90a1353d-50207af372dmr1979153e0c.3.1725607353037; Fri, 06 Sep 2024
 00:22:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905163540.863769972@linuxfoundation.org>
In-Reply-To: <20240905163540.863769972@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 6 Sep 2024 12:52:21 +0530
Message-ID: <CA+G9fYtWZSJ5G7rEoQ-QLKAEzQBYRKyGyRFhv+2V6QbL3kGMXg@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/131] 6.6.50-rc2 review
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

On Thu, 5 Sept 2024 at 22:06, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.50 release.
> There are 131 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 07 Sep 2024 16:35:08 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.50-rc2.gz
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
* kernel: 6.6.50-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 89740cbd04a6ed5c1db1a2b5a2cbcda34e1138aa
* git describe: v6.6.49-132-g89740cbd04a6
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.4=
9-132-g89740cbd04a6

## Test Regressions (compared to v6.6.48-94-g8723d70ba720)

## Metric Regressions (compared to v6.6.48-94-g8723d70ba720)

## Test Fixes (compared to v6.6.48-94-g8723d70ba720)

## Metric Fixes (compared to v6.6.48-94-g8723d70ba720)

## Test result summary
total: 507989, pass: 445691, fail: 4433, skip: 57272, xfail: 593

## Build Summary
* arc: 15 total, 15 passed, 0 failed
* arm: 387 total, 387 passed, 0 failed
* arm64: 123 total, 123 passed, 0 failed
* i386: 84 total, 78 passed, 6 failed
* mips: 78 total, 75 passed, 3 failed
* parisc: 12 total, 12 passed, 0 failed
* powerpc: 108 total, 105 passed, 3 failed
* riscv: 30 total, 30 passed, 0 failed
* s390: 42 total, 39 passed, 3 failed
* sh: 30 total, 30 passed, 0 failed
* sparc: 21 total, 21 passed, 0 failed
* x86_64: 99 total, 99 passed, 0 failed

## Test suites summary
* boot
* commands
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
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

