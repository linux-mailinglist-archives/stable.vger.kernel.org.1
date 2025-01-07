Return-Path: <stable+bounces-107855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7FAA0411B
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 14:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC15716485B
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 13:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC87B1DFDBB;
	Tue,  7 Jan 2025 13:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F19CITcl"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F4F1F03C6
	for <stable@vger.kernel.org>; Tue,  7 Jan 2025 13:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736257591; cv=none; b=Yur5Ezn4+uN1HJvoXU6B2k8uPWvtSDxvelcqzzlI3OP/41KySKiS+zs2PzlFDF+cu176z2ecd02B6n0zHJQRgzJHaTXHxVBU31kDVflYbKw6zAdDqv9tj8LD4qdMwktdP3yiDTKnF+oWj3m1nEjzJpe+aP/pXg4hXnf3cZ8qa7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736257591; c=relaxed/simple;
	bh=c4zaWbztBUVig2b0rtoihCmkfhinQyeht2xzMok1mT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S2sQCm3rfOIE5GLgOZJELN2FAYXZGTE9RTXCVdcWI6aqX0RzUrE9owvtWolbgsv00ZU/isKkOQx0NljKlLM/eTJRmVX+ByS/vd0RcmQf7RwjR+i3re3Ru67HLxkYEyGaQfTwz3VnU43NF0Aqh3sHokL++kFAJImutypBHsP/TQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F19CITcl; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-85c4e74e2baso2939267241.0
        for <stable@vger.kernel.org>; Tue, 07 Jan 2025 05:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736257587; x=1736862387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAMGdLTpXOT3n9eC7FE3UE/RoKHM53ulqTtui6culm8=;
        b=F19CITclUXQFcV4QSItTYA1VzjqYRkfJ8sbT74Mwyyxohq8F9RuG/ittmnB01zJWVH
         Ac29SWH8IZpcJWQ8orVpK2x85xfv5Jj3gMskjHaFy4dPYuDdkPYAgrgIlg/FXvEVk3aL
         ZQPRauIxtlJCRroxUKDcrBF4VWWj1kPoXeQKWs2oqksmn40N0WbNYkeYA/Qm7LGZ/oqP
         RUt9YJ4q4fSjJLitUXId1tyMxA1e5HH7jFPLOMD7brggDHhwORoUzhapEOO7qGBy8FkE
         i2fy9e/pRMi8EPZgK4haCDFIZGCFs+nLTV0DmDoDzed2mpLshvXckkUNZ5W3MX0do6GO
         S2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736257587; x=1736862387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OAMGdLTpXOT3n9eC7FE3UE/RoKHM53ulqTtui6culm8=;
        b=Vtcda7NJfnZUJKXuN1rvnjs8fjmNPqzEBMKP/LE78EWOEWbwQ9qL7oZG5EQBNGLloA
         e7HGeuKvhHpBhzfo1GhxRQ/HVXXBDAUXoHo2rxvkIH8gsUg4QZLP+cL57TeoVEQC6PEM
         5Wl9PCRQz8lgkTn9oex0Oc9okYLGeaSKGCYKu2cBXVjz8wHzm6K4dmWOnh4a8kjYRkG+
         oHafwL6F/+e8X33fqRnDlcr7pfZKajOqGDCAPRM89XKd4TD2DZ7E5MGJi1CxnEkMj2NN
         xlazBSfcTkOaQZF8DdIi4jc5dy145IVV8sPr661+oasgW8J7yLibx5DcMMW0eZBe2Kf4
         NS3A==
X-Gm-Message-State: AOJu0YwLD9w70A6iGfv8DnAlTP910QZSTe0KMfEw76iO+F9Y1ca230VZ
	ioCllyE+gFyyy1azcIQkINadeIWfrN505H3BZV51quPYiAIQbKIkx0zztSAAXz4G/7eZ4V1U5qQ
	qLXeUC9T+j52FF6BDs+81JcFMC36wSZOJks0z2Q==
X-Gm-Gg: ASbGncsXBFp80MpthBT5CR/Vg0kDYPw4FiAzIzlXiiWmZBNYRQtMFk3XEIYY1ziltck
	LVPLkXq9eh1xgG1EwaSl14qtmJvzqXEf5FrLBDg8=
X-Google-Smtp-Source: AGHT+IEDB41RCtrEyqxY3BJbFu54a08GTpGhSW47/06Rvw5p1eHcSJ8ESQDgF/bjRbdP5K0BGBH81qG4kDyNkSnU6nE=
X-Received: by 2002:a05:6102:4188:b0:4b2:4950:16fc with SMTP id
 ada2fe7eead31-4b2cc399b22mr44987586137.14.1736257586792; Tue, 07 Jan 2025
 05:46:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106151138.451846855@linuxfoundation.org>
In-Reply-To: <20250106151138.451846855@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 7 Jan 2025 19:16:15 +0530
X-Gm-Features: AbW1kva-wnFf6Gpv368sk5BP2HXq0iTu0eMEHR3tzMH92VZSZcwnvfMAHK3xzkI
Message-ID: <CA+G9fYvTeERvkq-k-fFVzrqzFjG=7i-mro0MXQ-JS_rPubtbmA@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/168] 5.15.176-rc1 review
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

On Mon, 6 Jan 2025 at 21:20, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.176 release.
> There are 168 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 08 Jan 2025 15:11:04 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.176-rc1.gz
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
* kernel: 5.15.176-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: bcfd1339c90c53211978065747daad99e1149916
* git describe: v5.15.175-169-gbcfd1339c90c
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.175-169-gbcfd1339c90c

## Test Regressions (compared to v5.15.174-52-g11de5dde6ebe)

## Metric Regressions (compared to v5.15.174-52-g11de5dde6ebe)

## Test Fixes (compared to v5.15.174-52-g11de5dde6ebe)

## Metric Fixes (compared to v5.15.174-52-g11de5dde6ebe)

## Test result summary
total: 54560, pass: 38397, fail: 3232, skip: 12777, xfail: 154

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 104 total, 104 passed, 0 failed
* arm64: 31 total, 31 passed, 0 failed
* i386: 25 total, 22 passed, 3 failed
* mips: 25 total, 22 passed, 3 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 25 total, 24 passed, 1 failed
* riscv: 10 total, 8 passed, 2 failed
* s390: 12 total, 11 passed, 1 failed
* sh: 12 total, 10 passed, 2 failed
* sparc: 8 total, 7 passed, 1 failed
* x86_64: 27 total, 27 passed, 0 failed

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
* ltp-filecaps
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

