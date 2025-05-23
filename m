Return-Path: <stable+bounces-146159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DF4AC1BAA
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 06:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 042F2500E9D
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 04:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428E32236F2;
	Fri, 23 May 2025 04:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="EfiZDZwK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OmLZFlZm"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955382248BE;
	Fri, 23 May 2025 04:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747975955; cv=none; b=RAlJdNN+z6BWduIi4LIq+ooaZ5nOpJI6dyHaBDJ7Z9LWgnGZyFAqjtSSGlC+h43ZkBi0FnH2thi4qAIavKTeyoDwHNj13zmatcpaysOCJgZ8W93H1S8dgY/HSmOaPvZIl0m+I+v2PYVkD5bt06w+IhpzVa+jWu5Gs5Oi2HO0TuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747975955; c=relaxed/simple;
	bh=ZteS8kRhMdAwufpGY+Iwq0uzOEYrQzTuwlqR/INtplM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UrcKYEwsBh/EyILFKxsdcVEPk3leOosyaXpkngNvCT2kljvm3HWGjb077cu6pLvyNnSw5BQ3/7uhuscVg+n2A9A0fZi698EdOsPp3MtUbYEVZIgT5CgtYySQc9sHMLaEPYY2UAoReimPHHlFHUihg5K3T9139cm4uU3qFNhaUNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=EfiZDZwK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OmLZFlZm; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0F0B92540118;
	Fri, 23 May 2025 00:52:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 23 May 2025 00:52:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747975950;
	 x=1748062350; bh=0ClJm+/YNEDEgXWEHcjEhQmkdi9HLEXaXq1Oo4O9Dgc=; b=
	EfiZDZwKeH4PWxQExvCctmMsvOQZ3XgBsUzHUrzXpF5rJNY7oU4EkzAHWZ8MWdvg
	c/vcGHxHarhosb0WPIkv4DFqoSkfD4ivuMXwFEGDaSN062cj1FEhzH1Jm+a2kffJ
	wW8917JTMvcjSwyQc9X8Ykt5ZFf86KFnjRY8NfIfh/ipBTJIQ7ZVXnj+qBA1OjlN
	PcJ016hU64DHQNyEIgcVUaBm5RcL50izb5pUKuC2dNO5vS+DPxRaehjcMvaOk9Ei
	ChUvZoDMPX07zHrEyaMd/zGEKiLTHcK8cJ+qUs6lC0KcJ2teM6qQNCyTGXulgV4F
	zl8W8xgSpIL4MLfrV0M4NQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747975950; x=
	1748062350; bh=0ClJm+/YNEDEgXWEHcjEhQmkdi9HLEXaXq1Oo4O9Dgc=; b=O
	mLZFlZmAfH4gANVWkrJ4Z3kStcNp7FEV16laI38jCJwV0fZ1GAVyS4UJCDwJ8Dg6
	K/HVDzh+pcbNqlHm6wCDiXCKILvO5+13yEE5XGLTSypA0vnycQ6iQ59GMmC7QFJK
	suU5bdKoLjmMZwMKbbm1SqGdi/TSKNjNvsNh4VlfOoE/c5FygzYD4LyWh6Mq+5sw
	cKM3boNQWO/t9vAwmeGImoAgzU4TnVFm0KgGq2824sS7yPmsATeQjbLjZ1Yh5Y2i
	4XN8Dw+T6qCHIaJQE3iPwlRPiC/eSVApC6cvvhOJdyXwgN7tS5UseCNottZykSfw
	cVqJo6hbcUpeg1kcFcl5w==
X-ME-Sender: <xms:Dv8vaGKi9Z8zGOZGfqIii1YfplHsJcS2eMcSZ_Ef5fRGEvQMijnSHA>
    <xme:Dv8vaOJLyMFS1Ru0SGuJPiOOPBuBVjG5NnkAluXhTWlCNiPmqD_VBqGUmRx5fQ8Wf
    ODWL3JZoMSMyQ>
X-ME-Received: <xmr:Dv8vaGuzLV4LkFH37g3v3uLU0ziG-UMAGMH9NZ2aK-PVPbi-Vws4vvKYmH8Qhf-kFEQ7gkqlBwCsZ2jVeBhR6v-ExHW0Y-U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdejledvucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhgg
    tggugfgjsehtkeertddttdejnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrh
    horghhrdgtohhmqeenucggtffrrghtthgvrhhnpeelkeehjeejieehjedvteehjeevkedu
    geeuiefgfedufefgfffhfeetueeikedufeenucffohhmrghinhepkhgvrhhnvghlrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhr
    vghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepfihquhesshhushgvrdgtohhmpdhrtghpthhtohepshhtrggs
    lhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtrggslhgvqdgtoh
    hmmhhithhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghlmhesfhgs
    rdgtohhmpdhrtghpthhtohepjhhoshgvfhesthhogihitghprghnuggrrdgtohhmpdhrtg
    hpthhtohepughsthgvrhgsrgesshhushgvrdgtohhm
X-ME-Proxy: <xmx:Dv8vaLbyLp4qqGZ-ilZrYjDZ_3HalOU9Pevja46ErNfzqPIk2BGJtQ>
    <xmx:Dv8vaNafGFgnf3zJjGE7WeJ3siv9kdGr4laNpksXeHfzEKfwunnZmw>
    <xmx:Dv8vaHDuRBBNkJEvfnOX-ixmraiPoUMElCxmF0h_LZzzH7DXaclkIg>
    <xmx:Dv8vaDa3bz1Zltf0ssNHqq9vGs3FARL7f03TVsH32LWdM4uGGQAQOQ>
    <xmx:Dv8vaL8MbgAjit0a5TIGVXZg-409RCVEH9voWgTbjNfMQ45T2U327yAd>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 May 2025 00:52:30 -0400 (EDT)
Date: Fri, 23 May 2025 06:52:28 +0200
From: Greg KH <greg@kroah.com>
To: Qu Wenruo <wqu@suse.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Subject: Re: Patch "btrfs: allow buffered write to avoid full page read if
 it's block aligned" has been added to the 6.14-stable tree
Message-ID: <2025052321-prepay-defog-2986@gregkh>
References: <20250522210549.3118269-1-sashal@kernel.org>
 <6377b61b-c16e-4d10-becc-53ac4af72725@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6377b61b-c16e-4d10-becc-53ac4af72725@suse.com>

On Fri, May 23, 2025 at 06:51:18AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/5/23 06:35, Sasha Levin 写道:
> > This is a note to let you know that I've just added the patch titled
> > 
> >      btrfs: allow buffered write to avoid full page read if it's block aligned
> > 
> > to the 6.14-stable tree which can be found at:
> >      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >       btrfs-allow-buffered-write-to-avoid-full-page-read-i.patch
> > and it can be found in the queue-6.14 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> Please drop this patch from all stable branches.
> 
> Although this patch mentions a failure in fstests, it acts more like an
> optimization for btrfs.
> 
> Furthermore it relies quite some patches that may not be in stable kernels.
> 
> Without all the dependency, this can lead to data corruption.
> 
> Please drop this one from all stable kernels.

Now dropped, thanks.

greg k-h

