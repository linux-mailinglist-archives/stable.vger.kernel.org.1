Return-Path: <stable+bounces-155295-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CF9AE35B8
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 08:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 107E316F4DD
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 06:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26261DF96F;
	Mon, 23 Jun 2025 06:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="E2gU2oxY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U37P0tUD"
X-Original-To: stable@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4326E184;
	Mon, 23 Jun 2025 06:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750660227; cv=none; b=Dg6GDdP5r2jreihoL9zC0Wh1icVIsUkT59FEXgQTrdrDjhO2PvYyLBL0kJCeN82iwZRC5gswM+AqIevzpoWbchpfw/wK6xmBHMyi12mzBro4sA7mj2rdpLdwCrAa8XBBLqVr/0jousuwE1xJIkke4rlgGysqd0M5cwznKmfb6eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750660227; c=relaxed/simple;
	bh=SRMe8CK6JM0ZIj4kHHMpEAD3KRdvvSxXxOxTfrCuYTI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAxxnlcaIzvixXDQ8DA9VBNkRw/Thbbjnn2+rzWfB9J6HRGsriSPBZTH5KGwTpy1JMdIof/z5UJK2i7BfN/kow6ldY+pdnM1fxu6rqURLbF1klsDczGVgrV32UYkTr60GI9AeQiOM58FT9Wvp8pD/JCCtPHU1XcJY1Qdif+qFk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=E2gU2oxY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U37P0tUD; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id F0769114013F;
	Mon, 23 Jun 2025 02:30:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 23 Jun 2025 02:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1750660223; x=1750746623; bh=jXMI8apfLB
	SadjxcnczIexFKVfL5KGNIjzbI2JHZohc=; b=E2gU2oxYOxGurvsnsB90R9AsY7
	i9+cSDEj7dCb+GrNF9b99b3f46ZVSE8MgU1/a3RHa7K2xP7BaXmfrSA5s31XMAWr
	2q85dbLVWHe7ByVJ4HYV8UKXYKCCTxNBoZe3DeGnX7hggjbmqea1UWWliQRtube+
	HeDJ2NYjpa1MW6s6qJFNzvrZdrHCZzt/SxHtC0S0/hMwZ3Km1bcC3WU+exQIN/cC
	wf3pl66cwlT6sl3EkeAifs+pvgaMvhF14E1shDL6pj0LL3neNyEGlivHBfxMG9uZ
	jN6TIfQExJWPr3u5mzTFyfjtADJ2VSxe2iFY8EeEDI39womuvoZnyClfgr7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750660223; x=1750746623; bh=jXMI8apfLBSadjxcnczIexFKVfL5KGNIjzb
	I2JHZohc=; b=U37P0tUD+YqsYxjChSS+303lvhswX7rwyBCUX4RMd4knc4EAAU6
	UB/vOHYImaIg/GL6n4ncZ6XZutxiS/vJxVxUsy4GEch1OtCd3AVz7NA91hIzWCJn
	kSya+kjlk6NaE+6FtuqGVqE0p0rgMS0LSA17kvDQirkWYXIhL7cZXkSPtoPgI8UA
	W2n521aTjlhw99lCleqGZwhNss6iVXkg6nEOl8Rn+IuGwOnr6mrqsofmi4lAWYY+
	zpdtlpM55tifEuHd7GZSIojpobePCNh51VnrAmjgtfY/FT617//XZXxmen39qBTa
	pjC4omY47sEt/RvrvoBsom7dHiO7WGQyJIQ==
X-ME-Sender: <xms:f_RYaJ5U8Ic6yEhZsJVpqT5mRiXz80P4jGPM9S7DWZDyOaC8Wudu3Q>
    <xme:f_RYaG4X-Bo_MR4Px0bHv5JlKZlQ9tPjhuP8HahJQZrqf21OHqgM9yfK9Dsc2NQZ5
    2VRdcUigqcDBQ>
X-ME-Received: <xmr:f_RYaAcmd1UbdC7tOYeoyYFMyMXXKXN4owXpogBIBgMJUk3DFnAM7ztgx25izbZQz7YKLMQAjRtuzAYRr3AYymHy2HjkEuEfVhcE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdduieefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpehgrhgvgheskhhr
    ohgrhhdrtghomhenucggtffrrghtthgvrhhnpeduvddvffevgfegleekgfdvvedtfeelue
    elhfefvdejvddtgfdvkeejtdetfeeiffenucffohhmrghinhepkhgvrhhnvghlrdhorhhg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvg
    hgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsth
    grsghlvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtrggslhgvqdgtohhmmhhithhssehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephigvsghinhdutdeshhhurgifvghi
    rdgtohhmpdhrtghpthhtoheptggrthgrlhhinhdrmhgrrhhinhgrshesrghrmhdrtghomh
X-ME-Proxy: <xmx:f_RYaCLnPNV3oX99oShD8JZvvSB6YuyzUqTWXBcop3M2fZNXiidB8w>
    <xmx:f_RYaNK5Mk5P5RvyyjO0rTwX2LTrvmeuq3PIzWAf1rO3CuSA-cjCYQ>
    <xmx:f_RYaLxmCsluthG2dWTZy8cE_FUe3844v-C5JvPSO5hIsKifPNdhEw>
    <xmx:f_RYaJI3qCGrkZEEcSP_IpKL3EWjWxbBKV6meG5vsMzKJPr2JeONMA>
    <xmx:f_RYaAAsIFg9iTPd7wn6N9TwfrtO3xrZPS_BEnzyiL2L0Ajhd8HxsS-i>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Jun 2025 02:30:22 -0400 (EDT)
From: greg@kroah.com
Date: Mon, 23 Jun 2025 08:30:20 +0200
To: Will Deacon <will@kernel.org>
Cc: stable <stable@kernel.org>, stable@vger.kernel.org,
	stable-commits@vger.kernel.org, yebin10@huawei.com,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: Patch "arm64/cpuinfo: only show one cpu's info in c_show()" has
 been added to the 6.15-stable tree
Message-ID: <2025062310-quartered-garland-eaf4@gregkh>
References: <20250620022800.2601874-1-sashal@kernel.org>
 <20250620101956.GB22514@willie-the-truck>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620101956.GB22514@willie-the-truck>

On Fri, Jun 20, 2025 at 11:19:56AM +0100, Will Deacon wrote:
> On Thu, Jun 19, 2025 at 10:28:00PM -0400, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     arm64/cpuinfo: only show one cpu's info in c_show()
> > 
> > to the 6.15-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      arm64-cpuinfo-only-show-one-cpu-s-info-in-c_show.patch
> > and it can be found in the queue-6.15 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> I don't think this one needs to be backported.

Now dropped from all queues, thanks.

greg k-h

