Return-Path: <stable+bounces-98757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0509B9E5031
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 09:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE54282BC8
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 08:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A1B1D3564;
	Thu,  5 Dec 2024 08:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C23rppL6"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B55A16F27E
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 08:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733388484; cv=none; b=eR5bbNt4gQQv6NyGHSppsL73YykHTWQTyUSeCrts5dYSC5xuVG5MOGYKIaW5gJy/rQ3EZfZKrF11RCRUl1hngYilb8P5NA7oZVQBd+BTFvUo9V/jL8RHelmUB4WRTqLQpCvX9s3aGeo9DaHNQtD+yCM2ous+K1xoqn3phsvge04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733388484; c=relaxed/simple;
	bh=wYDw1TuN2k35SkoIU0toiEcsVuzpIP7INLAH3/IoOlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZU8YwWOFPFn0mlezV0KcLAKMrIt7cioazLkd69cc6rAa4tpvrGpDJYBfhKSSJkFGlyT8PJem5Ve/oGcAId2zsoxa4X2kGJJJcrwxyBcBq5pdvbYeDJun1+m7F3Itx3gORSfgBV/AKp5KxwuoOdZVNBJe7CWAfJIcdyvZLjuhmVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C23rppL6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733388481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ccQzRwMGVsbCgo9un1k/hDN15wwRwt7Gy/SqmL8E9vc=;
	b=C23rppL6VOyuyULNHoIjN/CWAKSwqJB7nJ3tc49z7zIS9kIuM5Exjju6etVomhMW2OhpId
	xgj6+t8RywqcTjaOKcHdCMwBIU3j28sSZUrYF1g4w68dHggf6Kiuinv5EvWEYobJWssAXp
	abgLpMADqhu/poXuXjqDEjr8TCuRnFE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-388-qIMSRSmVPxGb32FvCtITKg-1; Thu,
 05 Dec 2024 03:47:55 -0500
X-MC-Unique: qIMSRSmVPxGb32FvCtITKg-1
X-Mimecast-MFC-AGG-ID: qIMSRSmVPxGb32FvCtITKg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A5FDC19560BD;
	Thu,  5 Dec 2024 08:47:53 +0000 (UTC)
Received: from redhat.com (unknown [10.22.64.4])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C1D491956052;
	Thu,  5 Dec 2024 08:47:51 +0000 (UTC)
Date: Thu, 5 Dec 2024 02:47:49 -0600
From: Bill O'Donnell <bodonnel@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, cem@kernel.org,
	stable@vger.kernel.org, jlayton@kernel.org,
	linux-xfs@vger.kernel.org, hch@lst.de
Subject: Re: [PATCHSET v2] xfs: proposed bug fixes for 6.13
Message-ID: <Z1FotR1TR8y_kY4D@redhat.com>
References: <173328106571.1145623.3212405760436181793.stgit@frogsfrogsfrogs>
 <Z1EBXqpMWGL306sh@redhat.com>
 <20241205064243.GD7837@frogsfrogsfrogs>
 <Z1FNqV27x5hjnqQ9@redhat.com>
 <Z1FPGXpTIJ1Fc2Xy@infradead.org>
 <Z1FQdYEXLR5BoOE-@redhat.com>
 <20241205073321.GH7837@frogsfrogsfrogs>
 <Z1Facuy97Xxj9mKO@redhat.com>
 <Z1Fd-FVR84x3fLVd@redhat.com>
 <2024120533-dirtiness-streak-c69d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024120533-dirtiness-streak-c69d@gregkh>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Dec 05, 2024 at 09:39:42AM +0100, Greg KH wrote:
