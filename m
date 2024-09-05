Return-Path: <stable+bounces-73129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4985696CF21
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 08:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B46B21F25394
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 06:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312B518A6CF;
	Thu,  5 Sep 2024 06:24:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD751898EB
	for <stable@vger.kernel.org>; Thu,  5 Sep 2024 06:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725517473; cv=none; b=Un/mjIhrrY1xujoRfRf/MI7uRdDYk4WXC1YO0QlZf+0DeCVAz9I6A+SLS//5bfoJnHLv7OaknK2arbddCi3zKWJyiXl9Jt0pXcqaE2Ujv/QhVP6OLIYTXNzRXfgMzSSpuXFwLFaZY5OErJBFYNJbpjzQvkVJzJoZdxfu+T2J7Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725517473; c=relaxed/simple;
	bh=U31ifcW1zCYkk+mQ1FZjKYpJy+llLB4fiw1S/WBEkCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=boKOCr2aSoJnhA7hOhWhiXi68Vgi7QKT6YaElpEZBVv0DOvc2CcNbHRnp57eLiFt20pM1qaGWbjkqFS77gNbAU0GZAsBVDqklc+Q4knTSzYKTW70KV0GKIWRNvBaS2pi8Nz+s2AeUPfjPS1GWBr93sYsugAu6oL4vfAK13qO7X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sm5uj-0008SY-Pt; Thu, 05 Sep 2024 08:24:17 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sm5ui-005daQ-Sp; Thu, 05 Sep 2024 08:24:16 +0200
Received: from pengutronix.de (pd9e5994e.dip0.t-ipconnect.de [217.229.153.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 84667333088;
	Thu, 05 Sep 2024 06:24:16 +0000 (UTC)
Date: Thu, 5 Sep 2024 08:24:15 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stefan =?utf-8?B?TcOkdGpl?= <stefan.maetje@esd.eu>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Frank Jungclaus <frank.jungclaus@esd.eu>, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] can: esd_usb: Remove CAN_CTRLMODE_3_SAMPLES for
 CAN-USB/3-FD
Message-ID: <20240905-apricot-lionfish-of-philosophy-183c7e-mkl@pengutronix.de>
References: <20240904222740.2985864-1-stefan.maetje@esd.eu>
 <20240904222740.2985864-2-stefan.maetje@esd.eu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xvlldxndayfojpdl"
Content-Disposition: inline
In-Reply-To: <20240904222740.2985864-2-stefan.maetje@esd.eu>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org


--xvlldxndayfojpdl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 05.09.2024 00:27:40, Stefan M=C3=A4tje wrote:
> Remove the CAN_CTRLMODE_3_SAMPLES announcement for CAN-USB/3-FD devices
> because these devices don't support it.
>=20
> The hardware has a Microchip SAM E70 microcontroller that uses a Bosch
> MCAN IP core as CAN FD controller. But this MCAN core doesn't support
> triple sampling.
>=20
> Fixes: 80662d943075 ("can: esd_usb: Add support for esd CAN-USB/3")
> Cc: stable@vger.kernel.org
> Signed-off-by: Stefan M=C3=A4tje <stefan.maetje@esd.eu>

Applied to linux-can.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--xvlldxndayfojpdl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbZTosACgkQKDiiPnot
vG+S/wf/UZZmMUVspBBw7nyBTivsUaIMl3+6v7uSUHbxNxE/ynJCCrsMfBRHNO8N
EAaTSmb4j3qo3txc9JybM6h/EDQ8RZLgyTx9OyNyXSguK33sLDrC6/s+jZv00H4f
Hbxmnt7YrD+PETqUD9qNzrIC15p1GITmJJsLVay7TAURdzwQzIY/wWdHyWcaE4s4
mTMjs7JcIeORWHT+c6P8ua8osFoXEKPF4Uo+2mWcUJiQ3GEfUPjZBD3JFJLuVTuL
szpAd/4C6/u0GtNAGotXf5WPtRT+eWqDRiOjiKlb5uz9PY0y3MnjKf30FH9ZQBK7
S9PqJJ05Q0sZpLaii3uL4rP8vGtKWg==
=mRIA
-----END PGP SIGNATURE-----

--xvlldxndayfojpdl--

