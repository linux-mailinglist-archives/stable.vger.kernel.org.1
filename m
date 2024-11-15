Return-Path: <stable+bounces-93495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E19379CDB69
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 10:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C4BFB24336
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 09:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D48D18F2C1;
	Fri, 15 Nov 2024 09:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TMTUloId"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA6918B476
	for <stable@vger.kernel.org>; Fri, 15 Nov 2024 09:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731662407; cv=none; b=MuMEu/twKvH8ngAccwmzti85T8uaQdIAyJLGcPqbQgxbmUoP9sAAQqZlHNbJ187sSNyl1yOxoWoO3FRwOrwSuNBBjilPUl8LqFVy7mCEl3hy3wZMZFsKpsdy9enQ55J5de91P5NAFo6dB5MPmbl7xIyUbHnwa1B2uWiQto+thsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731662407; c=relaxed/simple;
	bh=h4n3QFbZ5FYHELO6b/tRC7um1AKEeJgfZjhS3rn9w2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/AO27BGDPzPFJGCXew/47SfQp4azlVD1zVB1U+ulczk0jUfatPiIw3bEt6qVtYBtQ8xyy2CSSwAfcUOJEKTqTl7zaCSJqpj+nsDgUT8ZTBdeL1kw6Eyl2mMZ4F45cl/9V9K/jVDqVf1znwdiS3vPJGccPZKScIY8yRKuGPYPV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TMTUloId; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD2CC4CEDB;
	Fri, 15 Nov 2024 09:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731662407;
	bh=h4n3QFbZ5FYHELO6b/tRC7um1AKEeJgfZjhS3rn9w2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TMTUloIdg/9UvHJ7Gg8/ajXZrB8hhsJFWiX11WoQxnwPAE7tasaCcgbxkNhGc2jHS
	 5fMQ/MjXDw4t3QIQFRi/OqI2IdzLc4zvTsT05tkyrMiUP3BT4y98hbe3/DzECz6DZf
	 PO/Xgxr8b37dypp0P137tMriinna9gVGsvzoi9Ys=
Date: Fri, 15 Nov 2024 10:20:04 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: stable@vger.kernel.org, Jann Horn <jannh@google.com>,
	stable <stable@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 6.6.y] mm: refactor map_deny_write_exec()
Message-ID: <2024111523-energy-punctual-7b85@gregkh>
References: <2024111110-dubbed-hydration-c1be@gregkh>
 <20241114183615.849150-1-lorenzo.stoakes@oracle.com>
 <2024111540-vegan-discard-a481@gregkh>
 <bb420574-76ab-430e-838f-18690196b175@lucifer.local>
 <2024111520-freemason-boil-f2de@gregkh>
 <64dc674a-1152-4107-a382-b1167cdfb202@lucifer.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64dc674a-1152-4107-a382-b1167cdfb202@lucifer.local>

On Fri, Nov 15, 2024 at 08:38:00AM +0000, Lorenzo Stoakes wrote:
> On Fri, Nov 15, 2024 at 09:27:22AM +0100, Greg KH wrote:
> > On Fri, Nov 15, 2024 at 07:52:26AM +0000, Lorenzo Stoakes wrote:
> > > On Fri, Nov 15, 2024 at 05:02:29AM +0100, Greg KH wrote:
> > > > On Thu, Nov 14, 2024 at 06:36:15PM +0000, Lorenzo Stoakes wrote:
> > > > > Refactor the map_deny_write_exec() to not unnecessarily require a VMA
> > > > > parameter but rather to accept VMA flags parameters, which allows us to use
> > > > > this function early in mmap_region() in a subsequent commit.
> > > > >
> > > > > While we're here, we refactor the function to be more readable and add some
> > > > > additional documentation.
> > > > >
> > > > > Reported-by: Jann Horn <jannh@google.com>
> > > > > Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
> > > > > Cc: stable <stable@kernel.org>
> > > > > Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > > > > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> > > > > Reviewed-by: Jann Horn <jannh@google.com>
> > > > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > > > ---
> > > > >  include/linux/mman.h | 21 ++++++++++++++++++---
> > > > >  mm/mmap.c            |  2 +-
> > > > >  mm/mprotect.c        |  2 +-
> > > > >  3 files changed, 20 insertions(+), 5 deletions(-)
> > > >
> > > > There's no clue here as to what the upstream git id is :(
> > >
> > > It's in-reply-to a mail that literally contains the upstream git id,
> > > following the instructions you explicitly gave.
> >
> > The instructions explicitly give you commands that say to use 'git
> > cherry-pick -x' which adds the commit id :)
> 
> Right yes, missed that, these had to be hand fixed up which is part of it.
> 
> >
> > > > Also, you sent lots of patches for each branch, but not as a series, so
> > > > we have no idea what order these go in :(
> > >
> > > I did wonder how you'd sort out ordering, but again, I was following your
> > > explicit instructions.
> > >
> > > >
> > > > Can you resend all of these, with the upstream git id in it, and as a
> > > > patch series, so we know to apply them correctly?
> > >
> > > I'll do this, but... I do have to say, Greg, each of these patches are in
> > > reply to a mail stating something like, for instance this one:
> > >
> > > 	The patch below does not apply to the 6.6-stable tree.
> > > 	If someone wants it applied there, or to any other stable or longterm
> > > 	tree, then please email the backport, including the original git commit
> > > 	id to <stable@vger.kernel.org>.
> > >
> > > (I note the above hand waves mention of including original git commit, but
> > > it's unwise to then immediately list explicit commands none of which
> > > mention this...)
> > >
> > > 	To reproduce the conflict and resubmit, you may use the following commands:
> > >
> > > 	git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
> > > 	git checkout FETCH_HEAD
> > > 	git cherry-pick -x 0fb4a7ad270b3b209e510eb9dc5b07bf02b7edaf
> >
> > See, -x, I think you forgot that :)
> >
> > Anyway, this normally works just fine, as whole series of commits that
> > fail are odd and rare.  I can guess at ordering, like I do when I take
> > them from Linus's tree (going by original commit dates), but for when
> > you resend a bunch of them, it's much tricker as the original "FAILED"
> > message doesn't show that order.
> 
> My point stands about rewording this, because I mean - I did what you asked
> (modulo mistakenly not getting the cherry-picked-by thing) - and it seems you
> are still unable to apply these.

If I had the git ids, I'd take the time to figure it out.  As-is, these
were going to have to be redone anyway, hence me asking that they be
sent in a series.  That's all, just trying to make my life easier.

thanks,

greg k-h

