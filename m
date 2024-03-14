Return-Path: <stable+bounces-28134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 514FC87BAF9
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 11:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07B01282B33
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 10:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255F06DD1D;
	Thu, 14 Mar 2024 10:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZwvyuBE0"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581E16D1BD
	for <stable@vger.kernel.org>; Thu, 14 Mar 2024 10:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710410936; cv=none; b=Mrxdd+rEdo7DPab7NOEnKdVE6DaezOzZ+gI3dYw1pGa8s7wDSxF8srZ85STskIm1uRo7fLR+fDuYLSamHu0wQSXMGZnZ3dW3oAhZZykej2z7z8Sak14i1fWHK0HqWSUV9SksMSonyaxRGLxwtsWQQ3vz352YVeHu7l73ABoE6sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710410936; c=relaxed/simple;
	bh=LQm2VAj90xzGsL/49c3wp2VlNhOBJsbKetnsb0YVsAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hVNnu4zp3G0aG+yp2c4KdVDEEbg0kKyEnFXVU9Sojzk5mn2NOY7XLVi/n9F+hkYV2Fv1rU7Q8unnVRV9i/RHkmJyPixq2mBdnY3NPmVRVMJg2/CcfFT0XhLzWp6njrcdPT2PLjc9TtdVt8abgtWghYerEHwouv1tAXaVprGVh+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZwvyuBE0; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4d37e76a3dfso956236e0c.1
        for <stable@vger.kernel.org>; Thu, 14 Mar 2024 03:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710410934; x=1711015734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAj/KswqypAoEBR+gwAx50mwI6kr2j+amF9iU6S/qJY=;
        b=ZwvyuBE09r8XQbb7M9862QFjdvgvwEAsMLKdjfd2ZmhlGUl6CTMUUSdOdZe6uD2PWC
         Wo6SMpLYDkpc2gjm6yJ7ndLCKJt2lkvvOzKOR8pwkUeDRYQkobi6jKhjcTGd9/w0MhlT
         dQ+7IHPRyK/ykM+8ygknkAp8xqzH+MqnlRjdjkAOJ/JkOACytCtBVAIVWPmlFSWwzy3a
         Unkv8ThpTvVbplufQSCUbDtWgmK6yll37mTNknN7csPdR1eaHlUQhU/5EHSKf0apOdw5
         xN66HZpQQRsfEooO3NpoGbtr8lRdtPj813nsDm1PGmnKG3rgGfiR7JDvqZT7giWSHVjv
         NU8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710410934; x=1711015734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lAj/KswqypAoEBR+gwAx50mwI6kr2j+amF9iU6S/qJY=;
        b=hJHrdKptibdy//Gnzcygz+EsiVENUBHO5ZyguG4w8xiWEH5RaHmP+sWcPSWqJ81iXB
         Dg8bMf3yYNLTanRX65aIRk75jopUFduR5OX4/Mwxw0UH8V74d/6Ea0IGMSlpxcMswRzu
         bRNYZaDBSWYJOtvG1AJp3jHnfny2g9aap5OoyI2jYYF2FffLvetmSgzKmx34CseFCe6/
         9Ojc6JDMYfXcbDWSRPdaFiv752CigpM2xBG+f4Y8BE2H3HTZ/dx77gdaiX/cKKmljLN4
         rP3+dkzrzCjRg8DZqDI2AJRbx+1hDi4hGyueCSB9PTb5qvOTTnm8mDg8J/h9uxd8IB8c
         4+uQ==
X-Forwarded-Encrypted: i=1; AJvYcCVi5WnqQ4YlnSWkHf/I891RzX+SvVTIZC8rxm6UIksJFF2Ja+tnanDxYaXbmNH5fBuev0hDrHiNTm8QWTsoDy+RDM/K8IV9
X-Gm-Message-State: AOJu0Yz4SUBLVRroKMoDy+kEGKccZImIXYb0Z41I3Eh35nd2JBOxzYXG
	pfRRSSOLnWoy2Pho0M83A00KZUHcIDYpkhj/U25o9e21VkK73yiRVz+wlyofQ5Yltik1ayomGYh
	icgSPax53IXlHw3x4BsLO/j9qziJ2Uq410cosVA==
X-Google-Smtp-Source: AGHT+IHg7rmCU4eUS55fx7jxIP9xt+HAU98sLo4njVkb4X1xnRu1fwZtHWsJy3RuPfHRrmaf/FO4U3GIVpX5h1QY+x8=
X-Received: by 2002:a05:6122:3187:b0:4d4:17db:4f46 with SMTP id
 ch7-20020a056122318700b004d417db4f46mr1991889vkb.4.1710410934355; Thu, 14 Mar
 2024 03:08:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313163707.615000-1-sashal@kernel.org>
In-Reply-To: <20240313163707.615000-1-sashal@kernel.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 14 Mar 2024 15:38:42 +0530
Message-ID: <CA+G9fYsgBOc0HocgXzDN-cM-L_dDndysLvhbcf3nGpjzSBDXTQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/60] 6.6.22-rc1 review
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 13 Mar 2024 at 22:07, Sasha Levin <sashal@kernel.org> wrote:
>
>
> This is the start of the stable review cycle for the 6.6.22 release.
> There are 60 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri Mar 15 04:36:58 PM UTC 2024.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git/patch/?id=3Dlinux-6.6.y&id2=3Dv6.6.21
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.6.22-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.6.y
* git commit: 11496a5d363eb35c9b4de8012eae7ffa557594f0
* git describe: v6.6.21-60-g11496a5d363e
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.2=
1-60-g11496a5d363e

## Test Regressions (compared to v6.6.21)

## Metric Regressions (compared to v6.6.21)

## Test Fixes (compared to v6.6.21)

## Metric Fixes (compared to v6.6.21)

## Test result summary
total: 132425, pass: 115163, fail: 1216, skip: 15923, xfail: 123

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 135 total, 132 passed, 3 failed
* arm64: 43 total, 41 passed, 2 failed
* i386: 35 total, 30 passed, 5 failed
* mips: 26 total, 23 passed, 3 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 28 passed, 8 failed
* riscv: 18 total, 18 passed, 0 failed
* s390: 13 total, 13 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 39 total, 34 passed, 5 failed

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

