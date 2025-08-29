Return-Path: <stable+bounces-176709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBA4B3BCE5
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 15:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A492E7C0C9B
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 13:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3DD2F617A;
	Fri, 29 Aug 2025 13:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="HAW7S7q6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ruf983mK"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294FD347B4
	for <stable@vger.kernel.org>; Fri, 29 Aug 2025 13:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756475741; cv=none; b=Om3MzsJcn4Fa/ufrBzikAHWdIbOTVL6WcnPv+ss2xhPIWoDiXqQNC9DasFeihIU7OeDe7atvIswlsTwFwQDwtutP5Lx1jnQYTjndnXgLMA5wO+dDl1wpqBEm3wI7isLTzlQnxxD9RaSf4yhqQTN9eK8MUS8WBLH2Vrxm0RaUJL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756475741; c=relaxed/simple;
	bh=KhvCAHUZevc79mFa+a8PYDblX/kQW4PgiTOnynQZ0Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V29hXEiQ2m/d07mA8LwFeqAldHY0MX5obP9jkjlhms/XtP+OOzyHj+ITMc2KtAF4RULO20CbSMLam6rJ/j5oVwdGGcj3QMTjCkRws2YiXey0gxI2jfG0tcHOj+ft51oygCjXM+07YGrEF9DdRz5Zv5b/nMx34X/jYzD+gJpMufk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=HAW7S7q6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ruf983mK; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2D1057A026B;
	Fri, 29 Aug 2025 09:55:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 29 Aug 2025 09:55:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756475738;
	 x=1756562138; bh=7KUaFdTxkLalEXF+EXnLIvZkgHGJKGGON+5GFscrL8s=; b=
	HAW7S7q6Z/px47+Iajxts4b9kKj8K8xfVgM5NMt6R0OmutsdoaiKDm4LBO56uGrx
	B9bRwoQe+PuKe8+HRBb/C/pOv4wJfT3zELajbFkCeqNv8gfAnyFMjJeNOYVZqoXv
	Bx3aq4D2RgaNPuDllUQHZgADUp3tvM5dRRo3eRBStQPVLVbQ0MyPVHjSYT5eJi4G
	VVUz+d/NghZpvsbIhJVJ0sx7TbkgWn4yNgpPZtEmtaYpbmKJwGKpdurpwnjacm0K
	Y5uI0mVSPULeZY0zbIXJwCTjEtEwp2RqNWP4IvSgapOJunK5D5nCcue2enMxtCwu
	r/WbP1jA1gddYnsS8aJQuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756475738; x=
	1756562138; bh=7KUaFdTxkLalEXF+EXnLIvZkgHGJKGGON+5GFscrL8s=; b=R
	uf983mKcgqPjf8OqeBl3L4vG5e+kqI11/59h9npncUUazvom5RpFBMzICkA9Fhqo
	nqUaylmG19yup+xeehL1fdXG3FwJpYucbHhVMqo25kal9S9qE3aCdKAtTOpzPxiW
	Phdq0hujtRqcQWiQdDl8vvzPepZ+krQ4y4qLfMRCgVII1c3ohHov7MdbcT3uLTKU
	68hQKfZpR/j4/VLOx+/DgDHorjBFoAeiyv2eD8Dkay0UNWnEggbrZphnZ8eEimQo
	6vlp115W9puJRpovtmCzY+f02Pwv8H2HXMWwjtsptiftE3LpLVpvXp215mJN2lyc
	2V1dLBWzgNl/HTe/u0bpg==
X-ME-Sender: <xms:WbGxaLjSm4i6sNEDdFG2bqeSjkpx_N4SBtB-9EVX3GRgJindrjiYEA>
    <xme:WbGxaBc-i6ico1bYlftGL_TIsg0kXlUQHNJ10RvglZ1d_JUsByQq6INh2xHOJwRWm
    Nbc0CN7hQZ9EA>
