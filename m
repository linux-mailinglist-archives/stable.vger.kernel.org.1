Return-Path: <stable+bounces-267946-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c7HrB+WKOmrD/QcAu9opvQ
	(envelope-from <stable+bounces-267946-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 15:32:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 899406B776D
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 15:32:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=ksBeiXZe;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267946-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-267946-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EFB093062A6A
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 13:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7B437A49D;
	Tue, 23 Jun 2026 13:32:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D3024A067;
	Tue, 23 Jun 2026 13:32:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782221533; cv=none; b=IRZXDgKchiKDcONo3585JG8RCJHGQPQt2VVJi7MMcjxEeJKg1t4wW8p2myrd/F8Wt648NkPlGjQZFBq5oew6FIJlQe1n4c+MFYz8egHThgbQQUfw8agDC900gakWkyyUWpJ8Pjh1cY9vj5nUGD3VLKlWikq1R8qYwt34OoGnA1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782221533; c=relaxed/simple;
	bh=GLAQ1wAQQBnUigfR4Tu42LmsFdtCMYbfmp+zWHoDhgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pi/7hSfPjetpVnzLzx3eVeluk8vcqZM7FZtkY0dvIUsAf66/7SljEg1Pk37pEAGJA237+tb8LrAvzhuu5Sl7upx0YEiNY6y/NpzCPKzc5PmoTps+f+JejIbqiT3IY4rkEuhVdmI4cPkyV1mPMdxFgF/GCQ93VcUk4Qzx/zVCjjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=ksBeiXZe; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OPczqObw2LU9Iec6AtIPigfD+2H5uDyJzcQYqscqe8A=; b=ksBeiXZeEZjl6T9CNGPY+iendx
	WCYi4aP/aPj6KTsn0nZs/fQWTvXm6vt6g0JDhs6Z8e888Xauk0dDUKcpaqF7d5naq1lemWIedpd44
	qgQSh3rLhaaTwrI02kb89et1zeUg+t0wyR8Sg2cZcRLQrFBp8bIXNMnT9AFO2llAlSBFu1OuG3b0/
	emUM94XMDBGeOZKZRhXxwZ384q9ocScpzDinj1mWubgq7HRB7QlPh6BP1oJ+ht3qUBoC1Pds3N1SE
	Xqiy+GSvF16Hf4CsTEPt6GhIwp+9tJdxO2IUUnSOPrCfat/+USKwNRHzgkx62wgEeWz0xEx4/QvB1
	i4vNvx1Q==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wc1E9-001gUR-2h;
	Tue, 23 Jun 2026 13:31:46 +0000
Date: Tue, 23 Jun 2026 06:31:40 -0700
From: Breno Leitao <leitao@debian.org>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, kory.maincent@bootlin.com, zilin@seu.edu.cn, petrm@nvidia.com, 
	u.kleine-koenig@baylibre.com, marco.crivellari@suse.com, vadim.fedorenko@linux.dev, 
	Aleksey.Makarov@caviumnetworks.com, satananda.burla@caviumnetworks.com, 
	felix.manlunas@caviumnetworks.com, derek.chickles@caviumnetworks.com, rvatsavayi@caviumnetworks.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: liquidio: Check soft command allocation in lio_main
 setup_nic_devices()
Message-ID: <ajqKbaeXLvcLyN-0@gmail.com>
References: <20260623125611.2228149-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623125611.2228149-1-haoxiang_li2024@163.com>
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:haoxiang_li2024@163.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:kory.maincent@bootlin.com,m:zilin@seu.edu.cn,m:petrm@nvidia.com,m:u.kleine-koenig@baylibre.com,m:marco.crivellari@suse.com,m:vadim.fedorenko@linux.dev,m:Aleksey.Makarov@caviumnetworks.com,m:satananda.burla@caviumnetworks.com,m:felix.manlunas@caviumnetworks.com,m:derek.chickles@caviumnetworks.com,m:rvatsavayi@caviumnetworks.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-267946-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[163.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER(0.00)[leitao@debian.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 899406B776D

On Tue, Jun 23, 2026 at 08:56:11PM +0800, Haoxiang Li wrote:
> octeon_alloc_soft_command() returns NULL when the soft command buffer
> pool is empty. setup_nic_devices() dereferences the returned pointer
> immediately when preparing the interface configuration command, which
> can lead to a NULL pointer dereference if the pool is exhausted.
> 
> Return -ENOMEM when the allocation fails and let the existing NIC init
> failure path handle the error.
> 
> Fixes: f21fb3ed364b ("Add support of Cavium Liquidio ethernet adapters")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
>  drivers/net/ethernet/cavium/liquidio/lio_main.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
> index 0db08ac3d098..5077129656e8 100644
> --- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
> +++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
> @@ -3363,6 +3363,9 @@ static int setup_nic_devices(struct octeon_device *octeon_dev)
>  		sc = (struct octeon_soft_command *)
>  			octeon_alloc_soft_command(octeon_dev, data_size,
>  						  resp_size, 0);
> +		if (!sc)
> +			return -ENOMEM;

Is it fine to return in here, given that the
octeon_register_reqtype_free_fn()  and octeon_register_dispatch_fn()
functions succeed above? Do you need to clean any side effect by them?

--breno

