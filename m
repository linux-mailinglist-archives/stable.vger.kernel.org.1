Return-Path: <stable+bounces-215623-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OCADdzzimn2OwAAu9opvQ
	(envelope-from <stable+bounces-215623-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 10:01:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E773511878A
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 10:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE8483031ADE
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 09:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B942C33D6D4;
	Tue, 10 Feb 2026 09:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eoh7RfHs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B096280A5B;
	Tue, 10 Feb 2026 09:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770714063; cv=none; b=Rw3xBvHHf3s4RRzOg6ZsXrkVmgVyESaYOxqXn3151R9WEjQh8rq4gllIlybGnd+DXRFu2/IVgx/l/M+6v1r7EilMM72sq/4WVA+FfwXhUJJMINRuU4dlDEeMsd6vQdPP5scxF/Q3hW2LLdJU+/Y8YzyOkpOj9+hHO4SBG8cgWcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770714063; c=relaxed/simple;
	bh=1IgCLrreBz/N3YL81SnN8Md7AwrHBpXjhO7OoBiEfuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ig/i2UFRXyfuhjWOSeYqZQaAgm8kKgXwJ/u0SQ4nl0aihjBEc+9CriC7fCO5WmjGr4/1oQL9c4e9W2SWKX2Hvv7FiRu8ocJi/o64Nb10Otk68i+9ptX5h68jJEXig/7MnCKJETcOFgMLaIGK7+mIuuiM5EN61120u3ejKDE6TgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eoh7RfHs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 861AFC116C6;
	Tue, 10 Feb 2026 09:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770714063;
	bh=1IgCLrreBz/N3YL81SnN8Md7AwrHBpXjhO7OoBiEfuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Eoh7RfHs2d/lzXJGMj9r0vsZfjdss7xFmnLeHycQqrYwhzi0IkLaY9ygXkurLITKA
	 OQ5hPL3QvPrjYDAf9fA4xo2WdJwPyjYgepZ8paEZVPm0SR//NdSG3Ab/UnRfeUeoAr
	 pJ1lWDkIxt//QncVLThos3PphGWLFlGwINqm4lF/L4ObuhArMhub6IWTVO7Z4uNBnB
	 jTBBySNPN7ZzrFPxP3DhnTolTyDyp2ubEg6pIki+e49dsalP/pYx9GCetWYq+IzLjs
	 sRra9iC5eLbUN6dAHW47WhkLtuOjr47IEUa+WQnrKYd1wkQzAa+wBgNZsDcRtkw3wZ
	 zJ7LGJgXI0SZQ==
Date: Tue, 10 Feb 2026 10:01:00 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: stable@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sujuan Chen <sujuan.chen@mediatek.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net] net: mtk: wed: Fix dma_free_coherent() size
 mtk_wed_hwrro_free_buffer()
Message-ID: <aYrzzEvl8IG1caxS@lore-desk>
References: <20260209151822.136934-2-fourier.thomas@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5gUtC+mBewt4W4cJ"
Content-Disposition: inline
In-Reply-To: <20260209151822.136934-2-fourier.thomas@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215623-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable,netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,nbd.name,mediatek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,collabora.com,lists.infradead.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[fourierthomas.gmail.com:query timed out,stable.vger.kernel.org:query timed out];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E773511878A
X-Rspamd-Action: no action


--5gUtC+mBewt4W4cJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The DMA buffer alloc'd in mtk_wed_hwrro_buffer_alloc() with size
> dev->wlan.rx_nbuf but is freed with size dev->hw_rro.size.
>=20
> Change the dealloc size to match the one used in
> mtk_wed_hwrro_buffer_alloc().
>=20
> Fixes: 6757d345dd7d ("net: ethernet: mtk_wed: introduce hw_rro support fo=
r MT7988")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> ---
>  drivers/net/ethernet/mediatek/mtk_wed.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethern=
et/mediatek/mtk_wed.c
> index 1ed1f88dd7f8..455df564174d 100644
> --- a/drivers/net/ethernet/mediatek/mtk_wed.c
> +++ b/drivers/net/ethernet/mediatek/mtk_wed.c
> @@ -879,7 +879,7 @@ mtk_wed_hwrro_free_buffer(struct mtk_wed_device *dev)
>  		__free_page(page);
>  	}
> =20
> -	dma_free_coherent(dev->hw->dev, dev->hw_rro.size * sizeof(*desc),
> +	dma_free_coherent(dev->hw->dev, dev->wlan.rx_nbuf * sizeof(*desc),
>  			  desc, dev->hw_rro.desc_phys);

I think this problem is present even in the mtk git repo. I guess we should
allocate DMA buffer using dev->hw_rro.size instead of using dev->wlan.rx_nb=
uf
directly.

@Sujuan: any input on it?

Regards,
Lorenzo

> =20
>  free_pagelist:
> --=20
> 2.43.0
>=20

--5gUtC+mBewt4W4cJ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaYrzzAAKCRA6cBh0uS2t
rDvzAPkBX1YTfrEpUBYKFlg/hoAY2G+5Paz3zr1hmUyqY94m+AEAyhM0Q8sr8rB8
DSN4g6RwZHsJPkjsBLlo+xDkFDbtFQA=
=DElc
-----END PGP SIGNATURE-----

--5gUtC+mBewt4W4cJ--