> On Thu, Dec 05, 2024 at 02:02:00AM -0600, Bill O'Donnell wrote:
> > On Thu, Dec 05, 2024 at 01:46:58AM -0600, Bill O'Donnell wrote:
> > > On Wed, Dec 04, 2024 at 11:33:21PM -0800, Darrick J. Wong wrote:
> > > > On Thu, Dec 05, 2024 at 01:04:21AM -0600, Bill O'Donnell wrote:
> > > > > On Wed, Dec 04, 2024 at 10:58:33PM -0800, Christoph Hellwig wrote:
> > > > > > On Thu, Dec 05, 2024 at 12:52:25AM -0600, Bill O'Donnell wrote:
> > > > > > > > 1) Our vaunted^Wshitty review process didn't catch various coding bugs,
> > > > > > > > and testing didn't trip over them until I started (ab)using precommit
> > > > > > > > hooks for spot checking of inode/dquot/buffer log items.
> > > > > > > 
> > > > > > > You give little time for the review process.
> > > > 
> > > > Seriously?!
> > > > 
> > > > Metadir has been out for review in some form or another since January
> > > > 2019[1].  If five years and eleven months is not sufficient for you to
> > > > review a patchset or even to make enough noise that I'm aware that
> > > > you're even reading my code, then I don't want you ever to touch any of
> > > > my patchsets ever again.
> > > > 
> > > > > > I don't really think that is true.  But if you feel you need more time
> > > > > > please clearly ask for it.  I've done that in the past and most of the
> > > > > > time the relevant people acted on it (not always).
> > > > > > 
> > > > > > > > 2) Most of the metadir/rtgroups fixes are for things that hch reworked
> > > > > > > > towards the end of the six years the patchset has been under
> > > > > > > > development, and that introduced bugs.  Did it make things easier for a
> > > > > > > > second person to understand?  Yes.
> > > > > > > 
> > > > > > > No.
> > > > > > 
> > > > > > So you speak for other people here?
> > > > > 
> > > > > No. I speak for myself. A lowly downstream developer.
> > > > > 
> > > > > > 
> > > > > > > I call bullshit. You guys are fast and loose with your patches. Giving
> > > > > > > little time for review and soaking.
> > > > > > 
> > > > > > I'm not sure who "you" is, but please say what is going wrong and what
> > > > > > you'd like to do better.
> > > > > 
> > > > > You and Darrick. Can I be much clearer?
> > > > > 
> > > > > > 
> > > > > > > > > becoming rather dodgy these days. Do things need to be this
> > > > > > > > > complicated?
> > > > > > > > 
> > > > > > > > Yeah, they do.  We left behind the kindly old world where people didn't
> > > > > > > > feed computers fuzzed datafiles and nobody got fired for a computer
> > > > > > > > crashing periodically.  Nowadays it seems that everything has to be
> > > > > > > > bulletproofed AND fast. :(
> > > > > > > 
> > > > > > > Cop-out answer.
> > > > > > 
> > > > > > What Darrick wrote feels a little snarky, but he has a very valid
> > > > > > point.  A lot of recent bug fixes come from better test coverage, where
> > > > > > better test coverage is mostly two new fuzzers hitting things, or
> > > > > > people using existing code for different things that weren't tested
> > > > > > much before.  And Darrick is single handedly responsible for a large
> > > > > > part of the better test coverage, both due to fuzzing and specific
> > > > > > xfstests.  As someone who's done a fair amount of new development
> > > > > > recently I'm extremely glad about all this extra coverage.
> > > > > > 
> > > > > I think you are killing xfs with your fast and loose patches.
> > > > 
> > > > Go work on the maintenance mode filesystems like JFS then.  Shaggy would
> > > > probably love it if someone took on some of that.
> > > 
> > > No idea who "Shaggy" is. Nor do I care.	   
> > > > 
> > > > > Downstreamers like me are having to clean up the mess you make of
> > > > > things.
> > > > 
> > > > What are you doing downstream these days, exactly?  You don't
> > > > participate in the LTS process at all, and your employer boasts about
> > > > ignoring that community process.  If your employer chooses to perform
> > > > independent forklift upgrades of the XFS codebase in its product every
> > > > three months and you don't like that, take it up with them, not
> > > > upstream.
> > 
> > Why are you such a nasty person? I try to get along with people, but you're
> > impossible. I've been an engineer for 40+ years, and I've never encountered such
> > an arrogant one as you.
> 
> I have to step in here, sorry.
> 
> Please take a beat and relax and maybe get some sleep before you respond
> again.  Darrick is not being "nasty" here at all, but reiterating the
> fact that your company does do huge fork-lifts of code into their kernel
> tree.  If that development model doesn't work for you, please work with
> your company to change it.
> 
> And if you wish to help out here, please do so by reviewing and even
> better yet, testing, the proposed changes.  If you can't just suck down
> a patch series and put it into your test framework with a few
> keystrokes, perhaps that needs to be worked on to make it simpler to do
> from your side (i.e. that's what most of us do here with our development
> systems.)
> 
> By critisizing the mere posting of bugfixes, you aren't helping anything
> out at all, sorry.  Bugfixes are good, I don't know why you don't want
> even more, that means that people are testing and finding issues to fix!
> Surely you don't want the people finding the issues to be your users,
> right?
> 
> thanks,

Thank you for putting this in a better perspective.
-Bill

> 
> greg k-h
> 


