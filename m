Return-Path: <stable+bounces-121667-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BDBA58D7E
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 09:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2897B164DC2
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 08:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDD1221F37;
	Mon, 10 Mar 2025 08:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="rkXbZsPW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ARDupAQp"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1975215F76;
	Mon, 10 Mar 2025 08:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741593673; cv=none; b=ebm2ZqrWYUwWIcqWWaTaVqDO4Qry4HObf3KGedGbXwxAHaszzzFaflDudH4pyx6qWymMZLJcrik8dnO8L2zc/uJmJ/GwARJ+en2jmdMyybRVlBnTxP9J4DVP+QZ7a0ZN80zBI4DrsNguAAJ5lq+2DvhV9F0AHZd4JNt5tusvCnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741593673; c=relaxed/simple;
	bh=uzu2zPnx18GsAtkAlqoE5750Hm8jxpUihyCgbZ9mNSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5bZr3EgEvRGsFHR7M6ZwfKKJBC6BCl4224qGmBU2qGTtUlKvW6UFOIiAxwYLMf3wffy9vVwWYmFArXaGG2bBbllqDCqkVZPdtGcn2dVh6fP/BVQtK+mkhCR68vHhGYvK/e++kL6NLzGA2JoNIgOYs/KOmTuvZP6J1E4e7pCsYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=rkXbZsPW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ARDupAQp; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A99CE254014C;
	Mon, 10 Mar 2025 04:01:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 10 Mar 2025 04:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741593667; x=1741680067; bh=Vlk1i88H5d
	NBj9iBB3fmrWC5ZhgsWyEe7GBoEvn2KXI=; b=rkXbZsPWWo4So1ZBX5BFn/YuI3
	dgVVteedxY1agter1d4uEpmSQokvh8Dc4yvDrUAdWH0xZAtgiNGmmLIaN4GXTFSU
	DQQMNGGSsq3Jr+b+U1Q5BvHrh/4hcvDUFIGwp4aqYLXV+SL+dlP/wAjG2oD6k+BG
	Bwn3t9wp7ZIVMZkgN1caYmHkEftNkxPlme2jI0jNtGf2EZWczdlDptf0lixmtG8z
	jE5WG+MkqzGFg+1QzzMl6CbzOnoDy6jdLNyrZ0Kx0EIqT/tCRtxCxDUtjGV9p0Hz
	ipy0o2Ely3XJ5EM3f4P4RKLO9e18q5ijF/5Uly72zMAYEDLTNaOvmHXa1sPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741593667; x=1741680067; bh=Vlk1i88H5dNBj9iBB3fmrWC5ZhgsWyEe7GB
	oEvn2KXI=; b=ARDupAQpzxiPYlOJmAkeWDE3f8Vv6t8rMncgJvOr9Ta4injKK/C
	BywE3KbBVcyU843mt6DlkF9Q3H2v3BfF7RIO+EhAcyR7rD4qLueb9Qf7lmBaeBeI
	73sd5GMyPcU1AP8ABmKj1p+kTTiJPDiFvFgWtteYZ36poAbrxvh8JlQyakrOnNZZ
	Iz1MH5FnOkubE21PtQqgzwOtYHWLcLT7X6MtKPyjUnRw+YT613syM5qIBsKxrR8Y
	ljLor2rYTrUhJ/7YqiXIahkC+pS5XQz7GCC/SGnkOBWMjLeNdeERbbMeKNgvmss3
	0pbXT57nvYakj5IsvEo9j/WlZDQFyQxc31Q==
X-ME-Sender: <xms:QpzOZwYPNuE38lT2kQcAj2NVv2GKQGxucnpVtav31YP8Hs9P5rbqjA>
    <xme:QpzOZ7blAcsjOXz2JND7FNJtBRct8iINTljXWlDIS3r3Prl1mNTyrZRXSplOV-_t0
    E5yC6M_qiZ8lQ>
X-ME-Received: <xmr:QpzOZ6-qWLMsU8DU4YXUCls5tFHV9uSpnO5iXSjLOT-JCDSI0Sueb4iU0grbBvBvH_PpTkzD9eibbb1lbIRVMk_i_W0Y1A1vEwvzXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudekkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecugg
    ftrfgrthhtvghrnhepheegvdevvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeu
    fefhgfehkeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehtohhrvhgrlhgusheslhhinhhugidqfhhouhhnug
    grthhiohhnrdhorhhgpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepshhtrggslhgvqdgtohhmmhhithhssehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhg
    rdhukh
X-ME-Proxy: <xmx:QpzOZ6pSUWbPOouMB12XFmaEPivHFsCLcWwD9jYpaoXj28PNv4YoVQ>
    <xmx:QpzOZ7qy4H3Xj0i-DCuFHlo5qnpnKHcsgHs5crUgA-SWavVTtnSDtA>
    <xmx:QpzOZ4TRnQluvs1gh-U1u26EJFzMiNQcbQwjM3nSlF4WkI3M2sqizQ>
    <xmx:QpzOZ7pevPIGdT8BhSvQThDi8rpThWELalQKMNySJDKzvx5X6141nw>
    <xmx:Q5zOZ_ec02k3G6mWuSE9CdAX2SgXWckwtymkIiaQiELkFQWac-JYZ1vO>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 04:01:05 -0400 (EDT)
Date: Mon, 10 Mar 2025 09:00:59 +0100
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: Patch "fs/pipe: Read pipe->{head,tail} atomically outside
 pipe->mutex" has been added to the 5.10-stable tree
Message-ID: <2025031039-arbitrate-manned-f66a@gregkh>
References: <20250309195202.4675-1-sashal@kernel.org>
 <CAHk-=wgsHsVjOnETsRtY8ELEi1G1_0uLMYq2Fv9auhRfR5uJvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgsHsVjOnETsRtY8ELEi1G1_0uLMYq2Fv9auhRfR5uJvg@mail.gmail.com>

On Sun, Mar 09, 2025 at 10:05:24AM -1000, Linus Torvalds wrote:
> Note that this was a real fix, but the fix only matters if commit
> aaec5a95d596 ("pipe_read: don't wake up the writer if the pipe is
> still full") is in the tree.
> 
> Now, the bug was pre-existing, and *maybe* it could be hit without
> that commit aaec5a95d596, but nobody has ever reported it, so it's
> very very unlikely.
> 
> Also, this fix then had some fall-out, and while I think you've queued
> all the fallout fixes too, I think it might be a good idea to wait for
> more reports from the development tree before considering these for
> stable.
> 
> Put another way: this fix caused some pain. It might not be worth
> back-porting to stable at all, and if it is, it might be worth waiting
> to see that there's no other fallout.

Thanks for letting us know, I've dropped these and the other "fixups"
for the pipe patch from all stable queues now.

greg k-h

