Return-Path: <stable+bounces-6479-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 346D680F401
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 18:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65CC81C20C67
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 17:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48CB7B3BE;
	Tue, 12 Dec 2023 17:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CZnaI6sl"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2D9B7
	for <stable@vger.kernel.org>; Tue, 12 Dec 2023 09:05:55 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-7cb029c41e4so512592241.1
        for <stable@vger.kernel.org>; Tue, 12 Dec 2023 09:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702400754; x=1703005554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rVUABKJnbmOSs8hzbW3BwjC3WNYniAwiEC94aShqVUk=;
        b=CZnaI6slCuXnb2KTTY/SWvjFaxTC0xv223Kx1le0zaNLuoXamiOjo4+bsrzsHMnGqP
         LX4J9H8g5iDjqwEnRyV+yX/t3xAq8fAkbKtbD+TFlEYhLQxVjQcvZw6g7SNBPYWT+1aJ
         BpzBz5lr9m4qYQb7HKhI1YyzW1ycgwRkwQWug4BvAHl3ru/dW+0vW1ndf06tJyA3UBp6
         gGkP8MA8Yn05dpsP+VXY0S8e2YcTtRfTCBLy7BC70LxStFC7/1cMrvD54xsdtxi5cV8h
         fluc6u6qSNVdHBox7MqVM5SB1m8txEwK5x3dchlcAZ0S894DHmf5C42oPxxsFE6R/e0V
         yGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702400754; x=1703005554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rVUABKJnbmOSs8hzbW3BwjC3WNYniAwiEC94aShqVUk=;
        b=bnwB8lzhz6h7XbvINr1QCbEucQ2TlLV0tCMsiJpcjQRsj7F7+JS9Odnn61nu90MhNs
         UsBXGAVkMLaryQTg3vhtVu9Pa01Lq6U1qKCx95/I/q5PiupOBwzYhIAcmQnJKDwRxOPD
         wTpLbQKlF6WBA3TFomL4ZFPMY8HXCCnm8uTqY1XG7UJ/QZWRcIV1Eh0Jy/jQD3vOTQzN
         JewSPGm5XXrwjA6breibxvf1fb6sgtTtX79erKjKbFjMhcsuyB1+oLyqHK80XBleR1rH
         2IyB5d8lyeBwFDbZTJRteIvymFeBw91HxoZLfhaMMZS9teGIuSRsqFPhFKxYcsp/gp8E
         OLIg==
X-Gm-Message-State: AOJu0YzwufGBNMStA0/kCnfLG83LTsBsoxyOggfj8wBQwuHUhPMoPHlI
	MK3DYmayVwgD3ZoQcMWJKoRpI65CJD6qg24Ky3Hbpg==
X-Google-Smtp-Source: AGHT+IHBiISUg2Y9QZHx1rbNNItehJ/pakkybBK8JWivD6+77n9KarFXRbQMUh2xUKcZj4lfQ2bVW9V5z5Z4ODd0vBY=
X-Received: by 2002:a1f:f84d:0:b0:4b2:c554:ef02 with SMTP id
 w74-20020a1ff84d000000b004b2c554ef02mr4148071vkh.20.1702400753818; Tue, 12
 Dec 2023 09:05:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211182015.049134368@linuxfoundation.org>
In-Reply-To: <20231211182015.049134368@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 12 Dec 2023 22:35:42 +0530
Message-ID: <CA+G9fYs4OTxPPA7oQxHfF-NWvHEVYX_62yhTwwG3A2b5ZLKCWA@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/67] 5.4.264-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 12 Dec 2023 at 00:12, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.264 release.
> There are 67 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 13 Dec 2023 18:19:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.264-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.4.264-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.4.y
* git commit: 852f04d9850582c3df740ac6f1d1c507cedd9134
* git describe: v5.4.263-68-g852f04d98505
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.2=
63-68-g852f04d98505

## Test Regressions (compared to v5.4.263)

## Metric Regressions (compared to v5.4.263)

## Test Fixes (compared to v5.4.263)

## Metric Fixes (compared to v5.4.263)

## Test result summary
total: 91574, pass: 72218, fail: 2103, skip: 17206, xfail: 47

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 145 total, 145 passed, 0 failed
* arm64: 47 total, 45 passed, 2 failed
* i386: 30 total, 24 passed, 6 failed
* mips: 27 total, 27 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 32 total, 32 passed, 0 failed
* riscv: 15 total, 15 passed, 0 failed
* s390: 8 total, 8 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 41 total, 41 passed, 0 failed

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
* kselftest-lib
* kselftest-membarrier
* kselftest-memfd
* kselftest-memory-hotplug
* kselftest-mincore
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
* kselftest-sigaltstack
* kselftest-size
* kselftest-tc-testing
* kselftest-timens
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-user_events
* kselftest-vDSO
* kselftest-vm
* kselftest-x86
* kselftest-zram
* kunit
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
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

