Return-Path: <stable+bounces-60357-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F45933292
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 22:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FDCF1F233D6
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 20:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3228057323;
	Tue, 16 Jul 2024 20:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a/uZbCVu"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABB423A8
	for <stable@vger.kernel.org>; Tue, 16 Jul 2024 20:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721160075; cv=none; b=gD8oTTkrlWK3EPch4vORZiJrF3UJlI55sVjufNUnJbucUUByp8jEp6xBdJIh1GkIH8u/QnVhurR+usCU9by7y07by0YzJumzfJuk8pMvV00m7XsBnkch9k/igiSkSl8sIkzqhhA4zcBldqoCik77EYQax+xZKrhPJ488KZFxPqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721160075; c=relaxed/simple;
	bh=whvliUinTfvpRULhiqxTc3170YH5GGakjEVEdN9JnaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ffJ5V3EN95v4+sSc14EGIvYHJqZR1B2bAcI1Nma+r0S+36c9QZNOqALypBmw/aqdzrB9Mv1/Y0v7IZD4y49TfUSU055cSfNgbuJxchV617j2d/pF2iP2vo+4GozRUcHM2xfT6ok2Mhe4aSHsbucc0R6Wx+zdFxe35NDV9U3jGio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a/uZbCVu; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4f2fad3fb8eso268222e0c.0
        for <stable@vger.kernel.org>; Tue, 16 Jul 2024 13:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721160072; x=1721764872; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OoruTelNDegikEEcrJjnoc1yMF1fBFSJP2+Q2GOdqdM=;
        b=a/uZbCVuFllnVgHpBaKGGDKU37K3smBP+tUA3RevArzqlDfbkCO6qbh59sb2dSOgDu
         YVPdSDlNOGQ09ZHnGHvmX7WXrWup0ZF2o5EFkiu3aPpz71sWp0Lg4Gem9TicsbOvM7l8
         N/VmRAZFs3Em/ng8J/YsJxD4D8SoSIH+BwIGFMXaGOyzrsIfdIJEUtg9IbO8wzAq6Jey
         e+z8gUJ4bCXSPeBO9yK+JHN0opVXMQYwvTLQsp9sqGTWNiJZkx9awNWCcPp3pv5w/mQj
         hA7BttMYmrFTZHqtgDkJ5GwR1ZmVRxKDQcPJWTovClQoS1o9aOIlWcJiaER/4USLQsGu
         Wang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721160072; x=1721764872;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OoruTelNDegikEEcrJjnoc1yMF1fBFSJP2+Q2GOdqdM=;
        b=sid/c+2ALyfeGRRu82vHRZGMjymarMyHu3CC0mztPLUZ6ocjspPK873h6PaYKTFmfT
         31N5ghNA1OkkKJnRtdrBV4THL2vnCAq5iw2BjhJe19wL2B57oFci2367/8zEIeB+Fv+G
         CFGV+TMuQOZUOLQwDwi+vUxX42P6wsIiV1TcsJ0Jnn3g1O/jS1kdOj7nbECQgxt2HQye
         X0TMxQvYUnqN5EufS5WJ4I2YxlcnR4uPCe22gCGg2xOfOOmRlHGIkEnNeNuaJrnNbdWa
         MtkJhRvxxFBJMW1sdDLKrXrpXxLasAvHHtal9hYT9GGkOx6lG6bU32iC/9v2jwuIKYg8
         6XbA==
X-Gm-Message-State: AOJu0YzpCIUhTFutusAld5PmOIaNiXNtjSbnyBxloDz7e50lXaGzyV6B
	dxhwbnIQrS+OWqNyCmLnJjMGhAwu2Db+YdfEmfge5q07UX4D+Lzqm4vEkG72g80tJSPSdZDNe12
	J+6AR+AfTjvkLEDauyxr12+gaNt/RjQHjIH5tRg==
X-Google-Smtp-Source: AGHT+IF68HCygtFqq/rcGOKVvFd5SgfZ2cxp60pGpeacplZON7Ei2UAeaMsu+za8s0vvKbAzkBV4Bdcaj2sB6pKofbs=
X-Received: by 2002:a05:6122:4685:b0:4ef:3a26:6eb5 with SMTP id
 71dfb90a1353d-4f4d6d4821dmr2237072e0c.0.1721160071957; Tue, 16 Jul 2024
 13:01:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716152751.312512071@linuxfoundation.org>
In-Reply-To: <20240716152751.312512071@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 17 Jul 2024 01:30:59 +0530
Message-ID: <CA+G9fYspx-bBGD6A7Z7BL8+ZxZson5os6=gVSWSry1dQE4yZVg@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/121] 6.6.41-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jul 2024 at 21:30, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.41 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 18 Jul 2024 15:27:21 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.41-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


The s390 builds failed on stable-rc 6.6 branch due to following build
warnings / errors.

This is not a new regression, this has been reported on last round of stable-rc
6.6.39-rc1 review.

* s390, build
  - clang-18-allnoconfig
  - clang-18-defconfig
  - clang-18-tinyconfig
  - clang-nightly-allnoconfig
  - clang-nightly-defconfig
  - clang-nightly-tinyconfig
  - gcc-13-allnoconfig
  - gcc-13-defconfig
  - gcc-13-tinyconfig
  - gcc-8-allnoconfig
  - gcc-8-defconfig-fe40093d
  - gcc-8-tinyconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
----------
arch/s390/include/asm/processor.h: In function '__load_psw_mask':
arch/s390/include/asm/processor.h:311:19: error: expected '=', ',',
';', 'asm' or '__attribute__' before '__uninitialized'
  311 |         psw_t psw __uninitialized;
      |                   ^~~~~~~~~~~~~~~
arch/s390/include/asm/processor.h:311:19: error: '__uninitialized'
undeclared (first use in this function)
arch/s390/include/asm/processor.h:311:19: note: each undeclared
identifier is reported only once for each function it appears in
arch/s390/include/asm/processor.h:314:9: error: 'psw' undeclared
(first use in this function); did you mean 'psw_t'?
  314 |         psw.mask = mask;
      |         ^~~
      |         psw_t


metadata:
---------
  config: https://storage.tuxsuite.com/public/linaro/lkft/builds/2jKrJxxJX8PC3B3Py92l53Th4Vf/config
  download_url:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2jKrJxxJX8PC3B3Py92l53Th4Vf/
  git_describe: v6.6.38-260-gfb57426efe05
  git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git_sha: fb57426efe05b3f2f49a914e3da34e3c9d61c69a
  git_short_log: fb57426efe05 ("Linux 6.6.41-rc1")


Steps to reproduce:
-----
# tuxmake --runtime podman --target-arch s390 --toolchain gcc-13
--kconfig tinyconfig


--
Linaro LKFT
https://lkft.linaro.org

