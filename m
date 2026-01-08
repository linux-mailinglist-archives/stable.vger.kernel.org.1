Return-Path: <stable+bounces-206283-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E13D03AFF
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 16:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C77F303BFC6
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AAB42FAF2;
	Thu,  8 Jan 2026 09:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="oq+y1IWr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GgJ70aCY"
X-Original-To: stable@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C37F42C3D3;
	Thu,  8 Jan 2026 09:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864025; cv=none; b=ByXD70KreQktCbS3XHSULoakiHqXk1fKU79gT5hidBGyPyzrs53SFdYowmJNqBLrd7B0+/I6LsOxThwKUXLnsaxnAzeYIO4avGU/vGNr+PokKEPr5rYPNQUxExK7kUeENhsMJMy9DlzCq4PyLhSdxjl880fT9MgD1QMtBli414s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864025; c=relaxed/simple;
	bh=wZzdYtS7KiNN5+TGD+1db0eieaMXxcMD9DyxW5UuWoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WaMAbtnn9MukOlI8N88ARs2T8KLshYLDjcfWXucge9dsg6yKtJGDLEGbVEwQEJW+DAA94AUOpaegB59Pw7X8Ux+ubuqK7jPUjP/TgQ+gd2aw1gb71tJsow89rMbxPFYxXca4sIL36ZrJDbWbK8uTiWxYieyGHm+gm9eyx7lisTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=oq+y1IWr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GgJ70aCY; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 6758AEC0189;
	Thu,  8 Jan 2026 04:20:15 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 08 Jan 2026 04:20:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767864015; x=1767950415; bh=YasOPDk6vB
	JZ88OYJ/YbAznmcG/l8KBkYRcJnDwW4jc=; b=oq+y1IWrH4k52qUngyOUVZ7c9B
	3/TPfFVv8gpQ0vcTGbPq+kn87ZxiGjTrlvuHyx6rHJGeUBwxDIAqd4yxxSsPH+Yl
	aT+//ykig22GFfAHOzyOJp7H8sGx1X+27DN6f5+irpQMCNZlLFfMhp6Vx8I6ZvLA
	mFNBlML/cb2JgmAQOjqsRrq9Mo/n7o/bJPQzRG6pssaw4L7ux51V+VPIca2pLhZB
	3/eUhkIfuoYiawlo74YWAelDJDj9w/1L+jCiuHXRpynLA2BIeoIOQG07vMxRL3TL
	e6nYD+hurGm5efHcu2Dl0Y+IMJLAxrZ7GNLvwlKzwnMvna7PMubLF6xjmaLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767864015; x=1767950415; bh=YasOPDk6vBJZ88OYJ/YbAznmcG/l8KBkYRc
	JnDwW4jc=; b=GgJ70aCYfcIXRWeawWpmk2cbMgvOk0h4JA6j49u4g1B0AeoR26v
	xG6TWFwxThb+bFWU/2BWlaKxpfVVgtX8/DUid12zzHiq2qSJhfywhWD4MNKLstuR
	aHJ5loQ/OKrVG/+BOvq8I8ffEMXFX0zWd7gdv0zS2xHe6K9gp36qNQwBwF6+eWQ5
	1u4alpv4j+uZx42igWIcPSdME25S32CjL1REzCIUXwqlLbb99d26bKwlpji+NHie
	eTiA4MtwvNyWuarR62wl5fTdSvuZiQDpR1RqPsR7FZCBUM8IIj9cZCCI5O9F0hGu
	g4IDyd4eShVUEHLGklabf24OtTYyOtASs1w==
X-ME-Sender: <xms:znZfaQKC_5Dby3iDtHdffX4qpmKklQf99n35Nus73sEgg3Kp18uZMg>
    <xme:znZfaYU34qPOJgqdmO9aXiqrULsdwd8NVsIxq71x7j-mAegxRYLJ2vEkRcIC-sTwt
    vNBx1n1EHhT9qA7SjqsHB6_bpThCNQNrDMECKxT__KuVbrGhw>
