Return-Path: <stable+bounces-60367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9426933333
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 23:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBC611C223DF
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 21:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2E35C8FC;
	Tue, 16 Jul 2024 21:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gLfEyi+Z"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6075381A
	for <stable@vger.kernel.org>; Tue, 16 Jul 2024 21:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721163670; cv=none; b=LmzAuDg4GNeyYeKLFKN8cDhT2HkX7CQXSa8KRxe+Fi0da/eYxN5kGIhgi19xNBDCLcjfiqqBbBpMQSqdT4vD/NkfjwTMUInEMF+iy32Mfla2vc2/+ya9cqAqJcUgHaScpeToo2bxloJVtMXU7w57mfZTWBsI+cGZFJC+D8irXfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721163670; c=relaxed/simple;
	bh=ZhvJI5sTx3hlaxf+nVUj/uhFdYJslH/ZJYOw6nlbEVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T/fblYmtqGKn7cxQqlLD9s4FXHS0pKhb8TXL+c249paSOubTLOJVpfF0m/HheLJ6n+2aBiIOA3mndlQGOk7Q3wuK+6ityGsb8TunaPuOkakpvl/8N0uLjQe6NqXS0wx38AKpF+5QqUMjJ+FFNJnki2mIxKryt+60pI41+9/ccXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gLfEyi+Z; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a77d85f7fa3so26435966b.0
        for <stable@vger.kernel.org>; Tue, 16 Jul 2024 14:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721163667; x=1721768467; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fYlSeh/88dyiZHtXFw2OhH5nX5oaBfRET6Js1Ip/Ous=;
        b=gLfEyi+ZAcaUSNZoeaGx4EDHwdqeQCdq+/nsMj3Kdaa4Pntu4YNLsHj1aLS3vrcuFC
         rQ3cWjGJg9esj7zxU2pweD7Z+TxJpk89ub7We7xVLG7kw9VaSJss5Q9UvD2z0J4S3pMP
         v87YezsYdOKGeSO9QJSia+MONPzxDwoJ7AeEj92snlWvf1dwaePUlx1/nxDlmRkrMDhd
         uARSEjLBZYQloSDVkT2MmlLoIMTYX96hx+i+Ma/2tBWG3fV1iFoHAY+usGUOCy87Y61/
         3coV2622gjXQnlGxnHtjkXIN38rK8zhuBTGgtCrz0zPP7eh5CZ5aQA9EYntu4ad21gxE
         JE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721163667; x=1721768467;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fYlSeh/88dyiZHtXFw2OhH5nX5oaBfRET6Js1Ip/Ous=;
        b=wSm9vgrv+iW0uR2RbCEl1Q/k+dnqx8p80E+d8T3msyHmutoG4qBzK5ePuXwJjEYJAM
         gAgyFluJkpu/ZnAHBKEz/84mTzFNCrMMwCVG03awUYIr3SYJ9FZN5OYNMYaAb5Vu7qAq
         c/+IrZyzhlSeUQUfr9hkEIHruFiCx21b8G67SrEwmbNk7K9b7xtPxIA+F7fVV3LcAI7B
         mfCbbH9s64Lpan0s9+v5pbXPFq8zaTJiKm7mSCVKXEwto8Sm7mMNNLTtTRr1FQIPbnwu
         s5tOseWoWOkDrs+bx9xajRZMPbtqi7sR6IsJlz+ngT02jjssIMq3xKBp4/cKEUPjckBL
         lY8A==
X-Gm-Message-State: AOJu0Yw7A/ZwPRLiKZ8MiXVy8DiR6eAJA9g6D5cKqkDvTPNgyMKJgA1E
	yD0N9w4+ezoyfqty7cpc47sGraTN3fE+NUHNDycJqPz6xROP2lEaxAMyQmU8Li6obc78PukK7Hy
	+CHjaj7Z/PFuKzXjzKMiRIYqhOCB2BnJ1Tbhgmg==
X-Google-Smtp-Source: AGHT+IEes7lVzd1zbd+s9TAKyx+L9TnicLPt0I+L7F357KcgZRffzmyibdwIUXmFNYxp+IcOu2mtDYhIAaviAT2JQIk=
X-Received: by 2002:a17:906:231a:b0:a79:7f2e:d308 with SMTP id
 a640c23a62f3a-a79edcf457bmr328307566b.25.1721163667236; Tue, 16 Jul 2024
 14:01:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716152738.161055634@linuxfoundation.org>
In-Reply-To: <20240716152738.161055634@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 17 Jul 2024 02:30:54 +0530
Message-ID: <CA+G9fYuhFAiB_bnPpAC7sW96cyPHE3wGi+Q+=bNuXcmMzGnu=w@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/66] 4.19.318-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jul 2024 at 21:04, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.318 release.
> There are 66 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 18 Jul 2024 15:27:21 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.318-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


The 390 builds failed on 6.6, 6.1, 5.15, 5.10, 5.4 and 4.19


* s390, build
  - clang-18-allnoconfig
  - clang-18-defconfig
  - clang-18-tinyconfig
  - clang-nightly-allnoconfig
  - clang-nightly-defconfig
  - clang-nightly-tinyconfig
  - gcc-12-allnoconfig
  - gcc-12-defconfig
  - gcc-12-tinyconfig
  - gcc-8-allnoconfig
  - gcc-8-defconfig-fe40093d
  - gcc-8-tinyconfig


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
-------
arch/s390/include/asm/processor.h: In function '__load_psw_mask':
arch/s390/include/asm/processor.h:292:19: error: expected '=', ',',
';', 'asm' or '__attribute__' before '__uninitialized'
  292 |         psw_t psw __uninitialized;
      |                   ^~~~~~~~~~~~~~~
arch/s390/include/asm/processor.h:292:19: error: '__uninitialized'
undeclared (first use in this function); did you mean
'uninitialized_var'?
  292 |         psw_t psw __uninitialized;
      |                   ^~~~~~~~~~~~~~~
      |                   uninitialized_var
arch/s390/include/asm/processor.h:292:19: note: each undeclared
identifier is reported only once for each function it appears in
arch/s390/include/asm/processor.h:293:9: warning: ISO C90 forbids
mixed declarations and code [-Wdeclaration-after-statement]
  293 |         unsigned long addr;
      |         ^~~~~~~~
arch/s390/include/asm/processor.h:295:9: error: 'psw' undeclared
(first use in this function); did you mean 'psw_t'?
  295 |         psw.mask = mask;
      |         ^~~
      |         psw_t

Steps to reproduce:
----------
# tuxmake --runtime podman --target-arch s390 --toolchain gcc-12
--kconfig tinyconfig

--
Linaro LKFT
https://lkft.linaro.org

