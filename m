Return-Path: <stable+bounces-178006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C565B4773E
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 23:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B755565D55
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 21:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2568927EFE7;
	Sat,  6 Sep 2025 21:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QtOBdvIA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79C2279903
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 21:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757192690; cv=none; b=o3M8co1A89cQRU7Cq6CITOe7CtvcRnn3oqbzsJ/vqp/sJBTD3NDnebCrQhDwvhixlmuURzJhrjeNMFyacbh34Om1ushFilrhYvXS538oTjH1MM/5kbvVdFudk3Mlef0sIBd2jXSX7YfWmNu+P9gn1smzQspJtVBTNPWXENK4DTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757192690; c=relaxed/simple;
	bh=33YttKAmfNPbWXZrtDtAzCbwqNHVnIYUvuanr4dYJLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMTXvvQfEOmbRWvyzSu+/VldR7HAFWgjIiJzXtKQnfAoKPgifSVgrh4Ga3vYWv2ADEfZbOBaHGTI3eCT3sOhaXGoAY771Mqg4tcngYAaGNjlbA67IuMWQGeTxd4/4HI1v2kSZfJfcNasaURfSl1Epk4/0gXPkpbbvRxNKLYV+x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QtOBdvIA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEACCC4CEE7;
	Sat,  6 Sep 2025 21:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757192690;
	bh=33YttKAmfNPbWXZrtDtAzCbwqNHVnIYUvuanr4dYJLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QtOBdvIAywSEN0Ng0t6kXGXKzx4uI4AVTk4iYCdZxg42yna5WzJ4yfahlTrdgkpi6
	 tGXimYpbtFGnlJ07lsikJNw/FbJPccPC3VNwYwkCK8Ux/rKf4tQZfEoxHnhDusEfEf
	 9nqeUl8CQDw0yOBnuzEnkBMh0iqJSYojoJqdpyP4=
Date: Sat, 6 Sep 2025 23:04:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	stable@vger.kernel.org, vegard.nossum@oracle.com,
	syzbot+54cbbfb4db9145d26fc2@syzkaller.appspotmail.com
Subject: Re: [PATCH 6.12.y 11/15] io_uring/msg_ring: ensure io_kiocb freeing
 is deferred for RCU
Message-ID: <2025090635-charger-grader-8fdf@gregkh>
References: <20250905110406.3021567-1-harshit.m.mogalapalli@oracle.com>
 <20250905110406.3021567-12-harshit.m.mogalapalli@oracle.com>
 <f43fe976-4ef5-4dea-a2d0-336456a4deae@kernel.dk>
 <96857683-167a-4ba8-ad26-564e5dcae79b@kernel.dk>
 <2025090622-crispy-germproof-3d11@gregkh>
 <368617ee-8e77-4fec-81cd-45ee3d3532bb@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <368617ee-8e77-4fec-81cd-45ee3d3532bb@kernel.dk>

On Sat, Sep 06, 2025 at 02:47:04PM -0600, Jens Axboe wrote:
> On 9/6/25 12:36 PM, Greg KH wrote:
> > On Fri, Sep 05, 2025 at 07:23:00PM -0600, Jens Axboe wrote:
> >> On 9/5/25 1:58 PM, Jens Axboe wrote:
> >>> On 9/5/25 5:04 AM, Harshit Mogalapalli wrote:
> >>>> diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
> >>>> index 5ce332fc6ff5..3b27d9bcf298 100644
> >>>> --- a/include/linux/io_uring_types.h
> >>>> +++ b/include/linux/io_uring_types.h
> >>>> @@ -648,6 +648,8 @@ struct io_kiocb {
> >>>>  	struct io_task_work		io_task_work;
> >>>>  	/* for polled requests, i.e. IORING_OP_POLL_ADD and async armed poll */
> >>>>  	struct hlist_node		hash_node;
> >>>> +	/* for private io_kiocb freeing */
> >>>> +	struct rcu_head		rcu_head;
> >>>>  	/* internal polling, see IORING_FEAT_FAST_POLL */
> >>>>  	struct async_poll		*apoll;
> >>>>  	/* opcode allocated if it needs to store data for async defer */
> >>>
> >>> This should go into a union with hash_node, rather than bloat the
> >>> struct. That's how it was done upstream, not sure why this one is
> >>> different?
> >>
> >> Here's a test variant with that sorted. Greg, I never got a FAILED email
> >> on this one, as far as I can tell. When a patch is marked with CC:
> >> stable@vger.kernel.org and the origin of the bug clearly marked with
> >> Fixes, I'm expecting to have a 100% reliable notification if it fails to
> >> apply. If not, I just kind of assume patches flow into stable.
> >>
> >> Was this missed on my side, or was it on the stable side? If the latter,
> >> how did that happen? I always ensure that stable has what it needs and
> >> play nice on my side, but if misses like this can happen with the
> >> tooling, that makes me a bit nervous.
> >>
> > 
> > This looks like a failure on my side, sorry.  I don't see any FAILED
> > email that went out for this anywhere, so I messed up.
> > 
> > sorry about that, and Harshit, thanks for noticing it.
> 
> Thanks for confirming, because I was worried it was on my side. But I
> thought these things were fully automated? I'm going to add something on
> my side to catch these in the future, just in case.

Hah, "fully automated", I wish...

Just because "learning how the sausage is made" is something that some
people are curious about, here's how I apply stable patches:
  - I get a mbox full of patches that are in Linus's tree with a
    cc:stable in them, when he applies them to his tree.  How that
    happens is another story...
  - In mutt, I open the mbox, and pick a patch to look at.  if it seems
    sane (almost all do), I look for a "Fixes:" tag.  if it's there, I
    press a key and a script of mine + a local database I've hacked
    together, tells me just how far back that "Fixes: " commit went.  I
    try to remember that version number.
  - I press a different key, and the mail is turned into a patch, and
    then attempted to be applied to each branch of the currently active
    stable trees using quilt.  It tells me about fuzz, or failures, or
    other things, and can let me resolve failures if I want to, one per
    branch (I have to manually continue on after each attempt because I
    can cancel it all if it stops applying).
  - If the patch didn't apply all the way back, I go to a different
    terminal window and run 'bad_stable GIT_ID' with GIT_ID the id from
    the original commit which I had selected in the original email.  I'm
    then offered up which tree to say it failed for by the script, and
    it sends the email off.

Notice the "I try to remember how far back" stage.  Normally that works
just fine.  Sometimes it doesn't.  This time it didn't.  Overall my % is
pretty good in the past 20+ years of doing this.  Or no one is really
paying attention and my % is way worse, hard to tell...

And yes, I've tried to make the "send the failed email" happen directly
from the failure to apply, but that gets into some combinations of "did
it really want to go that far back" (some patches do not have Fixes:
tags) and sometimes Fixes is actually wrong (hit that just a few minutes
ago with a drm patch), and there's some messy terminal/focus issues with
running interactive scripts from within a mutt process that sometimes
requires me to spawn separate windows to work around, but then I lost
the original email involved as that was piped from mutt, and well, it's
a mess.  So I stick to this process.

I can process stable patches pretty fast now, I'm only rate limited by
my test builds, not the "apply from email" dance.  And the failure rate
is generally pretty low, with the exception of the -rc1 DRM subsystem
merge nightmare, but that's another issue...

Anyway, sorry for the wall of text that you weren't looking for :)

greg k-h

