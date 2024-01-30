Return-Path: <stable+bounces-17414-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83334842670
	for <lists+stable@lfdr.de>; Tue, 30 Jan 2024 14:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5D6C1C26112
	for <lists+stable@lfdr.de>; Tue, 30 Jan 2024 13:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DB66D1C4;
	Tue, 30 Jan 2024 13:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q6T+k91V"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7699D6D1B3
	for <stable@vger.kernel.org>; Tue, 30 Jan 2024 13:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706622624; cv=none; b=Lq5KkkLpZpZ4aFyVdacni2r/pP2CwAqPPCWA5i0C4FRQoT8z/oRS1zH0t/qxMLCIMYBjnR4Oi4Ih6ia22FKcJi0alhRKMTxWjQ14bSrp+pWC6BInTiUapxOPcPdbUNZ/mwgU0HGHPGiCd8K9rTx4fUdK6Urme2HhPaezz3M+s4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706622624; c=relaxed/simple;
	bh=S8UoD6Ta1gehN3pZq3TClOoAdLVOWvyfsPQVhm3ikJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pnW/und5fBAd0JLW2RgwiYC8FyajI47f4V8NkbzZGZvgy6Z470ThAnTRG/lOoXniiFDXvdD5T4B82AgI3nwBpihhCDJMtbMSquwOvzLKxr9orj3yL5ws7d8rtV8bpdDz5qr5w1/TyLasmt4HUM0LUBmWreoHOkFGFqBzZ11Zzg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q6T+k91V; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7d2df857929so1723038241.3
        for <stable@vger.kernel.org>; Tue, 30 Jan 2024 05:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706622621; x=1707227421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqRuopth+NFROAnnx4PTjC3pCFiYr+Y26i/bHfvDIrs=;
        b=Q6T+k91VAeEB08zyE6TCdez6/gkHnxOiSH90SRvPFcS4QHsbEJ61wqX094VQAQl/n9
         XTq0Gqs4s0P6iWVc8dbGrT/II/wyAVf08SaE7P8b816KDdXlerYXuaM561rcNu9Q431B
         jU9pZwcxOqsDnLoIdMEG/rhgto/nK9Hu4RqKGjKjdN8Ox9Y8HWvx8aOPqAqh/IJgtb/R
         TOOAXKb6qcTmnJHDJVqK9IRcvqxsDI2KRfQkEyXQDnES2xAk/gzyuC10ecmZbihrAtBe
         K6EjKXZ2Jr8i8U8fUMMvcZZEJoAYt1BaBnDna0evY912/K3YAxcgWXYjZ6uB2G0/ivTK
         ZsTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706622621; x=1707227421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oqRuopth+NFROAnnx4PTjC3pCFiYr+Y26i/bHfvDIrs=;
        b=L0ElVfOUWUTG9uBDkEqLUsMWWfOYZcZEfgNaMzVS3dP6S9pV75TN7Sm19Ve9FY1ZSA
         0yUNOZU/f3Ou2iuUTl+L4paqzEkFWeZKnw7z4iEA1CuaalTOVlrWem8npx+9gfXCW1yM
         sv2SH7E00CB3DpNYmCeJCjMC5n5umMbWikrlegGApafATGxQM02T/2BKEFBSQQ84AVFN
         bhNJT6on3jAj2KiGENzx2chdwSu/Agh7BpBrKWfQt49T6eXZAlqxoUnWdbbfPuX1C03R
         01IOLsHrqIusGuAZ5FZjh1O8G7431zd5Pz9cB8Gu4FJlzrQGSENiHipIdqo08YkYC5Mw
         whgQ==
X-Gm-Message-State: AOJu0YxeVfRKgxtBDryj9zOOO8omhowBJduJNruJzSQcVJuNHnilIzD/
	gDEU7xPyWNs5mZkAM5yVNw3Z9B+U3YFipKIKA0Xh2OX4raG+A2hswXt4Dlxo4EL9kMUaYDl6GGB
	6r0wp7Nq6h/AXNzbWtXT8vSPZ3yGi0cYokErSiA==
X-Google-Smtp-Source: AGHT+IE2NzLxDFSGj5n1fVpRkjkZIulZhy16OZlANragEXfj90Y18vilUxLyU4CKO4r4rgr1zbWvnLR3XGyNXMLS7hc=
X-Received: by 2002:a05:6102:1242:b0:469:a69e:70c4 with SMTP id
 p2-20020a056102124200b00469a69e70c4mr3590245vsg.37.1706622621209; Tue, 30 Jan
 2024 05:50:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129170016.356158639@linuxfoundation.org>
In-Reply-To: <20240129170016.356158639@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 30 Jan 2024 19:20:09 +0530
Message-ID: <CA+G9fYsT0kWty=aRATVCT1KzMBmbo0_LidV2=b7U+6f+=Sbd6A@mail.gmail.com>
Subject: Re: [PATCH 6.7 000/346] 6.7.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 29 Jan 2024 at 22:37, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.7.3 release.
> There are 346 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 31 Jan 2024 16:59:28 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.7.3-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.7.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.7.3-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.7.y
* git commit: 7c05c677b6ca67bd17cb1606e63c1962e0c2e2a2
* git describe: v6.7.2-347-g7c05c677b6ca
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.7.y/build/v6.7.2=
-347-g7c05c677b6ca

## Test Regressions (compared to v6.7.1-639-g2320541f64ba)

## Metric Regressions (compared to v6.7.1-639-g2320541f64ba)

## Test Fixes (compared to v6.7.1-639-g2320541f64ba)

## Metric Fixes (compared to v6.7.1-639-g2320541f64ba)

## Test result summary
total: 142243, pass: 124118, fail: 1075, skip: 16831, xfail: 219

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 145 total, 143 passed, 2 failed
* arm64: 52 total, 50 passed, 2 failed
* i386: 41 total, 38 passed, 3 failed
* mips: 26 total, 26 passed, 0 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 36 passed, 0 failed
* riscv: 25 total, 24 passed, 1 failed
* s390: 13 total, 13 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 46 total, 45 passed, 1 failed

## Test suites summary
* boot
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-exec
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-kcmp
* kselftest-membarrier
* kselftest-mincore
* kselftest-mqueue
* kselftest-net
* kselftest-net-mptcp
* kselftest-openat2
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-sigaltstack
* kselftest-size
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
* ltp-fsx
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
* ltp-syscalls
* ltp-tracing
* network-basic-tests
* perf
* rcutorture
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org

