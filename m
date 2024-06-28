Return-Path: <stable+bounces-56070-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F2D91C0B3
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 16:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 509331F21825
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 14:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830011BF317;
	Fri, 28 Jun 2024 14:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="SjijhTLE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VRPlrLor"
X-Original-To: stable@vger.kernel.org
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F13B15B111;
	Fri, 28 Jun 2024 14:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719584323; cv=none; b=U7u8YLBP7QI0uo9ytUBxUq65/l+K8eL6BteoEbFQlKYYrXW2hSSXwOpTScUwXgbulNWpTcGAt2s2ncqzokKTz2gqEAbSfJJ/zdXRebXTH9pO3GnVeYP8VjYE7KQnz0lil0Mpu4yjsRmUh5dQ53hahUn9H1OLame5dI/QvxpEAV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719584323; c=relaxed/simple;
	bh=WQvAJ7Ou6XB4ugAepvPCE9b7pBxY4KzoXm2okNPXvE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a40oT2xEAwjBzgfdrMETayNLUBo+3DwEVkIiItmzs0fTsFZzpqqLRu1wp/lnjc2DWtvXaIRXNarNYU5H6EKWNFQaLzhmh4uTZAFeoz9YMuRldNz1WMOpgWTHnby93G/4s4Yn8oWaQHsD67UGOHYaauVeerQ6P4F7IhyYI+2A/L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=SjijhTLE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VRPlrLor; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 590641140151;
	Fri, 28 Jun 2024 10:18:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 28 Jun 2024 10:18:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1719584320; x=1719670720; bh=XxEjxstRDM
	2MfcVWZj+c97JszTiOmNwvDxZQpSa8bAo=; b=SjijhTLEViXIpN0s5+Zd/vdcgv
	8itSWuQhnmlLaTV60tt023SS4Yuway6VE1PjU/Q+3YVqzu6pBtkFnpc2TXC1ZBIk
	GIky7Or38nFlpFlM97JGj0/yJD9IShUhi3o+JiecIlfKsodp0NY4cwhrd+1xMUeO
	9MvhyxI3zNEQIsvZ3M9J0Grmgqsp8Mkf7ATzOr2Zu0uc+CHVmg1U//l7dF5TtwnV
	IG+xWa9TnECEuFfgpIW910mEjkp1YNZ99gLV6exqiKcocjwlG0obmE67bE8jzMxU
	E13wAJc2ZsSZivTE0WW+zDh7bsc4o8C8f4kbJ4/9kCWrIy2BG3UwjGjE5VfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719584320; x=1719670720; bh=XxEjxstRDM2MfcVWZj+c97JszTiO
	mNwvDxZQpSa8bAo=; b=VRPlrLortUWZBn34e9W8IEBM91VRySa4bSlMAXYWshYv
	fAuJNwk3mjFhR0dNVP58pgyyk4ygngelV/1W8Y3nM4SpxoYrt75GlJU2A61C1Sa4
	jpd2nxD+UoZnRPqmAdDtnTF8M422p+Dz60dJp4pZNv7MR2tszHo1N5dRMGKNkrYB
	RhQXW7Mer+xKHZMMaqMF7ZhBMhJd2x4xYnp/T2YXqGeuKE0dz052kMoxPPkW6uEA
	aVf73OPXk0TB7/gqK2ij+1sKiJDM1HzhvIJPAS1Z4tQ4328/I16luoFMiZLYfidP
	ZcSHwsH3rBu4ppj0YZDVEg90eyFXhJywtk8UE+1eIQ==
X-ME-Sender: <xms:P8Z-ZkxMmDTLVRsOJ8zMhji3de0ENIHTXwbA2P5cr-fQLZf-GuETUQ>
    <xme:P8Z-ZoTgar-9j_LuwL0DUsVwRhaBcfwZeIDowFF6o0M8IrCpLwEDylsKraeNQkbBc
    7lYorQ5wYJB9Q>
X-ME-Received: <xmr:P8Z-ZmWISO95mwc_c_Y2ZXphcasrr00wPkz-R9PUKqR_HFzdhRi0hOESK4o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrtdejgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeegheeuhe
    fgtdeluddtleekfeegjeetgeeikeehfeduieffvddufeefleevtddtvdenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:P8Z-Zig9bKQjQ3ZVFanOQE4FiabHedbZUJbqT6PkFrOin73PGAEOtA>
    <xmx:P8Z-ZmC-K46rPuv54yRF3s4U8imgii3XxR9zjInrXLC9XRC1p8LEAA>
    <xmx:P8Z-ZjLrEBc6-uS5am6EaGlySouhb6VEs90pIwtwYcd9664U7t0LNw>
    <xmx:P8Z-ZtChOKYXX6cZzmWx-edoBipktAlKqK8hDONzskSDNar8yPZu0g>
    <xmx:QMZ-Zi1U7jfyicWFcuq8AxWmP-rTs_x0GBC5NRNyfBErLFtIzPI0pejc>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Jun 2024 10:18:38 -0400 (EDT)
Date: Fri, 28 Jun 2024 16:18:37 +0200
From: Greg KH <greg@kroah.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org, ms@dev.tdt.de
Subject: Re: Patch "MIPS: pci: lantiq: restore reset gpio polarity" has been
 added to the 6.9-stable tree
Message-ID: <2024062827-ransack-macarena-b201@gregkh>
References: <20240627185200.2305691-1-sashal@kernel.org>
 <Zn5easOVbv3VGAMu@alpha.franken.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn5easOVbv3VGAMu@alpha.franken.de>

On Fri, Jun 28, 2024 at 08:55:38AM +0200, Thomas Bogendoerfer wrote:
> On Thu, Jun 27, 2024 at 02:52:00PM -0400, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     MIPS: pci: lantiq: restore reset gpio polarity
> > 
> > to the 6.9-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      mips-pci-lantiq-restore-reset-gpio-polarity.patch
> > and it can be found in the queue-6.9 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> can you drop this patch from _all_ stable patches, it was reverted already
> in the pull-request to Linus. Thank you.

What is the git id of the revert?

thanks,

greg k-h

