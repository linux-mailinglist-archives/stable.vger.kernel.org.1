Return-Path: <stable+bounces-134528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEFAA93200
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 08:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1565C8E0E24
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 06:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E92268698;
	Fri, 18 Apr 2025 06:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OVbcsa+8"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0924B67E
	for <stable@vger.kernel.org>; Fri, 18 Apr 2025 06:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744957848; cv=none; b=DFA/w3pdsa+7GlHd4bsRSGpEWSoonBOH+jvtV+Ai6DNYIpdzDIAJIEiGTrWmLb3NF/Bu7hAYu7KkAbPopD2KbPz/IX8vWhd+PaEDUF6cWdV5MRzlcVNEmoMIUyp9hW582Tf9s5bn/BnDGBix+ImXhPnnxqYEDFzp+n1Q36yHykc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744957848; c=relaxed/simple;
	bh=vblSzRg0143xPuN4XeD6Vs9S/c2LX8BGW2kzWp+TWVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YqkqOwcYbXNWKOGqoDS9l+NzPCDs7VEUGPk9bVmmLQZzbUSfjW5vrKUtLRjoCIx8d8gPNXjSWLVUi+g3UXugG5yxzA8gg3+An80OtahcmCkUTSTXDKooOZm5HWv0vrzdRr+7QG7UMQh2MmT/mELiyw6IYhpGYta8mW8fC1uS3hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OVbcsa+8; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-86d3907524cso553093241.0
        for <stable@vger.kernel.org>; Thu, 17 Apr 2025 23:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744957845; x=1745562645; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cO+LZPGdKwCP9kW9Fu9VT4HesIxpNlVbvo5GVB8YGbA=;
        b=OVbcsa+8POgtr/7oU2pSp357AxFrO4aTLPwGJiXmaav1/sQpUEHY+vGH03jUNnuHiW
         YiOFU7FDK+zx7lcUUCsyP4hADUq80SU/wfqnlXvYOd7AYd69+wOsj7OgkPfs1D9WUrOT
         wJFqbJW8Vw1/vcSlL/YwvGxgGKC87ZjlPgOe2pdrmrN4Zvxc5S0F2r//9mQ6KxSrUjie
         L2Lxag0xNFcod34ZHp7ZLN5y4mXet0x+rBaYUKiDB7SDyx3V3Hv17CaPXpjYT3/BHVsq
         fGj2ORAZo0KVgvXocTtk14HjzIrXJwhdD21bH9Cm8drCCfsOVVtqE+z0fLArPkOEkGfD
         KzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744957845; x=1745562645;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cO+LZPGdKwCP9kW9Fu9VT4HesIxpNlVbvo5GVB8YGbA=;
        b=K8nYkmuV+LviPQh6sKAExCmkrZM1exjfFv2jbXqzr9N/AlckNkCUUC+uAMQZMSFa4U
         DF5wSsWC09E/BY/qQHUMlZvrCwf4OxI3EpWb1zrA85GFn0QTvFhl+Cz+dtpbIirDqroj
         bMx/L84x2aQG+XjZ2Sq/c5f0i8DqiiJ/t6G8o8OvOCNnj/M+kLvwbokdhKnBpEehZnV6
         e1wO38dYlcmoANL9EBbWH2nldu2f1XT/GDtDdy2ji/lOmIbwjJYXSs1Xpbz5aiT2Gcfb
         UKJPiJokazSbQyM6HvUEaM58kMOY0dvPGgrU2xYAPN0r7m9b5dGJ+LixINOAebrf3e4O
         1SpQ==
X-Gm-Message-State: AOJu0YxKeN3bSpCUva2DK6m6kqE4bvm1MvC8Z3i1fzppZdgkWX3F2pEQ
	eHqxVJusGRsZGo4pDtsXqf4J3JXBe3yPWRes0LOkrk0lcu3TwKTVw0CxG3l75oJfbE4JTUbFiY6
	GFFQwc1rGVtscN/N1WatwRLl8Js0kri3avfmV5w==
X-Gm-Gg: ASbGncuCaFglwq1FvF4kfJ/pfTZBVMNZUGH1uYu5hwCjlXge5HThjc62SWPTeu592Cm
	BPECpxXrCizRmed/uKoGhM6AACFnUmaehvRwJwp8JPYW/LQ7LyYlwAxvNxdFb03pWXVUYIYq55b
	uI12x3CxhoSZzXh5TxJnew9w3M2Uk8Z7pV55IClaE1WVHz4VIpp/NKTe2iplLTSzDs
X-Google-Smtp-Source: AGHT+IH6BG918r8UUA79PN7vIXS5dYZcYnUeACLfVZYjN9RIV6I6z90wfnR5o7Bxh+UkT+2opBqk+p0fP04vNBwseo8=
X-Received: by 2002:a67:f085:0:b0:4cb:5d6e:e6c8 with SMTP id
 ada2fe7eead31-4cb80128dcamr1118528137.9.1744957844659; Thu, 17 Apr 2025
 23:30:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417175117.964400335@linuxfoundation.org>
