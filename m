Return-Path: <stable+bounces-197109-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88035C8EA2B
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 14:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93B4F3A866C
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 13:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA95127E06C;
	Thu, 27 Nov 2025 13:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SkBz925/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA74622759C
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 13:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764251513; cv=none; b=btvAsbuo4Ehjc7dZBTlJn624dfhbMSEpqQ+sFlnVWRjQZD6B9XpB210z91lXRU9Ze+OY6xADmcurWEflLPouqOj8z3Qt2X17RUfxQFbv3Sjbba2tsFRvhlTuM8CDPhxfWLotRPxAP9+AuG8eIbxlVyggbpMtoL3go5IoWlJjqOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764251513; c=relaxed/simple;
	bh=eoHz/3tJbsd4wMAL8xs/k+Qt2IeD5tZ+X3aHmdsTFp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=paPJNv78+Dr+RReooUNMZyXBPhxh/7mNnr5dy8ryVZBQ8VNlXFqX/LmrfYlznomEK8HK7U0P8LwWISRrMKk/65waO6WUlne7Acakb+w0KL+/fBwmStNl0rFQsoKei1FN3CPOM+FJWvQ6PifB10hiFtRdvMz0jrFAKifkE3K3jbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SkBz925/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2999AC113D0;
	Thu, 27 Nov 2025 13:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764251513;
	bh=eoHz/3tJbsd4wMAL8xs/k+Qt2IeD5tZ+X3aHmdsTFp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SkBz925/I07XQwHqlJt8WJfrnozQHiRcP6AORhvik1wFoosj4P1be1QbzigIaPR8a
	 TIkuZWV2+QAmRa9JnamrxSONAONcBJGr05XnpCzhtZ2OMjsBozcvtHfa/WCgnSFW2l
	 RloOFo9Bftj0TbRoRt611HqmOJMzNNnJ0/ccOx28=
Date: Thu, 27 Nov 2025 14:51:50 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, stable@vger.kernel.org,
	linus.walleij@linaro.org, patches@opensource.cirrus.com
Subject: Re: [PATCH] Revert "gpio: swnode: don't use the swnode's name as the
 key for GPIO lookup"
Message-ID: <2025112757-squash-hesitant-d8d6@gregkh>
References: <20251125102924.3612459-1-ckeepax@opensource.cirrus.com>
 <CAMRc=MfoycdnEFXU3yDUp4eJwDfkChNhXDQ-aoyoBcLxw_tmpQ@mail.gmail.com>
 <2025112531-glance-majorette-40b0@gregkh>
 <aSWXcml8rkX99MEy@opensource.cirrus.com>
 <2025112505-unlovable-crease-cfe2@gregkh>
 <aSWl95gPfnaaq1gR@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aSWl95gPfnaaq1gR@opensource.cirrus.com>

On Tue, Nov 25, 2025 at 12:49:59PM +0000, Charles Keepax wrote:
> On Tue, Nov 25, 2025 at 12:58:30PM +0100, Greg KH wrote:
> > On Tue, Nov 25, 2025 at 11:48:02AM +0000, Charles Keepax wrote:
> > > On Tue, Nov 25, 2025 at 12:43:16PM +0100, Greg KH wrote:
> > > > On Tue, Nov 25, 2025 at 11:31:56AM +0100, Bartosz Golaszewski wrote:
> > > > > On Tue, Nov 25, 2025 at 11:29 AM Charles Keepax
> > > > > <ckeepax@opensource.cirrus.com> wrote:
> > > > > >
> > > > > > This reverts commit 25decf0469d4c91d90aa2e28d996aed276bfc622.
> > > > > >
> > > > > > This software node change doesn't actually fix any current issues
> > > > > > with the kernel, it is an improvement to the lookup process rather
> > > > > > than fixing a live bug. It also causes a couple of regressions with
> > > > > > shipping laptops, which relied on the label based lookup.
> > > > > >
> > > > > > There is a fix for the regressions in mainline, the first 5 patches
> > > > > > of [1]. However, those patches are fairly substantial changes and
> > > > > > given the patch causing the regression doesn't actually fix a bug
> > > > > > it seems better to just revert it in stable.
> > > > > >
> > > > > > CC: stable@vger.kernel.org # 6.12, 6.17
> > > > > > Link: https://lore.kernel.org/linux-sound/20251120-reset-gpios-swnodes-v7-0-a100493a0f4b@linaro.org/ [1]
> > > > > > Closes: https://github.com/thesofproject/linux/issues/5599
> > > > > > Closes: https://github.com/thesofproject/linux/issues/5603
> > > > > > Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > > > > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > > > > > ---
> > > > > >
> > > > > > I wasn't exactly sure of the proceedure for reverting a patch that was
> > > > > > cherry-picked to stable, so apologies if I have made any mistakes here
> > > > > > but happy to update if necessary.
> > > > > >
> > > > > 
> > > > > Yes, I'd like to stress the fact that this MUST NOT be reverted in
> > > > > mainline, only in v6.12 and v6.17 stable branches.
> > > > 
> > > > But why?  Why not take the upstream changes instead?  We would much
> > > > rather do that as it reduces the divergance.  5 patches is trivial for
> > > > us to take.
> > > 
> > > My thinking was that they are a bit invasive for backports, as
> > > noted in the commit message. But if that is the preferred option
> > > I can do a series with those instead?
> > 
> > I'd prefer to take what is upstream, it's simpler over the long term to
> > do so.
> > 
> 
> I really doubt this will end up simpler, as the comparison here
> is a) not backporting a change that probably shouldn't have gone
> to stable in the first place vs. b) backport a bunch of quite
> invasive changes.

But think about future changes/fixes.  6.12 is going to be around for 5
more years, doing one-off fixes ensures that any future changes/fixes
will NOT apply to 6.12.y and require custom changes that are almost
guaranteed to break.

Again, it is almost always better to take the same changes that are in
Linus's tree as they are better tested and future fixes apply cleaner.

But I defer to the maintainer, of the maintainer says to take this
one-off change (i.e. revert), I'll gladly do so.  Just trying to explain
that taking lots of upstream changes is almost always the right thing to
do in the long run.  And we are in this for the long run.

> Do we have to wait for the fixes to hit Linus's tree before
> pushing them to stable? As they are still in Philipp Zabel's
> reset tree at the moment and I would quite like to stem the
> rising tide of tickets I am getting about audio breaking on
> peoples laptops as soon as possible.

Yes, we need the fixes there first.

thanks,

greg k-h

