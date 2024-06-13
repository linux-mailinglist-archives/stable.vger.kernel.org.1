Return-Path: <stable+bounces-52059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F8990758B
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 16:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BC38282302
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBBC13CA9A;
	Thu, 13 Jun 2024 14:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bt43k9+b"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3C6B664
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 14:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718289975; cv=none; b=kDn0ZyvIzQJFdwGZF9VLKR0uHStXnHDp+DEvNhXjklN2ymVGeJP1DaPKuJklp3niHu2VdKi4YLv1h8askfVkzArE6twffybR3cvQIbdADxckpvxc6BPB6OKLOBj0kkF/z1RRHmiTF+WwjIlvCgWga3Q78QIIpOxbr6JWzktkB/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718289975; c=relaxed/simple;
	bh=xiHUK0Hl49OuL+qGWj5fc6IwTuTt+eReSxMzlJBq9LQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bwMNOx/2Zwxa+7aomrUvvy3/f4os7ELRdLZs0TVvR8/jTKGDS6zGBsVhseLd+iU+v9dnUnrJjImTvmjjK9H1U1X+dD18l060mhBzacQyU6o8T1SFrbAfu1fZL2h93uh00OsZ5EhB3dk5gA5PbunHeMqdaTryyp8jsYUmjpqmKo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bt43k9+b; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-80b83c2f18aso276521241.3
        for <stable@vger.kernel.org>; Thu, 13 Jun 2024 07:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718289972; x=1718894772; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rvoqFktMtHUyhGkKds1q+Wy+a/Ekxv2ikOOyTUk3yNk=;
        b=bt43k9+by8HKj5Uzz4MHnK90vf4BjbpzZ0wSEr9slMKsd6VpB9GRtQGK961Vuhwuay
         ymhGs5+8Rftyg2q6eIpyIqZEFdaH8nTlExVjUHPyjbOK1zNIv1hZeGeJaddDtjdQQLp6
         nE3TPfgaJjvMuof97I3LHzdNAV/7VGxwlXlL2CjG5ZVDYZRXlEt4/ub3D8aFakZj//YQ
         5jJP5WFHCDlNJlSttJfC4iMx73ByY9PXjgyJg8fGXMhY17RmtKvsNPQkMMUIX81RNsdK
         0oCs7ZCVgM3VEsGb3ZwfKmkUkWbYiDwE2AjcIyyD75H/cWOEycto2GfUmrZeYdQAf0DI
         uNxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718289972; x=1718894772;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rvoqFktMtHUyhGkKds1q+Wy+a/Ekxv2ikOOyTUk3yNk=;
        b=pcOGxbogkDtLFNlmJLYvNCJF524sRZiYqH7oDOTX6hlDcQXkBrQxDvQqT0cgbsePCA
         xMVkRG/J6vZgjRU0vhOpjg1TOnk4pW1z2txg/WrG69hMDyX1QZN1jZPf5qkxIzm80DT9
         xSecPeJyQASPdQ4C9zFTUnaUC1L4C3UGamhJDSpehalbh3p87vbmDSGALmSvlfXxaNKs
         R6BiBRW0dTQo8RKsoa3HHAloVQWKSFt4kq8RuOmQ8cKOKmBIsxc72ZopYdPr2qEYTuXk
         5pdxpUbFrxnB0HMvJzo2jUIDz7eBPixIcD+c2m1u8XCmmzQOREXm1mKDCxJBvPi9fta8
         txkQ==
X-Gm-Message-State: AOJu0Yy+2BTv0cOkrkCP6cswf7pG34WqnLJk6AUlFoa6sNb/1uf0hSPf
	3K93fNuw8BpylKxlDhBuhgbzekbu7MOqTLjf9/WGxq5ZxT7uZ+s5ejPPXjVe02Loxv+5vN1ugNA
	mMYhBZUIWu0RlcHScy43ZdkUNpCPwh3sN9wRe8A==
X-Google-Smtp-Source: AGHT+IH38Aaw8rZu9RWd7Y+SDv6K4CnE1Hl3fG5nWdWaMlQqDlbOxbQUuo/F9YbFyeIsxIWTnw6Q7JRYBqIgCDcz8/o=
X-Received: by 2002:a05:6122:2012:b0:4e4:ea24:4c53 with SMTP id
 71dfb90a1353d-4ee3db819e4mr70580e0c.3.1718289971414; Thu, 13 Jun 2024
 07:46:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613113223.281378087@linuxfoundation.org>
In-Reply-To: <20240613113223.281378087@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 13 Jun 2024 20:15:59 +0530
Message-ID: <CA+G9fYtEkcPasc62FH170nPyJTS83jfdAtHUfgwG+QDuQP060g@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/137] 6.6.34-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Puranjay Mohan <puranjay@kernel.org>, 
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Jun 2024 at 17:35, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.34 release.
> There are 137 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 15 Jun 2024 11:31:50 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.34-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The powerpc defconfig builds failed on stable-rc 6.6 branch due to below
build errors with gcc-13, gcc-8 and clang.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
----
arch/powerpc/net/bpf_jit_comp64.c: In function 'bpf_jit_build_body':
arch/powerpc/net/bpf_jit_comp64.c:1010:73: error: 'fimage' undeclared
(first use in this function); did you mean 'image'?
 1010 |                                 ret =
bpf_jit_emit_func_call_hlp(image, fimage, ctx, func_addr);
      |
         ^~~~~~
      |
         image
arch/powerpc/net/bpf_jit_comp64.c:1010:73: note: each undeclared
identifier is reported only once for each function it appears in


Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.32-876-g8429fc3308da/testrun/24327571/suite/build/test/gcc-13-defconfig/log

--
Linaro LKFT
https://lkft.linaro.org

