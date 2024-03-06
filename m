Return-Path: <stable+bounces-26938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0795C8734C3
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 11:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B0671C20AE0
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 10:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7B2605BC;
	Wed,  6 Mar 2024 10:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VC+waviz"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E068E5FDD2
	for <stable@vger.kernel.org>; Wed,  6 Mar 2024 10:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709722046; cv=none; b=ktqDnuueMbM6JvGJDRihS/MczV7EMYzCfjc5vGES5YozuapM2gP9YNSC/A+p+ZiLTlRDo7/zn5UgZ0JYLv2FukeNiM14CtSLOrVkdWLRjmED8+t+7vb07mPvfonDvc6o3JBIu1VHdK8EOX4FsRq3JsJRPIf7xzh4AOG7/lABnFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709722046; c=relaxed/simple;
	bh=T0tkg6tNNzgKe4ggRojauYOz8jIgWQEfoBASA+Nkh5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JO/sOqDy1P0gM1QwuQnMaOB8XFo8Pu7uM4ggNP23yO/ehn/xK9idSNCBYoB7RZdOUvF/I1wlCgT7y4z+lhmfRRf+ojJGWZNGLOn1khG+UIY9Cjx4TSWvwieWu1W0XHVIvNQLArpLmmyEdYxlCTkd1Rm9UKWQQaWRlYc9an8aBO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VC+waviz; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-472d1912f80so422656137.3
        for <stable@vger.kernel.org>; Wed, 06 Mar 2024 02:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709722044; x=1710326844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sw05fDmD/5sw/n+gj4x6MEl4S6mdDxa4iaEzvHHso+g=;
        b=VC+wavizYS7XHaXmzOKL+YqIfVDnXqH9zie7ngCVDFPsoI6DiCreNLhk7koTPQ0/Qt
         0xALrnHchi2P7w2/mG9rMQyIEbEvSmjPBL6l8OlKaJtsHi/4RwnE+z15tH2jIdEOHeFT
         AxpP+YLXNyEnwp1niah2Jp97fy+B69kJvbnQiQb97MUz8c4rbJc5RNxtR+5cL+HYckof
         Zkg8nDCgEpEiN8x0UqTBufxqII0HtObyxkLaFAc65SfI3Q8KK0UBCTgcvnMzK9dFaJVh
         kexcZirml7vZn8AqdnIG/tjVmQDl4qRdNjZPmpa7y7edhDzml1i6sugFkCfDM6bU6fHQ
         CbMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709722044; x=1710326844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sw05fDmD/5sw/n+gj4x6MEl4S6mdDxa4iaEzvHHso+g=;
        b=HK21L6FDqz1F9kdVXO9AKmXDASNqY9Zwc//Yz0GHY1eF3C8k6NBpD3bYgco668p3Hk
         Asu2yGb0nBWv4wxr8oUfrmCvdZEFBaVDSWNrPJtsmtqCQfuKFmFyIC+EIb6uBIXGxkoO
         5nopDOvNRzlvYo19eHekE4ven05dUAdvP29/cmVpZWbW9kICLmuwNL662XOpthr6YZSC
         aoZvulFhcYEdNOJRiR24e4iAumewQtU6JzPSW8MEO15qtwd7llo3UdIP+tXIJ5Y31zDs
         QvZ2qJxD6eg7aVMjm2Dee3PEv7LPX8R2GXTBHVus9Yjvk9cWirfw+KmrqIZl6DLf5giM
         1ICQ==
X-Gm-Message-State: AOJu0YwHukQBwtWWJr1xRi20JSHsYuZWbuyT2zqhqveKkUskY6vffi/V
	m8UNJZhL/JilCbj8WLOrMZN2+AUu7C5tRjwlyjvBsyr40rCBmq+wsXsxviJJMeWx1AhGgYG07SQ
	yHgWCSBHqEKYUSWH+YL6i0hPS+lliUDu/RhbGCQ==
X-Google-Smtp-Source: AGHT+IHFMma7JuSceVxjvjNRcZ0aadlI+aj3d1JXNvjpIxhakTYNUAvBqf/soLRi+E9TJ3sHbH/sfpJqlCtd0CiIXY8=
X-Received: by 2002:a67:e3b8:0:b0:472:e85e:7a53 with SMTP id
 j24-20020a67e3b8000000b00472e85e7a53mr1941063vsm.33.1709722043784; Wed, 06
 Mar 2024 02:47:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304211535.741936181@linuxfoundation.org>
In-Reply-To: <20240304211535.741936181@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 6 Mar 2024 16:17:12 +0530
Message-ID: <CA+G9fYtOAL4Kco7zCMp38niCHUJ7Z1hxV5VkT8VnbaWF4mqt_Q@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/25] 5.4.271-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 5 Mar 2024 at 03:04, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.271 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.271-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.4.271-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.4.y
* git commit: fe27532da81b5465567e329b6950454328c9482f
* git describe: v5.4.269-110-gfe27532da81b
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.2=
69-110-gfe27532da81b

## Test Regressions (compared to v5.4.269)

## Metric Regressions (compared to v5.4.269)

## Test Fixes (compared to v5.4.269)

## Metric Fixes (compared to v5.4.269)

## Test result summary
total: 98648, pass: 77795, fail: 4006, skip: 16788, xfail: 59

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 138 total, 138 passed, 0 failed
* arm64: 38 total, 36 passed, 2 failed
* i386: 25 total, 19 passed, 6 failed
* mips: 27 total, 27 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 12 total, 12 passed, 0 failed
* s390: 8 total, 8 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 34 total, 34 passed, 0 failed

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
* kselftest-sigaltstack
* kselftest-size
* kselftest-tc-testing
* kselftest-timens
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-user_events
* kselftest-vDSO
* kselftest-x86
* kselftest-zram
* kunit
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

