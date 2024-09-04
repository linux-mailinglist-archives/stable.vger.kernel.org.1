Return-Path: <stable+bounces-73097-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BDB96C815
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 22:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C24A6B207D0
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 20:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCE113B59E;
	Wed,  4 Sep 2024 20:00:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.aaazen.com (99-33-87-210.lightspeed.sntcca.sbcglobal.net [99.33.87.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE191F19A;
	Wed,  4 Sep 2024 20:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.33.87.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725480029; cv=none; b=kGJFytfZ+dg1PrDZ2RsG7OqsIvoAdJ9XTex7zdoJPLaKC86fR0Hy3x1v4F+5xxwlq8MvJFl01bsSUWqlVfsh5rSi3dAJiEAha0oHOMTHH2jwV25zOxgF3J4inSh7ZegXgiyEVRruv9WHV84vveXv2GNyu5h5rjyC0gXf9p3Og9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725480029; c=relaxed/simple;
	bh=N834h+TkJfRL/sE0PnQIG+ivUj/iOybR2xa6477cOl8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OxuI1NxqgIsr8IxRtK+yFClPxpIwUva0zZ1ljH7xL/x4mk5AqYQuO6oPO3A7o+5L3oxSqTsxYcvFpXziv3NiMHjgnAWA9QypyU6I4NX2L3LxQNxPzxYFcd9LXXixDbqDquPQhLbVWkAcAJOsDRpncWTVPpBh8fvI1bUvPwg8Wug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aaazen.com; spf=pass smtp.mailfrom=aaazen.com; arc=none smtp.client-ip=99.33.87.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aaazen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aaazen.com
Received: from localhost (localhost [127.0.0.1])
	by thursday.test (OpenSMTPD) with ESMTP id fb06cc91;
	Wed, 4 Sep 2024 13:00:26 -0700 (PDT)
Date: Wed, 4 Sep 2024 13:00:26 -0700 (PDT)
From: Richard Narron <richard@aaazen.com>
X-X-Sender: richard@thursday.test
To: Greg KH <gregkh@linuxfoundation.org>
cc: Linux stable <stable@vger.kernel.org>, 
    Linux kernel <linux-kernel@vger.kernel.org>, 
    Linus Torvalds <torvalds@linux-foundation.org>, 
    Salvatore Bonaccorso <carnil@debian.org>
Subject: Re: [PATCH 5.15 000/215] 5.15.166-rc1 review
In-Reply-To: <2024090413-unwed-ranging-befe@gregkh>
Message-ID: <c84d90fc-9c71-c8f-c6a5-fd88c166f8f4@aaazen.com>
References: <8c0d05-19e-de6d-4f21-9af4229a7e@aaazen.com> <2024090419-repent-resonant-14c1@gregkh> <fc713222-f7b1-d1c0-2aa2-c15f42d3873e@aaazen.com> <2024090413-unwed-ranging-befe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 4 Sep 2024, Greg KH wrote:

> On Wed, Sep 04, 2024 at 05:48:09AM -0700, Richard Narron wrote:
> > On Wed, 4 Sep 2024, Greg KH wrote:
> >
> > > On Mon, Sep 02, 2024 at 03:39:49PM -0700, Richard Narron wrote:
> > > > I get an "out of memory" error when building Linux kernels 5.15.164,
> > > > 5.15.165 and 5.15.166-rc1:
> > > > ...
> > > > cc1: out of memory allocating 180705472 bytes after a total of 283914240
> > > > bytes
> > > > ...
> > > > make[4]: *** [scripts/Makefile.build:289:
> > > > drivers/staging/media/atomisp/pci/isp/kernels/ynr/ynr_1.0/ia_css_ynr.host.o]
> > > > Error 1
> > > > ...
> > > >
> > > > I found a work around for this problem.
> > > >
> > > > Remove the six minmax patches introduced with kernel 5.15.164:
> > > >
> > > > minmax: allow comparisons of 'int' against 'unsigned char/short'
> > > > minmax: allow min()/max()/clamp() if the arguments have the same
> > > > minmax: clamp more efficiently by avoiding extra comparison
> > > > minmax: fix header inclusions
> > > > minmax: relax check to allow comparison between unsigned arguments
> > > > minmax: sanity check constant bounds when clamping
> > > >
> > > > Can these 6 patches be removed or fixed?
> > >
> > > It's a bit late, as we rely on them for other changes.
> > >
> > > Perhaps just fixes for the files that you are seeing build crashes on?
> > > I know a bunch of them went into Linus's tree for this issue, but we
> > > didn't backport them as I didn't know what was, and was not, needed.  If
> > > you can pinpoint the files that cause crashes, I can dig them up.
> > >
> >
> > The first one to fail on 5.15.164 was:
> > drivers/media/pci/solo6x10/solo6x10-core.o
> >
> > So I found and applied this patch to 5.15.164:
> > [PATCH] media: solo6x10: replace max(a, min(b, c)) by clamp(b, a, c)
>
> What is the git commit id of that change?  I can't seem to find it.

31e97d7c9ae3

From Salvatore Bonaccorso to stable on 22 Aug 2024 19:19:27 +0200

  Subject: Please apply commit 31e97d7c9ae3 ("media: solo6x10: replace
max(a, min(b, c)) by clamp(b, a, c)") to 6.1.y
...
  "Note I suspect it is required as well for 5.15.164 (as the commits
were backported there as well and 31e97d7c9ae3 now missing there)"

>
> > Then the next to fail on 5.15.164 was:
> > drivers/staging/media/atomisp/pci/isp/kernels/ynr/ynr_1.0/ia_css_ynr.host.o
>
> What .c file is this happening for?

Probably this one:
drivers/staging/media/atomisp/pci/isp/kernels/ynr/ynr_1.0/ia_css_ynr.host.c

Richard Narron

