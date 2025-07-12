Return-Path: <stable+bounces-161702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7254B02AD4
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 14:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 198171BC8154
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 12:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AB4275B0D;
	Sat, 12 Jul 2025 12:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mfA4wt2k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1EC18859B;
	Sat, 12 Jul 2025 12:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752323853; cv=none; b=Fhig7ncE8A/LGR/RD5jLRRuCxzv9xCDK/u3/h0oEXQLBOUOTBrdFVq4Kj13lPDDqrWQoEj7mtjZHr4HzfIj0EBbvQDkgP4LGfe4JJq5edVhDVnBHamLgcxzIAbXoELdviEhyWj+FQ6QLknjXHkh5Sw4NfwdPsdVdofInL77XD54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752323853; c=relaxed/simple;
	bh=+B4pE4dPACPvrddD2Ei3j45oBk2lkONau3fiIFlOTWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUkEY+4zQFE6i0Mn6GaX/pMO1LMA8Ud0m7+7z3OEeeI4EPBPv1qk6NgLAlQd1cshP1D3ZvDo9yNxzskUg+396nC0/T2Xdobr2M9qBNWYNgd/Paf0D//4WRfNrEie+5hBWrxg7Tfdo5dusTu0CxsBeyIrBqlIA12gAKWtwpdNnCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mfA4wt2k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CDBDC4CEEF;
	Sat, 12 Jul 2025 12:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752323853;
	bh=+B4pE4dPACPvrddD2Ei3j45oBk2lkONau3fiIFlOTWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mfA4wt2kfvaw9KFDRqoWo9nY/gTI0b/+bFgWspJN38/b025K6pEt9SWN0SL4goAep
	 GNblOSw7ixQZhYR35BQPpmKumj0qkWBdyqw2mti+nXpTfjJilKmt2vpqTcX7FMx6Pd
	 bDy2X5GMhglVtsre4TYPFV7NGJwWX3yL76+friOM=
Date: Sat, 12 Jul 2025 14:37:30 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 5.15 000/411] 5.15.186-rc1 review
Message-ID: <2025071238-decency-backboard-09dd@gregkh>
References: <20250623130632.993849527@linuxfoundation.org>
 <70823da1-a24d-4694-bf8a-68ca7f85e8a3@roeck-us.net>
 <CAFBinCD8MKFbqzG2ge5PFgU74bgZVhmCwCXt+1UK8b=QDndVuw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFBinCD8MKFbqzG2ge5PFgU74bgZVhmCwCXt+1UK8b=QDndVuw@mail.gmail.com>

On Tue, Jul 08, 2025 at 06:05:14PM +0200, Martin Blumenstingl wrote:
> Hi Guenter,
> 
> On Mon, Jul 7, 2025 at 8:05 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On Mon, Jun 23, 2025 at 03:02:24PM +0200, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 5.15.186 release.
> > > There are 411 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Wed, 25 Jun 2025 13:05:51 +0000.
> > > Anything received after that time might be too late.
> > >
> > ...
> > > Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > >     drm/meson: use unsigned long long / Hz for frequency types
> > >
> >
> > This patch triggers:
> >
> > Building arm:allmodconfig ... failed
> > --------------
> > Error log:
> > drivers/gpu/drm/meson/meson_vclk.c:399:17: error: this decimal constant is unsigned only in ISO C90 [-Werror]
> >   399 |                 .pll_freq = 2970000000,
> >
> > and other similar problems. This is with gcc 13.4.0.
> Sorry to hear that this is causing issues.
> Are you only seeing this with the backport on top of 5.15 or also on
> top of mainline or -next?
> 
> If it's only for 5.15 then personally I'd be happy with just skipping
> this patch (and the ones that depend on it).

It's already merged, and I see these errors in the Android build reports
now.  I think they've just disabled the driver entirely to get around it :(

> 5.15 is scheduled to be sunset in 16 months and I am not aware of many
> people running Amlogic SoCs with mainline 5.15.

Great, can we send a "CONFIG_BROKEN" patch for this then?

thanks,

greg k-h

