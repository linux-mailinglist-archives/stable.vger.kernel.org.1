Return-Path: <stable+bounces-200807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4E8CB6903
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 17:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8E1ED3001C11
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 16:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738E22FF646;
	Thu, 11 Dec 2025 16:41:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bregans-1.gladserv.net (bregans-1.gladserv.net [185.128.211.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9552C3148BB;
	Thu, 11 Dec 2025 16:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.211.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765471313; cv=none; b=OJFJt/ebGwYS4iH5Hg9+esy+gnhqI55zPp7mV2qqeLYJEvwNOX8JtLRcFr47oqHbypHBljtUrRRm3Lq8Hsq/JEMfsOyWbUGuf++k1wdP7CnkOWCVyP94Lvs3nR2qRwjwGZa8teQ2w32PBWh1x6a2I2+H6Sr5ay51UPtSr1MCn9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765471313; c=relaxed/simple;
	bh=F1MgHPSXe7ArSt8Y4Z0t7u6ZAkOmdiXO7hItBD7oNqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQ/kI2dh6ktoPIfAfa4rDQj6j5zc4k+yWQNIqOUtfbTGmt6wMSHv5RpA5MU9cnZ7PUhRYhp73i8lqfZiMN1KXWGeJ6BkmXckSNUNCMeVMmE67KLstLfVBvQZ86HB8oY0SpE4wiM5qS67ShPdFnP8DyFP+gTUAv18GmCTx4DxMUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.211.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=librecast.net
Date: Thu, 11 Dec 2025 16:41:26 +0000
From: Brett A C Sheffield <bacs@librecast.net>
To: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
	achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.17 00/60] 6.17.12-rc1 review
Message-ID: <aTr0NpEHWSCrGNTS@auntie>
References: <20251210072947.850479903@linuxfoundation.org>
 <CAG=yYwm==BjqjJWtgc0+WzbiGTsKsHV3e4Lvk60fcartrrABDw@mail.gmail.com>
 <2025121046-satchel-concise-1077@gregkh>
 <CAG=yYwm0bVzYoccKKcdheGOc-exuxVCPeXSftDixS68qZZ7W7w@mail.gmail.com>
 <aTnET5C2PGiKsW_2@auntie>
 <CAG=yYwnYgw-MYea3yEfwSRiLL+PsKPdQdejotyFTpme0LXc-Pg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG=yYwnYgw-MYea3yEfwSRiLL+PsKPdQdejotyFTpme0LXc-Pg@mail.gmail.com>

On 2025-12-11 21:09, Jeffrin Thalakkottoor wrote:
> On Thu, Dec 11, 2025 at 12:35 AM Brett A C Sheffield <bacs@librecast.net> wrote:
> >
> > On 2025-12-10 19:13, Jeffrin Thalakkottoor wrote:
> > > On Wed, Dec 10, 2025 at 6:17 PM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Wed, Dec 10, 2025 at 04:22:21PM +0530, Jeffrin Thalakkottoor wrote:
> > > > >  compiled and booted 6.17.12-rc1+
> > > > > Version: AMD A4-4000 APU with Radeon(tm) HD Graphics
> > > > >
> > > > > sudo dmesg -l errr  shows  error
> > > > >
> > > > > j$sudo dmesg -l err
> > > > > [   39.915487] Error: Driver 'pcspkr' is already registered, aborting...
> > > > > $
> > > >
> > > > Is ths new?  if so, can you bisect?
> > >
> > > this is new related. Previous stable release err and warn disappeared
> > > (i think i changed  .config)
> > >
> > > can you give me a  step by step tutorial  for git bisect
> >
> > 1) cd to wherever you have your kernel checked out
> >
> > 2) `git bisect start`
> >
> > 3) if you're already on a known-bad commit, then mark it as such:
> >
> >   `git bisect bad`
> >
> > 4) Mark the last known good commit as such:
> >
> >   `git bisect good <commit / tag>`
> >
> > git bisect will choose a commit to test.
> >
> > 5) Build, install and boot your kernel as you usually do
> >
> > 6) Run whatever test you need to determine if the booted kernel is good or bad
> > (check dmesg in this case)
> >
> > 7) Mark the commit as good or bad. Git will choose another commit for you.
> >
> > 8) Goto 5.
> >
> > `git help bisect` will give you more information.
> >
> > At the end of the process git will tell you the first bad commit found.  You can
> > dump the bisection log with:
> >
> > `git bisect log`
> >
> > which you can reply here with.
> >
> > HTH.
> >
> > Cheers,
> >
> >
> > Brett
> Thnaks for the tutorial  :)
> 1. should i start with the bad commit first ?

You start by marking one good (past) commit and one bad commit. It doesn't
matter what order.

You have at least one "bad" commit you know of: 4112049d7836ad4233321c3d2b6853db1627c49c

This is the 6.12.62-rc1 commit that you reported had the error.

So, in your kernel worktree:

`git bisect start`
`git bisect bad 4112049d7836ad4233321c3d2b6853db1627c49c`

Now we need to tell git bisect the most recent "good" commit we know of (where
the error didn't occur).

If you already know the commit or tag of a previous version where you did not get the
error, mark that as good. If not, pick a previous release, check it out, and go
to step 5.

> 2. how to move forward or backward in commits ?

git bisect will do that for you as soon as you mark a good and bad commit. If
you want to manually test a specific commit, just `git checkout <ref>` as usual, and
continue at step 5 in the instructions I gave you.

> 3. what is the point in re-compiling the kernel  if it cannot narrow
> down and  test news lines of code

We're narrowing down the error to a specific kernel commit. Once we know which
specific commit introduced the error, we can look at the lines changed and try
to understand why.  We need your help to find that commit, because it's
happening on your system.

Please do read `git help bisect` (man 1 git-bisect). It explains all this better
than I can.

Thanks for testing and good luck!


Brett


