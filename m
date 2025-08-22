Return-Path: <stable+bounces-172326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96406B310D8
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 09:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51DD36804E4
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 07:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2309E2EA47C;
	Fri, 22 Aug 2025 07:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="c+n3j8Ki";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bYQRegbm"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D52F1A9F83
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 07:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755849293; cv=none; b=UrXIa+NCopUXcjFXguA93ahho4n9XS4OOdErklIFaa8GjaxHd/64h2swsX81Mlpol5vy4WA+nudn2k8s+HrKauBhtfVEL6xWgfeEZSgvtDwQ6cnajyNH2yfH1QibU7rA8gKLK0FhI++w5L+6oAPf9hBtfONAVMPs43vuQQbpqDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755849293; c=relaxed/simple;
	bh=8aXbd6hi6hWJ0lVkeksnsamAudaUWHkjq1MWvfRSMKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBocRtHxubgO6o4FoQQVUvdNzay8ZeW4hN64GWOjGhjiVjJkAEeE1ktcKicaQcVs84iCidOq36QPZ4RCyQyPSzqftPA6IcCSrcvHab7nky9jR7sNIfv4DBOxsBvK/tjQDg0ppWmXpJuE67jfzqGJBOEFvOnOWQXrDtgDRnxYq6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=c+n3j8Ki; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bYQRegbm; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 133DD7A0155;
	Fri, 22 Aug 2025 03:54:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 22 Aug 2025 03:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1755849289; x=1755935689; bh=lXEliDZxFj
	ObXh7VU9jfiQGbEWsfEZiuAs4tdDSS3sE=; b=c+n3j8Kibi+qDD9FaxKrvodVDq
	TrRa1LuBNaZ2IZY3XdUxclhg+BMsjlKKn/pCz0jPJzEZhzdTH7Px24QKGxKS9vNj
	IhFQfkbhAZ1awCWbHSNDHGn48ubIwGqLt4D1xipiq8PIX3qQlknIAui52rtmHxzN
	vr7dyphoe9nyiGb3H0xRcDyIeuKypdbu1DBdIP3ErUNDrOxOUGbnHrXFAXy5uEX8
	zSt7KXzy+a+D00OhAkIj0yQD4qofzhapXxSSs8kuVd8Ld5kbzOScL5tvQef65+QD
	8UizyXwu6yN88OLsbm32z/GLeNObPjRZn/0u4VsF44VrM1GDBQSXjgEaDMKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755849289; x=1755935689; bh=lXEliDZxFjObXh7VU9jfiQGbEWsfEZiuAs4
	tdDSS3sE=; b=bYQRegbmTDDidVNMMQ5LhZBIeBHG6amv0c8thwQJLaWukhf+5ED
	MzF0tm+XKsIu5ZhN/5Qlq5dx3dF/VSQfpiLT5RQudLGxdeho8MJXUWYf7GDUB4tj
	d97Iw6cp2T7JDdYhv+DbH2yGG91no70KWe74DwtDM7N5RFLiXK///0tTKyiBrm8l
	h4TA7IXy53Z3DI9zce7Aqak5JZJTu7Ad2JHM2Z6TDITf49okAH/RQx/Dsu2JgIyN
	QKDnoJglRBuzWjQVOAyDEWyNTRapB9d8FTjuDgB0AuHqtEx73YSgOhsGlf+0ufe7
	qPNlowzXREO9W+YvirWBHEhKWNUqYVNWx9w==
X-ME-Sender: <xms:SSKoaMxZYH3UDsVE3Tft2d69opueruIkb3E3FHsOWTD9Gr4FNLRXlQ>
    <xme:SSKoaPeejnLfuq75E9sllBw-69FYcWam6LLyxTBFBvL9Qg0vUkjW27wVm_nYt7giY
    lHoBTI_PY8rIA>
X-ME-Received: <xmr:SSKoaBAEcWQB5JP0VDXLBE92d3WlEtCo-aZXFi-Vj8QthYcl7hZFmbzht8b3P5OEsyiYctmhoUHNLqeFg3OgqsYCfDpOCvEG4qokbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieefvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvdevvd
    eljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrd
    gtohhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohephhgvrhgsvghrthesghhonhguohhrrdgrphgrnhgrrdhorhhgrdgruhdprhgtphhtth
    hopehgihhovhgrnhhnihdrtggrsghiugguuhesihhnthgvlhdrtghomhdprhgtphhtthho
    pehsrghshhgrlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtrggslhgvsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvggsihhgghgvrhhssehkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:SSKoaD5U1rSE2Jb4wHCX9y1jnR_YJlfJvgXMZi_vooJUr7ThWwKjKg>
    <xmx:SSKoaKfPxy6ygOK3YP0jjtR_bvvlKhiDPu-oixfJyRmULETc937HXw>
    <xmx:SSKoaJsKIvaGfiWm9vQXlMDnjWs7A_wNwoUVBhYBjL7QfwXP6KrEBw>
    <xmx:SSKoaKmX6L1Mtf1CpcpgcjLod1Uqs7Gh4LY1VRTdmjhAug-biXKY3w>
    <xmx:SSKoaH1F27LU-Eu0BEnHE7kBBj1_iHwlrdGtYnzDo9QXVKft7gE3Ydey>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Aug 2025 03:54:49 -0400 (EDT)
Date: Fri, 22 Aug 2025 09:54:46 +0200
From: Greg KH <greg@kroah.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 6.16.y 2/2] crypto: acomp - Fix CFI failure due to type
 punning
Message-ID: <2025082239-ablaze-sneer-a79b@gregkh>
References: <2025082113-buddhism-try-6476@gregkh>
 <20250821192131.923831-1-sashal@kernel.org>
 <20250821192131.923831-2-sashal@kernel.org>
 <aKgZVNygjrqd9L6M@gcabiddu-mobl.ger.corp.intel.com>
 <aKgg3vHUz2MM7A-L@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKgg3vHUz2MM7A-L@gondor.apana.org.au>

On Fri, Aug 22, 2025 at 03:48:46PM +0800, Herbert Xu wrote:
> On Fri, Aug 22, 2025 at 08:16:36AM +0100, Giovanni Cabiddu wrote:
> >
> > Wouldn't it be simpler to drop the below changes to crypto/zstd.c in
> > this patch and avoid backporting commit f5ad93ffb541 ("crypto: zstd -
> > convert to acomp") to stable?
> > 
> > f5ad93ffb541 appears to be more of a feature than a fix, and there are
> > related follow-up changes that aren't marked with a Fixes tag:
> > 
> >   03ba056e63d3 ("crypto: zstd - fix duplicate check warning")
> >   25f4e1d7193d ("crypto: zstd - replace zero-length array with flexible array member")
> > 
> > Eric, Herbert, what's your take?
> 
> Yes there is no reason to backport that patch at all.

Both now dropped, thanks.

greg k-h

