Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F62979B0C5
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345790AbjIKVWS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240513AbjIKOqU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:46:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9991A2
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:46:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C17C433C9;
        Mon, 11 Sep 2023 14:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694443575;
        bh=Yjy7YKH01ftiFG/yiJlX3AH4v3ZdRvafhPr0P1WBvSg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MID2frJC39GI+1A4q24BA3/gwjo7O6Eomiz5WGAeBJJRuHYkpqc1J+/M9xrf8kIzk
         JwGofPvfE13r7LIc8zjvY2nmSghts9r80HkJpNwEC0unxnK5Z8hhyHjoSEkVDb+2fX
         H0GEJ/kSaar2Yu9xN2aGqjIy1V1JDnP/zXprhSKRImTqTzUnzx4iXCNP5jUCXfAifA
         JvHqJGrpG3tyYUmb0uPXQEuay1oI+CabdN3MWAiu+Vn05yGpm1BXv+q4JUY73y2DNV
         x1LWnLfGT3v9jZZO2mFjK296jYd0KyVPWb6GiD7/+0fEIDiHN0AzeCF/ZYLvxnamgg
         i8GkyXw2sEt8Q==
Date:   Mon, 11 Sep 2023 15:46:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.5 364/739] ASoC: soc-dai.h: merge DAI call back
 functions into ops
Message-ID: <ZP8oM04ucZJkxXCS@finisterre.sirena.org.uk>
References: <20230911134650.921299741@linuxfoundation.org>
 <20230911134701.316565214@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uXgq1JfM9v+Ln2ex"
Content-Disposition: inline
In-Reply-To: <20230911134701.316565214@linuxfoundation.org>
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


--uXgq1JfM9v+Ln2ex
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2023 at 03:42:43PM +0200, Greg Kroah-Hartman wrote:
> 6.5-stable review patch.  If anyone has any objections, please let me kno=
w.
>=20
> ------------------
>=20
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> [ Upstream commit 3e8bcec0787d1a73703c915c31cb00a2fd18ccbf ]
>=20
> snd_soc_dai_driver has .ops for call back functions (A), but it also
> has other call back functions (B). It is duplicated and confusable.


> Signed-off-by: Mark Brown <broonie@kernel.org>
> Stable-dep-of: 5e5f68ca836e ("ASoC: fsl: merge DAI call back functions in=
to ops")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

This is a code refactoring.  It is obviously not suitable for stable,
it's not even a warning fix or anything - just a refactoring.  You've
marked it as a dependency of another patch which is doing the
refactoring in a specific driver which obviously shouldn't be being
backported either.

To repeat what I said the other day in response to the other wildly
inappropriate backports (one was an entirely new driver...) I thought
that there was supposed to be some manual review of the patches being
included in stable prior to them being sent out.  How on earth are
things like this getting as far as being even proposed for stable?

--uXgq1JfM9v+Ln2ex
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmT/KDMACgkQJNaLcl1U
h9DBegf/bXtt/AFhswkVETM96dsafrYZEURjfGHLg00kg5CrG9dkJqF+BeYPx0Js
1MCwyRS4gXU2BSj4MSVkRHQfQGuTbwTqOr3n/rE0emeOqQv+CHhOYDFkOBaKj1ki
rr2HqToTtdRd4V+5K0Yf6a7157ritUrG2XSfTLrmptRsCfLgGf/37K8w1/sRqXnJ
6xsmUtMSbQwBDstSuEIjT32gFn4Z9Csx709pFv8uCS7cpxoLuPfMyRwlanvUhRke
4iJNHt5ZImRZc1gMBupKlz9jcMOCUEFPVNPbref+PYNlRzbQtfYJ8bnduGkdXGTq
7IDJa3ROD2Wx0gUfc27M4jrxPHE0hQ==
=AIrR
-----END PGP SIGNATURE-----

--uXgq1JfM9v+Ln2ex--
