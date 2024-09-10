Return-Path: <stable+bounces-74139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6330A972C2E
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7DE7B2245B
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 08:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31022178395;
	Tue, 10 Sep 2024 08:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="k6b+yR0d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YFu17omU"
X-Original-To: stable@vger.kernel.org
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0383D149E00
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 08:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725957205; cv=none; b=jjGSt03T03N1DOmXE7r/Jez75UN+FGY9JIi7MSP0X5jW5p+yLzFLNZll6waWowMinZtMZcj0ruxoSbQUh0hto3Cj/VeKcA6sCzcAsIiOUvznpmP97jcZjBdNy3TWD6XFU4GMLFEenuqwQUB/Qr1WpT3wqhbkCenw8CfzN2Nrk1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725957205; c=relaxed/simple;
	bh=bV3DjVRr2CeQp++Q2vW4DutuFrfcWYSgiRbpQ5Hhcx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6ehzgelMYG5I7BIYQ9IP4Yf4vch3j0wZsKlwQhrCQnyiUeNb4RZv2+MSucI7Uf1a0XsgnTJRtJ+DUduiYEYGQtgeKiNZH0BdLdlMHZr7nCeT9Ckdna6X1TjSfNaUyNIcAU+wKnxUGfijvT8IIQBAXF+rgDg58GnQPpc1Mz0QL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=k6b+yR0d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YFu17omU; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 006EF11401E5;
	Tue, 10 Sep 2024 04:33:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 10 Sep 2024 04:33:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725957202; x=1726043602; bh=BXDc5bSAhz
	Wh0PklVewicOmA4zdwbxF0tL0FHYIN0to=; b=k6b+yR0diB6REw+cxWgHM3SaDJ
	N9OoavO4Ht1yEDuySF/bYU/SCS8wu/vtcbvIbeRbk9eP7cAXZfkhHuYk+fED+Iw+
	/I3RYqdNqxI7uayD6vw4DWnm88/y9d2L61vq63BmhUEboFWMuCl+KACOmWh2jAZn
	xTEj/iZi7U+9FvlxLIwYHU2oe6jXF+WmCaaAPJMjCx0IlqaDpKlQNbwL5230skS1
	cQf05Qtz1IheEiCPcMWEaoaRty6LP1ZYXBoo0HpFZoZWL9ecpM/BGdRMOXV3t0+j
	6G5Jt7gh6CewT/gyZNSkYNzuYGzph1F+yvFVLW2Bpzn6WCK6HCSAI/Cv9B3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725957202; x=1726043602; bh=BXDc5bSAhzWh0PklVewicOmA4zdw
	bxF0tL0FHYIN0to=; b=YFu17omUnC0JtdkmXP3cQI+rLnlAzyCNbXBJxZUCqTqy
	kd1d6XXiVW272/RMY6FgSRBJzILAWVrfujq7vCGCG4O66QiJPqeW1fNN2SMw8E10
	XeuULh07fcAbAtK9XoIo9VlT7eeip5BWuNWk8OnoJz7ubKbAJKo8N7zTdF8KmukG
	HLbyYpUlKE13wVc8IQXIGPiexVFDUXAn52Hdfl7C1B/ssMbfsbHM2YMVJ6Rzq3tk
	xI1dNvM3FcIrxlzd4F4mNBW+zJZu+jBzivSEf8NzX2MWw0tHTjqLmrSEmOcGilgT
	h+AV58zFO9CLT7MYIm5km55zhL0p3M4Tq2fpA9Bq8w==
X-ME-Sender: <xms:UgTgZjrQklSiKFBKqIv2BJG07Lftg_k0E9pUODQkW-YB1LRL9UedKA>
    <xme:UgTgZtrgBHMRijy1_tOfl3owocW7P8A8cGy1UoAts9v245OnK_Z1Lksplpay-0poT
    ravXyvRsC1Q9A>
