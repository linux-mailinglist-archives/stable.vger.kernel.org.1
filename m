Return-Path: <stable+bounces-238281-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMY9B7Or4GkCkwAAu9opvQ
	(envelope-from <stable+bounces-238281-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 11:28:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D6A40C5A5
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 11:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D578303C519
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 09:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663EE39A054;
	Thu, 16 Apr 2026 09:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="g0bA2uG9"
X-Original-To: stable@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AA8399340;
	Thu, 16 Apr 2026 09:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776331240; cv=none; b=rmIIPX6BidAS+NW4zkMN686GN5pfNFKUmIffC4CDTi24RZvEpuxTeyoaQmpwPP9TzPYzOB1re3d0TkZ9J3hPhfcCgOnloqpxAeFal80FPiIkCiFg1tiZZVd53RzvYKife4oDw+fmVxY9d5NDHzmOppoRrgmHV7JOgl/dHTI/AJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776331240; c=relaxed/simple;
	bh=dD3UUD0Kr7I0glB/GGKzh7RGXYNoZdsYahQ8K3B82bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbgQ7XMoXOnBiOE6mTqh1dO/hjptmzhNTAO/T7VV2g/TR+8Oh/tg9QtTjWHXDIZrOtq84dsfnQUk2RYVQ8v/zE40574Cy+39yZ+wIZumwHxC+YMspKXqjTKBIhPOqIV13pbFlllAyCqObORR0NUl5bjJ/DRxD0t6i0YErFgF7kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=g0bA2uG9; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=LeD79Ghy94CfpUoAQenbsLexQn/Pp4AFdktVeRQ/V6Y=; 
	b=g0bA2uG9/AKjawQd7lLtACyn8Prgwof0ZFaLd47prRkh0pa2EX8+Kpdhxb6ABzAw6j1+S8GiTTv
	n7l/ChOrBGgHHbswIhrz8viP953E1DpoK/pMGGoGCdpExpKedlr3ffbC4SE+2Z95JKl0p0gFeXP+i
	ILEaYsXV+QnD/jnI1auohxAXm9rEpCNVZD979/rjhybP8/+vh/a6tbiyijI0k4UtRILZ5z+bLEmuk
	eTnzzqRQ4PmOrNo8tC90FTgnukiod0veYJJEGhjG37qrf4WStGVO/wrszWxYAUH98wMf/mbBJ2Llr
	mZrfuTkwCp5C3Qizia2lD+Ow01IcnGkbCT9g==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wDItV-006VMc-1h;
	Thu, 16 Apr 2026 17:20:18 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 16 Apr 2026 17:20:17 +0800
Date: Thu, 16 Apr 2026 17:20:17 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Srujana Challa <schalla@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Kees Cook <kees@kernel.org>,
	Lukasz Bartosik <lbartosik@marvell.com>,
	Suheil Chandran <schandran@marvell.com>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] crypto: octeontx2: fix IRQ vector leak in
 otx2_cptpf_probe()
Message-ID: <aeCp0Xe5G531vHBj@gondor.apana.org.au>
References: <20260414123857.3162673-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414123857.3162673-1-lgs201920130244@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238281-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gondor.apana.org.au:dkim,gondor.apana.org.au:mid,apana.org.au:url,apana.org.au:email]
X-Rspamd-Queue-Id: C2D6A40C5A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 08:38:57PM +0800, Guangshuo Li wrote:
>
> diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c b/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
> index 346d1345f11c..059f702dbf5c 100644
> --- a/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
> +++ b/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
> @@ -783,7 +783,7 @@ static int otx2_cptpf_probe(struct pci_dev *pdev,
>  	/* Initialize AF-PF mailbox */
>  	err = cptpf_afpf_mbox_init(cptpf);
>  	if (err)
> -		goto clear_drvdata;
> +		goto free_irq_vectors;
>  	/* Register mailbox interrupt */
>  	err = cptpf_register_afpf_mbox_intr(cptpf);
>  	if (err)
> @@ -826,6 +826,8 @@ static int otx2_cptpf_probe(struct pci_dev *pdev,
>  	cptpf_disable_afpf_mbox_intr(cptpf);
>  destroy_afpf_mbox:
>  	cptpf_afpf_mbox_destroy(cptpf);
> +free_irq_vectors:
> +	pci_free_irq_vectors(pdev);

Good catch.  But what about the remove path, shouldn't the vectors
be freed there as well?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

