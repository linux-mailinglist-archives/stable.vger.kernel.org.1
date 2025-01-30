Return-Path: <stable+bounces-111737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A05A234BB
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 20:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9E187A1D8A
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 19:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB14B1F0E43;
	Thu, 30 Jan 2025 19:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hwkgi8AS"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54FF1EE7A7
	for <stable@vger.kernel.org>; Thu, 30 Jan 2025 19:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738265757; cv=none; b=hDHv1p10Tu3nK07fPUcHtsmql1RrXqd1VtbBSM8HdMIkZmR0aGfI5CCSJ8ybJtpwwVN7y2buZ+tDg5BfgYaOntHc7aUm+0hw2yTdwNUvqgXwoGpf8m0EQrB2QM/lxW3ikQqtXrqR+VGTAWtJv6W9c14trKwTPreCb0xXCrN1ZfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738265757; c=relaxed/simple;
	bh=tc/PDcSzixb+iXX1akNgTyMJBuee/WcKU6Flx+8L31o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IwZlODJxojVWE55qprbBPai1y2vRSOChlTEBu9vwes3uQXThIRXwXFxEXYggrdHeuTlrIi9ukUN0YsGNz4cI0KpcA9WgoFHDsDFczEzmePqIhUoJsozQvwDeCX6uEmKytsaw46z4gIEy8HYmyo8MyDUVnUpEmFjsuHUj+M55AH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hwkgi8AS; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4afeccfeda2so685155137.1
        for <stable@vger.kernel.org>; Thu, 30 Jan 2025 11:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738265753; x=1738870553; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/s8I8F9pmlrzQR5tZezmCD4RoX0HPxCcaLCSVaDRDLw=;
        b=Hwkgi8ASSxU30FBDwYpYrNozMGg0w6NHlfKWr9GuTJ7AcRuWe4cIm0xhWMUgJb2lHr
         JPk7uCdy8+1MM7GxbZ7eKM+aj97/lL1e+B+Nl744J7BjlU8ZXQdqHycE7UC4MQk/NCr4
         tEsf01gsbpoHNendHm1XJGhJpnD4ZalHmQSiHa1asn3u+mGQ0Ovy7OvyXa+QhkZAMikw
         spaxslk+se+Y6GPiGhMGGF3ZGFeCweNSpk7l4vlivj6TTt+LM6FTpV1xn3AdkAjExkvZ
         V3C5G6GYSjb84tZLL/6j46hRz/tep8g37OLapnbDHFlA3lJuukzJXwZspMay2MFl3xTE
         I1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738265753; x=1738870553;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/s8I8F9pmlrzQR5tZezmCD4RoX0HPxCcaLCSVaDRDLw=;
        b=KA69Axs1L0dyqhKOQ1NIs3HND/k9Vv4xwGedaGUezZASzpHECXn2bgNB6K21a1bDXl
         zCJyD04YaVmHm9xWvMstr/XfNibGmWyLKw0Su5NGrS4aTZe9nipsiaai57+WQdW2J/Sh
         FDzoE/3q/uil1Sa9ipVxjPlY7ehz8O3aDAZejQvv7Tetwx4uQPSH70Lw0+efvozSkaV8
         BVvMEIspAwlw43EeTDAL8CpXi6cWyCyhwbAQ3aFKV7g6/kyEZuJODTQXACyvfZWVQ6hI
         K7hFReK1THdeMJdjBG7QCszz4QCuh1xYMKXGMdWNcFd62X/kOqJNR6QIBhm9aFp3BJNV
         HIgg==
X-Gm-Message-State: AOJu0Yw9mKUpmFkJlXVGVD/oBggwmXt0AQBzA/EAyj4URMMLUpZAVHhn
	MhIjVaotq8StjvioXGxTBxVGAq9GRvh4ujNZ/mjI8EKtbtIlDwozTJj5s36FEUP7Lal/nXWvwQ2
	7mEW+qTRh5/I8okxnSH07cHOPQ3eldMLSasqQrQ==
X-Gm-Gg: ASbGncu5X1hIWiPGOiFEFIB8rxG5R/RYiRNdPntZ9XED4fjrG1u1KPR7er/EWFfJAdZ
	cSnyla4paC2gHD+AXXvLMCOcS7EQzmXKj5pFPqwB/Fb/Ow+vCyb1zVi6H8gSprRfsPa8al0CI5d
	J6udLd4I6bf1KGVvZriog9XQV+dsr4
