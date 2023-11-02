Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821D17DE939
	for <lists+stable@lfdr.de>; Thu,  2 Nov 2023 01:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbjKBANJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 1 Nov 2023 20:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjKBANJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 1 Nov 2023 20:13:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D9E101
        for <stable@vger.kernel.org>; Wed,  1 Nov 2023 17:13:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA26FC433C7;
        Thu,  2 Nov 2023 00:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698883984;
        bh=s2zFXorocv1zuAi5+kYLC4454sqr4YBYADhktYWoFBA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gCkFYmXs1R3HoiIsUvMCNXbBWt9njpduA57m/uyadHKIj2yaX61HxcBzbFp/gJD4i
         lv9ROdUMCjXsmckTwFq9rMgjAXnpI8QujSmCeqWiyYRVznyQ8+DOfMkvM8rawsdKgJ
         P9+i16Lz5jnGgHJz1yAyS8BukU1K/45nuHA9e0WFL+hdlZftNeMLlrBcbLN4gGuBPj
         7UgN59tnCM+j1OGmnsaGRwn0xZ+RqAcgHs9HpAOlsyRVqhlTWg38mN72TK88MUkdVm
         u2j3yKftpMBJEgjWbYADuUS4b1EKHZbxwnmH6PSIwy2LArkhs7IC8T5DcEJegH7dwv
         1CRFtcSFwyQhQ==
Date:   Thu, 2 Nov 2023 00:13:00 +0000
From:   Conor Dooley <conor@kernel.org>
To:     "Saravanan.K.S" <saravanan.kadambathursubramaniyam@windriver.com>
Cc:     kexin.hao@windriver.com, rajeshkumar.ramasamy@windriver.com,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>, stable@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH 093/130] RISC-V: fix compile error from deduplicated
 __ALTERNATIVE_CFG_2
Message-ID: <20231102-unpicked-baggage-1e57a30ba81b@spud>
References: <20231101175702.3967251-1-saravanan.kadambathursubramaniyam@windriver.com>
 <20231101175702.3967251-94-saravanan.kadambathursubramaniyam@windriver.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5dRCX8WSNPYZP0Ch"
Content-Disposition: inline
In-Reply-To: <20231101175702.3967251-94-saravanan.kadambathursubramaniyam@windriver.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


--5dRCX8WSNPYZP0Ch
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Top post yada yada, I don;t care.

So, I got emailed on 190 patches from you that I don't think you
intended to send publicly.

Greg, if you see this, this is probably already in stable and is not
6.1-stable material anyway, I just had backported some stuff to my
vendor tree that is the source of this.

Cheers,
Conor.

On Wed, Nov 01, 2023 at 05:56:25PM +0000, Saravanan.K.S wrote:
>=20
> [You don't often get email from saravanan.kadambathursubramaniyam@windriv=
er.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdent=
ification ]
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> From: Heiko Stuebner <heiko.stuebner@vrull.eu>
>=20
> commit 7d27a3bb961dfb59ececd2f641b09fbe7198837e from
> https://github.com/linux4microchip/linux.git linux-6.1-mchp
>=20
> On the non-assembler-side wrapping alternative-macros inside other macros
> to prevent duplication of code works, as the end result will just be a
> string that gets fed to the asm instruction.
>=20
> In real assembler code, wrapping .macro blocks inside other .macro blocks
> brings more restrictions on usage it seems and the optimization done by
> commit 2ba8c7dc71c0 ("riscv: Don't duplicate __ALTERNATIVE_CFG in __ALTER=
NATIVE_CFG_2")
> results in a compile error like:
>=20
> ../arch/riscv/lib/strcmp.S: Assembler messages:
> ../arch/riscv/lib/strcmp.S:15: Error: too many positional arguments
> ../arch/riscv/lib/strcmp.S:15: Error: backward ref to unknown label "886:"
> ../arch/riscv/lib/strcmp.S:15: Error: backward ref to unknown label "887:"
> ../arch/riscv/lib/strcmp.S:15: Error: backward ref to unknown label "886:"
> ../arch/riscv/lib/strcmp.S:15: Error: backward ref to unknown label "887:"
> ../arch/riscv/lib/strcmp.S:15: Error: backward ref to unknown label "886:"
> ../arch/riscv/lib/strcmp.S:15: Error: attempt to move .org backwards
>=20
> Wrapping the variables containing assembler code in quotes solves this is=
sue,
> compilation and the code in question still works and objdump also shows s=
ane
> decompiled results of the affected code.
>=20
> Fixes: 2ba8c7dc71c0 ("riscv: Don't duplicate __ALTERNATIVE_CFG in __ALTER=
NATIVE_CFG_2")
> Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Link: https://lore.kernel.org/r/20230105192610.1940841-1-heiko@sntech.de
> Cc: stable@vger.kernel.org
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Saravanan.K.S <saravanan.kadambathursubramaniyam@windriver=
=2Ecom>
> ---
>  arch/riscv/include/asm/alternative-macros.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/include/asm/alternative-macros.h b/arch/riscv/inc=
lude/asm/alternative-macros.h
> index 7226e2462584..2c0f4c887289 100644
> --- a/arch/riscv/include/asm/alternative-macros.h
> +++ b/arch/riscv/include/asm/alternative-macros.h
> @@ -46,7 +46,7 @@
>=20
>  .macro ALTERNATIVE_CFG_2 old_c, new_c_1, vendor_id_1, errata_id_1, enabl=
e_1,   \
>                                 new_c_2, vendor_id_2, errata_id_2, enable=
_2
> -       ALTERNATIVE_CFG \old_c, \new_c_1, \vendor_id_1, \errata_id_1, \en=
able_1
> +       ALTERNATIVE_CFG "\old_c", "\new_c_1", \vendor_id_1, \errata_id_1,=
 \enable_1
>         ALT_NEW_CONTENT \vendor_id_2, \errata_id_2, \enable_2, \new_c_2
>  .endm
>=20
> --
> 2.40.0
>=20

--5dRCX8WSNPYZP0Ch
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZULpjAAKCRB4tDGHoIJi
0j4YAQDFa1z0fkoz9KHTb88DJrJbRVGXen5iMtwFv4YP+K7uEgD+LRBW53l8cuSu
RQdUw91w//ZIKhaZhL0DXPYR7SW3WwE=
=lre1
-----END PGP SIGNATURE-----

--5dRCX8WSNPYZP0Ch--
