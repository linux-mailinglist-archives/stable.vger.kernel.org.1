Return-Path: <stable+bounces-20888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB9985C601
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 21:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E8B61F2396E
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 20:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CAB14A4E9;
	Tue, 20 Feb 2024 20:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UO45lfez"
X-Original-To: stable@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A5269D10
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 20:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708461740; cv=none; b=S1rZmlzGpIahIt/dhWES2b3TyIhsVmz9RHX90ZxJtDC8KmCeY4DHCsSpiqV++B3BiXKOqGkSWQMu22AnHocmU7sV63Jtp2ygY9w6CYDS3LQzsAU0J1croxjxxzaXDCka8DzjRGsaVvmdZcuTvtJ5lbc56h4GFbVMaouB3mgDmxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708461740; c=relaxed/simple;
	bh=7F2nCf/uoyDWn5H8CuLYgRZ7dg52Z2pOHSaI79KSVCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OB3HJ/5PQl4jfMgq6Uo1S8ciDngxq5qL8l8eYOS13ifT2SIV9W9hA0Zc1ih9CTAUtnM4XvI8jawCQldvxsmfljYJvH7FC4rhy7iI/TlrfTvpddblAqOsQbKSGlAYU9FR4EQ6e88qEIqmQM2cmUHpOAPL4mxSGltBP0WvFvMhegE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UO45lfez; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 20 Feb 2024 15:42:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708461736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zyW5gxuGixFDOC5s6K8CF3WVb57nUkLWLt7gksfPd0k=;
	b=UO45lfez9cnLriF6OhcD4g/qSuAcl350me4qbtTRTLBFvCVzFhVJtrneaxZVs0qKbqjbrz
	uMXmN5XaPKPqcW+0MPhYXUYWFx2dHdi7l+7kVNur8oXnxTW5kJSZatOPDqOOoq2YTObhnT
	F+EAVmuYSrgpGVObR9rwjEO2IFytLcc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: Re: fs/bcachefs/
Message-ID: <n6lgkwkp4qwohc52matpdw6bvttdoc6krrdzmbq2flcse2uchf@ctcvhkyh5dfa>
References: <g6el7eghhdk2v5osukhobvi4pige5bsfu5koqtmoyeknat36t7@irmmk7zo7edh>
 <ZaW5r5kRbOcKveVn@sashalap>
 <dlxqudswz64v6xn3fg2i6ob2msnytaatmnyhq4ivi7notzs6jf@itt42d42zmsw>
 <2024022056-monkhood-fossil-ec02@gregkh>
 <2024022007-buggy-operator-2dc5@gregkh>
 <g2jlxm6hcpywrezexi3kxrl6nu7bdmkoafa2kh2ptcf7olhofl@ycilgjsqyycq>
 <2024022022-viewless-astronaut-ab8c@gregkh>
 <3w7o757uc4pvntklwd2lmcpdxca6wcabus5co43ia2cup5qyl5@4c2fcnbh4i7r>
 <2024022011-sliding-afterglow-d30f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024022011-sliding-afterglow-d30f@gregkh>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 20, 2024 at 09:39:03PM +0100, Greg KH wrote:
> On Tue, Feb 20, 2024 at 03:22:59PM -0500, Kent Overstreet wrote:
> > On Tue, Feb 20, 2024 at 09:19:01PM +0100, Greg KH wrote:
> > > On Tue, Feb 20, 2024 at 03:06:14PM -0500, Kent Overstreet wrote:
> > > > On Tue, Feb 20, 2024 at 07:53:04PM +0100, Greg KH wrote:
> > > > > On Tue, Feb 20, 2024 at 07:03:23PM +0100, Greg KH wrote:
> > > > > > On Tue, Feb 20, 2024 at 12:23:33PM -0500, Kent Overstreet wrote:
> > > > > > > On Mon, Jan 15, 2024 at 06:03:11PM -0500, Sasha Levin wrote:
> > > > > > > > On Mon, Jan 15, 2024 at 05:12:17PM -0500, Kent Overstreet wrote:
> > > > > > > > > Hi stable team - please don't take patches for fs/bcachefs/ except from
> > > > > > > > > myself; I'll be doing backports and sending pull requests after stuff
> > > > > > > > > has been tested by my CI.
> > > > > > > > > 
> > > > > > > > > Thanks, and let me know if there's any other workflow things I should
> > > > > > > > > know about
> > > > > > > > 
> > > > > > > > Sure, we can ignore fs/bcachefs/ patches.
> > > > > > > 
> > > > > > > I see that you even acked this.
> > > > > > > 
> > > > > > > What the fuck?
> > > > > > 
> > > > > > Accidents happen, you were copied on those patches.  I'll go drop them
> > > > > > now, not a big deal.
> > > > > 
> > > > > Wait, why are you doing "Fixes:" with an empty tag in your commits like
> > > > > 1a1c93e7f814 ("bcachefs: Fix missing bch2_err_class() calls")?
> > > > > 
> > > > > That's messing with scripts and doesn't make much sense.  Please put a
> > > > > real git id in there as the documentation suggests to.
> > > > 
> > > > There isn't always a clear-cut commit when a regression was introduced
> > > > (it might not have been a regresison at all). I could dig and make
> > > > something up, but that's slowing down your workflow, and I thought I was
> > > > going to be handling all the stable backports for fs/bcachefs/, so - ?
> > > > 
> > > 
> > > Doesn't matter, please do not put "fake" tags in commit messages like
> > > this.  It hurts all of the people that parse commit logs.  Just don't
> > > put a fixes tag at all as the documentation states that after "Fixes:" a
> > > commit id belongs.
> > 
> > Then there's a gap, because I need a tag that I can stick in a commit
> > message that says "this is a bugfix I need to consider backporting
> > later", and the way you want the Fixes: tag used doesn't meet my needs.
> > 
> 
> Then use patchwork or something else, but please do not override a 15+
> year old tag for just one small portion of the kernel.
> 
> Or better yet, use the fixes: tag with the commit id you are fixing,
> that way all other kernel workflows work properly with this filesystem.
> No need to be unique here :)

And stop trying to blame this on your scripts or the fixes tag, there's
a real lack of communication there; you can't say you're going to do one
thing and then do the complete opposite.

