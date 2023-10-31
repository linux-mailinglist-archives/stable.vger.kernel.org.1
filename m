Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8A77DD4A9
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjJaR2t (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbjJaR2t (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:28:49 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8144791
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:28:46 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.03,265,1694703600"; 
   d="asc'?scan'208";a="181313073"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 01 Nov 2023 02:28:45 +0900
Received: from unknown (unknown [10.226.92.68])
        by relmlir5.idc.renesas.com (Postfix) with SMTP id C5765400D0F3;
        Wed,  1 Nov 2023 02:28:41 +0900 (JST)
Date:   Tue, 31 Oct 2023 17:28:40 +0000
From:   Paul Barker <paul.barker.ct@bp.renesas.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     stable@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Fangrui Song <maskray@google.com>,
        Jian Cai <jiancai@google.com>,
        Peter Smith <peter.smith@linaro.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        martin@kaiser.cx
Subject: Re: [PATCH 4.14/4.19] ARM: 8933/1: replace Sun/Solaris style flag on
 section directive
Message-ID: <20231031172840.uotqlgihz3wg4rg6@GBR-5CG2373LKG.adwin.renesas.com>
References: <20231031172217.27147-1-paul.barker.ct@bp.renesas.com>
 <CAKwvOdkX83OxM5myi93g_4wRWf5prVZse2s0do8QxGWV0TyJ+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="za5ooudsi5sbw7q7"
Content-Disposition: inline
In-Reply-To: <CAKwvOdkX83OxM5myi93g_4wRWf5prVZse2s0do8QxGWV0TyJ+g@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


--za5ooudsi5sbw7q7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 10:25:20AM -0700, Nick Desaulniers wrote:
> On Tue, Oct 31, 2023 at 10:22=E2=80=AFAM Paul Barker
> <paul.barker.ct@bp.renesas.com> wrote:
> >
> > From: Nick Desaulniers <ndesaulniers@google.com>
> >
> > commit 790756c7e0229dedc83bf058ac69633045b1000e upstream
>=20
> Thanks for the patch, but Martin beat you to the punch by 1 day!
> https://lore.kernel.org/stable/20231030212510.equbu7lxlslgoy3t@viti.kaise=
r.cx/
>=20
> Sasha already has picked it up.
> https://lore.kernel.org/stable/ZUA5BDnos1ASlFqM@sashalap/

Ah, I should have searched harder! Sorry for the noise.

--za5ooudsi5sbw7q7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZUE5OQAKCRDbaV4Vf/JG
vQ4sAPwJcx68gGbybVf6IeFFvT5iXGVhBuXBBBTeHNq2xVR03gD+IGHrXaGwSsyZ
id1aKk19iIxNRyRtHkfvlbC6QC+VXgI=
=bQjl
-----END PGP SIGNATURE-----

--za5ooudsi5sbw7q7--
