Return-Path: <stable+bounces-150711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CF8ACC6B5
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 14:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D5333A4024
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 12:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C594322DA02;
	Tue,  3 Jun 2025 12:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LKvP3EzW"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B661F237A
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 12:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748953852; cv=none; b=ar5dL7N5zwDK0nEsLk3GvJbxF1seRkagQ5qWY+mOr3VI0rViheCfPey3Yic25mGDIFDq1R5DZoCznJIeVDGQdK7T9ZB/UccJch9GHnSHEumZy22dBZHrYB5gJoHKAmDNH8QpRLtmwMs1nKSXzlHvwccxzwlGheoWSBrSbNob/cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748953852; c=relaxed/simple;
	bh=EmQ/A9vSfKWWPB/K/T8g8cr639C8K9rcW3d2OXMslYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tZaGk/ocvjICz7nt0nvFZ1BYPgyHfkdB62xFJhdU6lYofIQrBWQMBoHIUz2bbnwProYLajd+ExyEztCc9Lmh7KYwJbj7fCOBw3Q2cvobrkAeu7GZMK29IHWI+FjudWpDmTnqpo1cgfj8HUuRb2NpVTVRqk9i6fQIwSUtRkOT6Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LKvP3EzW; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-52b2290e292so1834121e0c.3
        for <stable@vger.kernel.org>; Tue, 03 Jun 2025 05:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748953850; x=1749558650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LY/1nUmGBa6dpDChrxvy7BQ7e4yIy3xA/coyZFocW/0=;
        b=LKvP3EzWGddE4uWuB7OfVy5oDwkJQu8QXp+kbSInopfsq0Dt/ulzjij3bknit7gUH3
         9COBmnOrbiJ+hrIkCRvQTRQ8WLqCYpzNA3wSybQw9Wlag1pzanfyizd1xNNuJMT5f46l
         hJ9iB6lE66bI7x8ClQznWI2GW58iivl2fBIcMOalw2QlY40USWLDf0cq6lhPlPiXx+g1
         Aze9ZbE32pc1JOufsj+UA4jLRMsc68minAvhz0/Ca0RiVaw77b46aKr0JIODAF0aPNaC
         DUTQu/zlNzX4HsMa+2dSzcz4MM/3McAjU2fgWoKCzRO841yEblS2mHuXi3p0x8Zx6Fu0
         r35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748953850; x=1749558650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LY/1nUmGBa6dpDChrxvy7BQ7e4yIy3xA/coyZFocW/0=;
        b=uWaBMX6bOfZ4+gwDwHvJr/A74kShdS3NjM38Bg+N/v+40kUsGSpMc3XSN+cpgZBK5W
         ZkLiOxDcKJhFWv/VcxR4lRAcy0HKZgYba0DaIWB+IsE3jCK6KDj7DiAdhu19/WdkAHJy
         PM+PyJPRW4/MOJ2srB8wqZXzbZ28dHGQwZCCjMJgQK2jXzsaPt+SbOD8D57F9gkX8f99
         bQ5BtjY3n6CcwjzAbpWSIQvzXLuEv0NDwawC80HgWrreaB4tQp0foNEUXwMoWYUaWwlW
         b6sP8zZ4Z99YmZC6yd6zjRaN8DCZaOBU/bmta0VnfWxUzGeeeQpiPYF2HVNfQ7UX6QQ5
         SXgQ==
X-Gm-Message-State: AOJu0Yz82bTAhBpau/wL0UL9o77L+yWRJ1WXxzjY/Ab5EkxGUhSgF6DH
	LRWZ3ITikr/VtHAWhFo1hFrtEQguT7kgxpvtlVlTB7H7iGYk/+ii8/VWggixL2KTT/MRi/eGQKZ
	M7d7q78fBMj33dVS2eLavMsSlw3WFkuQU+y412xVr0g==
X-Gm-Gg: ASbGncspSWtEsNRMYzH097DWkcY0XHr5HWJqU2DtZ4LCwyl1J6pFmUuHKpso1yLoG6z
	p66oE9v4USwb9e/SO/v6YIfn5Mlpnb7h/C1jNg74KpUYvhh5zHn7SSjVzYSdLO1tSJbXb5JGe/Q
	taa/n2viFNC2rczvpvoBQ5+F4yPZ2ffog=
X-Google-Smtp-Source: AGHT+IHTosQvOBKF0L3D0Inb+MoWZZ3cSRXCp014dL+KqAo8fezAvJU5scdjR5Ga9Sawg0g6JBdjG2QGVG+FJzLfAfg=
X-Received: by 2002:a05:6122:1ad4:b0:52c:4eb0:118d with SMTP id
 71dfb90a1353d-53084be0280mr12838886e0c.4.1748953849537; Tue, 03 Jun 2025
 05:30:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602134241.673490006@linuxfoundation.org>
In-Reply-To: <20250602134241.673490006@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 3 Jun 2025 18:00:38 +0530
X-Gm-Features: AX0GCFumOsdVyieNJlmgoVB__zbTkcpeuCdAKy4COLBbvEc6SfoIbneNR7OPeWM
Message-ID: <CA+G9fYtrUYsAtZgJg4b8ZxCUzWmekp9v0USDVC5dKgZ3XNe7UA@mail.gmail.com>
Subject: Re: [PATCH 6.14 00/73] 6.14.10-rc1 review
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

On Mon, 2 Jun 2025 at 19:28, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.14.10 release.
> There are 73 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 04 Jun 2025 13:42:20 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.14.10-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.14.10-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: d9764ae2492695b2e87e4cd07bf1c61426d3693d
* git describe: v6.14.9-74-gd9764ae24926
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.14.y/build/v6.14=
.9-74-gd9764ae24926

## Test Regressions (compared to v6.14.8-784-g10804dbee7fa)

## Metric Regressions (compared to v6.14.8-784-g10804dbee7fa)

## Test Fixes (compared to v6.14.8-784-g10804dbee7fa)

## Metric Fixes (compared to v6.14.8-784-g10804dbee7fa)

## Test result summary
total: 332025, pass: 306599, fail: 4596, skip: 20041, xfail: 789

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 137 passed, 2 failed
* arm64: 57 total, 56 passed, 1 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 40 passed, 0 failed
* riscv: 25 total, 22 passed, 3 failed
* s390: 22 total, 22 passed, 0 failed
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
* kselftest-rust
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

