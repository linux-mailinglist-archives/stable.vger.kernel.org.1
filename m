Return-Path: <stable+bounces-177596-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00478B41A44
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 11:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84C9D1BA4399
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 09:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22062EC54B;
	Wed,  3 Sep 2025 09:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="mlP1oUsP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cQflpq8x"
X-Original-To: stable@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D8A2EC56C
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 09:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756892522; cv=none; b=KWj9QdPwXSSyNGxNkVbSYiWfXaOSp5uJoGHTjQuTSA5qbS0APgvjDiUgRH6LqC9Ndmh/dDea3+UStK64QTn9Ik3zB4xeF7CLCLSCYYHdI3qPivdDqrQd0LEvY8kr4XehMCCKJfhtxtC4oSMEoItN+NSZEWKNAGAybcdjrs4UKV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756892522; c=relaxed/simple;
	bh=Zq+DvfasxvVlTEn5eb4BHZsMkEb1AyDrxiuwsZYk3JY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8cq2bFPygrWYOxu7b0NjAsm1nZRQAtX0ZjDRnK9ZL7kB+YxmM9lVfM9lb7K1tnN1EylgdvCGDarLmlR3qdJDwxChA1fq1gnOKcEKXJ6owXHWimNZVhcXQzYV2qwK9YVEzO2A/o9hjH+lu7oIzufbQXjvFN5J/mDWhzqgK8HvFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=mlP1oUsP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cQflpq8x; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 721BAEC02F6;
	Wed,  3 Sep 2025 05:41:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 03 Sep 2025 05:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756892519; x=1756978919; bh=kp1tNsHg9t
	1wAUZLhN7vDSZ11VYDD6YUZaRVR2OT+QU=; b=mlP1oUsPivTn4Nbn4hqRqG+/L8
	+HtEw46PG1qpBjghZOFqc7K2kgRLmSbbejoNIYJhvCjsxWf+yL6rJs+IUAufBOJw
	yIWjEwcrZakVrKtDDanwRJF9gUMyldpv2B0m1ILi2pWjMNtZE4djrqfaFnGxtTQI
	l523f9rFDQ+JPcjgSb4LQIqediBj1mgX7qlldb0A+XAHw3tJK5XcfYHTJLCEIt+k
	CkQ+tAHzw1C8IvnrtmhL0bBsBYWuiBDNUpvpVS/i8RBn9Y2IW1V9CksWeutLHe9V
	75WmV0G0C5RpQJW9DTddf1oSI+Y0IdXD/y3pU/gyV/m4tZMdkS3ZksJTIE4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756892519; x=1756978919; bh=kp1tNsHg9t1wAUZLhN7vDSZ11VYDD6YUZaR
	VR2OT+QU=; b=cQflpq8xng2YO6oL4YIJrKcpDVpyjmXNOIik4umsaR6qvpFVoao
	FoqpDGSHTleCztkjtuM8qWg0yEOOmID3IgZjQx2XsdxHSMUytrx3AJ2rmsPeOz1n
	clyzuQipyMjF3gT6kGmhNkkwbM+VJh26MDA2lwVG9+R9IrOt04TRWcJAJdcyhb9x
	AUjRaGpcW7QTEiKTLAg8SW1tObVgYXX3ZSiCr1ut9VMiLYb1cE17BmGn4MnTO5Fn
	RoYFcHDKkRiVMDo8k7vX/p0TnR5BpCLgWtbx3cLCfRsFivZsIxtSH9hvfgjakWjV
	KlXFanmyI9X7vPphpMWG3WxfavGgfMR4tJQ==
X-ME-Sender: <xms:Zw24aFCZ6WVMcLDCLUY2J5zfYoMcGwTU-LN5weRsRT6O8iEPlB9ViQ>
    <xme:Zw24aFDD1bwRUIY0ZleYPUBLUUnoK_wSDauUov9aw_B0UevcASsnj9MjkO5OLmHpu
    NTd2MY81XqTHA>
