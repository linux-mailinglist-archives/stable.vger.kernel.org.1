Return-Path: <stable+bounces-73701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE2896EAD9
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 08:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEE151F25058
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 06:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7318013D62B;
	Fri,  6 Sep 2024 06:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q/NpNEbn"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C79813D537
	for <stable@vger.kernel.org>; Fri,  6 Sep 2024 06:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725605077; cv=none; b=GM4hJtvWRhH+kZXjLVzODrztMUq0ot4f5T5dAzkSuw3kgDPey7AkfQLar8n8TXoI8gDqTWpspv5eoAsKQ7TaFe992AITfihyQvSTbN1BhwaqSN5l21dyTel0JKDYThRKPVqLRCEIm9wVtm3iA57QXEcIZ826i8N5sX4kJXTkm5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725605077; c=relaxed/simple;
	bh=oa3H9YCpx5VYGA2KbkYcPMgZzeKNVh/PFUtLWy3sJ/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RbboWEeSmD4uLW/Hxcoy08Z1E+vUR83sgOF+IUo0Jk0MCGj0VECZkYU/jnCSXumSR+dv6Hw98tXGU4oADro9YfU6ICsrG82wnaPJwlO8FPkpO/YQIyIiB+uo/XjXrKsZ+FDAPNgWucz6oWwp6tzS3QXzaYT7RWX8BXlpiY5J4l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q/NpNEbn; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-49bd40d77e5so429089137.0
        for <stable@vger.kernel.org>; Thu, 05 Sep 2024 23:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725605072; x=1726209872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gP4o7JbisYVim+/wPjL+HDCs0/A0dQBHIFGkvw0INA=;
        b=q/NpNEbnM88Iy4LVeCO+y6wBPn/oRbBwowPadxJ9OVTj9NQH9/lqaZxsWxDpExVmcX
         PZQO6a0uR1R5ZqAm2vjWXTCQsaNTIHX+IwIo9lIUn1W8sFcFV/MrRpzwAINCcIAl6J+b
         Pc+/A/VY/6YzEJvf9M1mF5oiNPqpkmkN4beIrxUStUi1JwLuMOffa+VBkGoyewiuJ83o
         GG2Kp57AdBIj920eNZdg8UehQ6ZTFOaLcleXPyoRwoqOJ51S+WIIzeWODb7RfsJ0uNmU
         Koc5HpoTOnqvooCPQPxjEiF5Awj6XAPOEG38mJQ5A0eJtzzRl/72PVxJlCtJg2Pc2mlx
         JNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725605072; x=1726209872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+gP4o7JbisYVim+/wPjL+HDCs0/A0dQBHIFGkvw0INA=;
        b=GP9HleWNcMKaKAPYBN94xyyC7uzZ6BKQXW4oiKhWBjDR6Ys8DhE382UX1rKOkwgZj5
         XuFF0nFd+njfhcS1G8pF/b693kyDtaU8Qdc3eOzFK+7sYCPKNiywrTpJxY6Jxjb92olV
         l2gVDZd6DB03qVUQo5c7e8kYTi7I117U/IcJxGjI6ekIZwmWaIcl0r1R1zwhQW8dCz6R
         ZHnRn7nrNKrcBHsRvDHgMDcntVly0t7BWBljbDvCZxlEISzUTCcI1VPvLiWrxKMUp2BA
         t/putL1Pym4DJVuPEDBjzsm2bSLtj5qrVlKSplDpFlMjQuWDKBpQMi4dLF+T7CoHrAVe
         qn8Q==
X-Gm-Message-State: AOJu0Yzg1mObJjcMRMGzKUlEpt4x6lNudJqeEkhiV7JKUVYguQSlTXRA
	lyfKbFkivz2HdFWiDj2voK+yVFN9ABZL91/1/mtuG3wP9IpxgVaeTGR9yXsg1HTsdxNeto4J23v
	ur1t0AzHQxXc+xQW/FUbm+nDJLArQyesTY5Q0qw==
X-Google-Smtp-Source: AGHT+IHuUmzECAJSrwF2r14ymHpo71IMGLjs7axdWUb+JN+ClsSfKWQfo8MjNbsnf5TglvLkxKmzZ17gWcctxFVA+yk=
X-Received: by 2002:a05:6102:b02:b0:492:a93d:7cab with SMTP id
 ada2fe7eead31-49bde165666mr2127128137.1.1725605072208; Thu, 05 Sep 2024
 23:44:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905093716.075835938@linuxfoundation.org>
In-Reply-To: <20240905093716.075835938@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 6 Sep 2024 12:14:20 +0530
Message-ID: <CA+G9fYtr3bs6RbBgLc10QJ2c2Uh4EHiif7bFOD0J+p4rEoCukw@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/101] 6.1.109-rc1 review
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

On Thu, 5 Sept 2024 at 15:31, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.109 release.
> There are 101 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 07 Sep 2024 09:36:50 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.109-rc1.gz
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
* kernel: 6.1.109-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: be9ed790219a433e9d1aa5ca79fb51e3e52bdb81
* git describe: v6.1.108-102-gbe9ed790219a
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
08-102-gbe9ed790219a

## Test Regressions (compared to v6.1.107-72-gde2d512f4921)

## Metric Regressions (compared to v6.1.107-72-gde2d512f4921)

## Test Fixes (compared to v6.1.107-72-gde2d512f4921)

## Metric Fixes (compared to v6.1.107-72-gde2d512f4921)

## Test result summary
total: 190787, pass: 165221, fail: 2316, skip: 22988, xfail: 262

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 135 total, 135 passed, 0 failed
* arm64: 41 total, 41 passed, 0 failed
* i386: 28 total, 26 passed, 2 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 35 passed, 1 failed
* riscv: 7 total, 7 passed, 0 failed
* s390: 14 total, 14 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 33 total, 33 passed, 0 failed

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

