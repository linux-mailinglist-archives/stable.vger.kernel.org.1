Return-Path: <stable+bounces-66542-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AFC94EF63
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 920D8282DAE
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B859517DE36;
	Mon, 12 Aug 2024 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Jgbil5AK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YoVpxfTN"
X-Original-To: stable@vger.kernel.org
Received: from flow3-smtp.messagingengine.com (flow3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A423F16B38D;
	Mon, 12 Aug 2024 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723472406; cv=none; b=GAdZe57T8+RTc4//imnP3/eDA8OVUXDwA1faspArni69w7BzaGGNJG6O58QSrWnGOSTKyekla4GOZePr6FHHTlFaYwdLZxemAyByd+oimmY7PTCWyqyKwIJq1hVXsHNOVg7x+Ny7qnTgaFUMnvt2AM6pdX7eYYBoLwp+ERx2/Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723472406; c=relaxed/simple;
	bh=cVkHBiwDL71VAbFCe3luGFmIFIgP7wC1OfFcmy9JLoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQ3G8h9Rj0GlGZUU943AVidmspsCuEBYAgnaq1/k4Pd4k3LV3k7Te2mztcJU+cbqeu2JOuygfXFCNffLt4NCfT00k988pi04ixVmqQjCTuX75kG4DOZj907WKTot66d3qZkxGWXjnf1ydQUxCBSxflYoPoBNdB3dHsRchLzxqjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=Jgbil5AK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YoVpxfTN; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailflow.nyi.internal (Postfix) with ESMTP id A9969200DE8;
	Mon, 12 Aug 2024 10:20:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 12 Aug 2024 10:20:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723472403; x=1723479603; bh=uCDj2ND5nE
	8inw/UhtR4NteFMYiUan8kp+SXKAFbsaQ=; b=Jgbil5AKeanZIvWttmxLqpKCsG
	cesbBek8ICenp01vbRpzfnsqvCEeqYZDrJFOGmG4pyUGj8ycXV278ntTSqpCYfj+
	CT8mV9XiUNoZJXSI2E0gI5eWrDDMPq3amAq6JVPK99glkO718BJvjEtqdwLV8/d0
	aXX0nAulrrgPlE1uWsdyJyXFrHieiEnRfE96SJRQhvhxUPcKbPyosTyJe6BnQniF
	uBfkae4CprmvGdqvRNUslYuZzWV8KN0sSPuEJZOaOdLRUg8sX/Btn33nk1si8JWu
	BwaqA9R1Rp8yYoK6gZOIv1rVHIY2N82u2NWrDBs+siwcqSxL9Yg7mh5gh67g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723472403; x=1723479603; bh=uCDj2ND5nE8inw/UhtR4NteFMYiU
	an8kp+SXKAFbsaQ=; b=YoVpxfTN+n/d3TpfgC2wVhmVD01+o/XbiBE+IjP5hfZU
	LawS8HVlgD9HbX6Y0ZVfYbgMdSpuh6jqcuDIe2nArfz8tR+jM4q+oGkLdB6MaFHV
	PaYFhq4TEN/Ge6nm+xerlm6USso7J/EdCiOB2kq9KpgAfI2O16tNEWjNbTqM0Gr6
	ZNubXp7L65W9gsuDjWi9Ww32m2JiWP0MXmpdfMrwXfYjXaX6m2iXQRXqsVcLSXup
	WbSkBzFWq8h0JtI2n9s2jnsutu8TDCTffV+yJEgMSJyUkG6wrs+8IU+4IWEmx1hK
	JRlz2B773b4Hwub2EfGGht4DduJvUVHWsVS/KI9hcQ==
X-ME-Sender: <xms:Exq6ZgCsslAOYbRYLyk4RFsaAA_5noMhx7QlvMfy9lP9IQ25BicfMQ>
    <xme:Exq6ZihYkboEyO7RB17bKCXc-PCd42161nfETWrJP6i8aNPgUjuLZW4gzzfislGzz
    PWhHiFgXBQKsg>
X-ME-Received: <xmr:Exq6ZjnRVvHGeGII-0PWSXqBeaCWn2mSC6OPVh-An03T6IlwKYokAQ7YI7hQYfp5HExQxU65BTHV1WBjMErQfDRJQEkyLcIwXue_Wg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddttddgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrf
    grthhtvghrnhepjeetueehteekuefhleehkeffffeiffeftedtieegkedviefggfefueff
    kefgueffnecuffhomhgrihhnpehmshhgihgurdhlihhnkhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdp
    nhgspghrtghpthhtohepvdegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrlh
    gvkhhsrghnuggvrhdrlhhosggrkhhinhesihhnthgvlhdrtghomhdprhgtphhtthhopehs
    thgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihgthhgrlh
    drkhhusghirghksehinhhtvghlrdgtohhmpdhrtghpthhtohepphgrvhgrnhdrkhhumhgr
    rhdrlhhinhhgrgesihhnthgvlhdrtghomhdprhgtphhtthhopehhohhrmhhssehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehkrhhishhhnhgvihhlrdhkrdhsihhnghhhsehinhht
    vghlrdgtohhmpdhrtghpthhtoheprghnthhhohhnhidrlhdrnhhguhihvghnsehinhhtvg
    hlrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehnvgigrdhsfidrnhgtihhsrdhoshguthdrihhtphdruhhpshhtrhgvrghmihhnghesih
    hnthgvlhdrtghomh
X-ME-Proxy: <xmx:Exq6Zmy3X1VnAW_1lPaiJxzKQ-UP_SiNDCExMkCxvjtafQVM-Qy8qw>
    <xmx:Exq6ZlTlX1TOeDFFsO7iMjQYzkLxbH5blhS932bNWzcR7C63qMuzsg>
    <xmx:Exq6Zha5NNeI5JszU0ddiZ7Bn4EaEDipsqK9z6bmGCyRTyUw-8Qx5w>
    <xmx:Exq6ZuQjoiZOpsLnOrJtUKKcC-WEM0Y4MdPzuEJTiKai0QmqdSNnUw>
    <xmx:Exq6ZhLc_69r2TVkE3UXEtNW4rS_XWSYOgbz5EkrZbJJQNQRneNUUaEP>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Aug 2024 10:20:02 -0400 (EDT)
Date: Mon, 12 Aug 2024 16:20:00 +0200
From: Greg KH <greg@kroah.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: stable@vger.kernel.org, Michal Kubiak <michal.kubiak@intel.com>,
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
	Simon Horman <horms@kernel.org>,
	Krishneil Singh <krishneil.k.singh@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.10.y] idpf: fix memleak in vport interrupt configuration
