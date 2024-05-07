Return-Path: <stable+bounces-43162-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC1A8BDB34
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 08:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBE5F1F2517A
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 06:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4396F505;
	Tue,  7 May 2024 06:14:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB366F08E
	for <stable@vger.kernel.org>; Tue,  7 May 2024 06:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715062445; cv=none; b=Qac+nNetkG1ynWRzGayEGFBxrDXjEimi9AM04PGMTes0oyvt9fsI3HgbMdtNpFeY8/ueUIAl7HOrU6mnR+2J7qaSosHnRTbvNbzBccgt8pd095EwTmWuq0GMXjjbkYoj5fJ41wMD7wwjONkgVvCferqzOi5jrnfyaR1nOaRqnsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715062445; c=relaxed/simple;
	bh=GPWjKdirB7629q7V+10hJwf8/ObSz24j7C9OV4mHhPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9Vi69BXHo1ZeYGZk+Tv6+6Rd7HzyuN5tu3rqu2dDcBcZ5PJ7mjkyC7iZE9xCaPRicuiCAjhhU/dxCsBQ7ODtyf/iCAsRA8LJsquTd4z2yT9dc3o5iCiwM9icHoi8HmQXbRBD/IfCDtBLGjsUBlIPTw0E6auk/2d/YWgHcVgXsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1s4E5Q-0003wx-Md; Tue, 07 May 2024 08:14:00 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1s4E5P-0002vS-Bj; Tue, 07 May 2024 08:13:59 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1s4E5P-00H9K2-0u;
	Tue, 07 May 2024 08:13:59 +0200
Date: Tue, 7 May 2024 08:13:59 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: David Lechner <dlechner@baylibre.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org, 
	Michael Hennerich <michael.hennerich@analog.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Mark Brown <broonie@kernel.org>
Subject: Re: Patch "spi: axi-spi-engine: Convert to platform remove callback
 returning void" has been added to the 6.1-stable tree
Message-ID: <xoadzhyfsjcmvrolb7smsjsvvhfb67m6rcata7sox54yeqm54n@neow3nvsxcti>
References: <20240506193007.271745-1-sashal@kernel.org>
 <668fcb3c-d00c-4082-b55d-c8584f1b3f7a@baylibre.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="epjpwzes5w6i7m3k"
Content-Disposition: inline
In-Reply-To: <668fcb3c-d00c-4082-b55d-c8584f1b3f7a@baylibre.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org


--epjpwzes5w6i7m3k
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, May 06, 2024 at 03:43:47PM -0500, David Lechner wrote:
> Does not meet the criteria for stable.

It was identified as a dependency of another patch. But I agree to
David, it should be trivial to back this patch out. If you need help,
please tell me.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--epjpwzes5w6i7m3k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmY5xqEACgkQj4D7WH0S
/k6GJwf/SUPmCwGd/jefUWr5lE8Xn483F7HTy60MXQSd5AxzTwVR86l+4Bh884JL
KcgIkm+Kbw8QjwTAX627vvct0WwA12h8c94YVoHnWuBbUhHODCIVOzKkn+qLFDoI
we89apvjKzYt7I6gvXbPvtiixh3dq9uf8vk5QuPb3LTPX8ITIq1F1gLff3dMYA9A
KvqycjjaVv+qsoxyv8NcQRhw96wu85g58p2Fw1i5oDnJnfYlvkKTKoJ8bSIA+yha
2tggQ3WVywo24gVDFpZ1p9/NMCYExqSen7uPMmm2nRWXyj24/+SVEcZhIwnfTNx8
QpXBocnJnR7doo8k/G2iithAfegxLQ==
=5/v7
-----END PGP SIGNATURE-----

--epjpwzes5w6i7m3k--

