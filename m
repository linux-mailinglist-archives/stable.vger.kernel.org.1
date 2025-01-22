Return-Path: <stable+bounces-110172-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E90A1935B
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 15:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 360E53A45A7
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 14:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF079213E69;
	Wed, 22 Jan 2025 14:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zwJWC4wI"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F25213E6B
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 14:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737554940; cv=none; b=NKTKHT30V06xEADK3bVQReWKSaxOWoenqfx2bp/fQSB9I6s42IDcH/nGeRoVybFNJcCvodxqp8CfVVp6unLjhEDlRkuutg5r55JRYcRBhX/RfbMc/7cShaSXD1wKiujq1ADId6MKG2K/i2HDSxM3tGeSE82l0UOMEwvSnShh6b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737554940; c=relaxed/simple;
	bh=BNZe9woVKMvClgDyTngIj+nLNjMov1obNzOfpS+FjwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XHWglRnoIxNVpkq7W4hEAgEXl4R/LvFrtdqOFC5rYbuDf3t5BpC6rhpnuZtAhamhs9zbTxFBajY1goq3Mlbh3dLIftxrGnruS6xm8ZrFAQD3+JMhBznI925VR5igor5zSF7ERplBuC7E5HrgnOwOsHHmpWEZVPXMyoQK0T9fXQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zwJWC4wI; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-51c8460328dso1839036e0c.3
        for <stable@vger.kernel.org>; Wed, 22 Jan 2025 06:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737554938; x=1738159738; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lr1n+IaBijwJyddBXLLjBeruu5O2QY+sKXQxh8k1Lok=;
        b=zwJWC4wI0CZfD9jIZMqVj0yk6kDXpJF0rYbMhxhgcVWhV6mqeYEBO6x1dfG0nDol7v
         0czjiSEflAsvNrfjyy0xaogVlPCQBLh+iw9DFeH/Db/9De833WNKIBYhIg0Tbg/B2v9p
         M2hJ3GqmFjaw4Yq22kuYz6YxDPbXSMmPTVQaVZmxMQ3YLRTs09Su2k6mU3zjavT8CWz+
         Rpl72irU17at1HjK88mVP3UiiX5G8JraPaXJ5Egj/kOgpHkJVU+PZh8DksVcoTP7D1SD
         j8ICgQ37ZFrwGiqFQmXQebOuEywKuobaxwbBT6zDa3paP4+6zZeOLk5zdV02KGeL3btw
         kgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737554938; x=1738159738;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lr1n+IaBijwJyddBXLLjBeruu5O2QY+sKXQxh8k1Lok=;
        b=TZfcQvqgksY6NHNhRW4869EmZsqiwEDPY2BQa4gsN/mOVigkAVR/1W2jSy+pa0u0SC
         XfSoya0uocAHXqeATlST4y0HvZ2Dlh9fFEDNwbCveILj1DaLSuyzMI8HSCg4AhACLOZD
         DzPxcPAbx8IJw3j69rpLP2o1ZhoexciIULRWXkfS54tJ9G8td2s0IrtAjlLY+M5Ut5C7
         Sc5OUhAyKno9x6YBSSXFJc2De0aGGXj9rgfR3SVvhS2PhAOlVtLMHOhKKyS+VRish4eA
         JzUCkRsP59YcUfLZEjcQ+w49i5SFznvs01iMagqmiEJPWyLjaDLdpFs/tCC6mM9ZC1fI
         R29A==
X-Gm-Message-State: AOJu0YwC6sRJOMImbL73rtWqYQgKxxzYJIkAgv4tAQpQAErVo+Jb7QCC
	neD/MKKgokz6x++/EQM6QwWnN3UCJxPIJGHO1pBt3r3+WACzZxMT834yKNe/YI38aqDhhGikJKx
	tjKGdC+FSCytHfIn0Ux3KuSQcaoUzMXuijuTS2Q==