X-ME-Received: <xmr:WbGxaKpn3Fo2zDEOJPLrdCay6R1a6PfmveOHKAZWF_kf7n2UImNmwJkQv5Ix66zgi0UzGL8_JzWUpmByQm1S3Cq8fsW1ef7FGRqhTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeegtdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpefgkeffie
    efieevkeelteejvdetvddtledugfdvhfetjeejieduledtfefffedvieenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhhgohhrnhihsehgvghnthhoohdrohhrghdprhgtphhtthhopehsthgrsghlvgesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:WbGxaODynTmVxXPuy_UlX0j3crtfIzicJ8xfRFbLmABDABGJFyvW1g>
    <xmx:WbGxaPaPIrKeeImT_4NlQu0SzWVZgEcwmBe56roMRrbHZbUUDbMLYg>
    <xmx:WbGxaJ7i6JOhL7lBmrBic8riYvZSPSJ5uj_5NHi3xwiNumUyU9wV4w>
    <xmx:WbGxaIabC6lqNLGqWp9IGgyYZzs-cI2pvPT8U8NAVCM7VIDneOoTjA>
    <xmx:WrGxaE5K7RHE83j7UPGb06uhynkWGysbFes2GvwwGanKW0tySER_zLDz>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Aug 2025 09:55:36 -0400 (EDT)
Date: Fri, 29 Aug 2025 15:55:34 +0200
From: Greg KH <greg@kroah.com>
To: =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
Cc: stable@vger.kernel.org
Subject: Re: 5.10 backport request: ASoC: Intel: sof_rt5682: shrink
 platform_id names below 20 characters
Message-ID: <2025082909-plutonium-freestyle-5283@gregkh>
References: <53696f9e03ff0aa2d8ef3903293e49723df967d1.camel@gentoo.org>
 <55a3d4952c689938775a17df7eeec447e17e9f42.camel@gentoo.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55a3d4952c689938775a17df7eeec447e17e9f42.camel@gentoo.org>

On Fri, Aug 29, 2025 at 09:09:33AM +0200, Michał Górny wrote:
> Hello,
> 
> On Fri, 2025-08-29 at 08:03 +0200, Michał Górny wrote:
> > Hello,
> > 
> > I would like to request backporting the following patch to 5.10 series:
> > 
> >   590cfb082837cc6c0c595adf1711330197c86a58
> >   ASoC: Intel: sof_rt5682: shrink platform_id names below 20 characters
> > 
> > The patch seems to be already present in 5.15 and newer branches, and
> > its lack seems to be causing out-of-bounds read.  I've hit it in the
> > wild while trying to install 5.10.241 on i686:
> > 
> >   sh /var/tmp/portage/sys-kernel/gentoo-kernel-5.10.241/work/linux-5.10/scripts/depmod.sh depmod 5.10.241-gentoo-dist
> > depmod: FATAL: Module index: bad character '�'=0x80 - only 7-bit ASCII is supported:
> > platform:jsl_rt5682_max98360ax�
> > 
> 
> I'm sorry, I should've waited for my test results first.  Looks like
> this patch alone is insufficient.  Looking at 5.15 stable branch, I see
> that we probably need:
> 
>     ASoC: Intel: bxt_da7219_max98357a: shrink platform_id below 20 characters
>     ASoC: Intel: sof_rt5682: shrink platform_id names below 20 characters
>     ASoC: Intel: glk_rt5682_max98357a: shrink platform_id below 20 characters
>     ASoC: Intel: kbl_da7219_max98357a: shrink platform_id below 20 characters
>     ASoC: Intel: sof_da7219_max98373: shrink platform_id below 20 characters
>     ASoC: Intel: sof_da7219_mx98360a: fail to initialize soundcard
>     ASoC: Intel: Fix platform ID matching
> 
> Unless I'm mistaken, the firt series are part of the merge commit
> 98c69fcc9f5902b0c340acdbbfa365464efc52d2.  The followup fixes are:
> 
>     0f32d9eb38c13c32895b5bf695eac639cee02d6c
>     f4eeaed04e861b95f1f2c911263f2fcaa959c078
> 
> I didn't find anything else that seemed obviously elevant, but I didn't
> dug deep.  With these backports, I can build 5.10.241 fine -- but I
> don't have any hardware to test these drivers.

So what exact commits are needed and in what order?  Can you just send
tested backports to us so that we know we got it right?

thanks,

greg k-h

