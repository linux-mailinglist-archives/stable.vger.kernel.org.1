Return-Path: <stable+bounces-61773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0620F93C719
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 18:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A05A11F21C6D
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 16:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1A019D880;
	Thu, 25 Jul 2024 16:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="u+FpGg3c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="blXhFWrj"
X-Original-To: stable@vger.kernel.org
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4AC19922A
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 16:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721924745; cv=none; b=ulfpt3EEUfFX15dUuxtwiaNdkQEWKb/FZD+OfaEf2RFfLl4oZy31vrpXtzLh3psj6cgzGis5xin6kuMfywe+F5qhN2zfrh8/Mdq6BuTTwjql5zu0S11R7qY0bSWAlymO5Hl3b1wHkOb6ypdIEbyJhH9ZYXUO7Q+tDpHgxLfY7Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721924745; c=relaxed/simple;
	bh=YMMrg37swb34JChFvppKNE4HrczuVouFUyImLhdmU1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNZlmLE5FA91j7fCwLdKGC2E5OyccV0TcuoYh1wFLgNSEAYRAz+Beu+a7MRWr7/C3Tl2wJHeRLUeCYJ5YRQEdjHe5SFz5CzcpXX6a62lNyzWg3X6QZ14hOyLRw6ZO27UkhQiemCoCxSIqtrj/3GvlxeAMAJteu4e7FyetWhtKsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=u+FpGg3c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=blXhFWrj; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A53C91140133;
	Thu, 25 Jul 2024 12:25:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 25 Jul 2024 12:25:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1721924741; x=
	1722011141; bh=68ODnCNeS2lxbm5JoDgIm9RgWDDPs1ELYiTqDzpZpLE=; b=u
	+FpGg3ceoFDXqBMbXDx9wGImPWCiQPV3gJfQlJ6jNDI0h5cbvuJBteZSV2dr9oeS
	AEYEt8fjgd+C0esIXAHXmt6BV7RKG470yR4Gv6ry6u0A+XIksdi+I2Oij/PfAib5
	cxijkd2EQD4ChFQuhKtNGJoECDI7KQXWR+fJ52T4cEktgDRO22sAU+Q1n44r4+JA
	k6i7mClHpDab6/q7kmeibAM1BOlOPQKtlSOM6zm4NvXBnzm/iPzDQ8RtYX25uibm
	yBaYLOd2SUnd8Lty7ydA43IYTt/aJCNF6LMmHTOiWNBbN1jXpAIGX7RTDVQJ6D61
	EpeXYz1nyQYQv+pV9eRtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721924741; x=1722011141; bh=68ODnCNeS2lxbm5JoDgIm9RgWDDP
	s1ELYiTqDzpZpLE=; b=blXhFWrj5Xm6NOr+1U8/OmNjHroogqziY4FIPpBI20AC
	jotJ4xrAP7ZU43uM8+K6Y55+TPBYSIFsPbbKAJg5JROuz7SyfX64uxrAjk3l8G6f
	2rxs0gFjK8u2L0JmUV0XXDabyjCVaS0UVSzOlQqiNJtJXLGyIVjd3ubqo9SoBhFY
	PdCAD7PADAcUVFEwgyKqWjc6JmXNm4Dr8SCu35XEEwXWGc24IakZ7IOYMyWapB+0
	S2eEtwfI3yeIDj6PW22+X9G8l6tH8qs5IetR/Px8F/x+34AVcSQDwVtUlzIXF7RB
	7RRdp6WhACE+4gARFdB3NRHnLRsEbDffEcaqkzakgQ==
X-ME-Sender: <xms:hXyiZsetDMa79VNrzkp53njbXUWMmHv7Abrmm3eEAt99efqw48ZA-g>
    <xme:hXyiZuPj8MSeZAGE6WvUYX3S6fX_fnEJCJArGS6VErIfyUMOAON5gWbYTapU-DO4g
    NJQCCDE0tmS7lsl780>
X-ME-Received: <xmr:hXyiZthR8y26jRU6ctM2mP_QG6QCpxGq90f2ea4Wd40Cuzg_8OU7jxhbXzCsIrWBpRzZBFVIWVHCh0zCZ6IdeeBWFwmmvWqvT2Sy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieefgddutdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgr
    shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
    hjpheqnecuggftrfgrthhtvghrnhepveeilefhudekffehkeffudduvedvfeduleelfeeg
    ieeljeehjeeuvdeghfetvedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhppdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:hXyiZh9VJTQBdzheOjIBm0m6zrQoDmPvKdBGpdvbzjENMaq0Sv4ToQ>
    <xmx:hXyiZovcNlWuv9RpeFyDSU2kUGrHmg4Ax9aywgWEWwL2n_vVmHe5Rg>
    <xmx:hXyiZoFli-0B3HVcqTiDurYGQ4Zm0NIQ-65jLW2eIEhLQFke3ECZRg>
    <xmx:hXyiZnOvFUXS5hsQZG-ZyvAmvyEO7mVJongzSrXvBaazggiVgxbG8w>
    <xmx:hXyiZqKZVH2GzRTWI6LrnwbB6en5LLWn-MUqF1ne3u0-UVZkVwyKqrje>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jul 2024 12:25:39 -0400 (EDT)
Date: Fri, 26 Jul 2024 01:25:37 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Takashi Iwai <tiwai@suse.de>, stable@vger.kernel.org,
	Edmund Raile <edmund.raile@proton.me>
Subject: Re: [PATCH] ALSA: firewire-lib: fix wrong value as length of header
 for CIP_NO_HEADER case
Message-ID: <20240725162537.GB109922@workstation.local>
References: <20240725155640.128442-1-o-takashi@sakamocchi.jp>
 <94600ca4-47ce-4993-b6ce-dabb93ef01dc@embeddedor.com>
 <877cd9ih8l.wl-tiwai@suse.de>
 <9d039b39-06c1-4328-bd5b-8b2c757ee438@embeddedor.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d039b39-06c1-4328-bd5b-8b2c757ee438@embeddedor.com>

Hi,

On Thu, Jul 25, 2024 at 10:16:36AM -0600, Gustavo A. R. Silva wrote:
> Yes, but why have two separate patches when the root cause can be addressed by
> a single one, which will prevent other potential issues from occurring?
> 
> The main issue in this case is the __counted_by() annotation. The DEFINE_FLEX()
> bug was a consequence.

Just now I sent a patch to revert the issued commit[1].

I guess that we need the association between the two fixes. For example,
we can append more 'Fixes' tag to the patch in sound subsystem into the
patch in firewire subsystem (or vice versa).

... But it is midnight in JST, let me go to bed...


[1] https://lore.kernel.org/lkml/20240725161648.130404-1-o-takashi@sakamocchi.jp/T/#u

Thanks

Takashi Sakamoto

