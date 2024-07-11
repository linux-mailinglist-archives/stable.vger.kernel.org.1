Return-Path: <stable+bounces-59090-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6247292E3AB
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 11:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94A571C20F60
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 09:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849D115279E;
	Thu, 11 Jul 2024 09:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JRYW2FAp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F47C1509AE;
	Thu, 11 Jul 2024 09:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720691001; cv=none; b=SnTzbor7ky3FpafugWpuJv9yM0MhUbBUfNfufe0SPpw7KsZm7aTqRVOPWzgzY/qfdIMiJVmfyb6WgVGVcMnFE22Fkvs+oE9jY0J7TnhFFLLRdMgo7UAkxKPcpbWnLS++vsX4n/QdDFsGXC+YtuOAzHMzcxoTs/LNsKUyDalPHIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720691001; c=relaxed/simple;
	bh=eTZtUeszEe80uT0VU1k93cNr/HrAEFeUvPjwJ1/8QzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASf7uV76pMSLtu1pR6UDffW8s+y0v5HhpSWXTkdM8VOayzVDLlLOx39tU+C10BNCypa3eAYrR4Sg0zMcyfU+xmJXuO1B8BdOBYGLEHCX6/WeqyniUIwAqvhH2SAUoB3qv3YAzwJdyEwIA3OeACaIPBojdBQIpH2Q82v9SUy1ZZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JRYW2FAp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3F7C116B1;
	Thu, 11 Jul 2024 09:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720691000;
	bh=eTZtUeszEe80uT0VU1k93cNr/HrAEFeUvPjwJ1/8QzI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JRYW2FApIWdBMR28JnGXGzMI9VuDUkeOomwa4YNlPSDi7uPSywMWiT2/5KyyR6EW3
	 e4n+dtan5lpLLI6F2BdsEn3fBJzM7+MAbLa6k40XGv+rf7jZjorm9PzzQmsMy8JNeQ
	 O0ISjn4mpjwqrOSD/EytWu8g7cVbg9M6mZkXTUEg=
Date: Thu, 11 Jul 2024 11:43:18 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 000/102] 6.1.98-rc1 review
Message-ID: <2024071153-implicit-creole-a40b@gregkh>
References: <20240709110651.353707001@linuxfoundation.org>
 <CA+G9fYtK_CCvQ01LdANMViMpAGfY-fyh7vFwiOq7XzQw889jHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYtK_CCvQ01LdANMViMpAGfY-fyh7vFwiOq7XzQw889jHQ@mail.gmail.com>

On Wed, Jul 10, 2024 at 09:10:11PM +0530, Naresh Kamboju wrote:
> On Tue, 9 Jul 2024 at 16:59, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.1.98 release.
> > There are 102 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Thu, 11 Jul 2024 11:06:25 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.98-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> 
> Results from Linaro’s test farm.
> We have two major regressions.
> 
> 1)
> As I have reported on 6.9.9-rc1 same kernel BUG and panic noticed [1]
> while running kunit tests on all test environments [1] seen on 6.1.98-rc1.
> 
> BUG: KASAN: null-ptr-deref in _raw_spin_lock_irq+0xb0/0x17c
> 
>  [1] https://lore.kernel.org/stable/CA+G9fYsqkB4=pVZyELyj3YqUc9jXFfgNULsPk9t8q-+P1w_G6A@mail.gmail.com/
> 
> 2)
> S390 build failed due to following build errors on 6.1 and 6.6.
> Build error:
> ----
> arch/s390/include/asm/processor.h:253:11: error: expected ';' at end
> of declaration
>   253 |         psw_t psw __uninitialized;
>       |                  ^
>       |                  ;
>  [2] https://storage.tuxsuite.com/public/linaro/lkft/builds/2j0YAKrnHmvjt4fKPfYoEmSKWlG/

Thanks, I'll go drop this from 6.6 and older queues now, seems that
__unitialized doesn't work on older kernels just yet.

thanks,

greg k-h

