Return-Path: <stable+bounces-123218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10123A5C319
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 14:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35D127A30EA
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 13:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911AE254B0D;
	Tue, 11 Mar 2025 13:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="etkLWdkO"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B747D1D88A4
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 13:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741701401; cv=none; b=SFc6pGBFL7MvmDJiC71jtL6+00Grdt0pkz3MIuVhX8/RBvzeZ8iSFTA0CyCaPMRrZ3drhn2H2SH9a3krw616J6I9DvuA+t60Zekd9dpoQ0ZJJHntlNOueOuYlOePMdmqZYYn9Rev3MqXnheyCpgtSYxbWtGRLNtcH/mwKp+S1iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741701401; c=relaxed/simple;
	bh=8IiP310D7e4ansyuaQQM1xov8Mvy6oaQfxyIgMszHD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DW6OS2eLI/9/VoPmF0wQP04VPxYNIuATT6gZJLJgNrmxE771pTE/wE+m6WwRUvt7sU+P1zi/hCg2fIxk6zgjRs/cpMBzXy6DQLle9PZo6295fcFXerOt5xR2qVa7LS5Vt5YgPWjgFjJUBHA42rwM74MlrehyBCibso7lPB80Cnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=etkLWdkO; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-524038ba657so2449481e0c.0
        for <stable@vger.kernel.org>; Tue, 11 Mar 2025 06:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741701398; x=1742306198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2N+Aak+CIPeIHj0r29UVuXvGehh5FWJExHuvJuMJuw=;
        b=etkLWdkO/1PgqBwcW5eaB5PLHcGmnst+3iiJHOzt/FYjqdDcP5I7AJyg6Jxj5sX6VV
         NaK/i9S3aksxXqsQBYfLcWnLv9tcQ/wl7G2NeaxnZ64SDUqf9mUFWG4Q5wddsplgMnt4
         qippK+2PM8x1Cim9PfJlj767FKfxLekedTzpim4mZfGNjFmXCy4vi1wTOn6phweWjWDe
         LqbBz4Ro7gJuZM9MAGxoefJLIRFxFAVhQal11/Gts0wsY5YOP+DkIHP6psaS/63QBvTW
         ZOPJg9Bxkfa3JpJNBL2ytX9471G3pJWPVasuHXxnBAOrKLJAvz62YkzJrD5gTcyR/k+Z
         ftmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741701398; x=1742306198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2N+Aak+CIPeIHj0r29UVuXvGehh5FWJExHuvJuMJuw=;
        b=GlUBVq+aFMwigbgXRu99HIBhwbnTE/PyPFUjex3KXgcDAAYvaRHr73VMv8ApxQCW8t
         xSP1cmbiTGrAKU7WpCKDVAfoJ95Lq5nAUh7TAf+z33uTWruy9JLkzz1OQG6F4JFkamXx
         jvituI9+YPJMQSzHFf/D7EEXtecGZ4cfaHBeRVAPFraqJHoNaLetdCRp33YX+lUhu9/k
         jCeaxXJtblZHiyLQ7nzveiw2su0VYloNwYBLKD7Uv3wowXd4hp88uKcB/OK1EmY7yHud
         rFMtcf0bPS/CdAAhUv3yCWHW6FI5R8/g7PEqW1sLwDC5WK2rQiMMFBbFraaeGKRts5Sq
         ePWQ==
X-Gm-Message-State: AOJu0YyHNRiBHCoL6Mg8LjTAXKntZw7Iwl84LS/pR7H4Y5k8RbEiXWGb
	Hny4ncAJBXyT3z0uXkyeFnVp4pTAyVyD11jCepadJYRrmyWFb6cB9JXD1nuxedJtx0S66qttvvA
	4MLlYXBmraxiJSWbUBHdcq9ukfAAh76gNaDrdTg==
X-Gm-Gg: ASbGnctSl60+yrikLxBPEk8CuulkNXEzjnSeZUc+dHUcJFf56vy4ro1Kh6two83MQq5
	j7hd5eVNppiWHT/y7ONV+VKWJF0JL+msdaOHgNvwVP8zdibX77jYdXqDKP3eVnT3dXckZJtAWCJ
	5iZAI6wwG/J+VNph+/w4gnz6UKyuecEYxi3/99mTJmG4vaqkNduvY8sb3U3xg=
X-Google-Smtp-Source: AGHT+IEFerF36HL1rGh4auPc7CBLh70p65CcQmhmyY6oaALXU6swyvZCI0BvNaOEVhtsxQeTQfLD2Hu11+otSm5zxMY=
X-Received: by 2002:a05:6122:3d47:b0:523:dbd5:4e7f with SMTP id
 71dfb90a1353d-52419754983mr2484522e0c.3.1741701398495; Tue, 11 Mar 2025
 06:56:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310170447.729440535@linuxfoundation.org>
In-Reply-To: <20250310170447.729440535@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 11 Mar 2025 19:26:26 +0530
X-Gm-Features: AQ5f1JpJScIVXTIFtt-TDzw-VZFe3PYeUikQXgKwV-72D77COTTUyRM5ws7x7v4
Message-ID: <CA+G9fYtzO4bv8ij+x7yV5YDbSr+wsHRQCzfzjXUA29oQmvTsvg@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/207] 6.13.7-rc1 review
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

On Mon, 10 Mar 2025 at 22:38, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.13.7 release.
> There are 207 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 12 Mar 2025 17:04:00 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.13.7-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.13.7-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 2fe515e18cbae9a204a7662d4b3b5760633f31fa
* git describe: v6.13.6-208-g2fe515e18cba
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13=
.6-208-g2fe515e18cba

## Test Regressions (compared to v6.13.3-552-g3244959bfa6b)

## Metric Regressions (compared to v6.13.3-552-g3244959bfa6b)

## Test Fixes (compared to v6.13.3-552-g3244959bfa6b)

## Metric Fixes (compared to v6.13.3-552-g3244959bfa6b)

## Test result summary
total: 74660, pass: 60565, fail: 2624, skip: 11471, xfail: 0

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 143 total, 137 passed, 6 failed
* arm64: 58 total, 56 passed, 2 failed
* i386: 22 total, 19 passed, 3 failed
* mips: 38 total, 33 passed, 5 failed
* parisc: 5 total, 3 passed, 2 failed
* powerpc: 44 total, 42 passed, 2 failed
* riscv: 27 total, 24 passed, 3 failed
* s390: 26 total, 25 passed, 1 failed
* sh: 6 total, 5 passed, 1 failed
* sparc: 5 total, 3 passed, 2 failed
* x86_64: 50 total, 49 passed, 1 failed

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
* kselftest-rust
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

