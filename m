Return-Path: <stable+bounces-74003-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BC6971656
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 13:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 624ED1C22D69
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 11:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CE91B4C4C;
	Mon,  9 Sep 2024 11:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyT5Kta5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8161F15EFA1;
	Mon,  9 Sep 2024 11:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725880479; cv=none; b=Yo5rnydfJA9D5F8K6ULMjX4GWUD+t2vImmxl39M4kx/iOtJ0XvQCejQqg2r5g4WjWK1f+cOzUejEjnGZrrgU5mSznFKldHudsdJnCWMdi+q+7RhiAonseRaQ9420TQ3YWAI0xqLZ+OD2/nLgoRznP40JWgXvbZjk4sW+6hSY6AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725880479; c=relaxed/simple;
	bh=Fr2THDwY0bsKTYQl34f7h+OcLTt8G836Z3JtedeGPTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NP63zgz9S6xG6Ef4Fnp6FZusBfx1uI72GapYWg1a/2zd9Nav6ZHiT9VntWw2EvBanbkj/PXnb3GUusFGjX3tatwVqlZ/T9Vs994yssF4gbUQEp/PQrm/hfG0cEDePr5bJnHPiXhUOQ4+01KKB75gdea5PAlfbuZqDhAhuJLNsDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyT5Kta5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4589AC4CEC5;
	Mon,  9 Sep 2024 11:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725880479;
	bh=Fr2THDwY0bsKTYQl34f7h+OcLTt8G836Z3JtedeGPTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RyT5Kta5kuThcClujfWZqlsntpugpoGaos4uZAcOrhWAlvMddMhdy3ZSax7rUZPoK
	 0NswgkZYVNUgYFhssRcRWbJp5jf43eP7IJKwzeiucLatvtqxKpKyYp1MjUMg6ElT0y
	 K/ahZVjIQUPsKOhriHTpUj1XtTIjJdPQubzeQXCtxGhqrBfXcPC1sbbTsoBzkuFfrZ
	 Wjg06atCOAGrxplSEbGb+QNbCMSeXdodF1yeJGJ/raTGlW5tQS4li0oC60xP0pc2GT
	 8oamxOQgkyTQbsdOkO9cqBg/kim/5gfx0NXE5IwV6kTLfKVEbKqT603IA+MnaBKqw3
	 H6JPb1x8ionhA==
Date: Mon, 9 Sep 2024 12:14:28 +0100
From: Mark Brown <broonie@kernel.org>
To: Szabolcs Nagy <nsz@port70.net>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Szabolcs Nagy <szabolcs.nagy@arm.com>, netdev@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com,
	arefev@swemel.ru, alexander.duyck@gmail.com,
	Willem de Bruijn <willemb@google.com>, stable@vger.kernel.org,
	Jakub Sitnicki <jakub@cloudflare.com>, Felix Fietkau <nbd@nbd.name>,
	Yury Khrustalev <yury.khrustalev@arm.com>, nd@arm.com
Subject: Re: [PATCH net v2] net: drop bad gso csum_start and offset in
 virtio_net_hdr
Message-ID: <0b14a8a8-4d98-46a3-9441-254345faa5df@sirena.org.uk>
References: <20240729201108.1615114-1-willemdebruijn.kernel@gmail.com>
 <ZtsTGp9FounnxZaN@arm.com>
 <66db2542cfeaa_29a385294b9@willemb.c.googlers.com.notmuch>
 <66de0487cfa91_30614529470@willemb.c.googlers.com.notmuch>
 <20240909094527.GA3048202@port70.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HoiVCD7OSR8TbXx0"
Content-Disposition: inline
In-Reply-To: <20240909094527.GA3048202@port70.net>
X-Cookie: Anything is possible, unless it's not.


--HoiVCD7OSR8TbXx0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 09, 2024 at 11:45:27AM +0200, Szabolcs Nagy wrote:

> fvp is closed source but has freely available binaries
> for x86_64 glibc based linux systems (behind registration
> and license agreements) so in principle the issue can be
> reproduced outside of arm but using fvp is not obvious.

> hopefully somebody at arm can pick it up or at least
> report this thread to the fvp team internally.

FWIW there's a tool called shrinkwrap which makes it quite a lot easier
to get going:

   https://gitlab.arm.com/tooling/shrinkwrap

though since the models are very flexibile valid configurations that
people see issues with aren't always covered by shrinkwrap.

--HoiVCD7OSR8TbXx0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbe2JQACgkQJNaLcl1U
h9AmmAf/YFKKLxX04tgo73jfPK1KIxOpwDzijd1LbjSEQuCbTs3DwPnTmTss2w6g
1d4cpRhEkJiZrxskfhaI3WDWhhUDcKGzES5SFSF5JzSp9r4tNKBu2Ser1JTwPuhl
spvhdYegU73FWO25JM0JC+aXZwcUr4j0yJ39T04whRwfvKxMA+uwXx/3MzgJC+LV
+a30rMOG65K0Eh/EjRlAoZTkHKde/dRzqJ0AkpB7nyStdZDHThaapWOBcbAsHVXv
r4wr52sgTb6m44bIfZqpxCzdZuVOjQhyhEoM1LQDwMAWhKrQ8N8tJfk5vaOM8sYu
DxwcjGbeRvNe2B6kEXUG9W11U1yPew==
=+Erf
-----END PGP SIGNATURE-----

--HoiVCD7OSR8TbXx0--

