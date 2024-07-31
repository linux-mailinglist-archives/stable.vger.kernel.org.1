Return-Path: <stable+bounces-64736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FC8942AAC
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 11:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73E6C1C209C6
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 09:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA15B1AB50A;
	Wed, 31 Jul 2024 09:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zL+OcRKB"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E761A8C18
	for <stable@vger.kernel.org>; Wed, 31 Jul 2024 09:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722418663; cv=none; b=Kb9dsNaZoZEhYy9Oweiq3bcloQamKO/4G/hMhbGNhL7J/tNZt6grfKYyZ/7CcJVM8R/sOwmoUAEOxZt6HYKjEZ/HkYKM4VLHKDuR+yVs+wizTBZTNKR6szvgbmbmWPtfOBj0se3Zdf7PhKprvUt332tFnY6Z2AXBzrf2E8M9DK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722418663; c=relaxed/simple;
	bh=3PqYnVZVjS8Nchubqr5TZb9ZbM9gnu42tzIZibGM38k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BoVconxzBALEn2cgXyjSrUSCZBpyyHLpGZDdXn6chKDQv9uVHjmUoMfB0Bq5X4FLm1Y3ogKIx+nVdj9h2B6T+hCR6Zc7WNnST9rrgdwG4zPOIxoWtUR/cqtMYVsbDc9kbcIE+HM3kzGYFq2lYDXQSm4ASiX4G3wxz6WPIoLw1Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zL+OcRKB; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4f6c9e8e0f2so1685964e0c.3
        for <stable@vger.kernel.org>; Wed, 31 Jul 2024 02:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722418659; x=1723023459; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KUB2XfCmuTVubROS/hczkI5vuM+eVf8X/sAgSSkYLs0=;
        b=zL+OcRKBsCiyclo0+DZyLAm4X0o55M4cplNreqSoGDOPCt+E3sW8WCAH5QGD87v2Cc
         xyfbKwOhG2GaPgFxrIyUACzSpueEGGXlrMujL9MnEm4+GubW2HkXjjT//JN8YrJKjAI2
         H+4lcKIhwoX/mEFFadDknOKPbRzm2flPZaBV+3BIoBP2fVuyK/6OsmzufJj5XJYCUdJS
         X0/7IA6DNJQOADrnlpxOGD/SMjhKhBQE/ppZSXexPOIMpq68oFPT2iod5QWfPOtmFyba
         vc0eReBqbcNQXEe5smxc70+8DzX5mJ0gy/plwRmM16WeKHwLAwd4sRWiI0Nbeg9uvsOj
         L+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722418659; x=1723023459;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KUB2XfCmuTVubROS/hczkI5vuM+eVf8X/sAgSSkYLs0=;
        b=R1xOJLyDMRthx8pTbZMDBEVa2U25QeXJYdCqp50mefDngOzibz0xVZIWVm94F8QC8c
         hRSyc7Isxb38eoU2l/bMwOrnDV28ua51GcbpSpPqbRHYA/ywDKgxQZew5CXE2NI19ife
         JkpTxxnql1z/g+FBQHR8EIdwE5KWyEMnTnzObKJFyPd8qH+roAC4HxNlb5/34Ny4MxNL
         swDnxI4ec07R4I7UbqdBJy2aMZf7J2uCIAPh0bkCQGqmE5RfjJMgpWfQ0wpTeNCoaWe9
         GeDNDpBG1IF5+Dcmsv5ZPHkMzmHA7tYqUE95xJeHC8qnd7mH4y859efcTKGrhHy8LUdG
         Ilfg==
X-Gm-Message-State: AOJu0YygpMVjMYZ+YmwIcvYLOTxmTc3TxNi4/k7wsVcw+p9skaoNNWp4
	FbDL53coDl29mQCUWGt+vtSF3F/Wy+s1VRgk1FIEvT2J+DCvXBKGcjJHZx0Afab7zOnX1cBQ8gZ
	Zup5CLeNXd/W+pFYzKi9XCoLp2QHPNI5nWg7X/g==
X-Google-Smtp-Source: AGHT+IFwnHFkgq2DRdLx+mwGenItfQdCUaBvRiNx3dWS7SZyP0MZEu7BMjqAOHN1DQFd77LTqPl7sD/Jd5/SE6O03hI=
X-Received: by 2002:a05:6102:548b:b0:493:bbd7:3ec0 with SMTP id
 ada2fe7eead31-493fad0d470mr11329869137.23.1722418659376; Wed, 31 Jul 2024
 02:37:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731073151.415444841@linuxfoundation.org>
In-Reply-To: <20240731073151.415444841@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 31 Jul 2024 15:07:28 +0530
Message-ID: <CA+G9fYsGYtFhoSZbv_s=3TCSYis-pSPDJ3LJwxbtv1_9+Q61JQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/441] 6.1.103-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Thomas Richter <tmricht@linux.ibm.com>, linux-s390@vger.kernel.org, 
	Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 31 Jul 2024 at 13:34, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.103 release.
> There are 441 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 02 Aug 2024 07:30:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.103-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


On the 6.1.103-rc2 (and 6.1.103-rc1 ) s390 builds failed with gcc and
clang due to
following warnings / errors.

* s390, build
  - clang-18-defconfig
  - clang-nightly-defconfig
  - gcc-13-defconfig
  - gcc-8-defconfig-fe40093d

Build log:
--------
arch/s390/kernel/perf_cpum_cf.c: In function 'cfdiag_diffctr':
arch/s390/kernel/perf_cpum_cf.c:226:22: error: implicit declaration of
function 'cpum_cf_read_setsize'; did you mean 'cpum_cf_ctrset_size'?
[-Werror=implicit-function-declaration]
  226 |                 if (!cpum_cf_read_setsize(i))
      |                      ^~~~~~~~~~~~~~~~~~~~
      |                      cpum_cf_ctrset_size
cc1: some warnings being treated as errors

commit log:
--------
  s390/cpum_cf: Fix endless loop in CF_DIAG event stop
  [ Upstream commit e6ce1f12d777f6ee22b20e10ae6a771e7e6f44f5 ]


Metadata:
--------
  build_name: gcc-13-defconfig
  config: https://storage.tuxsuite.com/public/linaro/lkft/builds/2k0Kna66eRxxtDjqsue5mHG0j8L/config
  download_url:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2k0Kna66eRxxtDjqsue5mHG0j8L/
  git_describe: v6.1.102-442-g5ad01ec1b787
  git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git_sha: 5ad01ec1b7877a0e30c018e28e3909f96dbcef8d
  git_short_log: 5ad01ec1b787 ("Linux 6.1.103-rc2")
  compiler{'name': 's390x-linux-gnu-gcc', 'version': '13',
'version_full': 's390x-linux-gnu-gcc (Debian 13.2.0-12) 13.2.0'}

--
Linaro LKFT
https://lkft.linaro.org

