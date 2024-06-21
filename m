Return-Path: <stable+bounces-54833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C35A9912AA0
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 17:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DAB82825FF
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 15:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0397115CD40;
	Fri, 21 Jun 2024 15:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1V45UpN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B549115B993;
	Fri, 21 Jun 2024 15:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718984961; cv=none; b=mlYu+jCYe6gJ70pwXj8fqSnhUXDVgXoW3tPKlYiSOQWxA2QEN2TYuOxE/emCIdHuCbP76YHiR8148OvMEygX5agaF3GJQkC3IqR8+yK9AOaS9MKkD9nR2KlbDKCJKvAYVrrpJdApm4J7GXz3TSzhfz5vZAY8fKwrd/17cnabsLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718984961; c=relaxed/simple;
	bh=HT4G1AXJf7dq5QgGIVKWW8aXwKSYFQeF3N6y7kt0EPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBPjh2gjLkTJCufK1v961II7qSbcess6FHRvxnwT1AJrUThNLwNmGse4qXqbzqhWoTFtkyIsOb08nQCsNDqNgT62+hEim7SrbqsnB8H0YnXb74bROKa/b2drMf/8NYIddKPhXMAIUZRvEPiwjXImtny33UHUL3m7vR5VlWLq91U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1V45UpN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E28C2BBFC;
	Fri, 21 Jun 2024 15:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718984961;
	bh=HT4G1AXJf7dq5QgGIVKWW8aXwKSYFQeF3N6y7kt0EPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S1V45UpNLj/JQ0CZL6auJSEHOoC6EDb4g+5awYKQMDux8hPHnzzJXmx/S8vYLY1Wp
	 04DasMph5rNc/kLMgVo3iA1gqVeisXf51Mj1g34XwovP43HN9mI001Y7tJc+7Z82QZ
	 fotqzMgFAwH8eRIqOd4/xAzjFLE/VR2FvNwS5TWS0aDzIzQu3P+mzpHZypDKDIpzyM
	 hkVTvU41fTzZIdl6FqHlLmBPxcgXpZdT8nJhqIYRnRJ183XnK/E1eeUZFDduy0SaRJ
	 SVixLYC+ntvzyLNHVlEqW5cMVkqNC1hbyUBy7AfZuyUHoxMtSoZKwJ8HQr+izeVWCM
	 Tod/dSukARJ5A==
Date: Fri, 21 Jun 2024 16:49:16 +0100
From: Mark Brown <broonie@kernel.org>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, brent.lu@intel.com,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <liam.r.girdwood@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: Patch "ASoC: Intel: sof_cs42l42: rename BT offload quirk" has
 been added to the 6.9-stable tree
Message-ID: <c26034e7-194c-4b9c-9f2d-d25f7ca987ca@sirena.org.uk>
References: <20240621154202.4147700-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5OyUXH8ManbymOi0"
Content-Disposition: inline
In-Reply-To: <20240621154202.4147700-1-sashal@kernel.org>
X-Cookie: Androphobia:


--5OyUXH8ManbymOi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 11:42:01AM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
>=20
>     ASoC: Intel: sof_cs42l42: rename BT offload quirk

This is not obvious stable material.

>    =20
>     Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
>     Signed-off-by: Brent Lu <brent.lu@intel.com>
>     Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel=
=2Ecom>
>     Link: https://msgid.link/r/20240325221059.206042-7-pierre-louis.bossa=
rt@linux.intel.com
>     Signed-off-by: Mark Brown <broonie@kernel.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>

I'm also not seeing any stable-dep-of r anything in here.

--5OyUXH8ManbymOi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZ1oPsACgkQJNaLcl1U
h9CZ/wf/a72qFUmxTtD+ygYKK4NDKppVqFuW9/anR3Q/fU4B76q3geWuE5nHoqZO
I/HBr3lszAFL/W6yLy2vK2JvUXLd6h8S6R8u4h+TE0rRTFVggwIzklNPIncfrmgT
VfOBEYQ6TqmOuaPgWlHMM0Ns9DVOykPTQmaSku9A1f85ujydGVauHBBpr66fgnQA
I+kfYRYIH6ApQSIn8wvXr0F80OlIPBIYKnavYghdS1D0e0tCn15GohLF0dFCe2se
KEfFhW1OUbOfD3eM+hOqH0MHQTushohQotNo4l5YFDa6XAnkEIj0ROnIMImHA2vs
by3V1K3r+5c8sTiCnb8e3gDp8XUoCQ==
=GLGg
-----END PGP SIGNATURE-----

--5OyUXH8ManbymOi0--

