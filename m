Return-Path: <stable+bounces-92906-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 023A39C6D71
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 12:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 870D21F247EF
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 11:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EEB1FEFDF;
	Wed, 13 Nov 2024 11:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ByvS2wbe"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C671F80AE
	for <stable@vger.kernel.org>; Wed, 13 Nov 2024 11:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731496210; cv=none; b=b3xCOILiwUsBHLwpha+cgirjGzo1fsueP86To7tYUxiQLFoxF1Z93Ww9jEXwKsV7z1DjYJcqQBydBGsZPL/8bsaNigeIOxnDOMzAYO5gxZy4ATVdalhQLvM3u5YK51g0xr2/uF/wze5TXVMyyjQYOAjwZx9A/n4WZKDfQy9T3ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731496210; c=relaxed/simple;
	bh=o7ZakQlIa2lYgRR3nNgwkZEcN6aiF+WrAxBCWIkUVWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WLVuH+e9jOP0KnetEQricDd0XyY+/6vmc37Q9tQgNScPRatxV/LIhtv8RcsCznpd+jWefZdbpRQL/GUffh2NSC6c77ERN0A44YUDltR7szuYrmZd+GJEkqDFrlJO97fQ5sXQdqpWtuHxz1DXXE98kAMQYI0b9PDwDf5kOu1pv6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ByvS2wbe; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-513d1a9552cso2795316e0c.1
        for <stable@vger.kernel.org>; Wed, 13 Nov 2024 03:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731496207; x=1732101007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLRHbq0yedycOi7moHqeorbuEFrpPo0av/ZRKrfN6MQ=;
        b=ByvS2wbenltC3anw9uvXRO9+tjHbHx/06f/xCdiRKNZfFREMqykYGwYvM3mw8ID67+
         YV1MAUP21tmucxs8hcwiBVpIKdzlv5+ivjiRw1PyVhjunc+JXWwxV4xPd4qZEh84J2D3
         VbHa5QN/X0vfGNv5RevmMMcXlxBj/fU6p6C7S0DmpBsMsekcUX2jUhwq8y3jczn5qMAR
         w7BwJlacRvbd3rD/CstlCx8rPNsBY+G0gbl9UVCdlQIlDIe8JT5zJ8JCEALTUwRowHkp
         DIryeRFOMBo3QR+UEoD4roALRxeYvRJkByUGwFLszpGeNKYErxTpV3jfKX70A2EHHl9M
         LnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731496207; x=1732101007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLRHbq0yedycOi7moHqeorbuEFrpPo0av/ZRKrfN6MQ=;
        b=eEq+gWcOh8eJ88o8DY75z+7b202PNR1H/eY1O102eC5+VRV1VQB023cEl2qGpmGBNo
         7O5YaGeNMKxPFEC3zfTj+R7ABaaeMYcWjE7wbxas0Hz+3yGRFVjy07I9MTILqjW/HnZQ
         QjlxndvDCZAoX7pLkSa+/x6nin2tQzaO841YIlw0ZphYq8CIVoUDxSNny3UjW62YQDcI
         MvnUoEn8DMLX76Iw83gzmixz7oDb4RrjzirO5faa4KuuXyvt2dQAUBZP8AQTx2WEaADs
         bNQZccUNK4RttM571Scf2J5xh3m10U5TEkUSgGyKS6Jl90SEHfCCQMX9osMaRFNdYR9s
         LH8A==
X-Gm-Message-State: AOJu0YxdclVT+Cha0AyPp10zNYP1UW+j+vAns47xYX/hYD1eOP4mqrDy
	MTv96pdgFgbY+++ZMHDjbt1oKGLP1eLN9pPuy89Yo3PfFWnY9zheLByC0yIwCl9jvmcddE4ANjZ
	FDKbNOh8fWl5VZQ7quV9QxKGz+mZN5p5ruCN5SQ==
X-Google-Smtp-Source: AGHT+IFYtql4PZnERxqsx1iVt7t5SNiqWamwYFmQtWq0EQx64r3jMppMGLMQpLIRJQlVFtUDuYAk+p5YKLimNZuqqvg=
X-Received: by 2002:a05:6122:181c:b0:4f6:b094:80aa with SMTP id
 71dfb90a1353d-51401e8d209mr20290230e0c.9.1731496206871; Wed, 13 Nov 2024
 03:10:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112101848.708153352@linuxfoundation.org>
In-Reply-To: <20241112101848.708153352@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 13 Nov 2024 16:39:55 +0530
Message-ID: <CA+G9fYuvsU3hfJd_3tDsv1HpB_hBPTpzcyGqJ1bRhUcwmhKMjw@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/119] 6.6.61-rc1 review
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

On Tue, 12 Nov 2024 at 16:03, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.61 release.
> There are 119 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 14 Nov 2024 10:18:19 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.61-rc1.gz
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
* kernel: 6.6.61-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: ba4164ffa865e6dc8d86c0605cdf762aae20e49b
* git describe: v6.6.60-120-gba4164ffa865
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.6=
0-120-gba4164ffa865

## Test Regressions (compared to v6.6.57-484-g2daffc45f637)

## Metric Regressions (compared to v6.6.57-484-g2daffc45f637)

## Test Fixes (compared to v6.6.57-484-g2daffc45f637)

## Metric Fixes (compared to v6.6.57-484-g2daffc45f637)

## Test result summary
total: 207451, pass: 172242, fail: 2343, skip: 32689, xfail: 177

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 257 total, 257 passed, 0 failed
* arm64: 81 total, 81 passed, 0 failed
* i386: 55 total, 51 passed, 4 failed
* mips: 52 total, 50 passed, 2 failed
* parisc: 8 total, 8 passed, 0 failed
* powerpc: 64 total, 62 passed, 2 failed
* riscv: 38 total, 38 passed, 0 failed
* s390: 28 total, 26 passed, 2 failed
* sh: 20 total, 20 passed, 0 failed
* sparc: 14 total, 14 passed, 0 failed
* x86_64: 65 total, 65 passed, 0 failed

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

