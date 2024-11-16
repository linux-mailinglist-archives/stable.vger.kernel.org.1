Return-Path: <stable+bounces-93641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6729CFEEC
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 13:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C19F287A81
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 12:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0DC19340E;
	Sat, 16 Nov 2024 12:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tss89jXs"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837AF191F77
	for <stable@vger.kernel.org>; Sat, 16 Nov 2024 12:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731761683; cv=none; b=q1AsWi1pNE/joFNQmL+YKnnhaQ9lpdTe6atvPjWOxmp7Qz1Z7gjMlqQa+rIaOXbzzawZ9WCmMWSG8ybTIwIMKobpUv8xR/MhoZRJ5JuuAfTtN3FbpoGhGT9QTaRsiLQnY17qzMGVlSTXO5HSdRdNLnOQa0Ii3nQczx+HE1PdLR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731761683; c=relaxed/simple;
	bh=V8tnW0pG41HoDBAZmyoo2mCqeNMoj/x8I1k9IWEuRNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JVeckJdBw9mzEpz/4X5tQE7Pz5/Z+ruiS4uN42+Ph6CNY7HqoLmpYa+qsOOHrb42nN16h4TqNd20hOu3Oj8DFR3PHH7Gj25C//25uIpnvWdAirYxUmXg8Ge2q+ciaUnEmLDuJutsgukLE9Gpo7C2AF7UkpOmJOJc6l34whC1pDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tss89jXs; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5139cd01814so1051224e0c.0
        for <stable@vger.kernel.org>; Sat, 16 Nov 2024 04:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731761679; x=1732366479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkrfLtlpmMOkbZGmAfotCto0+KgmvVAi/auh4c1VTLU=;
        b=tss89jXs3Khjdx7l13RrTiaBR5A2T3K30sqbyFKFuYFGVk/KVK7Amt6lxsCFRtXu6K
         3wtgLR7UGE/dsAVta1T0ozE7G2y4DI0rqqRdHzTw0dypAFsYrUKLi29P/r6CFuoj6aLH
         Hq3/HGASbe2iyCKQhTg7sDh9ahM/WtGrvoaeT9YdXP0ZHcb5pQUtYjCMq9L9nePtoD7h
         R9p5Sd+P/UZdj9qAoFkNo9/bhDNQ8yay9fOw2n4/GXn5Hzr1t7ol0Xwh7X6oiIRR0lug
         g23H4AI7KvUGyhppFDblalhweFCvHAHfF8CUB9jMGWKjLMsvuI/ZKJfKJcwNaMO8htai
         kHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731761679; x=1732366479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PkrfLtlpmMOkbZGmAfotCto0+KgmvVAi/auh4c1VTLU=;
        b=F1NV+MXMvbHxslX0Sz/A3sUFrSyWQAehJUwu0HF0azoemUoa9FK8pRs0MtHaL4EpjS
         g9Ir42gAsMftYJ9m7EPkfgVUybqKUEn5Nw6/Eoui0o3UttMpZZt85GKXJcNnuZXYNcbX
         7PZlnCIBOaRKo/BO5QW2g7x25sBBJ98hVh2GrpqwXgoTLbV9ZqfGFU54NKFGv55/RcdC
         fs9uTdFw7mx24uMCkXqJMaSmBPceDihFlcmj5iTi/ACcRijawc90HFEeLgS5uxoVYglh
         23HL9m0iahnC2/BYVLxDD/FK/02Oi1YAg3meZljZ1Yba6RYEOanpFuKm1KbZxk4XJQn6
         7MnQ==
X-Gm-Message-State: AOJu0YxgjZUqyA5UoXZbZ7kmpc1vAhJJDsVUixe0rZr5nz7nI2Wzkswi
	j9zEUj18V+fJQ083a8Vn0HTKdUfKKgKhbnlZ1eKyRELupr8BGi8hppH6bB96+Py22D5V3bcoQyi
	Rlsm00BiiqQBulkqAICAK4a7ketNZ2KPqYRwZcA==
X-Google-Smtp-Source: AGHT+IFBlNbBEfHKYfUCLNDUnsYSTdCdqnGy1PkuwbDOsfFBeRKbFAQ00f5BfHzKrvXon2aVChjMTfVk2GjdRQAR1X4=
X-Received: by 2002:a05:6122:3d0c:b0:4f6:aa3e:aa4c with SMTP id
 71dfb90a1353d-51478567375mr5882461e0c.3.1731761679481; Sat, 16 Nov 2024
 04:54:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115063722.845867306@linuxfoundation.org>
In-Reply-To: <20241115063722.845867306@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 16 Nov 2024 18:24:28 +0530
Message-ID: <CA+G9fYvzExabWp94wW9dT=_KWLUWjTJvT4ZtoiJvFvGyxjW9Gg@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/52] 4.19.324-rc1 review
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

On Fri, 15 Nov 2024 at 12:11, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.324 release.
> There are 52 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 17 Nov 2024 06:37:07 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.324-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.19.324-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 3b4d1c2cc31466d675bc2579661f90066a9c0404
* git describe: v4.19.323-53-g3b4d1c2cc314
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19=
.323-53-g3b4d1c2cc314

## Test Regressions (compared to v4.19.322-350-g9e8e2cfe2de9)

## Metric Regressions (compared to v4.19.322-350-g9e8e2cfe2de9)

## Test Fixes (compared to v4.19.322-350-g9e8e2cfe2de9)

## Metric Fixes (compared to v4.19.322-350-g9e8e2cfe2de9)

## Test result summary
total: 25104, pass: 19640, fail: 186, skip: 5242, xfail: 36

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 101 total, 95 passed, 6 failed
* arm64: 26 total, 21 passed, 5 failed
* i386: 14 total, 11 passed, 3 failed
* mips: 20 total, 20 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 21 total, 21 passed, 0 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 22 total, 16 passed, 6 failed

## Test suites summary
* boot
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
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

