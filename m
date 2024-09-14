Return-Path: <stable+bounces-76138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2345978F8B
	for <lists+stable@lfdr.de>; Sat, 14 Sep 2024 11:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2BFC2856FE
	for <lists+stable@lfdr.de>; Sat, 14 Sep 2024 09:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9160B1CDFCB;
	Sat, 14 Sep 2024 09:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="mJ3yz60d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uMY9LFg0"
X-Original-To: stable@vger.kernel.org
Received: from flow1-smtp.messagingengine.com (flow1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF0A1448C5;
	Sat, 14 Sep 2024 09:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726306633; cv=none; b=fsH9rQg0fXLiC+5YO8mJJx+INHgthAiKnVlIgQvvnGVWeD5kiwztRUs8Ud3ZG0pM9YEx1VrIe1xGPlXaxCKn1p4otkBFTxZBXPz5LWwbi3CjUHykcz0tgkw5+ZvPzUqypXkGSO84vl4QxVi64JipYs6q1IlASWI8/gCi3giHsZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726306633; c=relaxed/simple;
	bh=Qf5B2biFef18wGe3+8byGLpVH1oi8Iq23Ri/boPqQm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LdCoHmlPsICCbVFvjBkFt/tUn7AYKD0bdkBiq9RlaklUhFYs7Wx6DnxzqB8vkoXhLb8tvzGTaU1/lWkKyIELcZlj7iH/Y+zJ0IkyEMhqODG/7ELp4b1+dDog4YiKJay9wQxhGo2sCX9sGeiC84Ilgr39vpNB3sr2Si7r9lHmEIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=mJ3yz60d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uMY9LFg0; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailflow.phl.internal (Postfix) with ESMTP id 9EF822000D2;
	Sat, 14 Sep 2024 05:37:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sat, 14 Sep 2024 05:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726306630; x=1726313830; bh=R2iKIRm1ZK
	weoiIyW9ZhG4ZGpNpIeSCKa4FSjdSTQ6g=; b=mJ3yz60dg/72nv96xzceZGWVGA
	6Lu5/hDwzQTUIspSVz+ykvFzN+R/9jRPnWI2FDCvHMkj6ffK+8nQhiHcb69ojfWX
	HLyrkJ/IVNvXaVgYElrbfqtsH3PMhXNIBbt8chkpglGmQkPyX1dc9WmHPqdavWA0
	Y6bL/6Q6CcH1pf+VxeMgQd4d20l1AqI4RKqyJBcKHaW8QG6ze0JbQQLLNps2hATS
	tv1qnUxvXi7pIOUuRQR+0pJEByn8sPOnMsdFCCLc/evc2k2VUd0iOWYndzRIKAvs
	ZWGAd0HsEZ/7gBk59sz49C+9eqPyQJHzvhTWfRODXB0P4hR23mYQ7/7eG++g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726306630; x=1726313830; bh=R2iKIRm1ZKweoiIyW9ZhG4ZGpNpI
	eSCKa4FSjdSTQ6g=; b=uMY9LFg0P5bEWUkwCmvMeNDNhk3uosxsA/mUW3z6vzpz
	/qXdHwRIO+o404+05zJ+/hrXKKntZsqHTO0bKllXd4aPPiycPD4pOW24gXsJE5Qk
	r0hRPdH5ON3A1lMsOKHtIt95SLIIjAczPTmYU2qm5Mjr3epX4b4D1Cii5ou86ycT
	nS+zSBOd7SDfmw+64HAvAcGw5JLuUsU/qHVZl93VHT4ntICnHFjpwFwqTBlacDD6
	l1tMpC0JxvGxpnDwTQRXOhgavtHIgVJ7EU775Jf99Cb4Ke56USOgsdi8nBGa6tQ+
	uqddsF5W9YrFrpYiHyKSM4TxsS02X1kynfKl9tM1tg==
X-ME-Sender: <xms:RlnlZvZJQzNJKkghfWOmCQ7sjAg6pubF-G8HFuvUml-b5Dd1--fb_w>
    <xme:RlnlZuad1xLghEouwD1CN1dXX7svz3l1SKETxS32g3BYjdPDkv5iiWZ-8LJZ_Tn5V
    umA4a6GIF9G_Q>
X-ME-Received: <xmr:RlnlZh83E7kyHcdelcHWRkxkhvFJzzsKChMrVG4mk3lrycx1IZFyvwH4TgUu4KeDDXieAMoGOayKuqF4rDgFaXVMBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudektddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrf
    grthhtvghrnhepgeehueehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeel
    vedttddvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdp
    nhgspghrtghpthhtohepvdegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeigih
    hnghihuhdrfihusehsthgrrhhfihhvvghtvggthhdrtghomhdprhgtphhtthhopehsthgr
    sghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgrsghlvgdqtg
    homhhmihhtshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghshhgr
    lheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlsegvshhmihhlrdgukh
    dprhgtphhtthhopegtohhnohhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgs
    hheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepphgruhhlrdifrghlmhhslhgvhiesshhifhhivhgvrdgtohhm
X-ME-Proxy: <xmx:RlnlZlq-KwhwoobvHzNNWrztl_wNA-1ShLkO6_JIOo7_-ecSH3G-mQ>
    <xmx:RlnlZqqs4IoOdN2NhKWx8EE7vArqJh6unx-FrWQcXAj4mlVqEtIcyg>
    <xmx:RlnlZrTcaBZz7CrJw9A8nqGu8bqb_MX09ic-Tyw9jOgPFhVDD7la6A>
    <xmx:RlnlZipCfcFk-3GCO7hBSpRrkXodaybSbBbDUY6kq9wj4LvzWwdxdg>
    <xmx:RlnlZiCPKgzkraYogePkX8HCtBXW9fr-P-SFbWrwdroXDvdWoSnN8ohX>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Sep 2024 05:37:09 -0400 (EDT)
Date: Sat, 14 Sep 2024 11:37:06 +0200
From: Greg KH <greg@kroah.com>
To: Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
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
Message-ID: <2024091445-underwent-rearview-24be@gregkh>
References: <20240913141134.2831322-1-sashal@kernel.org>
 <NTZPR01MB0956F268E07BAE72F3A133DE9F662@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <2024091451-partake-dyslexia-e238@gregkh>
 <NTZPR01MB0956BF9AAE1FCAAF71C810A69F662@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <NTZPR01MB0956BF9AAE1FCAAF71C810A69F662@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>

On Sat, Sep 14, 2024 at 09:24:44AM +0000, Xingyu Wu wrote:
> On 14/09/2024 16:51, Greg KH wrote:
> > 
> > On Sat, Sep 14, 2024 at 08:01:44AM +0000, Xingyu Wu wrote:
> > > On 13/09/2024 22:12, Sasha Levin wrote:
> > > >
> > > > This is a note to let you know that I've just added the patch titled
> > > >
> > > >     riscv: dts: starfive: jh7110-common: Fix lower rate of CPUfreq
> > > > by setting PLL0 rate to 1.5GHz
> > > >
> > > > to the 6.10-stable tree which can be found at:
> > > >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-
> > > > queue.git;a=summary
> > > >
> > > > The filename of the patch is:
> > > >      riscv-dts-starfive-jh7110-common-fix-lower-rate-of-c.patch
> > > > and it can be found in the queue-6.10 subdirectory.
> > > >
> > > > If you, or anyone else, feels it should not be added to the stable
> > > > tree, please let <stable@vger.kernel.org> know about it.
> > > >
> > >
> > > Hi Sasha,
> > >
> > > This patch only has the part of DTS without the clock driver patch[1].
> > > [1]:
> > > https://lore.kernel.org/all/20240826080430.179788-2-xingyu.wu@starfive
> > > tech.com/
> > >
> > > I don't know your plan about this driver patch, or maybe I missed it.
> > > But the DTS changes really needs the driver patch to work and you should add
> > the driver patch.
> > 
> > Then why does the commit say:
> > 
> > > >     Fixes: e2c510d6d630 ("riscv: dts: starfive: Add cpu scaling for
> > > > JH7110 SoC")
> > 
> > Is that line incorrect?
> > 
> 
> No, this patch can also fix the problem.
> In that patchset, the patch 2 depended on patch 1,  so I added the Fixes tag in both patches.

What is the commit id of the other change you are referring to here?

thanks,

greg k-h

