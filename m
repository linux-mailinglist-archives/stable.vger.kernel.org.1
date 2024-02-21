Return-Path: <stable+bounces-23186-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 062AB85E051
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 15:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B01CB286735
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4747FBCE;
	Wed, 21 Feb 2024 14:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iU5ItARV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D947FBB8
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 14:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708527194; cv=none; b=dxJ1F7z3wEDieE9vdYTt9ErB3nbB8zZ1plnfp0K//vSQQhSGI3Bwfsfaa+wEOO36mHlW7HDXgZScF98veif4gbJDuoZaFIl88I+I4x9n0HWz+4Ogk2EvmE3BajWKYn2qXo9AEml/KWBAXamSLV+fkr/CoyqU/W+4Nzq5tt/0XWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708527194; c=relaxed/simple;
	bh=FmEXpCKnqp1gzghjIRAaTB6zpRXa+ixYv53effhftpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBGn/3sHAhTqJyMZPnXvcqVYhKMrnftkqXb6qbjwZEx+xkQZnkBX5pzsDbEPvG/6EpH4BUh8sZ3kofff8yLO3JxSimTULJM4s/gYs0G39da08A6bajlRaoNg2FEf774qJFCANMkeMjITbgzfCanOo9sgNvPAamEe6/bhZ0poryQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iU5ItARV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21F2C433F1;
	Wed, 21 Feb 2024 14:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708527194;
	bh=FmEXpCKnqp1gzghjIRAaTB6zpRXa+ixYv53effhftpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iU5ItARVlmXHN9OsQegTZPIzBeo04CLsNrBOrPpi3nr8F0Qvj1ASMVWTQ68apXiye
	 TgOwGwCLS+RgEsCkoETb1jbcdNhD0YF9+YkdVWicbysNmJA6IxIKcbcb34EsdOpeJe
	 Fo3cJZEK3rU2mkQWsqf3f0ohG7oHrK9RjJwRIcSg=
Date: Wed, 21 Feb 2024 15:53:11 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: Re: fs/bcachefs/
Message-ID: <2024022103-municipal-filter-fb3f@gregkh>
References: <g6el7eghhdk2v5osukhobvi4pige5bsfu5koqtmoyeknat36t7@irmmk7zo7edh>
 <ZaW5r5kRbOcKveVn@sashalap>
 <dlxqudswz64v6xn3fg2i6ob2msnytaatmnyhq4ivi7notzs6jf@itt42d42zmsw>
 <2024022056-monkhood-fossil-ec02@gregkh>
 <2024022007-buggy-operator-2dc5@gregkh>
 <g2jlxm6hcpywrezexi3kxrl6nu7bdmkoafa2kh2ptcf7olhofl@ycilgjsqyycq>
 <2024022022-viewless-astronaut-ab8c@gregkh>
 <mpqwydwybzktciqsqsi4ttryazihurwfyl7ruhrxu7o64ahmoh@2xg56usfednx>
 <2024022006-tricky-prankish-212c@gregkh>
 <uknxc26o6td7g6rawxffvsez46djmvcy2532kza2zyjuj33k7p@4jdywourgtqg>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <uknxc26o6td7g6rawxffvsez46djmvcy2532kza2zyjuj33k7p@4jdywourgtqg>

