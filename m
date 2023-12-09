Return-Path: <stable+bounces-5110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F79F80B3F6
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 12:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB2831F21103
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 11:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D08813FED;
	Sat,  9 Dec 2023 11:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Av1K1glq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ap6XZt/S"
X-Original-To: stable@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDF0E7;
	Sat,  9 Dec 2023 03:29:59 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 7F6A55C017F;
	Sat,  9 Dec 2023 06:29:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Sat, 09 Dec 2023 06:29:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm1; t=
	1702121398; x=1702207798; bh=FBEUI9NsgNG7X5iwAyLcs6IgpqsahGTv5Fh
	mv1OWCaQ=; b=Av1K1glqpwzOsYalk0XePbgC8WnbK4P0e7u6URIDOQPbr0edh2i
	Y+HR+y5Lx2Xi2xtUriS7N+JwcDS03blStbpSqvDx/v4buieYCi7T5h/l1t2MS82B
	MzUU156urNz8xHCn7AhL5ZLaS9/i/P1xuH0qLi8S+kkDfl3NiNFNVGangXS6uFjf
	1Bo3vE+3MvGsXvxW+Unt2Aw67Ob9aRdIxehi6piGurvxudIVWQxu3QCdFS8s6DCx
	q2SymNDTxTvqJ/4pdKa03C6efVGHbbO1LknTVIBDlKnZ95NaHUCwLZXjkdcOUQAj
	A4R5WEKbv/PKKOlznF8LrbRFex1lcbtbdCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1702121398; x=1702207798; bh=FBEUI9NsgNG7X5iwAyLcs6IgpqsahGTv5Fh
	mv1OWCaQ=; b=ap6XZt/SKZLYVcXMuKQBQbQTk0WGVzMEwTTxFdtN5sEHy6rzLBt
	qM+qLCybi2a16NzM/lS3w+1zXnTw+pqxe544qIGh8PdK529IJfLDHS54gHHqEXQp
	uEzI8EuZOk1nr5RBKYIQkWzYVL/JHaTuxY683pRaigIekhEXtPLD3KkLeuKehmZ2
	z2EpwK5KeJPLEAljRJjk2efIT/EQEkkwR3vHJFUE7RJ1aXSgmcW5tRum3j1NtBD5
	XlvwFhzg2lj4XB04nuem2gs/I03wK2w19m/7COoOOcqdoEVrN6sY5EgZ4zzHRuyq
	3VDeaJzndkDGhv8ESWAmkXeWNlZI7yqX+6w==
X-ME-Sender: <xms:tk90ZX0Ll1iZiXwzZwy5Ra96Z3g6ueCfOV54ZannCeM9u7pIIUDn5g>
    <xme:tk90ZWFO1LHnVdW-VcxY5LGQkrBtz8Gn5SvY9aFn9uuPeYB1I9jf2sST52SFLUtaR
    ELBeQd-ed_-fw>
X-ME-Received: <xmr:tk90ZX7dnMwjyqhFdb5TsIEQsQrrZTKALrXMvdSX_r1MgPoqCDMRiRAxw6rIvicRScz1Cfuf5myRJdA__iuZDK8nKHeyT0lrYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekkedgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeegve
    evtefgveejffffveeluefhjeefgeeuveeftedujedufeduteejtddtheeuffenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:tk90Zc3u1Mai8tHT3HBFUVpojAFbNnYMsTjMMXqOQsbv-8PbPbg-ow>
    <xmx:tk90ZaGfdR4hVgAeX8Q4rQgPFX4iGk5oEmN-pOMaog3T-iPr1KH2mg>
    <xmx:tk90Zd850uwgoF-qRLTqgrG3scTpiMAiXhpIRx-ZlE4MSKNcfabGpw>
    <xmx:tk90ZY8ENIJUgqn-vG6gcOw4jPoeJppXK1oBpWcBcsMBaEH7v07Wpw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Dec 2023 06:29:57 -0500 (EST)