X-ME-Received: <xmr:UgTgZgPxb6fFiQICeCZBtVygG9mwhtfbLqUpiI2JbZv6ec2cExDk-Yr5W7IrKiNCmL-BeD2t3FfmOcTxs-bFClsdyvT0gsZFMq695w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeiledgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrf
    grthhtvghrnheptdefledvgeeiudejvdefteehfefflefhledtjedtudffhfekleekffek
    vefhtddvnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorhhgpd
    hmshhgihgurdhlihhnkhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdpnhgspghrtghpthhtohepudeipd
    hmohguvgepshhmthhpohhuthdprhgtphhtthhopehhshhimhgvlhhivghrvgdrohhpvghn
    shhouhhrtggvseifihhtvghkihhordgtohhmpdhrtghpthhtohepshhtrggslhgvsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgs
    ohigrdhnvghtpdhrtghpthhtohepuhhsihgvghhltddtsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepnhgvihhlsgesshhushgvrdguvgdprhgtphhtthhopehtrhhonhgumhihsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegrnhhnrgeskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:UgTgZm682eqkS4HOvV9EWS2kyPl7yyfE0R8o-m5NE0zKAhIsBxndfQ>
    <xmx:UgTgZi7Tq_N1KAhVgrGzzGQQbqbLWOZF0uQP2Aj_UcHS3UR3gC_BXg>
    <xmx:UgTgZujaMjMbw2OHTQeMDrjxSGg96XLzdZAIfTRYpst85GDFl2TTAA>
    <xmx:UgTgZk420e2CYCGy9hoU8jDbjnvaRbx_3q8vlDga8KqUGDHrq1k38w>
    <xmx:UgTgZuooCfh9rI3nilNx753-nzVxxNQBZYYD94kSvO2fc8AtopjsMbeh>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Sep 2024 04:33:22 -0400 (EDT)
Date: Tue, 10 Sep 2024 10:33:21 +0200
From: Greg KH <greg@kroah.com>
To: hsimeliere.opensource@witekio.com
Cc: stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
	Lex Siegel <usiegl00@gmail.com>, Neil Brown <neilb@suse.de>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 4.19] net, sunrpc: Remap EPERM in case of connection
 failure in xs_tcp_setup_socket
Message-ID: <2024091007-savage-railcar-8a72@gregkh>
References: <20240910081040.4102-1-hsimeliere.opensource@witekio.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910081040.4102-1-hsimeliere.opensource@witekio.com>

On Tue, Sep 10, 2024 at 10:10:40AM +0200, hsimeliere.opensource@witekio.com wrote:
> From: Daniel Borkmann <daniel@iogearbox.net>
> 
> commit 626dfed5fa3bfb41e0dffd796032b555b69f9cde upstream.
> 
> When using a BPF program on kernel_connect(), the call can return -EPERM. This
> causes xs_tcp_setup_socket() to loop forever, filling up the syslog and causing
> the kernel to potentially freeze up.
> 
> Neil suggested:
> 
>   This will propagate -EPERM up into other layers which might not be ready
>   to handle it. It might be safer to map EPERM to an error we would be more
>   likely to expect from the network system - such as ECONNREFUSED or ENETDOWN.
> 
> ECONNREFUSED as error seems reasonable. For programs setting a different error
> can be out of reach (see handling in 4fbac77d2d09) in particular on kernels
> which do not have f10d05966196 ("bpf: Make BPF_PROG_RUN_ARRAY return -err
> instead of allow boolean"), thus given that it is better to simply remap for
> consistent behavior. UDP does handle EPERM in xs_udp_send_request().
> 
> Fixes: d74bad4e74ee ("bpf: Hooks for sys_connect")
> Fixes: 4fbac77d2d09 ("bpf: Hooks for sys_bind")
> Co-developed-by: Lex Siegel <usiegl00@gmail.com>
> Signed-off-by: Lex Siegel <usiegl00@gmail.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Neil Brown <neilb@suse.de>
> Cc: Trond Myklebust <trondmy@kernel.org>
> Cc: Anna Schumaker <anna@kernel.org>
> Link: https://github.com/cilium/cilium/issues/33395
> Link: https://lore.kernel.org/bpf/171374175513.12877.8993642908082014881@noble.neil.brown.name
> Link: https://patch.msgid.link/9069ec1d59e4b2129fc23433349fd5580ad43921.1720075070.git.daniel@iogearbox.net
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
> ---
>  net/sunrpc/xprtsock.c | 7 +++++++

Now queued up, thanks.

greg k-h

