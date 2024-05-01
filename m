Return-Path: <stable+bounces-42923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D058B90F5
	for <lists+stable@lfdr.de>; Wed,  1 May 2024 23:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28D941F232DA
	for <lists+stable@lfdr.de>; Wed,  1 May 2024 21:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF87165FB0;
	Wed,  1 May 2024 21:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="kjIibFAE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OoDx9rYj"
X-Original-To: stable@vger.kernel.org
Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25E7130A4E
	for <stable@vger.kernel.org>; Wed,  1 May 2024 21:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714597348; cv=none; b=eF7HCPvd7wn+x5us3+KppcESxVyJfVfRwAKuJQGUMnhBChmk87vTq3zKr/xKriy0gSN6JjJ9RIB8ltcYchqW82KsD6CN41C1IfBXuZ1iOW2OLOYy7KssA4B5oMSqGXfmoVug4lJBKI2ksoc1db6PskM4YH4dLpF8MW1e+K4CFUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714597348; c=relaxed/simple;
	bh=NxSfLUKsiomIImnyGgyJm3UudWYY/JSTmCq8xKcdRh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1krHWKmlV5RHggjRO5YTapaT9HbbjRJMySfDcdT3+LSjGqZI6zQH+PUNiJM3RutHdF4ZrNT8KZUtT3RwcTqdXZ4hCZNJFwnxL+oX/ISJSEcLR8ZlW2OEF2HAXm9nI3ifnlRBpU8ezP6DbVLinCWefDXV3bgt8sgWO9t++RBWxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=kjIibFAE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OoDx9rYj; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 7F754180019E;
	Wed,  1 May 2024 17:02:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 01 May 2024 17:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1714597345;
	 x=1714683745; bh=+XY6aY2qZ2/7pxhp2ACoLYMto4L5WIBHaG5wSUHxqOY=; b=
	kjIibFAEdSNAmk7Kc4yuXRFeMWFrn+I5Ram6kZKTwIr4waV4ZQ/WD16Z8+Z3ut27
	JmHMhZ+p3yOjPBtXZRiUsRIEgmAOgLLw4fsSkqU3dFjCuvknjYyP7FVCraOpaGDS
	YhCwohHZZCGS6T1gY1eKwI4mzikyOMRh8/WaDHnGILwYHLCNn4mKD4/8/cwGY5Wz
	qIk2ZEyA1QME0c6HTyRaQSwuZR6KH1sdb1/G+prqK7NI3mH5j/N/7cnQ28zOkc0D
	6TDgqnJiPLQq+NH0JPsvbndKGWHYoySAY6Xdwgf15zfWOZ+1oRHXekKLcj2T8Mtu
	V4OoaVIoY5UfJB0vpTpS5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714597345; x=
	1714683745; bh=+XY6aY2qZ2/7pxhp2ACoLYMto4L5WIBHaG5wSUHxqOY=; b=O
	oDx9rYjhTkWg2jvpgpPDj+rhfBWcSUZbexlTZWzHj41sun3A+4/ytGv8gmc/xHI/
	5GOnLR8L+fKl+pxT889WWRi7ZGE96wqJq8y/Pfp6aGqn8p3zzlxgrG1wv2iCzcnE
	k1SRuQcXUs+EdtODtm2koCJOYFKb6q7JphApL+hA9RBEfH6kQbLrwaNbQ/cCA9/6
	atY4Q0DOSiVqivDv3RO6W9C9h9XJNzl600mbLeMKAVx8BJOYSiibgR8HgLPwA9QC
	5cFdOqESuMO5TjH5dzD5cmG5VR03y4t5GcuKnKmeA56VhajPmLlbVqROrvU3aTiB
	rAy7YwQIZyfClhQQaQoAA==
X-ME-Sender: <xms:4K0yZoIkGPhYycwtJZFpvTlYFA6X0SYfS4bG3j_vgk6Hrhc00ZmNfg>
    <xme:4K0yZoJz4v7VdgnalhFj5K-poksspfutJ_1sbpEDShWAyuBcR2RGvfM03hVX8fXhy
    DYSs-rur6TzDlpelQ>
