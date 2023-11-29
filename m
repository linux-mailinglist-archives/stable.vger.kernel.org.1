Return-Path: <stable+bounces-3136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFFD7FD322
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 10:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55B3D282F9D
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 09:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC23618AE9;
	Wed, 29 Nov 2023 09:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3966D6C
	for <stable@vger.kernel.org>; Wed, 29 Nov 2023 01:48:07 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r8HAn-0005C2-Mc; Wed, 29 Nov 2023 10:48:01 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r8HAn-00CNFM-9p; Wed, 29 Nov 2023 10:48:01 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r8HAn-00AkYx-0R; Wed, 29 Nov 2023 10:48:01 +0100
Date: Wed, 29 Nov 2023 10:48:00 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Nathan Chancellor <nathan@kernel.org>
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, bhelgaas@google.com,
	llvm@lists.linux.dev, stable@vger.kernel.org,
	Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH 5.10] PCI: keystone: Drop __init from
 ks_pcie_add_pcie_{ep,port}()
Message-ID: <20231129094800.7uxfxx7h2sa4p5an@pengutronix.de>
References: <20231128-5-10-fix-pci-keystone-modpost-warning-v1-1-43240045c516@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5lyitvpr4ipbhqge"
Content-Disposition: inline
In-Reply-To: <20231128-5-10-fix-pci-keystone-modpost-warning-v1-1-43240045c516@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org


--5lyitvpr4ipbhqge
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 05:37:00PM -0700, Nathan Chancellor wrote:
> This commit has no upstream equivalent.
>=20
> After commit db5ebaeb8fda ("PCI: keystone: Don't discard .probe()
> callback") in 5.10, there are two modpost warnings when building with

As with the 5.4 patch:

s/5.10/5.10.202/

> clang:
>=20
>   WARNING: modpost: vmlinux.o(.text+0x5aa6dc): Section mismatch in refere=
nce from the function ks_pcie_probe() to the function .init.text:ks_pcie_ad=
d_pcie_port()
>   The function ks_pcie_probe() references
>   the function __init ks_pcie_add_pcie_port().
>   This is often because ks_pcie_probe lacks a __init
>   annotation or the annotation of ks_pcie_add_pcie_port is wrong.
>=20
>   WARNING: modpost: vmlinux.o(.text+0x5aa6f4): Section mismatch in refere=
nce from the function ks_pcie_probe() to the function .init.text:ks_pcie_ad=
d_pcie_ep()
>   The function ks_pcie_probe() references
>   the function __init ks_pcie_add_pcie_ep().
>   This is often because ks_pcie_probe lacks a __init
>   annotation or the annotation of ks_pcie_add_pcie_ep is wrong.
>=20
> ks_pcie_add_pcie_ep() was removed in upstream commit a0fd361db8e5 ("PCI:
> dwc: Move "dbi", "dbi2", and "addr_space" resource setup into common
> code") and ks_pcie_add_pcie_port() was removed in upstream
> commit 60f5b73fa0f2 ("PCI: dwc: Remove unnecessary wrappers around
> dw_pcie_host_init()"), both of which happened before upstream
> commit 7994db905c0f ("PCI: keystone: Don't discard .probe() callback").
>=20
> As neither of these removal changes are really suitable for stable, just
> remove __init from these functions in stable, as it is no longer a
> correct annotation after dropping __init from ks_pcie_probe().
>=20
> Fixes: db5ebaeb8fda ("PCI: keystone: Don't discard .probe() callback")
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--5lyitvpr4ipbhqge
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVnCNAACgkQj4D7WH0S
/k5/oQf+MaA9j1Lx1QDq4jCwPrh4diaezdqjOJq5gKdZeryh0VqNp8qtOY1cE+kp
MF0VH18Dl3sAojrC3sBaCu6Izv05Gh5SpMuijZaIJ2Wao395PEZJcMlJ48It27hZ
JWPHDljULnJrme7L1o0ne/E4f8x2O6xNohRAapwkgI9/w/8FJmwzpAynIFXg/5tL
/uxCmjdGSJwCEODLqu1a51tq8y/aFs65fsjBqpPj5LYeIOdqIhe0cb3fXZLHmttL
IUNjUVpbmBKCe8wF7yb5Uhkmjq2g3fVv945M4p5e4hlqdz+Z1x9IBqAIIs041giI
hLORDKOUNq2IzMzvxMuUXr027jF7tg==
=Ux+x
-----END PGP SIGNATURE-----

--5lyitvpr4ipbhqge--

