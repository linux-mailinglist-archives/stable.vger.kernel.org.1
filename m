Return-Path: <stable+bounces-179625-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B55FBB57CDC
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 15:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FCFB163FE1
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 13:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B762FA0F1;
	Mon, 15 Sep 2025 13:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="klZkKTTW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UDdnRA01"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2811E3090EE;
	Mon, 15 Sep 2025 13:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757942787; cv=none; b=cx3zTaJzixCNmvixrdWW1N60Pc8VgcvgWccecUcWTmosT8z7kfJc97dyE3JjtYUzRubIJx5Y8Bev0rSmE8Cy5SogfsZ5xflwK7oZyQqa286XW41LN1uJQQaS4zN09Oh+41M5eLvOXgOL7y8KTya2rM8NVrL7fftO/7hcfcAtfFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757942787; c=relaxed/simple;
	bh=sQBsFFLYopAGT8T7Z3FYq459tKvmyfzfRQ9rDODfirw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tuPzGmU2LjXLzd/Xf4dgf+a2I97+14xwijCIez2C5HpnwcmY2F2KpDhdO0WeaSToMeDwEaPN5vLTU2wQEljU4QzuaGrB28BEJcrCrQbcy1uZkgekoGxNm4cFyIIrvh+Dd2awHRGrSoUbz5KTA5Fc3lNwVAE7l9364bN3qev6yZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=klZkKTTW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UDdnRA01; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 287C17A0116;
	Mon, 15 Sep 2025 09:26:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 15 Sep 2025 09:26:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757942784; x=1758029184; bh=hGr2ZXHNbB
	QlZWjzf51lRHlmuYxk6VbQFOily101OV8=; b=klZkKTTWixs+e294pY+FAVziaa
	vL7zinKhv7vWGB/Bb1Na2c8ybgQ9njaP0eFuybptrguYX6VK1/de2iZzxTxUmOvN
	r7OinonaGwkuavvXKrTneSvNSX4HbcpyaH88roFk03NuxhxxsdaCN6Vt37hFaLMa
	fnj46+ySIdV52TU/60+GBvORh+nn5sQYb7flObXJoTWZ0uRbmXgz8FUmGZgTcXOX
	shE03hwjxPmhGm3vlWFDJdxH3eUEhBq7l7MgAo0Hr4ddl6rgWybiZViabOzK5t/+
	JsSdMxp1e2kWEgwPu6e4F2dHMbo6GjvIXyJ240GaOSM8DOy23mL/4kEBaWKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757942784; x=1758029184; bh=hGr2ZXHNbBQlZWjzf51lRHlmuYxk6VbQFOi
	ly101OV8=; b=UDdnRA01yyzByFjml2RU9Id/gIX8QQvkpf9t3Sswb2u015W5lWQ
	Ahu/r4L26HVKy2XLk4QXq4inctGpZklC476K+RePAniwMurZYzYSF2IpNzrLfXId
	vRCa/keUf+7HIGIuhvVGEVgANFKBWVnojscZ+huIZoR157JmlJTuAop28CRq+kSA
	5WoYNgUVJ5OtDIuXhuLqcpG4sEq63eMZmKLiyA+Vhndv/drM3oDJK46dBug33XeF
	XohE6of+2Be8YuO03XIoCnYcFjpnDeG25t1KPDlgr/mI4/FJu4CYylSG+BLF261N
	whiR2Wc8EH0+BEZG15lylca/qPzyn+CMdzQ==
X-ME-Sender: <xms:_xPIaBAXz4mskkenqPaQ8QLVGixPmGL5EkIkNE67qLA9ICzjY3bgbw>
    <xme:_xPIaMYGw2XOU_82PKPSHCXby4mevcnWf2wjA7RVQRqeDn5QLaB37367HA7zWf_8W
    eRByBF_wSBEvFyQVpA>
X-ME-Received: <xmr:_xPIaMV7NIy6uqt8364hTh2On6c4nVhHUM0qjL9g8MXPfZidWhrRxAltSkVD-512MIN3_SQG4pWRPCMDKG2ewY4iVgwCsUsmeSs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjeektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpeflrghnnhgvucfi
    rhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnhepgfdvff
    evleegudejfeefheehkeehleehfefgjefffeetudegtefhuedufeehfeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhesjhgrnhhnrghurd
    hnvghtpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehhrghnshhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeguvghllhgvrhesghhmgi
    druggvpdhrtghpthhtohepthhrvgguihhnghesnhhvihguihgrrdgtohhmpdhrtghpthht
    oheplhhinhhugidqfhgsuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopegurhhiqdguvghvvghlsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhr
    tghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepthgvtghhsehtohhothgrihdrnhgvthdprhgtphhtthhopehsthgrsghl
    vgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:_xPIaLPgp0pZTvFIT8wWQsrJb1ejIL6243RP0whykhOh50GqJyhBxw>
    <xmx:_xPIaGY0AQ4vdP3Dw9buA8gXFRYSFY817xdSdaXGqvevpdmC-v0MGg>
    <xmx:_xPIaK_vpZb9VEiDwunhGEP8IlE77Cl_FNMxbSgqc1LnBQYP1BwS2A>
    <xmx:_xPIaHQuHmlf14Jg0X1Vt3GH4BPf-A5YLsAa97i-AYfHqkeVApZAiw>
    <xmx:_xPIaC6of_hqXpaVMJjBGWS-Ig_2QYEHoin6uTAt4VnB0MmyatHVHfJm>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 09:26:23 -0400 (EDT)
Date: Mon, 15 Sep 2025 15:26:21 +0200
From: Janne Grunau <j@jannau.net>
To: Hans de Goede <hansg@kernel.org>
Cc: Helge Deller <deller@gmx.de>, Thierry Reding <treding@nvidia.com>,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, Daniel Huhardeaux <tech@tootai.net>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] fbdev/simplefb: Fix use after free in
 simplefb_detach_genpds()
Message-ID: <20250915132621.GA1931265@robin.jannau.net>
References: <20250915-simplefb-genpd-uaf-v3-1-5bb51506a5b9@jannau.net>
 <802c1bad-94e4-4dae-94fe-ced28aebbe2a@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <802c1bad-94e4-4dae-94fe-ced28aebbe2a@kernel.org>

On Mon, Sep 15, 2025 at 02:19:30PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 15-Sep-25 8:36 AM, Janne Grunau wrote:
> > The pm_domain cleanup can not be devres managed as it uses struct
> > simplefb_par which is allocated within struct fb_info by
> > framebuffer_alloc(). This allocation is explicitly freed by
> > unregister_framebuffer() in simplefb_remove().
> > Devres managed cleanup runs after the device remove call and thus can no
> > longer access struct simplefb_par.
> > Call simplefb_detach_genpds() explicitly from simplefb_destroy() like
> > the cleanup functions for clocks and regulators.
> > 
> > Fixes an use after free on M2 Mac mini during
> > aperture_remove_conflicting_devices() using the downstream asahi kernel
> > with Debian's kernel config. For unknown reasons this started to
> > consistently dereference an invalid pointer in v6.16.3 based kernels.
> 
> Thanks, this v3 patch looks good to me:
> 
> Reviewed-by: Hans de Goede <hansg@kernel.org>
> 
> I assume that you will push this do drm-misc yourself ?

I don't have drm-misc commit access yet. I took this as reminder to
request access so I will either commit it myself or ask someone else in
a couple of days (if nobody beats me to it).

thanks,
Janne

