Return-Path: <stable+bounces-151875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CBAAD1148
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 08:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 832B07A4B0E
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 06:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEA21F4CB7;
	Sun,  8 Jun 2025 06:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CjHEg+My"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1019A55
	for <stable@vger.kernel.org>; Sun,  8 Jun 2025 06:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749364887; cv=none; b=Co/ecgFqOZZDS656BL4eQs2WncBv9lRZorkR82CZOHwbKknUCDXETp7SXCq+AzzTjWm89PKI4FqKFbSfop30Pxo8g6mbOd/FIkITFBZOTu3n1tubmCsEcGsM5D8neJaCqaxezxyAPVpflhb82tAJdgFEr5e7tExVuWrgNO2I2S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749364887; c=relaxed/simple;
	bh=cXHevK/ajj4mr4JnqEVggiQfI4w+UzwLggNOaT079ds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cpw9tNqRjSzP1DUbjGuVCwJw+j+/oSH2gNfGjw10C6omBbkki8SovsROTLz10l2kW3vOPXbqZi9J7KfwWcBLFr64DdZx6JKIL6gva5asYxZazKYagoTzpYOIIGQLxS3ydDw9v2l3yUVIKBoRq8znPDBz7xtNEFk7ccO8Ck/YZFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CjHEg+My; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4e5adc977ecso1038541137.3
        for <stable@vger.kernel.org>; Sat, 07 Jun 2025 23:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749364884; x=1749969684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OWp66g6XnahKQ1kFtBfhoQLOuAaU5itfCC1skHGxrWg=;
        b=CjHEg+MyhBPlKdI02jbiL7OPnRWeTRGlwlfPI5v7L0eKxAC0UWRWsD/c/7hvukXxl9
         JvcbyChtwVJ0uk2CSFlprxqX2aljrgAcQm47lxZnUg0FCFOUDS0DWAVKKgqLBYHPQlWO
         JcuUyM9OjoPb2E/nxxltEf/3B4GHdTp72Z2ifHGxzoMwCAev5fvLzmhE4VD7RfcS11n4
         ejmLx3RIflbwRl8319YkEuad1GWhiT2ii+4D4uPf34UG43YyLnmot7p1ZFd4S+k8UxOz
         Ptv5Mk4vO5huEO1KnIhMXfOEUIgHoABmvG9dpAlT4PFZ0Qg3ofYZtgmgOyJ8HqvIhfXY
         UTwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749364884; x=1749969684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OWp66g6XnahKQ1kFtBfhoQLOuAaU5itfCC1skHGxrWg=;
        b=aFzD/YA0s/asJyBgxOgAkjR6Wv02MLTEI4/8GtUAEDHd6HdjoIZ/0W7NbszthUZovD
         K+AB0Sui2RXCR5BYMaEeCAH3eyoAXWuhejCa/5kE/buGFtQb0cn/3CoEKQjNFHnPx0Ln
         2V4gpGH4+QAxOh9uF9/xAwJZuVRg2PNZmS8KPV8RkPO+735gL5s+gWDmu2eumAY/3RZp
         +A1KAeDMHfS5o5c/Slj5Uw6DXydsufKZwsY4mo9IPkzWg7M2eEhF6RsEF0uBT4XJi9ub
         /5eJkak+ihJQLmiKlRSRyloMz6lW0GxDaJ0mmBs9K60CnyUdOAgj1Kd13+pJ+YRph/sg
         2Ubg==
X-Gm-Message-State: AOJu0Yx8LGC2GJKb2Yf81mhWOXEj0tYviJ/nAdDr3iJcWXRJFSr7QH4J
	uW1D2uW4nWQuaQTCslz6PXyVG9jI2wtn2v4wimf6FJyMiWHvNMrALMOI/dDV6ZDd7U/hJarWIQg
	qgLjXSL4WMZQEq9rImjEeUfrSpoDn3hdXEza7RU0u1g==
X-Gm-Gg: ASbGncuWNZTbYAvtcbg8JJvVSEngbeJqQMsd5uTuKJV1RPqW1W2E2ApJsRj5itZ5aDo
	luZF+DdgQ1Nxv2B2oDRfMEOIdR7AkQom9XjUtpiQMt6IvVd13Zq5pexpwTmudJpoa/+iUnehcSy
	QRyZsd17h9mX5S49v1GEct1et9I5qoVlHs/sj1svwTYSZTqWsE4rxlmm6cz9M9ocs7dA==
X-Google-Smtp-Source: AGHT+IFOKDB/terG23eiO55r5zzzHyXTp9etD1qhfgoM4E3JRZzcfdv2fw7BXZF0LrrfUQXe0aHjYIKVWPr5xmSUpk0=
X-Received: by 2002:a05:6122:800b:10b0:52c:44a6:4801 with SMTP id
 71dfb90a1353d-530e45c3597mr4823131e0c.0.1749364883827; Sat, 07 Jun 2025
 23:41:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250607100717.910797456@linuxfoundation.org>
In-Reply-To: <20250607100717.910797456@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sun, 8 Jun 2025 12:11:12 +0530
X-Gm-Features: AX0GCFtNto2E0xHBg-g3bevE9-6Wg9W4bXyud4ke-3IqAefNOa9zs31uP7gGpBo
Message-ID: <CA+G9fYuw=+hcXhK4WBWxkMckk+u6hD_3Cnv-N1J63+hs=SXFhQ@mail.gmail.com>
Subject: Re: [PATCH 6.12 00/24] 6.12.33-rc1 review
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

On Sat, 7 Jun 2025 at 15:38, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.33 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 09 Jun 2025 10:07:05 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.33-rc1.gz
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
* kernel: 6.12.33-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 6fa41e6c65f72599c662db2b1e70f04205b38eb0
* git describe: v6.12.32-25-g6fa41e6c65f7
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12=
.32-25-g6fa41e6c65f7

## Test Regressions (compared to v6.12.31-56-gce2ebbe0294c)

## Metric Regressions (compared to v6.12.31-56-gce2ebbe0294c)

## Test Fixes (compared to v6.12.31-56-gce2ebbe0294c)

## Metric Fixes (compared to v6.12.31-56-gce2ebbe0294c)

## Test result summary
total: 250901, pass: 229133, fail: 4639, skip: 16564, xfail: 565

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 137 passed, 2 failed
* arm64: 57 total, 56 passed, 1 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 40 passed, 0 failed
* riscv: 25 total, 23 passed, 2 failed
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

