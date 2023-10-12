Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90487C67F4
	for <lists+stable@lfdr.de>; Thu, 12 Oct 2023 10:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347230AbjJLIBp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 12 Oct 2023 04:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343704AbjJLIBo (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Oct 2023 04:01:44 -0400
Received: from vulcan.natalenko.name (vulcan.natalenko.name [104.207.131.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF2390
        for <stable@vger.kernel.org>; Thu, 12 Oct 2023 01:01:41 -0700 (PDT)
Received: from spock.localnet (unknown [94.142.239.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 37FDE153CACD;
        Thu, 12 Oct 2023 10:01:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1697097698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ym8znVE/KNVZ2ABkurRPnWvCdBcwyMiA231koj0IzME=;
        b=RHv5a8hfYSsjGosuqXiM5HN4jBVFx9JzxhfRYPkbwVRUiakAp/Hupi2vIYb+4UPZc3sKSd
        9NUE2039F9zJvlRGh3tY8xURchgzAgNstbmNDKkqwtbEYng4RqvFmbNzyALxU+QbluM9tv
        G7di96YOnIw3j0q3NyvORUekdJK7uvM=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm: Do not overrun array in drm_gem_get_pages()
Date:   Thu, 12 Oct 2023 10:01:23 +0200
Message-ID: <2703014.mvXUDI8C0e@natalenko.name>
In-Reply-To: <20231005135648.2317298-1-willy@infradead.org>
References: <20231005135648.2317298-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12302735.O9o76ZdvQC";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

--nextPart12302735.O9o76ZdvQC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: [PATCH] drm: Do not overrun array in drm_gem_get_pages()
Date: Thu, 12 Oct 2023 10:01:23 +0200
Message-ID: <2703014.mvXUDI8C0e@natalenko.name>
In-Reply-To: <20231005135648.2317298-1-willy@infradead.org>
References: <20231005135648.2317298-1-willy@infradead.org>
MIME-Version: 1.0

On =C4=8Dtvrtek 5. =C5=99=C3=ADjna 2023 15:56:47 CEST Matthew Wilcox (Oracl=
e) wrote:
> If the shared memory object is larger than the DRM object that it backs,
> we can overrun the page array.  Limit the number of pages we install
> from each folio to prevent this.
>=20
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reported-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> Link: https://lore.kernel.org/lkml/13360591.uLZWGnKmhe@natalenko.name/
> Fixes: 3291e09a4638 ("drm: convert drm_gem_put_pages() to use a folio_bat=
ch")
> Cc: stable@vger.kernel.org # 6.5.x
> ---
>  drivers/gpu/drm/drm_gem.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index 6129b89bb366..44a948b80ee1 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -540,7 +540,7 @@ struct page **drm_gem_get_pages(struct drm_gem_object=
 *obj)
>  	struct page **pages;
>  	struct folio *folio;
>  	struct folio_batch fbatch;
> -	int i, j, npages;
> +	long i, j, npages;
> =20
>  	if (WARN_ON(!obj->filp))
>  		return ERR_PTR(-EINVAL);
> @@ -564,11 +564,13 @@ struct page **drm_gem_get_pages(struct drm_gem_obje=
ct *obj)
> =20
>  	i =3D 0;
>  	while (i < npages) {
> +		long nr;
>  		folio =3D shmem_read_folio_gfp(mapping, i,
>  				mapping_gfp_mask(mapping));
>  		if (IS_ERR(folio))
>  			goto fail;
> -		for (j =3D 0; j < folio_nr_pages(folio); j++, i++)
> +		nr =3D min(npages - i, folio_nr_pages(folio));
> +		for (j =3D 0; j < nr; j++, i++)
>  			pages[i] =3D folio_file_page(folio, i);
> =20
>  		/* Make sure shmem keeps __GFP_DMA32 allocated pages in the
>=20

Gentle ping. It would be nice to have this picked so that it gets into the =
stable kernel rather sooner than later.

Thanks.

=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart12302735.O9o76ZdvQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmUnp9MACgkQil/iNcg8
M0syoA//dDht5ZzqbjFSuWQmAUIPSUFsvQJN++9JIZ3meMgB/R8u8l0+hvQgo5pa
SSOW/C6YPgDJn40fjQy/D+Z7WlbfpLdfm2SfE2TIvG2D87b1ve8iY2/Opk2LA9l5
ezOWkm+M1Pq2Hrht7xiUGH4Y1WPuj4GRNl6ZAVQ0iLHUuFcNfcmio0lLY/z+1RN+
6ODQv9nXMEhmsAWXQHNQ7PpJz0lyzYM8pe/CJM+gn1jtTBlIE9bN7AktIVR1XOvC
7XMRiMbBKe7q/osmyDJ1VBgSn1EEWzupLnCwIjuLY0v9Hm7hTS030lbd0zUsiUe3
PvtR96R+3udApMH0ch6bBBCuKjXSBoDlbtFrEgJy9UFlJsqvNyEipsYFRDe2qKJ7
tNBOWQJCkTucQnn5e81XzzE429nqUYjUlR5qfYQF/sPXO7NewC1km/xO3bhePH3B
vGOQAvpGrJ1llN8HQr3PNgDuviJIXqVSIGLvXLf/FdKlN6NmxOgQdeq0+BQq91dN
s3J6ZxcGyoPt7y2WfY3ruExAl3lbpebYmK9Ti1O7mNpsIxdIl1gOkT3EtFICAIvJ
rTz3ie7SKhie3FudN5ceC6s2/Di2k5ute1a2gVsKrbSMsAwxJczb2r/7H/EwGExw
xMnCWyJ/SFIaxNcBIFTU7hQQcfbofJ7+Bf1mdhD6sCjfWfj0BwI=
=Gk16
-----END PGP SIGNATURE-----

--nextPart12302735.O9o76ZdvQC--



