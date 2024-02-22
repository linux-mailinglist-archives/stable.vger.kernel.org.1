Return-Path: <stable+bounces-23287-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0559985F11F
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 06:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60E1CB237BE
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 05:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AE5107B4;
	Thu, 22 Feb 2024 05:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OAXVUTj5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1639FC16
	for <stable@vger.kernel.org>; Thu, 22 Feb 2024 05:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708580942; cv=none; b=OEUPFfRqzGXFktbSxZ6DrmaOYiM2hMmxuisaim38VYSSohyXHRiExqfmW7DpHD7HFyiyS1MgaSrwKLfv/x4ug8rz+JG6PDfqOhm5gte3zlT8LeSg51b216rKLpmUs6kj+APym3xSwgm/hmXfvUs0uXDN5xaUSPmjXCxXD2+Io5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708580942; c=relaxed/simple;
	bh=8J6411boXYfd01PkdIjAPwo2As0sKAAsbKK11zO6Aos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sd7llOesyQRq7l5SCL5ZrxNfSv3Uy2FGyKlxesv60FImZv45LV9Pt487rYGJ6kSpz/niPT49JbiAa74cO4+p+x1+FFFlL5+5CV7kU7cyZnb5t198X09eKs1kUW9ioYKOnIrwF2NXgvtTshTnksrnBWu5zzxl9/V0n8UlNZyU3mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OAXVUTj5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFCC0C433F1;
	Thu, 22 Feb 2024 05:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708580941;
	bh=8J6411boXYfd01PkdIjAPwo2As0sKAAsbKK11zO6Aos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OAXVUTj5+Jwl/LogEmM+TPgJtF1JIxCpEBa3wp0VKaQ1Npu5FupenAlmMnTCh7OsN
	 6ii+dUOly2VmPah9z6DsZIOSZDb1ErIRoyYpZXWjYpLoRO8S06frRkyduGG7jnuLy0
	 aDqYB889wQ/Vs847cR91NV0Kl15mxQCwosBgnTvg=
Date: Thu, 22 Feb 2024 06:48:58 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Sasha Levin <sashal@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
	Oleksandr Natalenko <oleksandr@natalenko.name>,
	Jiri Benc <jbenc@redhat.com>, stable@vger.kernel.org,
	Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: fs/bcachefs/
Message-ID: <2024022224-spotting-blunt-1edb@gregkh>
References: <g6el7eghhdk2v5osukhobvi4pige5bsfu5koqtmoyeknat36t7@irmmk7zo7edh>
 <uknxc26o6td7g6rawxffvsez46djmvcy2532kza2zyjuj33k7p@4jdywourgtqg>
 <2024022103-municipal-filter-fb3f@gregkh>
 <4900587.31r3eYUQgx@natalenko.name>
 <2024022155-reformat-scorer-98ae@gregkh>
 <aaf2f030-b6f4-437b-bb4e-79aa4891ae56@suse.cz>
 <ZdaAFt_Isq9dGMtP@sashalap>
 <yp7osx43maofpmebvkrevi6qnuwwa2nrvx6uly4utny33j3o4u@jgrvcn5ylowo>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yp7osx43maofpmebvkrevi6qnuwwa2nrvx6uly4utny33j3o4u@jgrvcn5ylowo>

On Wed, Feb 21, 2024 at 06:12:42PM -0500, Kent Overstreet wrote:
> > The argument you're making is in favor of just ignoring it until they
> > get a CVE assigned (and even then, would we take them if it goes against
> > stable-kernel-rules.rst?), but then we end up leaving users exposed for *years*
> > as evidenced by some CVEs.
> 
> No, I'm not in favor of ignoring things either. What I want is better
> collaboration between subsystem maintainers and you guys. Awhile back I
> was proposing some sort of shared dashboard where we could all track and
> annotate which patches should be considered for backporting when,
> because the current email based workflow sucks.

I too would like a pony, but for now, we work with what we have, right?

> We need to be working together better, which is why I'm so _damn
> annoyed_ over the crap with the Fixes: tag, and Greg not taking my
> signed pull request as an atomic unit.

Fixes: has a long long long history and to think that your subsystem can
ignore it and do something else with it feels very odd to me.  Your
subsystem lives in the same ecosystem as all other 4000+ developers.
There's a reason we have standards/rules, you can't just ignore them.

> You guys shouldn't be doing all this work yourselves; the subsystem
> maintainers, the people who know the code best, should be involved. But
> your attitude 100% pushes people away.

The goal of the stable/lts kernels is that no developer or maintainer
that does NOT want to help out, has to do anything more than just a
simple "cc: stable@vger.kernel.org" addition to a commit when they apply
it to their tree.

Anything above that is wonderful, but again, not something I can ever
tell someone to do.

