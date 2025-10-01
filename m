Return-Path: <stable+bounces-182904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 336C9BAFBAD
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 10:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C1AC4E258B
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 08:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BBE19DF5F;
	Wed,  1 Oct 2025 08:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QRlqkMxc"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FA52494FF
	for <stable@vger.kernel.org>; Wed,  1 Oct 2025 08:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759308575; cv=none; b=KryaSMbSJVJGVkA5PGpDzWlj0ILHYb2WquTiP5/l3xSAQrVL4m5poGcvVir+Jrp+CulPQ4XiSQkevIzjogWmqI++cAjptjf09Tp9vlUAjgx3IAyZrvXCxlAGVmSUHj8WUk03YriZ3UlB/2/Fdt+wdkUl4m1mqFy89UTdQq2TP20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759308575; c=relaxed/simple;
	bh=QRJ9liXxFkfG7M561OyeuFb7bBN/oesi5Tc/NH8DBeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XbyuoHle1US2Zgy1hG8tlYQ+nk4YPVRshH4mx+SP+h6t0DilR8WBj2IrJwqTX3aAp9BBP+qPaLYxWAIeofKj8+CwM3KtUBRXo68JkMNe+F3+bhbOUDwtRzR7rMJp6SqnOfsSOlnyqRFRZAHoe1WlsXs2rHE6xkE/5gJDUwkEf34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QRlqkMxc; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b551350adfaso6560599a12.3
        for <stable@vger.kernel.org>; Wed, 01 Oct 2025 01:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759308573; x=1759913373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5lUFEDOlwk0GibJmBfeInBIlGX8sUYIM/tZA+M7nygI=;
        b=QRlqkMxcCSflo5XSydV/qUWSvDiP8n/E5+8n0VGvGurCKoK5xAfgEPxBDyqZhJ19bk
         S0GxHoeWoItQftkE6VzFDBTmWc/6QwnJLwImDw/0Mtir/i13rqlYPHSn8iGe+YSN61uq
         /n2C7Qc3MnNz34J0AJPK6mXjwqfvqETazX4aDDRs6FCuFM5GDlqwPkDpY0Y4yD6FWHBb
         iWWOwErWlnPPKTneEU8gf0HzTgKYWDdkmaQ3sMZqUZu9J0IwQSbrE17L/gsbw+cehYJ8
         Lvx66TJl/hpOHxuMrgthJGHkofzBmKLPZCirdGTnYqolnFxCBHXfaVbBSVm/hyLcfGt7
         YnHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759308573; x=1759913373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5lUFEDOlwk0GibJmBfeInBIlGX8sUYIM/tZA+M7nygI=;
        b=FMI+xTz+GRmyhGtDMENxre/RY6k8PzwbIGjaV0AOSkUSDctsR5H5Raa+7+Sr+xw6EV
         Lnx3voZwrfrUt0eJFctnxSbe1wRSGVdTYeNNby57xqOXpQskIlbozuo6LSWiS2uEHZVo
         TfKFXe2WmR2rjjyEDBP3+8CHXDI8vpDQNYjND53KqtxYcoMyULLOaIU1rzJze75fd9g8
         3SxCQkze+T0I3xZSqWT0fa9tCSiFwqG5THz3B4g+iLjnjNdBPSCjyVbM67wz8qNDWPHG
         AhNSraeBnwoMMIJSCt12x2b7abpyP7Ef8KyI8j5t3SXVG2ZUr9VBB/OmgmlJqV0fryQ/
         IQ+w==
X-Gm-Message-State: AOJu0YwmvMtJRfvcD8nTatbfwYmr/NOlG8LjfI7FOhA8VhlDhHt8SvWs
	Qf2BYns7sipo9C7kxQGTkt2m1PK+cXtz1bG5bLXFMokVUbHfxCQAOpL2oAr4qqveqC2k+sGUBnz
	uqQNZ9bJfUjIx8sQe1qJraq6RkVOVqop+PuKggneJ0w==
X-Gm-Gg: ASbGncsyTDKVDNo8E42PiG3hpcXLQETzEBd0FvQXTkDOhEghFUYKx4Txk2VzaeW/yQr
	KI7lPIT8jrPeqMSDTEOj9hNx4cZp+CcP7XrgZ+6389KvG14ZDHGsQ2AIMs1NRwOkwUdbnyIxuEN
	pvM+TX4+mSp3eZQEDYYP9bJryipww0KuvwheZDRgPCrfSbKkzR7ClHBcpQR6MlrfUB7Duo7uhJH
	EXSa+2+O1hQA+jtQgmWsy8rKDGRZqGlm+DRMoNT5nos4t/tMTLGEaXODGwFvRe/nPlh7FZtGWCe
	JRVEBRwb6D01WzK83BBU/UOawdkF/1k=
X-Google-Smtp-Source: AGHT+IHXdQvGj6eUadzCY2tlzRyfpnMGPewfjVo1faJS14ozece7Ob1BLBpJl8+EOXhQG2U/4x219HPYP7/eaFUDrEs=
X-Received: by 2002:a17:903:b85:b0:25d:5b09:a201 with SMTP id
 d9443c01a7336-28e7f2c6207mr36488825ad.27.1759308572985; Wed, 01 Oct 2025
 01:49:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930143831.236060637@linuxfoundation.org>
In-Reply-To: <20250930143831.236060637@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 1 Oct 2025 14:19:21 +0530
X-Gm-Features: AS18NWCvl1H8hhR2E11ihfNR1mldgcGLnS6MK4rJ4AfPqydTb0hfPaefWVGOAA0
Message-ID: <CA+G9fYvN7QxsZqQhHKqw-K4kn=rby4HmEyn=zhN-M_7uk=qLKA@mail.gmail.com>
Subject: Re: [PATCH 6.16 000/143] 6.16.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Sept 2025 at 20:31, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.16.10 release.
> There are 143 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.16.10-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.16.10-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: e1acc616e91adfbab433eb599e00d88f0bcdb07f
* git describe: v6.16.9-144-ge1acc616e91a
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.16.y/build/v6.16=
.9-144-ge1acc616e91a

## Test Regressions (compared to v6.16.8-150-gfef8d1e3eca6)

## Metric Regressions (compared to v6.16.8-150-gfef8d1e3eca6)

## Test Fixes (compared to v6.16.8-150-gfef8d1e3eca6)

## Metric Fixes (compared to v6.16.8-150-gfef8d1e3eca6)

## Test result summary
total: 351365, pass: 323894, fail: 6740, skip: 20731, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 138 passed, 1 failed
* arm64: 57 total, 56 passed, 1 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 27 passed, 7 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 39 passed, 1 failed
* riscv: 25 total, 25 passed, 0 failed
* s390: 22 total, 22 passed, 0 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 49 total, 47 passed, 2 failed

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
* modules
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

