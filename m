Return-Path: <stable+bounces-111834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C60A23FE5
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 16:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A612E3A3747
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 15:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4531EC011;
	Fri, 31 Jan 2025 15:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n+WGp4Qc"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A41D1E5714
	for <stable@vger.kernel.org>; Fri, 31 Jan 2025 15:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738338600; cv=none; b=tqESpq6WsE6Uk1sUju68q6T7KMFiwbSd+KPrNoXmHRkHc2czRweVklY3BwIgjHkIsExIElIdbqix00pmPzYVPMr+XI2JLmx5A87HnFon6tQD9Ze7ddAq/L9RFyFqexDvVsmeScmylnnkS3dESboede8sCgqJ9q8ceFywAWl83ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738338600; c=relaxed/simple;
	bh=o2eVme6LWBzp3TARLj8ZVEg5e8/pMmtAadvIJSWcjeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jxLcjpT/5WcVS2gZEewyXfE7JqQSUBTRgTv/oeGdfZoBoTYSmUuj1aum1ZrZGVmtm0485frGxB+9ob5Xd6dSJUfV+iufbVFk3EttW44XWRwvp7LBgZjaVtBIxq1wdznYlmZRf1mOpl6XF/b3Ibs3QeRwatuo+nld36yjuXsRoIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n+WGp4Qc; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4afeccfeda2so1203376137.1
        for <stable@vger.kernel.org>; Fri, 31 Jan 2025 07:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738338597; x=1738943397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWixQrVCIAlgNIcS80jNJtJK73gPxHWL9wIx8DKe7MA=;
        b=n+WGp4QchKTP6avem8Qd1pgafJsWegPVFcBJp97TvIIga/3QzY/JYL4FWzShjUh2M+
         zkbKYL92zNVV5TGJKZuOF/OM3VZBDxgNLProTkOaUCn7Wit+ApeOO1hxlLZv7LXTEiu+
         CDIbvfh2oWtiYzHm4mF88tLhI1YbAjbi8pjOXO1opPDWHCD/zj0yyidsJQzCEh5LCVfg
         ySGusWIYsRYBe8jzfl9zPMFiv4hhiYgvLzQuDHoK1e+jkpiMi8YjUaIyau+gFSUGuEEN
         LQ8QyPYxjWLPXLcoA2oZRoqGvn9v2VH5vfhMWXMqYxZ7k9haYD3pNcFDx/oyx+ihhhku
         GQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738338597; x=1738943397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VWixQrVCIAlgNIcS80jNJtJK73gPxHWL9wIx8DKe7MA=;
        b=BE3iItdf3Tgdx0axecHtVuwJ8m4dHpC8yqVyR96tfSIMG4VO7R2xtmkVq7Fyw5tDQt
         9vHh+SziUXhuabwRUhCn6Yt2ujABk8r3qkhg+zBGtj5jtx4twWi4hUx2IwWN8BTVTJoB
         rmTtHhViF+YHyafNGP1iuRR9q7Z0jO2TxVtNT/6dsIrzCyJs2vaW1/3jcgkYKENfwt5O
         UFQO1QKuVsT5BjVZSdcH3Ec9mz39bPdG1bhYEAxin66cphAKWIkoCHesoNaetAzokgHl
         w+sEmg3eDTFN+TzVRkyLsYIUvU08rRqqnFHnHssoTKw+FlwCOYUtlRlhdFYRqJJDPqVR
         2kLw==
X-Gm-Message-State: AOJu0YzIMNimb7MaRLqm7rgGhpFtBcPLh2mmQ44DUy5iJ9vo20mNtmgj
	JXpKQ6xhK3Y8UH8A3N1zPZIMO1fdxp7VbloWYVD1I5ZQlfiK8tI4DJbByRwGr5noqmQu4C8Lhn7
	IlhQzQ3LQZ5jvLm3MUZDSlCItTzFFhFsXI1ItzQ==
X-Gm-Gg: ASbGncs2Vd7egoBza9I/1u2gF1JiLpZXSeoawKl+FVKLY2HJ6TrSq5wxSMyvzhaGugM
	uOC/8CMnfERZS0j/hAyFAuPMf8lfuqqpi1cN2YcWQENrXAmqWQ6aVgyGCitViHlY0Mm9LIhc36b
	ww7d9Uq48Nk49X7Jw18fizcdIXkmon5g==
X-Google-Smtp-Source: AGHT+IEmU+ide+wPljEknjlPcnDS70VvV4gNHBQPkhRPBxsv4r+mkc3GijgB/cew2sz29EmYjuvDKwtPUTAI7Moscco=
X-Received: by 2002:a05:6102:510d:b0:4b9:bc4a:bf48 with SMTP id
 ada2fe7eead31-4b9bc4ac3b0mr5004678137.21.1738338595383; Fri, 31 Jan 2025
 07:49:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250130133456.914329400@linuxfoundation.org>
In-Reply-To: <20250130133456.914329400@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 31 Jan 2025 21:19:43 +0530
X-Gm-Features: AWEUYZmgHq21FJCqLUpH2YZWV0iYRhsBr_y3qwk_JndElOm_h0vSyasAEF7Z5l4
Message-ID: <CA+G9fYtJjEoVvJtg=DMXZGOaAXhiwYzGRu0JFkWpDpBSZhDmjA@mail.gmail.com>
Subject: Re: [PATCH 6.13 00/25] 6.13.1-rc1 review
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

On Thu, 30 Jan 2025 at 19:29, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.13.1 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 01 Feb 2025 13:34:42 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.13.1-rc1.gz
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
* kernel: 6.13.1-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 65a3016a79e2da6e613c74c51e580ff1b3ad1225
* git describe: v6.13-26-g65a3016a79e2
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13=
-26-g65a3016a79e2

## Test Regressions (compared to v6.13)

## Metric Regressions (compared to v6.13)

## Test Fixes (compared to v6.13)

## Metric Fixes (compared to v6.13)

## Test result summary
total: 142397, pass: 92519, fail: 31182, skip: 18696, xfail: 0

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 143 total, 132 passed, 11 failed
* arm64: 58 total, 56 passed, 2 failed
* i386: 22 total, 19 passed, 3 failed
* mips: 38 total, 33 passed, 5 failed
* parisc: 5 total, 3 passed, 2 failed
* powerpc: 44 total, 41 passed, 3 failed
* riscv: 27 total, 24 passed, 3 failed
* s390: 26 total, 23 passed, 3 failed
* sh: 6 total, 5 passed, 1 failed
* sparc: 5 total, 3 passed, 2 failed
* x86_64: 50 total, 49 passed, 1 failed

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
* ltp-np[
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

