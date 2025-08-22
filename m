Return-Path: <stable+bounces-172328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EED76B311AB
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 10:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AC78A04FE0
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 08:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4202EAB8E;
	Fri, 22 Aug 2025 08:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="aFpyd+Ck";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fgCDd/Ie"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4CF2E5415;
	Fri, 22 Aug 2025 08:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755850882; cv=none; b=QGysX/Tk0XzAA1S29SQku4WgqQyOffPit3HrpliKR3GDopzzK9bULptrUVr1T8HB6/8y+VDPwu0nt1La1KhoCB9wT2sf1MLHsQw/MYzwzoy+USXbxL6zEcuk9/3VF1hkF9Kc/NCx8hcOFjB4amx+I9BH/hSbdXRStvkSjHVaDnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755850882; c=relaxed/simple;
	bh=PJ+bUo2okZ+hQnCb7soTDsIhvm7ARH20YRTOEcDLeWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPkV014yVJcAJkzA+we6iDcm4Rd6eaKo1nzJfrI2lAIFsLaJSkB365Q6syoiG3iC5lbYjic8Z/LjHgXR2wvUUDBAPZW8bLKZW/mrULYt+o/UEFJWNyz7wJO66zqMIq4ZpU+8fViV1rS7xAzOmurcfRaU5/SHScYG+veo6cpUQ58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=aFpyd+Ck; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fgCDd/Ie; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8BA877A01EB;
	Fri, 22 Aug 2025 04:21:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 22 Aug 2025 04:21:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1755850879; x=1755937279; bh=2ZK2h7XHSt
	MRxTPul2DJw2Nv8ChTU8ryd1q9AIwcc+w=; b=aFpyd+Ck0UXfdbayEmQt44HkkM
	7un9by8c7ECCwbUR0m6XYcJ1VDsUNtOBDaY2QDdDEkJhWSQx7cWVuQoZ3+dhP0Hy
	to0/rf0BjqCUgcf5jg3ZuLGu0UnmkwkAqpZRWeQs9qtzaESgqOzNaWgLj2zScgiZ
	MEJNtCTH/Pj7tk2mmzCNujQgXExxssru8K6yrXTaXl2jmlxdrfFgCSdUpN1zP+j6
	TjqEdaPUcbyD52SmY0ElGbYB+uZhiKUtKjyQ5KU7J5vQwUqZD2OeVRBYpuyIYthH
	4XDZCvtdxCm88ar34cfy31JZ9rL4kyLD5s/zrQHtT7Cj18AzpaCbzwQvOuuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755850879; x=1755937279; bh=2ZK2h7XHStMRxTPul2DJw2Nv8ChTU8ryd1q
	9AIwcc+w=; b=fgCDd/IeLrILVsd+eDzRlKjjvXb88NLSDkWzu+jDKg/bxz/2ACV
	LVhLb1qCt8+sZJEQjPLBb8tZYSCZtaSwIyM4759tVa0EyakU02Bj1vSw1Cpxbqe3
	EPDDwlCT71UC+qOvU1EtyeJdiYDbXIDiP5MVaotmaFgxKOM+57/esuiy/UyGoZwF
	e3xr9zhYPS2WARE63j8RMTYjY2Fpz+kIDPiIFaBTnYvuAFEt7yUj6/aHFtZWZ65H
	AR/oqZU8tQhERpTh5qFniygGwz/SScowbadDuE4XQ1OSS6ETEnff37woeANBQhQj
	OJVIHIJWw+yqgif40JQWe0svE/qrtAHBIaw==
X-ME-Sender: <xms:fiioaG7xsuQXmNXO3Q37xM3q0oktsA2nicFEVhSwlwjdDJgjRRBJJQ>
    <xme:fiioaMx0n6Hr4ZkMNbh8nRYoeLJ61o3-cUmF00YyUDKNBbK0sltZm8W-UxuY3r8vA
    43Xk0iddRbArg>
X-ME-Received: <xmr:fiioaFO4cLW09awFWcKO10tO88p3xV75UMef29uH7z8V_BeD_XdANNLP2EjmMUKAJHiCiE2ShQzHmwMHaTkH2Fm6Kn_kE30fHz_DqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieefvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeehueehgf
    dtledutdelkeefgeejteegieekheefudeiffdvudeffeelvedttddvnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdpnhgspghrtghpthhtohepkedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrihhlhhholhdrvhhinhgtvghnth
    esfigrnhgrughoohdrfhhrpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepshhtrggslhgvqdgtohhmmhhithhssehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhklhesphgvnhhguhhtrhhonhhigidruggv
X-ME-Proxy: <xmx:fyioaCk9ne4KSyRfj8mMHH0fRVCfwLoueilqkZ76DdtlBXiKFbW8nw>
    <xmx:fyioaKSWU98wFMGQ-E7GPOOdW-EGxp9hHyfonF_cz0w4MGih1b6bgA>
    <xmx:fyioaBV4JRChTocX8hoFCfoqpZqWPLblgUxb7q8RXjlSxZUpsvdNJQ>
    <xmx:fyioaOLl_uqdGkrisbmZh0u_ITeMJF5i0MwP3N7GO1qITBy4KpZOqQ>
    <xmx:fyioaDZsDpqOpTiE_BkNG-33pe5FwdsNoT57y7e-sLjmqXTjHjRy6sqH>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Aug 2025 04:21:18 -0400 (EDT)
Date: Fri, 22 Aug 2025 10:21:16 +0200
From: Greg KH <greg@kroah.com>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Patch "can: ti_hecc: fix -Woverflow compiler warning" has been
 added to the 6.15-stable tree
Message-ID: <2025082256-goliath-boundless-bb22@gregkh>
References: <20250817134901.2350637-1-sashal@kernel.org>
 <CAMZ6RqKtpR3vikvm80h0Tv-SUCP4AU2gmMvn=F=SZMSB1UJTgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZ6RqKtpR3vikvm80h0Tv-SUCP4AU2gmMvn=F=SZMSB1UJTgA@mail.gmail.com>

On Mon, Aug 18, 2025 at 12:54:26PM +0900, Vincent Mailhol wrote:
> Hi Sasha,
> 
> On Sun. 17 Aug. 2025 at 22:49, Sasha Levin <sashal@kernel.org> wrote:
> >
> > This is a note to let you know that I've just added the patch titled
> >
> >     can: ti_hecc: fix -Woverflow compiler warning
> >
> > to the 6.15-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> >
> > The filename of the patch is:
> >      can-ti_hecc-fix-woverflow-compiler-warning.patch
> > and it can be found in the queue-6.15 subdirectory.
> >
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> This only silences a compiler warning. There are no actual bugs in the
> original code. This is why I did not put the Fixes tag.
> 
> I am not against this being backported to stable but please note that
> this depends on the new BIT_U32() macro which where recently added in
> commit 5b572e8a9f3d ("bits: introduce fixed-type BIT_U*()")
> Link: https://git.kernel.org/torvalds/c/5b572e8a9f3d
> 
> So, unless you also backport the above patch, this will not compile.
> 
> The options are:
> 
>   1. drop this patch (i.e. keep that benin -Woverflow in stable)
>   2. backport the new BIT_U*() macros and keep the patch as-is
>   3. modify the patch as below:
> 
>        mbx_mask = ~(u32)BIT(HECC_RX_LAST_MBOX);
> 
> I'll let you decide what you prefer. That comment also applies to the
> other backports of that patch except for the 6.16.x branch which
> already has the BIT_U*() macros.

Oops, missed this, it broke the build, as you point out, so I'll go drop
it from all older kernels and revert it in 6.12.y now.

thanks,

greg k-h

