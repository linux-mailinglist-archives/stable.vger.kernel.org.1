Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8830770A887
	for <lists+stable@lfdr.de>; Sat, 20 May 2023 16:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjETOk0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 20 May 2023 10:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjETOkZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 20 May 2023 10:40:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58854115
        for <stable@vger.kernel.org>; Sat, 20 May 2023 07:40:23 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q0Nkr-0000nv-M2; Sat, 20 May 2023 16:40:21 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q0Nkp-001Ytj-Pd; Sat, 20 May 2023 16:40:19 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q0Nko-006IeT-Ud; Sat, 20 May 2023 16:40:18 +0200
Date:   Sat, 20 May 2023 16:40:18 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc:     stable-commits@vger.kernel.org, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: Patch "iommu/arm-smmu: Drop if with an always false condition"
 has been added to the 6.3-stable tree
Message-ID: <20230520144018.h6qqwvnsldawu4kx@pengutronix.de>
References: <20230520014938.2798196-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="evf6xr4666n7b3me"
Content-Disposition: inline
In-Reply-To: <20230520014938.2798196-1-sashal@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


--evf6xr4666n7b3me
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, May 19, 2023 at 09:49:37PM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
>=20
>     iommu/arm-smmu: Drop if with an always false condition
>=20
> to the 6.3-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>=20
> The filename of the patch is:
>      iommu-arm-smmu-drop-if-with-an-always-false-conditio.patch
> and it can be found in the queue-6.3 subdirectory.
>=20
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

I'd not add that patch to stable. It's just about dropping an

	if (false) {
		something();
	}

The compiler probably isn't able to see that the condition is always
false, so the only benefit is that the patch makes the compiled code a
bit smaller.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--evf6xr4666n7b3me
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmRo29IACgkQj4D7WH0S
/k5fFggArD0Zr9RzqV30Bq+j0n2YKq7fpDn5GvIzL8YKDDv9a7gj//9IcwZigH+d
cLNTWPOqHxrWSOFbwMRfqg6Q6v44wtFI3sf4oc37IyGaPe6D9lhIpU4dKIw2IVje
NahEdiX6VkY2tb2P2QoXOM/ukrOFIAXrBDqrIkoAUKTfXYmOuHz26dLZ73F8lyvP
eLQKNwJBaJy24JDLyObrlFbAGryZGuSjO8utC9FT2FrHciqcTwamhF3zVweKqWMT
6CaftGErtWe/xUQMB87o1BGUBk4/zHMXLBDuvLMZ5Wxza1Bm5Zt6Mh24gC3mvEVf
l8tnmqSWDH+rz1C0PwzmaCurh2+I2A==
=opvh
-----END PGP SIGNATURE-----

--evf6xr4666n7b3me--
