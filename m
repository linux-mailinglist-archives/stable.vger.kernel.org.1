Return-Path: <stable+bounces-107812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B85A039D7
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 09:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A223B1882AD7
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 08:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947571DF726;
	Tue,  7 Jan 2025 08:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dd5fRzZ0"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EBD13D279
	for <stable@vger.kernel.org>; Tue,  7 Jan 2025 08:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736238805; cv=none; b=TivzL8YURVh4lQx27EzWW14tloxOMxBsuwliK2JmEBil4tp1RvOy/JvBLoDDsSWTbDONG5PKfpPyf31nWQMxc+njvLuW2WYDEOml8fDOmE413GBMNKoO5S2JKC3V1AGs19v2O7laSuSLpulE+hHur5J36DkZEITKfRaBubfiDk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736238805; c=relaxed/simple;
	bh=o3c4xW01MlLt6AqvT50LxovUv1h70hmJ6kadq6rLOh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D7HQ7wqr8FwuzBZeAUs+/JgxRl9+moWQY7tDDuE2NGFLvxnXCtM6stqF+DmTL3YdB8WkXSseoeyEXPc4Ium36mET0PS79L1dghqRwiZ7qQlWBw/EHI8hy4i74sftXurIrx/P+vGnGquvc49OzVVObELAA0bUK7MwjzeawygMOIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dd5fRzZ0; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4afdf300d07so8379191137.3
        for <stable@vger.kernel.org>; Tue, 07 Jan 2025 00:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736238801; x=1736843601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AOb3+hAddSIUzdjpQrT/NEZaORWBlzf1SKg8j80MHAc=;
        b=Dd5fRzZ0RRBUnof9eXh+GKJhamw63oiqD1nbTaL0Rk0gpmuYM7eTeW3j8ueqK0RvT4
         Yfugv4w8xf19TM03+ZEX8O5TU8W75mC//8WXsPFRf9wDOeDKw8iBd90Pde3egTiFt50A
         uQiiiNH+0QAxi6KwdHA73v46E+HgILzFq+fKTa9o9umE4D4dMWedhUd9/BHhKAG9gxrG
         PgkBZsF6V+Akkuw8Sb1JAdUFfs6g4ucoPdoovfSNeONQMaIjtzxW9GfChlrg+PEp6aae
         yf0i1w0ITEA5egwuDg47ku9VQcZAyWJgSF9VPQcJL5hgmMqlqIPBy+QRh3sWzlLI6HjZ
         BuOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736238801; x=1736843601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AOb3+hAddSIUzdjpQrT/NEZaORWBlzf1SKg8j80MHAc=;
        b=fUhJIA60q31xVX5SmSaAbCAHBOWIZXbWGpa34JF9Ne/6Y6aQVd+X9p0KP8kvIWbdlZ
         VdmAGEivUorWmQ+BRSdXVY0UaZQRBx3LzYDrBRxA0zHe51lw+0aS98XjX7fbdswCgupo
         Il5s8FW3/nVcuNn5kW7Mec/mNrHJR7+ComwFYccs2p/pO2NLomSbqHWmXq6Gvvx6is77
         o37IoBiM5DlmW6q7BZkYm2g0Nzo6VUZcOhZ+YzJv2dXo7+wSOJnwK1KWaBnb/yvS9mpd
         ulC7YiKEcM6DqNJF+9aaixo6aL0QDD8qVc6groZnPOsq2EYb7ALbN3v0PPmxg+AS34dg
         g46A==
X-Gm-Message-State: AOJu0YwVkv88MhqcpkM2DKZQf29/DWvB77W6+F/+X39AOVTS/uvPZ93W
	6xmzlHlQOehpMcTvjYm1K+/pe+REb/9eA/zfcvZhu8U6laqQ23uU1AsXmUl4wMCZbUu6oYDo+PO
	8tMdM17FaXSzg4Iyxxdp186jWK2/f5uM18WNmXA==
X-Gm-Gg: ASbGnctr5NAUZUmYtC1Wm05IOkvIEcY/B5/MmdJfRo/NGOLSj+oVK+HGOF7XOwRirLw
	T5r6ivZao2fW8KuLhj2KHzJntEYhtFwzbvWRS6Mk=
X-Google-Smtp-Source: AGHT+IG7ZVdbFjQkwvo9+d7q0UxDBknTtxsvnf8taB/cPAZ4LDxl7qsgCBaerGbta/UN4qnRz6M0BYXLL5SJpvG73mI=
X-Received: by 2002:a05:6102:548f:b0:4b2:ae3e:3ff with SMTP id
 ada2fe7eead31-4b2cc48a5eemr42731959137.27.1736238801229; Tue, 07 Jan 2025
 00:33:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106151141.738050441@linuxfoundation.org>
In-Reply-To: <20250106151141.738050441@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 7 Jan 2025 14:03:09 +0530
X-Gm-Features: AbW1kvaG91wnd1vMUK0C0HwzbTQbv1w3Mgho9lRI6s0h_W8EwlnNb-mIG4skv3I
Message-ID: <CA+G9fYtyKfP2pqMc8hOM=wd3hjbR5ffEA=4Q7VWZECbNP-SBaQ@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/156] 6.12.9-rc1 review
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

On Mon, 6 Jan 2025 at 21:04, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.9 release.
> There are 156 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 08 Jan 2025 15:11:04 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.9-rc1.gz
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
* kernel: 6.12.9-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: cab9a964396de70339b5d65f9666da355b6c164e
* git describe: v6.12.8-157-gcab9a964396d
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12=
.8-157-gcab9a964396d

## Test Regressions (compared to v6.12.7-115-ged0d55fbe89c)

## Metric Regressions (compared to v6.12.7-115-ged0d55fbe89c)

## Test Fixes (compared to v6.12.7-115-ged0d55fbe89c)

## Metric Fixes (compared to v6.12.7-115-ged0d55fbe89c)

## Test result summary
total: 113584, pass: 91189, fail: 4574, skip: 17818, xfail: 3

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 143 total, 137 passed, 6 failed
* arm64: 58 total, 56 passed, 2 failed
* i386: 22 total, 19 passed, 3 failed
* mips: 38 total, 33 passed, 5 failed
* parisc: 5 total, 3 passed, 2 failed
* powerpc: 44 total, 40 passed, 4 failed
* riscv: 27 total, 24 passed, 3 failed
* s390: 26 total, 22 passed, 4 failed
* sh: 6 total, 5 passed, 1 failed
* sparc: 5 total, 3 passed, 2 failed
* x86_64: 50 total, 49 passed, 1 failed

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

