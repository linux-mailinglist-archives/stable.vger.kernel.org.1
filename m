Return-Path: <stable+bounces-92907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 403D29C6DC1
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 12:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00DF028361C
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 11:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0491FF5E5;
	Wed, 13 Nov 2024 11:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f6HsbNO7"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770C31FA256
	for <stable@vger.kernel.org>; Wed, 13 Nov 2024 11:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731497032; cv=none; b=kNCjqwV+ZL+M0EceNuHg6LOOBUBxVtntj/RiVhGNtPG33a6y2e5imu9h2uIlM6pOiYEXx+W2QLevnwOXWbOm+Wjxs2TVYr+T+kCWgPRNIdrE/dFgvn6BpkdGH8vLPj48wexe4XQX2dCe6x5dxra7IOu+CTmFjIBtQ2vRXeH/CXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731497032; c=relaxed/simple;
	bh=gWwB35iDRGO3IreJbI3AA3gNoaf9ATe6VJvXYYnUzYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IhhozrE4gUn73jHVlkTdFChh5xXPNPi9gYVmujEHoIeQ3EGUirj0zBW0sQTmtH1oGnrA9+1YZNrC3oRzDERf/125K24d3TMBoDxYlmvyO/mvd6wy7ZiaevhQrv0rkgzZ9hZL/5Oc8XyxJomew4WwKnzr+8ib2XAitVLXyZAde2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f6HsbNO7; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-513de42687dso2875606e0c.3
        for <stable@vger.kernel.org>; Wed, 13 Nov 2024 03:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731497028; x=1732101828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXWDlI2EiF1lhgwDYvtN/ziCfOh4o3dD2YqZ6uItYPM=;
        b=f6HsbNO76xk8YVt4B0QpIimOteyouzS/acBcQqaCvUnUdr36GzgTsQlDu8h79ZvP/h
         Uu/IEhQIjXjl7UMT2P8+xhzyf2tzfZdLoGVowH9PkY1UynRYEbbbCuXyicdQLBsVtNHp
         vwBM3/gRX0FLUcUXDYqtu6wxw0KGuYzeCiqJCB4fcKQh+FTrk0lY0d3j/TBTvgBlpQYT
         raSgxkm5AlJkttusYjpZX/fRlEGj929E5ksrQN88g061a3owxZJblrNQsDuL1CCyJkV/
         XrDtI1240fMnozq/CfB0bSeInbB1kKiamJmtr47gf0zM8r1zhyID2N6t67yq7oXs3GWd
         WnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731497028; x=1732101828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wXWDlI2EiF1lhgwDYvtN/ziCfOh4o3dD2YqZ6uItYPM=;
        b=uwWolmdT0PL58oSWwIk8e05PEc6c468zXhwHMQ9i8FlELSdiKFlsbscw5kXlu7i0BR
         lYg5eUAfh5SNqAhUsK8UO9m0q/6jKh0OX30N0Mfjda7eqJn16KS9F1P405/0lsZvhD07
         HIU/4wZ3U2xTzDohHaTZZt4/TrcCdDFsgjpye58JpZNOlPnV2cUaVGDZ0zqPh3ZLRuFg
         0gtPTJRQbSdYMz/i67ttxElUL2YdDEbyfKpykLkwU4N+HcDuAnkauBnha3E+7y7ot66N
         ivQezzIVl5GYcQePKzz1gPTauIgpJePMwM8VT3RXuAQjL8A4Ra+sxE7KUs+ax7y3MQv+
         fV7Q==
X-Gm-Message-State: AOJu0YwkmQ/ZRqbPnfCYaTLhavBqV8DKwxmXiwZH1ujNAMdITgpPZiW+
	tDaBaXQoltfhKLZYsArt/bUw+wMPxbHdEwEh6ENrf6bmfkUV2zS42yonoK/dKBfj++NOM2Spx+g
	1aBM7Geq02N0sapWBwhGJaQrY1rNBOF9athPygw==
X-Google-Smtp-Source: AGHT+IGGvLM8pgT//CkiY3rwXUQ9Fmj5zh9FjBQ10Hd8Z1Gm2Iz1Wpdr0yutxfe0P/2ydOyLzCuMYm0QtK/SbauAP1k=
X-Received: by 2002:a05:6122:1697:b0:50c:5683:ad56 with SMTP id
 71dfb90a1353d-51401ba3348mr18377003e0c.3.1731497028273; Wed, 13 Nov 2024
 03:23:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112101844.263449965@linuxfoundation.org>
In-Reply-To: <20241112101844.263449965@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 13 Nov 2024 16:53:37 +0530
Message-ID: <CA+G9fYvtaB2Zmr6mWr03p2WF-ozf6JVSZVyPj03qEZHt8_VzyQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/98] 6.1.117-rc1 review
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

On Tue, 12 Nov 2024 at 15:57, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.117 release.
> There are 98 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 14 Nov 2024 10:18:19 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.117-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.1.117-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 41a729e6f9a934c7236c526524847c3b92f331d4
* git describe: v6.1.116-99-g41a729e6f9a9
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
16-99-g41a729e6f9a9

## Test Regressions (compared to v6.1.113-359-g17b301e6e4bc)

## Metric Regressions (compared to v6.1.113-359-g17b301e6e4bc)

## Test Fixes (compared to v6.1.113-359-g17b301e6e4bc)

## Metric Fixes (compared to v6.1.113-359-g17b301e6e4bc)

## Test result summary
total: 174222, pass: 141185, fail: 3150, skip: 29700, xfail: 187

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 269 total, 269 passed, 0 failed
* arm64: 81 total, 81 passed, 0 failed
* i386: 55 total, 51 passed, 4 failed
* mips: 52 total, 50 passed, 2 failed
* parisc: 8 total, 8 passed, 0 failed
* powerpc: 64 total, 62 passed, 2 failed
* riscv: 22 total, 22 passed, 0 failed
* s390: 28 total, 28 passed, 0 failed
* sh: 20 total, 20 passed, 0 failed
* sparc: 14 total, 14 passed, 0 failed
* x86_64: 65 total, 65 passed, 0 failed

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
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user_events
* kselftest-vDSO
* kselftest-watchdog
* kselftest-x86
* kunit
* kvm-unit-tests
* libgpiod
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

