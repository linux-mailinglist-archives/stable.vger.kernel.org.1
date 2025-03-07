Return-Path: <stable+bounces-121395-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAECA56A66
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 15:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01A49176A06
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 14:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AC21A23B8;
	Fri,  7 Mar 2025 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mjrDa3Na"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688241547C0
	for <stable@vger.kernel.org>; Fri,  7 Mar 2025 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741357894; cv=none; b=ue/5HGnyF5c/904fTDRcKvd7kiGhxwz/UI+8HYzhIj8K5fSqTMlb2Fp3MOBxr3ZpiCGWV/b/swRyCwAMtXoiGIVCyOm0VRD1i3oYJEnWmzFIC7QkQyJ3dOXhUQpoeeCFLg/hl6F3HHT278dHvKyzE+ppmBwlqkcVXUTqh3WZyvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741357894; c=relaxed/simple;
	bh=XYJNNCv5forrU/dyju2HGQ5XExkF/q7OPSpiPEw1JLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIwdW+X7GzBagseonlqnywJVKsw4svvlENvU80Z/cWMSKh+K8BAaR0cxtc35UjpGXA4JVyBKzp0vpEaN0JY0b86TA9dXIO34Xd9zbkKoN6WGxDppIODVGY87J24Hh45GUIgfU8XYNmPHMpvnWYsmwR6TzIa6I6qu4jbTsxrobu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mjrDa3Na; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A9C3C4CED1;
	Fri,  7 Mar 2025 14:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741357893;
	bh=XYJNNCv5forrU/dyju2HGQ5XExkF/q7OPSpiPEw1JLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mjrDa3Nah344IkXPJfQ6AMW2vpx7t5udEtKI6jXIgopfGQQXMv9RfqSKA2Qq3jsMZ
	 RmH8ZlOYR2dU3mPjg8Q9CdsISKbB1yj2F/5PvinzNGtjsfJOH3aPd2rM8qF6NS68XE
	 ce9C8ySmEthDVXP3X9YwEat5n7fOyhEUuGxI+RLM=
Date: Fri, 7 Mar 2025 15:31:30 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
Cc: Jared Finder <jared@finder.org>, stable@vger.kernel.org,
	Jann Horn <jannh@google.com>,
	Hanno =?iso-8859-1?Q?B=F6ck?= <hanno@hboeck.de>,
	Jiri Slaby <jirislaby@kernel.org>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH] tty: Require CAP_SYS_ADMIN for all usages of
 TIOCL_SELMOUSEREPORT
Message-ID: <2025030747-latter-purr-1ee0@gregkh>
References: <491f3df9de6593df8e70dbe77614b026@finder.org>
 <20250223205449.7432-2-gnoack3000@gmail.com>
 <20250307.9339126c0c96@gnoack.org>
 <2025030708-tidal-mothproof-0deb@gregkh>
 <20250307.80ee8ceb5f5b@gnoack.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250307.80ee8ceb5f5b@gnoack.org>

On Fri, Mar 07, 2025 at 02:55:37PM +0100, Günther Noack wrote:
> Hello Greg!
> 
> On Fri, Mar 07, 2025 at 12:05:43PM +0100, Greg Kroah-Hartman wrote:
> > On Fri, Mar 07, 2025 at 11:16:21AM +0100, Günther Noack wrote:
> > > On Sun, Feb 23, 2025 at 09:54:50PM +0100, Günther Noack wrote:
> > > > This requirement was overeagerly loosened in commit 2f83e38a095f
> > > > ("tty: Permit some TIOCL_SETSEL modes without CAP_SYS_ADMIN"), but as
> > > > it turns out,
> > > > 
> > > >   (1) the logic I implemented there was inconsistent (apologies!),
> > > > 
> > > >   (2) TIOCL_SELMOUSEREPORT might actually be a small security risk
> > > >       after all, and
> > > > 
> > > >   (3) TIOCL_SELMOUSEREPORT is only meant to be used by the mouse
> > > >       daemon (GPM or Consolation), which runs as CAP_SYS_ADMIN
> > > >       already.
> > > 
> > > 
> > > Greg and Jared: Friendly ping on this patch.
> > 
> > I think my bot found a problem with the v2 version so I was waiting for
> > a new one to meet the issues there, right?
> 
> I made a submission mistake with the previous patch, which your bot
> tripped over, but you already merged it into master and stable as
> commit 2f83e38a095f ("tty: Permit some TIOCL_SETSEL modes without
> CAP_SYS_ADMIN"):
> https://lore.kernel.org/all/2025011205-spinout-rewrap-2dfa@gregkh/
> 
> The patch I am submitting here is a new bugfix on top, for which I am
> seeking your approval, since the previous patch is already merged.  (I
> should have sent it as a new mail thread, I guess. :-/)
> 
> (If that helps, I explained the relationship between these different
> patches more visually in the table in
> https://lore.kernel.org/all/20250307.9339126c0c96@gnoack.org/.)

Ok, I am totally lost.  Ah, I see this patch now in my queue, it's in my
"grab-bag" of patches to get to "last" as it wasn't cc: to the proper
list (hint, use scripts/get_maintainer.pl, it would have shown you that
the linux-serial list should have been cc:ed.)

So don't worry, it's not lost, just sitting next to a bunch of other
patches I need to review "soon".

thanks,

greg k-h

