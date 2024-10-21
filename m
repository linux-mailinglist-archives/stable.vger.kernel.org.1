Return-Path: <stable+bounces-87626-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B91A9A731B
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 21:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D4212833A8
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 19:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7811FB3F2;
	Mon, 21 Oct 2024 19:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VtWWu6uL"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABFE1EEE0
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 19:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729538434; cv=none; b=uZu8djNdwqKZTBr4PqaDC6yt1dG3TfLfSJMm0cyMFkBOsWlUS5kfY6m/WIb8yFZ8c2dVSLh3sY3q6/aYBg0Hwd6NpB0DSmNBn5lyvBAhXQUbmX4/vSGgciIQBWUc0peYMYQp1Pr8xrw8eO5darMs2q7VPnLTrgZyizylJ/MY8pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729538434; c=relaxed/simple;
	bh=X+BqB4m3qGiikLAH4c0bPLfQQ1ZnoUYOSeFkn0/BV1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AM4lVwiPQwnYG+FAzC2iLakx4/wCFMP5MZcrm9slCn384tpNsPteOOIwMTxxygPfjVdIJo2pOybEVQgNgiZlwCEa7p8FSd241XzrQD1owtNBM6OzrO51tc7CeiXItLGWs/xE25pgELXdlW96SfCiSO59VU23cJknBDxmWkoTILA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VtWWu6uL; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-84fd059e49dso1322042241.1
        for <stable@vger.kernel.org>; Mon, 21 Oct 2024 12:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729538430; x=1730143230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vert6VuWRQoFH6tsezfjZ9Blc9TeqIOBYLRy1ol7FKk=;
        b=VtWWu6uLerUeVz0ZvicH8rfmizCD3cAi75z2D69a68FuQWLcfMKGWfsVlwH+JAXvW5
         qb3LqDmQbAbGT8bSk8WbrXTO28nbu5FdAR3puSd/YW/FgOsPelsszE5MCMp2+EqgxAqi
         rBSyNvBrIp5I7W2d0kqm66Rk7zUp9ixa/NnZDYqxVN4TgqGwVk5LetJo73Q9Srm1TR1O
         CpdC0J88E4SllB5X9X1jqQmXtfJXYpX+aQQtAiRKvE+ZfjcjdjmCURYW/W4QxYzfl4nt
         R1aB6vTc4EEi2LaVp3U5U5tW2EKNepFnFzQ8cujl6oJcqgSPx6BG4nUnfCmAD2ZZhjPl
         NZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729538430; x=1730143230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vert6VuWRQoFH6tsezfjZ9Blc9TeqIOBYLRy1ol7FKk=;
        b=QGNyW+wwSMuhvjI+FfpbkESk21LW6I86oiGWOyefGgjuWMtWAvk0qFWbn7OugrTPy5
         zkxuN6IRXIoB4rGyyJsFUDAcjY9pPudYvS8JafVmnW0EqvGU54FSh5hB56IystXRkgjf
         JgTMW/7h1lFojiqDuQP0ml2kHYLE/xdiAWmXP25XYn7EE1OG8ZXgnQUqee4uG2Js2byd
         ICzr0CggYe1dhoL3rQDeVvsL0tbTHitCCFS2jmiGFSRWG1j2Kjaj2d4PFKP4RDkTApUT
         r60jvY9bd7gMdDfliYn28ih4C1lj76DVzjaUaA6B6kxkF3lKlqMZ6UblYG9J4S4wv3Gg
         DGww==
X-Gm-Message-State: AOJu0YyV4yXMtJ7PCHVmlGitbaHps3XA91P7tOxWCjnnqDSv05ZTA3WU
	H5PsWBE5H9hQbCerEfTABHRQUXjEsf11I7DId6Zl7yaJC1n9R87gx/mFaj0BfeKrJX8CmmWAjqn
	pu1qkHm+fVIdSu3dOjEUv6XS51n4BdRWFHECgyQ==
X-Google-Smtp-Source: AGHT+IFzrHON7EUJ5b34Xli0Mwpct9YMdi8X2Xx69LaqV+Tdl8QUb43GqBLOD5tk37yRZb6XyiauK7V+SVav5ptOpzY=
X-Received: by 2002:a05:6102:2ac7:b0:48f:df11:5f28 with SMTP id
 ada2fe7eead31-4a5d690eeecmr10795506137.0.1729538429893; Mon, 21 Oct 2024
 12:20:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021102259.324175287@linuxfoundation.org>
In-Reply-To: <20241021102259.324175287@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 22 Oct 2024 00:50:18 +0530
Message-ID: <CA+G9fYvfZEBkAwJ9AMFcfnyMNfqDnce4xk-v6VkKywV3Y7t2qA@mail.gmail.com>
Subject: Re: [PATCH 6.11 000/135] 6.11.5-rc1 review
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

On Mon, 21 Oct 2024 at 15:57, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.11.5 release.
> There are 135 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 23 Oct 2024 10:22:25 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.11.5-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.11.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.11.5-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 96563e3507d7fd82e448c6803ed8e07bc6e5ec86
* git describe: v6.11.4-136-g96563e3507d7
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.11.y/build/v6.11=
.4-136-g96563e3507d7

## Test Regressions (compared to v6.11.3-213-g9e707bd5fc59)

## Metric Regressions (compared to v6.11.3-213-g9e707bd5fc59)

## Test Fixes (compared to v6.11.3-213-g9e707bd5fc59)

## Metric Fixes (compared to v6.11.3-213-g9e707bd5fc59)

## Test result summary
total: 140250, pass: 115901, fail: 1938, skip: 22411, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 131 total, 129 passed, 2 failed
* arm64: 43 total, 43 passed, 0 failed
* i386: 18 total, 16 passed, 2 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 35 passed, 1 failed
* riscv: 16 total, 14 passed, 2 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 35 total, 35 passed, 0 failed

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