In-Reply-To: <20250417175117.964400335@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 18 Apr 2025 12:00:33 +0530
X-Gm-Features: ATxdqUEWtM1oKR-sQYc2k2BCDKdcFTg3l0NQ9YagooLEJvlaaYx37l9I6E6Bh2M
Message-ID: <CA+G9fYvz0kujF4NjLwwTMcejDF-7k7_nhmroZNUJTBg4H4Kz8Q@mail.gmail.com>
Subject: Re: [PATCH 6.14 000/449] 6.14.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, PCI <linux-pci@vger.kernel.org>, linux-s390@vger.kernel.org, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Niklas Schnelle <schnelle@linux.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 17 Apr 2025 at 23:23, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.14.3 release.
> There are 449 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 19 Apr 2025 17:49:48 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.14.3-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Regressions on arm64 and s390 allmodconfig and allyesconfig builds failed
on the stable rc 6.14.3-rc1 with gcc-13 and clang-20.

There are two different types of build errors on arm64 and s390.
These regressions on arm64 are also found on stable-rc 6.13 and 6.12.

First seen on the 6.14.3-rc1
 Good: v6.14.2
 Bad:  v6.14.2-450-g0e7f2bba84c1

Regressions found on arm64 s390:
  - build/gcc-13-allmodconfig
  - build/gcc-13-allyesconfig
  - build/clang-20-allmodconfig
  - build/clang-20-allyesconfig

Regression Analysis:
 - New regression? Yes
 - Reproducibility? Yes

Build regression: arm64 s390 ufs-qcom.c implicit declaration
'devm_of_qcom_ice_get'

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build log arm64
drivers/ufs/host/ufs-qcom.c: In function 'ufs_qcom_ice_init':
drivers/ufs/host/ufs-qcom.c:128:15: error: implicit declaration of
function 'devm_of_qcom_ice_get'; did you mean 'of_qcom_ice_get'?
[-Werror=implicit-function-declaration]
  128 |         ice = devm_of_qcom_ice_get(dev);
      |               ^~~~~~~~~~~~~~~~~~~~
      |               of_qcom_ice_get
drivers/ufs/host/ufs-qcom.c:128:13: error: assignment to 'struct
qcom_ice *' from 'int' makes pointer from integer without a cast
[-Werror=int-conversion]
  128 |         ice = devm_of_qcom_ice_get(dev);
      |             ^
cc1: all warnings being treated as errors

## Build log s390
arch/s390/pci/pci_fixup.c: In function 'zpci_ism_bar_no_mmap':
arch/s390/pci/pci_fixup.c:19:13: error: 'struct pci_dev' has no member
named 'non_mappable_bars'
   19 |         pdev->non_mappable_bars = 1;
      |             ^~

## Source
* Kernel version: 6.14.3-rc1
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* Git sha: 0e7f2bba84c1f492e15812fade27cc0a697f3cb6
* Git describe: v6.14.2-450-g0e7f2bba84c1
* Project details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.14.y/build/v6.14.2-450-g0e7f2bba84c1/
* Architectures: arm64, s390
* Toolchains: clang-20, gcc-13
* Kconfigs: allmodconfig, allyesconfig

## Build arm64
* Build log: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.14.y/build/v6.14.2-450-g0e7f2bba84c1/testrun/28150920/suite/build/test/gcc-13-allmodconfig/log
* Build history:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.14.y/build/v6.14.2-450-g0e7f2bba84c1/testrun/28150920/suite/build/test/gcc-13-allmodconfig/history/
* Build details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.14.y/build/v6.14.2-450-g0e7f2bba84c1/testrun/28150920/suite/build/test/gcc-13-allmodconfig/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2vrqIAiN9QWCPEV6FWrOWIRos2j/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2vrqIAiN9QWCPEV6FWrOWIRos2j/config

## Build s390
* Build log: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.14.y/build/v6.14.2-450-g0e7f2bba84c1/testrun/28148516/suite/build/test/gcc-13-allmodconfig/log
* Build history:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.14.y/build/v6.14.2-450-g0e7f2bba84c1/testrun/28148516/suite/build/test/gcc-13-allmodconfig/history/
* Build details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.14.y/build/v6.14.2-450-g0e7f2bba84c1/testrun/28148516/suite/build/test/gcc-13-allmodconfig/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2vrqI5I7Rtlnhj4xhKXAwkGJ27o/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2vrqI5I7Rtlnhj4xhKXAwkGJ27o/config

## Steps to reproduce on arm64
 - tuxmake --runtime podman --target-arch arm64 --toolchain gcc-13
--kconfig allmodconfig

## Steps to reproduce on s390
 - tuxmake --runtime podman --target-arch s390 --toolchain gcc-13
--kconfig allmodconfig

--
Linaro LKFT
https://lkft.linaro.org

