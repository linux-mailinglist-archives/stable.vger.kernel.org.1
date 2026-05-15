Return-Path: <stable+bounces-247809-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GrzGec1B2rftQIAu9opvQ
	(envelope-from <stable+bounces-247809-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:04:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AED98551D67
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7083C30065E0
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1979E481FD5;
	Fri, 15 May 2026 15:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="pyxa/tAo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S7LF5RRs"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0775747ECE3
	for <stable@vger.kernel.org>; Fri, 15 May 2026 15:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778857416; cv=none; b=A/Kw5HBUE7cimuzEA9WhfSfo9W3kAK1kIgFw69WUTQ98RplTty3O/E2ogA25NuvxTUZ4/OClIpqNHr3J/WpylgTfnHquy8xzoUB/9c38I9GIkOqq0R++8gfU6tpj/bqR3KlQ1cNEgtAb7Z1fvA5p1gtAcrahfJcqUG7Kd7muQDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778857416; c=relaxed/simple;
	bh=R+IhNxKDrONGZYLmpehHyysbNLhEYOP+EnpOVjVPt6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDM2SnGXrcI80IPhKK12FGgiBQpFeZx6abNEOopGN3cv4qFaEqFXo5Ze4wUP4wc4DP1CZvO52+r9y+7TC/PxUovJen005qDzUIy+gUdHQQ4JXo6JOixzQ5Tspy5e0or9EbunjVGmteYoPhLVhHRn7z0fjs57YwcD+T1hxxzxuNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=pyxa/tAo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S7LF5RRs; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 43F161400033;
	Fri, 15 May 2026 11:03:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 15 May 2026 11:03:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1778857407; x=1778943807; bh=Zp9Os2cHh9
	ened5bfnJJ3lSIvZQ1Hxl4HkCaeFc3wfQ=; b=pyxa/tAoIkw+B3LJdn+wxmPpQm
	GaW5Eawon5FFY7GboBbStOYV3pC7MyoNBJzR3sbng4jFQG8WEOhQ1cJ/X/jbOkah
	aUqO6qOwSbMMCUeQdJOiQDGy3kqS6ae1YXDZf2LA6yvQ15/IF5r8blcVkorbHTbF
	hTEiugibIcevCjXbS4Fp1CjrmaUpa9jjguA5ZTo+JGsEdz58wBg5kvqpKZVtGQjV
	k4z7FXudjlwdMd3eEnPricovkbRnGc6kYG0lwkuxPWOq6Iek84RjgxcMyJhZOXA8
	Ki5eqpPF2j+S1f+SYbFE/s6M4Io8ctnUGLsVqjajqONfVtECx/9fltrKK5+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778857407; x=1778943807; bh=Zp9Os2cHh9ened5bfnJJ3lSIvZQ1Hxl4HkC
	aeFc3wfQ=; b=S7LF5RRsH4Cgz8yjCo3Qbjmfnni9YDp8WU+fqEV76H2nr4r9OC8
	Pu2DJw0JuIdIqLZuCsPRWqMdiZDhdjECg4pqebbHKzt1q3PZaDGrgQjXtfc78FRK
	KeVo1OnQ2DE68OOTNZeFnfFbNcBmkmF4+BVF4P9wMWDMdZXakyhpB50DOv47kNFS
	nPxkdFRbTmc74Pf8gAja3b1kn3prkKDoNwondmVAl0rvsa5XOso3EACFTpaR/BdQ
	yg/Ri6kJGpBLeIurFePoTSRp1Zr5bhpuerN3lVtDyCycLbZ24S6wR2C+nPV88OGw
	m9FxSZ51c+XAdE1ZK9za5IwjBs/qIuLeOoQ==
X-ME-Sender: <xms:ujUHasko7eEG27qHojYS13-gG-HZM6ODWYEFP_w3imkZbIg4ORA3yA>
    <xme:ujUHakAEXe74bA9sYxtqz5Le36J2gpg8pcbHkCxl0YAK1GXmqu5AsgeaKzd2S1181
    gJRFhVq4TU3SqP9tgdZs5Oa9UK-Nx20n0yinQJM5jeUmTjJ>
X-ME-Received: <xmr:ujUHamMR5wNS-JqO82Dx8xUZWfWl81FpqFULJfCeo05i_0Mo6DyPKRuaRkglPJuQ3U7XqfSRk-wGI992wOoitth6Xw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufedtjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepjeetueehte
    ekuefhleehkeffffeiffeftedtieegkedviefggfefueffkefgueffnecuffhomhgrihhn
    pehmshhgihgurdhlihhnkhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdpnhgspghrtghpthhtohepuddt
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsrghshhgrlheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepjhhohhgrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrshgrqd
    hkohhrghesughsnhdrohhkihhsvghmihdrtghomhdprhgtphhtthhopegsrhhoohhnihgv
    sehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ujUHajPfvYZOpZWD17L5W3S8F2Fl2P8tCky4VW99-HqWspHZivM7uw>
    <xmx:ujUHamkesuk7HI0r4ZIg866i-4qJQyyEwdxiejljbJf_RzXt5itLlA>
    <xmx:ujUHapsb2pU7Chpkk7K-avioAu6tnZGuGszffC0Quw3sligRADOacg>
    <xmx:ujUHahoeWm-FtT7FuplZ59and9M5E4zGg6pydimSsnNu5cPCzi8THw>
    <xmx:vzUHagGcy1VOiv0ziZE6iGOr4sMUA-WKTbm12iFTzbaMZo3yUeM79Z8o>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 May 2026 11:03:21 -0400 (EDT)
Date: Fri, 15 May 2026 17:03:27 +0200
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Johan Hovold <johan@kernel.org>,
	Masayuki Ohtake <masa-korg@dsn.okisemi.com>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6.6.y 2/2] spi: topcliff-pch: fix controller
 deregistration
