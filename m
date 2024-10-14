Return-Path: <stable+bounces-83764-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5577499C5DA
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 11:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85FD21C22B7C
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 09:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1079D156227;
	Mon, 14 Oct 2024 09:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CO9gB51O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B441F14A4EB
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 09:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728898578; cv=none; b=e/RUNesbFbuanVckxHF/6D1x9XjIp8Ioa32N5CbWJmHmMRmBDb9+vqOp7/wvoZoYHjdXFn//CwJUYpgy66h38W2huTYxvNhiYCrnvJUtTpRaeD1rIfc+vEWni9uo7mPVRUuTRT6gJTntVxLvBP+9fZlz5ARtUOoLB+AQvLutK2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728898578; c=relaxed/simple;
	bh=X4c4DYREX/ZJZTtRi5mewGr0H7zDAmpnDr297ANrBts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXfXrgKEjAQcwcWzvYVAhJq1rW3+UEnDxHcNN9ckqXR/RIS2lqVs8yY2jLO6RA9/VKdehO1sPLdo/Vf0+4PuJjdZ6PSI8edQksDphboHp7riC+l40RvG6quiIu6KURoaFjwiPC1h6zrzrLLYIo5RiFsRTcyNzaaudIJP9TyZh4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CO9gB51O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE20DC4CEC3;
	Mon, 14 Oct 2024 09:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728898578;
	bh=X4c4DYREX/ZJZTtRi5mewGr0H7zDAmpnDr297ANrBts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CO9gB51OYDk/2TQUCW18fFb4tP8mJkHUXC4l34ovr4RDwOxKrDoxEcxopgmbEZYPu
	 +GLx20RbRLwp6XscLc727bXqgV1eoqZ6oWniDvJ9qnWzqAzsgj1H3ld/oMWJnjEM7+
	 jqVff94Hs+Im5zex+G4P1AXrdHNl+I9XIL0nSdXk=
Date: Mon, 14 Oct 2024 11:36:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jinpu Wang <jinpu.wang@ionos.com>
Cc: stable <stable@vger.kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	baolu.lu@linux.intel.com, jroedel@suse.de,
	Sasha Levin <sashal@kernel.org>, x86@kernel.org
Subject: Re: [regression]Boot Hang on Kernel 6.1.83+ with Dell PowerEdge R770
 and Intel Xeon 6710E
Message-ID: <2024101401-reawake-posture-01fd@gregkh>
References: <CAMGffE=dPofoPD_+giBnAC66-+=RqRmO2uBmC88-Ph1RgGN=0Q@mail.gmail.com>
 <2024101006-scanner-unboxed-0190@gregkh>
 <CAMGffE=HvMU4Syy7ATEevKQ+izAvndmpQ8-F9HN_WM+3PKwWyw@mail.gmail.com>
 <2024101000-duplex-justify-97e6@gregkh>
 <CAMGffE=xSDZ8Ad9o7ayg2xwnMyPDojyBDh_AHf+h7WBV7y630w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMGffE=xSDZ8Ad9o7ayg2xwnMyPDojyBDh_AHf+h7WBV7y630w@mail.gmail.com>

On Thu, Oct 10, 2024 at 12:10:49PM +0200, Jinpu Wang wrote:
> Hi Greg,
> 
> 
> On Thu, Oct 10, 2024 at 11:31 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Oct 10, 2024 at 11:13:42AM +0200, Jinpu Wang wrote:
> > > Hi Greg,
> > >
> > > On Thu, Oct 10, 2024 at 11:07 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Thu, Oct 10, 2024 at 09:31:37AM +0200, Jinpu Wang wrote:
> > > > > Hello all,
> > > > >
> > > > > We are experiencing a boot hang issue when booting kernel version
> > > > > 6.1.83+ on a Dell Inc. PowerEdge R770 equipped with an Intel Xeon
> > > > > 6710E processor. After extensive testing and use of `git bisect`, we
> > > > > have traced the issue to commit:
> > > > >
> > > > > `586e19c88a0c ("iommu/vt-d: Retrieve IOMMU perfmon capability information")`
> > > > >
> > > > > This commit appears to be part of a larger patchset, which can be found here:
> > > > > [Patchset on lore.kernel.org](https://lore.kernel.org/lkml/7c4b3e4e-1c5d-04f1-1891-84f686c94736@linux.intel.com/T/)
> > > > >
> > > > > We attempted to boot with the `intel_iommu=off` option, but the system
> > > > > hangs in the same manner. However, the system boots successfully after
> > > > > disabling `CONFIG_INTEL_IOMMU_PERF_EVENTS`.
> > > >
> > > > Is there any error messages?  Does the latest 6.6.y tree work properly?
> > > > If so, why not just use that, no new hardware should be using older
> > > > kernel trees anyway :)
> > > No error, just hang, I've removed "quiet" and added "debug".
> > > Yes, the latest 6.6.y tree works for this, but there are other
> > > problems/dependency we have to solve.
> >
> > Ok, that implies that we need to add some other patch to 6.1.y, OR we
> > can revert it from 6.1.y.  Let me know what you think is the better
> > thing to do.
> >
> I think better to revert both:
> 8c91a4bfc7f8 ("iommu: Fix compilation without CONFIG_IOMMU_INTEL")
> 586e19c88a0c ("iommu/vt-d: Retrieve IOMMU perfmon capability information")

Can you send reverts for these, or do you need us to do this for you?

thanks,

greg k-h

