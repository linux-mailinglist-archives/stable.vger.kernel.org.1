Return-Path: <stable+bounces-92905-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB229C6D63
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 12:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F289D1F24CD1
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 11:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5F61FF5F2;
	Wed, 13 Nov 2024 11:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zZ46wYmy"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33021FF5F9
	for <stable@vger.kernel.org>; Wed, 13 Nov 2024 11:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731495970; cv=none; b=pw+5K2RzCz3LGU3kMCqneEvk+84YAQQa+1yRzqZNT/vOX6F1gVxFIP2bRCfIAgZLs1ESwHtThq6wz6PnTeOy0CIs2mOU93tPe6TmmhnHGZ+0aZpVeFEPXlcdDwuLTBnuwgAriR77kGxk3U6NYZMV1dJkU2s51VzS8rpju5Sf6ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731495970; c=relaxed/simple;
	bh=9w1adhm4OIkWgFRN1hDiDFpoQSbwWNGU96qvtFz9gAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M4UR45jR1c0i8aJv3BRFeuo0v2jX8gBYRyPlqXDSlpZZhNuFCLT8NdJTZsh1BTS4d0+dki05/inBRlSFe9Y3u2HTwYbLN5muTi+Fk92+F0b6zs2i/Cz2zd+pBTh1TqwZ3SBDCJT3+Ijw6lEhq6bdR5Kjru5H+z+46pPdiPhcpiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zZ46wYmy; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-84fcfe29e09so2617176241.2
        for <stable@vger.kernel.org>; Wed, 13 Nov 2024 03:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731495967; x=1732100767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTJceuzTgFN//BIRxDZQ62yaIBfXA/2h6KzjoJYet3Q=;
        b=zZ46wYmyJnE2o7g6sm6RXJ7/24EYHnuOYD88iLb+9V8725pdo3y4C0WD16eFtrTvZy
         0d1JxvIoyTz39KW8PZDG50ZroeSlg4YpIOSeCiiD4TtAY5d7EnolcaREmoNCpgOMTe0O
         V6Oesi7YVOyie6bYKOfYLufan6/w+FLMF3yKQ8fzJqDAxZ+dpJtpXKrQpMESEGAU2+wc
         aO3kK1W6AiafXya4ZFf37iMpstGvasjjqHop34xFXobmhCCHrfBCmGpAWRDDKtdUI10N
         gvUvMK+2SonBlIJx+eNGjS8NzrAXAKl8ueNjgGucRmewx10PSLfmQzU2Cfyy19CD4MR8
         +4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731495967; x=1732100767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YTJceuzTgFN//BIRxDZQ62yaIBfXA/2h6KzjoJYet3Q=;
        b=H+3hsGoX4q2nvBGHZLwFSW5kYrbC8kKLZ8wsvMS6Cju+fCtN9TJE2bvNeZIeyvwyb/
         pfcNQOJmktPCEIZLKx7Dtm8sKHfg1EbCbqYeqW7yGjnhCRZAgvUoHLwL7zF/90F+Pvob
         e/LaLMEO9k3ERm5xnu40SkQPJHdnv919ftQGd8fRvAzUIoD3nQV+cHWNeY0Qmo3kFycu
         vEs22iyDXeC1PIcDj5JWjDo3ADa9qdc6k/Jm0vwmGEStEb8RYXJf7DJNwPO1Yy3Chigf
         M6A1nzQCtFlVu/7mPfN0LZJNAnC1Dv3IEi7XNBQfqxFXUSKcwP1ivFnnUnQLEXgTcsaT
         PE8g==
X-Gm-Message-State: AOJu0Yy8pamHP6Kz24Ygaskm/HYPiZMqrtqgZyf7kNoeShlQV1lMpAvA
	HVTH2w39uP0m/p7TxZ1PCzocZbpBydE4OPJlQ8ZARXcXtqSow2iEhopTfIYcJDgaadWwu5IFl7B
	upaLqNMtLTWd3PLq6ONMUf32jOHNUPiGPD+j2cw==
X-Google-Smtp-Source: AGHT+IGDMocD7bchTeV1O8crofiDsw5L3oHsCEad9aXSKbm2iKz41U8oJ7bQoCv7VzLfFIUKUS9u1m1UWmm2qbJ0Dgs=
X-Received: by 2002:a05:6102:2ac4:b0:4ad:4e7b:10a8 with SMTP id
 ada2fe7eead31-4ad4e7b14edmr850344137.27.1731495967541; Wed, 13 Nov 2024
 03:06:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112101900.865487674@linuxfoundation.org>
In-Reply-To: <20241112101900.865487674@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 13 Nov 2024 16:35:56 +0530
Message-ID: <CA+G9fYsT27U3v0cDOxRCE53qTDC13f8Tx2QiueD4bWOe-N-nNw@mail.gmail.com>
Subject: Re: [PATCH 6.11 000/184] 6.11.8-rc1 review
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

On Tue, 12 Nov 2024 at 16:10, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.11.8 release.
> There are 184 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 14 Nov 2024 10:18:19 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.11.8-rc1.gz
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
* kernel: 6.11.8-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: a5b459e185d11096a9edda920413f07fc50f6071
* git describe: v6.11.7-185-ga5b459e185d1
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.11.y/build/v6.11=
.7-185-ga5b459e185d1

## Test Regressions (compared to v6.11.4-646-g504b1103618a)

## Metric Regressions (compared to v6.11.4-646-g504b1103618a)

## Test Fixes (compared to v6.11.4-646-g504b1103618a)

## Metric Fixes (compared to v6.11.4-646-g504b1103618a)

## Test result summary
total: 312413, pass: 259601, fail: 3622, skip: 49190, xfail: 0

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 262 total, 258 passed, 4 failed
* arm64: 86 total, 86 passed, 0 failed
* i386: 36 total, 32 passed, 4 failed
* mips: 52 total, 50 passed, 2 failed
* parisc: 8 total, 8 passed, 0 failed
* powerpc: 64 total, 62 passed, 2 failed
* riscv: 32 total, 30 passed, 2 failed
* s390: 28 total, 26 passed, 2 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 6 passed, 2 failed
* x86_64: 70 total, 70 passed, 0 failed

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

