Return-Path: <stable+bounces-61822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6190193CE29
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 08:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 202B9282A6D
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 06:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3C9174EFE;
	Fri, 26 Jul 2024 06:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jAQbRyzq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A052B9C4;
	Fri, 26 Jul 2024 06:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721975342; cv=none; b=GoAdH4005ETbknmnVctIENi4kqZuW+briQx4uoVy6BFw+Tvlt5aIs77ix8j4X35zHXynStoncntAMm8xowcEwzI62O4S/oML1O+FIzLoDegy6D8PTt1dAJWJaN4eJ3uARVWLqvsSgcToNX6Nex3LDjNkboQQqkJnznS9qUaEPVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721975342; c=relaxed/simple;
	bh=LPyPV3ZHGwFOuz1RQ/ueMR6hQzLC4NnAN9BDJPA0zWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJIjFw82Sb59GmP2Ocq8DTXA513ArjA6Jv6B13Em2iOaDmH0xELkR4PqzNBVe2+kaTDYJf0sHIRWe4jV6bswmf9NYESh2D331hgSgpGQcjkszBE1iOxUeewUTnhwke5TMt4QkVbOgR1BZ7qxUtc6oTtkf8UWcyMFbV1hnH8wqLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jAQbRyzq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BA8C32782;
	Fri, 26 Jul 2024 06:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721975341;
	bh=LPyPV3ZHGwFOuz1RQ/ueMR6hQzLC4NnAN9BDJPA0zWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jAQbRyzqxZ7/JQ9gXcqBDXho8P4pZrmRbMnQT5Rv9PG8avzVODX/N2nnsx+njkPi+
	 05sIfbmWv7OmksF70b/Nixe+3qo8CCZqHZJ/zb4Rr8rpr7f5rcrQnxmONqJpxOiS7c
	 4bIrxU69xLm15gNUB8DRoF9EnTymxFNGV/ThWKGo=
Date: Fri, 26 Jul 2024 08:28:58 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Ian Ray <ian.ray@gehealthcare.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 5.4 00/43] 5.4.281-rc1 review
Message-ID: <2024072647-frisbee-comma-012c@gregkh>
References: <20240725142730.471190017@linuxfoundation.org>
 <CA+G9fYsVD0Yn2WPqu3a_CYtDZ=XR4WctQLOyTdn=EoS-idDHGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYsVD0Yn2WPqu3a_CYtDZ=XR4WctQLOyTdn=EoS-idDHGg@mail.gmail.com>

On Thu, Jul 25, 2024 at 10:28:16PM +0530, Naresh Kamboju wrote:
> On Thu, 25 Jul 2024 at 20:12, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.4.281 release.
> > There are 43 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sat, 27 Jul 2024 14:27:16 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.281-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> The following build errors noticed while building arm and arm64 configs with
> toolchains gcc-12 and clang-18 on stable-rc linux-5.4.y
> 
> First seen on today builds 25-July-2024.
> 
>   GOOD: 4fb5a81f1046 ("Linux 5.4.280-rc2")
>   BAD:  13f3efb40ee1 ("Linux 5.4.281-rc1")
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Build errors:
> -------
> drivers/gpio/gpio-pca953x.c: In function 'pca953x_irq_bus_sync_unlock':
> drivers/gpio/gpio-pca953x.c:699:17: error: implicit declaration of
> function 'guard' [-Werror=implicit-function-declaration]
>   699 |                 guard(mutex)(&chip->i2c_lock);
>       |                 ^~~~~
> drivers/gpio/gpio-pca953x.c:699:23: error: 'mutex' undeclared (first
> use in this function)
>   699 |                 guard(mutex)(&chip->i2c_lock);
>       |                       ^~~~~

Now fixed for 4.19 and 5.4 trees, thanks!

greg k-h

