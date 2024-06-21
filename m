Return-Path: <stable+bounces-54797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77875911C6D
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 09:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A89831C20DFC
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 07:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905E8168C1D;
	Fri, 21 Jun 2024 07:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YuiNfFBj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282D614038F;
	Fri, 21 Jun 2024 07:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718953747; cv=none; b=mLXG5MYF7WDl0q1SVJyByXeBP0+VJP6IYm9I/lJq/0hU98Rte4bTw+44OofLca/TDCh28vJMLD/+JnEu5xrXazLmVgOgpsKIRIJ6rGnKkGRW7iWO1ToRJ4oVswTIytjNZluVUei3KKDVYXb2gimX/SHgUEiAjgf6xvzIhjy6rxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718953747; c=relaxed/simple;
	bh=JNeSznPsu6rMM8q9i1YN4cUCJ34wg5WxXaxe2u+XauI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYGEkNJKZc0QHUQepdlBsIXSPEfEB3cTOKiTeQfxEpoUYTsHPwGX/f6Z48VqpsSf/W5KiP4AV1Q9dOw/qTyGi/Ndg+HRy+CLhLkVJCZM5PwTQc3XZd5XTFysY7+lr+0FfhKP+P+5upJoUFArZ7LcG4OiBUybphZImBDfeyfYtAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YuiNfFBj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522EBC2BBFC;
	Fri, 21 Jun 2024 07:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718953746;
	bh=JNeSznPsu6rMM8q9i1YN4cUCJ34wg5WxXaxe2u+XauI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YuiNfFBjYQZ4LWbVZN2X73hS5tUPBXHgfp6QswTqOZ2KDQNS6n7gypHuB7O9Ltu5l
	 btpKVynQuyMi1uu5NaLbZzYltuiNLZoYU/ya58uhWbgtzPeJf7s6FrsaSqhBSNKVta
	 8AB9fKEKDbvJHvK/anMsronwVvkEkcxdaDOw0rcQ=
Date: Fri, 21 Jun 2024 09:09:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: joswang <joswang1221@gmail.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Jos Wang <joswang@lenovo.com>
Subject: Re: [PATCH v7] usb: dwc3: core: Workaround for CSR read timeout
Message-ID: <2024062126-whacky-employee-74a4@gregkh>
References: <20240619114529.3441-1-joswang1221@gmail.com>
 <2024062051-washtub-sufferer-d756@gregkh>
 <CAMtoTm06MTJ_Gc4NvenycvWRxhLSaPptT1DLvBRs4RWVZO9Y_g@mail.gmail.com>
 <2024062151-professor-squeak-a4a7@gregkh>
 <20240621054239.mskjqbuhovydvmu4@synopsys.com>
 <2024062150-justify-skillet-e80e@gregkh>
 <20240621062036.2rhksldny7dzijv2@synopsys.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240621062036.2rhksldny7dzijv2@synopsys.com>

On Fri, Jun 21, 2024 at 06:20:38AM +0000, Thinh Nguyen wrote:
> On Fri, Jun 21, 2024, Greg KH wrote:
> > On Fri, Jun 21, 2024 at 05:42:42AM +0000, Thinh Nguyen wrote:
> > > On Fri, Jun 21, 2024, Greg KH wrote:
> > > > On Fri, Jun 21, 2024 at 09:40:10AM +0800, joswang wrote:
> > > > > On Fri, Jun 21, 2024 at 1:16 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > >
> > > > > > On Wed, Jun 19, 2024 at 07:45:29PM +0800, joswang wrote:
> > > > > > > From: Jos Wang <joswang@lenovo.com>
> > > > > > >
> > > > > > > This is a workaround for STAR 4846132, which only affects
> > > > > > > DWC_usb31 version2.00a operating in host mode.
> > > > > > >
> > > > > > > There is a problem in DWC_usb31 version 2.00a operating
> > > > > > > in host mode that would cause a CSR read timeout When CSR
> > > > > > > read coincides with RAM Clock Gating Entry. By disable
> > > > > > > Clock Gating, sacrificing power consumption for normal
> > > > > > > operation.
> > > > > > >
> > > > > > > Cc: stable@vger.kernel.org
> > > > > > > Signed-off-by: Jos Wang <joswang@lenovo.com>
> > > > > >
> > > > > > What commit id does this fix?  How far back should it be backported in
> > > > > > the stable releases?
> > > > > >
> > > > > > thanks,
> > > > > >
> > > > > > greg k-h
> > > > > 
> > > > > Hello Greg Thinh
> > > > > 
> > > > > It seems first begin from the commit 1e43c86d84fb ("usb: dwc3: core:
> > > > > Add DWC31 version 2.00a controller")
> > > > > in 6.8.0-rc6 branch ?
> > > > 
> > > > That commit showed up in 6.9, not 6.8.  And if so, please resend with a
> > > > proper "Fixes:" tag.
> > > > 
> > > 
> > > This patch workarounds the controller's issue.
> > 
> > So it fixes a bug?  Or does not fix a bug?  I'm confused.
> 
> The bug is not a driver's bug. The fix applies to a hardware bug and not
> any particular commit that can be referenced with a "Fixes" tag.

So it's a bug that the kernel needs to work around, that's fine.  But
that implies it should go to "all" stable kernels that it can, right?

> > > It doesn't resolve any
> > > particular commit that requires a "Fixes" tag. So, this should go on
> > > "next". It can be backported as needed.
> > 
> > Who would do the backporting and when?
> 
> For anyone who doesn't use mainline kernel that needs this patch
> backported to their kernel version.

I can not poarse this, sorry.  We can't do anything about people who
don't use our kernel trees, so what does this mean?

> > > If it's to be backported, it can
> > > probably go back to as far as v4.3, to commit 690fb3718a70 ("usb: dwc3:
> > > Support Synopsys USB 3.1 IP"). But you'd need to collect all the
> > > dependencies including the commit mention above.
> > 
> > I don't understand, sorry.  Is this just a normal "evolve the driver to
> > work better" change, or is it a "fix broken code" change, or is it
> > something else?
> > 
> > In other words, what do you want to see happen to this?  What tree(s)
> > would you want it applied to?
> > 
> 
> It's up to you, but it seems to fit "usb-testing" branch more since it
> doesn't have a "Fixes" tag. The severity of this fix is debatable since
> it doesn't apply to every DWC_usb31 configuration or every scenario.

As it is "cc: stable" that implies that it should get to Linus for
6.10-final, not wait for 6.11-rc1 as the 6.11 release is months away,
and anyone who has this issue would want it fixed sooner.

still confused,

greg k-h

