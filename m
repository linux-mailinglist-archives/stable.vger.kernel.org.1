Return-Path: <stable+bounces-156158-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D83FAE4D6E
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D5B517D49E
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 19:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9591678F4F;
	Mon, 23 Jun 2025 19:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qnwn8NPo"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C782B78F51
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 19:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750706190; cv=none; b=dBt37NXxqBM3ijxx/4StPyh5Zet0ayBzTv/+qFSF0kwP3yfldd51iZ95mpPkxv/61KjY9h+Z1vjgzPibtulReKx+ga6TYBC3sblqCrj7d+cJR09YPz9HiM1N1pGOjfUEqNqH3oMQqbkj21imp5z9qXWK2haKJUsw09IZJUwFtHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750706190; c=relaxed/simple;
	bh=16ajhQv5os3Fe8HPOj3wleQOPP9qIpb/CjsQFZOKpuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WfSYNLe3TSR9aS03LT46nzZKOodOnTJuLxlqEhuRapcxS69F2bNxbKVSpepMDp574gyjMeIW2N+TK75sNrNTdFAJS0F9x8hezviwu309CG2TOGziLXSM+/USxdXMF9LV5YQdUmR/bVrFmubbuj1ij3eUHyd43xy0/JoT28Q+VVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qnwn8NPo; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-235ea292956so48721035ad.1
        for <stable@vger.kernel.org>; Mon, 23 Jun 2025 12:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750706188; x=1751310988; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wKugEmOPj2OnBJsKBHzxcLtnIp31cFhUKP6WHxuOkns=;
        b=Qnwn8NPoFcXyk12oMeBej2mq7IfP582qsjKMq4bVJwTqYJZ/vxIK3HGw5BBAJUxs6z
         hbodP54oqnMYluZJrZHSS8yMVgzZCYSqfnlW1NaTlyxW1q6YEbf7aOk3G5exaM8qwani
         zdyin7EAsxv/XmIfgHXSADE00kImy02pAVA1u62VmoPl7lOtDVoddCKwnBEmjvVX9iSt
         vI2jLevghyKeQrZlSyAOGAW6uHTzLKbQoxscMu5jQ+gOvxom4sUYcsV4ez7kL5c2jd5D
         fJ8dnQT0kk7iWZyAbIXg/e6DakJrFFQrl9IUMtgEJcdyXVtQmMtDihARG+eKIlmKtVs7
         B1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750706188; x=1751310988;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wKugEmOPj2OnBJsKBHzxcLtnIp31cFhUKP6WHxuOkns=;
        b=tRNAhdzwrXedd9GKWD26AfWKtmcVdiLDJ+A7cEFvGRHPVe0dp0BCZys7w6FlHRI+z4
         IXT0tOA27GFrKmALYAkb9czezZN5sDGjUPuCoudktJPXejqEzWDl+rJOHw2CoeGs9O7V
         R7b3H3/oGqr0+GLBlx+7eda8/msbiANFQBgbtlSCuTeApIWoC9M2OH8ZRiSvx0mB/OrR
         G39X2GMQACzcI771DWdzQ/z5XeWzEfzYR8A+Nj2ZOs5+p8JhT4UuLQAxCV4azYM8AqTC
         391rXsy73qYzt/NfvMsbniZe6Lo3OvHxfxnF8WxEGbq56wtXAa+E1aRWEJ5nLCDw4aQO
         wPPw==
X-Gm-Message-State: AOJu0YxaP1dx3SpqUFw24mtZuYfRmS+cqI7iP1SNoalOQxCgVPTgJEFx
	wd7e8ToUT+Iwdm0xKJktXab2GtEeOyA8VJjqxWUJjsOPDlJBHAm5KHzL2Z+a2E81shtrVDPOijj
	0nY5nQKTKGoDjfCnejCHBa2O8Mm5fM/UVm2qDrRMTuA==
X-Gm-Gg: ASbGncttN+xUQ0KAbjREMQF+PsLztgMRkDHVrwbElxqLwkzQSR3vQCsrqBuSnl7DeRD
	lfD05j5i2N290vYuHLZ6Jp3S+9lcKtWuJ2JjxeJwkD/jPTy9/APfKzoMLtB3JTkK8xp9ga9ldXq
	HRylbx83z9Ypz2wAAh8OWQIh+x4Es1G+/fsiB2Ml+c7Evra2I/kEIKfNXacPgay7RLktgOmHElE
	GNA
