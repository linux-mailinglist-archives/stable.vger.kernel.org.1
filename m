Return-Path: <stable+bounces-197559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F51CC9108F
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 08:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 299CB4E31D3
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 07:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80152D6E67;
	Fri, 28 Nov 2025 07:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rpxv+3Uf"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3432D6E61
	for <stable@vger.kernel.org>; Fri, 28 Nov 2025 07:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764314801; cv=none; b=FNTBljmJpBq7n5rVgsJolMJcLjZ4xWfTNwha82eDEJmFdFv5nt7Pd+n9zJ0Gq5dB1Btdl9GYKEf6JH+z1VD8xkRt2RFsPO9+VBki13W5zf6x7/QESpKHGA5GcMFAzoUI6UF94pS9G3F83zHNKT/kytOaZ6magIDqH6WXmdPY/wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764314801; c=relaxed/simple;
	bh=Onl2TpckQ9ttyuBj5wfEDD4O9I9DGA0NOljfyU3CtDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V3Hhs4S9acLDjURXViL8hvCP57DsV9ccorZbtzjFaDWH3tebHaeO4ryHLybg6ovgX36Yp7v1nBPPgOBtfw1PHcBmFlMaohlqZLFQAt3YeM8rkI/8n6GINthN8r6QDC+BJvWhDHtW68pdryXD56m6I74GyQqrUnXtAzLOaM+tXiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rpxv+3Uf; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-bc0d7255434so841966a12.0
        for <stable@vger.kernel.org>; Thu, 27 Nov 2025 23:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764314799; x=1764919599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=157z9r7viSF7Wrf9hRXSEg3ckRXmsCSwlbd23w9qPsw=;
        b=Rpxv+3UfHnXp8f6GoNDvojeF7alxKEMA+gRJVGDB9JAejXzkfzXjAGRNQK1q+aUmHv
         JjgdxgoaiGE2Y1FiVKmjFcB7jbR56oKWzL2E0N/CDPHAS/FujIjiJAUZRpeeS811qLnR
         uBrbdv0OmPmAtR58uMFyTQ6hoykDjw9GoGLJC5QxRzlhSxVU4QlVnCIBtUOALxC0Bn/3
         Z1mDbBTGbST99JGz/IMLNWn6/T37CYXoIuaR2OjZsYjXSlMArH+qEwDooSlVUOfhqr3a
         NWnHqFSggjBG7bLbnSB6ORHg5SiKAOxY/0JE9csjG8n5g5XfUqMbBM2+pZFnOsNlum1U
         xOvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764314799; x=1764919599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=157z9r7viSF7Wrf9hRXSEg3ckRXmsCSwlbd23w9qPsw=;
        b=xKFBLEX/EqsJbHfX2BIo5x8a4GhPKA0Dn63Kj8N88PQU1dimDIB/BYO8yE4Xzg7Y9n
         nftgefk/h0Xg+YER5SQDrkE1gQe/HRFkgD4wpi1jKiTyyosf1jd0YdSlDJE3J75UTSgb
         e08cIDVKB3tFUE6eAWEqSN+eBkKHAcHE4KCUHiRqueZs10D9Owx/qCpPe2CstBkTQcQ2
         3JeF5E3U5tBtpUprLjzf3wycSAo9ieY1LSlZg4lzv6Gu/6OskFbibeW9ni1GG5yMhQlA
         BV58rfQ2rAWgvIAt8G/nhzJSCuYOLQC84BsSLiy83+VSjA43JUpu1d3YKcVw08gYwfwv
         C80Q==
X-Gm-Message-State: AOJu0YzN/M7I+PrXQCUahw1aBQexPIrzS9tbcYzmEG3YDfQubq9WLQdA
	fmHfDZnfJKRn7D2kQON0wJPLGl1BYx1A4v9RkJFciRxSwAL86DFeiymyVlBVEerg+ULHL54p6nb
	xH+b3YjyDaS8V8zS/8Ok72dMBJfpbZUhnRkpOD/+/SA==
X-Gm-Gg: ASbGncuBM0uz/m4lC4HbdgSV+9mYvjaw8Tvbop+/vjtW2c+1NwSQU6DjXnS3CIbJ64x
	PhfqNahsywGMTKVbyvcax+soYzAsxvXUgjIpP+5yLnUHqmnKxC9/lI4/OSf9FoIB47OvsisPyx7
	LdeWEj4AQXMQYqeWv0t+Qzwdj6Jp4zOofJTgOsf59cX450wmc3vtbOUTsT+0cbKABYjk5JCT6tf
	ZSyWXe3V4w27ndBBDmdQxW0ZcoRTZ2lD9eXeV5k7tNPJGFcS5hDPlhjkxLqMEKWaB3LoaMIuHtk
	15x2uCfE/lSGSEfhiIXdzs2di37C
X-Google-Smtp-Source: AGHT+IFcY1dlpiXsopK0jfaJYLRaV4SWNTp+pKmhuz3ErQ5moUPBqoFQtpnwhvEKy2niLlNGiEvAotewGPcCwtByltc=
X-Received: by 2002:a05:7300:e827:b0:2a4:41c3:3a45 with SMTP id
 5a478bee46e88-2a9415736femr9201430eec.2.1764314798914; Thu, 27 Nov 2025
 23:26:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127150348.216197881@linuxfoundation.org>
In-Reply-To: <20251127150348.216197881@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 28 Nov 2025 12:56:27 +0530
X-Gm-Features: AWmQ_bl4SIEOduO2IiuVY2QQXbLBZd6DDREJVut88Ph1ndilRzlaVsup6M2cG24
Message-ID: <CA+G9fYsXLTzLQBMu7LuqXUTfJyB121qX8bD2jYAYEikGSsfiaA@mail.gmail.com>
Subject: Re: [PATCH 6.17 000/176] 6.17.10-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 27 Nov 2025 at 20:36, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.10 release.
> There are 176 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 29 Nov 2025 15:03:13 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.17.10-rc2.gz
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
* kernel: 6.17.10-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 6c8c6a34f51808e7b3dedc4227e8bd060559a0e2
* git describe: v6.17.9-177-g6c8c6a34f518
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.17.y/build/v6.17=
.9-177-g6c8c6a34f518

## Test Regressions (compared to v6.17.6-1131-gddfe918dc24b)

## Metric Regressions (compared to v6.17.6-1131-gddfe918dc24b)

## Test Fixes (compared to v6.17.6-1131-gddfe918dc24b)

## Metric Fixes (compared to v6.17.6-1131-gddfe918dc24b)

## Test result summary
total: 126087, pass: 106603, fail: 4209, skip: 15275, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 139 passed, 0 failed
* arm64: 57 total, 54 passed, 3 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 39 passed, 1 failed
* riscv: 25 total, 25 passed, 0 failed
* s390: 22 total, 22 passed, 0 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 49 total, 48 passed, 1 failed

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

