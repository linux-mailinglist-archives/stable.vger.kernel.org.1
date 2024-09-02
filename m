Return-Path: <stable+bounces-72682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2889681F0
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 10:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E5DC1F22EC4
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 08:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DE4187321;
	Mon,  2 Sep 2024 08:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vuHMGKR/"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AFB186617
	for <stable@vger.kernel.org>; Mon,  2 Sep 2024 08:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725265897; cv=none; b=jX+BZz+ZNXxeLNZrFPfLyxvGANaPFCVMBMzn4+MUyu+pVw9vazHZwno7f35O3PhT7CnjNwyd8dmpPM4JLKw1b8UvSX47PorEWZTmkEfy+N89VQwdGIm20v0WP8YYdmj4T5hHRvVgg5VnuiMFQdH+Zhg0N51NqHDoz7hGs5EI+to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725265897; c=relaxed/simple;
	bh=1T3KMgmpMiNvt7U5PmEWel2ne3m++jS4I22mN2SjCgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bK4b4+iSGIfq83ASK0HJSUzgb2j4p2BD93kB6hz0FeekLBEK/pLeBYtc1eL068EivC72Wc73HqAfn8E4pz1XCqrJTg64lc4fUcqv1DJ12cesI+uR3raGXfWLrLWaCazzj8ya6HAgXxuAZ7GZZrtIyFXZci5hmGJZuRim0mZfGHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vuHMGKR/; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-846b564c141so659267241.1
        for <stable@vger.kernel.org>; Mon, 02 Sep 2024 01:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725265894; x=1725870694; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lRVjabj0djVdwpLCoyxrLONDr/903wyzboPgOhDWvWA=;
        b=vuHMGKR/g28cdoFh6LlS2ckh5YcMdmL5x9deKkOjEp8yvjhVTURRK7PkrAutOUl0fu
         hSROFcLwkjDVKiRYTZiv9vt7XDexQyr28kZyXAOIqXfFE5AQvpZlfGEXmAxu91L1++Cg
         whQS11wl7B1jzIqGxjB6cxcnDkxteQ9i+r8oAvZq6Z9Fv8JM/2JYk0uE7e8O2eoj6b7W
         v39+emr6pNpZNvwkBjfJkA8p0mzAsqtTBHH3Rvji3SHKygrsSRjRkQa3cc1tVqTPcJ03
         aUmdvN4suP3bJkZ1sXfmozObmUm+vHF+2orZp8fx5+8PY6AnWzFE9OJTdsJIHgMo/DHw
         yayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725265894; x=1725870694;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lRVjabj0djVdwpLCoyxrLONDr/903wyzboPgOhDWvWA=;
        b=JYYX2m/df/99wFFQvTnX/lbcLC0Ij4k4H9O1rlAdnOz63iR/9QRRNsu8AgaxXaAbIy
         qDFeFwPATNsf5Xes4Cbr7ndXzktwQ7Jv3XyZuwxXwNXykeBK8a1z/fNDP/ylhyDx4pxv
         vr04U/OFoD3cIu+q+DsqNED93vtUD5qO5nSKCidoZCh2coKiG8JUNkFXNfeBVZowqu8J
         8Gz4KOr+O5vzOI8ehvr5+z0pMGYJYi0stDzPUSDMOowyY17OTeGT8nR5mHzbJbM2aL50
         7dVJ7Wo8hR9hPTCoWI6huwdC+auC5LFh44NgddFUkX/N9MnK6cH6RSgTqxuboY0s0ice
         Xf9Q==
X-Gm-Message-State: AOJu0YzAvbzUKkgPhb9O6UHm6qQrZMwT1SpxwnyNvb9zFz4/uC9cC7jR
	Wq6p5+yVIm1dM5msfOmDcWNeVDhXSnRqlvJdPVkB7kh9d57lETfaT9ZaESZ1gI6VxkCfuZ2dja6
	nS2HgzcaT7xlmCHoJ9mraP7h+cwTpENimGqUQ4Q==
X-Google-Smtp-Source: AGHT+IEjGqgt+OkXRBwK2EUIYkL4nUoOA9bh176nKVLStq/plhobmmkx91skPtvLHDCGrmSXQXFS2j0XKRu5RUgB1NY=
X-Received: by 2002:a05:6102:3f45:b0:48f:e09e:ef60 with SMTP id
 ada2fe7eead31-49a5b1690e7mr12210882137.29.1725265894238; Mon, 02 Sep 2024
 01:31:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240901160823.230213148@linuxfoundation.org>
In-Reply-To: <20240901160823.230213148@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 2 Sep 2024 14:01:22 +0530
Message-ID: <CA+G9fYu3+16JcZbAJY0SXoqnMDOMXr8S136Zb4ONh7WpD-5-Hw@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/215] 5.15.166-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, abdulrasaqolawani@gmail.com, Helge Deller <deller@gmx.de>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 1 Sept 2024 at 22:29, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.166 release.
> There are 215 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 03 Sep 2024 16:07:34 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.166-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The Powerpc defconfig builds failed on Linux stable-rc due to following
build warnings / errors with clang-18 and gcc-12.

This is a same problem on current stable-rc review on
   - 5.4.283-rc1 review
   - 5.10.225-rc1 review
   - 5.15.166-rc1 review

In the case of stable-rc linux-5.15.y

first seen on 36422b23d6d0243e79a6ddc085f8301454ea5291.
  Good: v5.15.164-480-g2a66d0cb3772
  BAD:  v5.15.165-216-g36422b23d6d0

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Anders bisected this to first bad commit id as,
  fbdev: offb: replace of_node_put with __free(device_node)
  [ Upstream commit ce4a7ae84a58b9f33aae8d6c769b3c94f3d5ce76 ]

build log:
--------
drivers/video/fbdev/offb.c:357:32: error: expected ';' at end of declaration
  357 |                 struct device_node *pciparent
__free(device_node) = of_get_parent(dp);
      |                                              ^
      |                                              ;
1 error generated.

Build Log links,
--------
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.165-216-g36422b23d6d0/testrun/25000678/suite/build/test/clang-18-defconfig/log

Build failed comparison:
----------
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.165-216-g36422b23d6d0/testrun/25000678/suite/build/test/clang-18-defconfig/history/

metadata:
----
  git describe: v5.15.165-216-g36422b23d6d0
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git sha: 36422b23d6d0243e79a6ddc085f8301454ea5291
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2lTijUAVRaXda7PSrBQgP98ffqd/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2lTijUAVRaXda7PSrBQgP98ffqd/
  toolchain: clang-18 and gcc-12
  config: defconfig
  arch: powerpc

Steps to reproduce:
---------
 - # tuxmake --runtime podman --target-arch powerpc --toolchain
clang-18 --kconfig defconfig LLVM=1 LLVM_IAS=0
LD=powerpc64le-linux-gnu-ld

--
Linaro LKFT
https://lkft.linaro.org

