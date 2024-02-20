Return-Path: <stable+bounces-20886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFED85C5F5
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 21:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18EE72814B8
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 20:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E71F14A4C7;
	Tue, 20 Feb 2024 20:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ucr9RGQP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F264B69DE2
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 20:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708461547; cv=none; b=Mcofpdi77X1oCmO22OA1ncDaZ7N0qD70zgaXfSmji3WI7ZQKhiSCp+lVgmwB/8QYBIBcWLNtHLSpvoxy5FyBemcWUflCvpvR4UvjId8VHxi6v//9EepMDyeEKe8Xfbals7VsQvOM9Y8Mcct5cEGvbwf2BgHvGb2ZpD/1Eu7x9bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708461547; c=relaxed/simple;
	bh=r6EFPNZIvy1b7fOxVjs7tepUwAQ70uP0aGPSVSD0guQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bla2gduoT2xfULpR+oP+cRSrCNc8uvh8bCUlIHeKr8R1gyP1WmbP7wCb2eE1uy1DRZvpdttOmWjzbZ+Llhebf2XLdzW90kZInMY93oRzixRcqd5FTbMJ+CpQXVTbkNf0WZP9zpJ2lkN4V1u0sqZxzpvGcIVB+NgGwICmx0riOQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ucr9RGQP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC2CC433F1;
	Tue, 20 Feb 2024 20:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708461546;
	bh=r6EFPNZIvy1b7fOxVjs7tepUwAQ70uP0aGPSVSD0guQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ucr9RGQP17koqlcDlxtF9FjY7RJyi/0/QIymrVFI1x5k+mtiEXW1oLTZFQrsxjp2K
	 koRHGVkS9abrEW6Ij1OGhbDpcZnL6AECkeK/mHOFTQ2EuHQx3p6k5U/cSilDo9Hj59
	 Nvx82KQSY03bgtbeh0HvNxFyHhjgRbL7Z5N2Kxuo=
Date: Tue, 20 Feb 2024 21:39:03 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: Re: fs/bcachefs/
Message-ID: <2024022011-sliding-afterglow-d30f@gregkh>
References: <g6el7eghhdk2v5osukhobvi4pige5bsfu5koqtmoyeknat36t7@irmmk7zo7edh>
 <ZaW5r5kRbOcKveVn@sashalap>
 <dlxqudswz64v6xn3fg2i6ob2msnytaatmnyhq4ivi7notzs6jf@itt42d42zmsw>
 <2024022056-monkhood-fossil-ec02@gregkh>
 <2024022007-buggy-operator-2dc5@gregkh>
 <g2jlxm6hcpywrezexi3kxrl6nu7bdmkoafa2kh2ptcf7olhofl@ycilgjsqyycq>
 <2024022022-viewless-astronaut-ab8c@gregkh>
 <3w7o757uc4pvntklwd2lmcpdxca6wcabus5co43ia2cup5qyl5@4c2fcnbh4i7r>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3w7o757uc4pvntklwd2lmcpdxca6wcabus5co43ia2cup5qyl5@4c2fcnbh4i7r>

On Tue, Feb 20, 2024 at 03:22:59PM -0500, Kent Overstreet wrote:
> On Tue, Feb 20, 2024 at 09:19:01PM +0100, Greg KH wrote:
> > On Tue, Feb 20, 2024 at 03:06:14PM -0500, Kent Overstreet wrote:
> > > On Tue, Feb 20, 2024 at 07:53:04PM +0100, Greg KH wrote:
> > > > On Tue, Feb 20, 2024 at 07:03:23PM +0100, Greg KH wrote:
> > > > > On Tue, Feb 20, 2024 at 12:23:33PM -0500, Kent Overstreet wrote:
> > > > > > On Mon, Jan 15, 2024 at 06:03:11PM -0500, Sasha Levin wrote:
> > > > > > > On Mon, Jan 15, 2024 at 05:12:17PM -0500, Kent Overstreet wrote:
> > > > > > > > Hi stable team - please don't take patches for fs/bcachefs/ except from
> > > > > > > > myself; I'll be doing backports and sending pull requests after stuff
> > > > > > > > has been tested by my CI.
> > > > > > > > 
> > > > > > > > Thanks, and let me know if there's any other workflow things I should
> > > > > > > > know about
> > > > > > > 
> > > > > > > Sure, we can ignore fs/bcachefs/ patches.
> > > > > > 
> > > > > > I see that you even acked this.
> > > > > > 
> > > > > > What the fuck?
> > > > > 
> > > > > Accidents happen, you were copied on those patches.  I'll go drop them
> > > > > now, not a big deal.
> > > > 
> > > > Wait, why are you doing "Fixes:" with an empty tag in your commits like
> > > > 1a1c93e7f814 ("bcachefs: Fix missing bch2_err_class() calls")?
> > > > 
> > > > That's messing with scripts and doesn't make much sense.  Please put a
> > > > real git id in there as the documentation suggests to.
> > > 
> > > There isn't always a clear-cut commit when a regression was introduced
> > > (it might not have been a regresison at all). I could dig and make
> > > something up, but that's slowing down your workflow, and I thought I was
> > > going to be handling all the stable backports for fs/bcachefs/, so - ?
> > > 
> > 
> > Doesn't matter, please do not put "fake" tags in commit messages like
> > this.  It hurts all of the people that parse commit logs.  Just don't
> > put a fixes tag at all as the documentation states that after "Fixes:" a
> > commit id belongs.
> 
> Then there's a gap, because I need a tag that I can stick in a commit
> message that says "this is a bugfix I need to consider backporting
> later", and the way you want the Fixes: tag used doesn't meet my needs.
> 

Then use patchwork or something else, but please do not override a 15+
year old tag for just one small portion of the kernel.

Or better yet, use the fixes: tag with the commit id you are fixing,
that way all other kernel workflows work properly with this filesystem.
No need to be unique here :)

thanks,

greg k-h

