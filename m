Return-Path: <stable+bounces-200546-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 070D9CB22F2
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 08:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0D2430076B0
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 07:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604352F3C3E;
	Wed, 10 Dec 2025 07:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="qpJAzXI3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uRMFTElf"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E111DE8A4;
	Wed, 10 Dec 2025 07:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765351562; cv=none; b=uzW1E2ae4d0EKXHtxsn8Z6kI7VfbwJOi5FJ69gZYTdj6/gnETjBqAqj6HPvw02uRWvtUDPfRKDEp+9EfVACHm36cKlMn7tJJqTBxEASmuTzrhUHnPb3sBfxJWjAITO2OX4KaWk1xxDsAPmWj6yfUNXqaYBOZxDHj541hZctXDqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765351562; c=relaxed/simple;
	bh=bTTD0yXMByZPOP8+hdWDWK4xGqiPnLzoGKPg3Sl3eLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZbE6aLOlIBihEJgutImmE3anVnxESTBfjHJ3OIX7mjrYjL0l+HdvuJfUtFNO/OHHqqSUS5ehjJPkmqgl4iqaL4P2SRLvKE4pD0RpyshBhQtUElpFLzKlDDg5Vs/mVFSwacT8Ba+iYtdHvUintvj9hgZCo2+l/CkFGpFt4UG5/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=qpJAzXI3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uRMFTElf; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D27467A00BC;
	Wed, 10 Dec 2025 02:25:58 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 10 Dec 2025 02:25:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765351558; x=1765437958; bh=eiAG7rKOgQ
	x9Py8b1gKm28FLJBvTyIIjz9fg6XYAf7k=; b=qpJAzXI3OP5xBwbh8V0kV8P+H4
	pbkCANc4xDW+mwM9Yimj29GlBpl+YB/yHxlHQOfH4eKqbCfQCaw7oW60m3ij1aYr
	MuNQSG5S/iXhhv0QsJJXAbuFWkZZuYyAX2Qj9GF/Nytl2EKHyAdtm8FBSFzOPnwV
	/I0BzK17o4FbN8w2WUd3GHFuDr156/0KonQPSXXWHn5JvHiWMSNIDKC3sfLigAG5
	f1quTKpdMSMO6khsn5gciQL459lteDnNbEdfpFH+0/huLdb8skdqZgRTzv30WphE
	QjdVTndC904eTy9qN1yN9H6dX3IQhI2VSt4x7w54G8o9tv9KaniIcNbP8VKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765351558; x=1765437958; bh=eiAG7rKOgQx9Py8b1gKm28FLJBvTyIIjz9f
	g6XYAf7k=; b=uRMFTElfEn67yC5g+9vcK4/Oz4VNu31rXNWq8D7a7LdAClyO1F4
	gLCKB9u28D92NNO/7M+W0JiGDvDvB50yRR4pPJac36fsqkCRz7drEiqX/AIIutlX
	1RAY0KrvCljlICtGzpSiBRZAIWUi6yEIBmbYtCrrCPAsEXhVxK8zZu6Dnm/BSVPo
	anqmyxGRtnlP9mU/zDbTWhak+9BKSj41A0HTiELVdme50eoA59UZrGV9i1c1XLNq
	nncjxWXhnLgbxqPB8yVcYODvY/j9XdeYHev3tNRYRtPwQSxBsFfSqaUNx42qJ+es
	yUw9agaGQbsRmSY3saE1EHOROS1P/EJx3Nw==
X-ME-Sender: <xms:hiA5acyW-wdlZnQxZMpJi3iNgK8v4Htlu9b0poCRf3xweIjK8VMD6A>
    <xme:hiA5aZAY0_iV1IHB6WaRIuVcAL9CclP4sHNUSmgZZfLLaKb7i5qR9wfJwwW_c5C2Z
    jwVD_A4xbCAz5vFr5QAZ6qm5ESA0oa8uDVTYzFLCdWi3UHqUA>
X-ME-Received: <xmr:hiA5adD0UWkJEatnkhSpqRH7krqtqLNcpbpBFYhjgpLkElwuyPQNKxoovEFF757gqIwgNQSPQxU0d_lpaJf0LvTNdQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudekvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcumffj
    uceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeegheeuhefgtd
    eluddtleekfeegjeetgeeikeehfeduieffvddufeefleevtddtvdenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopedukedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgrthhhrghnsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehsthgrsghlvgdqtghomhhmihhtshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehjrghmvghsrdgtlhgrrhhksehlihhnrghrohdrohhrghdprhgtphht
    thhopehmrdhsiiihphhrohifshhkihesshgrmhhsuhhnghdrtghomhdprhgtphhtthhope
    hrohgsihhnrdhmuhhrphhhhiesrghrmhdrtghomhdprhgtphhtthhopehnihgtkhdruggv
    shgruhhlnhhivghrshdolhhkmhhlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhorh
    gsohesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhhushhtihhnshhtihhtthesghho
    ohhglhgvrdgtohhm
X-ME-Proxy: <xmx:hiA5ac6zsutDHZ-d6OMb2F0cYWB9hboq4zceN-4uPi5Yp5H5P3rNqQ>
    <xmx:hiA5aR1iQOoZ9iXCe0Stcn8R2FAhS_Yt-jzoxWoPUn3n0aezB9571A>
    <xmx:hiA5aQCLQjIv1KKUZmkuehcZk7M0EZyMaGSuMt8mAPZ-inJoiKol0A>
    <xmx:hiA5aZE43Whjnuo1U2i3oOPoOYG3BytdrSXDGct6-sSk3gXCsGnhug>
    <xmx:hiA5abA5zmMWxo2ee0dUWnsVLtWiun_qBKSwx8FCJCrtMCOMLUx9tKIQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Dec 2025 02:25:57 -0500 (EST)
Date: Wed, 10 Dec 2025 16:25:51 +0900
From: Greg KH <greg@kroah.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	james.clark@linaro.org, Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: Patch "dma-mapping: Allow use of DMA_BIT_MASK(64) in global
 scope" has been added to the 6.17-stable tree
Message-ID: <2025121043-retool-judo-5f1d@gregkh>
References: <20251208030749.190427-1-sashal@kernel.org>
 <20251208032256.GA1356249@ax162>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208032256.GA1356249@ax162>

On Sun, Dec 07, 2025 at 07:22:56PM -0800, Nathan Chancellor wrote:
> On Sun, Dec 07, 2025 at 10:07:49PM -0500, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     dma-mapping: Allow use of DMA_BIT_MASK(64) in global scope
> > 
> > to the 6.17-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      dma-mapping-allow-use-of-dma_bit_mask-64-in-global-s.patch
> > and it can be found in the queue-6.17 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> > 
> > 
> > 
> > commit 51a1912d46ceb70602de50c167e440966b9836f1
> > Author: James Clark <james.clark@linaro.org>
> > Date:   Thu Oct 30 14:05:27 2025 +0000
> > 
> >     dma-mapping: Allow use of DMA_BIT_MASK(64) in global scope
> >     
> >     [ Upstream commit a50f7456f853ec3a6f07cbe1d16ad8a8b2501320 ]
> 
> This change has a pending bug fix, consider waiting to apply this to the
> stable trees.
> 
>   https://lore.kernel.org/20251207184756.97904-1-johannes.goede@oss.qualcomm.com/

Now dropped from everywhere, thanks.

greg k-h

