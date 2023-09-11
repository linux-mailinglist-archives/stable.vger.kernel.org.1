Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC82E79BB23
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349273AbjIKVdA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240550AbjIKOrB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:47:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40D8125
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:46:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0546C433C8;
        Mon, 11 Sep 2023 14:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694443617;
        bh=/o5U7v5CEh6tJZJh+0mrDPVsIkMF4KLwNtjauuWmYcw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J0F17HoUa4q86S5Cuzp7R3pQ3grLqjNmwmkF79ZmrCTKSHpmHQtRpx4bLmeNWWAXK
         +aSiP+wQfFePGLMq0eUAg6PEMrFPAt2rXf3EIx8+yC+zAmx/NeK8NqPfhyEaT98d+1
         qTaFtExXHhcPtXXeLeQK70k6OfsE6TdUK6LOjLVAoSB8IK3wVn9W209W0i8X+ZSi0I
         rHruLO6vfmVEufM8hGxvLzpMLnQN1kaxbipi5RSCNUnbUo1SW+HrOf/F40Uyyvtol9
         aEKiJeNRx4760aPqZBr1KaCaaaNuyalvtTu1ml6md8RIv6jFXh0GPq8+AJMCWizVwz
         Ja2ftChqqiAaA==
Date:   Mon, 11 Sep 2023 15:46:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.5 365/739] ASoC: fsl: merge DAI call back functions
 into ops
Message-ID: <ZP8oXToYJFUCeJ40@finisterre.sirena.org.uk>
References: <20230911134650.921299741@linuxfoundation.org>
 <20230911134701.347315064@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n9/5o3vSTY80nZ6a"
Content-Disposition: inline
In-Reply-To: <20230911134701.347315064@linuxfoundation.org>
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


--n9/5o3vSTY80nZ6a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2023 at 03:42:44PM +0200, Greg Kroah-Hartman wrote:
> 6.5-stable review patch.  If anyone has any objections, please let me kno=
w.
>=20
> ------------------
>=20
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> [ Upstream commit 5e5f68ca836e740c1d788f04efa84b37ed185606 ]
>=20
> ALSA SoC merges DAI call backs into .ops.
> This patch merge these into one.

This is obviously not stable material.

--n9/5o3vSTY80nZ6a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmT/KFwACgkQJNaLcl1U
h9CtPwgAgHoAOyu+YNvMrRwEH/2Ut68OB2xqn+0+l9j/eyX/AQ62F4ZOih6XokSH
F8JkWxLLvl5uajRRu7eHUqc1AJlfRVKPeJCfBd8Zc+QMrxIcxSbdu89DJMXkkJpp
7qiUcSA5nzIZbc6aLLfKhKJD3P46cPgBG2wtOXayo4tMhkzUvxQ1MFV1fD7674ot
diIp3c8rVbWMrTmkAzO6p0KzE1kTa5AoZBdt/DpE+RbOZX4BeBrQAcH8cDG87D/+
JiJDeQ7WWvE8t6J6I258tDLf9Vyp5Ij1FpXO7D2/0mdQruAakeilvj+k7ngZsIUL
afuUsFPArjtxkw+77aFIOAEVwZi+3g==
=HJt3
-----END PGP SIGNATURE-----

--n9/5o3vSTY80nZ6a--
