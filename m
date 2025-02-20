Return-Path: <stable+bounces-118420-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 835C6A3D8E8
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 12:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ED6A16B3F8
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 11:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1F91F2B82;
	Thu, 20 Feb 2025 11:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JPu99uq4"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FC71F1908
	for <stable@vger.kernel.org>; Thu, 20 Feb 2025 11:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740051448; cv=none; b=Mun3A0XWQ9zpH7Suw8oMyRDyetHE1iUAK1i7vRl5bF5CLycJnKACkIdQupTVwyBk4oBayKXXFQ2S1SpGOAf8DFDNP957sa4eBJPdoGEXhS52Uum7wUO82b1XALTwUUEHAIhT/3O1rHGkKJXgomb/QCG7MAwpX/uUs9zYT0JaIpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740051448; c=relaxed/simple;
	bh=88G0YOIoPPOL/EjQy1wtDWVST89b/CpWuK/PGMVcl54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aLbFrEKMIR852glngsboLLkKOnvu25F+YHHzW2H8za17IRH/E38agiNKs152EuEZ8cZ+6u43Yipu+Ay61uV+O8hvgw+LT9PtWZ5UCQipUHO8Fd7RI48yMPoyf830Jy/xqblz6NU2VuyvZFOxyngglNH3NsszZ5y2S7I8qyvchOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JPu99uq4; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-51eb1823a8eso236685e0c.3
        for <stable@vger.kernel.org>; Thu, 20 Feb 2025 03:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740051445; x=1740656245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IuzVq9OkutvCNEzS5JGhlxT8oPc0+NNNyZEuizMTif8=;
        b=JPu99uq4joWinTrzx9qtuLlX2QJsyJVIrn5YDfMne7gvtINGm3hbST6WGvMRsijYy4
         aD7m14WQ7GJ6ZlOXM+7S/EXBLJtgOpM1VKn8O2uOR0fyF+245HnlyswNEGWw84UK1o9l
         VRUfq08FG4tDyaXs+Nbl187RCEDWub2EBMqxjY8Gm3966xP3STFG3I46RPsBt974KvYf
         8C01XM/JXZqoQcl2rQc6CVMoAIwqcTjp/8j0PJIXfRf18Gl9DeTWf5pN7eCc3ftSBnYP
         hGsi+6Bh1dSLShqhv2XXHoDuu5y+09PwulSPD8h73LeD9H/08v1Qq2nBhyuO2GIr15xB
         2xug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740051445; x=1740656245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IuzVq9OkutvCNEzS5JGhlxT8oPc0+NNNyZEuizMTif8=;
        b=faRFGl3RxPAiIcDNv3kcw+ZyirPhmRhOBuPOcLivmod/PToKhyZr+UgIoTlxLBhWQe
         rbpTPI69Wd+y/SAQUuWyAZQ/GtAsSZn8NehGmTzJF5bZLAvhgB9YrOCFauTo+FcohQ3k
         EwNBgnsUVvjL+CEFen4JHTmjAwHFcfNCnDmuX/BnsvRgKgbSpEGfQdKMHakNytlDOPLO
         D071Pp7O+Jitnyt3S/mQrn8Yt45Rbzaoa3pQwADZOpZ35YzV7wbtE7qakpbe/er1XXI3
         kfhkLjQcLpfR37ezpBlTvt/ZqqJX4aHXHCOc1N0qiZLEdHH9CPz/QC6qZjKNg/HDm5xs
         uOSw==
X-Gm-Message-State: AOJu0YwKPfgagUlsSeZa+XjdrIZzKfZpkwzwYwSeM0mK9vWBAVzS02vs
	/XrFnthl/spAh84f+HZBUKPal91nsMHz9QQqgdTCs5kpwTWWoStFEDcXyMjF59oaMqgCtShEBY3
	6qLBRVJgg8GOUt3uwXPAV0oF1TkkxOkh6TVYUhw==
X-Gm-Gg: ASbGnctz+zZtyg4YAj0kTy11+qkY+dCMuBJ8Q7Dw5yhgAZEceqRAEtzIcEd1PqzVZ0p
	wO5x1V8wx4VJaoUmcMhGqzf3GdgrwJgUyiagv7B99BX7MZ1iZ2jE1OnTbdH2bY0pI3raGYz4OjD
	4ub3Oe1imoLT/etl7l2r6e2QCFysSq
X-Google-Smtp-Source: AGHT+IHzJnQ8UdPjYSfM/OBiu2LSuTlvIs57FBk1cINHCNnyxHhaqri2pojhFlOAyHI/OO7q6pneJlQKoZbBkFzte7w=
X-Received: by 2002:a05:6122:506:b0:50a:c70b:9453 with SMTP id
 71dfb90a1353d-5209de6718cmr9371127e0c.10.1740051445536; Thu, 20 Feb 2025
 03:37:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219082550.014812078@linuxfoundation.org>
In-Reply-To: <20250219082550.014812078@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 20 Feb 2025 17:07:14 +0530
X-Gm-Features: AWEUYZnQO4inOznO9_79aYbIKplawCDHNLm1B1JD3EKc_OH-xNl-HvFQIbOwsf8
Message-ID: <CA+G9fYv7WoDA1OC9VtQ6qAqwoaJA5+mpWMahE+7j+vwp1dTS6g@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/152] 6.6.79-rc1 review
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

On Wed, 19 Feb 2025 at 14:28, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.79 release.
> There are 152 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 21 Feb 2025 08:25:11 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.79-rc1.gz
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
* kernel: 6.6.79-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: de6988e4026e1da2b3653e74a33e46860cb3f717
* git describe: v6.6.78-153-gde6988e4026e
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.7=
8-153-gde6988e4026e

## Test Regressions (compared to v6.6.77-274-ge4f2e2ad0f5f)

## Metric Regressions (compared to v6.6.77-274-ge4f2e2ad0f5f)

## Test Fixes (compared to v6.6.77-274-ge4f2e2ad0f5f)

## Metric Fixes (compared to v6.6.77-274-ge4f2e2ad0f5f)

## Test result summary
total: 67097, pass: 53621, fail: 1765, skip: 11452, xfail: 259

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 127 total, 127 passed, 0 failed
* arm64: 39 total, 39 passed, 0 failed
* i386: 26 total, 22 passed, 4 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 30 total, 30 passed, 0 failed
* riscv: 18 total, 18 passed, 0 failed
* s390: 13 total, 12 passed, 1 failed
* sh: 12 total, 10 passed, 2 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 32 total, 32 passed, 0 failed

## Test suites summary
* boot
* commands
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
* kselftest-kvm
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
* kselftest-x86
* kunit
* kvm-unit-tests
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
* ltp-crypto
* ltp-cve
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

