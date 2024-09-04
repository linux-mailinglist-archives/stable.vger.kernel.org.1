Return-Path: <stable+bounces-73066-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DD396C058
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 16:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25CED28EDF4
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 14:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D661DA0F3;
	Wed,  4 Sep 2024 14:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="LLBsBXyK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IahBWetf"
X-Original-To: stable@vger.kernel.org
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C73144316
	for <stable@vger.kernel.org>; Wed,  4 Sep 2024 14:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459896; cv=none; b=tNH2FTjLYlvwGlPCqO/jBRjRxi/9bbQrNK9V3Zl1i8mKzkkgrIMpAdx1CCZc20XKv6vWVmDDduD+1sWXFWplUbSy4GH2Dc7vSB0hsV8+kIijYXPka4VN7xFUyCDDjl7w+Mqqn1FiXOflE0D0OwRySIUmfD7GnsKouNDtGT1lUKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459896; c=relaxed/simple;
	bh=3zvpN/O0DpSaUWn9QZlfIZ+TjXklr/RB3neqWf7UPew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2n0/8IPdDk8aJkx8vFHpu4XfEwhNvrF7D5ool8rmWtzEYWeDYuTBJsdKPxNZZNs+tT5KkmFYbrYFaMyelcJoOQwIuIS+nKbd3zBnnFqx2guVZRH4clL8CRhfhdGIPvNfP2jvBymprDFS0Yqw/t2b7Iuq4x8odSbYrzY0yPB5e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=LLBsBXyK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IahBWetf; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A49481140223;
	Wed,  4 Sep 2024 10:24:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 04 Sep 2024 10:24:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725459893; x=1725546293; bh=X/EsrWh82Q
	lkIhvRmtpTbTmjLyL83iX0dHlpXqJDj+A=; b=LLBsBXyKVfPceaExuLWOKwXrJt
	11l2vNH3a2lEPQ+vunLSMSLevz4kU0x0Bt4/bsQJSzPtZKedBkJ4sICI9b9NxSrs
	d/HduGo1RNzrDDsQx3BmalRSmXrMJjesTplKxegazdqPgkn0DT6RDdrVvoNeggzX
	Yq8HvAdPbiOzreaGPgZi3ND8i0mQeh/l0XJL61lIuNDEjMchC+YW2U+cC7NzgjU8
	vt01JOUCN67hjtC0Ft28gvtKPtA26IswNQSBHfuFGr61+Jgtiq1WCw6QfSEJQqS9
	CRerXZO0JHXTenSqymibBvYNL6VaY4raalfG1rOUTxLU331XriI7dqJY9TpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725459893; x=1725546293; bh=X/EsrWh82QlkIhvRmtpTbTmjLyL8
	3iX0dHlpXqJDj+A=; b=IahBWetfVGhIhCsfSMPKDMLDc+TrV4XkHwLYpeg0KyjQ
	+LU6LfzYyLs/8jAkAdYuP+JKtGbRvxwGJTM+pqrMet//11BEqCuDAjO43csInjpn
	Ylr+ced9CyE/FwBX2ZW8jEfUAXxHhe9c4Dl5Fg21mLzCaIs8IhOfwRjY0YEUmlvs
	1LZlk1J8luYZbDAcpDD5zVzJz7qEqvWqVvyrsfZX2FLA+1EsJGukxxqX3jDyMs6U
	7583sTuCHT3xUzgH3PrWpf5D2h6eyW2vdq/4AiX7fF/F25ET4ewqSDOAS/fP0M1k
	WGu7yahYUJbZBpkA7kDjGBXIyB4lBTR9Pvy/5kuAcQ==
X-ME-Sender: <xms:tW3YZvI714MqWvpmM79l4ZZsJt6CX6aepMojTDrMVqECFmp6xzIwHg>
    <xme:tW3YZjIOjun_LkCDx-ro-Mpa96Pg3SUlgqogBKqBxtiXzDIjYu3M65CRlEBWzVrAO
    ADuSWLXy0XxzA>
X-ME-Received: <xmr:tW3YZntPtXsHzWoZrty9FDeuf41iw1PHeDM183XEGt7iZlbiiXrhtMz5-TRmzGGY-W3fwOQe7u6UEb-RXguSNrK8ogdFoDI4np1cjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehjedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrf
    grthhtvghrnhepheegvdevvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefh
    gfehkeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohephhhsihhmvghlihgvrhgvrdhophgvnhhsohhurhgtvg
    esfihithgvkhhiohdrtghomhdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehsmhhoshhtrghfrgesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepsghh
    vghlghgrrghssehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:tW3YZobF4sWrRnFHeySlATjKwbf7eHSoDXC-ot6l_YIJq5k8nDYXAQ>
    <xmx:tW3YZmZC0Ib74pkmFWQotIEC3A_2my-rhQAUPDq-zqP0cryzhSJitQ>
    <xmx:tW3YZsCFQq3P1XBOWO_t2R3qr0X1HiAw5nfyrNLfLXMokLun6r1sYA>
    <xmx:tW3YZkYEG8ko2V7Vkv_7KPqI9-xyrmFG6Ixne1MqliSoRvN-ikLnpQ>
    <xmx:tW3YZjQ6BMJDKgvPVF7DDUlNIRDKkx6jL77zMT1eZQzcEMg5fHyT0w0w>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Sep 2024 10:24:52 -0400 (EDT)
Date: Wed, 4 Sep 2024 16:24:50 +0200
From: Greg KH <greg@kroah.com>
To: hsimeliere.opensource@witekio.com
Cc: stable@vger.kernel.org, Mostafa Saleh <smostafa@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Heelgas <bhelgaas@google.com>
Subject: Re: [PATCH 6.1 1/1] PCI/MSI: Fix UAF in msi_capability_init
Message-ID: <2024090445-dismay-colonial-40db@gregkh>
References: <20240902083709.6216-1-hsimeliere.opensource@witekio.com>
 <20240902083709.6216-2-hsimeliere.opensource@witekio.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902083709.6216-2-hsimeliere.opensource@witekio.com>

On Mon, Sep 02, 2024 at 10:36:42AM +0200, hsimeliere.opensource@witekio.com wrote:
> From: Mostafa Saleh <smostafa@google.com>
> 
> commit 9eee5330656bf92f51cb1f09b2dc9f8cf975b3d1 upstream.
> 

Now queued up, thanks.

greg k-h

