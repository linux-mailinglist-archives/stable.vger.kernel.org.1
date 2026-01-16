Return-Path: <stable+bounces-210074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEB5D33875
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 17:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FA613095AB3
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 16:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED113939AE;
	Fri, 16 Jan 2026 16:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+tLO4cX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2481DE8B5;
	Fri, 16 Jan 2026 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768581250; cv=none; b=sLWzq84uqj+nLHuFScx2a1RV5WZjv/fadnQrU3NUyLy51QPMHsLYKWgs1K5X4rxn0sTrJxk0P4h701FmMRQR0V5dVmDgPZF4OO1KoSom6wyGd9P30oaPjTaVBNmrdYWi5ZwIM+ZzGPzXwLHcgRgDxS9AKX5C7Vw4JrsU2IrNKLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768581250; c=relaxed/simple;
	bh=lIn5nB5OQV163d2ql4SG5TBcf+LgicpAVm533/xb4l8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pmpjk6w1t3YWBYrHd1BBqIH3zAXkxC2DzC3cqOGiDrBwUlH3DIlNnS8RiWDBirowQSVy7gq4CzowLi8wLCwDtrUipAGzgon3KPzjRtIXYRB19aIY8uFNVjGn8h4QJ4Lcm1MxkqgqRXM7vkDNArmmwc9OaYL3fyy/yfk0RTpeAAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+tLO4cX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D14C116C6;
	Fri, 16 Jan 2026 16:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768581249;
	bh=lIn5nB5OQV163d2ql4SG5TBcf+LgicpAVm533/xb4l8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O+tLO4cXRTxsshxKnwXjaoCH3yFfxa2A6Yf0JEEcUTCxEvfUzpCPbNKnRUbE0vg3u
	 GwIyxXFD86kD8Ks2daoxgFU4UEMO2LY3a0YsuxY2ifiaiLaTqEw0HuHJw+im3LQsoA
	 JI4rHTpRKDHMuz/PvtOPV+05i2fYVG8f2EvtW2k28YeftJaFbnGaQA93nlehGLVqCh
	 qtGaPQF0z9J1sp2Czk4Sd9Ubh/zYpEHFjTt0at+SJNjAdj4n7SUdhW/ZwSQtqQ/GL9
	 RqhosQ5qhaFw2gTDQG8O/R2JjRDkG6fS6+Mq8Uikt1Z1ic3jO0CrecO7DN+fMzcUT1
	 o3CjTD9JhvL+A==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vgmly-000000005i7-2rA6;
	Fri, 16 Jan 2026 17:34:06 +0100
Date: Fri, 16 Jan 2026 17:34:06 +0100
From: Johan Hovold <johan@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Mikko Perttunen <mperttunen@nvidia.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH] drm/tegra: dsi: fix device leak on probe
Message-ID: <aWpofkwmsgebJcqS@hovoldconsulting.com>
References: <20251121164201.13188-1-johan@kernel.org>
 <aWd3iFrujbRWyyyx@hovoldconsulting.com>
 <aWorgofgDfxprcPG@orome>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TQRmpdojEzv5eG6Y"
Content-Disposition: inline
In-Reply-To: <aWorgofgDfxprcPG@orome>


--TQRmpdojEzv5eG6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 01:14:19PM +0100, Thierry Reding wrote:
> On Wed, Jan 14, 2026 at 12:01:28PM +0100, Johan Hovold wrote:
> > On Fri, Nov 21, 2025 at 05:42:01PM +0100, Johan Hovold wrote:
> > > Make sure to drop the reference taken when looking up the companion
> > > (ganged) device and its driver data during probe().
> > >=20
> > > Note that holding a reference to a device does not prevent its driver
> > > data from going away so there is no point in keeping the reference.
> > >=20
> > > Fixes: e94236cde4d5 ("drm/tegra: dsi: Add ganged mode support")
> > > Fixes: 221e3638feb8 ("drm/tegra: Fix reference leak in tegra_dsi_gang=
ed_probe")
> > > Cc: stable@vger.kernel.org	# 3.19: 221e3638feb8
> > > Cc: Thierry Reding <treding@nvidia.com>
> > > Signed-off-by: Johan Hovold <johan@kernel.org>
> >=20
> > Can this one be picked up now?
>=20
> Sorry, forgot to notify you earlier that I've picked this up into
> drm-misc-next.

No worries, I noticed this morning when looking at linux-next.

Thanks!

Johan

--TQRmpdojEzv5eG6Y
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCaWpoehsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQC8XNwux9ZQiKzQEAuHemijv/bXDzxOez/BpB
GARmxhti5zQMoBULYZDJ6VsA/0a3Z/9CihqvoQLTuqEOvkd0yldVIvsaL2mwwrY3
NEcE
=PgyA
-----END PGP SIGNATURE-----

--TQRmpdojEzv5eG6Y--

