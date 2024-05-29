Return-Path: <stable+bounces-47612-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 824D68D2B70
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 05:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C23C286804
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 03:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431E015B126;
	Wed, 29 May 2024 03:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wyACmEhr"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6146F158A31
	for <stable@vger.kernel.org>; Wed, 29 May 2024 03:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716953301; cv=none; b=YKtkmhb83av7nrWXplKcrVA4vj249FnGwNhQ6rNGX9oW/UTh3R96hCY+mzb1CMCVO6Q7QxdRUotkRj5bO2GT2etTuQyvQCwLN7k2bQnGs9u7iWI7ql30UTXLoLteG1iGBboy41dXiQL7b6qzQqz4i7sFWhLR+y29kT9JfTiDIyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716953301; c=relaxed/simple;
	bh=wRt+TDfSYlFEo9QS6+j0hrFYKrhvxg8xfu70bcZErBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N788ifOgf3TRaiGX9fRtewyozMVdX4Y+XFqMcgm1XoumHzJ+JvcrzL0su7zBJu0ArHxG9wUldWE5foMkeCs7DQJ3X36nwxf9x2PKNABg0r8eABZYz4z+HtmBFpZMxQEYhHLTEZ46y7zT03s5t9peMzxUeoz3NIKq2RHBNIRaMlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wyACmEhr; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-8030f814a15so475041241.1
        for <stable@vger.kernel.org>; Tue, 28 May 2024 20:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716953298; x=1717558098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTGZhWYe+6C1xgVbBSIL7jdPle1wizKI4qRK3FbTxHg=;
        b=wyACmEhrSculZ8ECLzxFP5zfZ4OrqmjCce8cn9Y03HYGHgHu0ggEgL1qQHRsjGoahJ
         gzfBIKxODDxBHTXmrN3CKxVynsaYDbbhwHcIMpNvGH3a/hvPK39S6Tk4IPqnQ/3Z4q20
         X7v81CwXAIUCdDNHhV5DchHQNMTzd0ABo32/Jauk193IJdtrx+oTrm8p/kAz50eNrIW6
         qsGSKqv3+C1gvZ2ML2EEPPZgrqvqb1HoXde+bB5KyEhjZSf4ZIorcAVbafPGcuzY9LDn
         ZWAHDkkSxJoy9d04z2DyHM8eIflTk/LvnVKLI5nkM0Ls304ktXl/kQ85jclXY9yYCvbp
         gcwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716953298; x=1717558098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aTGZhWYe+6C1xgVbBSIL7jdPle1wizKI4qRK3FbTxHg=;
        b=IrxoWL/y02qblcJc2KrSLzdeY2PZ4hSFN7pkcexlZZjDJzLHo5XhXcWOJLjAk33NwG
         k0fhyV/8Ki3cPZSpsysQut5gKSIO2CAAG6h4oIJ2Dhp7Od3ve4/GBcql4xPwRILmb1AY
         v5l3Q0OSWwAjIxYte1xjdnB9roIK7GJKk0SXOezv40aR/HweZueB7zaZB7K6YJAdnLPA
         7KYCryJoKPl2g8/sOx1Ja/Sk6NnNio43v1jONlsJfPK3zCm6ykRouH3aaxm6GwNA9mCa
         dh8vqpt6u+NRYlqFa+w4ul948Ut+Aw3Wux7KNxSJD9A+jUjwZIu/QBWrv5adz3UnIOsB
         3quQ==
X-Gm-Message-State: AOJu0YwWMbGAQOHRGWzM0cYmpuK85jx9JvyXeqvAbSWQLZinllH+Ck1b
	P2VR31TxIy3ZLBhStjOl5Yqtt3pEYn02+t75/LHz+gv5WujWx/PUfCEwiuAVQTwXcdRr6RWvSpu
	HaM0i3XcBk+8Bmmz4oUUMXdBHQrJrB8oSyOWrFQ==
X-Google-Smtp-Source: AGHT+IHpoGFgIK6a88msVLi1jV2V44/8HkVwz9s/s+DVm/mINPSvG56jyyOZprGwQ43LYPMKYsw7FuSaczrzvnnBj9s=
X-Received: by 2002:a05:6102:22f6:b0:48b:9460:b5f5 with SMTP id
 ada2fe7eead31-48b9460b61emr3078771137.29.1716953298214; Tue, 28 May 2024
 20:28:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527185601.713589927@linuxfoundation.org>
In-Reply-To: <20240527185601.713589927@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 29 May 2024 08:58:06 +0530
Message-ID: <CA+G9fYsbuFey+yukQYqKwVK3tEcMebAKsoV-qNaFZX7aHLDrDA@mail.gmail.com>
Subject: Re: [PATCH 6.9 000/427] 6.9.3-rc1 review
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

On Tue, 28 May 2024 at 00:30, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.9.3 release.
> There are 427 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 29 May 2024 18:53:20 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.9.3-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.9.3-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.9.y
* git commit: c1009266618d24dff4fa4dd5f4086d4701b1fdf9
* git describe: v6.9.2-428-gc1009266618d
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.9.y/build/v6.9.2=
-428-gc1009266618d

## Test Regressions (compared to v6.9.2)

## Metric Regressions (compared to v6.9.2)

## Test Fixes (compared to v6.9.2)

## Metric Fixes (compared to v6.9.2)

## Test result summary
total: 194636, pass: 167011, fail: 3701, skip: 23924, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 129 passed, 0 failed
* arm64: 39 total, 39 passed, 0 failed
* i386: 29 total, 29 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 17 total, 17 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 34 total, 34 passed, 0 failed

## Test suites summary
* boot
* kselftest-android
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-drivers-dma-buf
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
* kselftest-ir
* kselftest-kcmp
* kselftest-kexec
* kselftest-kvm
* kselftest-lib
* kselftest-livepatch
* kselftest-membarrier
* kselftest-memfd
* kselftest-memory-hotplug
* kselftest-mincore
* kselftest-mm
* kselftest-mount
* kselftest-mqueue
* kselftest-net
* kselftest-net-forwarding
* kselftest-net-mptcp
* kselftest-netfilter
* kselftest-nsfs
* kselftest-openat2
* kselftest-pid_namespace
* kselftest-pidfd
* kselftest-proc
* kselftest-pstore
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-splice
* kselftest-static_keys
* kselftest-sync
* kselftest-sysctl
* kselftest-tc-testing
* kselftest-timens
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-user_events
* kselftest-vDSO
* kselftest-watchdog
* kselftest-x86
* kselftest-zram
* kunit
* kvm-unit-tests
* libgpiod
* libhugetlbfs
* log-parser-boot
* log-parser-test
* ltp-cap_bounds
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
* ltp-io
* ltp-ipc
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-securebits
* ltp-smoke
* ltp-smoketest
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

