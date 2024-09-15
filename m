Return-Path: <stable+bounces-76153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAAA9796CB
	for <lists+stable@lfdr.de>; Sun, 15 Sep 2024 15:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D823A28151D
	for <lists+stable@lfdr.de>; Sun, 15 Sep 2024 13:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34D31C57BC;
	Sun, 15 Sep 2024 13:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="klh4Z7Du";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GRgxYDyO"
X-Original-To: stable@vger.kernel.org
Received: from flow4-smtp.messagingengine.com (flow4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777641C3F38;
	Sun, 15 Sep 2024 13:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726406552; cv=none; b=tFBNaic10ZqmOeaJCY+Grb4NyCtEGna9OW8a3K61Pj+0hnTY1kBgY4UwZTPP80LffWwG9MQ6ES6o0T3Feyp+9OyQFXBbjZ3AWUYZL8pQoZZzNopFqnzSN9uYxg/B/2WJG3U+dUctkn2I4Q+tmw7LDK1OUBbYNLDGjkwi6710H34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726406552; c=relaxed/simple;
	bh=HPklK2HqeAak351kg60i6/u/1YoEifKLFfZBoQU4qBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5p9sqHEFzFt+FLTHGr0u/7fnFwpRUEc1kCbvJ39taFUWz9geKiFaKEe2AXrB92KjR/wyhhtNcIINs2V2zqONC39YGEMuXvER/Zuy4Tma9hOdR8hq3x1icmC7cwewmg6/oMVd5iOechhXcZxbJ+0U3jGfJPqnJG3WGLCvMuVDbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=klh4Z7Du; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GRgxYDyO; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id 6C4302002F8;
	Sun, 15 Sep 2024 09:22:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sun, 15 Sep 2024 09:22:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726406549; x=1726413749; bh=8IX9+V+TNf
	Y/M7trh+uuRxUvH/7oXTV9uwRun+jVTiA=; b=klh4Z7Du6RXXMBk5rZzcbx3ov7
	ZJj/UZCw2xkdFBkTpkI2YzoESOXxpCeFfe0FQQMRT2apB1P2cdTez4EtTVbM0yci
	tyjiI9T7l6EDfCOF4Fevdj5GZ9l/CwgImxabJAO0zaIkvxw0RDcrbtzYVIh/768Q
	2gv4iE+zAqaCuaOj1OUIhr5s1+m/YXAr0wn2lACOJIhliCIF5pQ/t2mf5ef7rHQ5
	rLfLdK5Tk9hbz91B+f9noP4WFjVTiSyaer5lc4mMqoXmg5fSUFSc3PUCu7+JaEey
	shpXxZb/WoEjZkpWzVuaQQ35rDi87Oi4qWx0UJTr02OCYNv5i/2FtAksViBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726406549; x=1726413749; bh=8IX9+V+TNfY/M7trh+uuRxUvH/7o
	XTV9uwRun+jVTiA=; b=GRgxYDyO2qnMYbcIf2EDky+iweOYbQXG5rpnDIKXiXVJ
	i4kLmaISkvZ0Tz1hOjhhwHPMeeX7625wydJDtUU1mgWftXR3rbDDJN8hgg9vLsuF
	h6h+BjvTkX8lwmapwURUw9G8G5nD4hvPwoFECCpew5k6OLWyJfz0KAL+8MskOzZA
	jBcUWj5R4VOWhBoPrknI6GA2tyL/moudhWaf6eIId0OrZIVpQTwaoyNd47lgxJNK
	d3BEhrO2/lleqbyFfQVrqpDFjIm00s1vRFog70AwHQW8Y5DZAjneF8tCEuer41N7
	zRzQjDte1dFiEVU67gRJ9W1ZNyPX1Rm5AE1CV3NlYQ==
X-ME-Sender: <xms:lN_mZttJMxFXRYUQgKc-luWDFMRFANogNKWKoSHLkjt0o-rpdkcJlA>
    <xme:lN_mZmdQC69-GjPXiFjXXcGJdo8MNJ_Ynydkv0uEP062rVg55BBcTaY2X-ev4fkEA
    WcLmTCMeol9tA>
X-ME-Received: <xmr:lN_mZgweYhpl6pa3sWQTXhlF4fkkyQiqUKlmkN4I1ryUDw5m1BdnV_SX_gTNYIwCDMNOdJESoZgsQ4RXZaJwwvr4XA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekfedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrf
    grthhtvghrnhepgeehueehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeel
    vedttddvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdp
    nhgspghrtghpthhtohepvdeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrvg
    esfieirhiirdhnvghtpdhrtghpthhtohepgihinhhghihurdifuhesshhtrghrfhhivhgv
    thgvtghhrdgtohhmpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepshhtrggslhgvqdgtohhmmhhithhssehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepshgrshhhrghlsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehkvghrnhgvlhesvghsmhhilhdrughkpdhrtghpthhtoheptghonhhorheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:lN_mZkP_uML5aISnelCD9hVhs4Z35scRS7YPWsD2woCiwLmRi1-Pog>
    <xmx:lN_mZt-lIsa_rYHfaXm-Su5lmn2yV0OpB0BVFaRxhpefsNr518GA6w>
    <xmx:lN_mZkWWQUoASZZEFpPkmM8XxJrelMyNwox37s9522zGVlR4EXH2kw>
    <xmx:lN_mZueKKFvFX8wqS0yBrkmrrozDuBQ6TERE-DRxJnGaavkhDZjjww>
    <xmx:ld_mZt9_G9G7sPbkqVFqMVeldhazAXGytl0XozzMnQGkeoHZxQTmevRA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 Sep 2024 09:22:27 -0400 (EDT)
Date: Sun, 15 Sep 2024 15:22:25 +0200
From: Greg KH <greg@kroah.com>
To: Ron Economos <re@w6rz.net>
Cc: Xingyu Wu <xingyu.wu@starfivetech.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"stable-commits@vger.kernel.org" <stable-commits@vger.kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Hal Feng <hal.feng@starfivetech.com>
Subject: Re: Patch "riscv: dts: starfive: jh7110-common: Fix lower rate of
 CPUfreq by setting PLL0 rate to 1.5GHz" has been added to the 6.10-stable
 tree
Message-ID: <2024091501-dreamland-driveway-e0c3@gregkh>
References: <20240913141134.2831322-1-sashal@kernel.org>
 <NTZPR01MB0956F268E07BAE72F3A133DE9F662@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <2024091451-partake-dyslexia-e238@gregkh>
 <NTZPR01MB0956BF9AAE1FCAAF71C810A69F662@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <2024091445-underwent-rearview-24be@gregkh>
 <NTZPR01MB0956C2EF430930E4DB2C35BE9F662@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <59b65d17-7dce-ef5d-41ba-2c04656fb2e8@w6rz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59b65d17-7dce-ef5d-41ba-2c04656fb2e8@w6rz.net>

On Sat, Sep 14, 2024 at 03:32:33AM -0700, Ron Economos wrote:
> On 9/14/24 3:04 AM, Xingyu Wu wrote:
> > On 14/09/2024 17:37, Greg KH wrote:
> > > On Sat, Sep 14, 2024 at 09:24:44AM +0000, Xingyu Wu wrote:
> > > > On 14/09/2024 16:51, Greg KH wrote:
> > > > > On Sat, Sep 14, 2024 at 08:01:44AM +0000, Xingyu Wu wrote:
> > > > > > On 13/09/2024 22:12, Sasha Levin wrote:
> > > > > > > This is a note to let you know that I've just added the patch
> > > > > > > titled
> > > > > > > 
> > > > > > >      riscv: dts: starfive: jh7110-common: Fix lower rate of
> > > > > > > CPUfreq by setting PLL0 rate to 1.5GHz
> > > > > > > 
> > > > > > > to the 6.10-stable tree which can be found at:
> > > > > > >      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-
> > > > > > > queue.git;a=summary
> > > > > > > 
> > > > > > > The filename of the patch is:
> > > > > > >       riscv-dts-starfive-jh7110-common-fix-lower-rate-of-c.patch
> > > > > > > and it can be found in the queue-6.10 subdirectory.
> > > > > > > 
> > > > > > > If you, or anyone else, feels it should not be added to the
> > > > > > > stable tree, please let <stable@vger.kernel.org> know about it.
> > > > > > > 
> > > > > > Hi Sasha,
> > > > > > 
> > > > > > This patch only has the part of DTS without the clock driver patch[1].
> > > > > > [1]:
> > > > > > https://lore.kernel.org/all/20240826080430.179788-2-xingyu.wu@star
> > > > > > five
> > > > > > tech.com/
> > > > > > 
> > > > > > I don't know your plan about this driver patch, or maybe I missed it.
> > > > > > But the DTS changes really needs the driver patch to work and you
> > > > > > should add
> > > > > the driver patch.
> > > > > 
> > > > > Then why does the commit say:
> > > > > 
> > > > > > >      Fixes: e2c510d6d630 ("riscv: dts: starfive: Add cpu scaling
> > > > > > > for
> > > > > > > JH7110 SoC")
> > > > > Is that line incorrect?
> > > > > 
> > > > No, this patch can also fix the problem.
> > > > In that patchset, the patch 2 depended on patch 1,  so I added the Fixes tag in
> > > both patches.
> > > 
> > > What is the commit id of the other change you are referring to here?
> > > 
> > This commit id is the bug I'm trying to fix. The Fixes tag need to add it.
> > 
> > Thanks,
> > Xingyu Wu
> > 
> I think Greg is looking for this:
> 
> commit 538d5477b25289ac5d46ca37b9e5b4d685cbe019
> 
> clk: starfive: jh7110-sys: Add notifier for PLL0 clock

That commit is already in the following releases:
	6.6.51 6.10.10
so what are we supposed to be doing here?

confused,

greg k-h

