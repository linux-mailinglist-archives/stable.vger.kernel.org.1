Return-Path: <stable+bounces-126575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1E7A704EB
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 16:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ED16168009
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 15:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C49B25D1FA;
	Tue, 25 Mar 2025 15:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t9fFNFkt"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81572561A2
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 15:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742916175; cv=none; b=WZrZRBVHZoM45ULjBAfCTP+nUF67dbpUNESQnFhPG8OcO2to51hN80lG9VDiss05Zj/k6T+n3MNwms50LJ48jsJldzmk6H8L7EvnmyhynWnjlpE9n4HjgG8zbDuGstVE5uGfDK933PzyRYy+05rDNpApnC1Uo5LKNIqP/cLKnhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742916175; c=relaxed/simple;
	bh=vs+t2NdfqiK4z8GbA1CIrnlz9zIFlKWM1eLzsT7vTkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OPOF5xLMNB/EHy4Yy1FW3nuizHbWLSATsj19gSv3eAjkIXjr3df/b+mSVd5zu9BAO3Lu3Vnh4zI6UQ2mgEGCuE2LsB286gCU4i/XCPhIROqAnlohX0Wgz/riHu/WNQdCsRUD2EffWdmzPtOHWRGbXSv9mS0Lz0foIrs3FqPFPHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t9fFNFkt; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-524038ba657so5550755e0c.0
        for <stable@vger.kernel.org>; Tue, 25 Mar 2025 08:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742916171; x=1743520971; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FR1psq8rYb0jVgAPAumoNgxnKTwTi/S55HLEy0wx1vw=;
        b=t9fFNFktJsSi83AKlQTzXkk6PGNEFn+kAhEkyuCV0/HkEsw2osEztVG9ByM7A3JmVM
         DioQoImuLuEnZhXYQ8cRljQmzFR6zHTLut1tzx92K0In0O/ORlw6+Gncu/Wd0F/iSgVp
         W8tI8nzGw0TdOnYnZdxJN2XcLGKkNddZna654lJQjbc89a0Fck/6mh4Pe6QS4GJkHwVn
         jz07/BC0sdw/lmTODEFAGq5czvkxHops52zgioLxUEkXFiCuSKDn+yV7DO9E8/C4Bd5V
         vXylB5RvjTF1bXoe80EKzxM9GG98ltQnvIYlOPTsskvbt6lxkWBgmvr37wqP+6w5xk9B
         J3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742916171; x=1743520971;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FR1psq8rYb0jVgAPAumoNgxnKTwTi/S55HLEy0wx1vw=;
        b=lVYNz1/JVRIiGUydCb1aLoTpFoH6ilGfnu7Clyx24sp+nuWT0iivdk+tNC0kcww63m
         0jK3GYY7f0u8v9iwUUuaeqk4lWsxZKezq2UTxKSzctLiokChMIFkbebr6Vtv1j3JmTBu
         /sZd5yuR9ok9BBKu3s7EqWPUQoHY70ywvvr3jsHQZQpWAvHQzldTKthEvLj0njwEt8GZ
         NtPtkkrZFHAUCor6sCJCbMB+ZBu0/Ie2TnQ2kO+V5OZ47XAeJTadKOpMpMfbNWsXwDHY
         0a/Qq/PH8CJdGSlK4PwmwX9z4k0f0UFbWycn4xqr3Z86TnykTe+7x/M/NO+oZ7jq6R3I
         JXGA==
X-Gm-Message-State: AOJu0YwtW6p6s7K2Fgz5OIQfRSvp3WCE7TsW8krUhcSge2pJ2mi1HP57
	pRgQEKSSvo7XZ3hgf7qVoNHPSGRA02yFAMbQ4vIJMSivu+6P2Tb0qpbjxqmk9cOE5aflM6qyTsl
	f2Sw0Nuv+XAnh0sUIc946LHMsz4tDPB3zJME70w==
X-Gm-Gg: ASbGncvMFS/kcqmUCI3SI8XgxczgMAuusCGpchaWX0YRUiPPJf2yl5LO7QwZt+SDC1W
	kbS+n7blo01hUFSk12PBVaJgAhc5r+AW1ZDYFg6dgKi7hkXcy0s8swWtCkejoEIDdRA7v/uOQnU
	CK+wj4PrMi3HstMsqhSTk4usqHjdVDv23SNHT+ceuJBn8SE4pfPjp2ecMXSwwdU6A/BnWEGA==
X-Google-Smtp-Source: AGHT+IFPyQveoVq2SQJDsUBSx33+PpHB6pNXsSERn8w+t52W+nsQCR7YrtRu8eLNlWuhbuil8gCmDMnrysGjzJPJ4tM=
X-Received: by 2002:a05:6122:a24:b0:51f:a02b:45d4 with SMTP id
 71dfb90a1353d-525f0acd8a5mr202640e0c.1.1742916170612; Tue, 25 Mar 2025
 08:22:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325122156.633329074@linuxfoundation.org>
In-Reply-To: <20250325122156.633329074@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 25 Mar 2025 20:52:39 +0530
X-Gm-Features: AQ5f1Jpu_5veFnVwrvzd6ONxa6kMdH0QnKmtM7yQuJWdcSN64QgsvR2p84j7Rx0
Message-ID: <CA+G9fYss7RcH=ocag66EM4z26O-6o-gaq+Jo+GOUr2W773vQOw@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/198] 6.1.132-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dragan Simic <dsimic@manjaro.org>, Heiko Stuebner <heiko@sntech.de>, jorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Mar 2025 at 17:55, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.132 release.
> There are 198 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 27 Mar 2025 12:21:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.132-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Regressions on arm64 rk3399 dtb builds failed with gcc-13 the
stable-rc 6.1.132-rc1

First seen on the v6.1.131-199-gc8f0cb669e59
 Good: v6.1.131
 Bad: 6.1.132-rc1

* arm64, build
  - gcc-13-defconfig

Regression Analysis:
 - New regression? yes
 - Reproducibility? Yes

Build regression: arm64 dtb rockchip non-existent node or label "vcca_0v9"
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build log
arch/arm64/boot/dts/rockchip/rk3399.dtsi:221.23-266.4: ERROR
(phandle_references):
  /pcie@f8000000: Reference to non-existent node or label "vcca_0v9"

  also defined at arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi:665.8-675.3

## Source
* Kernel version: 6.1.132-rc1
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* Git sha: c8f0cb669e590c6c73c274b9fc56270ec33fa06b
* Git describe: v6.1.131-199-gc8f0cb669e59
* Project details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.131-199-gc8f0cb669e59/

## Build
* Build log: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.131-199-gc8f0cb669e59/testrun/27755718/suite/build/test/gcc-13-lkftconfig-devicetree/log
* Build history:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.131-199-gc8f0cb669e59/testrun/27755718/suite/build/test/gcc-13-lkftconfig-devicetree/history/
* Build details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.131-199-gc8f0cb669e59/testrun/27755718/suite/build/test/gcc-13-lkftconfig-devicetree/details/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2uoE2WrLPnhBvFm7ejgwd6QJxk8/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2uoE2WrLPnhBvFm7ejgwd6QJxk8/config

## Steps to reproduce
 - # tuxmake --runtime podman --target-arch arm64 --toolchain gcc-13
--kconfig defconfig

--
Linaro LKFT
https://lkft.linaro.org

