Return-Path: <stable+bounces-45250-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 056538C7233
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 09:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83A751F21FD8
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 07:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A8B4501A;
	Thu, 16 May 2024 07:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x3oW+ScS"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940514EB56
	for <stable@vger.kernel.org>; Thu, 16 May 2024 07:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715845318; cv=none; b=h+UnQzYGs94VoYha2TNi7LqHMVRvpZ5vDAtshenv7VWdtNMFFItzlo5o/QUZtQfAHXJreHjy7TvvpvUAbtiZuXb+SWN3HS37HzA4yNptH3en9sLQzEjF024yt8JVms9KJos14aUTICt2KW6zVr1IvAjPqDhty6/22h+BvtFcyH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715845318; c=relaxed/simple;
	bh=j/jADXi8aVK219RoMXFxr0FK2LP/W6+xdunhiuD316E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R2swGWoCR7nQtXIRNFpiVM4FVnOdMTMC3TWwL+ZKDVul/uTD6lX00iprV7UcjzRHlEAGw47q4DUQ0IQFhfDnITx2LeHimcT6WyHMSa+yDRXj87sIVULU7Xxb8+V8kSM6jNDacczGBibWScLXYldes5muW+dqUH2a6Mn3y2kbV+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x3oW+ScS; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-47eefa04398so2272413137.3
        for <stable@vger.kernel.org>; Thu, 16 May 2024 00:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715845315; x=1716450115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dc20ps0jcAFJUuVh3rL9TK1FgnvbqFRCMsnNsO8X2rw=;
        b=x3oW+ScSEKzaW9i0V98auQV89j1mqCzoz9Lq1lW8tHCymMKHSaFaq2byOHY6V3xQ81
         lDj7iKuK7O8g8FHDysOKWn2P7lAPCHTLB6N6KxwQGEadh/XrI9LY373zgt+AP0FbiUPk
         6g8LOo39aYeEoZ62EFqC7deh2udOei9q3mZtTGp6avYHKKgemrsd7c54Y2QqzGZH0LYy
         b1Yh2Z8UhzGTENFLlXYnZoAPVwy1SSE5XbMjg/zYfQENQ+BAO30axrUD42QWpVMpYOWr
         n4l2lzPsgOO0qz8zt0sPpNnu6M9Y7jczb3j/k3133VcDaISysqkYJMuvXtrh0sMFt4H1
         RTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715845315; x=1716450115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dc20ps0jcAFJUuVh3rL9TK1FgnvbqFRCMsnNsO8X2rw=;
        b=OMmkOeQl2kQuzNwc20fX4ZYjF8pWo97ixqNZikLD/LBQG5Zar6RZtmXmB1hGcGKqyP
         DSNlpUXHTbewUn5sVIle8Sifc47kDoFcv3zPy46lBaqlEM0unwK/Pm2Y7xNeqVOLJ5oZ
         Qut1ONZes4ZKXU+6gDT7OowFla5UddztjvzqSrupVC9iBNnmeIgMvJcjPeLRSSX5AW1S
         c06zLjHwrialeNdDtHrRxkraRGFUClZ703EizQ08HCepVi5pqRFaUjTrgidFdGZm8eIZ
         eXlpj7Pw6X014pQ2QQlwRJx32sTkE5PD1JBCeVM3j2RbceIiBdeZsTG5BXMAAtQqZXnw
         thPg==
X-Gm-Message-State: AOJu0Yz126dWC0nmGA1XxuNxAjOcYBRnLZYTlChaxTzhszcdKWccSGrL
	5i6hDWpeK8iNiy3MQwxrQOe7/LCAkC2R/ySSWYGPpnGE3Fy0XHGHt68klx7ppksZJ32SodfAvOA
	IE+IugKUmjBeJNK/kpBml3i2wC9FGtTHt1IDQNg==
X-Google-Smtp-Source: AGHT+IFhhy55sY01/+/Zby73Vqqeyn4UsGekdgGN26SRGbbQ48ktrx1ypYxjBGoTD2XxjGyZO3aaJBMLOFQX+ce/Htg=
X-Received: by 2002:a05:6102:38cb:b0:47c:f0d:3ba1 with SMTP id
 ada2fe7eead31-48077e83090mr17760401137.27.1715845315492; Thu, 16 May 2024
 00:41:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514100951.686412426@linuxfoundation.org>
In-Reply-To: <20240514100951.686412426@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 16 May 2024 09:41:44 +0200
Message-ID: <CA+G9fYvGZjMKyM+5HoPOhYT2mHx9K4JxbWR1m59RqpaH=8CxoA@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/84] 5.4.276-rc1 review
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

On Tue, 14 May 2024 at 13:43, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.276 release.
> There are 84 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 16 May 2024 10:09:32 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.276-rc1.gz
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
* kernel: 5.4.276-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.4.y
* git commit: ea8a1bc66159e9f769146360b41d36e87537045e
* git describe: v5.4.275-81-gea8a1bc66159
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.2=
75-81-gea8a1bc66159/

## Test Regressions (compared to v5.4.275)

## Metric Regressions (compared to v5.4.275)

## Test Fixes (compared to v5.4.275)

## Metric Fixes (compared to v5.4.275)

## Test result summary
total: 79349, pass: 65689, fail: 1047, skip: 12565, xfail: 48

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 135 total, 135 passed, 0 failed
* arm64: 35 total, 33 passed, 2 failed
* i386: 23 total, 17 passed, 6 failed
* mips: 25 total, 25 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 30 total, 30 passed, 0 failed
* riscv: 9 total, 9 passed, 0 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 31 total, 31 passed, 0 failed

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

