Return-Path: <stable+bounces-43117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1841A8BD165
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 17:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497C21C23E77
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 15:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADDC155A39;
	Mon,  6 May 2024 15:14:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50DF155A35
	for <stable@vger.kernel.org>; Mon,  6 May 2024 15:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715008489; cv=none; b=Nm6aoEoHpOuW2n3VVTtwDceatvd45lL7k92edazPIspVrYK2btvKrIWNJpOv8CKn5WPU0CZ6o+tixTZrEIL2DWMSTvhLop2VvHbI8hVF8U6ubyayXL+4NiJmVgNGsNxtdtEgCGPwWZYgfXPcgLW+AwWr4MI0slSSCi7KOqV2waI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715008489; c=relaxed/simple;
	bh=jgGBM1di0T0Mxh3GNCKZQk+nKLdzZaWHV4xpYN6qKrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+MZU7dG21H2TlsgU5M/c62EMvFCQ4GmJfMmhvf5tVHk2u/o4WH/VSfBAL1G/XSpjjsCkqtMYetWL1OhCn9UD9ET2HW5cgEAMIM6XF+8Qu+yx8q4t3Hs5GQakD0On0jarL7ffaN4ACDBvXgmO8oWQlA8fkf+9eim9buIRZuo1bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1s402l-0000sN-R5; Mon, 06 May 2024 17:14:19 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1s402j-00GHyB-Up; Mon, 06 May 2024 17:14:17 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 89ACC2CB730;
	Mon, 06 May 2024 15:14:17 +0000 (UTC)
Date: Mon, 6 May 2024 17:14:17 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vitor Soares <ivitro@gmail.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Thomas Kopp <thomas.kopp@microchip.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vitor Soares <vitor.soares@toradex.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4] can: mcp251xfd: fix infinite loop when xmit fails
Message-ID: <20240506-bronze-snake-of-imagination-1db027-mkl@pengutronix.de>
References: <20240506144918.419536-1-ivitro@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6xvopgmhifp6pdtd"
Content-Disposition: inline
In-Reply-To: <20240506144918.419536-1-ivitro@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org


--6xvopgmhifp6pdtd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 06.05.2024 15:49:18, Vitor Soares wrote:
> From: Vitor Soares <vitor.soares@toradex.com>
>=20
> When the mcp251xfd_start_xmit() function fails, the driver stops
> processing messages, and the interrupt routine does not return,
> running indefinitely even after killing the running application.
>=20
> Error messages:
> [  441.298819] mcp251xfd spi2.0 can0: ERROR in mcp251xfd_start_xmit: -16
> [  441.306498] mcp251xfd spi2.0 can0: Transmit Event FIFO buffer not empt=
y. (seq=3D0x000017c7, tef_tail=3D0x000017cf, tef_head=3D0x000017d0, tx_head=
=3D0x000017d3).
> ... and repeat forever.
>=20
> The issue can be triggered when multiple devices share the same
> SPI interface. And there is concurrent access to the bus.
>=20
> The problem occurs because tx_ring->head increments even if
> mcp251xfd_start_xmit() fails. Consequently, the driver skips one
> TX package while still expecting a response in
> mcp251xfd_handle_tefif_one().
>=20
> This patch resolves the issue by decreasing tx_ring->head and removing
> the skb from the echo stack if mcp251xfd_start_xmit() fails.
> Consequently, the package is dropped not been possible to re-transmit.
>=20
> Fixes: 55e5b97f003e ("can: mcp25xxfd: add driver for Microchip MCP25xxFD =
SPI CAN")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
> ---
> With this approach, some packages get lost in concurrent SPI bus access
> due to can_put_echo_skb() being called before mcp251xfd_tx_obj_write().
> The can_put_echo_skb() calls can_create_echo_skb() that consumes the orig=
inal skb
> resulting in a Kernel NULL pointer dereference error if return NETDEV_TX_=
BUSY on
> mcp251xfd_tx_obj_write() failure.
> A potential solution would be to change the code to use spi_sync(), which=
 would
> wait for SPI bus to be unlocked. Any thoughts about this?

This is not an option. I think you need a echo_skb function that does
the necessary cleanup, something like:

void can_remove_echo_skb(struct net_device *dev, unsigned int idx)
{
	struct can_priv *priv =3D netdev_priv(dev);

        priv->echo_skb[idx] =3D NULL;
}

I think you can open-code the "priv->echo_skb[idx] =3D NULL;" directly in
the driver.

And you have to take care of calling netdev_completed_queue(priv->ndev,
1, frame_len);

Another option would be to start a workqueue and use spi_sync() in case
the spi_async() is busy.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--6xvopgmhifp6pdtd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmY488UACgkQKDiiPnot
vG9FFggAit859fJ+935r7xsgkOImOZCO1B2qbEmNRJCx3IOcusNr1j74fL935i6a
0rAdqHU7qndcGynpBbClTarptUjDRy0OH7PS/WGhucNdwPpJqXat3uGqgMJw06WQ
EsDrS2iYiXCbj9rgcxl5EMaW7RSRz2mOzrAMkPzWtpIRxNetha+PKa9fDc9iEq01
5J+8DlRIa4tMgy1Y1OOEkHvObg8iVg55e1v1+MKJ2wti/WS7dvU0m/QEwbPqXre+
k+TozqXogUNIMA8BuVwhrKjtfxQyCyyk9SIt+aLsXt8PwgvQTab3hiEwkd6B5B53
NPURQbFDCPVvTKX0aiJpchxMHCCZ2g==
=/BDM
-----END PGP SIGNATURE-----

--6xvopgmhifp6pdtd--

