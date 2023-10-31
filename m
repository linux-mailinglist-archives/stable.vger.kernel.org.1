Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFBBC7DD6D7
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 20:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235455AbjJaT7l (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 15:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjJaT7l (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 15:59:41 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4EE8F3;
        Tue, 31 Oct 2023 12:59:36 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.03,266,1694703600"; 
   d="asc'?scan'208";a="185137237"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 01 Nov 2023 04:59:35 +0900
Received: from unknown (unknown [10.226.92.14])
        by relmlir6.idc.renesas.com (Postfix) with SMTP id 2E51F40A0B34;
        Wed,  1 Nov 2023 04:59:32 +0900 (JST)
Date:   Tue, 31 Oct 2023 19:59:31 +0000
From:   Paul Barker <paul.barker.ct@bp.renesas.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Luis Machado <luis.machado@arm.com>, linux-ide@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 4.14] ata: ahci: fix enum constants for gcc-13
Message-ID: <20231031195931.zzeugxsquaayov52@GBR-5CG2373LKG.adwin.renesas.com>
References: <20231031173255.28666-1-paul.barker.ct@bp.renesas.com>
 <2023103125-public-resilient-cc46@gregkh>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fznka5kjuo4i6fa6"
Content-Disposition: inline
In-Reply-To: <2023103125-public-resilient-cc46@gregkh>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


--fznka5kjuo4i6fa6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 06:48:03PM +0100, Greg KH wrote:
> On Tue, Oct 31, 2023 at 05:32:55PM +0000, Paul Barker wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >=20
> > commit f07788079f515ca4a681c5f595bdad19cfbd7b1d upstream.
> >=20
> > gcc-13 slightly changes the type of constant expressions that are defin=
ed
> > in an enum, which triggers a compile time sanity check in libata:
>=20
> Does gcc-13 actually work for these older stable kernels yet?  Last I
> tried there were a bunch of issues.  I'll gladly take these, just
> wondering what the status was and if there are many more to go.

Well, it works for me!

The Yocto Project master branch has binutils 2.41 & gcc 13.2.0. I can
build 4.14.328, 4.19.297 & 5.4.259 with these patches applied on top and
boot them in qemu. For 4.14 & 4.19 I also need a backport of 790756c7e02
("ARM: 8933/1: replace Sun/Solaris style flag on section directive")
which is already in the stable queue. I've done no testing beyond
checking that I can get to a shell.

I've tested x86 (i386_defconfig), x86-64 (x86_64_defconfig), arm
(multi_v7_defconfig) & arm64 (defconfig).

Thanks,
Paul

--fznka5kjuo4i6fa6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZUFclAAKCRDbaV4Vf/JG
vUvaAP0X1CI2jftu24eBUi1/ITx4zPWvw8yuV+AM2AKbl0vfRQD/Ss/eqqAeu2zv
/duA2bUJlhUSQzoWQKDmBTHw5cN3AQY=
=kICp
-----END PGP SIGNATURE-----

--fznka5kjuo4i6fa6--
