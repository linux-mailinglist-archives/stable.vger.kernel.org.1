Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7757972F26D
	for <lists+stable@lfdr.de>; Wed, 14 Jun 2023 04:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242052AbjFNCFS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 13 Jun 2023 22:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242056AbjFNCFR (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Jun 2023 22:05:17 -0400
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [95.217.213.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882C1172A
        for <stable@vger.kernel.org>; Tue, 13 Jun 2023 19:05:16 -0700 (PDT)
Received: from [213.219.167.32] (helo=deadeye)
        by maynard with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1q9Fso-0005eQ-9S; Wed, 14 Jun 2023 04:05:14 +0200
Received: from ben by deadeye with local (Exim 4.96)
        (envelope-from <ben@decadent.org.uk>)
        id 1q9Fsn-000YMM-2O;
        Wed, 14 Jun 2023 04:05:13 +0200
Message-ID: <b0662a1562dca6aa2059f908cf18e7be1bf26707.camel@decadent.org.uk>
Subject: Re: [PATCH 4.19 02/23] i40e: fix build warnings in i40e_alloc.h
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev
Date:   Wed, 14 Jun 2023 04:05:08 +0200
In-Reply-To: <20230612101651.237619015@linuxfoundation.org>
References: <20230612101651.138592130@linuxfoundation.org>
         <20230612101651.237619015@linuxfoundation.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-tc/JFBPGpwqKIoNkC/c9"
User-Agent: Evolution 3.48.2-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 213.219.167.32
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


--=-tc/JFBPGpwqKIoNkC/c9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2023-06-12 at 12:26 +0200, Greg Kroah-Hartman wrote:
> Not upstream as it was fixed in a much larger api change in newer
> kernels.
>=20
> gcc-13 rightfully complains that enum is not the same as an int, so fix
> up the function prototypes in i40e_alloc.h to be correct, solving a
> bunch of build warnings.
>=20
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_alloc.h |   17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
>=20
> --- a/drivers/net/ethernet/intel/i40e/i40e_alloc.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_alloc.h
> @@ -20,16 +20,11 @@ enum i40e_memory_type {
>  };
> =20
>  /* prototype for functions used for dynamic memory allocation */
> -i40e_status i40e_allocate_dma_mem(struct i40e_hw *hw,
> -					    struct i40e_dma_mem *mem,
> -					    enum i40e_memory_type type,
> -					    u64 size, u32 alignment);
> -i40e_status i40e_free_dma_mem(struct i40e_hw *hw,
> -					struct i40e_dma_mem *mem);
> -i40e_status i40e_allocate_virt_mem(struct i40e_hw *hw,
> -					     struct i40e_virt_mem *mem,
> -					     u32 size);
> -i40e_status i40e_free_virt_mem(struct i40e_hw *hw,
> -					 struct i40e_virt_mem *mem);
> +int i40e_allocate_dma_mem(struct i40e_hw *hw, struct i40e_dma_mem *mem,
> +			  enum i40e_memory_type type, u64 size, u32 alignment);
> +int i40e_free_dma_mem(struct i40e_hw *hw, struct i40e_dma_mem *mem);
> +int i40e_allocate_virt_mem(struct i40e_hw *hw, struct i40e_virt_mem *mem=
,
> +			   u32 size);
> +int i40e_free_virt_mem(struct i40e_hw *hw, struct i40e_virt_mem *mem);

All these function names are actually macro names, which seems a very
strange way to declare functions.

Shouldn't the declarations use the actual function names, which have
"_d" suffixes?

Ben.

> =20
>  #endif /* _I40E_ALLOC_H_ */
>=20
>=20

--=20
Ben Hutchings
It's easier to fight for one's principles than to live up to them.


--=-tc/JFBPGpwqKIoNkC/c9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmSJIFUACgkQ57/I7JWG
EQl5Qw//RlkpqD3m6c+Ov129Van3dXOb26D3q/kCkj0jAepFKS6qAlrNsgjvbueI
p0UCOOlqhSbe8sMDiNsFpNCP4QA0PwuPXyE6f0tiiQGYZffZTf4QiEPxgYQWqFYd
4MAvknk2BBw5psiWeuhjFQvnAc4ZfnCNBIFaWonfNJW6Ou6Dv6QFzev6QAAcwhRi
dVtJDJCsCZPq7jicwCEG9yLEYc4gh2tlhO1SNZXlAOs831n3LcWpNyi93CGbofum
oZbo41hWGw2u6RUiYVXhq9dcEPbzqCjBuKoiVmNJd7JMUWS4EwOdCrLjYBxzICHi
8acLiUsfoQj6TLB6jqbEBaITLpf3jlUT/1vb0ufS0qAOeDsRkb/jL6x85UHfXaUH
dq4HI61TWX7d6JtxdWf6Nfzuh2t6m5npdDAbp3auj3CnO0IZfSm1nqUQR1JAhqOQ
CJBxdbu8hlMxWOlgHqgEtiB17VK2z6bG2KnJ70HvKwU1FqbYWmTAOXxa0wEp7zpW
BBJXK8YUbxCAVq5ardJrk6SrPoeliKpPiA9n+qeDMgo0iTjKd62yEv9lV/VEE015
mEpeEPiUcf5k5kLfOVJK9Gifz11Pbg+bAv0/ojiBCNINQFEJKplnNurrDCklc9m2
5sG3hpmbNR4c4dfFpO2lPOqCokMSeIpJ62Mo45tfxfN8FAYnoTI=
=dvdZ
-----END PGP SIGNATURE-----

--=-tc/JFBPGpwqKIoNkC/c9--
