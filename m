Return-Path: <stable+bounces-227955-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDa8OV4fwWmTQwQAu9opvQ
	(envelope-from <stable+bounces-227955-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 12:09:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 623902F0E56
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 12:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F61E305384B
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 11:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F74392828;
	Mon, 23 Mar 2026 11:01:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC0E3932F3
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 11:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774263673; cv=none; b=FIiF80v9AVyusbSn1pF70b9QZzabOhd3jnFU+QpyUCRAksmEL2HVQNfg9S3Y3QXSdLDw/FWMK5CXEFAhp5S7xNdVZyleuG/VUDB//1tsy8RxE1dzcwPZHSS5+zrIvRQWumCYxV1fJMiBv4z1yNJmLS+TzedBkoZZEuyqOVXR51U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774263673; c=relaxed/simple;
	bh=xiMy2n0h2WpsAoBsk50jpY36hluSHQTq+ZP6gM04BK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLDTGPxBy2U47z6rIaa38fO7KgPHPROVcKkX9Hli1QRBsGQfuTi5mH/UqLtn2d2HD7bKl/FJPyPJLR5lVyrvY/ElgsbmwMGcV4vrVbUWZk8TP3wpIk3nSQz28mGTRQLEelUTq+xr9ya4lGK9dg4SG8pJi290LymkZnG7cyOfh0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w4d1o-0003tW-SV; Mon, 23 Mar 2026 12:01:00 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w4d1o-001iEY-0z;
	Mon, 23 Mar 2026 12:01:00 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 00B8E50A88E;
	Mon, 23 Mar 2026 11:00:59 +0000 (UTC)
Date: Mon, 23 Mar 2026 12:00:59 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Johan Hovold <johan@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Heiko Stuebner <heiko@sntech.de>, 
	Laxman Dewangan <ldewangan@nvidia.com>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 1/5] spi: imx: fix use-after-free on unbind
Message-ID: <20260323-demonic-worthy-guillemot-c2abb8-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260323104948.844583-1-johan@kernel.org>
 <20260323104948.844583-2-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ljhv27eikzb6qhcw"
Content-Disposition: inline
In-Reply-To: <20260323104948.844583-2-johan@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227955-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,stable@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,pengutronix.de:email,pengutronix.de:mid,pengutronix.de:url]
X-Rspamd-Queue-Id: 623902F0E56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--ljhv27eikzb6qhcw
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/5] spi: imx: fix use-after-free on unbind
MIME-Version: 1.0

On 23.03.2026 11:49:44, Johan Hovold wrote:
> The SPI subsystem frees the controller and any subsystem allocated
> driver data as part of deregistration (unless the allocation is device
> managed).
>
> Take another reference before deregistering the controller so that the
> driver data is not freed until the driver is done with it.

Would re-ordering the spi_imx_remove() function be an alternative fix?
I.e. call spi_unregister_controller() last?

regards,
Marc

>
> Fixes: 307c897db762 ("spi: spi-imx: replace struct spi_imx_data::bitbang =
by pointer to struct spi_controller")
> Cc: stable@vger.kernel.org	# 5.19
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/spi/spi-imx.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 64c6c09e1e7b..a8d90c86a8a1 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -2401,6 +2401,8 @@ static void spi_imx_remove(struct platform_device *=
pdev)
>  	struct spi_imx_data *spi_imx =3D spi_controller_get_devdata(controller);
>  	int ret;
>
> +	spi_controller_get(controller);
> +
>  	spi_unregister_controller(controller);
>
>  	ret =3D pm_runtime_get_sync(spi_imx->dev);
> @@ -2414,6 +2416,8 @@ static void spi_imx_remove(struct platform_device *=
pdev)
>  	pm_runtime_disable(spi_imx->dev);
>
>  	spi_imx_sdma_exit(spi_imx);
> +
> +	spi_controller_put(controller);
>  }
>
>  static int spi_imx_runtime_resume(struct device *dev)
> --
> 2.52.0
>
>

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ljhv27eikzb6qhcw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCacEdaQAKCRDMOmT6rpmt
0vdmAQDl2tOYzInI6kiatpAaexhYpTZll2Fs6FunvhoKrocdHgD/Wg1W8ppiIlVs
ZGFsRytoRorexXMxURMC2/DM0/D/EgI=
=arGX
-----END PGP SIGNATURE-----

--ljhv27eikzb6qhcw--

