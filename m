Return-Path: <stable+bounces-100049-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C989E81D0
	for <lists+stable@lfdr.de>; Sat,  7 Dec 2024 20:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45EB42818E9
	for <lists+stable@lfdr.de>; Sat,  7 Dec 2024 19:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87A71537C6;
	Sat,  7 Dec 2024 19:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B08QNhel"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF67238FA3
	for <stable@vger.kernel.org>; Sat,  7 Dec 2024 19:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733599859; cv=none; b=m5ykOz9WtAoXraJcbU/ZE16dBUJG3EdNrSG+TnS09ZGiD3I5H0l41+EsFOjdIPnmflfXFG+UtK+G3AXMUTjoW/d6vkAmtOnGst+D+PczeQqoJuMEmYUZeRAkKyWgzkkzPK6m5ZsWB4ZPoRYZUP6OG31IbbodBuBrKIV223ejpjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733599859; c=relaxed/simple;
	bh=MWIUYe8rynxHFhV3H9EzZP2GLleiXwTjfN9R28Xsoi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZB2DZxriOJr/5eOyUsD4jAcsijACInqd2BvoDMs/oT0+NazSBRX3j+roffD/7Eto3kjNO8FTptZeu5zPlfV09nVGEThY1DmStrXPxXvmeS/79VxM5nVBfLNSL3SeKlAbmw+nUJw1gQKqhupglQynK0oTuSSqB4YeEmRPJcywN7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B08QNhel; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-515d5204eaeso828309e0c.0
        for <stable@vger.kernel.org>; Sat, 07 Dec 2024 11:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733599857; x=1734204657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJMJPDqFDO7AvNtISrsM1UjQtxcLbmrzTjKuUV+bsSk=;
        b=B08QNhel+WDVmnWPpArrzh1e3MPSNxaAArZOJHuv/VpEkWpA25HIEXEe3gRhV5ugV/
         TT8gu868nmpK1Ps0fPpPBEUoPManfYloc4xanAvMwxPXAhDAHsd8JHWr2iYpjlTw+3xh
         OILVrnp9zHc6LSv7rBdT0l6IJp94So4f8JqQOAH3RCZsGBeqE2z6mosu6102OsLXjKl1
         hWkTFfqiImihugGo/AtaC2lAeG9s5ZUJkAcFIoQ6+yqlJ9IGyRTHTe+poyjvJXySpF7c
         9igB70MxAHZg/62OiJkYWmuN7waRvcFgAeS3k602zugJN0IBgTa8t3TvbvP8vdNZoP0z
         KYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733599857; x=1734204657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJMJPDqFDO7AvNtISrsM1UjQtxcLbmrzTjKuUV+bsSk=;
        b=dC+v8RXeS+jA7kRgqHW+6TQGwn3xROs4tTuFODuUiEMKbdnYUPuKN/xGSIF7RmwrUR
         0YMXmdGYA6I3+4Xc0XU8yDDI1fw+sVUZHm369CPfhis6qMGra7GBUKVmB8yK5xubnx4k
         SC4lu9nCDxoawXLq6GhwXSdzsbYqxA6vCkBoonKEyPWaR3AJeQflRIjLKGozvodB0nlf
         q8OelvYBMI7Lu/4MCO56QsAnd8MDt93H79QyOjlMwyBBNdy34hV6I1Dmy3TeBxMecmv1
         V02ppWj+u3vr2LyNeuyFd+8mwXiWxkLjGPJ+w3RrskJUfoJkYhuYuE0bypV+JNbrq/g9
         gA/A==
X-Gm-Message-State: AOJu0Yzn/Mr8xeXn5s6/JfwsqcqanixNhVxLuh1FRUGU8w9jElE3QRdD
	cBnIXgdo5700EaeM9PoCobwumkt/DYgQO+jX8kAvEKiP7j5SigM8ElLsCRFYm79pQv8BJUw/FzF
	FreJKEW08ZHBXkRKRfK5WskQ4DM1q8R476SPrRw==
X-Gm-Gg: ASbGncvpkGjEAWN/UGy2nzVzd+gnaivjBNPsepr/Ew5Ih7TrN4ix82oVhFyxj5NYl7d
	GhczcBp82MptZQu/UI31QNWTd3x5PJxIIR+b3heXEqkz9GJc9G8ANj0DRnkFo7f4f
X-Google-Smtp-Source: AGHT+IETMLvnjf2ePYPZmXA6raknYI25DS65BZcGw3tt+idtCpI6lOPHsr2VFcKdZpZEQ9i6MUgEhoh8dwN1lRh3vJ0=
X-Received: by 2002:a05:6122:1da3:b0:50d:5e21:ef39 with SMTP id
 71dfb90a1353d-515fc9c08a5mr7801610e0c.1.1733599856750; Sat, 07 Dec 2024
 11:30:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206143527.654980698@linuxfoundation.org>
In-Reply-To: <20241206143527.654980698@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sun, 8 Dec 2024 01:00:45 +0530
Message-ID: <CA+G9fYswik7dS-Sy-gmZZKT6bdxcxT1eRn4=994VV5R0RGfDxQ@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/146] 6.12.4-rc1 review
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

On Fri, 6 Dec 2024 at 20:09, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.4 release.
> There are 146 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 08 Dec 2024 14:34:52 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.4-rc1.gz
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
* kernel: 6.12.4-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 91ba615b0f093358fd3961fb76f3479193cd18f6
* git describe: v6.12.3-147-g91ba615b0f09
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12=
.3-147-g91ba615b0f09

## Test Regressions (compared to v6.12.1-827-g1b3321bcbfba)

## Metric Regressions (compared to v6.12.1-827-g1b3321bcbfba)

## Test Fixes (compared to v6.12.1-827-g1b3321bcbfba)

## Metric Fixes (compared to v6.12.1-827-g1b3321bcbfba)

## Test result summary
total: 158647, pass: 131960, fail: 2855, skip: 23832, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 138 total, 136 passed, 2 failed
* arm64: 52 total, 52 passed, 0 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 3 passed, 1 failed
* powerpc: 40 total, 39 passed, 1 failed
* riscv: 24 total, 23 passed, 1 failed
* s390: 22 total, 21 passed, 1 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 44 total, 44 passed, 0 failed

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
* kselftest-watchdog
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

