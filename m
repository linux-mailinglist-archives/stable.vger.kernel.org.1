Return-Path: <stable+bounces-37787-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BAA89CA8F
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 19:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80F3B1F24E38
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 17:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33647142E9F;
	Mon,  8 Apr 2024 17:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T0N1ia1H"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30241143888
	for <stable@vger.kernel.org>; Mon,  8 Apr 2024 17:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712596559; cv=none; b=oi5f7LenohPWfDdC7ksupHf/IvOWU6DWYWuYq8/t5bRCJRvL3Jynux4i/3q2WHrFdyWiYGXeDSVsPJK8eKu/ZLm0Qsm3DNH7+E0+8l0EuNx6Se9roR09otPeHEJ306A68cmPawyoDjUqMPXKYhw6wUIpcVLZsMpObqXz0UfBngo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712596559; c=relaxed/simple;
	bh=WzIOBFBkD2VF+X/O36wHgqJzYEwGWtCcZYrHSWH0pUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c6nNItf2Zt3wkkHg7yS8GC/oQCWdqrEJEjGXV/gSuiterikwpoJ19PA/qs+RQ2ghOJm4T4qOMCQRpV9pR88VN6eJ0WBR0BEwbKRuO7Y6/f7TaJ5EtYZ4k0mIfol5RwwgA8kiiO9Lv7MV9LA4P0fCqejCR17ygl4kr+uQvHfVaZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T0N1ia1H; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-479edfd02e4so582486137.2
        for <stable@vger.kernel.org>; Mon, 08 Apr 2024 10:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712596556; x=1713201356; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qMNf7A6k8nLtZDPsfj34GNgCGUzYdTJ3ArVvRF7NLxI=;
        b=T0N1ia1HCZUIfD5me3hD/7haseWLZWvH6VnymmhWs+pzrD6F57B+znGEWdsMlx5WKB
         x1gDvHQIo/ZrOeD3AG6uR8cS3hpOpiuliQh8YVirw+Ep8gnNm0o+mhvbsKuuy0qeaIlP
         6GlmFKW4QIYRMEMuylztBvh0M+NLERW+XIOmuItmXvbZdrdYQt47bWEk0JrmE6S6BIyQ
         ltfg6vjWDWT9VmkI0cvfZsQu+qMXYryXsu3/rQEiGJZ5KwXHOOSN+C9cRtglkUddxTKP
         vwOP3f8Om2/Tkm62FKchMr8j0pFQqR9jUFd3diuaYWD2+Uoj0hH2MlcEViiWYuGTnFCF
         LLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712596556; x=1713201356;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qMNf7A6k8nLtZDPsfj34GNgCGUzYdTJ3ArVvRF7NLxI=;
        b=wtXQh12MITALAyUeO4Yyxu6pLMgdUjAX6iExz+X3RAf6ArI4L8WA7N60VtDkBhYLSf
         75Z6CpiKKt3A++RHqj77bVpz8dcAuMJUcrQWF3+sUyNsVhk8sB18gLFMebLw2aIyu6Bd
         L7m4B308NeXY/WxpIr0AH3azLcZPiDAVlbvrKRkjHoJjN7avdV26hHjmpQqbzsBU64rS
         PC1n1qkIxwEhfWld8hlLZ2zRSviKKrhMLEzp9lBUMKUdFFAIx3IBhYc4zykWJckoAimT
         ay7yPzveJUZOc2CAdsC92VZGInmh77XjOz+1opQh/vKnSjc13Bq+pMOOLSQzPoNKmRZA
         0iRA==
X-Gm-Message-State: AOJu0YwFIio9JAkZ8nfbj/P1apyUB5MCrrZQpATJo0TJ7PCIrY+gqO4G
	FRb7MPBwT6+ANZQ8FYFrh4flEOSUfr61xyn3z/UAz5SqbI8s0uJOpUh+xfiR47oI3mXS+Gf48ve
	Wxxtk1Ac3glVAs84MQjne4xbSxQVfXwnX20gXig==
X-Google-Smtp-Source: AGHT+IGH5m+zw44aHKIWpc2eCPDcCytI9gca4fjAbaev/T3kTlbpcREmReh2WF2ua2H28ryZdpuTMcSK6lK7YYEObFE=
X-Received: by 2002:a05:6102:6ca:b0:47a:ff5:fcc5 with SMTP id
 m10-20020a05610206ca00b0047a0ff5fcc5mr1097660vsg.4.1712596555926; Mon, 08 Apr
 2024 10:15:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408125306.643546457@linuxfoundation.org>
In-Reply-To: <20240408125306.643546457@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 8 Apr 2024 22:45:44 +0530
Message-ID: <CA+G9fYsvgN2ixfmDKc_x8yFnZ3SfrmSV5Ck1QC5KfmYN89CFYQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/252] 6.6.26-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Apr 2024 at 18:30, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.26 release.
> There are 252 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 10 Apr 2024 12:52:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.26-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The s390 defconfig build failed with gcc-13 and clang-17 due following
build warning / errors on Linux stable-rc linux-6.6.y.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build error:
--------
arch/s390/kernel/perf_pai_crypto.c: In function 'paicrypt_stop':
arch/s390/kernel/perf_pai_crypto.c:280:51: error: 'paicrypt_root'
undeclared (first use in this function); did you mean 'paicrypt_stop'?
  280 |         struct paicrypt_mapptr *mp = this_cpu_ptr(paicrypt_root.mapptr);
      |                                                   ^~~~~~~~~~~~~

Commit detail,
  s390/pai: fix sampling event removal for PMU device driver
  [ Upstream commit e9f3af02f63909f41b43c28330434cc437639c5c ]

Steps to reproduce:
# tuxmake --runtime podman --target-arch s390 --toolchain gcc-13
--kconfig defconfig

Links:
  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.25-253-gec59b99017e9/testrun/23347738/suite/build/test/gcc-13-defconfig/log
  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.25-253-gec59b99017e9/testrun/23347738/suite/build/test/gcc-13-defconfig/details/
  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2eozoS8GQGxb94EUWNTPuXvYjVU/


--
Linaro LKFT
https://lkft.linaro.org

