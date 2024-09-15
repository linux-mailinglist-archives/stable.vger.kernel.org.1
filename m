Return-Path: <stable+bounces-76162-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 596C8979766
	for <lists+stable@lfdr.de>; Sun, 15 Sep 2024 17:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D70381F21769
	for <lists+stable@lfdr.de>; Sun, 15 Sep 2024 15:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51CA1C8FA0;
	Sun, 15 Sep 2024 15:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="HWN7Wf0E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J+uuVXGi"
X-Original-To: stable@vger.kernel.org
Received: from flow5-smtp.messagingengine.com (flow5-smtp.messagingengine.com [103.168.172.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCC01C578E;
	Sun, 15 Sep 2024 15:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726413027; cv=none; b=joxHDO4EWqLACQxu3VkqxIOF2wzlh4v+X3iKY5qFOzIWVbraHz1HClUdJx6meNm5HO1THi3u14yyB71RoO16CUUd5BnmS38e6jiCW1ET7mS5IOnPH1iQdzUxfRTr+SfgS9XrOluRECTapTY6M8JiqXDvI8mvV/LokPtL6oyD3jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726413027; c=relaxed/simple;
	bh=AzoRJb9I3c4xPzeb7gKDB7DHIG0KNQsv6fHptEN/QOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WaTD98txQFL4UqfKTXM8SOAISjJeYRxL6+GHFwzi+RPuFOD7t60Jjf0zfdw4CDDiE3Z4YZu8b+bYPMtybmFC522E5JFa/fhpavbi7ne9yxI1b2r0Dds2+ASQOhuobMwO9FviJYJXZy3jrPHUvJ8llRWObCwJTQCv4zG2ZwGh1Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=HWN7Wf0E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J+uuVXGi; arc=none smtp.client-ip=103.168.172.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailflow.phl.internal (Postfix) with ESMTP id 1429620029F;
	Sun, 15 Sep 2024 11:10:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Sun, 15 Sep 2024 11:10:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726413024; x=1726420224; bh=4pHIjvxwDz
	wZlDQBtGIMN5hoMAjEAo/eTiIQHImlS88=; b=HWN7Wf0EnYBViIOcF8aEiXRu8+
	pcQkpDw/KfbYO56tpU2Qpv2fmn0LQb7Pz34QMReJzHrZir0RwvJxVC6qyyECUYDt
	uW5BAOZ2rPvWPl0FDp5Ndo+ssJxFnY+RkWjrVlxeGrnvo8QvzABq9HPgBfD5xI/V
	xCLE1hsuO3C8WyoLVFEUAQaOgcg245tHhOlnD5pK19W3dcE5YF0tvzigB4e2IHkb
	4Xm/B7eJWeqdoV9MZbvb85quzpKRkqyqNSAiUiiQB6xJWE/B3mNPMLOjIBpttyHW
	ncwWwgDcM2p++3T1rGAkirRcRnX9xF7h11gNuFpAtzmeCmFqKefG1e/lAGXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726413024; x=1726420224; bh=4pHIjvxwDzwZlDQBtGIMN5hoMAjE
	Ao/eTiIQHImlS88=; b=J+uuVXGiw44vm3Rqr3g7G2zyRl5tE8HV43eKtLLkt0VC
	jPmwORDmDdHJg35U47P1T+fKC59n2WaIVDg9NJuy6YCVepxonE/aWBIlQO+Fub56
	WstsUhzbDw+uz+p1YUTOHnPM7aGzshdHLTm54x72MCPh2LfXzt9Hm9UZVa69UvlB
	r7Z/bDPQhqQgdTg71InEQTRnOMDEMcc+gqMz5qcDBsil+WxvthVi26NWzQ+yBq6j
	+c6r/OqRiroaZysqZxQvvrW356mnPNGUg7XjVNRppeSRTpAbb1stTB5qy0WMHlPB
	PJ0gDXmKritnzTqzFVw2b/xIHULhMMS74Q8CAZ11bg==
X-ME-Sender: <xms:3_jmZps-TZKr7ub3oVohE5eurI5yiSG23Mwzn1vCNRR85hILoPvESA>
    <xme:3_jmZicG_Rnwy0SG1SRo0mvCCV3I1_OA5ZT-Yhn1QmVKgkjF8NlMr9vQQiwO4Jf1h
    0-EnVGhApqLWw>
X-ME-Received: <xmr:3_jmZswAl9kQotf8ZHRYqKka7bzG1BsMh8ziMCgs-g33A71dC4gaLoOnrzz8Apsh7EeHvvazDsrTaLDBF46-5Aquyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekfedgkeehucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:3_jmZgML9jgq3ukepF1jwCtu6bkFou1sTTh3TlymI6YYqo2RdYP-pg>
    <xmx:3_jmZp8mr0tk4wNXWGQvtT6dmcUBLOFkMC0HSRT76UKZjndwmCdMZQ>
    <xmx:3_jmZgXowJOstwA3DFp17OhbcpYx4bmlty79xdnqKko50-hBMJzIkg>
    <xmx:3_jmZqfZ0OYPpwSQsxXxFap42bvsPEClUVYj1B90Ut8aqaeuWJoVWw>
    <xmx:4PjmZp8V21nxofSyUN3tukQtLGz0CYKQqpi0VMIKmzQDue7-DT2FC0uc>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 Sep 2024 11:10:22 -0400 (EDT)
Date: Sun, 15 Sep 2024 17:10:21 +0200
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
Message-ID: <2024091557-contents-mobster-f2c3@gregkh>
References: <20240913141134.2831322-1-sashal@kernel.org>
 <NTZPR01MB0956F268E07BAE72F3A133DE9F662@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <2024091451-partake-dyslexia-e238@gregkh>
 <NTZPR01MB0956BF9AAE1FCAAF71C810A69F662@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <2024091445-underwent-rearview-24be@gregkh>
 <NTZPR01MB0956C2EF430930E4DB2C35BE9F662@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <59b65d17-7dce-ef5d-41ba-2c04656fb2e8@w6rz.net>
 <2024091501-dreamland-driveway-e0c3@gregkh>
 <148a908f-e2e2-6001-510e-73aef81d07b5@w6rz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <148a908f-e2e2-6001-510e-73aef81d07b5@w6rz.net>

On Sun, Sep 15, 2024 at 08:01:33AM -0700, Ron Economos wrote:
> On 9/15/24 6:22 AM, Greg KH wrote:
> > On Sat, Sep 14, 2024 at 03:32:33AM -0700, Ron Economos wrote:
> > > On 9/14/24 3:04 AM, Xingyu Wu wrote:
> > > > On 14/09/2024 17:37, Greg KH wrote:
> > > > > On Sat, Sep 14, 2024 at 09:24:44AM +0000, Xingyu Wu wrote:
> > > > > > On 14/09/2024 16:51, Greg KH wrote:
> > > > > > > On Sat, Sep 14, 2024 at 08:01:44AM +0000, Xingyu Wu wrote:
> > > > > > > > On 13/09/2024 22:12, Sasha Levin wrote:
> > > > > > > > > This is a note to let you know that I've just added the patch
> > > > > > > > > titled
> > > > > > > > > 
> > > > > > > > >       riscv: dts: starfive: jh7110-common: Fix lower rate of
> > > > > > > > > CPUfreq by setting PLL0 rate to 1.5GHz
> > > > > > > > > 
> > > > > > > > > to the 6.10-stable tree which can be found at:
> > > > > > > > >       http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-
> > > > > > > > > queue.git;a=summary
> > > > > > > > > 
> > > > > > > > > The filename of the patch is:
> > > > > > > > >        riscv-dts-starfive-jh7110-common-fix-lower-rate-of-c.patch
> > > > > > > > > and it can be found in the queue-6.10 subdirectory.
> > > > > > > > > 
> > > > > > > > > If you, or anyone else, feels it should not be added to the
> > > > > > > > > stable tree, please let <stable@vger.kernel.org> know about it.
> > > > > > > > > 
> > > > > > > > Hi Sasha,
> > > > > > > > 
> > > > > > > > This patch only has the part of DTS without the clock driver patch[1].
> > > > > > > > [1]:
> > > > > > > > https://lore.kernel.org/all/20240826080430.179788-2-xingyu.wu@star
> > > > > > > > five
> > > > > > > > tech.com/
> > > > > > > > 
> > > > > > > > I don't know your plan about this driver patch, or maybe I missed it.
> > > > > > > > But the DTS changes really needs the driver patch to work and you
> > > > > > > > should add
> > > > > > > the driver patch.
> > > > > > > 
> > > > > > > Then why does the commit say:
> > > > > > > 
> > > > > > > > >       Fixes: e2c510d6d630 ("riscv: dts: starfive: Add cpu scaling
> > > > > > > > > for
> > > > > > > > > JH7110 SoC")
> > > > > > > Is that line incorrect?
> > > > > > > 
> > > > > > No, this patch can also fix the problem.
> > > > > > In that patchset, the patch 2 depended on patch 1,  so I added the Fixes tag in
> > > > > both patches.
> > > > > 
> > > > > What is the commit id of the other change you are referring to here?
> > > > > 
> > > > This commit id is the bug I'm trying to fix. The Fixes tag need to add it.
> > > > 
> > > > Thanks,
> > > > Xingyu Wu
> > > > 
> > > I think Greg is looking for this:
> > > 
> > > commit 538d5477b25289ac5d46ca37b9e5b4d685cbe019
> > > 
> > > clk: starfive: jh7110-sys: Add notifier for PLL0 clock
> > That commit is already in the following releases:
> > 	6.6.51 6.10.10
> > so what are we supposed to be doing here?
> > 
> > confused,
> > 
> > greg k-h
> > 
> Sorry, I didn't check to see if it was already in releases. So the 6.10
> queue is fine as is.
> 
> However, these two patches go together, so the 6.6 queue should also have
> 61f2e8a3a94175dbbaad6a54f381b2a505324610 "riscv: dts: starfive:
> jh7110-common: Fix lower rate of CPUfreq by setting PLL0 rate to 1.5GHz"
> added to it.

Given that the file arch/riscv/boot/dts/starfive/jh7110-common.dtsi is
not in the 6.6.y kernel tree, are you sure about this?  If so, where
should it be applied to instead?

thanks,

greg k-h

