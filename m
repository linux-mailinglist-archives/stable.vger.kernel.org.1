Return-Path: <stable+bounces-124415-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B907A60C41
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 09:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48892189A7AC
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 08:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962071DDC14;
	Fri, 14 Mar 2025 08:53:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F4F1DA617
	for <stable@vger.kernel.org>; Fri, 14 Mar 2025 08:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741942418; cv=none; b=obXG+nLWLCFHbapcJbH+Yo0btQ1DIaaKvIAk4e6C19lA5aBmVXzkK+9kMJMbvK5kucVmvNLIxlbdEdMuoT+J2S+sA+BjGdh87nL9b/E07nO9gCH4Bqs17n1lZTHgZ24StEwM1HoKg8QGvjqkE4vrgBKcJqTAbbWcTXbT3T/rGbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741942418; c=relaxed/simple;
	bh=LG+zWUiU+YDS4u7udi6xwwIRvt4cLa8ZSYa7+ZaV17I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+KppL6PlgWiBxoHWx7b87Ht9noqjdYZeeX51uw+SyzZX4TiMRTCMXgVej2WASYL1qpBa016jO/yGJAzASgPrEVq+QS0Pf7jt9UO7G4VX6PMB+VUc/Yb8hh5wkNxnP+Ife9luEYO1GMcGoLv9E0GagfKH9sF/w/G3hvbMBLEgvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tt0n5-0007tf-7y; Fri, 14 Mar 2025 09:53:15 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tt0n3-005fmP-13;
	Fri, 14 Mar 2025 09:53:13 +0100
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id EB3603DB854;
	Fri, 14 Mar 2025 08:53:12 +0000 (UTC)
Date: Fri, 14 Mar 2025 09:53:12 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Duy Nguyen <duy.nguyen.rh@renesas.com>, Simon Horman <horms@kernel.org>, stable@vger.kernel.org, 
	linux-can@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH v3 0/2] R-Car CANFD fixes
Message-ID: <20250314-coyote-of-inspiring-perception-9f5089-mkl@pengutronix.de>
References: <20250307170330.173425-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sfhcrqzzuf5ym3x3"
Content-Disposition: inline
In-Reply-To: <20250307170330.173425-1-biju.das.jz@bp.renesas.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org


--sfhcrqzzuf5ym3x3
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 0/2] R-Car CANFD fixes
MIME-Version: 1.0

On 07.03.2025 17:03:25, Biju Das wrote:
> This patch series addresses 2 issues
>  1) Fix typo in pattern properties for R-Car V4M.
>  2) Fix page entries in the AFL list.
>=20
> v2->v3:
>  * Collected tags.
>  * Dropped unused variables cfg and start from
>    rcar_canfd_configure_afl_rules().
> v1->v2:
>  * Split fixes patches as separate series.
>  * Added Rb tag from Geert for binding patch.
>  * Added the tag Cc:stable@vger.kernel.org
>=20
> Biju Das (2):
>   dt-bindings: can: renesas,rcar-canfd: Fix typo in pattern properties
>     for R-Car V4M
>   can: rcar_canfd: Fix page entries in the AFL list
>=20
>  .../bindings/net/can/renesas,rcar-canfd.yaml  |  2 +-
>  drivers/net/can/rcar/rcar_canfd.c             | 28 ++++++++-----------
>  2 files changed, 12 insertions(+), 18 deletions(-)

Applied to linux-can.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--sfhcrqzzuf5ym3x3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmfT7nYACgkQDHRl3/mQ
kZyQcQf9GCCP/HKTjBxyq7lVtcXFI0SYyIzqN2BocqvkOk+LX8jiBhabI2Dj3LLi
Kxuv4HZRFDTf9zQXa690wOcWtBnRBKxDb+jXFBZY7lEnH59WhJlH1FVX7GkFOtmx
cbDqwS/nrzW2VH2w7+wLlgsyQvcKycB9VvxO6lQvbgqSltageE/Jl45e9aquCY7l
GhZjcVMltZhy0jA6IVqGpjicXYESfrZYYD+H7fJ3xo7tDIVdG/LdvSx3x71/+/Ct
dALlcctsLVAEqh26BrpbIMv0hed5QZUFXbDRla5D5z/rRswkPsioqJMkPGfhGMB5
e1V95RJmMYEelyf3EsO1mxs25dtC/Q==
=SXcH
-----END PGP SIGNATURE-----

--sfhcrqzzuf5ym3x3--

