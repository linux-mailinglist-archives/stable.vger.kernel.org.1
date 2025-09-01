Return-Path: <stable+bounces-176784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78219B3D8D8
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 07:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4584317928A
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 05:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D70B1922F6;
	Mon,  1 Sep 2025 05:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1IwWGVX6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6031519AC
	for <stable@vger.kernel.org>; Mon,  1 Sep 2025 05:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756704897; cv=none; b=jbpmAWF7LjsoltbthIhADCeW3dg/+/iJIfNXYuRACtEKiSatUrVJqwLQIzqwYQcL0b4y2OyXwrF+sQ3LqPvS64OJ8wzy0YyPV+dL7cTPvptVfHWe9UeVtNM9BZWAJ/5dc6SjkbZ9/d/1krH9YEc8u+LpKKu1MEyGsQYnWtE+/CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756704897; c=relaxed/simple;
	bh=JgYV9KYQhwjHlhHFCyRWvXO/8ImZtRPdFBjGDMoQ05I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XdUeIlr0lRdYGPrSg05Ii6qvP+p5EkrUCmua46NP9kglkLq3ddGcNaS1FgbdeHMT48cEnceonn0F/YjzM2hD31F+/MBt+qKyJ+dDeG4XA5QGjIt+8eEqXZwPegSAQPYGoMNWxq4fTKMcyPMD4JSFXnWjSj5NybdHu8Zza+WzZ5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1IwWGVX6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA03C4CEF0;
	Mon,  1 Sep 2025 05:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756704896;
	bh=JgYV9KYQhwjHlhHFCyRWvXO/8ImZtRPdFBjGDMoQ05I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1IwWGVX6qa9zjiEexxlxz4fLHjrugo9h4188zYvLvApZhwQWMIb7QNgvyI6XQRDaZ
	 lE2+6e8g8k8Rn89QWZylQgVKjpki+hrbTAXf+BRbPmreQUhEv7CaZWzZ2QLsggZpel
	 fFCXdizeponvcU2oeOHl+lmTaCDM+yOPAmNA2b60=
Date: Mon, 1 Sep 2025 07:34:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
Cc: stable@vger.kernel.org
Subject: Re: 5.10 backport request: ASoC: Intel: sof_rt5682: shrink
 platform_id names below 20 characters
Message-ID: <2025090123-widow-strategic-0202@gregkh>
References: <53696f9e03ff0aa2d8ef3903293e49723df967d1.camel@gentoo.org>
 <55a3d4952c689938775a17df7eeec447e17e9f42.camel@gentoo.org>
 <2025082909-plutonium-freestyle-5283@gregkh>
 <32b1c5d75fbc391ac2e8ce9857adc907797f7d81.camel@gentoo.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32b1c5d75fbc391ac2e8ce9857adc907797f7d81.camel@gentoo.org>

On Sun, Aug 31, 2025 at 08:25:07PM +0200, Michał Górny wrote:
> On Fri, 2025-08-29 at 15:55 +0200, Greg KH wrote:
> > On Fri, Aug 29, 2025 at 09:09:33AM +0200, Michał Górny wrote:
> > > Hello,
> > > 
> > > On Fri, 2025-08-29 at 08:03 +0200, Michał Górny wrote:
> > > > Hello,
> > > > 
> > > > I would like to request backporting the following patch to 5.10 series:
> > > > 
> > > >   590cfb082837cc6c0c595adf1711330197c86a58
> > > >   ASoC: Intel: sof_rt5682: shrink platform_id names below 20 characters
> > > > 
> > > > The patch seems to be already present in 5.15 and newer branches, and
> > > > its lack seems to be causing out-of-bounds read.  I've hit it in the
> > > > wild while trying to install 5.10.241 on i686:
> > > > 
> > > >   sh /var/tmp/portage/sys-kernel/gentoo-kernel-5.10.241/work/linux-5.10/scripts/depmod.sh depmod 5.10.241-gentoo-dist
> > > > depmod: FATAL: Module index: bad character '�'=0x80 - only 7-bit ASCII is supported:
> > > > platform:jsl_rt5682_max98360ax�
> > > > 
> > > 
> > > I'm sorry, I should've waited for my test results first.  Looks like
> > > this patch alone is insufficient.  Looking at 5.15 stable branch, I see
> > > that we probably need:
> > > 
> > >     ASoC: Intel: bxt_da7219_max98357a: shrink platform_id below 20 characters
> > >     ASoC: Intel: sof_rt5682: shrink platform_id names below 20 characters
> > >     ASoC: Intel: glk_rt5682_max98357a: shrink platform_id below 20 characters
> > >     ASoC: Intel: kbl_da7219_max98357a: shrink platform_id below 20 characters
> > >     ASoC: Intel: sof_da7219_max98373: shrink platform_id below 20 characters
> > >     ASoC: Intel: sof_da7219_mx98360a: fail to initialize soundcard
> > >     ASoC: Intel: Fix platform ID matching
> > > 
> > > Unless I'm mistaken, the firt series are part of the merge commit
> > > 98c69fcc9f5902b0c340acdbbfa365464efc52d2.  The followup fixes are:
> > > 
> > >     0f32d9eb38c13c32895b5bf695eac639cee02d6c
> > >     f4eeaed04e861b95f1f2c911263f2fcaa959c078
> > > 
> > > I didn't find anything else that seemed obviously elevant, but I didn't
> > > dug deep.  With these backports, I can build 5.10.241 fine -- but I
> > > don't have any hardware to test these drivers.
> > 
> > So what exact commits are needed and in what order?  Can you just send
> > tested backports to us so that we know we got it right?
> 
> Would it be okay if I cherry-picked them from 5.15.y rather than from
> master?

We need the commit id from Linus's tree in them, not the id from 5.15.y,
for obvious reasons.

thanks,

greg k-h