X-ME-Received: <xmr:Zw24aOPh4wR_BHu5kmUMJIgjdQN0wyx63nFQkKiWsLxa7GzZZ6Gt45-43XPnvOwqaWjb9qtI8P-elMx6tXQMk5_d4jsIZKegw7OI1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfmjfcu
    oehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepjeetueehteekue
    fhleehkeffffeiffeftedtieegkedviefggfefueffkefgueffnecuffhomhgrihhnpehm
    shhgihgurdhlihhnkhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdpnhgspghrtghpthhtohepudekpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehsuhhjrghnrgdrshhusghrrghmrghnih
    grmhesshgrphdrtghomhdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehklhhithgvhihnsehnvhhiughirgdrtghomhdprhgtph
    htthhopehighhoiihlrghnsehnvhhiughirgdrtghomhdprhgtphhtthhopehmsghlohgt
    hhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepthgrrhhiqhhtsehnvhhiughirgdrtg
    homhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgr
    shhhrghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrkhgvnhguohesrghkvghnug
    hordgvuh
X-ME-Proxy: <xmx:Zw24aHPS_PUWf6WMbBLQX6wNPn6nUJdagdS1QRHtClujuCRKxydo5A>
    <xmx:Zw24aKuI5TqK7wHMylPamdrjgiwY5X8d9UU-bK3tLInlwXblRxnZVw>
    <xmx:Zw24aE_yx96O3FBzxhyon1IW9zDpzzl92WXVBnxmw2juhm7oz6u68w>
    <xmx:Zw24aOG8w8M2Y9HLcFy2HXMDoA7OipsDlWKrkQ5Wn7x5BaTnY6GMbA>
    <xmx:Zw24aIAJVVeaDVsi9FwNGSZadIXwiKbZFpELSCHvPeWGMICDo5EV2L3G>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 05:41:58 -0400 (EDT)
Date: Wed, 3 Sep 2025 11:41:56 +0200
From: Greg KH <greg@kroah.com>
To: "Subramaniam, Sujana" <sujana.subramaniam@sap.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Itamar Gozlan <igozlan@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>, Akendo <akendo@akendo.eu>
Subject: Re: [PATCH] net/mlx5: HWS, change error flow on matcher disconnect
Message-ID: <2025090322-nervy-excuse-289e@gregkh>
References: <20250903083947.41213-1-sujana.subramaniam@sap.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903083947.41213-1-sujana.subramaniam@sap.com>

On Wed, Sep 03, 2025 at 08:40:13AM +0000, Subramaniam, Sujana wrote:
> From: SujanaSubr <sujana.subramaniam@sap.com>
> 
> [ Upstream commit 1ce840c7a659aa53a31ef49f0271b4fd0dc10296 ]
> 
> Currently, when firmware failure occurs during matcher disconnect flow,
> the error flow of the function reconnects the matcher back and returns
> an error, which continues running the calling function and eventually
> frees the matcher that is being disconnected.
> This leads to a case where we have a freed matcher on the matchers list,
> which in turn leads to use-after-free and eventual crash.
> 
> This patch fixes that by not trying to reconnect the matcher back when
> some FW command fails during disconnect.
> 
> Note that we're dealing here with FW error. We can't overcome this
> problem. This might lead to bad steering state (e.g. wrong connection
> between matchers), and will also lead to resource leakage, as it is
> the case with any other error handling during resource destruction.
> 
> However, the goal here is to allow the driver to continue and not crash
> the machine with use-after-free error.
> 
> Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> Signed-off-by: Itamar Gozlan <igozlan@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> Link: https://patch.msgid.link/20250102181415.1477316-7-tariqt@nvidia.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sasha didn't sign off on this original commit, did they?

> Signed-off-by: Akendo <akendo@akendo.eu>

Real name?

> Signed-off-by: SujanaSubr <sujana.subramaniam@sap.com>

Correct name?

What is this being sent for?

totally confused,

greg k-h

