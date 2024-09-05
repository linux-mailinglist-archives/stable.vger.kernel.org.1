Return-Path: <stable+bounces-73684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 839C396E652
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 01:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4121B287412
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 23:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBBD199E9D;
	Thu,  5 Sep 2024 23:30:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.aaazen.com (99-33-87-210.lightspeed.sntcca.sbcglobal.net [99.33.87.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F2C17C991;
	Thu,  5 Sep 2024 23:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.33.87.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725579006; cv=none; b=TQRkqVWiiC8CSZYHMw8FEjTGet9YbD9A5ZqMWk6ZX6lmDWM2PdnOUI1+6kdttekwSa/GlOIUH/xC2itAu8ICPbjYEX45hqoNbESIET4c2jCi4TykLq57wcRD61m2IZDexpSKZL9MQqHS5q9MfbW2XLaMCZY83Q47TFM2FHbHi/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725579006; c=relaxed/simple;
	bh=es0dKRV5+BGqgD898Y3lT7VP1VCprSJlCg6xlLbdZ/4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FQkf7xDK9tQR85KV08SlvQQZEaEMYop2lwrWvKCmWi1YKS/7npUW6aHb7Gs1LFjlcclqKQ88+PhKS6bPv4KuZ+WN60Pp3+KEBMU4cBkqa/5pK9zA8aeXZkVBMXaNjStJe23iji4RgXI2uMVwZaWs5gtlk2p2GjofZPSLkcn+Rg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aaazen.com; spf=pass smtp.mailfrom=aaazen.com; arc=none smtp.client-ip=99.33.87.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aaazen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aaazen.com
Received: from localhost (localhost [127.0.0.1])
	by thursday.test (OpenSMTPD) with ESMTP id 96369a6d;
	Thu, 5 Sep 2024 16:29:58 -0700 (PDT)
Date: Thu, 5 Sep 2024 16:29:58 -0700 (PDT)
From: Richard Narron <richard@aaazen.com>
X-X-Sender: richard@thursday.test
To: Greg KH <gregkh@linuxfoundation.org>
cc: Linux stable <stable@vger.kernel.org>, 
    Linux kernel <linux-kernel@vger.kernel.org>, 
    Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 5.15 000/215] 5.15.166-rc1 review
In-Reply-To: <2024090454-cardiac-headway-730b@gregkh>
Message-ID: <8d92d7b7-6334-b9af-ee1c-4ce56d207a26@aaazen.com>
References: <8c0d05-19e-de6d-4f21-9af4229a7e@aaazen.com> <2024090419-repent-resonant-14c1@gregkh> <fc713222-f7b1-d1c0-2aa2-c15f42d3873e@aaazen.com> <2024090413-unwed-ranging-befe@gregkh> <c84d90fc-9c71-c8f-c6a5-fd88c166f8f4@aaazen.com>
 <2024090454-cardiac-headway-730b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 4 Sep 2024, Greg KH wrote:

> On Wed, Sep 04, 2024 at 01:00:26PM -0700, Richard Narron wrote:
> > On Wed, 4 Sep 2024, Greg KH wrote:
> >
> > > On Wed, Sep 04, 2024 at 05:48:09AM -0700, Richard Narron wrote:
> > > > On Wed, 4 Sep 2024, Greg KH wrote:
> > > >
> > > > > On Mon, Sep 02, 2024 at 03:39:49PM -0700, Richard Narron wrote:
> > > > > > I get an "out of memory" error when building Linux kernels 5.15.164,
> > > > > > 5.15.165 and 5.15.166-rc1:
> > > > > > ...
> > > > > > cc1: out of memory allocating 180705472 bytes after a total of 283914240
> > > > > > bytes
> > > > > > ...
> > > > > > make[4]: *** [scripts/Makefile.build:289:
> > > > > > drivers/staging/media/atomisp/pci/isp/kernels/ynr/ynr_1.0/ia_css_ynr.host.o]
> > > > > > Error 1
> > > > > > ...
> > > > > >
> > > > > > I found a work around for this problem.
> > > > > >
> > > > > > Remove the six minmax patches introduced with kernel 5.15.164:
> > > > > >
> > > > > > minmax: allow comparisons of 'int' against 'unsigned char/short'
> > > > > > minmax: allow min()/max()/clamp() if the arguments have the same
> > > > > > minmax: clamp more efficiently by avoiding extra comparison
> > > > > > minmax: fix header inclusions
> > > > > > minmax: relax check to allow comparison between unsigned arguments
> > > > > > minmax: sanity check constant bounds when clamping
> > > > > >
> > > > > > Can these 6 patches be removed or fixed?
> > > > >
> > > > > It's a bit late, as we rely on them for other changes.
> > > > >
> > > > > Perhaps just fixes for the files that you are seeing build crashes on?
> > > > > I know a bunch of them went into Linus's tree for this issue, but we
> > > > > didn't backport them as I didn't know what was, and was not, needed.  If
> > > > > you can pinpoint the files that cause crashes, I can dig them up.
> > > > >
> > > >
> > > > The first one to fail on 5.15.164 was:
> > > > drivers/media/pci/solo6x10/solo6x10-core.o
> > > >
> > > > So I found and applied this patch to 5.15.164:
> > > > [PATCH] media: solo6x10: replace max(a, min(b, c)) by clamp(b, a, c)
> > >
> > > What is the git commit id of that change?  I can't seem to find it.
> >
> > 31e97d7c9ae3
> >
> > >From Salvatore Bonaccorso to stable on 22 Aug 2024 19:19:27 +0200
> >
> >   Subject: Please apply commit 31e97d7c9ae3 ("media: solo6x10: replace
> > max(a, min(b, c)) by clamp(b, a, c)") to 6.1.y
> > ...
> >   "Note I suspect it is required as well for 5.15.164 (as the commits
> > were backported there as well and 31e97d7c9ae3 now missing there)"
>
> That is already in 5.15.166, can you verify it is resolved for you
> there?

Yes, solo6x10-core.c compiles ok on the new 5.15.166.

But 5.15.166 still fails on ia_css_ynr.host.c

>
> > > > Then the next to fail on 5.15.164 was:
> > > > drivers/staging/media/atomisp/pci/isp/kernels/ynr/ynr_1.0/ia_css_ynr.host.o
> > >
> > > What .c file is this happening for?
> >
> > Probably this one:
> > drivers/staging/media/atomisp/pci/isp/kernels/ynr/ynr_1.0/ia_css_ynr.host.c
>
> Did you see this also building this file in 6.10 or anything newer than
> 5.15.y?

Slackware current uses 6.10.8
I don't see ia_css_ynr.host.c on 6.10.8

6.10.8 contains solo6x10-core.c and compiles with no problems.

Richard Narron

