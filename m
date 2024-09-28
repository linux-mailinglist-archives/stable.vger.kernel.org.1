Return-Path: <stable+bounces-78176-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C62988F79
	for <lists+stable@lfdr.de>; Sat, 28 Sep 2024 15:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78C651C20846
	for <lists+stable@lfdr.de>; Sat, 28 Sep 2024 13:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E131E188727;
	Sat, 28 Sep 2024 13:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pETDgV7R"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBC6187FF4
	for <stable@vger.kernel.org>; Sat, 28 Sep 2024 13:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727530982; cv=none; b=ndqdhGoCs3OXEz9BfruDknqttBaTTNvtNd6shLB43BCNiecTYZgTat+4PxKTY2ShURZUjj0Fx4gzOa7w/hRjgxNXlzP3NMPzqLhNFfvCDx1vm9Cf4J/2RStyKePz5V0wx3ZyQwiAagwfQL3cde+hPlqgXEs3/wun6dBUY8ZA/l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727530982; c=relaxed/simple;
	bh=j8+uLbNk15LUD/swoLKPjamTGdWDzEdyurpg9CKJ4HA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sx3yefP3XC222VsBo8Nd1aWF6Plz77HWeMCKF0r34mPt6syb6ibSL6x2eL8Chu5fimT8j8YKGxJzyUfkCMxT+HdJGGaGRffXYp7zSLtgWzE4Gur06ekJylssVGPEZ41t+4qNNlZibmyogRj4VwNoVIbaz1OBmE2P85hbzKAxyXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pETDgV7R; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5094e0c0d71so87740e0c.2
        for <stable@vger.kernel.org>; Sat, 28 Sep 2024 06:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727530979; x=1728135779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c53yyAs7E6NtQLNrLLtPZdGoIfca6+dE3YJrHfT4exo=;
        b=pETDgV7RIbkKqe1sV9HRWG6CR823Oyx8EUwTOvXSFTxvxLiOgpmvOxFCcYWoejV6eO
         2xUDhwfKY3MkGeTtvvVDOe9NJjojpr9KOTix10n2Is5kNRmCGA4WB8A9XeV/oN1Ab8KM
         NY1VmAUkb6XFRWeieViT/sQUBKDEIYGIdgQmGf/FJbwW6sg98O99Tu44u/Kmpr5OPV1a
         875xQ6GMg+Ojdo9tOhhGalxW4c3mPzZRU/bMcaU5yWcKcAkGYbWpsoBezQjUYosLernV
         CJZtWnLCPoooXZ+l59l/M/u+3YqXyxxW/ceYe5bVk6NG3X4/O5gN6MwhU7njBapYsDmu
         GYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727530979; x=1728135779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c53yyAs7E6NtQLNrLLtPZdGoIfca6+dE3YJrHfT4exo=;
        b=Fb63Vjh7vHbAXnYTqn0AXLDzxzWRVWGpEoAI8YRkjaCOYSdDrU9m4Wc5BDAXPE5n3t
         4/ujPtWTPsAfbMq8olu98Wl8aoxIqzGddKQsntPHQP4yGqpe/n3raQpzeDO4sPU4IMyY
         2GVpyTXOZAhecH/NcHbeSGb9me5DDEHxhywwY5XlG6JWLL8mRl+yC0aX+XPCX0isa0SO
         /5hsTO1YhuyCEbXnlTkzaO2Vlk6IH87vemElqZQZ395AsNiTJvE6ynvFEfNLWvuJc50w
         s+5CXsZub+W1Y6nlrFe+jwXqLklMsf3eGJIUYXPahnlq5y3f4y9IGarOM3cqqdHnehdh
         euzw==
X-Gm-Message-State: AOJu0Yzbe1257cHDBuKsoahcKYZC95EzeBkcZGq0xu5U7RQKMFhUiegK
	sLVmcwZ5qqXnX36jMlZbUli9KvQFjky2gqbNyRB3N1qhObvjLR/A2feRMtDtDi7Um+IYx3dRRg+
	QjqlFfYjd4fDTvnoEZzmQ+y3HSK80mYl1G7Vb3v/8x34npOLxMeE=
X-Google-Smtp-Source: AGHT+IFXav694ULLBUcIHDeEBtyNOQd2icWi28G4aTHq/JtEB90SqMDUHu4yQWX4LIEEwmaG089P2mrQbxxAZaJ7Bdg=
X-Received: by 2002:a05:6122:921:b0:4f6:b094:80b1 with SMTP id
 71dfb90a1353d-507818ca8f7mr4297460e0c.11.1727530979073; Sat, 28 Sep 2024
 06:42:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927121715.213013166@linuxfoundation.org>
In-Reply-To: <20240927121715.213013166@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 28 Sep 2024 19:12:47 +0530
Message-ID: <CA+G9fYskpf=rGsmQ2QCZ2GVvBEuO5Fc5ROWuu4a6udSB9c22GA@mail.gmail.com>
Subject: Re: [PATCH 6.11 00/12] 6.11.1-rc1 review
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

On Fri, 27 Sept 2024 at 18:00, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.11.1 release.
> There are 12 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 29 Sep 2024 12:17:00 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.11.1-rc1.gz
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
* kernel: 6.11.1-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: cecd751a2d94beedbaab82f5eb42ed19b0bbff41
* git describe: v6.11-13-gcecd751a2d94
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.11.y/build/v6.11=
-13-gcecd751a2d94/

## Test Regressions (compared to v6.11)

## Metric Regressions (compared to v6.11)

## Test Fixes (compared to v6.11)

## Metric Fixes (compared to v6.11)

## Test result summary
total: 225868, pass: 197174, fail: 2806, skip: 25888

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 131 total, 129 passed, 2 failed
* arm64: 43 total, 43 passed, 0 failed
* i386: 28 total, 26 passed, 2 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 3 passed, 1 failed
* powerpc: 36 total, 35 passed, 1 failed
* riscv: 12 total, 11 passed, 1 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 6 passed, 1 failed
* x86_64: 35 total, 34 passed, 1 failed

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
* ltp-ma[
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

