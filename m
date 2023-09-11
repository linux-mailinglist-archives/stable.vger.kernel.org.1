Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B6D79BC2E
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345772AbjIKVWQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240528AbjIKOqj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:46:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0495125
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:46:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC53C433C9;
        Mon, 11 Sep 2023 14:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694443594;
        bh=2It49KItNZGBnAorNowsZeS4iwuYO9L2hV6pvsJvszA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NkAg1tzb/9uZaTFlE04bCiT6OaXYypB8331BVaJFAGVRQLOUcbpdYpsleSgWQtfJc
         07b3cURxWtwR0QkR5jdJcVWELUSvohYNZz/d507EpYOsglWqsbXn+FhLQoqu5lsW/t
         B3b3vc1SYXN/kvzjsffljACYu1z4nYeC5mnSxmNITaBGgSA5CPLTsfy8+AbOX8tTup
         +Ns+tNMR61lPhlKG0UP/YHFHCrpYkFByLXZJH91YI/kDw/NJY8be8tBLX3R187RwRJ
         564cXIGd9oy6Xbs0CpcNAY/Pn2uQ9W70eIjF/6+W8QOBpHOdjlD+7cya1vKkvwQack
         aUnNdVGxE4+LQ==
Date:   Mon, 11 Sep 2023 15:46:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.5 363/739] ASoC: pxa: merge DAI call back functions
 into ops
Message-ID: <ZP8oR4nDRDpsxLkM@finisterre.sirena.org.uk>
References: <20230911134650.921299741@linuxfoundation.org>
 <20230911134701.287984009@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5v/l/Hft6U+bbW2F"
Content-Disposition: inline
In-Reply-To: <20230911134701.287984009@linuxfoundation.org>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


--5v/l/Hft6U+bbW2F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2023 at 03:42:42PM +0200, Greg Kroah-Hartman wrote:
> 6.5-stable review patch.  If anyone has any objections, please let me kno=
w.
>=20
> ------------------
>=20
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> [ Upstream commit 98e268a7205706f809658345399eead7c7d1b8bb ]
>=20
> ALSA SoC merges DAI call backs into .ops.
> This patch merge these into one.

This is obviously not stable material.

--5v/l/Hft6U+bbW2F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmT/KEYACgkQJNaLcl1U
h9COUQf+MF3nbU2r8UK2CM96oFjdqSlUoHmBa8VoOcSLGy8SpkLj27B9bUQkGluL
dq/R92rTs1QwJTXNzGZPAsl2Rz9qoYCNBFrgG98ZX8jfPJGl9PrZG8ca954wQhfx
68KIB5cgT+2OXuTzSFQNY3lEQWE3q5PESwmh3u3/nQKWQlHgsl3ICKtARhUBEOwe
bBeyFPTXrpGQywLQiueZnACxnXkpGyBciUhGDv0YVtYHteCVv3OAArKgS8VRNpwm
1/MstCluKhA5Lce59aN2tN+yxEAJG34I96HK9J2lmc9GCUDy7A84gbaSe9wJwAU6
4OV4WNzRgFnZilt+QxkrgzqEExFNXA==
=kBHO
-----END PGP SIGNATURE-----

--5v/l/Hft6U+bbW2F--
