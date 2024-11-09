Return-Path: <stable+bounces-91975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0E69C291A
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 02:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C4AC283FCD
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 01:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE19D17C7C;
	Sat,  9 Nov 2024 01:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oW6lrI7T"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA82C1802B
	for <stable@vger.kernel.org>; Sat,  9 Nov 2024 01:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731115690; cv=none; b=phd8LlChIe36+7eswdi3KUUGvo9pNDCXIsuFhXZibo3Zq6/TIg+PnMsDEYhwcZqtCQCJEfdgaz4zxS4KNZjQaoZlZqYi7QzcPAWMSkqLz06rbFKj3xYEf3IUASCcRrREC94RNDuMrj3rCBnQ1jgGLA/sKh4P2ad2g+ci1MjFzfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731115690; c=relaxed/simple;
	bh=0qOBjDBFQ7/bVy1TcDES0h9C1kh7nE15LzRGiQXWB0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hE+pHZtyGbVh2+sxg+NALHItE9KPRrcUV8ngB4fGLzjHHRE37LnG15wst449yIJceaCAVoXxvbccQFyX3LU6A0s5YkDFlibjSnGPSZ9VAcVIQu+9fbDyoUXRSdHcdCWxSC8R1WGxWn4GdCoCpYtNIQi+kL/EYM+7uQOVPC9zRWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oW6lrI7T; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-50d3998923dso1095824e0c.2
        for <stable@vger.kernel.org>; Fri, 08 Nov 2024 17:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731115688; x=1731720488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/PJTkVlX31ldHixqsdMfMAxssLgGROHTxQckOiGCTc=;
        b=oW6lrI7T0zs5APXS324dzZ0H7K5L+6oH11KsduJtpKMS3kz9mq82vIKm7732XS9HBg
         HqtZ0jOZrClrmppGGSPl7skVHIdAlA+BGUr98PJin8oLihTeqH5Sdm2RLd9OsWYfQsby
         rtDEFuGNvX9dSJv709c23OXOGOxCXbFfB2OiSkcKOjw7y45JOvuF80KECLSDmtRG2Xal
         ovNj1spXlfBxJxC0azqP12EnBd/Q9csnIDHu/hsOYeAJ5HaXkN2zFgHqk2aCtPLcDsom
         OfkN/T6g6b3VOafrt0EQol429Zqqfe+C3qq2SuK3dONGErPNrNX6jUMtTqUj3Ni3fbIP
         ntZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731115688; x=1731720488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/PJTkVlX31ldHixqsdMfMAxssLgGROHTxQckOiGCTc=;
        b=aw5ZMyOhsgR+p2craZryhci2Xl5LOdjnq8q0wrAl16y6i4Q4hYq2IiZybm+KgFMRkS
         2a0RlUlpgxHJk0oC+37sT9Ebyr+CZgLDf+yCnS+k9jLjQVPaMG0Qxi7CRX7WO//fm/uT
         AdEbHzCT52/fj9rWJpb9Ze/WkJ4bmAdh6SsSi/zjcfmZQprPAozRB/bVscMXGX59Gu2o
         l7YQZksXTu9zrxDNufn6MxIgaPX3GAaMIVlBR+GPmPl+Jp1Y89G+4rBvvgwhhRS9xbpV
         PVTX5duQB9FBJAHrpjXbm7Wi+F3ZP0SODQNGddhGRTXE6G+jldpc3Saa4pZFGZ6x1OAL
         fZ1Q==
X-Gm-Message-State: AOJu0YzmX63g70TB40VFCO50PvKRxzj4jYo9qPuJeJPxsC9j/3Mrk+Fc
	t3ekIEnYd7/cieWLcS6lOqhY2fIgxCwbCXnVOHAoPkiEPwnp2EVzJtJv2ispEwXEC2RektON1Pn
	VhHwstoEaV+J8R6l60axwQ5M4iZyt1sCBIg5v4Q==
X-Google-Smtp-Source: AGHT+IH4A0WlCjq74/Wfa1EzS4MKy9Vj7qJ45SzcSoIl1Y3odqZNyIYgD5QY/H+Ea2D7ncIbYc0XPx9spPHgk0g4z2M=
X-Received: by 2002:a05:6122:2a02:b0:50c:99da:4f70 with SMTP id
 71dfb90a1353d-51401ba15c3mr5317685e0c.2.1731115687671; Fri, 08 Nov 2024
 17:28:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107063341.146657755@linuxfoundation.org>
In-Reply-To: <20241107063341.146657755@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 9 Nov 2024 01:27:53 +0000
Message-ID: <CA+G9fYuXK1LYzu++g6LUBOEhbOMQSO9Zz6AhM7100NMMEZLuAg@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/461] 5.4.285-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hagar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 7 Nov 2024 at 06:47, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.285 release.
> There are 461 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 09 Nov 2024 06:32:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.285-rc2.gz
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
* kernel: 5.4.285-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 5dfaabbf946a8554cfc17ba8c289fe5eda8a3e1c
* git describe: v5.4.284-462-g5dfaabbf946a
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.2=
84-462-g5dfaabbf946a

## Test Regressions (compared to v5.4.283-122-g10d97a96b444)

## Metric Regressions (compared to v5.4.283-122-g10d97a96b444)

## Test Fixes (compared to v5.4.283-122-g10d97a96b444)

## Metric Fixes (compared to v5.4.283-122-g10d97a96b444)

## Test result summary
total: 52133, pass: 32970, fail: 2420, skip: 16682, xfail: 61

## Build Summary
* arc: 15 total, 15 passed, 0 failed
* arm: 399 total, 398 passed, 1 failed
* arm64: 99 total, 93 passed, 6 failed
* i386: 63 total, 45 passed, 18 failed
* mips: 75 total, 75 passed, 0 failed
* parisc: 9 total, 0 passed, 9 failed
* powerpc: 90 total, 90 passed, 0 failed
* riscv: 27 total, 27 passed, 0 failed
* s390: 18 total, 18 passed, 0 failed
* sh: 30 total, 30 passed, 0 failed
* sparc: 18 total, 18 passed, 0 failed
* x86_64: 87 total, 81 passed, 6 failed

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
* kselftest-memfd
* kselftest-mincore
* kselftest-mqueue
* kselftest-net
* kselftest-openat2
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
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

