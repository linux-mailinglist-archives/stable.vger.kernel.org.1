Return-Path: <stable+bounces-145806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F12ABF228
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 12:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F01A1BC32B4
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 10:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767A32620C1;
	Wed, 21 May 2025 10:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Au9vurJ5"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3932609D8
	for <stable@vger.kernel.org>; Wed, 21 May 2025 10:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747824756; cv=none; b=tOyUSuH/MPh8TkIpa5YnNo2CP8zo6F+2O630u5nRdGhOygFE/4h+Ho7VslUDB2FrYCFaHJ4S6L9m7l96FTcfMWOAYznrzqWZAb+TxAyc9M0Hwpl/WsQNz1HQU8+LJEs6waTzgjesbnp3FlEoQeUBrVlgFeY2jCtXc+rI5PF8DtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747824756; c=relaxed/simple;
	bh=4BFLWPUAMSInPQdAE9fgzFRSdzO/MJE0QCcVjoTiJko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D2w1DIX3+m40PUkSN3CbJzSQbE/mRxfUqthEopV2BMXDHIXBbptuom95ApPryevRNY08rRCFy8rlZ/0rq66DzWzWzoiHthJxq7KDY6M1hyqkVClFNiVF4WfkR5P9maubLy66ntSfFka0IdbK4S9InZFfYC2PQwnTokm6TXK/i60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Au9vurJ5; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5259327a93bso2134232e0c.2
        for <stable@vger.kernel.org>; Wed, 21 May 2025 03:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747824753; x=1748429553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZHVJ3+0s5VJ9SAEbzNjGpliuVaCZn6/g9D/MgHcJ80=;
        b=Au9vurJ5+bsLZI7KBAZ3jbQJVUwB3tFEs1zFiyFUyfWMitAFXtjU2JDZl4OgR2ogUh
         WWJyWmHfkB/dqcfrJ+fNkXOg+AZUcEzfCvv02W2NIGXHKT3RwcHbAyGJyuUzMpS5bY11
         iWEuNPOC5Rb2Dzhnv/xPraMMLeKNEln2BlHsKX80HGNSOEHcFVBHrJUiZ9q8k7Wvdnbe
         G6Mh/SIJ9PigKFajkbJhlKt9MaCtms2P43USHI9o94brNBaTxnfDKyvWk2phrP6CFJlK
         Vv+vf47AV+vL+cgbp7M9u/4gpyxkOW3qqx6GUVwUDcQCe4n46gD3zz5cxpzXTtzSQGH3
         Z/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747824753; x=1748429553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dZHVJ3+0s5VJ9SAEbzNjGpliuVaCZn6/g9D/MgHcJ80=;
        b=elWvD0b5jZ0YOu/5XvMUuA2kQqrsrHRwJssROB07YGk4++VZ0nYKkAr3ePAE0ILQMR
         xB5EDtHz8/Apb8CmviOfwFPwFCmXJU3ZvedieG69JH9ApNlqLuWOcGp+MqaD41nAZAxk
         eh7IEuo+EmVeag0/WO8Cjf3jI0tl52vZ3OpvSfShuqKSjfApDhI0g/xQvXZbklcaBK37
         xz5aZQdCT/TAbrQQrFlOqB4GO2wrkR0vqfJqd1q3n1TMR+HkWNXa5HtAGagjSEUzDn6P
         9goiZ+Ku/pMCF1tOmpvJl4aqccsqp1cpSHjmaN4SgnXj0TecKqLq+cQO/5xLP2b/TXAg
         M/sw==
X-Gm-Message-State: AOJu0Yzzbr1gyGmxtjUtUgDYYJwOVjpCEB5RlvIi6LTqSu34G93qjJ3T
	7HYC1SJ5Od6OoRwIzJ7+2OvXMXniIsEEbQN1Dmxn7TRC2tDJsU2PLtqjjz4AeBp6QfpJz2uuz/S
	ymehL+ObYtkhQxLquT9TUEDpmCDw1asp1IruUo+v2pg==
X-Gm-Gg: ASbGncuGmQP22AIjglYWvt/pdkwNxsmDV1/T0xXf8XgNkA3PcV6cL4A2CdyA9D+V81M
	GfoGiWWCzGNv3KGx3SBJFzZIs/epMpxSyhafk7SiWFfIkbr7cix+0VpV/+UdAU1Fi2sMzqKbp53
	7UKcbRVxbJwhAjXqxBs55FZ4vh7snpCtODs7vQHnDM8OnGzQT5SkjAM/mieZ5H5owLxA==
X-Google-Smtp-Source: AGHT+IGTpet3tvuo4dVQk5bLwsNjz4FVi9021yTbDrQQwYKO6Ii2Esq7EdmHZdrJDV4Fl+4399BvnJRaMflLdZbEFEg=
X-Received: by 2002:a05:6122:4317:b0:520:6773:e5bf with SMTP id
 71dfb90a1353d-52dba800001mr15970869e0c.1.1747824753137; Wed, 21 May 2025
 03:52:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520125803.981048184@linuxfoundation.org>
In-Reply-To: <20250520125803.981048184@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 21 May 2025 16:22:20 +0530
X-Gm-Features: AX0GCFu9JDvT9DPHZ1453In-RQsb-9FyVMa4i9tTQ2pJYOokOVyHxxYrKkbN7O8
Message-ID: <CA+G9fYvDbn66=pss5UeMtjU5rYTG27nr-s5EV3Z7U3TfxSkhWg@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/117] 6.6.92-rc1 review
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

On Tue, 20 May 2025 at 19:31, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.92 release.
> There are 117 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 22 May 2025 12:57:37 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.92-rc1.gz
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
* kernel: 6.6.92-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 18952a1fc4ac790deb4faa116f18310d7010a9fb
* git describe: v6.6.91-118-g18952a1fc4ac
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.9=
1-118-g18952a1fc4ac

## Test Regressions (compared to v6.6.90-114-g477cfead3566)

## Metric Regressions (compared to v6.6.90-114-g477cfead3566)

## Test Fixes (compared to v6.6.90-114-g477cfead3566)

## Metric Fixes (compared to v6.6.90-114-g477cfead3566)

## Test result summary
total: 236734, pass: 211762, fail: 5845, skip: 18530, xfail: 597

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 129 passed, 0 failed
* arm64: 44 total, 44 passed, 0 failed
* i386: 23 total, 20 passed, 3 failed
* mips: 26 total, 22 passed, 4 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 20 total, 20 passed, 0 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 37 total, 33 passed, 4 failed

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
* ltp-ipc
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

--
Linaro LKFT
https://lkft.linaro.org

