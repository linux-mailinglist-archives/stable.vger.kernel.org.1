Return-Path: <stable+bounces-43184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5F58BE53A
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 16:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47B9F28A01E
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 14:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D3115EFC8;
	Tue,  7 May 2024 14:08:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A51214EC64
	for <stable@vger.kernel.org>; Tue,  7 May 2024 14:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715090887; cv=none; b=G+gpGIpHN6JwVtg/TeErMKCDjHa6nI5SZl2ksMR17NcEocn8nH/3RMKXz+c7j+wUX7s6JRmR+FzucaF0xHg6hhcIf8amUZ7l0NKbivePHI0+b+HRIE+LgNfylSjvAnDXUUSUZ8KCPXEZ8LZSsSXD7Kxbc8HjXT/EMZNtjJIC4So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715090887; c=relaxed/simple;
	bh=/Z9ykdE/gw4RhCDa8pfbSV8Xayw3wLMDyf1VXe0/6iY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QdxJ67fhPW7Tx6N+vRdneR4U1hR3AJIR7Lr/GSuMumfUt9sLC01z6jhWyTxtoEp4Z0+3Xx/WGUYReUHeIM7NovuaZJ+IL3V4LOct16SjtKqeWYIda/5+6HcXN/xonJZZiE6UBHsu/uk0msNx+Posyao6mH1CTx2yKnqyOP0j7Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1s4LUB-0006vO-Td; Tue, 07 May 2024 16:08:03 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1s4LUA-0006tx-OR; Tue, 07 May 2024 16:08:02 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1s4LUA-00HPn5-2B;
	Tue, 07 May 2024 16:08:02 +0200
Date: Tue, 7 May 2024 16:08:02 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: David Lechner <dlechner@baylibre.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org, 
	Michael Hennerich <michael.hennerich@analog.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Mark Brown <broonie@kernel.org>
Subject: Re: Patch "spi: axi-spi-engine: Convert to platform remove callback
 returning void" has been added to the 6.1-stable tree
Message-ID: <xm5ghowrandbwib2osgihglhwief6buepdcht42uljj65apnya@qgshrnbi2s5r>
References: <20240506193007.271745-1-sashal@kernel.org>
 <668fcb3c-d00c-4082-b55d-c8584f1b3f7a@baylibre.com>
 <xoadzhyfsjcmvrolb7smsjsvvhfb67m6rcata7sox54yeqm54n@neow3nvsxcti>
 <0ba14e0f-6808-45ae-a6cd-9b9610d119db@baylibre.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ybbp2rswycy36rqm"
Content-Disposition: inline
In-Reply-To: <0ba14e0f-6808-45ae-a6cd-9b9610d119db@baylibre.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org


--ybbp2rswycy36rqm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello David,

On Tue, May 07, 2024 at 08:59:16AM -0500, David Lechner wrote:
> On 5/7/24 1:13 AM, Uwe Kleine-K=F6nig wrote:
> > On Mon, May 06, 2024 at 03:43:47PM -0500, David Lechner wrote:
> >> Does not meet the criteria for stable.
> >=20
> > It was identified as a dependency of another patch. But I agree to
> > David, it should be trivial to back this patch out. If you need help,
> > please tell me.
> >=20
>=20
> The "fix" patch isn't something that should be backported to stable
> either, so we shouldn't need to do anything here other than drop
> the whole series from the stable queue.

Maybe it's just me, but for me backporting commit 0064db9ce4aa ("spi:
axi-spi-engine: fix version format string") looks sensible. (Or what do
you mean with "the \"fix\" patch"?) It's a small fix for a small
annoyance, but looks harmless enough that I'd tend to include it in
stable.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ybbp2rswycy36rqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmY6NcEACgkQj4D7WH0S
/k5dlQf/d8K+BKX+wDX01Ls4bEhbK7D0BKyMS/NdPvxwTj1Iv7t4KjutninAmnj4
2wlw3YDinQGBpqYOdz7VmiZVJu/B1mdjWRbirqareocttxmyZ6xEKUKVe9nZw7Du
b1b7JC47zaYpi/0kC2oIvJFNVA9RssRiuQo3gMU3GiJW7+RysjncQhCg65eo+nCb
mbhNrH0n2vV7xXoMIYOr38NJEW3VHqZbdqn3dly+EDPnAiXJnjLypfpU6c+wPR6E
j2/IufN2TZIVO89qEhkD9FXaFo2SpvuuAqOEJ6XUToQp/kvsufHsOaH6tdathYec
KOQUHXoXzG8QBUhqvTEaLIOyQuhqEA==
=Jo0l
-----END PGP SIGNATURE-----

--ybbp2rswycy36rqm--

