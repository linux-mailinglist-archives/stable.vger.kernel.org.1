Return-Path: <stable+bounces-20933-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2A385C661
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 22:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC2392836EE
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 21:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220A314C585;
	Tue, 20 Feb 2024 21:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="brN64fUF"
X-Original-To: stable@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B46C14AD15
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 21:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708462826; cv=none; b=AKEI5eu+e1yXg4LDfDesYRbNj1spEHF70juqh1l6c6n2cfXZPo6zhtPcezc+VfiUzxuhdJXsCUJCkPUZ1DBwn6uBOXGhQXTUOXOmMwv6xlp5F+lOAZt6NwrVhvEZCDU71RagvoB1FNFN/Xti43zW/qibQpfX6sqBRNqCTkJ4yKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708462826; c=relaxed/simple;
	bh=cwoNYqSYOYttuttBAOBjicIw7kJ9/YRcq46xVwi+1C8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7rSmkwJOQvbs2AYl55O3dKgq/fDloUZMKMtveUgQf6ssuPmfidrFNHr1JB2TcOB/dt3D2+DsWiexmCm7Sq0lw1bGE7hWIST3fTAYqhT/9ET1fti9nQT5jahCYtL3p938mNUGC5riGnBwH40198sXuuJ9udl7CK8hku1B+D9BsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=brN64fUF; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 20 Feb 2024 16:00:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708462822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OngdcmO3PkxeAq3QE32mSrXrxXcw9VAOUxvVoF10f2c=;
	b=brN64fUFjiORO9TFJpZDK/8z8X8Z4qEQgqRb+deWaqzN9l4O9RUlaj8Nu9tp2PtVr+pVJY
	O9Ty5mimNrIk+3+NlLRcl2aB/BtSr29SsaT7G+mhYf/GXrBvJk2UsPYN0UZhkEI7caf1Dd
	Q0LTCfCKCjK4YmqBZ2ZAkSZnXXMvqiY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: Re: fs/bcachefs/
Message-ID: <uknxc26o6td7g6rawxffvsez46djmvcy2532kza2zyjuj33k7p@4jdywourgtqg>
References: <g6el7eghhdk2v5osukhobvi4pige5bsfu5koqtmoyeknat36t7@irmmk7zo7edh>
 <ZaW5r5kRbOcKveVn@sashalap>
 <dlxqudswz64v6xn3fg2i6ob2msnytaatmnyhq4ivi7notzs6jf@itt42d42zmsw>
 <2024022056-monkhood-fossil-ec02@gregkh>
 <2024022007-buggy-operator-2dc5@gregkh>
 <g2jlxm6hcpywrezexi3kxrl6nu7bdmkoafa2kh2ptcf7olhofl@ycilgjsqyycq>
 <2024022022-viewless-astronaut-ab8c@gregkh>
 <mpqwydwybzktciqsqsi4ttryazihurwfyl7ruhrxu7o64ahmoh@2xg56usfednx>
 <2024022006-tricky-prankish-212c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024022006-tricky-prankish-212c@gregkh>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 20, 2024 at 09:51:20PM +0100, Greg KH wrote:
> On Tue, Feb 20, 2024 at 03:39:16PM -0500, Kent Overstreet wrote:
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
> > So you manually repicked a subset of my pull request, and of the two
> > patches you silently dropped, one was a security fix - and you _never
> > communicated_ what you were doing.
> 
> I explicitly said "Not all of these applied properly, please send me the
> remaining ones".  I can go back and get the message-id if you want
> reciepts :)

I gave you a _signed pull request_, and there were no merge conflicts.

> > Greg, this isn't working. How are we going to fix this?
> 
> Please send a set of backported commits that you wish to have applied to
> the stable trees.  All other subsystems do this fairly easily, it's no
> different from sending a patch series out for anything else.
> 
> Worst case, I can take a git tree, BUT I will then turn that git tree
> into individual commits as that is what we MUST deal with for the stable
> trees, we can not work with direct pull requests for obvious reasons of
> how the tree needs to be managed (i.e. rebasing all the time would never
> work.)

You rebase these trees? Why? Are they not public?

Look, I need to know that the code I send you is the same as the code
that gets published in stable releases. If you're going to be rebasing
the trees I send you, _all_ the mechanisms we have for doing that
validation break and I'm back to manual verification.

And given that we've got mechanisms for avoiding that - not rebasing so
that we can verify by the sha1, gpg signing - why is stable special
here?

