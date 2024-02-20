Return-Path: <stable+bounces-20853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6460185C296
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 18:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06ABF1C243FC
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 17:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B03876C95;
	Tue, 20 Feb 2024 17:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MY29Rcng"
X-Original-To: stable@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7627876C8F
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 17:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708449931; cv=none; b=Nv8A50YaK4v4el+QMhjFi5cQczCG1LM9G6zfDbS5Dw0CHyUxsh1x/oXABuZstyDfjWYEKib7TiPsZs5BUqIXct+aICnSQJCScuREoK2CdfgUA0pS+4Fsjrvoi3NOlqMJq4/BanJ/UNFDpj+x6FAxXQ+Rw3tgazyMzRi7RGIgZh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708449931; c=relaxed/simple;
	bh=7DoFv3ud+YVzfH5w//bbhkrPFbfyVKzScJzS7+qnQ7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhHniWstawINnRIP4fCNNcR24JsOug14i3ib+vCS8t7rMNHbUljVqjBvrZ3sZB28UAd0dgfQzN7pDGsMCI1Z+jVUgJd5Hx3tN374FNP6LHHudqFIW1dNzaW9sWYARCsGfKVe3BErPwbfLcb1qV4V2SW3JT93LH909cLzYQMVNdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MY29Rcng; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 20 Feb 2024 12:25:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708449927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3ik97lVNWvt8KM0a/RNfbzGfQce3+jtEiK9rt6tkdA8=;
	b=MY29RcnghzCT8CLqQcsbvw0gBuzbi37X9zrGLXzZ0mTiYfDbGXDZPEFFrgsV6GhKBA57/e
	1dZjaGCxNMt0MQhv7hCWxAvJgp+VonbVoOSX9V+nJZuPdlejaio81bIdMu7gdcwlkSZTt0
	iJzFriBa34ULCqeofcwcN9UPAPsrYME=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs stable updates for v6.7
Message-ID: <pkearorf3vty5zqui6souxaesd57e4oef2ds45da7sb4mfqij3@5l3r6f7uwgwe>
References: <6yl6zvu2pa3mz7irsaax5ivp6kh3dae5kaslvst7yafmg6672g@mskleu2vjfp2>
 <2024021307-reactive-woven-8543@gregkh>
 <2024021300-deck-duffel-5d2b@gregkh>
 <jhwinzfpw2xjjdwsgqsrtjnzcqdbfoqev3qrm65oaxktua4c7m@mes2iwvk2yep>
 <2024021419-tumbling-rewind-dd83@gregkh>
 <2024022024-plywood-energize-f059@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024022024-plywood-energize-f059@gregkh>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 20, 2024 at 03:34:52PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Feb 14, 2024 at 07:51:01AM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Feb 13, 2024 at 09:28:37PM -0500, Kent Overstreet wrote:
> > > On Tue, Feb 13, 2024 at 03:44:25PM +0100, Greg Kroah-Hartman wrote:
> > > > On Tue, Feb 13, 2024 at 03:38:10PM +0100, Greg Kroah-Hartman wrote:
> > > > > On Thu, Feb 08, 2024 at 08:14:39PM -0500, Kent Overstreet wrote:
> > > > > > Hi Greg, few stable updates for you -
> > > > > > 
> > > > > > Cheers,
> > > > > > Kent
> > > > > > 
> > > > > > The following changes since commit 0dd3ee31125508cd67f7e7172247f05b7fd1753a:
> > > > > > 
> > > > > >   Linux 6.7 (2024-01-07 12:18:38 -0800)
> > > > > > 
> > > > > > are available in the Git repository at:
> > > > > > 
> > > > > >   https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-for-v6.7-stable-20240208
> > > > > > 
> > > > > > for you to fetch changes up to f1582f4774ac7c30c5460a8c7a6e5a82b9ce5a6a:
> > > > > > 
> > > > > >   bcachefs: time_stats: Check for last_event == 0 when updating freq stats (2024-02-08 15:33:11 -0500)
> > > > > 
> > > > > This didn't work well :(
> > > > > 
> > > > > All of the original git commit ids are gone, and for me to look them up
> > > > > and add them back by hand is a pain.  I'll do it this time, but next
> > > > > time can you please include them in the commit somewhere (cherry-pick -x
> > > > > will do it automatically for you)
> > > > > 
> > > > > Let's see if I can figure it out...
> > > > 
> > > > I got all but 3 applied, can you please send an updated set of 3 patches
> > > > for the ones I couldn't just cherry-pick from Linus's tree?
> > > 
> > > New pull request work?
> > > 
> > > The following changes since commit 0dd3ee31125508cd67f7e7172247f05b7fd1753a:
> > > 
> > >   Linux 6.7 (2024-01-07 12:18:38 -0800)
> > > 
> > > are available in the Git repository at:
> > > 
> > >   https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-6.7-stable-2024-02-13
> > 
> > Thanks, I'll look at these after this round of -rc kernels are released,
> > which should have most of these in the release alraedy, but not all.
> 
> Didn't work, can you rebase on 6.7.5 please?  I tried to rebase the tree
> here, but it gave me rejects that I didn't know how to resolve.

Because sasha cherry picked some of those fixes himself, despite an
explicit ack that he wouldn't.

And one of the fixes had a locking bug, and he missed the fix for that.

You're going to have to revert all that if you want my pull request to
apply.

