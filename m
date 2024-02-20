Return-Path: <stable+bounces-20890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 308D085C614
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 21:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 615FD1C20FC3
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 20:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDA314F9C6;
	Tue, 20 Feb 2024 20:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hf7MxVJi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E84A14A4E9
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 20:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708462289; cv=none; b=gUFQrfvehA7pcLrfnZscTA2YQRMjA3wAQ6lCGztbLT6CkiSMiTe9bNBWH2wpzMosV/2KT1RLegHUFoDk3pjRnu7HIqviUO7rb3HMOF2GUG3B9HvA9J9j0/yTbzWJ8vEWVPVjJHxyfp88k9aeC+FA4YGBdn2wHSKkThw4kGizmIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708462289; c=relaxed/simple;
	bh=0NX80nFK1zaQ4uKQyt/zwhB/zIB2jRrLDW9krBqVmjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gRTt9sKnJfV9Np4kY8FO1BsMVjN176ovKAVBqb0eRXBdhtnJrlLXUXOQ/JeQQDXQOurvRjpsWKg0qs56fao4yvHIPUYC7qQvR+Augm1DcfQHmI1DTYlYPu5APTOYDEEnph6ngCfjQ1ER/M5GkZbll1g5AC4hhtpnkJvTDOYNWJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hf7MxVJi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56144C433C7;
	Tue, 20 Feb 2024 20:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708462288;
	bh=0NX80nFK1zaQ4uKQyt/zwhB/zIB2jRrLDW9krBqVmjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hf7MxVJiJHWaEsrueThWuC/nunWb4UmTrR/JafubZAsNljg1fqNsFJbipBCdDchN2
	 VMy+OH6YhU977u9Ye5DLhwaHM12jzAL6LT7AeNPWr+hsvE2jH93ZViD2zH1JiketXk
	 HpoRUY1GQpW7w4dVDDw2v2hX4eHUydbEZM7A71Vw=
Date: Tue, 20 Feb 2024 21:51:20 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: Re: fs/bcachefs/
Message-ID: <2024022006-tricky-prankish-212c@gregkh>
References: <g6el7eghhdk2v5osukhobvi4pige5bsfu5koqtmoyeknat36t7@irmmk7zo7edh>
 <ZaW5r5kRbOcKveVn@sashalap>
 <dlxqudswz64v6xn3fg2i6ob2msnytaatmnyhq4ivi7notzs6jf@itt42d42zmsw>
 <2024022056-monkhood-fossil-ec02@gregkh>
 <2024022007-buggy-operator-2dc5@gregkh>
 <g2jlxm6hcpywrezexi3kxrl6nu7bdmkoafa2kh2ptcf7olhofl@ycilgjsqyycq>
 <2024022022-viewless-astronaut-ab8c@gregkh>
 <mpqwydwybzktciqsqsi4ttryazihurwfyl7ruhrxu7o64ahmoh@2xg56usfednx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mpqwydwybzktciqsqsi4ttryazihurwfyl7ruhrxu7o64ahmoh@2xg56usfednx>

On Tue, Feb 20, 2024 at 03:39:16PM -0500, Kent Overstreet wrote:
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
> So you manually repicked a subset of my pull request, and of the two
> patches you silently dropped, one was a security fix - and you _never
> communicated_ what you were doing.

I explicitly said "Not all of these applied properly, please send me the
remaining ones".  I can go back and get the message-id if you want
reciepts :)

> Greg, this isn't working. How are we going to fix this?

Please send a set of backported commits that you wish to have applied to
the stable trees.  All other subsystems do this fairly easily, it's no
different from sending a patch series out for anything else.

Worst case, I can take a git tree, BUT I will then turn that git tree
into individual commits as that is what we MUST deal with for the stable
trees, we can not work with direct pull requests for obvious reasons of
how the tree needs to be managed (i.e. rebasing all the time would never
work.)

thanks,

greg k-h

