Return-Path: <stable+bounces-92823-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B69DA9C61A1
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 20:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCE2ABE390D
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 18:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDB521502E;
	Tue, 12 Nov 2024 18:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="XOnEnwqB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ArkE0Cr/"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FBE215018;
	Tue, 12 Nov 2024 18:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731435192; cv=none; b=JtysA0YgFslhj2/rqurBeqLOGbPEmYcQzcVW4IbsGDMX12Fvqwp6pc8BiDdtRk44UyoO5AdhTSOB8YiQdS//bwBgpc034Xyo4yaepo8iQQUnapHm7M7kQJC3DB4Ttv63xQ8zSr9WnwWSgRPnhCPx7iFKj204cyDY3uqLjaIxDfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731435192; c=relaxed/simple;
	bh=8Md/0wxch8GF2XKL24jvKS1lXD+LgLTefx6I9QRIRPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0cFfgF237CYlGNw6yE9KM6MvculXDoRg020GKYbaW6GqvzAbDGMlIHGxxbCGvz0WFPf52RIxAvRwcdpx8ScXDt+20bplJPedouvBgv45Eg1UKJl33gCH9imm+5BbevMjBLWwNHEdwT7pv5r8/r1Q9/bIiye7H4k/+QTGAGKGOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=XOnEnwqB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ArkE0Cr/; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3AC901140108;
	Tue, 12 Nov 2024 13:13:08 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 12 Nov 2024 13:13:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731435188; x=1731521588; bh=GBlmKr7LO4
	s5Nk4CKtNED03PTOVngWj8u8yCs17F3kQ=; b=XOnEnwqBjOufEhFWucOqNOsxwx
	OB/aDPV8EspXxmMg6zAynKsWxUAaPbpEg+Ip51wb2+fKSBcrhWu/2/qdIfP1WpMn
	j7DDu5N476SeDZH1bDCNzzNTM9hgsNwrNNuPu8zWvxuaiBgNXfyDMiSjb3X4eiky
	fSc3e2DCOiuiIeIJpOPMgUx/60zT2uAB4vbbgyjWDeMqnlzurQ5oLvDczMHJFGlm
	VQI79rDnU7UwzaaqvKfgWLXKqNP53QOCi7k4UwD/lnz5WfQJ4VlsCey6QtKyX5yJ
	xfyjdT5kZupYAMwqhHfzGHF+hf6IkmEVhIYUGByEgHS6Ck6625/RW2vBPwxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731435188; x=1731521588; bh=GBlmKr7LO4s5Nk4CKtNED03PTOVngWj8u8y
	Cs17F3kQ=; b=ArkE0Cr/Vgn6F6jJtmO0G2k+zcSjI+MV2F2en6IYXOrKNzNzpbm
	fOaDcucDr9q5qEcP97RDpbdKvxSBjvYTvyn93NyGUj0BUAOUOwAwaGGWucy7kfy7
	SIpmJK1kzoOquEAzoLDu76XunQKPiOyGgVRhBWaMyoCmwXAEhOWeMsTpwKoS5j2p
	LRl2XSi4fur4CF1+qLKNAPehznt21l4nfXGVnj1iPMHuqD+Q+d9n9seSo/lVHvgl
	scsDZ/0kxWBuke9qJiAGi1OojrmZ7FsMCUbbF6T51mX1TfV93soNNOzeN5gKWMZh
	twpJ+h36OSPleYW25DudgF+kFc8f2RLN00w==
X-ME-Sender: <xms:tJozZ6KPsSEBHF1cSn8fNu13VTYhR0adhi3c0U3lOOeyssArg5cwTA>
    <xme:tJozZyLQ8wzEixmgGVK4EKEsxofWcZAkWf2Yi_R1NqUeG4lHR7JwK3o0mH2ssDupw
    hw2AW0QcgwybQ>
