Return-Path: <stable+bounces-23255-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2903F85EC96
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 00:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BAA01C213BB
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 23:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FCD85268;
	Wed, 21 Feb 2024 23:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WI6Ang84"
X-Original-To: stable@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A2269DE5
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 23:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708557170; cv=none; b=kV62iCXKwDZvQDHfj0x/JJj0SXmznJ27sOibMUhdKQSAMIkiB8nIlp5csXPs/JkoRoQPtg1090AqyTY86tsDjiqQ8AwsrPfrtpIUhVgpaKIK8Av169+c7ARTZvoJbDmprDlFMFRFehgp6Em1wu+IAfnNrLVICZPT52RuRhy104s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708557170; c=relaxed/simple;
	bh=NCMeNA+uWJ/CnwPDj9AvZfPVRnUch9fzunFJPUKmt3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDy+Oam8UTW3q77IiZf5V+U4I+pvMjEC4CXV4PcjBaBM0mM8za7tdTxJEUEMillmQbWqh4gK2uVf5Va9eROVnNl6E9lxwv9kTvPGRY9AW7FhF+48qUeKHWUuFPYXbq+w/Kolw7aCJIEsKSyR6gWobuK0eZhMQ0BLSTd8U5YcdIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WI6Ang84; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 21 Feb 2024 18:12:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708557165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5nBl0mzI5a01pEbFmRvjS+u5c2tyrRqZlr4+/lzHMr4=;
	b=WI6Ang84KT9rIOWxAoQXgifHIil1vP+/FoqE+pjT/8atjGW7QqP1fdSYluE6P2QiNPsRur
	joZu8hUSKE6f9kWP9U6Cz48Z+g2EVMR5s37HyGh4NKgqMoVE4jXn7BtyxM3PEyQkY2/NGP
	MYMt3kXSbFBy565/ojwD936Y6RAjzFs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Sasha Levin <sashal@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Greg KH <gregkh@linuxfoundation.org>, 
	Oleksandr Natalenko <oleksandr@natalenko.name>, Jiri Benc <jbenc@redhat.com>, stable@vger.kernel.org, 
	Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: fs/bcachefs/
Message-ID: <yp7osx43maofpmebvkrevi6qnuwwa2nrvx6uly4utny33j3o4u@jgrvcn5ylowo>
References: <g6el7eghhdk2v5osukhobvi4pige5bsfu5koqtmoyeknat36t7@irmmk7zo7edh>
 <uknxc26o6td7g6rawxffvsez46djmvcy2532kza2zyjuj33k7p@4jdywourgtqg>
 <2024022103-municipal-filter-fb3f@gregkh>
 <4900587.31r3eYUQgx@natalenko.name>
 <2024022155-reformat-scorer-98ae@gregkh>
 <aaf2f030-b6f4-437b-bb4e-79aa4891ae56@suse.cz>
 <ZdaAFt_Isq9dGMtP@sashalap>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZdaAFt_Isq9dGMtP@sashalap>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 21, 2024 at 05:58:30PM -0500, Sasha Levin wrote:
> On Wed, Feb 21, 2024 at 07:10:02PM +0100, Vlastimil Babka wrote:
> > On 2/21/24 18:57, Greg KH wrote:
> > > On Wed, Feb 21, 2024 at 05:00:05PM +0100, Oleksandr Natalenko wrote:
> > > > On středa 21. února 2024 15:53:11 CET Greg KH wrote:
> > > > > 	Given the huge patch volume that the stable tree manages (30-40 changes
> > > > > 	accepted a day, 7 days a week), any one kernel subsystem that wishes to
> > > > > 	do something different only slows down everyone else.
> > > > 
> > > > Lower down the volume then? Raise the bar for what gets backported?
> > > > Stable kernel releases got unnecessarily big [1] (Jiří is in Cc).
> > > > Those 40 changes a day cannot get a proper review. Each stable release
> > > > tries to mimic -rc except -rc is in consistent state while "stable" is
> > > > just a bunch of changes picked here and there.
> > > 
> > > If you can point out any specific commits that we should not be taking,
> > > please let us know.
> > > 
> > > Personally I think we are not taking enough, and are still missing real
> > > fixes.  Overall, this is only a very small % of what goes into Linus's
> > > tree every day, so by that measure alone, we know we are missing things.
> > 
> > What % of what goes into Linus's tree do you think fits within the rules
> > stated in Documentation/process/stable-kernel-rules.rst ? I don't know but
> > "very small" would be my guess, so we should be fine as it is?
> > 
> > Or are the rules actually still being observed? I doubt e.g. many of the
> > AUTOSEL backports fit them? Should we rename the file to
> > stable-rules-nonsense.rst?
> 
> Hey, I have an exercise for you which came up last week during the whole
> CVE thing!
> 
> Take a look at a random LTS kernel (I picked 5.10), in particular at the
> CVEs assigned to the kernel (in my case I relied on
> https://github.com/nluedtke/linux_kernel_cves/blob/master/data/5.10/5.10_security.txt).
> 
> See how many of those actually have a stable@ tag to let us know that we
> need to pull that commit. (spoiler alert: in the 5.10 case it was ~33%)
> 
> Do you have a better way for us to fish for the remaining 67%?
> 
> Yeah, some have a Fixes tag, (it's not in stable-kernel-rules.rst!), and
> in the 5.10 case it would have helped with about half of the commits,
> but even then - what do we do with the remaining half?
> 
> The argument you're making is in favor of just ignoring it until they
> get a CVE assigned (and even then, would we take them if it goes against
> stable-kernel-rules.rst?), but then we end up leaving users exposed for *years*
> as evidenced by some CVEs.

No, I'm not in favor of ignoring things either. What I want is better
collaboration between subsystem maintainers and you guys. Awhile back I
was proposing some sort of shared dashboard where we could all track and
annotate which patches should be considered for backporting when,
because the current email based workflow sucks.

We need to be working together better, which is why I'm so _damn
annoyed_ over the crap with the Fixes: tag, and Greg not taking my
signed pull request as an atomic unit.

You guys shouldn't be doing all this work yourselves; the subsystem
maintainers, the people who know the code best, should be involved. But
your attitude 100% pushes people away.

I need a workflow that works for me, if I'm going to do the backporting
for bcachefs patches, as I intend to: fuckups in filesystem land can
have _far_ too high a cost for me to leave this work to anyone else.

What I need is:

 - A way to unambigiously tag a patch as something that I need to look
   at later when I'm doing backports; and I do _not_ want to have to go
   git blame spelunking when I'm doing that, distracting me from
   whatever else I'm working on; if you insist on the Fixes: tag
   conforming to your tools then this won't get done and bugfixes will
   get lost.

 - Signed pull requests to not get tweaked and rebased.

   Tweaking and hand editing patches is one thing when it's being done
   by the subsystem maintainer, the person who at least nominally knows
   the code best and is best qualified to review those changes.

   You guys should not be doing that, because then I have to go back and
   check your work (and even if you swear you aren't changing the code;
   how do I know unless I look at the diffs? Remember all the talk about
   supply chain attacks?) and I'm just not going to do that. That adds
   too much to my workload, and there's no reason for it.

And please, you guys, make a bit more of an effort to work with people,
and listen to and address their concerns. I hear _way_ too much grousing
in private about -stable bullshit, and despite that I went in to this
optimistic that we'd be able to cut past the bullshit and establish a
good working relationship. Let's see if we still can...

