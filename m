Return-Path: <stable+bounces-58199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99409929FA3
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 11:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C96151C20839
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 09:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21338768E1;
	Mon,  8 Jul 2024 09:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="VW6QBK1e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PeDFcYjh"
X-Original-To: stable@vger.kernel.org
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A468762D2;
	Mon,  8 Jul 2024 09:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720432463; cv=none; b=W97+SoipKsKnDmO558+WpjO4E+6AWftLMEqmaRQ8v0ftbKpdK9GN7AWpnGhhk/Zu72rTCUpKC5d1T3mfk0l7A0ipRLWWfeA5RAryS/okBvHgkysHIFdAxaY14Xas5inx9gzL9Iln6sRjLyLS0M4Uw5i8DZlq59yR9BGfZJ8pbj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720432463; c=relaxed/simple;
	bh=/YJBv0fRaHXgXHPGphXvbBH86bC8CdMHVs8HLNw0WNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGFG4Fm3VztZ2bF1tuqrX7FNw3iRWJ2YSVKMtsRvXSUSNP1knpYUhu5l9jnX/bDMvUDDwaAnm9XsXEYz1Vxq7ZJQvDI6zGAU6BA8xY6hBchZ6Gm5TVRZpxPasCH90K4we8MXuTgAQ73GXPErrCQfZJJShXrTPuRO+18/71PvNLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=VW6QBK1e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PeDFcYjh; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2EF741140390;
	Mon,  8 Jul 2024 05:54:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 08 Jul 2024 05:54:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1720432461; x=1720518861; bh=VT7j+W6avd
	oFz4TXh7QfAWgv7o9GQXrgGo6M4ehU4Tc=; b=VW6QBK1eUudeGXzt6j9S3ZeJmr
	SAH1OGv8V0b/UJKnpP4fyym6NCzAoq0BKeqSpI1q2t5ewWyolHcz9x0ieEeZx01p
	dPHt34rhspmyVeKXV7vJHq6W4s7oP/lGUXbtkLiHo/jAW1xQ9l2k0TY1RUQTADVs
	DeCGNUYsd7xBmVAWAqrjv/gKegQYhWTjHgieCdR+bd15bfUFNA3gh5eErRHQ08b3
	D2sAKPBcWtmLWRU/PBoRO5iwC9Qj8RwMwigqsXADbwp7g8xa+RmjgJ19MJQvqnHu
	9oGsYjLKLc7A0Y8u1GCCYprpx0EjGlyyiecP1pNaHNF+57Vkk+JUaZ0CVfPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720432461; x=1720518861; bh=VT7j+W6avdoFz4TXh7QfAWgv7o9G
	QXrgGo6M4ehU4Tc=; b=PeDFcYjhSRQPwospvoH6gnnX8TKuMmJCsavhJKV50epl
	XAgMwPEHdYvJK6+n8Kh9nt1aWri7bholZ9uSWmoEM/k94GA78VqnDtZgbNCjDeHF
	Onzy+8OncBtyayVGRHck4969OCC9ESLQR8I6ceKROM2ukYQd0jERhuwpNfX4qfG1
	CCYAb5y99drjjSIPSIDWsNr7mABwWJXLzkBGz17P2MLueTIdKk/Kh/EFS3IVF1Ou
	bWPQJmXtNbTfmRQ2OXWnfmp6ppE0P3WsuGx75zIgaZRVepWonZyzgxvcA35lXDNv
	Qn/JhCNBacV24D0sV6f0F+XybENOY1LlM9hD9MPHUw==
X-ME-Sender: <xms:TLeLZixRdyx7JlwtdfEcfTWDWPa8MpSex0Vtk0_i8YCOxEOI_AZuqQ>
    <xme:TLeLZuQzQWa_sKN_gHXtpFl1gJvO0bTfTG1K7jehcVA3iNDNfZHhZ9SyxJwB8JdP-
    fS7GVtz-NWGjg>
X-ME-Received: <xmr:TLeLZkVI8qMaO_4rPukweBJJiwK_Ar40BWObcGY6JswrwcPpIUt1f0inxq7MdbMleDECoVssRO-yfWJ302Ev-CV4IYoCxW3GPU-Now>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeegheeuhe
    fgtdeluddtleekfeegjeetgeeikeehfeduieffvddufeefleevtddtvdenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:TLeLZogvljX7G_utU1FjCcmObUHdV9S9yZY3n-CMfyqeYMb0KtjgVw>
    <xmx:TLeLZkAxSr17BPhvo9LV9mRQiJztsC30R_oqIlgiBbnF49g-csZwEw>
    <xmx:TLeLZpIUvagbDRGeWhLI51qd4dTCUfGOvyeAjvCKgcLHAmYgGqJIhg>
    <xmx:TLeLZrB_Mr7EQgYwrPFB00xXGXrYxsk8NdGoI7OOYdSPPrsqRlssbQ>
    <xmx:TbeLZsYh9U8Hu3meLGzcxd5n9GtZSCwRTOtZ30taDcbHMSjfwNPqFu_T>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jul 2024 05:54:19 -0400 (EDT)
Date: Mon, 8 Jul 2024 11:54:18 +0200
From: Greg KH <greg@kroah.com>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, edumazet@google.com,
	Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: Patch "wifi: cfg80211: restrict NL80211_ATTR_TXQ_QUANTUM values"
 has been added to the 6.6-stable tree
Message-ID: <2024070808-discover-juror-2bde@gregkh>
References: <20240707145552.3695089-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240707145552.3695089-1-sashal@kernel.org>

On Sun, Jul 07, 2024 at 10:55:51AM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     wifi: cfg80211: restrict NL80211_ATTR_TXQ_QUANTUM values
> 
> to the 6.6-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      wifi-cfg80211-restrict-nl80211_attr_txq_quantum-valu.patch
> and it can be found in the queue-6.6 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 0014eb2dd000fba5b30a3cb883b750bd344f050d
> Author: Eric Dumazet <edumazet@google.com>
> Date:   Sat Jun 15 16:08:00 2024 +0000
> 
>     wifi: cfg80211: restrict NL80211_ATTR_TXQ_QUANTUM values
>     
>     [ Upstream commit d1cba2ea8121e7fdbe1328cea782876b1dd80993 ]

Breaks the build, so I've dropped it now.

