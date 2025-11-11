Return-Path: <stable+bounces-194512-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6E9C4F330
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 18:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0D403BC0EA
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 17:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83248377EA4;
	Tue, 11 Nov 2025 17:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OIPhjcpu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913243559ED
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 17:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762881074; cv=none; b=XsXvyqfO925LOWXGXtankcgPiihjnWj5ehUTgccOTcNifEMOoTmzTPQ3ZoS/pmX+aQM47+KqSzLfkIhoo0KE2Y15l6C/28k9t4vd+mXVo5jNw0UKCohrJfAFpKkYJcTT7D/zXIdZf+GV76CwWXm/b+g8B2I6QQVeQfZ0z1ujFs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762881074; c=relaxed/simple;
	bh=M5SWC/ZzGICrpsGy0ws7WBFefwMyTwIJqGaOFlz3nW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ogjap+MphcgDopoCWFATPBeSpbWMn+01kujBVtAuwIeYsJ1n1XPTwWSWUPD9jkCXExcD+8BE5ep1OcqA02r5Pj36erbvc/Cbgu2MnMo315udOH/X4FWjXdaAXbK1zf9/Dn1e4Mwot7v8gpqoeQRoX/OMle/Vpjtriy9UlWeZgJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OIPhjcpu; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b8c0c0cdd61so3619370a12.2
        for <stable@vger.kernel.org>; Tue, 11 Nov 2025 09:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762881072; x=1763485872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYA3N5+LW84uc3fFIjJhQ2RE7h8FnuvgCOqxZQpkq8Q=;
        b=OIPhjcpu5I2CcMnTNd1CfxLLrDO1YTNOqRUD1G5B+wcemg9HTMLdWiG8jAMLCgdNmS
         QxZD0LyATudpRceb5urcMhhsjnQe5/a7C7YdN194QaveBaRqbHuPX0NXc+gO4PUU08Z4
         1gpdZG+Z6lNZRZOcXEjNZetmCXBvz8DROE2MG4bzXvd1U7yRWeSKCsnpdaVrd2OsTRYC
         Zp0BEGF/XWVmHQ+2Ij1oBkf6fPLvnzTFcW55Dpo5EOZDsgYz51OY5sUucdv4BCbhUsCz
         twoEqfYkuTFBFlhrzLBkvPGWCbZg0RYdjobF85Zhy1OSy6wuAjlpjn2BTMswrX2x17ZV
         OM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762881072; x=1763485872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HYA3N5+LW84uc3fFIjJhQ2RE7h8FnuvgCOqxZQpkq8Q=;
        b=XxjJhjIj7L0bxAckiK1FoyrbONRplbfiq8+EHf4a9PDjCEm/EwLQd5s8siWAqzhGTj
         CqOQwvSrsvbUppddl3M09iX+PSyMMOTpkNU4iuyastvJf+CT2QVhLUFjygRjtrchnPWx
         WVv/2O3v/hTyOqsh2ikIimYyws5GaAFTEmyazKOFi+//jWN9XaQAEOa6p5CWZbJJUPxd
         B2JmgYgkWnFRHVvf0YynMINoog9LRHxhHDbQ8hRFYtgTIT5aIhe/PiuL6wS1KmV43txc
         cHmlah7VX/suJeRYO6SKufigJU5pvvj+SzhCLP1XJ9BJxo0wE12t9FPowt0Sgc4L1hUw
         N4RA==
X-Gm-Message-State: AOJu0YwJtuSO0IbxqyKInLGjd0eqEF/90KCu50ArJuyoyYrySVEgB3v4
	IDz6hMJsOK5iyT6uyXvJF673NwaHAaEEEtvXgyS0Lej8ybuthhdwo+B0ahO2nWyN9oi8XEewjzW
	RADhgGIpNRVjKNc0a4e8q9sEyVEmLW9IZrjg7blzQnA==
X-Gm-Gg: ASbGncv5qCnoiGj4A5xf+yekMjbb0q96Gjpn7YbIWq4whhKDjJP5rearnlCMMyCGWXp
	BggxcOUIF6+6MVIwTc+7Q0twJtgs/CZ+/wPq3LG4F31pAqMfL95K3PKFUlRRS2x23nH46MTC18M
	vDRaduOHP3u2FQs1nzndp1Y302XaZ3Tz5ljbVGDUpqmVmA0x81SU0vWlLWDcmqu65Pw4hVi+WxD
	9Sq9BOTZmi5UrcAvzbryPGbfdnRtm6QnNMjcax+y1aSHtefTqJcra3HwyiFCtdZPrR7sf+AzVfs
	poQC4kt5TBK63VMttIoX9yW2Spw=
X-Google-Smtp-Source: AGHT+IFlLhpBIxkK/o5HRow5nDOpJpBNkdHxuJq3gOmppeUMKLKNf0PyrtnYTUc2Qk9tZv4yl9D247eFzCIGZIv2wMs=
X-Received: by 2002:a17:902:ccd1:b0:295:7806:1d7b with SMTP id
 d9443c01a7336-2984eddee65mr509315ad.45.1762881071929; Tue, 11 Nov 2025
 09:11:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111012348.571643096@linuxfoundation.org>
In-Reply-To: <20251111012348.571643096@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 11 Nov 2025 22:40:59 +0530
X-Gm-Features: AWmQ_bkPy11x6qA98zrHbB-fFmThJx0VvL4EnyNUU17Y_7By7h5jvu5tlHvRR1U
Message-ID: <CA+G9fYs=TLsf6ttjcNep6FSibccva++QJG_FCJsRt+5i7Dxpyw@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/562] 6.12.58-rc2 review
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

On Tue, 11 Nov 2025 at 06:55, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.58 release.
> There are 562 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 13 Nov 2025 01:22:51 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.58-rc2.gz
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
* kernel: 6.12.58-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: e6b517276bf625e5d0a1f6eec0ed960bd99ec0d9
* git describe: v6.12.56-605-ge6b517276bf6
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12=
.56-605-ge6b517276bf6

## Test Regressions (compared to v6.12.56-41-gc3010c2f692b)

## Metric Regressions (compared to v6.12.56-41-gc3010c2f692b)

## Test Fixes (compared to v6.12.56-41-gc3010c2f692b)

## Metric Fixes (compared to v6.12.56-41-gc3010c2f692b)

## Test result summary
total: 120229, pass: 101980, fail: 3716, skip: 14186, xfail: 347

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 137 passed, 2 failed
* arm64: 57 total, 51 passed, 6 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 39 passed, 1 failed
* riscv: 25 total, 24 passed, 1 failed
* s390: 22 total, 21 passed, 1 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 49 total, 46 passed, 3 failed

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

