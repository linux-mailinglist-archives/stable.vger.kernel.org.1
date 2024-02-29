Return-Path: <stable+bounces-25606-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EF186D3C4
	for <lists+stable@lfdr.de>; Thu, 29 Feb 2024 20:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7911B1F23D87
	for <lists+stable@lfdr.de>; Thu, 29 Feb 2024 19:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6074E13F44E;
	Thu, 29 Feb 2024 19:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XikPLy5N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E684C13C9F0;
	Thu, 29 Feb 2024 19:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709236450; cv=none; b=bN6NbpkA8wsHhGm1GJGzh97Co0JIhIjqvyfSaUyLECWDAunkNa0XueaL9g7kFbBjNoh5TJgIKwgkrCCB3dYUyC49TTdngYc9jKu8vO6iSbRW0u4uyYRBKvn/X0O6UYTZZPYv4Qj5we4qwiExb0ZMDRxmIYU/p0QaI+Bj9Ppxnz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709236450; c=relaxed/simple;
	bh=zWQt1iQ4/+xGXNV8nMzVwEapO4EgGz7oXUPhT66Bbso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbQwuZLIHaCK6SZ89t5GGNlW2SC5+M3uAGwfjb2H2fTvHTsrUTg/r0C5MAcUK9ldVB5y+1UgOeWGt1umeUODBmKH1Kr739u1EgE+4U0AEFozGvxYfBs6pdRwkFUFeQ2tLsBAn02kdFpPr3077HiDX52puubNgcZdFn0DKq+dbhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XikPLy5N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9EBEC433C7;
	Thu, 29 Feb 2024 19:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709236449;
	bh=zWQt1iQ4/+xGXNV8nMzVwEapO4EgGz7oXUPhT66Bbso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XikPLy5N4w7KUwQ5Ux1ncrrvWUuorVCkIAiQLMmsrfZ4vQdP0llWj9glBu0CBlUNy
	 5birv+2EM4Yk3qgb0Oym/CTF8spTo+1hvplKkwbQPqtRhHAUNB0GhrzT7WXBdQtvfQ
	 Tgu4h75hgkDQ6UvqP+O/Vt17wsLs1quz14TonNxo=
Date: Thu, 29 Feb 2024 20:54:06 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, paul@crapouillou.net
Subject: Re: [PATCH 5.15 000/245] 5.15.150-rc1 review
Message-ID: <2024022905-skinny-making-7852@gregkh>
References: <20240227131615.098467438@linuxfoundation.org>
 <ac2c579e-4ff0-42e2-ab70-efb8ded2d257@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac2c579e-4ff0-42e2-ab70-efb8ded2d257@linaro.org>

On Tue, Feb 27, 2024 at 12:56:32PM -0600, Daniel D�az wrote:
> Hello!
> 
> On 27/02/24 7:23 a.�m., Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.15.150 release.
> > There are 245 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.150-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> We're seeing build regressions here with RISC-V, with GCC 8, GCC 12, and Clang 17:
> 
> -----8<-----
>   In file included from /builds/linux/include/linux/list.h:9,
>                    from /builds/linux/include/linux/module.h:12,
>                    from /builds/linux/drivers/net/ethernet/realtek/r8169_main.c:12:
>   /builds/linux/drivers/net/ethernet/realtek/r8169_main.c:5512:35: error: 'rtl8169_pm_ops' undeclared here (not in a function); did you mean 'rtl8169_poll'?
>    5512 |         .driver.pm      = pm_ptr(&rtl8169_pm_ops),
>         |                                   ^~~~~~~~~~~~~~
>   /builds/linux/include/linux/kernel.h:46:44: note: in definition of macro 'PTR_IF'
>      46 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
>         |                                            ^~~
>   /builds/linux/drivers/net/ethernet/realtek/r8169_main.c:5512:27: note: in expansion of macro 'pm_ptr'
>    5512 |         .driver.pm      = pm_ptr(&rtl8169_pm_ops),
>         |                           ^~~~~~
>   make[5]: *** [/builds/linux/scripts/Makefile.build:289: drivers/net/ethernet/realtek/r8169_main.o] Error 1
> ----->8-----
> 
> Bisection points to:
> 
>   commit ac2871f646a8f556203f5b6be875ce406d855ddb
>   Author: Paul Cercueil <paul@crapouillou.net>
>   Date:   Tue Dec 7 00:20:59 2021 +0000
>       PM: core: Redefine pm_ptr() macro
>       [ Upstream commit c06ef740d401d0f4ab188882bf6f8d9cf0f75eaf ]
> 
> A revert could not be done cleanly.
> 
> Tuxmake reproducer:
> 
>   tuxmake --runtime podman --target-arch riscv --toolchain gcc-12 --kconfig defconfig
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

I've been beating on this for a while and I really don't know what is
happening, sorry.  The driver looks fine, something is "odd" with riscv
here that is not "odd" with other arches.

I'll leave this as-is for now and hopefully someone who relies on riscv
can help track it down.

thanks,

greg k-h

