Return-Path: <stable+bounces-145038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26919ABD254
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 10:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 276EE7A9162
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 08:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88E62609DF;
	Tue, 20 May 2025 08:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="ABbbvEcI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AsrpVBcB"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6CD1DA61B;
	Tue, 20 May 2025 08:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747731094; cv=none; b=dwsSh5dO+6BYRVsrESawpaL6nsvTUY/uWTGTGecFySbR12o65NHP8hr9Ovs14SG1Pttid40LXTh/TVL4YXfITTlpg+tw6figyfSNaO3bjZNmLFHj3LkSh6oQGgv/GSZoIgVc1tcHAetO4XH898gm1kwnAbUNIJu9VryuYhKb7FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747731094; c=relaxed/simple;
	bh=Ptpv8lFgfw6y2ANTyU2kUpAV6CH0cMtc0HgM31NmHOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkyXzE/J3Dis1SVdjaXl5e0FNUxJf+qgEZrgfBozgovMivGBnAFEJCMw9dwL8wHJo/DsOABgsoOzXiyIi10suZxknYzRAhf/7qW4KfrGyK/SThlp7djA1qxAuSZo+J8xw07Ai+S57kIi/Wp8tKGBmfS8+O/c91jQslkSIeapKB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=ABbbvEcI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AsrpVBcB; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9799111400E8;
	Tue, 20 May 2025 04:51:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 20 May 2025 04:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747731090; x=1747817490; bh=uZYCYUDzU/
	1fERtCPeyUwRLSCDgFXGdZSY5+nBi25Tc=; b=ABbbvEcI3LorwxAue4McwmTKH3
	a1pgaC23Nbijn9PV5xijao9k1KZgmnlWE/b2vQ4ZrUzy2F3Eb1N7FyT9uYhxr0mU
	TaN+JoH8F56DgnD/oKQjxU1wa4mJR5GcanDXOhMqhXPKzG1IB9BCgt0g8Je56q7T
	2d8rsgKB+qArqYaYjkjTiNsCTDqktCtu6EH5iyssFOrkolEoguja1JPiv27ArU9y
	36eB6/yEkKZw9UtcXNh7rMQmIRxXsOFEJmfpg2jvI8G/J2GhOiaXJ83i33PGaOYI
	W4WuPtXqzE4War5IQrhif9lGYm3jiC7VAEllUIUmOVHmlnbJwo/htMM8GMpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747731090; x=1747817490; bh=uZYCYUDzU/1fERtCPeyUwRLSCDgFXGdZSY5
	+nBi25Tc=; b=AsrpVBcB0ybFKwm5RHbuZgEWKlPImz0YNa6LVjcH8fvLrMIn+Zk
	/IIv2GESD5+G1a1Kin6yQC91Zc81fWinwiVm4F/qgn5EFCElv3iat7QaVO3qB4tY
	/uNg2ndZdyTQpsOyyjSYdFbzMZsvsqSrTtlPPlqzS4ax5kOUIMvut2PStjG47/uB
	qro15vru8W0O2GNZi/2ufajSTC6fgoVoY+KFcfivVj7H1UwRLMcA5/hRN9JfCN+0
	rEVt5E5mjjWL66LgY+N5/s0wGg7OFMulJUWoCsWQU5RW++s7kvFHIulrknyi11bf
	qvdg8FcUgiiFiq3fUBbCBBnb1tNXYXWgIKA==
X-ME-Sender: <xms:kUIsaPSn-EnpO1DGtrTFMiI7yAOnbREaYhjMZ6pv3gmI2i2jYff64A>
    <xme:kUIsaAzXqpr_d6-u5vgSZjwPRGE8ubf5UDcwmvgFWm8NxR-MWMtiHUFE0z4npv82l
    N-ouKzhkzuekA>
X-ME-Received: <xmr:kUIsaE2wYva6sTfuZ_0KBdX35ACGyLz0XYKOUzVuPWncl7g0tqct6gADv6XAgJzk0vUOlVAnOSWum98wZvyg-3ZpK8b3weU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvdefkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecugg
    ftrfgrthhtvghrnhepgeehueehgfdtledutdelkeefgeejteegieekheefudeiffdvudef
    feelvedttddvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtgho
    mhdpnhgspghrtghpthhtohepfedtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    grrhhighhhihesnhhvihguihgrrdgtohhmpdhrtghpthhtohepshhtrggslhgvsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtrggslhgvqdgtohhmmhhithhsse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhjsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehvohhiugesmhgrnhhifhgruhhlthdrtghomhdprhgtphhtthhope
    gthhgrnhhgfihoohesihhgrghlihgrrdgtohhmpdhrtghpthhtohepmhhinhhgohesrhgv
    ughhrghtrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorh
    hgpdhrtghpthhtohepjhhurhhirdhlvghllhhisehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:kUIsaPCqSSQXUM6Wor6XlKnnIRDV6vvnbAdwODnBHqKs6p663bD2xA>
    <xmx:kUIsaIgsdZSfDflWxk0uzWobUAwMktESheT2st1QyAt6OwQmtRRV8A>
    <xmx:kUIsaDrCLPptAEJ-82GqpPEx6rMxY6sESQVoYB-UPSJba9K2n54Vqg>
    <xmx:kUIsaDhgpIeCGB0qCoXh9fbIQ2Invo4p_BxcS2gwqFSXNpuZOQWY_A>
    <xmx:kkIsaFTDs4nS9BsJBbpf2WZW-VdeJFRALRdxlb6T_UDJUDHCXmU0gk95>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 May 2025 04:51:28 -0400 (EDT)
Date: Tue, 20 May 2025 10:51:27 +0200
From: Greg KH <greg@kroah.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: Patch "sched_ext: Fix missing rq lock in scx_bpf_cpuperf_set()"
 has been added to the 6.14-stable tree
Message-ID: <2025052016-breeching-chastity-7935@gregkh>
References: <20250518103528.1830160-1-sashal@kernel.org>
 <aCn2soZgtO3kWAyX@gpd3>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCn2soZgtO3kWAyX@gpd3>

On Sun, May 18, 2025 at 05:03:14PM +0200, Andrea Righi wrote:
> Hi,
> 
> On Sun, May 18, 2025 at 06:35:28AM -0400, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     sched_ext: Fix missing rq lock in scx_bpf_cpuperf_set()
> > 
> > to the 6.14-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      sched_ext-fix-missing-rq-lock-in-scx_bpf_cpuperf_set.patch
> > and it can be found in the queue-6.14 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> This requires upstream commit 18853ba782bef ("sched_ext: Track currently
> locked rq").

Thanks, I've dropped this from both queues now.

greg k-h