X-ME-Received: <xmr:4K0yZotSaimp4rz4wUkB1CZSEA1-TqnoG46nv1TMwNk2Rj59DRmmt5Z8z9QRvuBWXYcLYiB2kmxgg-bn0wxWOY2cjNY6kJVyinfD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduiedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpeffhffvvefukfhfgggtugfgjgestheksfdt
    tddtjeenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpedtgfeuueeukeeikefgieeukeffleetkeekkeeggeffvedt
    vdejueehueeuleefteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:4K0yZlZzdQ-bRvACXKv6aOVJNo4TIorXjli98ZxIAILbMsqMy4W3BQ>
    <xmx:4K0yZvYjLT4lYLG0AsSlFsWP0TZu0d_aQXk9tRfq_EOTeo-hYmswUg>
    <xmx:4K0yZhDwNQO-7k4szh_m_cJxp6pyK2sC_BrUjIkUP3GW2Pzavt0arQ>
    <xmx:4K0yZlYoA3XQ4sMBE44i9PbbmgcuiJEJer7FRGF4vN0ukI076VNrgw>
    <xmx:4a0yZtPzThetjesLK3ridEqgEWbJnAONhmWCo6driaBowNmdhw9ITFtG>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 May 2024 17:02:24 -0400 (EDT)
Date: Wed, 1 May 2024 15:02:22 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: gregkh@linuxfoundation.org, benno.lossin@proton.me, 
	bjorn3_gh@protonmail.com, ojeda@kernel.org, walmeida@microsoft.com, stable@vger.kernel.org, 
	Andrea Righi <andrea.righi@canonical.com>
Subject: Re: FAILED: patch "[PATCH] rust: macros: fix soundness issue in
 `module!` macro" failed to apply to 6.1-stable tree
Message-ID: <c3quwogwcekhndus6zfls2acrjbcjhcatqryotkpis2jzdudbw@db5qqg3vodpg>
References: <2024042940-plod-embellish-5a76@gregkh>
 <CANiq72npZyXLXBZQe3gzPX-geyUqkF1HNg6H28TKr9t_BE+DuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72npZyXLXBZQe3gzPX-geyUqkF1HNg6H28TKr9t_BE+DuQ@mail.gmail.com>

Hi Miguel,

On Wed, May 01, 2024 at 04:25:08PM GMT, Miguel Ojeda wrote:
> On Mon, Apr 29, 2024 at 1:21 PM <gregkh@linuxfoundation.org> wrote:
> >
> > Possible dependencies:
> >
> > 7044dcff8301 ("rust: macros: fix soundness issue in `module!` macro")
> > 1b6170ff7a20 ("rust: module: place generated init_module() function in .init.text")
> > 41bdc6decda0 ("btf, scripts: rust: drop is_rust_module.sh")
> 
> For 6.1, it is a bit more complex. The following sequence applies cleanly:
> 
> git cherry-pick 46384d0990bf99ed8b597e8794ea581e2a647710
> git cherry-pick ccc4505454db10402d5284f22d8b7db62e636fc5
> git cherry-pick 41bdc6decda074afc4d8f8ba44c69b08d0e9aff6
> git cherry-pick 1b6170ff7a203a5e8354f19b7839fe8b897a9c0d
> git cherry-pick 7044dcff8301b29269016ebd17df27c4736140d2
> 
> i.e.
> 
> 46384d0990bf ("rust: error: Rename to_kernel_errno() -> to_errno()")
> ccc4505454db ("rust: fix regexp in scripts/is_rust_module.sh")
> 41bdc6decda0 ("btf, scripts: rust: drop is_rust_module.sh")
> 1b6170ff7a20 ("rust: module: place generated init_module() function in
> .init.text")
> 7044dcff8301 ("rust: macros: fix soundness issue in `module!` macro")
> 
> So essentially 2 more commits needed than the dependencies quoted
> above: the rename (which is easy) and the regexp change so that the
> drop applies cleanly (which makes the regexp change a no-op). This
> seems easier/cleaner than crafting a custom commit for that.
> 
> I think dropping the script is OK, since it was already redundant from
> what we discussed last time [1], but I am Cc'ing Andrea and Daniel so
> that they are aware and in case I may be missing something (note that
> 6.1 LTS already has commit c1177979af9c ("btf, scripts: Exclude Rust
> CUs with pahole")).

Yep, sounds right to me. 

Thanks,
Daniel