On Tue, Feb 20, 2024 at 04:00:18PM -0500, Kent Overstreet wrote:
> On Tue, Feb 20, 2024 at 09:51:20PM +0100, Greg KH wrote:
> > On Tue, Feb 20, 2024 at 03:39:16PM -0500, Kent Overstreet wrote:
> > > On Tue, Feb 20, 2024 at 09:19:01PM +0100, Greg KH wrote:
> > > > On Tue, Feb 20, 2024 at 03:06:14PM -0500, Kent Overstreet wrote:
> > > > > On Tue, Feb 20, 2024 at 07:53:04PM +0100, Greg KH wrote:
> > > > > > On Tue, Feb 20, 2024 at 07:03:23PM +0100, Greg KH wrote:
> > > > > > > On Tue, Feb 20, 2024 at 12:23:33PM -0500, Kent Overstreet wrote:
> > > > > > > > On Mon, Jan 15, 2024 at 06:03:11PM -0500, Sasha Levin wrote:
> > > > > > > > > On Mon, Jan 15, 2024 at 05:12:17PM -0500, Kent Overstreet wrote:
> > > > > > > > > > Hi stable team - please don't take patches for fs/bcachefs/ except from
> > > > > > > > > > myself; I'll be doing backports and sending pull requests after stuff
> > > > > > > > > > has been tested by my CI.
> > > > > > > > > > 
> > > > > > > > > > Thanks, and let me know if there's any other workflow things I should
> > > > > > > > > > know about
> > > > > > > > > 
> > > > > > > > > Sure, we can ignore fs/bcachefs/ patches.
> > > > > > > > 
> > > > > > > > I see that you even acked this.
> > > > > > > > 
> > > > > > > > What the fuck?
> > > > > > > 
> > > > > > > Accidents happen, you were copied on those patches.  I'll go drop them
> > > > > > > now, not a big deal.
> > > > > > 
> > > > > > Wait, why are you doing "Fixes:" with an empty tag in your commits like
> > > > > > 1a1c93e7f814 ("bcachefs: Fix missing bch2_err_class() calls")?
> > > > > > 
> > > > > > That's messing with scripts and doesn't make much sense.  Please put a
> > > > > > real git id in there as the documentation suggests to.
> > > > > 
> > > > > There isn't always a clear-cut commit when a regression was introduced
> > > > > (it might not have been a regresison at all). I could dig and make
> > > > > something up, but that's slowing down your workflow, and I thought I was
> > > > > going to be handling all the stable backports for fs/bcachefs/, so - ?
> > > > > 
> > > > 
> > > > Doesn't matter, please do not put "fake" tags in commit messages like
> > > > this.  It hurts all of the people that parse commit logs.  Just don't
> > > > put a fixes tag at all as the documentation states that after "Fixes:" a
> > > > commit id belongs.
> > > 
> > > So you manually repicked a subset of my pull request, and of the two
> > > patches you silently dropped, one was a security fix - and you _never
> > > communicated_ what you were doing.
> > 
> > I explicitly said "Not all of these applied properly, please send me the
> > remaining ones".  I can go back and get the message-id if you want
> > reciepts :)
> 
> I gave you a _signed pull request_, and there were no merge conflicts.
> 
> > > Greg, this isn't working. How are we going to fix this?
> > 
> > Please send a set of backported commits that you wish to have applied to
> > the stable trees.  All other subsystems do this fairly easily, it's no
> > different from sending a patch series out for anything else.
> > 
> > Worst case, I can take a git tree, BUT I will then turn that git tree
> > into individual commits as that is what we MUST deal with for the stable
> > trees, we can not work with direct pull requests for obvious reasons of
> > how the tree needs to be managed (i.e. rebasing all the time would never
> > work.)
> 
> You rebase these trees? Why? Are they not public?
> 
> Look, I need to know that the code I send you is the same as the code
> that gets published in stable releases. If you're going to be rebasing
> the trees I send you, _all_ the mechanisms we have for doing that
> validation break and I'm back to manual verification.
> 
> And given that we've got mechanisms for avoiding that - not rebasing so
> that we can verify by the sha1, gpg signing - why is stable special
> here?



Hi,

This is the friendly email-bot of the stable kernel team.  I've detected that
you are asking a question that has been discussed many times in the past.  If
you wish to contact the stable developers directly, please use their phone
hotline, 1-800-382-5633.

thanks,

stable email bot

----------------

*beep  beep beep beep  beep beep beep  beep beep beep beep*

*ring*  *ring*

	This is the Linux stable kernel team's phone line.

	Please listen to the following menu fully as the items have changed
	recently.

	To contact the Linux stable developer's directly, please press 1.

	To contact the Linux stable develop—
