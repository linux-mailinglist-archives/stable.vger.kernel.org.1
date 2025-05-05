Return-Path: <stable+bounces-139702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B3FAA9595
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 16:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BC2D16C2E1
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 14:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0C91F30A4;
	Mon,  5 May 2025 14:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U+uc+ib4"
X-Original-To: stable@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308F0846C
	for <stable@vger.kernel.org>; Mon,  5 May 2025 14:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454942; cv=none; b=Y0+3grgNIi47hbDFj8/sr7EvO35TPYs2hC/MjCEVXGBRY82/cRwU9R+/b6BJLUOxXbaosSO5ikjHM78q0qFTVAL6BK92w3ddjkuqFx8fq22BqrFAW4tmAvUI9NQHFSriKcJwQ9m2MuEmAQjC+3tftRlraDXHydwACSUHXIdztIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454942; c=relaxed/simple;
	bh=dqA8Vi7Tjf7vqVmmWKxDXv+wTh9E1QSiZixL+5eDALc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYNDO2bkYTlVxi+Ne617FbCW93YkaF96sbqYtOSAIRFMv1NwrkDb4BVOXyf8llCJXYHPcV2I2jXASYjxH8CC/nrGa28b0gbeD5M7do2xJ1Vw6rw2hQgFnpIUvIyRQu2M+ojkWrd6hl7jG2gjiVEjmxfCIPeC1GmYg8TPBgeST3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U+uc+ib4; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 5 May 2025 10:22:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746454938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uh7estd9zAu0O/tk7w0y7NuBGjZGcTGPLKVSreiVaAs=;
	b=U+uc+ib4+1mljnJGKmb5XiNtprvdQoDRMTWfYpSoKGvkfhA6VbNwbFKt4sF6q1HAicTZ/8
	HPeJsSO34QAk3dogACidrqokGKuMlFF3gRLRXwQtfI0LiiR8FqQnWReIJbnOyadmMfOu9Y
	fxTizyTo9DoADuyMPkKvOtz3UQ6Wg50=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-bcachefs@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.14.y
Message-ID: <7jhqpuoe47jo3cm7hwo5mxstneacvws5ddxzyagyiayon3jldh@i6tnxq5z7ouz>
References: <hbrzmt73aol6f2fmqpsdtcevhb2sme6lz2otdn73vqpsmlstzt@egrywwkbtpfm>
 <2025050523-oversweet-mooned-3934@gregkh>
 <gjr5fogy6fuev264diupbdyoyat6pdwa2fklxaf6cvu4mr3vck@6vvfw7awb5qy>
 <2025050543-overkill-eradicate-2bdf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025050543-overkill-eradicate-2bdf@gregkh>
X-Migadu-Flow: FLOW_OUT

On Mon, May 05, 2025 at 04:06:55PM +0200, Greg Kroah-Hartman wrote:
> On Mon, May 05, 2025 at 09:54:24AM -0400, Kent Overstreet wrote:
> > On Mon, May 05, 2025 at 10:32:49AM +0200, Greg Kroah-Hartman wrote:
> > > On Fri, May 02, 2025 at 09:12:22PM -0400, Kent Overstreet wrote:
> > > > 
> > > > The following changes since commit 02a22be3c0003af08df510cba3d79d00c6495b74:
> > > > 
> > > >   bcachefs: bch2_ioctl_subvolume_destroy() fixes (2025-04-03 16:13:53 -0400)
> > > > 
> > > > are available in the Git repository at:
> > > > 
> > > >   git://evilpiepirate.org/bcachefs.git tags/bcachefs-for-6.14-2025-05-02
> > > > 
> > > > for you to fetch changes up to 52b17bca7b20663e5df6dbfc24cc2030259b64b6:
> > > > 
> > > >   bcachefs: Remove incorrect __counted_by annotation (2025-05-02 21:09:51 -0400)
> > > > 
> > > > ----------------------------------------------------------------
> > > > bcachefs fixes for 6.15
> > > > 
> > > > remove incorrect counted_by annotation, fixing FORTIFY_SOURCE crashes
> > > > that have been hitting arch users
> > > > 
> > > > ----------------------------------------------------------------
> > > > Alan Huang (1):
> > > >       bcachefs: Remove incorrect __counted_by annotation
> > > > 
> > > >  fs/bcachefs/xattr_format.h | 8 +++++++-
> > > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > > 
> > > You list 1 patch here, but if I pull this, I see 2 patches against the
> > > latest linux-6.14.y branch.  When rebased, the "additional" one goes
> > > away, as you already sent that to us in the past, so I'll just take the
> > > one that's left here, but please, make this more obvious what is
> > > happening.
> > 
> > That's because you're rebasing my patches.
> 
> Not really a "rebase", but rather a "cherry-pick", but we've been
> through this before, so no need to go over it again :)
> 
> > > Also, I see a lot of syzbot fixes going into bcachefs recently,
> > > hopefully those are all for issues that only affected the tree after
> > > 6.14 was released.
> > 
> > Until the experimental label comes off I'm only doing critical
> > backports - it really doesn't make any sense to do anything else right
> > now.
> 
> Ok.
> 
> > The syzbot stuff has had zero overlap with user reported bugs, and since
> > it's fuzzing the on disk image (and we don't support unprivilidged
> > mounts - yet, at least) - they haven't been a security concern. There's
> > been one security bug since 6.7, and you have that fix.
> 
> Great, thanks!

BTW - in the interim, if we do want to backport a wider set of fixes the
sane thing to do will be to forklift all of fs/bcachefs to the stable
kernels. QA here has been good, so regressions in Linus's tree have been
a non issue - in 6.15, all (2?) regressions were found and fixed before
rc1 came out.

This hasn't been an option yet because the required on disk format
upgrades have been too disruptive for stable kernels (the 6.14 upgrade
took ~hours on the big 50-100TB filesystems), but as of 6.15 that should
be over, so I've been giving some thought to the idea, especially since
usage is steadily ticking up...