> I need a workflow that works for me, if I'm going to do the backporting
> for bcachefs patches, as I intend to: fuckups in filesystem land can
> have _far_ too high a cost for me to leave this work to anyone else.
> 
> What I need is:
> 
>  - A way to unambigiously tag a patch as something that I need to look
>    at later when I'm doing backports; and I do _not_ want to have to go
>    git blame spelunking when I'm doing that, distracting me from
>    whatever else I'm working on; if you insist on the Fixes: tag
>    conforming to your tools then this won't get done and bugfixes will
>    get lost.

Why can't you use Fixes like all of the 10's of thousands of other
developers have over the past 15+ years?

And if you don't like it, that's fine, but again, you can not redefine
it to mean something else for your tiny subsystem, sorry, that's not how
projects of any size work well and survive.

>  - Signed pull requests to not get tweaked and rebased.

As-is, I can NOT take your signed pull request as it did not include the
needed information in it, as I said at the time (i.e. no reference to
the commits that you were backporting.)

What I DID do is dig through your pull request and take the individual
commits that DID apply after looking up, by hand, the proper upstream
git commit id.  I then did NOT take the 2 commits that you had modified
from their upstream version, as there was no indication as to why the
changes were made, or even that any change was made at all, from what is
in Linus's tree.  And at the time I told you all of this, so there was
no question of what happened, and what was expected.

And remember, Linus's tree is the "canonical" version here.  We rely on
signed tags for that, and then we can safely cherry-pick and compare to
those commits to verify that "yes, this is the exact same change that we
already approved and accepted".

>    Tweaking and hand editing patches is one thing when it's being done
>    by the subsystem maintainer, the person who at least nominally knows
>    the code best and is best qualified to review those changes.

Wonderful, then say you tweaked and hand-edited the patches when you
submit them to us and we are fine with it.  But you didn't do that, so
in the interest of saftey and stability, I did NOT take the changes that
were modified.  And here I would think you would be happy we do
validation and verification...

>    You guys should not be doing that, because then I have to go back and
>    check your work (and even if you swear you aren't changing the code;
>    how do I know unless I look at the diffs? Remember all the talk about
>    supply chain attacks?) and I'm just not going to do that. That adds
>    too much to my workload, and there's no reason for it.

If I was a more paranoid person, I would have thought that the modified
changes you sent us with no indication that the changes were modified,
was a "supply chain attack" that you were attempting to do on us.

> And please, you guys, make a bit more of an effort to work with people,
> and listen to and address their concerns. I hear _way_ too much grousing
> in private about -stable bullshit, and despite that I went in to this
> optimistic that we'd be able to cut past the bullshit and establish a
> good working relationship. Let's see if we still can...

This goes both ways please.

Again, I can not take pull requests, it does not work at all with our
workflow as we NEED and REQUIRE actual individual commits, both for
verification and validation, as well as to actually be able to apply to
our trees.

We NEED and REQUIRE the git commit ids of the changes you are asking for
including to be in the commit message itself (or somewhere that I can
then add it), as that is how we, and everyone else, tracks what gets
applied to where, and to be able to validate and ensure that the commit
really is what you say it is.

We NEED and REQUIRE you, if you do modify a commit from what is in
Linus's tree, to say "hey, this is modified because of X and Y", not to
just not say anything and assume that we should blindly take a modified
change.  You don't want us to do that, right?

So, to work with the stable trees, you have a number of simple options,
here they are going from least-amount-of-work to most-amount-of-work:
	- ignore the stable trees and insist that everyone only use
	  Linus's releases for your subsystem (some subsystems do want
	  this, for whatever reason, that's on them.)
	- add only "Fixes:" tags to commits, with the correct git id.
	  These will eventually get picked up by a stable developer and
	  a semi-best effort done to apply them were relevant, but we
	  can not guarantee it.
	- add a "Cc: stable@vger.kernel.org" tag to a commit when you
	  apply it to your tree.  This is the simplest, and recommended
	  way.  Bonus if you also include a "Fixes:" tag so we know how
	  far back to apply it, AND you will get an automated message
	  for when we can NOT apply it that far back successfully.
	- Send us a list of git ids you want to have us backport.
	- Send us a patch series that you want to have applied, with the
	  git id of the original commit in the commit body, and if the
	  change has been modified from the original, a small note
	  somewhere (usually in the signed-off-by area) saying it has
	  been modified and why.
	- Send us a pull request of patches built up the same way as the
	  above option.  This puts more work on us as we then need to
	  turn the pull request into a set of individual patches and
	  review them "by hand" in a tool other than our mail readers,
	  but eventually the patches will get applied.

Note that no where is a "send a pull request that consists of patches
with no references to upstream git ids or notification that anything has
changed" option.  That just will not work for all of the reasons
speficied above, sorry.

Hope this helps explain all of this better.

greg k-h

