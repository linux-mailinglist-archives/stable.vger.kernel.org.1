Return-Path: <stable+bounces-64741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 317FB942B89
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 12:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0E3CB24930
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 10:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840921AAE20;
	Wed, 31 Jul 2024 10:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BLGjHx5O"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AA01AAE3B
	for <stable@vger.kernel.org>; Wed, 31 Jul 2024 10:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722420177; cv=none; b=AKr2eRAUbqP72m7YCGO53QBb0ZlkVnU/BFrcDL6DEFjmZanEQPl3IMyWiSCaDRd9bXEP6ooEdyg8+zHg99/LUEvUmmWFHV5XDn+pC01+L3jk9v92peMlTGXWkrcfmBk7PcMfJDgmIhaagQ4KGsfQiJoQ/1T48sHBvL0oIKN1zFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722420177; c=relaxed/simple;
	bh=mL9uusADg7a9HYOd2D6NR3WfFBGUc0zEZb9LtWE1w+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hHGtoMp5NDvUW4651Uyy1pvdDPkYpR78Kqhc5MOqZXv8Cmc5R8C2mYuf2zRI/iPEZSe9S+zU+r4Kqy7NQBvR7auh4cmkV9QAWflEOqKehAvBfsVcV9GNmhQH77MFeYS7n+KUu4Pe/q8EkHaYqSP6lsO55e/sEXTTjQZX69d/6yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BLGjHx5O; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-709485aca4bso2208901a34.1
        for <stable@vger.kernel.org>; Wed, 31 Jul 2024 03:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722420174; x=1723024974; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SxfIjWQM1I8ejdjTf/qmRKu9OVnpN31pitQiLexFUhQ=;
        b=BLGjHx5OOl13gDwgU5ARQdCqYRW0qn7T7gIdpIbsLnztnSE0z113YJlzibn2vY8urj
         04O41qFu5Mc3GebD2IsolmcHX4S1y9tvi0vpD8HH2bJuwPRt61Ml+CYhA2mM99ffSgK1
         swRsVPlwdRuO43D2yFKFNsJyXzmDwkelQzfVa9HEI1kKZczDEc2gKZViKIhfFH4T0WlA
         d3xj43vj+3NjoKTvlyeK921GVYGfg81dwtLRgzp7MTQqhSmFZAZyyijzt/Y7c3Nmv0OG
         w1nO0hWq6eRFXB979HQko+JQlDvnPbA0MA5LdZnaE6P/NFMFb9hFd3ayINT/oFgodftX
         NF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722420174; x=1723024974;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SxfIjWQM1I8ejdjTf/qmRKu9OVnpN31pitQiLexFUhQ=;
        b=uBor8jB2C2HGbP2Dd2ExFP149UrCbfegL5KRL1UXFzyDcwWsrRIyenMzEZnNMINWz8
         F84/l47aqnJJqfs+eHU/9yhQGLyUNoEe9L/QQe6QV/77JvRDJd1ZlKQe4TaswTU8zpxv
         ynWSpKYq/dMof01eaIMp6hRS8Z6RR4+o68GsgvcT+PxWrm1gPHFM/Guog6abpkgAMkMZ
         lBqATpMyIWLgSWEDmZ4rgBns9kpdeKEjuWpBrX//k0RLoMbHPgiI9QctpVbrkdPwUTo2
         8ZDopLmwbn3Fq5ybEOvDhqX4pfRewJULSlLkYFthrbf2NFu/hJ5ymrHd71VGn6LXojtf
         QRsw==
X-Gm-Message-State: AOJu0Yw8BvxKYynB8J1Pa8UlSZC9WfrC9lmj29PlbguOHiTUfHC93zg5
	Y4Z3PFUEv4fP68l+H8MLb8XqbJMK7iO6BCnFtLIgIekhw+4XX3wu5AWczD1JAMmn3Q3L82+d1qQ
	0z1LyGd55uK61p0jcGyvK5LWpP3wevXHe5ggYow==
X-Google-Smtp-Source: AGHT+IGcJSroVYBHJ4TkHrJZqgxfv+JaZ6KCx5vx38yAmqvwXJaQ/hKH0lewS0khMKn07cEIxbvOWLW6z7FVQF7/IT0=
X-Received: by 2002:a05:6358:5292:b0:1af:1bc9:f406 with SMTP id
 e5c5f4694b2df-1af1bca22a4mr476871055d.27.1722420174535; Wed, 31 Jul 2024
 03:02:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731073248.306752137@linuxfoundation.org>
In-Reply-To: <20240731073248.306752137@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 31 Jul 2024 15:32:42 +0530
Message-ID: <CA+G9fYuqGMX9OQOoWOO+NbjY0W74CRzcgEXPNSGZvjutpKWM_Q@mail.gmail.com>
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 31 Jul 2024 at 13:34, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.10.3 release.
> There are 809 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 02 Aug 2024 07:30:18 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.3-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

As Pavel reported the build regressions.

The stable-rc 6.10.3-rc2 all builds failed due to following build warnings /
errors.

 GOOD: 8b6d47196ca5 ("Linux 6.10.3-rc1")
  BAD: 48651c22f448 ("Linux 6.10.3-rc2")


Build log:
-------
drivers/net/virtio_net.c: In function 'virtnet_poll_cleantx':
drivers/net/virtio_net.c:2334:1: error: invalid use of void expression
 2334 | +                       free_old_xmit(sq, !!budget);
      | ^
make[5]: *** [scripts/Makefile.build:244: drivers/net/virtio_net.o] Error 1

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


Steps to reproduce:
-----
# tuxmake --runtime podman --target-arch arm64 --toolchain gcc-13
--kconfig defconfig


Build log:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.10.y/build/v6.10.2-810-g48651c22f448/testrun/24750484/suite/build/test/gcc-13-lkftconfig-kunit/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.10.y/build/v6.10.2-810-g48651c22f448/testrun/24750484/suite/build/test/gcc-13-lkftconfig-kunit/details/

metadata:
---
  compiler: {'name': 'aarch64-linux-gnu-gcc', 'version': '13',
'version_full': 'aarch64-linux-gnu-gcc (Debian 13.2.0-12) 13.2.0'}
  config: https://storage.tuxsuite.com/public/linaro/lkft/builds/2k0KjlhdvqUirHA49IbPjeyDz6R/config
  download_url:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2k0KjlhdvqUirHA49IbPjeyDz6R/
  git_describe: v6.10.2-810-g48651c22f448
  git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git_sha: 48651c22f44864b641cfca023d360673cc46e900
  git_short_log: 48651c22f448 ("Linux 6.10.3-rc2")


--
Linaro LKFT
https://lkft.linaro.org