X-ME-Received: <xmr:tJozZ6uChuNBV6RAnJjUC5A4x9PY1TbrJZJU7-M2_3P7vf0XdiIVcS3q44LLb3QOva4dm21TFG96C1C__cP0XmL2KKfcpKANuKZP0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggddutdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrf
    grthhtvghrnhepheegvdevvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefh
    gfehkeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptghhvghnqhhiuhhjiheiieeisehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepnhhiphhunhdrghhuphhtrgesrghmugdrtghomhdprhgtphhtthho
    pehnihhkhhhilhdrrghgrghrfigrlhesrghmugdrtghomhdprhgtphhtthhopehlihhnuh
    igqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrghi
    jhhirghjuhduleeltdesghhmrghilhdrtghomhdprhgtphhtthhopehsthgrsghlvgesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:tJozZ_awMr5H8zhxS3k6chJyE-pT4I8M9OmbsoaZ_H4HBxY92BBCuw>
    <xmx:tJozZxYhnjnTsGZDiew7COUbDVvln1QhQtsGXSBwV2vXSXEIxJZEDA>
    <xmx:tJozZ7B2PK9Rch4Hnp3WCctALFZqtnv-r9Bg9GeidWsdBqAEKZ03bg>
    <xmx:tJozZ3Y6Pmx2YZPIQVC56lFaAzGRjCbVGTJ6tTceV1x4qv5ivJuRdA>
    <xmx:tJozZ1TEZVz8WHtqQgn889c7FS2jZdg1m5j203kjN0LycSKQqCpj0ohy>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 13:13:07 -0500 (EST)
Date: Tue, 12 Nov 2024 19:13:04 +0100
From: Greg KH <greg@kroah.com>
To: Qiu-ji Chen <chenqiuji666@gmail.com>
Cc: nipun.gupta@amd.com, nikhil.agarwal@amd.com,
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] cdx: Fix possible UAF error in driver_override_show()
Message-ID: <2024111230-snowdrop-haven-3a54@gregkh>
References: <20241112162338.39689-1-chenqiuji666@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112162338.39689-1-chenqiuji666@gmail.com>

On Wed, Nov 13, 2024 at 12:23:38AM +0800, Qiu-ji Chen wrote:
> There is a data race between the functions driver_override_show() and
> driver_override_store(). In the driver_override_store() function, the
> assignment to ret calls driver_set_override(), which frees the old value
> while writing the new value to dev. If a race occurs, it may cause a
> use-after-free (UAF) error in driver_override_show().
> 
> To fix this issue, we adopt a logic similar to the driver_override_show()
> function in vmbus_drv.c, protecting dev within a lock to ensure its value
> remains unchanged.
> 
> This possible bug is found by an experimental static analysis tool
> developed by our team. This tool analyzes the locking APIs to extract
> function pairs that can be concurrently executed, and then analyzes the
> instructions in the paired functions to identify possible concurrency bugs
> including data races and atomicity violations.
> 
> Fixes: 48a6c7bced2a ("cdx: add device attributes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
> ---
> V2:
> Modified the title and description.
> Removed the changes to cdx_bus_match().
> ---
>  drivers/cdx/cdx.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
> index 07371cb653d3..4af1901c9d52 100644
> --- a/drivers/cdx/cdx.c
> +++ b/drivers/cdx/cdx.c
> @@ -470,8 +470,12 @@ static ssize_t driver_override_show(struct device *dev,
>  				    struct device_attribute *attr, char *buf)
>  {
>  	struct cdx_device *cdx_dev = to_cdx_device(dev);
> +	ssize_t len;
>  
> -	return sysfs_emit(buf, "%s\n", cdx_dev->driver_override);
> +	device_lock(dev);
> +	len = sysfs_emit(buf, "%s\n", cdx_dev->driver_override);
> +	device_unlock(dev);

No, you should not need to lock a device in a sysfs callback like this,
especially for just printing out a string.

greg k-h