Message-ID: <2024081251-eggshell-down-d665@gregkh>
References: <20240812134455.2298021-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812134455.2298021-1-aleksander.lobakin@intel.com>

On Mon, Aug 12, 2024 at 03:44:55PM +0200, Alexander Lobakin wrote:
> From: Michal Kubiak <michal.kubiak@intel.com>
> 
> commit 3cc88e8405b8d55e0ff035e31971aadd6baee2b6 upstream.
> 
> The initialization of vport interrupt consists of two functions:
>  1) idpf_vport_intr_init() where a generic configuration is done
>  2) idpf_vport_intr_req_irq() where the irq for each q_vector is
>    requested.
> 
> The first function used to create a base name for each interrupt using
> "kasprintf()" call. Unfortunately, although that call allocated memory
> for a text buffer, that memory was never released.
> 
> Fix this by removing creating the interrupt base name in 1).
> Instead, always create a full interrupt name in the function 2), because
> there is no need to create a base name separately, considering that the
> function 2) is never called out of idpf_vport_intr_init() context.
> 
> Fixes: d4d558718266 ("idpf: initialize interrupts and enable vport")
> Cc: stable@vger.kernel.org # 6.7
> Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
> Reviewed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Link: https://patch.msgid.link/20240806220923.3359860-3-anthony.l.nguyen@intel.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 

Now queued up, thanks.

greg k-h

