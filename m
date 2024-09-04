Return-Path: <stable+bounces-73046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DF396BCD9
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 14:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E304328730C
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 12:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876541D935D;
	Wed,  4 Sep 2024 12:48:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.aaazen.com (99-33-87-210.lightspeed.sntcca.sbcglobal.net [99.33.87.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FBD1D6DDE;
	Wed,  4 Sep 2024 12:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.33.87.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725454098; cv=none; b=I/aOOJAtub/JwYpkFY2tcJ5voRb13XVNuNFvVvopoY1GJM4oCrHw2x5xAvocPJXwo0bq02FP6yD2HU4qF7+tWX8Tqc3QoaXz0SpVnAOI2eDJb17rqhn5pQA+ID2b0Z3EVHMQ4/yanw8pEWsH6XKREQnKFeHBxVs6mTYlYkEG2s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725454098; c=relaxed/simple;
	bh=BxBXr1JwIhSOYtpAbjVQSDPksrtq48NOtKtuzNlUNl8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PHIh5pzNG9ffTnFcklZs2wsYbURCaBhMX7L8xj9CuRPf3SLD68VhdUOTbEioF7Bp97LRyxfHnnwnxn5kTeCDqLWMffM9drg/f7o5nOOo9b9KvrZPnh4EvQeTt9/56G+HkdLGzVKgeb4ejENbHvX8dc+0d3zRjBptc/aL0Hk24zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aaazen.com; spf=pass smtp.mailfrom=aaazen.com; arc=none smtp.client-ip=99.33.87.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aaazen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aaazen.com
Received: from localhost (localhost [127.0.0.1])
	by thursday.test (OpenSMTPD) with ESMTP id 98049a54;
	Wed, 4 Sep 2024 05:48:09 -0700 (PDT)
Date: Wed, 4 Sep 2024 05:48:09 -0700 (PDT)
From: Richard Narron <richard@aaazen.com>
X-X-Sender: richard@thursday.test
To: Greg KH <gregkh@linuxfoundation.org>
cc: Linux stable <stable@vger.kernel.org>, 
    Linux kernel <linux-kernel@vger.kernel.org>, 
    Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 5.15 000/215] 5.15.166-rc1 review
In-Reply-To: <2024090419-repent-resonant-14c1@gregkh>
Message-ID: <fc713222-f7b1-d1c0-2aa2-c15f42d3873e@aaazen.com>
References: <8c0d05-19e-de6d-4f21-9af4229a7e@aaazen.com> <2024090419-repent-resonant-14c1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 4 Sep 2024, Greg KH wrote:

> On Mon, Sep 02, 2024 at 03:39:49PM -0700, Richard Narron wrote:
> > I get an "out of memory" error when building Linux kernels 5.15.164,
> > 5.15.165 and 5.15.166-rc1:
> > ...
> > cc1: out of memory allocating 180705472 bytes after a total of 283914240
> > bytes
> > ...
> > make[4]: *** [scripts/Makefile.build:289:
> > drivers/staging/media/atomisp/pci/isp/kernels/ynr/ynr_1.0/ia_css_ynr.host.o]
> > Error 1
> > ...
> >
> > I found a work around for this problem.
> >
> > Remove the six minmax patches introduced with kernel 5.15.164:
> >
> > minmax: allow comparisons of 'int' against 'unsigned char/short'
> > minmax: allow min()/max()/clamp() if the arguments have the same
> > minmax: clamp more efficiently by avoiding extra comparison
> > minmax: fix header inclusions
> > minmax: relax check to allow comparison between unsigned arguments
> > minmax: sanity check constant bounds when clamping
> >
> > Can these 6 patches be removed or fixed?
>
> It's a bit late, as we rely on them for other changes.
>
> Perhaps just fixes for the files that you are seeing build crashes on?
> I know a bunch of them went into Linus's tree for this issue, but we
> didn't backport them as I didn't know what was, and was not, needed.  If
> you can pinpoint the files that cause crashes, I can dig them up.
>

The first one to fail on 5.15.164 was:
drivers/media/pci/solo6x10/solo6x10-core.o

So I found and applied this patch to 5.15.164:
[PATCH] media: solo6x10: replace max(a, min(b, c)) by clamp(b, a, c)

Then the next to fail on 5.15.164 was:
drivers/staging/media/atomisp/pci/isp/kernels/ynr/ynr_1.0/ia_css_ynr.host.o

This is also the first to fail on version 5.15.166-rc1

Richard Narron