Message-ID: <2026051520-veggie-tacky-ce51@gregkh>
References: <2026051239-idealize-clanking-104d@gregkh>
 <20260515113152.2965674-1-sashal@kernel.org>
 <20260515113152.2965674-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515113152.2965674-2-sashal@kernel.org>
X-Rspamd-Queue-Id: AED98551D67
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kroah.com,none];
	R_DKIM_ALLOW(-0.20)[kroah.com:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247809-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kroah.com:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greg@kroah.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,kroah.com:dkim,okisemi.com:email]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 07:31:52AM -0400, Sasha Levin wrote:
> From: Johan Hovold <johan@kernel.org>
> 
> [ Upstream commit 5d6f477d6fc0767c57c5e1e6f55a1662820eef87 ]
> 
> Make sure to deregister the controller before disabling and releasing
> underlying resources like interrupts and DMA during driver unbind.
> 
> Fixes: e8b17b5b3f30 ("spi/topcliff: Add topcliff platform controller hub (PCH) spi bus driver")
> Cc: stable@vger.kernel.org	# 2.6.37
> Cc: Masayuki Ohtake <masa-korg@dsn.okisemi.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> Link: https://patch.msgid.link/20260414134319.978196-8-johan@kernel.org
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/spi/spi-topcliff-pch.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
> index 271f3e7f834be..1a85b92e9eaa3 100644
> --- a/drivers/spi/spi-topcliff-pch.c
> +++ b/drivers/spi/spi-topcliff-pch.c
> @@ -1406,6 +1406,10 @@ static void pch_spi_pd_remove(struct platform_device *plat_dev)
>  	dev_dbg(&plat_dev->dev, "%s:[ch%d] irq=%d\n",
>  		__func__, plat_dev->id, board_dat->pdev->irq);
>  
> +	spi_controller_get(data->host);
> +
> +	spi_unregister_controller(data->host);
> +
>  	if (use_dma)
>  		pch_free_dma_buf(board_dat, data);
>  
> @@ -1433,7 +1437,8 @@ static void pch_spi_pd_remove(struct platform_device *plat_dev)
>  	}
>  
>  	pci_iounmap(board_dat->pdev, data->io_remap_addr);
> -	spi_unregister_controller(data->host);
> +
> +	spi_controller_put(data->host);
>  }
>  #ifdef CONFIG_PM
>  static int pch_spi_pd_suspend(struct platform_device *pd_dev,
> -- 
> 2.53.0
> 
> 

These two did not apply at all :(

