Return-Path: <stable+bounces-121369-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7E0A566C9
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 12:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68D103A6426
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 11:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8658220E717;
	Fri,  7 Mar 2025 11:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iHRvSEj7"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BEC149C50
	for <stable@vger.kernel.org>; Fri,  7 Mar 2025 11:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741347121; cv=none; b=RsHOBwc7MHWCcUcxOvocXevm5q2K40ttTpsi8dXv/IphQZuTLD1W26iYyiZiJaIW1DnyY+TJO40HfxsmlNdg+5oNN8Nv+otOGCPfNRYeJp1qD7OEFT9CQnq6UtElC1Jf0cH5ZaeAgP90ZTrH1/OMAZ/9REkmJlGpA94blTMKFaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741347121; c=relaxed/simple;
	bh=f+BPraS5AJNOD2aTCpOoOgZLm6Ptv8S/6d8vbUiK0zc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fQvzM78k1BwHK4LizVpOFHs2k6aQ4wsMb6frvpYAGThSo/CgSmjvAx9Suv0wQvyGY6ew8UaIv9dE4XTh5TRBhjrIuZcxrjwF1HJ1XHCT8Ik3MGQiL5EhmoMWKPXdDASu5HGfr9rRFBOxCsHl0OkQoxcxY5F9mxgq8Jd0vV9OCy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iHRvSEj7; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5239e7d4f0aso1697714e0c.2
        for <stable@vger.kernel.org>; Fri, 07 Mar 2025 03:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741347118; x=1741951918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywKNXyQduZtYvoI6jxdhP8hHSFQmxCo5DD38wzTDf7I=;
        b=iHRvSEj7Dq9ZMiJj9kqWzpG4/nUISg896L0jpLTgl6YrFwDOZOA4ErW2VVojAQF1LP
         Nai2K0ff4e3ExF3Yg7sxbJ342c9P1Cxu/IjfODTE8lRF1Oef/gb4WqP1Oqv4RoLS4Uzb
         JLYuMxScX8xet1XgSq6NAhxaYsL4Lj3lWFe6OIMZDa9ah1+Tsasewgiq66wDVYfV23mv
         4p3BeVGptl9MIjitl3oRZe04OwfvfVnWDnO/tt9XvYqQQItN8MTk8wo+NapcQDLC1M8y
         TP2SCCDq36zHPKDQQmMKRbxrO77eiCJsTQVcyMDevkUJTg5JQYUjv6lu48NG15JH9Ffk
         UTqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741347118; x=1741951918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywKNXyQduZtYvoI6jxdhP8hHSFQmxCo5DD38wzTDf7I=;
        b=tRUi3zhd7z8Icnx0Wp+44tVbKzDZFPToacTMxpLY9Ju+zQzIHoaV2IRKjecbEbkszj
         dnDyu52ofcGoR/+V9Dd1wvkRttwezXEVRQiBPkoW2lZkzSZQD1qAm40vIQ0n20ViNNww
         JVnIVuIfSj6P7cCMXw0RfxmuS53pigR+rBCEZvxmvIqFMn55H47Z+TUJvQWrOzHqgq/5
         c5SaPbO47CY20fwkORhpTti5Qpc4M5Ub6ipBGLyNaRGRg1qAaaAEkPeXLLYlyH18AEcF
         YCnRLT/rpITz+UK//x4bguivVAwzhYlIcWjiJKViC+ItRiZkZGL3+jSMNpKCzF+H5hiw
         hnCw==
X-Gm-Message-State: AOJu0YwtEVFRAG/42cBnDkcljz8KXzIBSTrleL6KsAtpHTTMysFUm6WP
	LnkkOsZ/lpKopqrq37xyqbFJ1dlPb4LYJ7S5mqg9Emu5gCGZhbKUGxNeBiQ8dpUyp8hmzbk6r+K
	GSFF8WSLUV6bS2e3dzxp5n1dBHunTgbVPgACasQ==
X-Gm-Gg: ASbGncsyrKfYIynLUSmBUc9a68h7vSIle5UAVxZfPLUwhfr49gIi+pBd8iKCaj89AFn
	8Oa9q82JrKq5Lm9v98lLxkeVuQZjg6E+JQCe/VmFp9/FExF/33d1tWveO9OKVm44+t7rGYjy0r+
	G6iUnq2ldjeUw0tvj51tNXLEIatqL0RqPNeNgGI2uLklRVMKg2iDVd8NL4Bxw=
X-Google-Smtp-Source: AGHT+IEEoX3qpu6CmSaLeGuLW548G5UTO5B5A9BtNRSS+A2PIW08gpwHLIcHbM2Qnh/gpSxTryWAuaw+5ZOfZzxiwbw=
X-Received: by 2002:a05:6102:809c:b0:4bb:e80b:473d with SMTP id
 ada2fe7eead31-4c30a5a84c0mr1419593137.6.1741347118445; Fri, 07 Mar 2025
 03:31:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306151415.047855127@linuxfoundation.org>
In-Reply-To: <20250306151415.047855127@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 7 Mar 2025 17:01:47 +0530
X-Gm-Features: AQ5f1JpE8AAJ3gh7RSXMtWAe3wo8-y_6_oLsy-2eWfHGaTOHnPUFj3a5CwYb0eg
Message-ID: <CA+G9fYtDNr+w0cd7uiwyTWGvdVGWn9W1UdmRjbzA2JA_-x69yQ@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/148] 6.12.18-rc2 review
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

On Thu, 6 Mar 2025 at 20:51, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.18 release.
> There are 148 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 08 Mar 2025 15:13:38 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.18-rc2.gz
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
* kernel: 6.12.18-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 7d0ba26d403608b56f8de4892c01e4da7e841940
* git describe: v6.12.15-529-g7d0ba26d4036
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12=
.15-529-g7d0ba26d4036

## Test Regressions (compared to v6.12.15-380-gf5c37852dffd)

## Metric Regressions (compared to v6.12.15-380-gf5c37852dffd)

## Test Fixes (compared to v6.12.15-380-gf5c37852dffd)

## Metric Fixes (compared to v6.12.15-380-gf5c37852dffd)

## Test result summary
total: 124530, pass: 101752, fail: 4084, skip: 18630, xfail: 64

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 143 total, 137 passed, 6 failed
* arm64: 58 total, 54 passed, 4 failed
* i386: 22 total, 19 passed, 3 failed
* mips: 38 total, 33 passed, 5 failed
* parisc: 5 total, 3 passed, 2 failed
* powerpc: 44 total, 42 passed, 2 failed
* riscv: 27 total, 24 passed, 3 failed
* s390: 26 total, 22 passed, 4 failed
* sh: 6 total, 5 passed, 1 failed
* sparc: 5 total, 3 passed, 2 failed
* x86_64: 50 total, 48 passed, 2 failed

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
* ltp-co[
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

