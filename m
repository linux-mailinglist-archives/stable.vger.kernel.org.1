Return-Path: <stable+bounces-200775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D19FDCB4F0A
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 07:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DA713006AAD
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 06:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99ED52BE04C;
	Thu, 11 Dec 2025 06:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XReTvQvg"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D166F28751F
	for <stable@vger.kernel.org>; Thu, 11 Dec 2025 06:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765436120; cv=none; b=Lq+2lEZhVnRqH/s+6ljkimrKPh/K2TMU0+K+Zqku/uTUJAXxNb8WRjQgOS3EBaTF2GtTi+r4ClXMI9UdULNMdMQkF1Vmj9y6EiR8lA10ha2Xk7Eza3177qQA7rTnELsP9Fel1WXSXNXbZ3TJ5Nh+mdFTYtK8cQY7RgVVUj2DkVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765436120; c=relaxed/simple;
	bh=zLi29bNPMscrpkND0dGBlbS2YU2Q/WBcwTz5UAK+Vuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HtsOhnR6yJ3CsP1I7VkiGW7ufPozZrzUkLLN6+EyiT/WEx/rruSSezFoctW7O8KF19m+t4nly4D9ipKYsAklWw/XMQKEYn10aZjFVq+F1a090hH+rC0QHlLED7ucAg4O1Or26Yv2vOmbJR3ebud4R8r8hL3QbhBiFG1Vi60sewg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XReTvQvg; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-bfe88eeaa65so431341a12.1
        for <stable@vger.kernel.org>; Wed, 10 Dec 2025 22:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765436118; x=1766040918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WRjgoNaFh1qvJHAkZNDs2Z3lEI+Ypa7L//zyHW7li88=;
        b=XReTvQvgh1liSNCoWBweQvJcAUJtGHaTZqmZXQPzGntgPXQy7lCIblZoTuhNaoPVP7
         NaNA41ZU8SOucMiqnpv4ufb+1KXNCVlsSksi51BQCTKmlpF+HjKEE2Qg2thBYAMh3Y1f
         1kLGXJIT8LLZf8Ap1w7qfSzdX9L0KTYUMP33OsK5AbW0mzl0J+oyGYqHldhOiOjxjVde
         qAAGv+Xkj7yF+aW2Vrk9vhgbk1Qq8bn9DISIyIaNUQAVswwTJFhlwftE3kUeupKnhdVL
         zSE2ZUvZkEsUO1fYyxUO6f4gf3UfZngu5haiVJqZ9SC++Al4M2S0Bn4gD+X4CngZRpLK
         hXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765436118; x=1766040918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WRjgoNaFh1qvJHAkZNDs2Z3lEI+Ypa7L//zyHW7li88=;
        b=TgNfpAjFurivvOB2mY2CnKMyDEHyOcS/ny1WSy+EWViCON6+/PUMl0WQFCm7oHJgjQ
         yQaoLPYyZtja5zQRxfO97xAyEI/+zjt+tTbeI4DkUY9aXEk/VWeB7Dago7EPY7tNeWmE
         REpZqcptE1+ey8lzV0G2SGKr6TLLp5rROxWXFh6txlJfQDrxnDgDRZfpzjqt9lZpPwv0
         rf2n7b9meSuJveIvdbU2BZIwb4fTs8AKNco8HqgpA4TvN4JyCNCZA56ZVOE5Kt5xqk6u
         QnArhZGCO/zo5h8miLLetHUu8jWipU+kRzNyoaEWZuhzAz9y6vnkPUrFUBa7OhCrBPY5
         kAVA==
X-Gm-Message-State: AOJu0Yw8MrbT+6jczX8cvSwLJKaxb2FsvOu98FNMD+1ZOnUVCTXE0Lur
	LBc45Bdt3TuRwadfJAvNpf4ObV1ccuAwgOZ0B25LaXVISKPQAln6eK4UpRKQBEqFzCtD85ZhSKE
	dK03MHYovV1I3LrQw8UTwsoFnl/S4JmFm0r6n8UyF+g==
X-Gm-Gg: AY/fxX7BxMDIGx4DNSwXFip3ZQPTicGDHTC+luTvkZQmqxUuA80lYaW85dQclF6z2W/
	KXZ4s+PUrgeAOJwLyls4vR+Pp0anZENN1memz8XaT6Om4dYQiqENm6oeYDhtpSPKLWkyHUr50Xy
	T+d5QEBJUJHQw1d12dFoPc4JhABKcQw9Kt7E9BzymrBKTtY7p4umFgDEpiJZLrATYo7HARGAdTo
	napO0m9xxQIO6MndMG2YZiVHn+XvmZ3MzDECvVI60105PUmm5Ewy63z6aTjej5zDGp8NuLZaxnz
	WVXZB4SM83cLLShJMIHVcNB+Zwvyhg==
X-Google-Smtp-Source: AGHT+IEK9lMZU75iBuRom2ZiQbpD8X35wlwGqwstNR/EfSk9pcL6vP7Kd8Q3/CfsM5+z3Hy3eX3dcxL47A50j3+nOTs=
X-Received: by 2002:a05:7301:fc02:b0:2a4:3594:72e8 with SMTP id
 5a478bee46e88-2ac055fe09amr3058131eec.23.1765436117675; Wed, 10 Dec 2025
 22:55:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210072948.125620687@linuxfoundation.org>
In-Reply-To: <20251210072948.125620687@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 11 Dec 2025 12:25:03 +0530
X-Gm-Features: AQt7F2rJVFMic4-AFitD_2jlPPFvgeLqMlEXw7fLa5w9eV_te60dn_zVUCuBXBk
Message-ID: <CA+G9fYs9fLHnhKvoJ3vuEMFqxA4mSuV_55BUEVPpdib70gY=OA@mail.gmail.com>
Subject: Re: [PATCH 6.12 00/49] 6.12.62-rc1 review
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

On Wed, 10 Dec 2025 at 13:01, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.62 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 12 Dec 2025 07:29:38 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.62-rc1.gz
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
* kernel: 6.12.62-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 4112049d7836ad4233321c3d2b6853db1627c49c
* git describe: v6.12.60-182-g4112049d7836
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12=
.60-182-g4112049d7836

## Test Regressions (compared to v6.12.60-133-g8402b87f21e8)

## Metric Regressions (compared to v6.12.60-133-g8402b87f21e8)

## Test Fixes (compared to v6.12.60-133-g8402b87f21e8)

## Metric Fixes (compared to v6.12.60-133-g8402b87f21e8)

## Test result summary
total: 106188, pass: 89612, fail: 3189, skip: 13145, xfail: 242

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 137 passed, 2 failed
* arm64: 57 total, 54 passed, 3 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 39 passed, 1 failed
* riscv: 25 total, 25 passed, 0 failed
* s390: 22 total, 21 passed, 1 failed
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

