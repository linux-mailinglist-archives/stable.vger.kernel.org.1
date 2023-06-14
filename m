Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F04372F2A7
	for <lists+stable@lfdr.de>; Wed, 14 Jun 2023 04:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjFNCoT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 13 Jun 2023 22:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjFNCoS (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Jun 2023 22:44:18 -0400
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [95.217.213.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16961BDA
        for <stable@vger.kernel.org>; Tue, 13 Jun 2023 19:44:17 -0700 (PDT)
Received: from [213.219.167.32] (helo=deadeye)
        by maynard with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1q9GUX-00062j-Vc; Wed, 14 Jun 2023 04:44:13 +0200
Received: from ben by deadeye with local (Exim 4.96)
        (envelope-from <ben@decadent.org.uk>)
        id 1q9GUX-000YiS-1J;
        Wed, 14 Jun 2023 04:44:13 +0200
Message-ID: <56e71e80cf4f20bb6d0a1be088210e2582c162f6.camel@decadent.org.uk>
Subject: Re: [PATCH 4.19 21/23] btrfs: check return value of
 btrfs_commit_transaction in relocation
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, Qu Wenruo <wqu@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Stefan Ghinea <stefan.ghinea@windriver.com>
Date:   Wed, 14 Jun 2023 04:44:08 +0200
In-Reply-To: <20230612101651.846259280@linuxfoundation.org>
References: <20230612101651.138592130@linuxfoundation.org>
         <20230612101651.846259280@linuxfoundation.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-HlSuPSMAaRdFA2k5XPnM"
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


--=-HlSuPSMAaRdFA2k5XPnM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2023-06-12 at 12:26 +0200, Greg Kroah-Hartman wrote:
> From: Josef Bacik <josef@toxicpanda.com>
>=20
> commit fb686c6824dd6294ca772b92424b8fba666e7d00 upstream.
>=20
> There are a few places where we don't check the return value of
> btrfs_commit_transaction in relocation.c.  Thankfully all these places
> have straightforward error handling, so simply change all of the sites
> at once.

I have no objection to this, but in case anyone wants to fix this issue
completely there are a few other unchecked btrfs_commit_transaction()
calls in other source files in 4.19-stable.

Ben.

> Reviewed-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: David Sterba <dsterba@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Stefan Ghinea <stefan.ghinea@windriver.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  fs/btrfs/relocation.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -2341,7 +2341,7 @@ again:
>  	list_splice(&reloc_roots, &rc->reloc_roots);
> =20
>  	if (!err)
> -		btrfs_commit_transaction(trans);
> +		err =3D btrfs_commit_transaction(trans);
>  	else
>  		btrfs_end_transaction(trans);
>  	return err;
> @@ -3930,8 +3930,7 @@ int prepare_to_relocate(struct reloc_con
>  		 */
>  		return PTR_ERR(trans);
>  	}
> -	btrfs_commit_transaction(trans);
> -	return 0;
> +	return btrfs_commit_transaction(trans);
>  }
> =20
>  static noinline_for_stack int relocate_block_group(struct reloc_control =
*rc)
> @@ -4097,7 +4096,9 @@ restart:
>  		err =3D PTR_ERR(trans);
>  		goto out_free;
>  	}
> -	btrfs_commit_transaction(trans);
> +	ret =3D btrfs_commit_transaction(trans);
> +	if (ret && !err)
> +		err =3D ret;
>  out_free:
>  	btrfs_free_block_rsv(fs_info, rc->block_rsv);
>  	btrfs_free_path(path);
>=20
>=20

--=20
Ben Hutchings
It's easier to fight for one's principles than to live up to them.


--=-HlSuPSMAaRdFA2k5XPnM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmSJKXgACgkQ57/I7JWG
EQnGuxAApuCUHILiOD5NVhtuAO/5RSrM6qYkC27a90r3Y07yqZMw1edrGfk64mzd
eH6q8FRbIr7aR2OqakP8wvp9MRrR0SGM7Nn6dOgZeZXYePZIPPf3kJli7Q7wB6cL
fW5wNbG7X572kJ7GtMqA0H2p0v3z1Tz7cQHWTgcG2+il6khJIe0g9ryCCZQ+eluf
0iijpWES+m1VCKyAHGST7bF1GlZmXUnCWAfsEbPipMSKoblED82DZp/feeFRnD8l
dgn1cMaK9K18fSJkT3ITlY1yhRDZGnRqWxK0U/nPTHUJgRCtWSeNpLME63fz8y1I
4cPs4wjWPPUYKAMJjQ7H/GpF6yb49JRZSr3W0NJPSFWW0GGZmGFXYAQea7B61dH0
UI5yTixZ71eh+LiktpoVFFqFq/hQS7aZ5nS31aM/FZNcCu0fTqu0Mo9dyXAZD+98
G2vUVyGIJENbzRq3DqPpFxbtFojfKW2ZV4nBSBd52115vtB8Ij4A3scRpGB9lPzU
JAw0zDeu+cC38A2NVSjA5VV6UJnB1MXe6PYwp69gTVMNAGWLKHV1og9Z0Oq/Kzo6
2CgnZX/qXDu1xNOQLY/hxFRkz+VE97XC7RO6TeGuLNh+pJAMdqmLTyvIkE8qbBr7
kh9WMrVPlDeDhraUntFjv6aNHBkgKiScL9mJ8RPTYSVSV70kM18=
=8CR1
-----END PGP SIGNATURE-----

--=-HlSuPSMAaRdFA2k5XPnM--
