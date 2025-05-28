Return-Path: <stable+bounces-147941-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C56AC66E3
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 12:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E14DA4A278A
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 10:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A28276024;
	Wed, 28 May 2025 10:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wvb99DWY"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773AC1FECAB
	for <stable@vger.kernel.org>; Wed, 28 May 2025 10:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748427744; cv=none; b=UkqO7bgWtgYiUkzOrCKc8I2EfvDQqevyJuDd2MWbVUAG39KQ9fRWaYNZKcvCERJcHqLQL3vSLGQ8gjWt08UEwuWaangnA/4PXD+mbAS7nbwWaGDtW6qWgv4U2Bx15V7coHbNqoOc2GHnYR6FjgztlWl7n7VDO69aoRDBagyGDWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748427744; c=relaxed/simple;
	bh=xIZDmtQ2bvvQrjrF0cMpsxOEeT+sh9IA+MNDwQ3A68s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XNn37vOzVmXrFYEhkZp5cWgsbnQlCP8sSB1LpkEJdQiNc2cQOeTdKFifUrbJ8IO7yKTxw53jv3JWvQpB2F4dgkeMdIgvNX1QT6qGHwCJdV6ffIsHmMvXylhWF3Xhky/HhJv1AMC2LClPaWSwy/1qYv2+DgTosuCo6tjkIDpzD7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wvb99DWY; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-52eff44a661so1189614e0c.3
        for <stable@vger.kernel.org>; Wed, 28 May 2025 03:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748427740; x=1749032540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAEI9dBBmQszHW+RKw/FSPz3iCXRW4F3HWgkJ+DnBwI=;
        b=wvb99DWYCXQ61OXHGI21DT4cnPTAC9dIYsxvn2u+e9oU1YuSuuPn2I7F+u/2tkYZKg
         r2VOUDDN9HVL71sNYm/6J5YWT6lZRjE1EkurS98MqyYB7OzBR1bpPN2kNQaIr//4IBbl
         Ys1L8vUG8ozYhhouEYLM/t2FGtJnUgzbdRbNPO95RrhtiRJkMIRbz2j1uhGTOScoQEBi
         MtLqzGcxIYQnQn+tvUn4Gwmg658ZEANQNRWmtXx9mB3qMxf5k53bwLOE1lfvPmYgi37l
         OfLKhYBzQjzBbWJregksUDag4aoEDHnYNi2kYdiaISLnIxXk6PAyalFlyzhhD+YRzPGb
         HMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748427740; x=1749032540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UAEI9dBBmQszHW+RKw/FSPz3iCXRW4F3HWgkJ+DnBwI=;
        b=qHRGmbMObOsoe71PhnrhIpiHM5Mkehj3Dnb8zDYFGyCQerEZIVLQGzucE57fhHCtPX
         hU1K3IAewLC0fBm1QrX45wbl+SE/AQm/mMR76cvV43zHRZyIU8IbVAwTG4KJjoKshorV
         QI4PPif5vcdqTrsok3SRq+nfdu+2fjHoTIedOk7nPxly5xkRQt4f6gg/+1FcuGziM5Fd
         /WEOmbFVX57h4gE4BrPMeepNvQCJHpG7EC0RIa7HWcHiw0uZSXwoOUKBjwus0NCYPT6/
         VTrSBl00VvcHJL65QEUOm+pjw7vSq3ZNE902exFNDjOsQN2ZIsAFqRC2O+hoParah279
         LvfQ==
X-Gm-Message-State: AOJu0YyoEfx5tBXPydJMxwxWb8bqN8Heh0mDeuAKFnlJMBNbERPXZNRt
	YIQyvxz2NceyaIxbxpIbqyFtBChr51PvkSiHNVDYoYFdmahITrUEGwSKepNEiqw0/Zt9I8ZFZ+G
	m2MeR2JzLINqLJrNMwMb3z5SzpcOs7q+dEX29CG/Avg==
X-Gm-Gg: ASbGncvDPybo0rVrXLJSE9kS7bqnIgMK6OyJ5erMAPpNhezTZ0gKIhb6PtKUBNE7Dc8
	g1gKIEbYDIv+i/ZFF3qpIKGCaOabpypTvmdtv3zr5fm8xRHR7iZhjczkWS1O/nsHI47x72QFYII
	zZdsSgIGqcJR6RAJ7a6MR/8PTcePBZgzqLPI5An1fnkQJZoK7DaBlSElHy5eF7VbM=
X-Google-Smtp-Source: AGHT+IEO3OOrOKakDBXhBTdlrsfwTV2dD71uDOAnQpVHty/kUYLxbnKLo9QmXXM/u9gXgZxa0nnw9P5aUEWPNgid+No=
X-Received: by 2002:a05:6122:d9b:b0:526:1ddc:6354 with SMTP id
 71dfb90a1353d-52f2c310e57mr11013519e0c.0.1748427740331; Wed, 28 May 2025
 03:22:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250527162445.028718347@linuxfoundation.org>
In-Reply-To: <20250527162445.028718347@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 28 May 2025 15:52:07 +0530
X-Gm-Features: AX0GCFsXzFBM0eq21JXza1j0vn6z6QdWuG8ZgACS1SYBRb2dXaTUVPRzdxziTBQ
Message-ID: <CA+G9fYsJ_=E0+eE0p32TZ993JSr57N9eS3f=B-conLWJwts3SQ@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/626] 6.12.31-rc1 review
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

On Tue, 27 May 2025 at 22:15, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.31 release.
> There are 626 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 29 May 2025 16:22:51 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.31-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.12.31-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 3fc6e1848884b217db332a5f677a33ad485a128e
* git describe: v6.12.30-627-g3fc6e1848884
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12=
.30-627-g3fc6e1848884

## Test Regressions (compared to v6.12.29-144-g28ceb2ca3164)

## Metric Regressions (compared to v6.12.29-144-g28ceb2ca3164)

## Test Fixes (compared to v6.12.29-144-g28ceb2ca3164)

## Metric Fixes (compared to v6.12.29-144-g28ceb2ca3164)

## Test result summary
total: 323787, pass: 297841, fail: 5458, skip: 19725, xfail: 763

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 137 passed, 2 failed
* arm64: 57 total, 56 passed, 1 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 40 passed, 0 failed
* riscv: 25 total, 23 passed, 2 failed
* s390: 22 total, 21 passed, 1 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 49 total, 48 passed, 1 failed

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
* kselftest-mm
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
* modules
* perf
* rcutorture
* rt-tests-cyclicdeadline
* rt-tests-pi-stress
* rt-tests-pmqtest
* rt-tests-rt-migrate-test
* rt-tests-signaltest

--
Linaro LKFT
https://lkft.linaro.org