X-Gm-Gg: ASbGncvpJ3nHMZsWF/9LkwXSxdGc019q3RY0DgoEWC1E+ks9Y5W35rmYzZt9gOXaU39
	e0kN5oMqVuYH8FfG2IwwI/JuOo40SXdz/XIG5jiyi305NxN8MubVvHqXyuDYs5fWKOd1hQiXL6K
	iUI+X40vGLRg==
X-Google-Smtp-Source: AGHT+IGLWXwyuXaXwfJs34+xd6SLmksW1fOx6jKIpx1cgMPzurnoBpojdOddNFPnUE9Cisi5OmuhcMLx31lCfxgL008=
X-Received: by 2002:a05:6122:16a8:b0:517:4fca:86e2 with SMTP id
 71dfb90a1353d-51d5b3b081emr16121970e0c.10.1737554937647; Wed, 22 Jan 2025
 06:08:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122073830.779239943@linuxfoundation.org>
In-Reply-To: <20250122073830.779239943@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 22 Jan 2025 19:38:46 +0530
X-Gm-Features: AWEUYZmm_93N1P23_VAh3-RRUpaVrMKj5gQ3K8-rdVA_HV_VCJkQxpDVG-hIKhg
Message-ID: <CA+G9fYvacKD7aFkMCW6nwjZ4t-cpH0deLiPY-cFvGkRn5hgK3w@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/127] 5.15.177-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Jan 2025 at 13:34, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.177 release.
> There are 127 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 24 Jan 2025 07:38:04 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.177-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


The following build regressions noticed and reported last week and
found it here again on arc, arm, mips, parisc, powerpc with gcc and clang
toolchains on Linux 5.15.177-rc1 and Linux 5.15.177-rc2

Build regression: arc, arm, mips, parisc, powerpc,
drivers/usb/core/port.c struct usb_device has no member named
port_is_suspended

First seen on Linux (Linux 5.15.177-rc2)
  Good: v5.15.176
  Bad: Linux 5.15.177-rc2

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
fs/ext4/readpage.c: In function 'ext4_mpage_readpages':
fs/ext4/readpage.c:413:1: warning: the frame size of 1132 bytes is
larger than 1024 bytes [-Wframe-larger-than=]
  413 | }
      | ^
2025/01/22 08:45:53 socat-internal[1491] W waitpid(-1, {}, WNOHANG):
no child has exited
fs/mpage.c: In function 'do_mpage_readpage':
fs/mpage.c:336:1: warning: the frame size of 1092 bytes is larger than
1024 bytes [-Wframe-larger-than=]
  336 | }
      | ^
fs/mpage.c: In function '__mpage_writepage':
fs/mpage.c:672:1: warning: the frame size of 1156 bytes is larger than
1024 bytes [-Wframe-larger-than=]
  672 | }
      | ^
drivers/usb/core/port.c: In function 'usb_port_shutdown':
drivers/usb/core/port.c:299:26: error: 'struct usb_device' has no
member named 'port_is_suspended'
  299 |         if (udev && !udev->port_is_suspended) {
      |                          ^~

## Build
* kernel: 5.15.177-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: a38aec37d68a477d59deca3dad2b2108c482c033
* git describe: v5.15.176-124-ga38aec37d68a
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.176-124-ga38aec37d68a/

metadata:
---------
* Build log: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.176-124-ga38aec37d68a/testrun/26887549/suite/build/test/gcc-11-defconfig/log
* Details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.176-124-ga38aec37d68a/testrun/26887549/suite/build/test/gcc-11-defconfig/details/
* build: https://storage.tuxsuite.com/public/linaro/lkft/builds/2rydJdviHEKygtIIXuzF9SBprlr/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2rydJdviHEKygtIIXuzF9SBprlr/config
* Architecures: arc, arm, mips, parisc, powerpc
* Toolchain version: gcc-12, gcc-11, gcc-8 and clang-19

Steps to reproduce:
------
$ tuxmake --runtime podman --target-arch arm --toolchain gcc-12
--kconfig footbridge_defconfig
$ tuxmake --runtime podman --target-arch sh --toolchain gcc-11
--kconfig defconfig

--
Linaro LKFT
https://lkft.linaro.org

