Return-Path: <stable+bounces-23291-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AEE85F181
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 07:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF0791C213BC
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 06:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C607C8E2;
	Thu, 22 Feb 2024 06:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DNpd3X5i"
X-Original-To: stable@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795B914291
	for <stable@vger.kernel.org>; Thu, 22 Feb 2024 06:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708583412; cv=none; b=BPG+Conn1YoqC2uI0bY/Ytfo7h8wTevBuDZyY+qusSwIYudBzh/lCsMzc04erTimWLTWVg5zRPMMqrx8jLFCl4G6UXhHbaQ2WMQeSChegKaZloJ9OfhS1F8Rs4WsNPCfCocvdg4biLmVLCcDQzVKYrgBcl1NKRR3qeD3Kzaq+b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708583412; c=relaxed/simple;
	bh=1wfDfyR9Q8hgXXP+AKVUMgpmLDEKJmiShjrUZvzFtpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dccjYIvysA8o/XL97D/cMT0edzisMkiVW9KEQklAFDpmbEmLQtiajDTTNQfas20HZE2pUEh9X09nn9u54RJYHD+iYbezvC5e/t/JcE7tO4JJdLUaCkVMPClmVyfMdV4JGPk07w5ZFbkoEu39/SCXGmvBCXXzRkanDsPqDA0NcTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DNpd3X5i; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 22 Feb 2024 01:30:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708583407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BuJ47cNrq5XvDz0kiJtcwDCzemRNvuKwJ3uPZFE2XKU=;
	b=DNpd3X5iAAS3I7tTdhk3LjCSM48LuHH/EJrvmzog1Z0vCkzIHO1TJ5g8ethuoSMtm8XEtu
	sY997liYjr+n1LgSuirqVzn9Y8aA4EOx39Ks10Aw8y9DikLHIkHpD/1C7ni8Vnp586c+hQ
	+18Y4huwEgLKvarDEIFLNM7waZZLSVo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Oleksandr Natalenko <oleksandr@natalenko.name>, Jiri Benc <jbenc@redhat.com>, stable@vger.kernel.org, 
	Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: fs/bcachefs/
Message-ID: <kcu4dlcablzlybppobcql7roqehim6ejkgsqkbw2rkrfv7xuch@edklzskv4iaa>
References: <g6el7eghhdk2v5osukhobvi4pige5bsfu5koqtmoyeknat36t7@irmmk7zo7edh>
 <uknxc26o6td7g6rawxffvsez46djmvcy2532kza2zyjuj33k7p@4jdywourgtqg>
 <2024022103-municipal-filter-fb3f@gregkh>
 <4900587.31r3eYUQgx@natalenko.name>
 <2024022155-reformat-scorer-98ae@gregkh>
 <aaf2f030-b6f4-437b-bb4e-79aa4891ae56@suse.cz>
 <ZdaAFt_Isq9dGMtP@sashalap>
 <yp7osx43maofpmebvkrevi6qnuwwa2nrvx6uly4utny33j3o4u@jgrvcn5ylowo>
 <2024022224-spotting-blunt-1edb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024022224-spotting-blunt-1edb@gregkh>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 22, 2024 at 06:48:58AM +0100, Greg KH wrote:
> >  - A way to unambigiously tag a patch as something that I need to look
> >    at later when I'm doing backports; and I do _not_ want to have to go
> >    git blame spelunking when I'm doing that, distracting me from
> >    whatever else I'm working on; if you insist on the Fixes: tag
> >    conforming to your tools then this won't get done and bugfixes will
> >    get lost.
> 
> Why can't you use Fixes like all of the 10's of thousands of other
> developers have over the past 15+ years?

I've explained that multiple times and you're not listening.

That's not how you work with people, Greg; cut the form letter response
bullshit and try and have a real conversation.

You've been repeatedly stonewalling and shutting down my every attempt
to find a solution here.

But honestly, this isn't even the main issue.

> And if you don't like it, that's fine, but again, you can not redefine
> it to mean something else for your tiny subsystem, sorry, that's not how
> projects of any size work well and survive.
> 
> >  - Signed pull requests to not get tweaked and rebased.
> 
> As-is, I can NOT take your signed pull request as it did not include the
> needed information in it, as I said at the time (i.e. no reference to
> the commits that you were backporting.)

You communicated that one, and I redid the cherry picks with -x...

...And they still showed up in your tree as completely different
commits.

> What I DID do is dig through your pull request and take the individual
> commits that DID apply after looking up, by hand, the proper upstream
> git commit id.  I then did NOT take the 2 commits that you had modified
> from their upstream version, as there was no indication as to why the
> changes were made, or even that any change was made at all, from what is
> in Linus's tree.  And at the time I told you all of this, so there was
> no question of what happened, and what was expected.

Why would you silently redo work that I sent you?

All you're doing is making more work for yourself. If I send you a pull
request that you can't use, kick it back to me and tell me why!

But silently redo it and drop a security fix? Can we please not?

> If I was a more paranoid person, I would have thought that the modified
> changes you sent us with no indication that the changes were modified,
> was a "supply chain attack" that you were attempting to do on us.

Of my own code?

Look, this isn't about not trusting _you_, it's that the further up the
food chain commits go the less it is possible and reasonable to expect
anything to be caught by review.

> > And please, you guys, make a bit more of an effort to work with people,
> > and listen to and address their concerns. I hear _way_ too much grousing
> > in private about -stable bullshit, and despite that I went in to this
> > optimistic that we'd be able to cut past the bullshit and establish a
> > good working relationship. Let's see if we still can...
> 
> This goes both ways please.
> 
> Again, I can not take pull requests, it does not work at all with our
> workflow as we NEED and REQUIRE actual individual commits, both for
> verification and validation, as well as to actually be able to apply to
> our trees.
> 
> We NEED and REQUIRE the git commit ids of the changes you are asking for
> including to be in the commit message itself (or somewhere that I can
> then add it), as that is how we, and everyone else, tracks what gets
> applied to where, and to be able to validate and ensure that the commit
> really is what you say it is.
> 
> We NEED and REQUIRE you, if you do modify a commit from what is in
> Linus's tree, to say "hey, this is modified because of X and Y", not to
> just not say anything and assume that we should blindly take a modified
> change.  You don't want us to do that, right?

I can provide commit messages in the format you need - but also: _none_
of this is documented in stable-kernel-rules.rst, so I'm going to want
something clear and specific I can go off of.

(And why are you not specifying the original sha1 in the format
cherry-pick -x produces? Why is that not documented?)

But not taking signed pull requests is going to be a sticking point, as
well as the fact that you only took part of the pull request.

We've had multiple bugs lately stemming from related patches not being
carried together - _nasty_ bugs, as in "I can't access my filesystem" or
"My data is being corrupted".

That was the case in this pull request too; one of the patches you
dropped, IIRC, was a locking fix for an earlier fix by Al; those patches
should have gone together.

This sort of thing is a good part of why I'm insisting on doing things
myself.

So: in the interest of avoiding issues like this, can I at least ask you
to start taking signed pull requests if the patch metadata is all in the
format you need?

