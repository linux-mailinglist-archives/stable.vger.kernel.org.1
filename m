Return-Path: <stable+bounces-26754-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89134871A39
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 11:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 268A81F21887
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 10:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE0254770;
	Tue,  5 Mar 2024 10:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nTHJcUYE"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D81D53387
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 10:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709633314; cv=none; b=BiNVUDwJ/vpmpBfWGkouFhLFfHWu7DMW9hEdiN0dn2ohFz9AWDThzYhGmm1cfsU5BImdP9p+K7cmzyqBwytaxvrUUNMm5lLKwwXaR7dcE8jF38hcz5Du4EdESNqXpyiANkCCN/gCDNCznRr3OnCp0HgIy75IReFuYSal+j0SVjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709633314; c=relaxed/simple;
	bh=AAT2HVEPA3dM1HBiRM7N4VVxTR53mysqKg/WAuUxMG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S4AFz7pR0A7XQmmrAtwB+wE+8GhNyCBlY4WILGUY6qrEAjSx3FlbR3VWN/F76nJNnDsTzISs2dS06omGiLgiAtEBHfpBhsI4Xm4q34fAcoKcKaZqvnaR6QKu0aijYJVIb7Gu5HE369nV4w7COFv3yhx1MmUc6GdkWw/0Q06yTZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nTHJcUYE; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-472997f6747so738505137.1
        for <stable@vger.kernel.org>; Tue, 05 Mar 2024 02:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709633311; x=1710238111; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RcQYPt61ZswmG7Ltk4aqTMqKV2Gt5394DVr+HiHAY7c=;
        b=nTHJcUYEBWfnSRyAJZIy62yd5hv3on6QR+XkXkaJWkdioWDZ5YiUA6xi95IMG+t0En
         RH1zgvk/YQS9cqxYooymQxIl+yRBF4SzmoOJ/Fk04LGk+Ap8F23gjAYhVYO9IA2TgOMW
         peIcIpzL3aUFKRwqa/q93RxvzgoU4xqy7/VzkvtviDxt4XRdtli4fBlX8ZfKbWp3QaEf
         hVjBDIu/119X8E/iIQe1+m6kGFBZ/ngpo+r8+zqxUOjjbhy32g/YBQmxEd2CKQe5CAGe
         aX3r8haOfrPDjkqcwnuYdr3YXfOtJQy3m96hI1kY/jWxJcxjDmOpCO4EEfibWrOikP5E
         RJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709633311; x=1710238111;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RcQYPt61ZswmG7Ltk4aqTMqKV2Gt5394DVr+HiHAY7c=;
        b=FfYmqglAscxWcGnbrmuL5nwfLRSgLpoqYvzUTvz19olXis8kuR06hSttDhXj52tW9o
         YY1ywfXIZhcT3MsT1AOIeDhpetRvhGtDW+q5XB58oEx0sBjwK7BAINtgCbcWk/1IlqEE
         hugtmODN+GA9oZ9GSrPwjzcET7rLLcvQa1z31sN5Sf7OXT8kkH2V7FcgaLYrHQ890nqE
         HqN6XkyuRd2Eq9v093v9y5s+8+FPSdG8aN/Rny/XgSko52TBhBBgldTQ21VCVEoYfKjg
         oD9qkQffYkK26l+FZ4rbck7HSpfeezWKYkdM2fWUSNWeAuRR9cxgUBsBpKalAJZhfb6r
         RdDA==
X-Gm-Message-State: AOJu0YxwMJZBiH2niLTb6JLRQxM+8ZtnVkX24aChJH89eBtoZuIjrPdS
	Rou+xrHIn8BVSa5rrp3szVMHhHWGZ5Awzhjjwo/8pQOpYKX5MI4DxOb3sXNHqVIduboOeF/I/Ko
	/2ql28hhUIFd4GLl+SF/w8f6Wm8hQ063HtAY0hw==
X-Google-Smtp-Source: AGHT+IFp0tE8IoMcXWbHzzy6DSzTZLssOhqBeRslDbpiAMOBFY2vsJQqIa8loedxuKNtQwny5IBMpPE/nnJCa8ZQ8/Q=
X-Received: by 2002:a05:6102:49a:b0:472:b056:1264 with SMTP id
 n26-20020a056102049a00b00472b0561264mr1218311vsa.30.1709633311370; Tue, 05
 Mar 2024 02:08:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304211542.332206551@linuxfoundation.org>
In-Reply-To: <20240304211542.332206551@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 5 Mar 2024 15:38:20 +0530
Message-ID: <CA+G9fYvOpuVjEe_0E5bwsmP39VQwdybDEoKTZGeYC3ULtqmViQ@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/84] 5.15.151-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	Zong Li <zong.li@sifive.com>, Palmer Dabbelt <palmer@rivosinc.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Mar 2024 at 03:23, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.151 release.
> There are 84 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.151-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Following build failures noticed on riscv.

The riscv tinyconfig and allnoconfig builds on 5.15.
The riscv defconfig, tinyconfig and allnoconfig builds on 5.10.

linux.5.15.y build failures on riscv.
riscv:
  build:
    * gcc-12-tinyconfig
    * gcc-8-allnoconfig
    * clang-17-tinyconfig
    * gcc-8-tinyconfig
    * gcc-12-allnoconfig

linux.5.10.y build failures on riscv.
riscv:

  * gcc-8-defconfig
  * clang-17-allnoconfig
  * gcc-12-tinyconfig
  * gcc-8-allnoconfig
  * gcc-8-allmodconfig
  * clang-17-defconfig
  * gcc-12-defconfig
  * clang-17-tinyconfig
  * gcc-12-allmodconfig
  * gcc-8-tinyconfig
  * gcc-12-allnoconfig

 Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

arch/riscv/kernel/return_address.c:39:9: error: implicit declaration
of function 'arch_stack_walk' [-Werror=implicit-function-declaration]
   39 |         arch_stack_walk(save_return_addr, &data, current, NULL);
      |         ^~~~~~~~~~~~~~~
cc1: some warnings being treated as errors

Suspecting patch,

riscv: add CALLER_ADDRx support
commit 680341382da56bd192ebfa4e58eaf4fec2e5bca7 upstream.

steps to reproduce:
---
# tuxmake --runtime podman --target-arch riscv --toolchain gcc-12
--kconfig defconfig

Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/v5.15.149-332-ge7cbbec10c6e/testrun/22942335/suite/test/gcc-12-allnoconfig/history/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2dF68wn0dXbU2xGLRyzsxGdXTyB/

 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/v5.10.210-166-g4b0abedc88b0/testrun/22941782/suite/test/gcc-12-defconfig/details/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/v5.10.210-166-g4b0abedc88b0/testrun/22941144/suite/test/gcc-12-defconfig/history/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2dF5ke88GqtfanduGie1JGLUbVa/

--
Linaro LKFT
https://lkft.linaro.org