*1*

	All of the current stable developers are busy handling other kernel
	developer issues or reviewing properly tagged kernel patches.  Please
	wait for the next available developer, or press 0 to return to the main
	menu.

	You are caller number SEVENTY FIVE in the queue with an expected wait
	time of ELEVEN HUNDRED AND TWENTY FIVE MINUTES.

	Please enjoy the smooth sounds of Enya while you wait.

		"Who can say where the road goes?
		 Where the day flows?
		 Only time.
		 And who can say—
*0*

	This is the Linux stable kernel team's phone line.

	Please listen to the following menu fully as the items have changed
	recently.

	To contact the Linux stable developer's directly, please press 1.

	To contact the Linux stable developer's legal department to lodge a
	complaint, please press 2.

	To listen to the—
*2*

	You are now being transferred to the legal department, to return to the
	main menu, please press 0

	....

	Welcome to the law firm of Dewey Cheatem & Howe.  Unfortunately, due to
	a large outstanding bill, we no longer represent the Linux stable
	kernel team as it turned out they were not being paid for their
	services, and so didn't feel like paying for ours either.  If you wish
	to hire us to represent you in an accident claim, stay on the line and
	someone will be with you—
*0*

	This is the Linux stable kernel team's phone line.

	Please listen to the following menu fully as the items have changed
	recently.

	To contact the Linux stable developer's directly, please press 1.

	To contact the Linux stable developer's legal department to lodge a
	complaint, please press 2.

	To listen to the often asked question of "why don't you accept pull
	requests directly", please press 3.

	For all other questions, please write an email and it will be handled
	in the order in which it is received.

	This menu will now repeat for your enjoyment.

	This is the Linux stable—

*3*

	The reason the stable kernel team can not accept pull requests directly
	is that they accumulate many patches from many different developers and
	trees and combine them all into a set of patches to be applied on top
	of the last release.  If a git tree were used, the ordering,
	reshuffling, removing, and adding of patches in the list would not
	work properly at all as it would require constant rebasing.  This can
	be seen directly by following the often-rebased linux-stable-rc git
	tree, which is only present for CI systems to consume if they can not
	handle a set of quilt patches directly.

	The stable developer workflow has been working well for over 15 years
	as a patch queue, no convincing of "but you must accept my pull
	request" is going to work well, given the current requirements of how
	the stable trees are generated.

	A pull request can be handled, by the stable developer taking it,
	exporting the changes as individual patches (using 'git format-patch')
	and then importing them into the stable patch queue directly.  If a
	subsystem maintainer feels that this is the best way to coordinate with
	the stable team, that is fine, but note that individual patches will be
	the end result, so perhaps just using 'git send-email' in the first
	place would be simpler for everyone involved?

	Having to process a git pull takes additional time and energy and slows
	down the patch acceptance rate.  It is generally postponed as there are
	lots of properly tagged commits that are easier and simpler for them to
	handle.

	Given the huge patch volume that the stable tree manages (30-40 changes
	accepted a day, 7 days a week), any one kernel subsystem that wishes to
	do something different only slows down everyone else.  Yes, your
	subsystem is special and unique, just like everyone else's, we know,
	remember, we maintain kernel subsystems too.  Just use patches and
	email, it's the lowest common denominator here that works well given
	the often-disconnected nature of the stable developers as they travel
	the globe racking up frequent flyer points and talking in generic
	conference center meeting rooms about hardware roadmaps and their
	applicability to the kernel.

	Thank you for listening to the reasoning here, and as we generally
	assume this will not have calmed you down much at all, please feel free
	to stay on the line in the phone queue which currently has EIGHTY FIVE
	callers ahead of you, with a expected wait time of TWELVE HUNDRED AND
	SEVENTY MINUTES

	Please continue to enjoy the smooth sounds of Enya while you wait.

		"Let me sail, let me sail
		 Let the orinoco flow"
		 Let me reach, let me beach—

*CLICK*


