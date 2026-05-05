Return-Path: <stable+bounces-244254-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMyuAqc5+mnHKwMAu9opvQ
	(envelope-from <stable+bounces-244254-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 20:40:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A910E4D2C7B
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 20:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAA6E304457D
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 18:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318973C871B;
	Tue,  5 May 2026 18:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="jon8/EDe"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6983B19A9;
	Tue,  5 May 2026 18:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778006177; cv=none; b=VAvi+kJd4dj2uEQrtI+6iXYkAV23Ubodhrv8m+icDBDcWNe0/J+v62MlKlweHsq7+We235MjErfC5le/Q12r+dW6/Vx/lsg2bpo5sExdGrxrAsLFos5fzElVF8yOiovvhgV0TrPeS+x68y2wZkQY1lAibzkwu4FWi8/Ycwd9uVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778006177; c=relaxed/simple;
	bh=fJNLh7vlWBmLtkgJ+eGR18nb9EkD+2PPfCUJu2JN5vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FjN/7lN31KOPk7CVgrR56uPC0n+VDSxmQm/N5ulGCXBmGquG2PHnE3S0/qVwZliHFRNU+Rz3wcimLjplIQec9aeb7IOHj8WpbIm9vvKG+9pDTqlW6KFa+OpuelmqK4FIOO7jf2Y/vNqYlQsjjaXMcHaoGDgYbgTH5NcdnQT1gDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=jon8/EDe; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=4dK8dGl/0EI/DjbmEcBMbo8RnhHPnsLTlshvyB5AK6E=; b=jon8/EDe5bki1ULUH1d6giVxcn
	tCb8OCgP9jYmtkI4aivHoD0YwjBA4Z7D3Ajm6KCkMVYuR+C4AsP9VRbdPl2Hdhg89HFiDqolv+Fqe
	W64mG8B937HTPjaDLa+j6EJr54Fe/E+mM9JplmqOIobxfWDM6qUvlO/B050wn4mn/cSBSEER0IJtT
	/zeEDRhRXLr2Ij7hFpRgq7Z2iLVBbPZJVIkrjynAyfVZ0XLAn3aPpUQtIsIU7kdLKI8rA77ewMMIB
	oKHFdQmXV0GZbDyKeKuAQ3Dsomy++jWF6P+E1iAiVHYbREwsvISjB1Zj1uqBc7V+9d8Yr/5NJU7tt
	X2MkkgmQ==;
From: Heiko Stuebner <heiko@sntech.de>
To: Johan Hovold <johan@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
 stable@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH] clk: rk808: fix OF node reference imbalance
Date: Tue, 05 May 2026 20:36:11 +0200
Message-ID: <3672033.3VsfAaAtOV@phil>
In-Reply-To: <177714062701.5403.1177541832751457755@lazor>
References:
 <20260407095027.2625516-1-johan@kernel.org>
 <177714062701.5403.1177541832751457755@lazor>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Queue-Id: A910E4D2C7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sntech.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sntech.de:s=gloria202408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-244254-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heiko@sntech.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[sntech.de:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,collabora.com:email,sntech.de:dkim,sntech.de:email]

Am Samstag, 25. April 2026, 20:10:27 Mitteleurop=C3=A4ische Sommerzeit schr=
ieb Stephen Boyd:
> Quoting Johan Hovold (2026-04-07 02:50:27)
> > The driver reuses the OF node of the parent multi-function device but
> > fails to take another reference to balance the one dropped by the
> > platform bus code when unbinding the MFD and deregistering the child
> > devices.
> >=20
> > Fix this by using the intended helper for reusing OF nodes.
> >=20
> > Fixes: 2dc51ca822e4 ("clk: RK808: Reduce 'struct rk808' usage")
> > Cc: stable@vger.kernel.org      # 6.5
> > Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
>=20
> +Heiko

I've looked that up, and that is the right way to go

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

>=20
> >  drivers/clk/clk-rk808.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/clk/clk-rk808.c b/drivers/clk/clk-rk808.c
> > index f7412b137e5e..5a75b5c91555 100644
> > --- a/drivers/clk/clk-rk808.c
> > +++ b/drivers/clk/clk-rk808.c
> > @@ -153,7 +153,7 @@ static int rk808_clkout_probe(struct platform_devic=
e *pdev)
> >         struct rk808_clkout *rk808_clkout;
> >         int ret;
> > =20
> > -       dev->of_node =3D pdev->dev.parent->of_node;
> > +       device_set_of_node_from_dev(dev, dev->parent);
> > =20
> >         rk808_clkout =3D devm_kzalloc(dev,
> >                                     sizeof(*rk808_clkout), GFP_KERNEL);
> >
>=20