X-ME-Received: <xmr:znZfacTjSROnV_gMZBws532raLoyhvnug4XqhxY0wNJbGKtp_slJeXVBHvk9evr1RxJ09r0MFaxiPXh0XQa3_ievdky92ZRqu06Lnw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdehheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeehueehgf
    dtledutdelkeefgeejteegieekheefudeiffdvudeffeelvedttddvnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdpnhgspghrtghpthhtohepuddt
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehhrghlrdhfvghnghesshhtrghrfh
    hivhgvthgvtghhrdgtohhmpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepshhtrggslhgvqdgtohhmmhhithhssehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehvihhrvghshhdrkhhumhgrrheslhhinhgrrhhordhorhhg
X-ME-Proxy: <xmx:znZfaYCYQOwy9vQcoVlZ5nTHkf4KwPUvhCXXBIbGwPY48kWL3itc2Q>
    <xmx:znZfaTIy0i3bHN-9Qe5yE2xp85OU3iv0B3EzE_LAea10JSamfey6QQ>
    <xmx:znZfaTAelfSHtixjje_VUUbDXVJ3mSCQfH-ndiwR4v75Kcd9e2XmvA>
    <xmx:znZfaYsVqGB_CPKhNvb1uytxa3LeYaoGFRF6dAU1xaDfvtXQFPgL6g>
    <xmx:z3ZfaQiyqCPsNIrt_KkpP4APNMCjpQiEakSmrZHZeVuF1tdBcIgbINYU>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jan 2026 04:20:14 -0500 (EST)
Date: Thu, 8 Jan 2026 10:20:12 +0100
From: Greg KH <greg@kroah.com>
To: Hal Feng <hal.feng@starfivetech.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"stable-commits@vger.kernel.org" <stable-commits@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: Patch "cpufreq: dt-platdev: Add JH7110S SOC to the allowlist"
 has been added to the 6.18-stable tree
Message-ID: <2026010858-spoils-trimness-8d6f@gregkh>
References: <20251219123039.977903-1-sashal@kernel.org>
 <ZQ2PR01MB1307AE907F8899DA89F1085CE6B42@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
 <2025122908-skinning-mortuary-89c7@gregkh>
 <ZQ2PR01MB13070AEE145A353E886D7741E6B92@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQ2PR01MB13070AEE145A353E886D7741E6B92@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>

On Sun, Jan 04, 2026 at 06:25:56AM +0000, Hal Feng wrote:
> > On 29.12.25 23:36, Greg KH wrote:
> > On Mon, Dec 22, 2025 at 01:54:03AM +0000, Hal Feng wrote:
> > > > On 19.12.25 20:31, Sasha Levin wrote:
> > > > This is a note to let you know that I've just added the patch titled
> > > >
> > > >     cpufreq: dt-platdev: Add JH7110S SOC to the allowlist
> > > >
> > > > to the 6.18-stable tree which can be found at:
> > > >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-
> > > > queue.git;a=summary
> > > >
> > > > The filename of the patch is:
> > > >      cpufreq-dt-platdev-add-jh7110s-soc-to-the-allowlist.patch
> > > > and it can be found in the queue-6.18 subdirectory.
> > > >
> > > > If you, or anyone else, feels it should not be added to the stable
> > > > tree, please let <stable@vger.kernel.org> know about it.
> > >
> > > As series [1] is accepted, this patch will be not needed and will be reverted in
> > the mainline.
> > >
> > > [1]
> > > https://lore.kernel.org/all/20251212211934.135602-1-e@freeshell.de/
> > >
> > > So we should not add it to the stable tree. Thanks.
> > 
> > Why can't we take the commit that also landed in mainline for this too?
> > What is that git id?
> 
> Those commits are applied to the riscv-dt-for-next branch [1], but not landed in the mainline yet.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/log/?h=riscv-dt-for-next
> 
> The commit IDs in riscv-dt-for-next branch are
> d2091990c5c1
> 7c9a5fd6bb19
> 4297ddbf1d14

Great, when they hit Linus's tree, please let us know and we can queue
them up then.

thanks,

greg k-h

