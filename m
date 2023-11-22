Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545CB7F52AA
	for <lists+stable@lfdr.de>; Wed, 22 Nov 2023 22:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjKVVf2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 22 Nov 2023 16:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjKVVf2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 22 Nov 2023 16:35:28 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688F6191
        for <stable@vger.kernel.org>; Wed, 22 Nov 2023 13:35:24 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r5usT-0007yE-2I; Wed, 22 Nov 2023 22:35:21 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r5usR-00AtmJ-VP; Wed, 22 Nov 2023 22:35:19 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r5usR-0061eg-MK; Wed, 22 Nov 2023 22:35:19 +0100
Date:   Wed, 22 Nov 2023 22:35:19 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     gregkh@linuxfoundation.org
Cc:     alim.akhtar@samsung.com, bhelgaas@google.com,
        stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] PCI: exynos: Don't discard .remove()
 callback" failed to apply to 5.10-stable tree
Message-ID: <20231122213519.mynzhbfow44py5ie@pengutronix.de>
References: <2023112207-dealmaker-frigidly-e080@gregkh>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7gus3c23m5ufkikx"
Content-Disposition: inline
In-Reply-To: <2023112207-dealmaker-frigidly-e080@gregkh>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


--7gus3c23m5ufkikx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 08:06:08PM +0000, gregkh@linuxfoundation.org wrote:
>=20
> The patch below does not apply to the 5.10-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>=20
> To reproduce the conflict and resubmit, you may use the following command=
s:
>=20
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-5.10.y
> git checkout FETCH_HEAD
> git cherry-pick -x 83a939f0fdc208ff3639dd3d42ac9b3c35607fd2
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112207-=
dealmaker-frigidly-e080@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..
>=20
> Possible dependencies:
>=20
> 83a939f0fdc2 ("PCI: exynos: Don't discard .remove() callback")
> 778f7c194b1d ("PCI: dwc: exynos: Rework the driver to support Exynos5433 =
variant")
> b9ac0f9dc8ea ("PCI: dwc: Move dw_pcie_setup_rc() to DWC common code")
> 59fbab1ae40e ("PCI: dwc: Move dw_pcie_msi_init() into core")
> 886a9c134755 ("PCI: dwc: Move link handling into common code")
> 331e9bcead52 ("PCI: dwc: Drop the .set_num_vectors() host op")
> a0fd361db8e5 ("PCI: dwc: Move "dbi", "dbi2", and "addr_space" resource se=
tup into common code")
>=20
> thanks,
>=20
> greg k-h
>=20
> ------------------ original commit in Linus's tree ------------------
> With CONFIG_PCI_EXYNOS=3Dy and exynos_pcie_remove() marked with __exit, t=
he
> function is discarded from the driver. In this case a bound device can
> still get unbound, e.g via sysfs. Then no cleanup code is run resulting in
> resource leaks or worse.
>=20
> The right thing to do is do always have the remove callback available.
> This fixes the following warning by modpost:
>=20
>   WARNING: modpost: drivers/pci/controller/dwc/pci-exynos: section mismat=
ch in reference: exynos_pcie_driver+0x8 (section: .data) -> exynos_pcie_rem=
ove (section: .exit.text)
>=20
> (with ARCH=3Dx86_64 W=3D1 allmodconfig).
>=20
> Fixes: 340cba6092c2 ("pci: Add PCIe driver for Samsung Exynos")

Actually this is wrong. The right Fixes: line would have been:

Fixes: 778f7c194b1d ("PCI: dwc: exynos: Rework the driver to support Exynos=
5433 variant")

which entered the mainline in v5.11-rc1, so not backporting it to 5.10
and older stables is the right thing to do.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7gus3c23m5ufkikx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVedBYACgkQj4D7WH0S
/k6uwQf/dzZS9+75wyo9s3wjj3xbsPWMTEmUcGvJV0F8svjYTWBgaS2xTLfeNmZI
oIXA92JVvh3JP/Yp9kguUTtQm+NGAtjbfs6hBGOEq5Kqgo7c09rpbtk81cw9rYpH
F9PSYlThM7t3lkT/EbKY1rD/OaPENXH12mV2eRQrj9d95sgMA+P3RP30w/1SeWfp
+mKdSUq2WsuAsv0sUeJr42KWr4SQ56lU2CN3OZarAUWSRBmKdf6qVOsolQmlWfPu
QzmdbbBB1k4xz64+TUFZgf5cJPlI9CixZyxBe/0rPqGc+cAXKJ5ZWM7lzb885zof
pav4SbCcbOV1+13z376kZHWcokkFMw==
=9A4F
-----END PGP SIGNATURE-----

--7gus3c23m5ufkikx--
