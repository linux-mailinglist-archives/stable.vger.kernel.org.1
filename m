Return-Path: <stable+bounces-59284-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F094930FCD
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 10:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B52CF1F21AD3
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 08:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E27185E52;
	Mon, 15 Jul 2024 08:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OSxyOhru"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419DA1849E8;
	Mon, 15 Jul 2024 08:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721032177; cv=none; b=cie2Y+BjYeVT9y0UjG1ycyWK+8x2uqS8jPWuqNTu33tYVgfN/5bTMyn5+mucyQYQ8KvM/5ZxuUJIxKwjANwpez3y6knCdts2NK2BYdWKgj9xrnR5eCnVZmPobL8tbNkKxUJmMXbdM7cSHIfoJmbnxsxpaz6w0FoHgoZmAimT/Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721032177; c=relaxed/simple;
	bh=wiTo8uBl8LYt418qIZjGZMOgjUMZtIisDShPynw5eOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIH+nHLUdzD0cwxSIg8sRa8deiGPW9qKRnQnMxM4pFOqBNJ/w9b2/4YpOZ1ian2zJ277K8AwJAYmC1MSIYJ8YRrdRdj7MTu6m/jP4JGZ67Yod7W0eMIvrdmnkmoxJ1FdhYVfxWRjwdNqWtHVtuGHGUbGezqEWCjV7lX+QCJNDI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OSxyOhru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 582D7C4AF0B;
	Mon, 15 Jul 2024 08:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721032176;
	bh=wiTo8uBl8LYt418qIZjGZMOgjUMZtIisDShPynw5eOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OSxyOhruJLRr7Wo0Q5xnXFqG94BSlCOaeiCveX1PJmeA+5RqytgkkTW7hDFKDGFuz
	 v9t/7p1pU7EG9BtMn1IXRA8Gjh5JMfW+s926C3TUjiwr/pG/4DQEu8Y8iJ/bLLi5L0
	 SupB/ic8cW/DOdfx7F0DwhjzLcaMkOGoiDN2vops=
Date: Mon, 15 Jul 2024 10:29:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: =?utf-8?Q?Micha=C5=82?= Pecio <michal.pecio@gmail.com>,
	elatllat@gmail.com, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, mathias.nyman@linux.intel.com,
	niklas.neronin@linux.intel.com, stable@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [PATCH 6.1 000/102] 6.1.98-rc1 review
Message-ID: <2024071556-perceive-zit-6a0c@gregkh>
References: <CA+3zgmsCgQs_LVV6fOwu3v2t_Vd=C3Wrv9QrbNpsmMq4RD=ZoQ@mail.gmail.com>
 <20240714173043.668756e4@foxbook>
 <ZpP3RU-MKb4pMmZH@eldamar.lan>
 <2024071540-commute-curler-26d3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024071540-commute-curler-26d3@gregkh>

On Mon, Jul 15, 2024 at 07:45:07AM +0200, Greg KH wrote:
> On Sun, Jul 14, 2024 at 06:05:25PM +0200, Salvatore Bonaccorso wrote:
> > Hi,
> > 
> > On Sun, Jul 14, 2024 at 05:32:39PM +0200, Michał Pecio wrote:
> > > This looks like bug 219039, please see if my suggested solution works.
> > > 
> > > The upstream commit is correct, because the call to inc_deq() has been
> > > moved outside handle_tx_event() so there is no longer this critical
> > > difference between doing 'goto cleanup' and 'return 0'. The intended
> > > change of this commit also makes sense to me.
> > > 
> > > This refactor is already present in v6.9 so I don't think the commit
> > > will have any effect besides fixing the isochronous bug which it is
> > > meant to fix.
> > > 
> > > But it is not present in v6.6 and v6.1, so they break/crash/hang/etc.
> > > Symptoms may vary, but I believe the root cause is the same because the
> > > code is visibly wrong.
> > > 
> > > 
> > > I would like to use this opportunity to point out that the xhci driver
> > > is currenty undergoing (much needed IMO) cleanups and refactors and
> > > this is not the first time when a naive, verbatim backport is attempted
> > > of a patch which works fine on upstream, but causes problems on earlier
> > > kernels. These things need special scrutiny, beyond just "CC:stable".
> > 
> > For tracking I guess this should go as well to the regressions list?
> > 
> > #regzbot introduced: 948554f1bb16e15b90006c109c3a558c66d4c4ac
> > #regzbot title: freezes on plugging USB connector due to 948554f1bb16 ("usb: xhci: prevent potential failure in handle_tx_event() for Transfer events without TRB")
> > #regzbot monitor: https://bugzilla.kernel.org/show_bug.cgi?id=219039
> > 
> > Thorsten I hope I got the most bits correctly, how would one inform
> > regzbot about the regresssion for 6.1.98 and 6.6.39 but not happening
> > in the upper versions?
> 
> I'll handle this and go release new kernels with just this reverted in
> it.  Let my morning coffee kick in first...

Should all now be fixed in the 6.6.40 and 6.1.99 releases.  If not,
please let me know.

thanks,

greg k-h

