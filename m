Return-Path: <stable+bounces-78174-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FD4988F53
	for <lists+stable@lfdr.de>; Sat, 28 Sep 2024 15:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 584461C20C4E
	for <lists+stable@lfdr.de>; Sat, 28 Sep 2024 13:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F242187FF1;
	Sat, 28 Sep 2024 13:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DEWPMNs3"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AD4187876
	for <stable@vger.kernel.org>; Sat, 28 Sep 2024 13:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727528878; cv=none; b=LXfHWuxijvjKZdq2g080oEBnS/PdWBA1tOC6sQnnfpx5DkbQsfQuRPXcwPNjlQDgIyp3iMNwzDjGen4qqdeFAyKJlsc+gXe1orBCIS5kJyGjygNvGX8RL4vJ6yfJ5lTzNCEWogfOieGjxvtejA8N3V9TvOYSkCewQ6+QxF0NDZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727528878; c=relaxed/simple;
	bh=NF0Z16Sr+zxpBPzPl9FRHxZtteQuFZvwfQ5o4ap1K20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OGu+tG5jMJwJwcQ9WP2OA+H6opxhbcsAH9YOmA2eS+7C4hgO/jzBBrBDuIcZBeYrl9ShriSMNMAuWXyz3xhNrfzmJvMczfO9QDjEhRzfsJ92q8BIFRYHEBljbJZBzjotVLN+xb+RxpJUyNYgbSmazXsIb6AGLRfiUaP3AkYwvGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DEWPMNs3; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5011af337d4so768244e0c.2
        for <stable@vger.kernel.org>; Sat, 28 Sep 2024 06:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727528875; x=1728133675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+p8ve9O0X2u3XZpQMEXjYXFloRPDslr669RcjkIfYiY=;
        b=DEWPMNs3HLqscKWiMjfry8THAtVHGw8oNnpZnFJ5NpkofUyPe5Wwn8pDmgZM3TpORT
         FZkkhaK6ObJOSRcMPIRQni8PF+HrON/G1v4VNRB2ifhiOuVCBnwuqqbQjBLZxJfmCcsr
         vbnrpeX/hYAHmkaki9wag4hGInP5JilD5dA5ikY2tHzaWPCpCMXc4iWnPqwGFoCIg91a
         e+eqUAbBx+R1TSo4NAqv5a7d3c4Ze9F6Ki3XqKITMM8UTm2ICH3qp0tdwc5gVNHhHALO
         dgqUkxPM4p9J0xJHwAHAyAD/VyAth6zWFizOuaElPj9x4Q6YwlG80EHv3H+92ze4n0/Y
         dDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727528875; x=1728133675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+p8ve9O0X2u3XZpQMEXjYXFloRPDslr669RcjkIfYiY=;
        b=W0DGCJ7ClDch0hx/hYWneBDurtXnHvgL65OCaKWIL1m41P+ol5ecb6j2vhJlGkFdD4
         EYzpTFqeC7VJf2c9aH9xdjk75wMut4JjeiLpRzltn64/a268CX0aboVKvTeAJgK8hi3m
         UG8G7Ta5u9hlhvy0ANTh7lnirygyPtMx6uH2WCMWe+X/w7ilMMLJAaoSX5Fwc1bmc3L3
         uFGLN4aFgqGRfROLm7kNMUNih3c54rBU0dQaQQRiTRT2XXQ6eIEBGkAAzaOr5sauOkC2
         2v6i4vBCzrwBurkbRrG2KivZB1Zs9u9VMYrg4z+xfxWSFujToNZYxTRQYeUXps8NIiXa
         YJiA==
X-Gm-Message-State: AOJu0YxxekxX3jyX00NV/d0xJMcKbFKiwTpsQ7iMpkbSy2E77khFa7IV
	pyyWi9f4+35fsUxGB1ttDdNr1YLsCgrcR37xyGmpD+8UByNLxQ3klCvI+rcVa/+iYT5woEXWWPa
	HBVEbOa5M8oGzjijIWx47fJjRZaT3LDVUGGtig/5WswyD9Sm2iNk=
X-Google-Smtp-Source: AGHT+IHdUyjpLmb12iBp0x3k2LddQ3GVji+hY/nYqPlkPljo9avsX1iDl2Nt7RuhUa/sUTGdu2VYf0PrKcOldQGS4iY=
X-Received: by 2002:a05:6122:1d4e:b0:501:af0:565a with SMTP id
 71dfb90a1353d-507816aef43mr3873023e0c.2.1727528875123; Sat, 28 Sep 2024
 06:07:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927121719.714627278@linuxfoundation.org>
In-Reply-To: <20240927121719.714627278@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 28 Sep 2024 18:37:43 +0530
Message-ID: <CA+G9fYv5yR4TQV-H9O=YZS-bCkHkXqOfQ9qut3U2hCiH+ni1Eg@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/54] 6.6.53-rc1 review
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

On Fri, 27 Sept 2024 at 17:54, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.53 release.
> There are 54 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 29 Sep 2024 12:17:00 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.53-rc1.gz
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
* kernel: 6.6.53-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 3ecfbb62e37adaf95813d2e47d300dc943abbdc6
* git describe: v6.6.51-145-g3ecfbb62e37a
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.5=
1-145-g3ecfbb62e37a

## Test Regressions (compared to v6.6.51-92-gfd49ddc1e5f8)

## Metric Regressions (compared to v6.6.51-92-gfd49ddc1e5f8)

## Test Fixes (compared to v6.6.51-92-gfd49ddc1e5f8)

## Metric Fixes (compared to v6.6.51-92-gfd49ddc1e5f8)

## Test result summary
total: 173914, pass: 152411, fail: 1575, skip: 19725, xfail: 203

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 129 passed, 0 failed
* arm64: 41 total, 41 passed, 0 failed
* i386: 28 total, 26 passed, 2 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 35 passed, 1 failed
* riscv: 10 total, 10 passed, 0 failed
* s390: 14 total, 13 passed, 1 failed
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

