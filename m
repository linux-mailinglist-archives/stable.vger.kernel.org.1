Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A7579D087
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 13:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235066AbjILL74 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 12 Sep 2023 07:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235064AbjILL7O (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 12 Sep 2023 07:59:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6C6170F
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 04:58:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A98AC433C9;
        Tue, 12 Sep 2023 11:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694519905;
        bh=u2rSIdmyA/xYdKHGkZABHu/PkWvdRGgxsEkYotVDPns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DLC707AapNJ89eMjEs14FaTwXvJBV+Lxsdr3HGArrYJslskRarbnSLs9IesBbojvy
         /2woGxUyGg7tGs+L0Hbmqk97Vk4uoOgY8an+wTT8lUDxbJo35xF74l8J9VlQ9rpDpW
         7MfOCzjRgu4G4WgvqIgdQZ8OuuHPp2cQTc57RWLXBsXgrGsaqgeHy2rDeSFr4eRG9W
         jdnonj6PqtVGcxZ5JkvavD5H/cb+zx0H7QpcGdmvZw+96vj9gW0EJldjL1a/68yyIL
         IkZ+kPJ0vCSB4mUcbtdDkaA7JnZ7aMbSIJzCq9EyJnkdoRRCTe3pq2JlUO5BcjURkr
         G//WR5T8iMHJw==
Date:   Tue, 12 Sep 2023 12:58:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.5 364/739] ASoC: soc-dai.h: merge DAI call back
 functions into ops
Message-ID: <5ce33be2-230e-41d0-8ec2-9bf59cc43d32@sirena.org.uk>
References: <20230911134650.921299741@linuxfoundation.org>
 <20230911134701.316565214@linuxfoundation.org>
 <ZP8oM04ucZJkxXCS@finisterre.sirena.org.uk>
 <87il8gs3m8.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lSgeNTjfyO2/jRm+"
Content-Disposition: inline
In-Reply-To: <87il8gs3m8.wl-kuninori.morimoto.gx@renesas.com>
X-Cookie: Victory uber allies!
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


--lSgeNTjfyO2/jRm+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 11, 2023 at 11:16:00PM +0000, Kuninori Morimoto wrote:

> I have noticed about this, but my guess was that because this each patch
> modifies driver file with wide range. Thus, other main/important patch
> can't be backported without this patch (to fsl/pxa) ?
> (I'm not 100% understanding stable rules...)

If it were that I'd have expected it to have a Stable-dep-of tag in it
saying what was pulling it back, but even there it would be more
sensible to do a manual backport than pull in a refactoring.

--lSgeNTjfyO2/jRm+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUAUkAACgkQJNaLcl1U
h9BGdgf/fURDpLfQ7eMKhmOEgVHIAdprihoAQ2QFFhRWVZLFG6bMye/wjgS5qlxP
SlClwETngWk2ls9439ZoMwvIkBz3lfFcUF+HXepAz7o3ZVkei7oOQXC5ZIc5qjlh
Up9UtcaBZiNEd6rnI8fkIcCPmvSnhmpHfjKsnHrry/D5TOt+71Ef/k2enDWRSIaA
EL0yOiS5O06mBzN/TfclyVIKdyAILcP/xwpvhAncrurhkPf1w2Z7V4Ii+g9OmuhJ
QXx/eOTOGOEpi74Obh8epcwqLXzKwkUGAZ8/AM25z65LbF1voPEDcd7PCkAvnRQr
5qR0KsfRiWAYSUN6EahCX546cKhDzQ==
=yuDm
-----END PGP SIGNATURE-----

--lSgeNTjfyO2/jRm+--
