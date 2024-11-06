Return-Path: <stable+bounces-91660-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2A49BF0C3
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 15:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88E281F21175
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE5C202F69;
	Wed,  6 Nov 2024 14:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E487PcQ4"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBA82022F5
	for <stable@vger.kernel.org>; Wed,  6 Nov 2024 14:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730904808; cv=none; b=QxawGR33FmDva7ZcsEklg12mnGo7KA5fEeeqCJ86oEb7t1ityNIwSYVo93raHkrExl7DzmENrgwe7ZjEFdRAGvxt0nysWKyS/QfPLMEYaAa/HUf9fmYjOOZ/WJSviUuXErg8+k5c7en+chlh7iSsMfn650KgMNciNfayCnnT3PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730904808; c=relaxed/simple;
	bh=Jsc2PoIQuQ4AsWmFF8Q6+FWTBnPxjtElzH9JCRFYzn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s7cG4EsHxC6CyAJ9dP5t3pZG5Tz4LlJFEYVJzudRtiUZuUPahyyZVndvbYHluRCJo41YlsuKx+Nq8L041ErTxXkw3gARK8WrtmoizQmzzA49fLJxGItm7F/pVEh5gyavRJqfCNfDDJfAbJ8gW2r4fDR/IaO9XPzB54RmbyLUGSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E487PcQ4; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5139cd01814so1711156e0c.0
        for <stable@vger.kernel.org>; Wed, 06 Nov 2024 06:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730904806; x=1731509606; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MI7nbg4m00fCCSnSEy5rtRmHnkUgA3x+XzaBxsgKSKs=;
        b=E487PcQ4U8vylo9j2EQSPdnMIjB+aXSgKNawQCEokHYFBVY3SVClIGdvw8IG1hcht0
         eb4MccU5UVF6VKQnqsbZyoOiIocXNFKag1dTot0NtcxLToVTFK6J93M6WnFwdYHdlg1m
         qOLE1C9Ck398f0pvxL6tqVVBb/CKY31xLOrXkCowg0tSVlVDkIegCna2JzQ/LOdP+Zju
         XWGFQkNAoW2cOGbQrLquFigktxSAQanVpVItqmrD6/LQqQSm/L+haglqGptUk2EuSwiU
         LP9IrJpi2KDPrV+EZwVBTpNkAFGKB0i5VVpjyBZcSGPAMsw8SM/JH8LbFvhII+ppS24W
         2V8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730904806; x=1731509606;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MI7nbg4m00fCCSnSEy5rtRmHnkUgA3x+XzaBxsgKSKs=;
        b=isY29zmEsfvJspiK4jiafsDD1FF9A6XY5IYP1GaPsF/Sa286OBMkxgRmtR7OiiWusp
         sjDzY6mQclj200/hCPJauUon7ADccXDUKYbSO0zwOPDdnseaw/Jopuoy+PT9Z/BQa9P+
         12eGXROihx8u60+HTjeAabRe0zMLlpZ+6yY9Q5t2fMe+BmAubv/jeZWArlSASVvMPsZq
         ml76Yt94HPYK4fb0y+jCCouXtabwGI32m5J/TqyMCChh6aq6lT24O8o8zp7fLY6xNAqQ
         NxFMPD+UTE3POuJNBH+vL0u9XssPpAp9rHissYIsgNuQ+yhToBNjPAGDBdar37YdTRri
         nx2g==
X-Gm-Message-State: AOJu0YxtpyN1+FqoYfxhwjkvRe/zI4WdfP1HsUpjreY/9BNgmf9SJbig
	R0peUoVvlIzWKefOCEIm1O0LbQ2x9EWluNwLT7V3AN5AsSwA8zyQ1DXrCjgFRbHImGQQ+EqcrKC
	qXMK9YxTMhhWKatG36QXWHt6TmNcSfKgJBmRVTA==
X-Google-Smtp-Source: AGHT+IHs9hyVIriLMV9zWsnUhtPPevFZRCt/0mF2YKsK9ex6H5hpAbYzZ/R5/cPmYMGvyjEh4T44MeVLbN7lSIGnIXQ=
X-Received: by 2002:a05:6122:a18:b0:50d:3ec1:1531 with SMTP id
 71dfb90a1353d-510150e1e84mr38180373e0c.8.1730904806042; Wed, 06 Nov 2024
 06:53:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106120331.497003148@linuxfoundation.org>
In-Reply-To: <20241106120331.497003148@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 6 Nov 2024 14:53:14 +0000
Message-ID: <CA+G9fYvqfxYX8r1rMcaiaq-K0xuVf4-pRrS77ovNMHNiA+FPkA@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/462] 5.4.285-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hagar@microsoft.com, 
	broonie@kernel.org, Wang Jianzheng <wangjianzheng@vivo.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Yangtao Li <frank.li@vivo.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Nov 2024 at 12:57, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.285 release.
> There are 462 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 08 Nov 2024 12:02:47 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.285-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The arm builds failed with gcc-8, gcc-12 on the Linux stable-rc
linux-5.4.y and linux-4.19.y.

First seen on Linux stable-rc v5.4.284-463-g21641076146f
  Good: v5.4.283-122-g10d97a96b444
  Bad:  v5.4.284-463-g21641076146f

arm:
  build:
    * gcc-8-lkftconfig
    * gcc-12-lkftconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
---------
drivers/pinctrl/mvebu/pinctrl-dove.c: In function 'dove_pinctrl_probe':
drivers/pinctrl/mvebu/pinctrl-dove.c:787:16: error: implicit
declaration of function 'devm_platform_get_and_ioremap_resource'; did
you mean 'devm_platform_ioremap_resource'?
[-Werror=implicit-function-declaration]
  787 |         base = devm_platform_get_and_ioremap_resource(pdev, 0,
&mpp_res);
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                devm_platform_ioremap_resource
drivers/pinctrl/mvebu/pinctrl-dove.c:787:14: warning: assignment to
'void *' from 'int' makes pointer from integer without a cast
[-Wint-conversion]
  787 |         base = devm_platform_get_and_ioremap_resource(pdev, 0,
&mpp_res);
      |              ^
cc1: some warnings being treated as errors


Build image:
-----------
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2oTfYomC7gxQMBPlC8XecubDfEA/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2oTfYomC7gxQMBPlC8XecubDfEA/build-debug.log
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2oTfYomC7gxQMBPlC8XecubDfEA/config
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.284-463-g21641076146f/testrun/25690547/suite/build/test/gcc-12-lkftconfig/details/

Steps to reproduce:
------------
   - tuxmake --runtime podman --target-arch arm --toolchain gcc-12
--kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2oTfYomC7gxQMBPlC8XecubDfEA/config

metadata:
----
  git describe: v5.4.284-463-g21641076146f
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git sha: 21641076146f6d3076b915009a45a9b8ac7b78fb
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2oTfYomC7gxQMBPlC8XecubDfEA/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2oTfYomC7gxQMBPlC8XecubDfEA/
  toolchain: gcc-12 and gcc-8
  config: lkftconfig
  arch: arm

--
Linaro LKFT
https://lkft.linaro.org

