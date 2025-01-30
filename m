Return-Path: <stable+bounces-111738-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75094A234C5
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 20:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D179D164DC7
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 19:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F391F0E45;
	Thu, 30 Jan 2025 19:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="baJpEIHb"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970A01E522
	for <stable@vger.kernel.org>; Thu, 30 Jan 2025 19:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738266136; cv=none; b=AjBlClhdEJeB7vgEGsKYF7REiwiO2newn2/97HjG+wqwGd8yDs+CO+ZEAyu/PswitfvxnmxOMGyUIZHKJzU/eFM/J8MWH0zlS0nMyCHpDjRhNCnhmeiXulIFic6Il3F2cJTvHaNJ/LofajGZ3n1gm7yoBQ5JS0mmjN+ujkxJaec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738266136; c=relaxed/simple;
	bh=zehHH8Y1Wwzx+YfhbDuyZL+H1gwEL6TAie0nbVvLEMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fNnKwUhEqRFt9NPrOAuvZiXm+i+JA0WvJoS7GoaFF5OT0LlFTMiRewr7BoEWhZsdUtMNFdmhRBw9EEpOS7sm/d2RftUl89JY3RCY+8E9N6fJpLXCTauHha/vgI48l9oK9r/qq8lx/6/MOVrLO78AAjmloBXal1HdFYeSoiay2VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=baJpEIHb; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-85c4b057596so273385241.3
        for <stable@vger.kernel.org>; Thu, 30 Jan 2025 11:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738266132; x=1738870932; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RjqHYSGSUkq0Y5wudcQHXFnXTvjYr8lKpJ37kSClfG0=;
        b=baJpEIHbsPD/MQdNSMG6DfxgebgRB0ctxK1/fqT7Nf4nX6GkmG5/GVxKAj+4OgfJKp
         h8QQdJpqZe7BG+z7m1qES919ToXk5nR1LrMoQ0DONj7fEMyyhApSqgCBhjgQUW5z/ibd
         mFGzgyXASPCwOrXRYIOf8/6ojDrUrbAotQsdZvDLpzKO4TkefyCPXp2JBi0WPc+8xfc3
         VksTfeKueOKsnT/udSGi5Zzx+CTjL4rI0CgZ0LUCyo4tHMwa0Ekyh+fg11nlXsLlTKkn
         Jq4NKhbCddBgfHWVzvQH9sjgCrWl05NuC7o7y1P2AUaCnZSINpJQ0s98cAU8Nejhl2Jl
         VV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738266132; x=1738870932;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RjqHYSGSUkq0Y5wudcQHXFnXTvjYr8lKpJ37kSClfG0=;
        b=TG9STPIdUCa5RgTJ+turW8kSkjESlZaarK0x8mvaOU6tu4lEnCO1gFjg7hBVQkUomu
         qRaKAMxyI44UC+U/riwz7sydUPq0oeCXx+rTAie7x2bB2QSoyRiMxc3SR/C5ECvPrf6U
         jqOmnZ0ecxtJVBB9knz3U6nehxFI6Dh2nocJ9bgT4cIpjD+l0D5nmkPadooTt+1xDSdy
         lVCwkBMrfikruDC4VYejoQnlGn5iZxCGdpJUdppw+FQgl8yRTScJo7mncwbxQgaFAzLf
         vO1krz2kfMCoje2VKUZ3vO/ci41ovVsyRQ6icmw/6XekMsEwylgeR/c8sGT2TR7wcBgT
         MgBA==
X-Gm-Message-State: AOJu0Yzqq8uJBproFuD4EbUqYoie3swN1xt1m5HdUPewkM9Tak/TJYBx
	zIfgxSU6aVkceNRPmYoV6uBW3aiT1qzxfKdbs243Qq/enq6b3wDlCxIL8ojKcSg5iaaXSR7JCAX
	uKR82E7Th9FRJHX9sTWXuT5XQRTW5hwR4aDvT0w==
X-Gm-Gg: ASbGncsGahzZfzzqBGHeVDRy9DF4PN7DVIdJYAb4Giyh3LLBoDyqAFnt07kI5wUxAQU
	Kiyyo34RqtP3UoH7GspiALHXrgqz0pOT/4aucDzm7pzcokIBJqZA/+CbchWNJPE4CLXwhcbcg8O
	qwl0Hdp99+9GgLE+AsajapkSp4wFQ7
X-Google-Smtp-Source: AGHT+IFD6Vvxc8sA0n3TKBPikH9o0k59Sle6GqOsO74NocpNslG2/xlUymWtQlqSxJl8oiD0U4+4dEziqRxDIGqKyxQ=
X-Received: by 2002:a05:6102:292b:b0:4b2:af6e:5fef with SMTP id
 ada2fe7eead31-4b9a4f6986emr8241190137.9.1738266132325; Thu, 30 Jan 2025
 11:42:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250130140142.491490528@linuxfoundation.org>
In-Reply-To: <20250130140142.491490528@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 31 Jan 2025 01:12:01 +0530
X-Gm-Features: AWEUYZkZA79PZ9fsrU-3OmddYVaf7TuCnzxZur-Nd2qPMPZyDfxA-jiR_FByOOE
Message-ID: <CA+G9fYsDgsJSj=WfH+5pMFJe6pLmBMAp1PiYyCbVn4Nh1Lt3pQ@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/133] 5.10.234-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 Jan 2025 at 19:52, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.234 release.
> There are 133 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 01 Feb 2025 14:01:14 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.234-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The following build regressions were noticed and reported last time
on 5.15 and found here again on arc, arm, mips, parisc, powerpc with
gcc and clang toolchains on 5.10.234-rc1 and 5.4.290-rc1.

Build regression: arc, arm, mips, parisc, powerpc,
drivers/usb/core/port.c struct usb_device has no member named
port_is_suspended

First seen on Linux (5.10.234-rc1)
  Good: v5.10.233
  Bad:  5.10.234-rc1

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
drivers/usb/core/port.c:299:26: error: 'struct usb_device' has no
member named 'port_is_suspended'
  299 |         if (udev && !udev->port_is_suspended) {
      |

metadata:
---------
* Build log: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10.233-134-gd215826da15b/testrun/27078309/suite/build/test/gcc-12-footbridge_defconfig/log
* Details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10.233-134-gd215826da15b/testrun/27078309/suite/build/test/gcc-12-footbridge_defconfig/details/
* build: https://storage.tuxsuite.com/public/linaro/lkft/builds/2sLvkKOcaJTFWGOHFpeqcAkyaIB/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2sLvkKOcaJTFWGOHFpeqcAkyaIB/config
* git_describe: v5.10.233-134-gd215826da15b
* git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git_sha: d215826da15b526aadf99923695890c777190399
* Architectures: arc, arm, mips, parisc, powerpc
* Toolchain version: gcc-12, gcc-11, gcc-8 and clang-19

Please find the email discussion
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

