Return-Path: <stable+bounces-46064-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DB98CE64C
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 15:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6860E282025
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 13:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21D4126F06;
	Fri, 24 May 2024 13:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DQc++neL"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B0B17C9
	for <stable@vger.kernel.org>; Fri, 24 May 2024 13:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716558431; cv=none; b=O0FphJhLVYrGc1ncvVV5A8AuItPTXkr89ujTMnoR/P1e2AP2QwsZYjr/X1Q9BfWDIWdgvtsUiJL1MgvPAROq9QPUULEonlRT+ZS8Tz1wr+szsZzV6t4YPp+vDJB/5WU4mYWuqfEHT7XPj0cJ4pouN+/gWgSW14WoVwHnE4exKVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716558431; c=relaxed/simple;
	bh=J4jKhU2rB31y3MjXeQjXlJ26Ug7+zDBlfBWD4JhyTwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XXOfOmjDxSplxIQUPPE1vnQHmxa8nbH91BAZwBzRLOp6HDEhxXysDr9CZQb8F5/cGK8dxDG512U+FR9yQuxoewq06MuTXzAyXFkWulF/C8hLNXJ4yAWGi2Qm9zZrTv0B407papWwUmfXPdu3o+TAvriQP0tn0MsuOKx5L9CHg2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DQc++neL; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6ab9dacc38fso4743446d6.2
        for <stable@vger.kernel.org>; Fri, 24 May 2024 06:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716558428; x=1717163228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1AdWBPJk5cBe/4Kv5WSEGIK67LQv5wPA9TlUppk5PQ=;
        b=DQc++neLPNuL/r5feGeDtEuCP6oyfxOqaG4ORWrKmk8e7ScBN3BQ9by5c2GXylZB3s
         uC0ZTOExyK4PEWim9l/C0WqhlLIBZsEqBHwzEFIefdSTnloq0YqTWUf1zarpye9XnSFF
         5gJ/5voXhdUwW+0PDT8dWA+ip2fY1zaW+94eiY6J8+NydV2Fdu5P5cQ7I05ONWmazeX1
         eqkwM6CZd4WdZChFi41sJu+1s5ZGDOJc6zeKwULClfQKt0F803Drf1ZJx4fB/uyK+MgV
         B/xLJZHQQKcekzLJePlnLwn0pRG+Ck60ncO+n+/qc1Vd8eTu9X9Xipf4TNC7m/78G5P8
         AUKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716558428; x=1717163228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1AdWBPJk5cBe/4Kv5WSEGIK67LQv5wPA9TlUppk5PQ=;
        b=amNXWfX37gdmWb0ZHJM9nTFdlZ0WLp+608m2MGQcrdbc8m1pq+RvEaBO8irB29t4K4
         ihv0NuZkC/JpxSV/1dmE2xZ/X4HF/r9/DuIdeTOqshpobZH9sTcR5tRh1XVxgmrAJ12o
         6vYnCJM2qjDjAipQ297HfPY7Reh3e4WCCFo/E4fmmrcZp+iTfHqRMgPYBq2hIoB9oKtD
         pgmMQ++0zWLmApuASmyTzKnAcKWS72yh2s4F7CvaeZg41COH/B4L0x03lCmipnSkkNGZ
         oGEkBtWKGn7XhzFd206WnN8JTZhbHufwRHVgLiFrL3c5qu3iM45oyhfdfhgB30Bjbbid
         AUTA==
X-Gm-Message-State: AOJu0Yz0H9OJ7Jg3QbyKV/NOBP+RQxwebWqlpdJBumVL9OFZoNfbUE3L
	wyDk5LHT4rhxEWYa3d5KZnLdUAeMqGuDZf3WKboNO4HvTtdeYCtafTjvRg2/uIacjGkE4E+yu0g
	n22uSbrm5I6PYaolJcRCmzYvunR6N6r2dZ4RFxw==
X-Google-Smtp-Source: AGHT+IHogsSuuy+E3e3pnsuSrATsQOrGLSz4vi3QS2BdvkWUI2SzN070UwMpnAke8bJaN/PfoYBOKxmGy4L0+AdkHEg=
X-Received: by 2002:a05:6214:b33:b0:6ad:5f4b:d79b with SMTP id
 6a1803df08f44-6ad5f4bd983mr8922616d6.16.1716558427864; Fri, 24 May 2024
 06:47:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523130325.727602650@linuxfoundation.org>
In-Reply-To: <20240523130325.727602650@linuxfoundation.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Fri, 24 May 2024 15:46:56 +0200
Message-ID: <CADYN=9+vnu=a9ZbEXBvtW8OXs6L4xTqokLLDhMDrnjmE+dmqaw@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/18] 4.19.315-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 23 May 2024 at 15:15, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.315 release.
> There are 18 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 25 May 2024 13:03:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.315-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 103 total, 97 passed, 6 failed
* arm64: 28 total, 23 passed, 5 failed
* i386: 16 total, 13 passed, 3 failed
* mips: 20 total, 20 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 24 total, 24 passed, 0 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 24 total, 19 passed, 5 failed

## Test suites summary
* boot
* kselftest-mm
* kselftest-net-forwarding
* kselftest-timens
* kselftest-user
* kselftest-zram
* kunit
* log-parser-boot
* log-parser-test
* ltp-cap_bounds
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-crypto
* ltp-cve
* ltp-fcntl-locktests
* ltp-filecaps
* ltp-fs
* ltp-fs_bind
* ltp-fs_perms_simple
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
* ltp-smoketest
* ltp-syscalls
* ltp-tracing
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