Date: Sat, 9 Dec 2023 12:29:55 +0100
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	stable-commits@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Mark Brown <broonie@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, stable@vger.kernel.org
Subject: Re: Patch "spi: imx: add a device specific prepare_message callback"
 has been added to the 4.19-stable tree
Message-ID: <2023120959-buffer-amendment-77cf@gregkh>
References: <20231208100833.2847199-1-sashal@kernel.org>
 <20231208104838.xqtiuezd72nzufd4@pengutronix.de>
 <ZXQKi4QvI7KOJsyb@sashalap>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZXQKi4QvI7KOJsyb@sashalap>

On Sat, Dec 09, 2023 at 01:34:51AM -0500, Sasha Levin wrote:
> On Fri, Dec 08, 2023 at 11:48:38AM +0100, Uwe Kleine-König wrote:
> > Hello,
> > 
> > On Fri, Dec 08, 2023 at 05:08:32AM -0500, Sasha Levin wrote:
> > > This is a note to let you know that I've just added the patch titled
> > > 
> > >     spi: imx: add a device specific prepare_message callback
> > > 
> > > to the 4.19-stable tree which can be found at:
> > >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > > 
> > > The filename of the patch is:
> > >      spi-imx-add-a-device-specific-prepare_message-callba.patch
> > > and it can be found in the queue-4.19 subdirectory.
> > > 
> > > If you, or anyone else, feels it should not be added to the stable tree,
> > > please let <stable@vger.kernel.org> know about it.
> > > 
> > > 
> > > 
> > > commit b19a3770ce84da3c16acc7142e754cd8ff80ad3d
> > > Author: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > Date:   Fri Nov 30 07:47:05 2018 +0100
> > > 
> > >     spi: imx: add a device specific prepare_message callback
> > > 
> > >     [ Upstream commit e697271c4e2987b333148e16a2eb8b5b924fd40a ]
> > > 
> > >     This is just preparatory work which allows to move some initialisation
> > >     that currently is done in the per transfer hook .config to an earlier
> > >     point in time in the next few patches. There is no change in behaviour
> > >     introduced by this patch.
> > > 
> > >     Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > >     Signed-off-by: Mark Brown <broonie@kernel.org>
> > >     Signed-off-by: Sasha Levin <sashal@kernel.org>
> > 
> > The patch alone shouldn't be needed for stable and there is no
> > indication that it's a dependency for another patch. Is this an
> > oversight?
> 
> It is, appologies. I've been traveling and my patch-shuffling-fu isn't
> doing well with conference/jetlag.
> 
> This is a dependency for 00b80ac93553 ("spi: imx: mx51-ecspi: Move some
> initialisation to prepare_message hook.").
> 
> > Other than that: IMHO the subject for this type of report could be improved. Currently it's:
> > 
> > 	Subject: Patch "spi: imx: add a device specific prepare_message callback" has been added to the 4.19-stable tree
> > 
> > The most important part of it is "4.19-stable", but that only appears
> > after character column 90 and so my MUA doesn't show it unless the
> > window is wider than my default setting. Maybe make this:
> > 
> > 	Subject: for-stable-4.19: "spi: imx: add a device specific prepare_message callback"
> > 
> > ?
> 
> I borrowed the format from Greg, and I'd say that if we make changes
> then we should be consistent with eachother.

Sure, I can change my script, but better yet, can you send a patch
against this file:
	https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/scripts/added-to-stable

> No objections on my end; maybe I'd even go further and try and send one
> email per patch rather than one mail per patch/tree.

one-per-patch isn't going to work, sorry, as I push out queues
separately.

> Or... finally drop the stable-commits mailing list altogether? Does
> anyone still need this (vs. just looking at -rcs)?
> 
> Greg?

Yes, we still need it, we want a public record of what is merged, and
that is what the mailing list archives provide.

thanks,

greg k-h