X-Google-Smtp-Source: AGHT+IGrFhsWx2APvDHc9B+I1PGJySlyZAw1hj5EW5+boxTCTPHRxriv2teURnE3JpRUpFRPlT0ckZzm8x0oUDOBFUE=
X-Received: by 2002:a17:902:e842:b0:234:b41e:37a4 with SMTP id
 d9443c01a7336-237d977534dmr170095205ad.6.1750706187876; Mon, 23 Jun 2025
 12:16:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623130611.896514667@linuxfoundation.org>
In-Reply-To: <20250623130611.896514667@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 24 Jun 2025 00:46:15 +0530
X-Gm-Features: Ac12FXz30P3_qgT_WSMm7LFk36zn-jf-1_pKeKeTrImJ1UENQPJh4UpyKNWKP7U
Message-ID: <CA+G9fYvpJjhNDS1Knh0YLeZSXawx-F4LPM-0fMrPiVkyE=yjFw@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/222] 5.4.295-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	kvmarm@lists.cs.columbia.edu, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, 
	Julien Thierry <julien.thierry.kdev@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Russell King <linux@armlinux.org.uk>, Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	Andy Gross <agross@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Jun 2025 at 18:40, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.295 release.
> There are 222 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 25 Jun 2025 13:05:50 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.295-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Regressions on arm defconfig builds with gcc-12 and clang failed on
the Linux stable-rc 5.4.295-rc1.

Regressions found on arm
* arm, build
  - clang-20-axm55xx_defconfig
  - clang-20-defconfig
  - clang-20-lkftconfig
  - clang-20-lkftconfig-no-kselftest-frag
  - clang-nightly-axm55xx_defconfig
  - clang-nightly-defconfig
  - clang-nightly-lkftconfig
  - gcc-12-axm55xx_defconfig
  - gcc-12-defconfig
  - gcc-12-lkftconfig
  - gcc-12-lkftconfig-debug
  - gcc-12-lkftconfig-kasan
  - gcc-12-lkftconfig-kunit
  - gcc-12-lkftconfig-libgpiod
  - gcc-12-lkftconfig-no-kselftest-frag
  - gcc-12-lkftconfig-perf
  - gcc-12-lkftconfig-rcutorture
  - gcc-8-axm55xx_defconfig
  - gcc-8-defconfig

Regression Analysis:
 - New regression? Yes
 - Reproducibility? Yes

Build regression: stable-rc 5.4.295-rc1 arm kvm init.S Error selected
processor does not support `eret' in ARM mode

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Build errors
arch/arm/kvm/init.S: Assembler messages:
arch/arm/kvm/init.S:109: Error: selected processor does not support
`eret' in ARM mode
arch/arm/kvm/init.S:116: Error: Banked registers are not available
with this architecture. -- `msr ELR_hyp,r1'
arch/arm/kvm/init.S:145: Error: selected processor does not support
`eret' in ARM mode
arch/arm/kvm/init.S:149: Error: selected processor does not support
`eret' in ARM mode
make[2]: *** [scripts/Makefile.build:345: arch/arm/kvm/init.o] Error 1

and
/tmp/cc0RDxs9.s: Assembler messages:
/tmp/cc0RDxs9.s:45: Error: selected processor does not support `smc
#0' in ARM mode
/tmp/cc0RDxs9.s:94: Error: selected processor does not support `smc
#0' in ARM mode
/tmp/cc0RDxs9.s:160: Error: selected processor does not support `smc
#0' in ARM mode
/tmp/cc0RDxs9.s:296: Error: selected processor does not support `smc
#0' in ARM mode
make[3]: *** [/builds/linux/scripts/Makefile.build:262:
drivers/firmware/qcom_scm-32.o] Error 1


## Source
* Kernel version: 5.4.295-rc1
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* Git sha: 7ff2d32362e444f6459597db979cab7af498cdf3
* Git describe: v5.4.294-223-g7ff2d32362e4
* Project details:
https://regressions.linaro.org/lkft/linux-stable-rc-linux-5.4.y/v5.4.294-223-g7ff2d32362e4/
* Architectures: arm
* Toolchains: gcc-13
* Kconfigs: defconfig

## Build arm
* Build log: https://qa-reports.linaro.org/api/testruns/28837192/log_file/
* Build log 2: https://qa-reports.linaro.org/api/testruns/28841756/log_file/
* Build details:
https://regressions.linaro.org/lkft/linux-stable-rc-linux-5.4.y/v5.4.294-223-g7ff2d32362e4/build/gcc-12-axm55xx_defconfig/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2yuYHH1epMqFqeFlNFUWiMeDjEz/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2yuYHH1epMqFqeFlNFUWiMeDjEz/config


--
Linaro LKFT
https://lkft.linaro.org

