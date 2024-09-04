Return-Path: <stable+bounces-73098-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A69396C82F
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 22:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C1351C224F2
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 20:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DA340C03;
	Wed,  4 Sep 2024 20:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M0FPp0t0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCD41E7672;
	Wed,  4 Sep 2024 20:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725480693; cv=none; b=TDmUdhqEQ7mI3DVui0kz17vUvtCmWc0zvr6ZimhKb6LRyvdQ3/GjJheD4Pvay7g+L6fOQBf3PxLtBETMa7oTd7vXgr6G6ay1HxlqSyWe6jX8zDgotqIZ+IxYB/0IMTp6zXn/xGEgPxECVGfR0yF8ALmiUUNLfD+XsEmbgiKdj4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725480693; c=relaxed/simple;
	bh=DehHu6xAbURmG/4IvfJez3Wa6rd3rh+a7c46iCV4kV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Se8LxHk+/hgMzxWSqL7Uo4WosNRHXGx61774DIh2p7+z4eyJde5SCEXkEQJGdDsyoQyEnyws3TfgfedxyTLhJNpb4TZjp7OH5QLWk+UdKuxiXOOfKrLCXM6V/6LbJrlVZf+HJpBgVOu6OgsI2Yh4M/HVYQ5j1VJYa3kl/1m9ORc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M0FPp0t0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FEA4C4CEC2;
	Wed,  4 Sep 2024 20:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725480693;
	bh=DehHu6xAbURmG/4IvfJez3Wa6rd3rh+a7c46iCV4kV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M0FPp0t0h8bZR/Sis1VAY93F+bmKmXpbR5CK4M2AZ4VYTmoA/50rxA7UhgOX+8cEi
	 ChWOIBx70ZpOpjuJKNrSQ3bdTd5OBuS9dtLX0sOIPm0z4vD8Vd/IeT5xjE9iAKEROM
	 TKKY2YiIC4j/qhRGaATiqyko2nyGw0WUHmmwMjZE=
Date: Wed, 4 Sep 2024 22:11:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Richard Narron <richard@aaazen.com>
Cc: Linux stable <stable@vger.kernel.org>,
	Linux kernel <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Salvatore Bonaccorso <carnil@debian.org>
Subject: Re: [PATCH 5.15 000/215] 5.15.166-rc1 review
Message-ID: <2024090454-cardiac-headway-730b@gregkh>
References: <8c0d05-19e-de6d-4f21-9af4229a7e@aaazen.com>
 <2024090419-repent-resonant-14c1@gregkh>
 <fc713222-f7b1-d1c0-2aa2-c15f42d3873e@aaazen.com>
 <2024090413-unwed-ranging-befe@gregkh>
 <c84d90fc-9c71-c8f-c6a5-fd88c166f8f4@aaazen.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c84d90fc-9c71-c8f-c6a5-fd88c166f8f4@aaazen.com>

On Wed, Sep 04, 2024 at 01:00:26PM -0700, Richard Narron wrote:
> On Wed, 4 Sep 2024, Greg KH wrote:
> 
> > On Wed, Sep 04, 2024 at 05:48:09AM -0700, Richard Narron wrote:
> > > On Wed, 4 Sep 2024, Greg KH wrote:
> > >
> > > > On Mon, Sep 02, 2024 at 03:39:49PM -0700, Richard Narron wrote:
> > > > > I get an "out of memory" error when building Linux kernels 5.15.164,
> > > > > 5.15.165 and 5.15.166-rc1:
> > > > > ...
> > > > > cc1: out of memory allocating 180705472 bytes after a total of 283914240
> > > > > bytes
> > > > > ...
> > > > > make[4]: *** [scripts/Makefile.build:289:
> > > > > drivers/staging/media/atomisp/pci/isp/kernels/ynr/ynr_1.0/ia_css_ynr.host.o]
> > > > > Error 1
> > > > > ...
> > > > >
> > > > > I found a work around for this problem.
> > > > >
> > > > > Remove the six minmax patches introduced with kernel 5.15.164:
> > > > >
> > > > > minmax: allow comparisons of 'int' against 'unsigned char/short'
> > > > > minmax: allow min()/max()/clamp() if the arguments have the same
> > > > > minmax: clamp more efficiently by avoiding extra comparison
> > > > > minmax: fix header inclusions
> > > > > minmax: relax check to allow comparison between unsigned arguments
> > > > > minmax: sanity check constant bounds when clamping
> > > > >
> > > > > Can these 6 patches be removed or fixed?
> > > >
> > > > It's a bit late, as we rely on them for other changes.
> > > >
> > > > Perhaps just fixes for the files that you are seeing build crashes on?
> > > > I know a bunch of them went into Linus's tree for this issue, but we
> > > > didn't backport them as I didn't know what was, and was not, needed.  If
> > > > you can pinpoint the files that cause crashes, I can dig them up.
> > > >
> > >
> > > The first one to fail on 5.15.164 was:
> > > drivers/media/pci/solo6x10/solo6x10-core.o
> > >
> > > So I found and applied this patch to 5.15.164:
> > > [PATCH] media: solo6x10: replace max(a, min(b, c)) by clamp(b, a, c)
> >
> > What is the git commit id of that change?  I can't seem to find it.
> 
> 31e97d7c9ae3
> 
> >From Salvatore Bonaccorso to stable on 22 Aug 2024 19:19:27 +0200
> 
>   Subject: Please apply commit 31e97d7c9ae3 ("media: solo6x10: replace
> max(a, min(b, c)) by clamp(b, a, c)") to 6.1.y
> ...
>   "Note I suspect it is required as well for 5.15.164 (as the commits
> were backported there as well and 31e97d7c9ae3 now missing there)"

That is already in 5.15.166, can you verify it is resolved for you
there?

> > > Then the next to fail on 5.15.164 was:
> > > drivers/staging/media/atomisp/pci/isp/kernels/ynr/ynr_1.0/ia_css_ynr.host.o
> >
> > What .c file is this happening for?
> 
> Probably this one:
> drivers/staging/media/atomisp/pci/isp/kernels/ynr/ynr_1.0/ia_css_ynr.host.c

Did you see this also building this file in 6.10 or anything newer than
5.15.y?

thanks,

greg k-h

