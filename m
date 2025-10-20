Return-Path: <stable+bounces-188138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 60461BF21C8
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 17:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2730B4FB572
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5028926981E;
	Mon, 20 Oct 2025 15:26:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1AD1D7999
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 15:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760974019; cv=none; b=smptHa4GpSrq9bXXnVD8ksEOJdjRMsEXUALaT/QG0k8F7YQ2dRt00KNjcvEOJ1zT1Ztka7f4/0u10wGJKsCDiQJVcWrFVLrYHVPGo2QSo77W2aK5Be7rSjm83S2RazFczTchDgYeIHo9QqYZMWrDRSSfxXmj9aoe6DszN7DT7BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760974019; c=relaxed/simple;
	bh=vPL+q/vk+gg2Stp2ZUVK2Nu5mtP+IFMSjWR997aw3oE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7tk7wtQ5/1ozLZWiT9f4gcCS/I67SltbrVwul0df22hnhZQo8W8WYst2suQCiThl6FOdmIWmRiajvroKMTOfVU+XXWCFNTXURzRTwFOT3tAYQIa4G9I8+Iq3Sf5dRoo4w+uNu6Q88ZqAQkw/JsMZsZsyqvRksP3QJOMcaU2HWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vArme-0005as-Fn; Mon, 20 Oct 2025 17:26:52 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vArme-004ZUd-0k;
	Mon, 20 Oct 2025 17:26:52 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id F2B4348B5B7;
	Mon, 20 Oct 2025 15:26:51 +0000 (UTC)
Date: Mon, 20 Oct 2025 17:26:50 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Andrei Lalaev <andrey.lalaev@gmail.com>
Subject: Re: [PATCH can] can: netlink: can_changelink(): allow disabling of
 automatic restart
Message-ID: <20251020-gigantic-jovial-mastiff-cb8d0d-mkl@pengutronix.de>
References: <20251020-netlink-fix-restart-v1-1-3f53c7f8520b@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sjgy3rx7vga7lvbm"
Content-Disposition: inline
In-Reply-To: <20251020-netlink-fix-restart-v1-1-3f53c7f8520b@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org


--sjgy3rx7vga7lvbm
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can] can: netlink: can_changelink(): allow disabling of
 automatic restart
MIME-Version: 1.0

On 20.10.2025 13:34:42, Marc Kleine-Budde wrote:
> Since the commit c1f3f9797c1f ("can: netlink: can_changelink(): fix NULL
> pointer deref of struct can_priv::do_set_mode"), the automatic restart
> delay can only be set for devices that implement the restart handler stru=
ct
> can_priv::do_set_mode. As it makes no sense to configure a automatic
> restart for devices that doesn't support it.
>=20
> However, since systemd commit 13ce5d4632e3 ("network/can: properly handle
> CAN.RestartSec=3D0") [1], systemd-networkd correctly handles a restart de=
lay
> of "0" (i.e. the restart is disabled). Which means that a disabled restart
> is always configured in the kernel.
>=20
> On systems with both changes active this causes that CAN interfaces that
> don't implement a restart handler cannot be brought up by systemd-network=
d.
>=20
> Solve this problem by allowing a delay of "0" to be configured, even if t=
he
> device does not implement a restart handler.
>=20
> [1] https://github.com/systemd/systemd/commit/13ce5d4632e395521e6205c9544=
93c7fc1c4c6e0
>=20
> Cc: stable@vger.kernel.org
> Cc: Andrei Lalaev <andrey.lalaev@gmail.com>
> Reported-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Closes: https://lore.kernel.org/all/20251020-certain-arrogant-vole-of-sun=
shine-141841-mkl@pengutronix.de
> Fixes: c1f3f9797c1f ("can: netlink: can_changelink(): fix NULL pointer de=
ref of struct can_priv::do_set_mode")
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Applied to linux-can.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--sjgy3rx7vga7lvbm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmj2VLcACgkQDHRl3/mQ
kZw5RAgAjdw8+lPMF2fLPP05DKR/FCNIvJrujgSopNVkuBLpNBl6ojzCHhauTRQ8
TplZgZZiXjQwB3VyR3LKmLqKtwJOcw2wtidyLOS6YEr3XI9rw5e5KenWURoclH15
U2NiKGcepNb9TPsWCNjY2sj8O9zj6UPy/XeWYdBrSxc6ut17X0897UTAE5uINwq+
Y3E0wxwMQfgCiAafddik7B7IvDKSjZys87/vHeY7EFuaLoameRxNoRfY8ZtYqILM
MeE0JpmASzMOEfY09dHH5NbffxIYgontrEcW8njbPgLv2iK1MIJ4dH8ghsmSXPYL
SoN3br2eUaaVxyIesdAcKmQw0ZVDFA==
=szio
-----END PGP SIGNATURE-----

--sjgy3rx7vga7lvbm--

