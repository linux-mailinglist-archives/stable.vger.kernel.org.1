Return-Path: <stable+bounces-126988-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B375A754D7
	for <lists+stable@lfdr.de>; Sat, 29 Mar 2025 08:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D18A188F223
	for <lists+stable@lfdr.de>; Sat, 29 Mar 2025 07:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8472A18BC36;
	Sat, 29 Mar 2025 07:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L2PDGXlz"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824F33F9D5
	for <stable@vger.kernel.org>; Sat, 29 Mar 2025 07:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743234584; cv=none; b=TN39yfOFXlNwSSVjpSsVQwIp+l6ImwQP4AUQJ9/lPe0zF1EQ6otkl+9MlGsocwDgWmyFWFZ11NQLwlpYOvA8cx6R0QU7tcYvEQdGWAuGhrGKyy+GaNkphTdu97XPocGSZt0lYiqnDmq5IMVnAjzqNmiNFeszQ3UPqKXSkt4OVqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743234584; c=relaxed/simple;
	bh=MHHRWUXC0T3tGXItDSQMukJjIL8/ZiY7+/F3ZN8HeOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IGX7KzVDQQ4oZjFzSQlpTJ5z29tdqAB86H/GGjS+/FUgshEV+CdzVqGJGdxKn5v3nsLVvG5EWfq+Zz22s8g904MH2sq1f6LNOst18P6kcni7CEkbOiGf6bCQL2sA5Xba2RI7EfBsYsfA8oAM7GO/u81WpRb4svjflenj25audsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L2PDGXlz; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-523ed8ac2a3so1327111e0c.3
        for <stable@vger.kernel.org>; Sat, 29 Mar 2025 00:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743234581; x=1743839381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3C2zpjI32ZH68ExPTYzRVA/xIOTUen94tCifkIcqHY8=;
        b=L2PDGXlzgfCGTyhRHXaHhko7e8o65jacAEgCZU2toO4OsO4MAj+1OWQ09KMYwvioh+
         N36Is/VkRQN88shAsqReIOFC/HNCCpdspqbIXZNRiUTN6w48ecWsf7Ht8FzhQPNW6T9p
         f8/CMMX4ydmZnrGKanmP6zkKjp8yhpTAZkxUx6eHq8WRzamT289gX2UVOda3+vu2C/Py
         Mti1iNr0czFYuttHt663o5UDX0IcSaLy+K8hf0T6KogHlUdaBU2f6qINjWV7mDSDKKYh
         Cyhr7gyykNeEnUv142GVVOyw49a4uoXD+wdufz9qh/TrVsDN7zUmV7oIp61gvXIbI94J
         /pjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743234581; x=1743839381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3C2zpjI32ZH68ExPTYzRVA/xIOTUen94tCifkIcqHY8=;
        b=hM50hp/yAE5yCAoeGf4o4yPdOc1QG5k0Xk7V+7Gv+o9T9o5lkY9j2WK1coJuvNmBnR
         NwVM04+0lKKQF4leFSwcM/t+tkxtl1QV1lBdY75ka3EykR0MsKDsBaD0RrL7leUbF2Bg
         7+sAn+5HzGCY+yKgSUaTugdoeoAkt/ezhmc7wtttKlLXi6lsu/pAlA9DzehdFSEnB1Tf
         nI119eVUbN6qxorFmKx9IDbNaALvt6WGD+kaWaT2f20JkRMNpNhKBLJ8PWTRjrUmAt4O
         5a5NXdc4Nv2U4t3ZP+XaMJ6ziGpFR+qazAoBaAcl2+OvgVgTbOBjABe5CVBfjFCKtV1L
         vtaQ==
X-Gm-Message-State: AOJu0YxlQBNwZcfiC38ak3FWRADKra/ihTz7cxRkw+n42FStGT46aeMa
	YThPWJ10UrBTFvy6kv+g008/gG8Yk8yxydOCjbedWao33SlnBx43WzNJN2sI6Z4Cs7Wqw0Q1472
	6C03YFuVCSEUf99rYcD+e9VZrtso4UQREqn7rnw==
X-Gm-Gg: ASbGncukPc7wkRG9BW+Fmi5DRheH49kFA34vqEsfS++u6CNHv98cfabIc7Eln0DfyMK
	xfT/iPOfDb1Z97/jnsh15Jqv5ACi2Mu/i4oORZhpSueMtpRDEZ0bImz0diHYqWXHs2S3t1c8tqX
	QZbEJMtgcy9NLfH1H0U8FOTbkl4HXE7iLXMYQ2il5iLbo3Yq7uIDpAKzDwRlY=
X-Google-Smtp-Source: AGHT+IEjxd3QzrvH+Pg9A2NoNz2kh0BR0YjkJNSydoZFwQZzM8b49otZVjs3S4/pPOgfbZ58TTgNgeYQCStbEnP22Ec=
X-Received: by 2002:a05:6122:3d0e:b0:523:8230:70db with SMTP id
 71dfb90a1353d-5261d4e0e18mr1295865e0c.10.1743234581158; Sat, 29 Mar 2025
 00:49:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250328074420.301061796@linuxfoundation.org>
In-Reply-To: <20250328074420.301061796@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 29 Mar 2025 13:19:29 +0530
X-Gm-Features: AQ5f1Jo6C5mPNw0OZrMB7VjXrQqsCNSD0uiLzOh0vpRmVRtg_TkWKb_6VsjrOAk
Message-ID: <CA+G9fYsydn0Y=UMSdDagnnT4Xsb-MP0vfStYaqK8uxDUACsUUg@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/197] 6.1.132-rc3 review
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

On Fri, 28 Mar 2025 at 13:18, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.132 release.
> There are 197 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 30 Mar 2025 07:43:56 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.132-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.1.132-rc3
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 0c858fc73636037dc5394a03850eac9083de1dea
* git describe: v6.1.131-198-g0c858fc73636
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
31-198-g0c858fc73636

## Test Regressions (compared to v6.1.130-110-g5ccfb4c1075f)

## Metric Regressions (compared to v6.1.130-110-g5ccfb4c1075f)

## Test Fixes (compared to v6.1.130-110-g5ccfb4c1075f)

## Metric Fixes (compared to v6.1.130-110-g5ccfb4c1075f)

## Test result summary
total: 105955, pass: 82570, fail: 4156, skip: 18738, xfail: 491

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 139 total, 139 passed, 0 failed
* arm64: 46 total, 42 passed, 4 failed
* i386: 31 total, 25 passed, 6 failed
* mips: 30 total, 25 passed, 5 failed
* parisc: 5 total, 5 passed, 0 failed
* powerpc: 36 total, 33 passed, 3 failed
* riscv: 14 total, 13 passed, 1 failed
* s390: 18 total, 15 passed, 3 failed
* sh: 12 total, 10 passed, 2 failed
* sparc: 9 total, 8 passed, 1 failed
* x86_64: 38 total, 38 passed, 0 failed

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

