Return-Path: <stable+bounces-98720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CCB9E4DC9
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 07:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 548E41881458
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 06:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8F319645D;
	Thu,  5 Dec 2024 06:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aUsQEfwI"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5217C17C208
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 06:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733381562; cv=none; b=vCWL1zUWG2ddHf0egDRP1isuTPap7d8ACXw+TYJ8JtEV4+SFX8j5GD6EeCfzAMLLuM0PrY46piVh4yPy/gPogs7AJ/t799iGOJegrQC5YoCtOn/ldBuo6E9pG7j5/NNfvwQiz7fBc7yiQ97J5Q63rq2383b5VLOfs4Euz3ZgXBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733381562; c=relaxed/simple;
	bh=Hxc5BJfUOEhEkjRnzPMlxQ0MGq07HEi8ySVIgM7dmVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shP/Hr+/WpR89I90A9anu3PuJoJBsmXp8a9NaOtEQRK7FdOqy15p5bV4iZqC7dPh6RK2QsN9BE/pZ0ARLiwknQ48Utu8UhUbGU5jEG99cA/f5A4AJgxe5Txhg0Hx8uOrS08hCpujkmxqcuastsbfNZq6HKYQ3bhJ3i8uluma6YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aUsQEfwI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733381558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HBS+AO6z8v1OAx4+wXhlKbnz9/BIKeL3bWgH9Ssx3AA=;
	b=aUsQEfwIsKhmoa1PQ1hG4SafpUIxw8PCE8XGxrvQ67NH2w+VaHEaSUwkd411HZPNDhlsGh
	kur/2LJJn6phqno1rrBAo4CikUo6WnDjKO1dLBrpRPN3dzx3QxDGVLnftNf9zGBkkfdHvb
	tcoCHmp7PHCKmiQFKmTuSdTjA9FFXt8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-kxcb60d_NNOw6FArRh4buw-1; Thu,
 05 Dec 2024 01:52:30 -0500
X-MC-Unique: kxcb60d_NNOw6FArRh4buw-1
X-Mimecast-MFC-AGG-ID: kxcb60d_NNOw6FArRh4buw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3D4EC195608B;
	Thu,  5 Dec 2024 06:52:29 +0000 (UTC)
Received: from redhat.com (unknown [10.22.64.4])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D47DD1956054;
	Thu,  5 Dec 2024 06:52:27 +0000 (UTC)
Date: Thu, 5 Dec 2024 00:52:25 -0600
From: Bill O'Donnell <bodonnel@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: cem@kernel.org, stable@vger.kernel.org, jlayton@kernel.org,
	linux-xfs@vger.kernel.org, hch@lst.de
Subject: Re: [PATCHSET v2] xfs: proposed bug fixes for 6.13
Message-ID: <Z1FNqV27x5hjnqQ9@redhat.com>
References: <173328106571.1145623.3212405760436181793.stgit@frogsfrogsfrogs>
 <Z1EBXqpMWGL306sh@redhat.com>
 <20241205064243.GD7837@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205064243.GD7837@frogsfrogsfrogs>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Wed, Dec 04, 2024 at 10:42:43PM -0800, Darrick J. Wong wrote:
> On Wed, Dec 04, 2024 at 07:26:54PM -0600, Bill O'Donnell wrote:
> > On Tue, Dec 03, 2024 at 07:02:23PM -0800, Darrick J. Wong wrote:
> > > Hi all,
> > > 
> > > Here are even more bugfixes for 6.13 that have been accumulating since
> > > 6.12 was released.
> > > 
> > > If you're going to start using this code, I strongly recommend pulling
> > > from my git trees, which are linked below.
> > > 
> > > With a bit of luck, this should all go splendidly.
> > > Comments and questions are, as always, welcome.
> > > 
> > > --D
> > 
> > Hi Darrick-
> > 
> > I must ask, why are these constant bug fixes and fixes for fixes, and
> > fixes for fixes for fixes often appearing? It's worrying that xfs is
> 
> Roughly speaking, the ~35 bugfixes can be split into three categories:
> 
> 1) Our vaunted^Wshitty review process didn't catch various coding bugs,
> and testing didn't trip over them until I started (ab)using precommit
> hooks for spot checking of inode/dquot/buffer log items.

You give little time for the review process.

> 
> 2) Most of the metadir/rtgroups fixes are for things that hch reworked
> towards the end of the six years the patchset has been under
> development, and that introduced bugs.  Did it make things easier for a
> second person to understand?  Yes.

No.

> 
> 3) The rest are mostly cases of the authors not fully understanding the
> subtleties of that which they were constructing (myself included!) and
> lucking out that the errors cancelled each other out until someone
> started wanting to use that code for a slightly different purpose, which
> wouldn't be possible until the bug finally got fixed.
> 
> 4) The dquot buffer changes have been a known problem since dchinner
> decided that RMW cycles in the AIL with inode buffers was having very
> bad effects on reclaim performance.  Nobody stepped up to convert dquots
> (even though I noted this at the time) so here I am years later because
> the mm got pissy at us in 6.12.
> 
> 5) XFS lit up a lot of new functionality this year, which means the code
> is ripe with bugfixing opportunities where cognitive friction comes into
> play.

I call bullshit. You guys are fast and loose with your patches. Giving
little time for review and soaking.

> 
> > becoming rather dodgy these days. Do things need to be this
> > complicated?
> 
> Yeah, they do.  We left behind the kindly old world where people didn't
> feed computers fuzzed datafiles and nobody got fired for a computer
> crashing periodically.  Nowadays it seems that everything has to be
> bulletproofed AND fast. :(

Cop-out answer.

> 
> --D
> 
> > -Bill
> > 
> > 
> > > 
> > > kernel git tree:
> > > https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=proposed-fixes-6.13
> > > ---
> > > Commits in this patchset:
> > >  * xfs: don't move nondir/nonreg temporary repair files to the metadir namespace
> > >  * xfs: don't crash on corrupt /quotas dirent
> > >  * xfs: check pre-metadir fields correctly
> > >  * xfs: fix zero byte checking in the superblock scrubber
> > >  * xfs: return from xfs_symlink_verify early on V4 filesystems
> > >  * xfs: port xfs_ioc_start_commit to multigrain timestamps
> > > ---
> > >  fs/xfs/libxfs/xfs_symlink_remote.c |    4 ++
> > >  fs/xfs/scrub/agheader.c            |   66 ++++++++++++++++++++++++++++--------
> > >  fs/xfs/scrub/tempfile.c            |    3 ++
> > >  fs/xfs/xfs_exchrange.c             |   14 ++++----
> > >  fs/xfs/xfs_qm.c                    |    7 ++++
> > >  5 files changed, 71 insertions(+), 23 deletions(-)
> > > 
> > > 
> > 
> > 
> 


