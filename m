Return-Path: <stable+bounces-93629-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D06439CFD4F
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 09:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07260B2551B
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 08:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6440A193079;
	Sat, 16 Nov 2024 08:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ULc7w4AD"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CB5192D8F
	for <stable@vger.kernel.org>; Sat, 16 Nov 2024 08:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731745411; cv=none; b=iJhALRbyxzKQwjt5BAS9cZua2WiVJAuidFZijVlfOxZipoa1j5S2NtxkG62PocnDihoGDlWcxwJV6XVVtQFtwzxv0VCcUWfvil3oyGyYRVLomzck3TuqIASD7iLSKA00uneZOSVWPsI+nNLkD3eaz3vQ24elQdJU3yPIcqKwR74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731745411; c=relaxed/simple;
	bh=/vAXpvQJcUvvaJpB0creFK6Tfqr0lDfjuAa3ofKrd2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gpv+pN9Z45FlCpR7VKWKU7+vW0G746WT2s21+F3j82xFnM9P4jzY+jEbVFubdYRCPnVEIi/7INAWSGQMWMv75dJU+0nxsn1TBPczhnroJowNXcx29raOUkez1WmgbtlIff0kBnclPkheigaDeIdQ7+86FNA8r0BIHUbT6lNjp5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ULc7w4AD; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5146e6531c8so672041e0c.0
        for <stable@vger.kernel.org>; Sat, 16 Nov 2024 00:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731745408; x=1732350208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jL+EGpzKO3rkWQkX1EtEQ2OUgQqQWIQ+psOwfG+IX20=;
        b=ULc7w4ADIC50yySiIJIKzkFUtrgJKZMIfPoomsmMKxTm/ypPBzcjkOQLUEUgQ4CyZ4
         KYA8oGrCSMpdmFpgKo6ITiXBIc9oYCwFPTKiWxjHoVPX0I0mxwBX98KRlQsVpvPVcJnF
         yfovS11JmC/DRyOSfWtxWUwQVVKNvON2EIQZM8guqT3Kd4zzeQKjOYuEIrkcJMjVxUu7
         AGCRYsQOXIOYIrRMGpP5AsTkaB37PMD+Dcs28n9p3oNxZ1EgT2R9s7DZHpfUzaG+3Plz
         +vUep510SjCn8vpN+jV4OJJ0nLGdoq/irwmY4Tt7xixPXup+Idub2hc+abCXTxMInkPW
         Z0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731745408; x=1732350208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jL+EGpzKO3rkWQkX1EtEQ2OUgQqQWIQ+psOwfG+IX20=;
        b=Wlvi2n6arXEIceQ94M2UToF76STXr7QvN8b5QAdTs24CPI4iRe+jG/SEZ2veotlAH9
         Sbo6qNfDns3FSPUKn/tEMFXYVduLH+iWR4aqcU+zIOrALanT1Z5IsraL9c7VzF4OAsUf
         wOK8ypjzyldd4esLQi+36zWA8tprBHq1oA8nvSbwpYoqTqMg7H3Kl4CInw2UsWyLwiiJ
         sIK4QaQ1BFC758g4GhVPPl3aoRE+zfwYmdHe60f4V+JwkHp6kWzjYvBl2TqE5rDS9nV6
         xZDwpdTNARwzVUMtJU3MFcoR1QAOFZk9250ZboAcG7i7Dz0yCPb72Lte8ysCjtbPLMmC
         lBgg==
X-Gm-Message-State: AOJu0Yy1AdckCz/eyjemZWSxvMh57nwpFx/5sfkVdN0EuQXnNCPKT1ln
	iVGeri2XHiS8JpWAIcbOL9pn5BEaIRcxWeY6X2ThH7EnsugI8KKx40DpQ+WmN7OeVcUWnu6zBq8
	Zcd/cXStdilo+6WCZmZnNjbXkqPqKZgRSYz0e/Q==
X-Google-Smtp-Source: AGHT+IFfsrHAKWiUgxHG1qmyvjcG0JFl63uHkfBHMWAOjZI7ZUVNK9whEoSXc1qn9TgWJnXz4SICKB+CG8m7VOHh2aM=
X-Received: by 2002:a05:6122:1794:b0:50d:3ec1:1546 with SMTP id
 71dfb90a1353d-51477f148b9mr6219285e0c.4.1731745408187; Sat, 16 Nov 2024
 00:23:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115063722.962047137@linuxfoundation.org>
In-Reply-To: <20241115063722.962047137@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 16 Nov 2024 13:53:16 +0530
Message-ID: <CA+G9fYuZYe7_AfPgjPMqPL9xgAq90kA5T272B3irJ-hLiM0Acg@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/48] 6.6.62-rc1 review
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

On Fri, 15 Nov 2024 at 12:21, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.62 release.
> There are 48 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 17 Nov 2024 06:37:07 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.62-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.6.62-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 68a649492c1fa0ed80e347e707b68e57128fa3c7
* git describe: v6.6.60-169-g68a649492c1f
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.6=
0-169-g68a649492c1f

## Test Regressions (compared to v6.6.60-120-gba4164ffa865)

## Metric Regressions (compared to v6.6.60-120-gba4164ffa865)

## Test Fixes (compared to v6.6.60-120-gba4164ffa865)

## Metric Fixes (compared to v6.6.60-120-gba4164ffa865)

## Test result summary
total: 149514, pass: 123228, fail: 1597, skip: 24596, xfail: 93

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 128 total, 128 passed, 0 failed
* arm64: 40 total, 40 passed, 0 failed
* i386: 27 total, 25 passed, 2 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 19 total, 19 passed, 0 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 32 total, 32 passed, 0 failed

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

