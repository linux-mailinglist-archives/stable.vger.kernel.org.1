Return-Path: <stable+bounces-119645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA60A459C9
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 10:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 901C6189A12F
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 09:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CA122423B;
	Wed, 26 Feb 2025 09:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tb0lNpVP"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F353A258CED
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 09:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740561433; cv=none; b=YTSoF088RxWtLK8HO67xNNjJXcxXnlwI4LZCAMkUwwY/PMHscJixFvwW6wsiwYdn+4/YqAAFQ7vuAHashEE2tgd1n0owdkn0f6o7c8XfiW0N0ix4sf1gdKrijFjgSeW6bzET5K6eAfiw7aXPrEzbLnDQPFhSM1HcnSgwShSDPUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740561433; c=relaxed/simple;
	bh=Hf+VCZQAkJT2meu1sdVN2NPdeG/wTQeLa2BFN9U1kK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YIqFSCzuA+c2UvAjtLvCCd20w2exxLNTD0lGTJWmsefssB3PJAOwGX6N0wkulwUC25EQ15Bn0E4NCbIK0zx5scXiivBLCBwsj04rK+oZ/cCpRB4nOU1ouG0zIoBkpX0OEBocw23yaQxWc3qZujzR8uDunfkNpJaRvrddwZPVxLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tb0lNpVP; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-520a473d2adso4229273e0c.2
        for <stable@vger.kernel.org>; Wed, 26 Feb 2025 01:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740561429; x=1741166229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkYsziU56oM3MwTS4qzMUVuZRmIpV9WQpyZSvh+BG5E=;
        b=tb0lNpVPg6F15WG2pskzFuz/wKuJDmfNDGb5GRJwc/WfHfDNTABWyl2BN+wEG91PCP
         AANb74c+6C5Qx73xtYOOHtGDOZpJFQXmR3oIZew6Bl8VNY3uMcCAowUJynbG/G+4em9X
         CqDkdodj1sTOhKd+Hb6aD4sFEW/3AxT1ef6MGww2pjZJZt97fGAxy7lNq9HJWAjD9vtu
         QK/xHCVeeDYpcYE0qhyUGiL5lrKFPCfaBeBBvXwNagVM02nj83v/fm48QenRX80O1Dau
         82gXk+TGT1zCqlT+LePWFvgtkm/r481KKKQJaJKFBTHrMt6x21ae6Nr4XgFaJp2rely7
         Ykvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740561429; x=1741166229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nkYsziU56oM3MwTS4qzMUVuZRmIpV9WQpyZSvh+BG5E=;
        b=Q9ltZS7oTJzAEI/77a/fwHgyAzsFA2+nDZ3dq0LYsAVC/+U8OkBoxgdIozeRrWIkgw
         Loxam+Willu3YzsyeyzG8pDoSu3AvS4tL+SWjt7eSoRgOCNEwGp9ELeqaa6uApiyGeyh
         fyzlfC4aLTXw7xkXhYEYsdgW7qVpVd0Qfw8JbOZksL9LuDrN5a8tlxwBACpbCdHvKOpa
         uWd6k9qloegPHtc1VDs5tHKMSN+zWNK2f6L/z6A5cXb9EHbhJOQq9qg8VemSivdyV4fg
         +2/1IfF7W92Wus7PUg0VMw+fcglsBDsSRQadDjtoNEYtBoyLsDguRN6qPWxZwnzSpwrq
         5vfA==
X-Gm-Message-State: AOJu0YwxvGElBe3kYEItDevZL9WQE2tCqhK2v/fjf1c4jeV37+BEZg7p
	svRwlFlLvgGlBBhIIRAmw/BpYRDbBZhuSEUVphJS6QtpruxMhMZY5RI0mlaAekqRMMt5E/mr/2o
	jmGn+Zgn/Xmhqo9EwPazxU8L+dCFZygsoUinOLg==
X-Gm-Gg: ASbGnctAtRbDuN3MVTi9KkfUd0shusjER8jSQ8nXt+Z1d0dNOrTaFL1N6FJO8pUC1+R
	ZwdcELIUbSao8r0/XaOAnCSJwUJorljo5xztaNMXzMW/RyuHoETZ1LxXKTXtxQ4KD3NYgSbASeA
	Vv4Jh6Fvza7ZWxeaflhxrgP3Xlmfwf32uoI6rybc5j
X-Google-Smtp-Source: AGHT+IHhFiHsjlOh4HmrLEErJxo2Wlkw5Rir9/OPzCHMjsHipZPzDGQHYAiqeuDUwOBfy9pdIdakUoNmvIbZJ2T+Imk=
X-Received: by 2002:a05:6122:201d:b0:520:4996:7cf2 with SMTP id
 71dfb90a1353d-5224cd6264dmr1654324e0c.10.1740561428792; Wed, 26 Feb 2025
 01:17:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225064751.133174920@linuxfoundation.org>
In-Reply-To: <20250225064751.133174920@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 26 Feb 2025 14:46:57 +0530
X-Gm-Features: AQ5f1JqZEZmcBTxhk-z2C8v138XsDQ7jKMGbCVbb5921NpSF-DW8iSkGlypOB5E
Message-ID: <CA+G9fYt8kOe_wkQe_iVAwc5qPKUiZWb1=COO88Dj3c8oVWkNMw@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/153] 6.12.17-rc2 review
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

On Tue, 25 Feb 2025 at 12:20, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.17 release.
> There are 153 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 27 Feb 2025 06:47:31 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.17-rc2.gz
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
* kernel: 6.12.17-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: f5c37852dffd24f66248b4086ea594060f3299a4
* git describe: v6.12.15-380-gf5c37852dffd
* test details:
https://staging.qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/bui=
ld/v6.12.15-380-gf5c37852dffd/

## Test Regressions (compared to v6.12.15)

## Metric Regressions (compared to v6.12.15)

## Test Fixes (compared to v6.12.15)

## Metric Fixes (compared to v6.12.15)

## Test result summary
total: 125310, pass: 102630, fail: 4192, skip: 18488, xfail: 33

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 137 total, 137 passed, 0 failed
* arm64: 49 total, 49 passed, 0 failed
* i386: 17 total, 17 passed, 0 failed
* mips: 32 total, 32 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 38 total, 38 passed, 0 failed
* riscv: 22 total, 22 passed, 0 failed
* s390: 24 total, 20 passed, 4 failed
* sh: 6 total, 5 passed, 1 failed
* sparc: 3 total, 3 passed, 0 failed
* x86_64: 44 total, 44 passed, 0 failed

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