X-Google-Smtp-Source: AGHT+IGiEPzFzPkapPW9tYKkO6D7+5pRUyuylUBuGphS/MvvFc6gbIMXzc0fsmezXugCb4QptmMQodulfJJCcyzSat4=
X-Received: by 2002:a05:6102:800e:b0:4b2:5d10:58f2 with SMTP id
 ada2fe7eead31-4b9a4fc15bdmr7858997137.14.1738265753545; Thu, 30 Jan 2025
 11:35:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250130140133.662535583@linuxfoundation.org>
In-Reply-To: <20250130140133.662535583@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 31 Jan 2025 01:05:40 +0530
X-Gm-Features: AWEUYZkm0r6LQxZqc8VnDXBKmK1_Cm3f9f2joOD8H6qqpOf194TFrPp8tavbzQE
Message-ID: <CA+G9fYsiw4GSjL7Sf51OaGM_-uWAQYaLCb14L_RC81nwoZJJzA@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/91] 5.4.290-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 Jan 2025 at 19:47, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.290 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 01 Feb 2025 14:01:13 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.290-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


The following build regressions were noticed and reported last time
on 5.15 and found here again on arc, arm, mips, parisc, powerpc with
gcc and clang toolchains on 5.4.290-rc1 and 5.10.234-rc1.

Build regression: arc, arm, mips, parisc, powerpc,
drivers/usb/core/port.c struct usb_device has no member named
port_is_suspended

First seen on Linux (5.4.290-rc1)
  Good: v5.4.289
  Bad: Linux 5.4.290-rc1 (v5.4.289-92-gd06b29df5286)

* arc:
  build:
  - gcc-9-axs103_defconfig
  - gcc-9-vdk_hs38_smp_defconfig

* arm:
  build:
  - clang-19-axm55xx_defconfig
  - clang-19-footbridge_defconfig
  - gcc-12-axm55xx_defconfig
  - gcc-12-footbridge_defconfig
  - gcc-8-axm55xx_defconfig
  - gcc-8-footbridge_defconfig

* mips:
  build:
  - gcc-12-ath79_defconfig
  - gcc-12-bcm47xx_defconfig
  - gcc-12-rt305x_defconfig
  - gcc-8-ath79_defconfig
  - gcc-8-bcm47xx_defconfig
  - gcc-8-rt305x_defconfig

* parisc:
  build:
  - gcc-11-allyesconfig
  - gcc-11-defconfig

* powerpc:
  build:
  - clang-19-ppc64e_defconfig
  - gcc-12-cell_defconfig
  - gcc-12-ppc64e_defconfig
  - gcc-8-cell_defconfig
  - gcc-8-ppc64e_defconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


Build log:
-------
drivers/usb/core/port.c:299:21: error: no member named
'port_is_suspended' in 'struct usb_device'
  299 |         if (udev && !udev->port_is_suspended) {
      |                      ~~~~  ^
1 error generated.

metadata:
---------
* Build log: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.289-92-gd06b29df5286/testrun/27079097/suite/build/test/clang-19-footbridge_defconfig/log
* Details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.289-92-gd06b29df5286/testrun/27079097/suite/build/test/clang-19-footbridge_defconfig/details/
* build: https://storage.tuxsuite.com/public/linaro/lkft/builds/2sLvp68rK3neoKGJil8eoZjIS1y/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2sLvp68rK3neoKGJil8eoZjIS1y/config
* git_describe: v5.4.289-92-gd06b29df5286
* git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git_sha: d06b29df52866ecaf06746ab6997a9ffabfd4357
* Architectures: arc, arm, mips, parisc, powerpc
* Toolchain version: gcc-12, gcc-11, gcc-8 and clang-19

Please find the lore email discussion
Link: https://lore.kernel.org/stable/eec53047-6118-4a73-9535-335babf68685@app.fastmail.com/
Link: https://lore.kernel.org/stable/CA+G9fYvacKD7aFkMCW6nwjZ4t-cpH0deLiPY-cFvGkRn5hgK3w@mail.gmail.com/

Steps to reproduce:
------
$ tuxmake --runtime podman --target-arch arm --toolchain gcc-12
--kconfig footbridge_defconfig
$ tuxmake --runtime podman --target-arch sh --toolchain gcc-11
--kconfig defconfig

--
Linaro LKFT
https://lkft.linaro.org

