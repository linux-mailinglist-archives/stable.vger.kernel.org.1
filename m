Return-Path: <stable+bounces-185595-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F0CBD80B6
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 09:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C0DA1920093
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 07:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566C52F5324;
	Tue, 14 Oct 2025 07:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xeMtAs1i"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF6330E852
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 07:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760428731; cv=none; b=QEg4mhhcF0eFGVEwNtKWBOi7uNdwB9GrfsR0uAJFk3ePQslG9WXaYD6hXYee/mHqE5m+sv2qL7I6yc7hPiRRxilXWqV89oPdadnh+rk06iH9e+ZTtNZGvy2/qCqV1YoTAWb8ELPF/baP8NxECt/b7zzhlVw+cW6fu+HWEFBOtic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760428731; c=relaxed/simple;
	bh=G2VtRn5hudNwHDgDn/7W78by4qirc2MsuWrSActYjD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rj5aUQpfQ1MtFH5pA5BFZ1sN+agjb3nUG+kD75yw7fqglqFMtj8C9HXIv43sPmqCG45wT5WdJrYiCw+9D/54+E1PeVKaJ6+KeR1Was0w4Sg5pnhdev+CIA+SzJgNBU0rA81/fvBhZq8ieWbj/YzMkzfEajzwPwNpwvjZ2vrhMB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xeMtAs1i; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b5a631b9c82so3072479a12.1
        for <stable@vger.kernel.org>; Tue, 14 Oct 2025 00:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760428728; x=1761033528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gCfEtBQohhUWgvY+Jg30trTCgcmv7nRwq3VJ9R+wHY=;
        b=xeMtAs1ietPAmKIZALBoEnyeG2yp8CH77vwb2kyCIr2GroWIQBpFjQX7Amwo0UK6ko
         lIR6v1YNloETensMb/Q99LlDqRTz/WXNBBSGzHt3dypJ6BIeitX2Wjj8CpUbjBqe1B5l
         vt60r+uhUPOKtKQDKFGt9e5Edw3PeKqpNT7U3sdv8Hb1CYCsCjEJr85sYiKnHaJte3tz
         HQZpuw+qeSOEfRGyeWFUmlxUCbVbjSI1SR4LqZxb6d/dSsTsFQKpYKol/Jfnfv+vQAt9
         VPJmR/33lutDnWp7ZFpt2trRhxDVvhoFaWxY9I2SQJ5FScWu8cUsSratU1FREyOYlIU4
         QUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760428728; x=1761033528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2gCfEtBQohhUWgvY+Jg30trTCgcmv7nRwq3VJ9R+wHY=;
        b=kdA7z0rMV5dGRbsJIhLWgeqQe2nk4l2Aw1ixvXNm6aFhZ9erzz7NuKNxBy5ZQ1ZWh4
         iADISzhcmHSsvQQwDuIeTlqAkF/JpFCRHGUqtlkGT5cZESWosVo/nYViH3UrZzA7wlo9
         JYkqmOUHseYJBmt9CX1f8tDe3Y0vUgrm7TtzbGiRH2YO8GTVzAdevVIkwUCqSy8c/7pW
         Dpyjf1RwsUAFwQykrcEu8NyvSFfyMEMS93rUklJUsBcXQEU90sxoXP/V5AM2HOxQq6We
         pKtSJoicpCDZ90BhDCrvZDFui9vNGfbFnU9ezcau9kGpDbmzLa+lN50q75c9Gxoc1Lyl
         IToQ==
X-Gm-Message-State: AOJu0YwxSqP0cWSO68ybzortOKHwi9fSChGYE96Rbw6sKQtxmDXS+eWv
	CRHxFxkhNCELfT/6ncKmZkxfully7YLY2IuoqK38VDniH1XyseIsJDwxkGZ186tf8bxKOkznb20
	FlGgT0hrrtz8xGj5Tunscpbn0okL0ugj0dyX4NmJNcA==
X-Gm-Gg: ASbGncvEwPdhgzgRm/yantDCohBY+VZ7LZmAtVfWXWUGShiZp3zuTR1nSyWYHDe5YH7
	4LwVKbm3nu0bk4YKfPqv2+YORa51Nbafi34Nsue2UxD8qGkzZnQEjZV2rBK2Nbidbw6BukAchdp
	Y4FVX7tm1I7Ssi1i3yRJpu34ea9hM3wHoifbxKco0MWDSviQ7KX2pou4fkb/OgZNGh3e/fZpLNT
	4ANX89RtqinzWCrD9Kvd2kPWKponIDF1lkGDmgTrA6YqihFvoJ2IfGPmx1jPSdNpdvYup3SeM7Q
	wsNFYZJJZBvRE9SlZlNJOjcpW22FWg==
X-Google-Smtp-Source: AGHT+IGyLtRwKF59vA/XgA89QVVWWrZXaLpJuoILoiZ0IPjJIP505nZ21laMBq6+MEb4Y6JHPF+ffXMGtMTqV8CQDmc=
X-Received: by 2002:a17:903:f8e:b0:27e:f16f:61a3 with SMTP id
 d9443c01a7336-29027238f07mr282622365ad.23.1760428727710; Tue, 14 Oct 2025
 00:58:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013144411.274874080@linuxfoundation.org>
In-Reply-To: <20251013144411.274874080@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 14 Oct 2025 13:28:34 +0530
X-Gm-Features: AS18NWBVmjY_ZUNYY0Fb-geHzDHpJmdEB3VK9gcbwGTLTufE_jsfJXboVi5C0ZI
Message-ID: <CA+G9fYv4wpxs1zOrnNBCK+oYL7-fsTy2Lxgd9NGMY7PcwPOTMQ@mail.gmail.com>
Subject: Re: [PATCH 6.17 000/563] 6.17.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 13 Oct 2025 at 20:50, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.3 release.
> There are 563 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 15 Oct 2025 14:42:41 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.17.3-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.17.3-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 99cf54e7bd2fde42d75c71b54fb3652adea2e7a4
* git describe: v6.17.2-564-g99cf54e7bd2f
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.17.y/build/v6.17=
.2-564-g99cf54e7bd2f

## Test Regressions (compared to v6.17-43-g8902adbbfd36)

## Metric Regressions (compared to v6.17-43-g8902adbbfd36)

## Test Fixes (compared to v6.17-43-g8902adbbfd36)

## Metric Fixes (compared to v6.17-43-g8902adbbfd36)

## Test result summary
total: 150604, pass: 129081, fail: 4610, skip: 16913, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 138 passed, 1 failed
* arm64: 57 total, 51 passed, 6 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 39 passed, 1 failed
* riscv: 25 total, 24 passed, 1 failed
* s390: 22 total, 21 passed, 1 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 49 total, 46 passed, 3 failed

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
* rt-tests-cyclicdeadline
* rt-tests-pi-stress
* rt-tests-pmqtest
* rt-tests-rt-migrate-test
* rt-tests-signaltest

--
Linaro LKFT
https://lkft.linaro.org

