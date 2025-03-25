Return-Path: <stable+bounces-126582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF35A7068D
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 17:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CBBA3BF193
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 16:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF1025B691;
	Tue, 25 Mar 2025 16:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eCsEbvxq"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAA81F463F
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 16:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742919272; cv=none; b=qy1mB+T9TSzmiN1MrfjaxF9+C0pLo2A0FAfgTjcXqmIOGjdJKg3s7BEWykcJTFEsmrLn9uaS+kbokJn87kA8/hDpvJkx5q/yDdAXUf7RzwP6d8wS++fYHFO+6bhf1NEfGGO/EAN2oIyV/WxSYWewAYwi0xalEnLabG915sTGODg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742919272; c=relaxed/simple;
	bh=xXcB18cHItpKdRkh30guopUU49ZVJxSa+x01vlmZgrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q8bQnQnUYZK8yCtXAxaUpr1WaM8EwLO1PMdxOIZTqsj0QalnLdPtoMFYtaCKWwnIcy8yStvVU41VUcG7VWDWUZS1HBGR1W0ZNYN35tazzW/mS9VUKYkkc6JaoEZcQOo9NtNLxZuJpLDIHj0AryaDeF2PHi0brT+SMExtG6DjKXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eCsEbvxq; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-523eb86b31aso2482724e0c.0
        for <stable@vger.kernel.org>; Tue, 25 Mar 2025 09:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742919268; x=1743524068; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BaohcKTCwY8+VpwM3aapzTE/kg503pUIVGtaPhgwj1s=;
        b=eCsEbvxqlhDDAgcVZq8+D8jZNXQZH/slgMZHzpTQWIRH2cGIQfiLxpwW06MPnzAl8W
         23JuswjcTY8MksexwvkdDUjuj1EEj1CZyeT2+HigSbuRH12d9BOT/dYpQBtUFKH+croY
         d2QSXiPjRuHxzY445513xh+cBzpkN+2+bC22cs9HFuZjPK0uWfkDoH6n5NBwF4CKUcEG
         zl68ecYQG9qk4q0Ex0SmgOl2+lZ0echEoGClhNIeHq1wHYZN8ds2KYkkYjT8V9Wl2jeY
         DoqGBjz5ZEfw1ebwcbpW/dywclVBXzswnXzH8PlfN3GfZi8G5cI898puEPC8+3WXilD0
         0ypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742919268; x=1743524068;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BaohcKTCwY8+VpwM3aapzTE/kg503pUIVGtaPhgwj1s=;
        b=E2/GG9XK/pYH/OrvAUigt97JhvAKm1j0gU5Fki8S66Q8P4t6VQC6NmCf6oyn0+Ehv4
         qucsr17MqXjDL8SKwICyZDThroP+CJW1FWVtt53Lz8V8nkWSfAM+4mxlbp3VfzIYnVrd
         7yFSkZyDHbWDWwHB80Wae1TMTbW3InfOgQeEzZskMpw0C8L1XI6h06odiy5dNEhBHpU/
         0d0KDdB+k7clX46QyMBNuwShPvNyjRZCzYK/KIUUvjTPEktYgt3Bps+flVC4SFN3ohNa
         PLokfXD+sRDpYjaZ1Qcte2peLYi293SPFzZm63U8Lvx/toI7mN9J/xXFt0SKaFBnRGzh
         clOg==
X-Gm-Message-State: AOJu0YxLuRdI6z0u0Le/j8e/ZSzcsXQYV/lzlP6U0CrhqrjQeph2c+T/
	9KP87CBAR55jQ0GpFOjxGy74u0xn6J4M4RPEaf5Hqu1Tt+X3ZkF/NbtzYnce/xrTU4PJBWg36qR
	hXOeyJ3RmR+MxQmSS+iboDYi8WlY/1o6j5w3dAA==
X-Gm-Gg: ASbGnct6vNtKhWPYGnuDeGkKuXLwOQJluNLVuS68DTOuTMMJ2VNnGI6van3Nj/XBNA/
	HYbHYYgkUngfh3m2oFqtMB/CFcSRfUwLGrGxVp1RCNv/inZHIGBPVbfE9VawPS4zbeNnvrJD6wH
	gi+295gphAssmLNTuXdA4T1v3McJhImn6AU4Yi7hMkoyg/ErFO/vdmUetqODTfEGLSplHYQA==
X-Google-Smtp-Source: AGHT+IEPYTodFqcqF8Efn8cEBRGiITyGd0BPRmWJhgYjQS7JJvpdV/lixW5XnmBOn5f5Fk8rQGTqZ+ByuVXZYVxL/bQ=
X-Received: by 2002:a05:6122:6184:b0:525:aeb7:f22e with SMTP id
 71dfb90a1353d-525aeb7f2afmr7300952e0c.7.1742919268062; Tue, 25 Mar 2025
 09:14:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325122149.207086105@linuxfoundation.org>
In-Reply-To: <20250325122149.207086105@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 25 Mar 2025 21:44:15 +0530
X-Gm-Features: AQ5f1JqspNdi-6TlUeHbfzfXwOqeSMIOZd9HQXTwahnt1Erb3i0Fy8v8uY2WGpM
Message-ID: <CA+G9fYvaziw0a60idsSbDdSQLL2L+W7VnVv9VJHc-2M5p5qRfQ@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/116] 6.12.21-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Bjorn Helgaas <helgaas@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Dragan Simic <dsimic@manjaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Mar 2025 at 18:08, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.21 release.
> There are 116 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 27 Mar 2025 12:21:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.21-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Regressions on arm64 rk3399 dtb builds failed with gcc-13 the
stable-rc 6.12.21-rc1

First seen on the v6.12.19-349-g8c2b29e24438
 Good: v6.12.20
 Bad: 6.12.21-rc1

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

Anders bisected this to,
# first bad commit:
  [b3d8759e5e8530302831e24232cb360388a2d62e]
  arm64: dts: rockchip: Add missing PCIe supplies to RockPro64 board dtsi

## Source
* Kernel version: 6.12.21-rc1
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* Git sha: 8c2b29e24438f0439af527927ea2989df3a41c6f
* Git describe: v6.12.19-349-g8c2b29e24438
* Project details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12.19-349-g8c2b29e24438/

## Build
* Build log: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12.19-349-g8c2b29e24438/testrun/27759652/suite/build/test/gcc-13-lkftconfig/log
* Build history:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12.19-349-g8c2b29e24438/testrun/27759652/suite/build/test/gcc-13-lkftconfig/history/
* Build details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12.19-349-g8c2b29e24438/testrun/27759652/suite/build/test/gcc-13-lkftconfig/details/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2uoHnrrOWLw0FMCQJDU4Si0cD9n/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2uoHnrrOWLw0FMCQJDU4Si0cD9n/config

## Steps to reproduce
 - # tuxmake --runtime podman --target-arch arm64 --toolchain gcc-13
--kconfig defconfig

--
Linaro LKFT
https://lkft.linaro.org

