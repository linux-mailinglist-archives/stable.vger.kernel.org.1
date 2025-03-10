Return-Path: <stable+bounces-121732-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 873D0A59B24
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B547188789D
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 16:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55C6230981;
	Mon, 10 Mar 2025 16:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="tlESz1QU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Eg4or7n2"
X-Original-To: stable@vger.kernel.org
Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEFA22FF31;
	Mon, 10 Mar 2025 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624576; cv=none; b=GmAPI5enIhV2r59cgtsI7NXvxpPmtOdU9kwtVtnAOFmUblzXKb61QT+x79dejbyqlIPPNP+LdmnwshQg8TCpdtpBUG8aeLz8fqh5IBaDri9Ro05G3A4DvoLOJwcem/+x3aO0aoCiUrK26zdXv+fGa4/kZZO4DWa4rgxvSSPsgu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624576; c=relaxed/simple;
	bh=c0lfhZcU8DhXxUDs4LjwQ0yMOoROETcUFcSOvO3Bhrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YhnbCABC4Au0ZE7l5XfiYdFGRnh5nker/VDs9zRnSAtTtor20G3rFyx2+JgWPd1bZJPIv6Z9UTWI953ZTPomE2KogiJHswstYRMoX5OsgtoiJni8ELHgOZvgFRIXtEYCCGjllHP2QrRCnFoMaw1CHqHXI2TLJbkzhufkKknddzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=tlESz1QU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Eg4or7n2; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id BE9CD1D40F59;
	Mon, 10 Mar 2025 12:36:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 10 Mar 2025 12:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741624572;
	 x=1741631772; bh=W12JWoT3JRqnZUjWC8vkiruvPfakcTXFnSvupYw+Lxo=; b=
	tlESz1QUWKgfbzscVh7wZlZkQ0nQnF0ZPjz1uWixQoiaEouaWEKOY5n83detW38B
	0KzxPKnLzKRiMuYwfbSCajwlF6NPh/y4l+PcKF+dVmq91XsLteGHT6dSev9nw4Pz
	0IuEhmFF0OTZY5xrpx0fMAJ645A9nWSjng9Ap0o69RrprBNHmw+iZ7RYS5LOR34R
	jw4HzE4OKDaSkUq9ulX5/xRq921TekhzOR4vDpZWQA4A6MynIH22EptlCDXYYixb
	jj28o5lSzzLzDZVMorrVkqRlyPdT2J1RKPP7fFAkxJcfZUIf/STbrNVPfjICQJVr
	Bdn3YJJq2aZXmcQnrzWKHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741624572; x=
	1741631772; bh=W12JWoT3JRqnZUjWC8vkiruvPfakcTXFnSvupYw+Lxo=; b=E
	g4or7n2uqnm5qPeSNBhuusN31Ov5hFKdd15GDqMwaNA3ohBm8kAFVsS5mTGG0pxr
	cowTRxR07qdgD7m/8bQoH14Iw0QjvjKM1WDRYCMN1ZCwawOkGYlcTGzpR5UnwcsF
	deh47lt3iSAh1ra/oQZ6FMMXJxcaDCsydPOQ6kaRNOQh4csQGqEX2nQ8w8JfkrPi
	sks+TluKotybiuBbv20eD22vzbedSMs0l3p2FA3sh/D7EADGYEyUSWTTvOZH/lyo
	h5AMKboh9TscJ9gMYCj6XvzP4xX+As2av34Zs6Ahpd4tOdT89siQSc+foXr2M61D
	zea4E9BYBI+zaO3JCpVsQ==
X-ME-Sender: <xms:_BTPZ2nIxuPbhjN5JqFdewT7WMw8fCy95YNpsmcXdIwTAXTDO6QrDw>
    <xme:_BTPZ93Gc6oEYFt90TS9nJw63Dv8aQt_z0cfSI-MScIbiOHxDQgRe7YXqyJPnn8K0
    nF5lJr1BQ9dYQ>
X-ME-Received: <xmr:_BTPZ0qSEonbPv4uOnSTy1zGDccn25F-n_7EPPO-c1E0fOzYUKvCynYXnjbuRfxz6yuH95yv3h68EhGWvoUwLARdqPNHJkg6QM9ALg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudelkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tddunecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeegveevtefgveejffffveeluefhjeefgeeuveeftedujedufedu
    teejtddtheeuffenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgt
    ohhmpdhnsggprhgtphhtthhopedvkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epvhhilhhlvgdrshihrhhjrghlrgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphht
    thhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsth
    grsghlvgdqtghomhhmihhtshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehjrghnihdrnhhikhhulhgrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoh
    eprhhoughrihhgohdrvhhivhhisehinhhtvghlrdgtohhmpdhrtghpthhtohepjhhoohhn
    rghsrdhlrghhthhinhgvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhope
    htuhhrshhulhhinhesuhhrshhulhhinhdrnhgvthdprhgtphhtthhopegrihhrlhhivggu
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhimhhonhgrsehffhiflhhlrdgthh
X-ME-Proxy: <xmx:_BTPZ6kxcln-bk5Vdh3x-Pra36H-CG3v33RPNRnbXl33sHtxBD4pQw>
    <xmx:_BTPZ02_TECJKV1zqVxrE9Wce4LHfHEmEfTPRZRohen7aSqrdYbqWA>
    <xmx:_BTPZxs-b_ZKH_TDkWDPOFwmOEpJRlVwTCo4O2upAHoFFeP9Ppdv5A>
    <xmx:_BTPZwVFq_wkSg_monLY0MIx5jkPgUfjodNlYU3jYtnFJc8OUHBYWw>
    <xmx:_BTPZxfAQIA5KAWmelA-nbTl0L8MV_YdM9pzZYpvWRxf_vMMKa4WFGCg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 12:36:11 -0400 (EDT)
Date: Mon, 10 Mar 2025 17:35:06 +0100
From: Greg KH <greg@kroah.com>
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: Patch "drm/i915: Plumb 'dsb' all way to the plane hooks" has
 been added to the 6.12-stable tree
Message-ID: <2025031047-reformist-faster-c3c6@gregkh>
References: <20250309194558.4190633-1-sashal@kernel.org>
 <Z88LWG1_AeNb7Hch@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z88LWG1_AeNb7Hch@intel.com>

On Mon, Mar 10, 2025 at 05:55:04PM +0200, Ville Syrjälä wrote:
> On Sun, Mar 09, 2025 at 03:45:57PM -0400, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     drm/i915: Plumb 'dsb' all way to the plane hooks
> > 
> > to the 6.12-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      drm-i915-plumb-dsb-all-way-to-the-plane-hooks.patch
> > and it can be found in the queue-6.12 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> > 
> > 
> > 
> > commit f03e7cca22f4bb50cae98840f91fcf1e6d780a54
> > Author: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > Date:   Mon Sep 30 20:04:13 2024 +0300
> > 
> >     drm/i915: Plumb 'dsb' all way to the plane hooks
> >     
> >     [ Upstream commit 01389846f7d61d262cc92d42ad4d1a25730e3eff ]
> 
> It would help if you actually mentioned *why* you need to backport this?

If you read further in the patch it says:
	Stable-dep-of: 30bfc151f0c1 ("drm/xe: Remove double pageflip")

which is the reason.

thanks,

greg k-h

