Return-Path: <stable+bounces-108072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F67A0726D
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 11:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAECD1885CE2
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 10:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEED21578B;
	Thu,  9 Jan 2025 10:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="IclCkFAw"
X-Original-To: stable@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A136121577F
	for <stable@vger.kernel.org>; Thu,  9 Jan 2025 10:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736417350; cv=none; b=GT57eDnjmv/1QaJ5LUmB+G0kFQ01yIvz3kttlMicKPahDsl/z7Znhjyet4IMn8dwfnpjHeoyYiOhc7oMprBYoHG2mxwn6zr5BF3/GxARL8XJ4ma18sJXrOZ1XmlAz9s6IQYJZRvV48yiejiGgg40ZT2BzVvAOOz+L1ekVISVmUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736417350; c=relaxed/simple;
	bh=/VryW5ujGq6JBeWUyzO7YRMqTwfR0XLmEtQ2i/FfvjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hpwwr8pFmcQOgNE0SKyoasWUHha0q1Wd8Tjwzm0olNt/OG5pHQ9mDWLpxQaMedApSgJKOasHpJYxVVjj5aItNXlmdmk7y3B2RfbJBHS15wjSlP+S+unY48Pg3sNzHkBNzkcss2NeRhtmos7Bpldtt/CpzNNVKb/HO0Hfu4YtlgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=IclCkFAw; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=/Vry
	W5ujGq6JBeWUyzO7YRMqTwfR0XLmEtQ2i/FfvjQ=; b=IclCkFAw9MZG8cmqMjGk
	xHoNQ9q5NQWj+j2/IHzF1tlIerO0XfOn5wXNeDgQGZrw5EWS2z/sd0AXNO9RR/f5
	ey/y/3+lw3c4d4Xlz3kj10gQpdhM09INsYY1ADNJP1Pyy6g8cRCHhQ7hr0Ix/QCw
	m4gYhr0gIa8JSbhuVYb2sc6wvZy1Rq6kKJ8Oxbv3OLv/jjqyo6L3y8t7OndDuaVg
	KFFPJ51P91B2Ku56QkMDKj84edgu5DE3l+BlmpxT3z5VuY0dMUOaEk1gaXT8FaVu
	ynA9Q/ShjtXAZR0ITRbEZhsi9ptIPUu13CGSwraPFpziAhI19oxR0HHajJUf/hid
	Gg==
Received: (qmail 2864054 invoked from network); 9 Jan 2025 11:09:05 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 9 Jan 2025 11:09:05 +0100
X-UD-Smtp-Session: l3s3148p1@1e0JK0MrMuwgAwDPXw20AOMQ2KO98fSH
Date: Thu, 9 Jan 2025 11:09:05 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wolfram Sang <wsa@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] i2c: atr: Fix client detach
Message-ID: <Z3-gQcui8PbEUGZW@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wolfram Sang <wsa@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
	stable@vger.kernel.org
References: <20241122-i2c-atr-fixes-v2-0-0acd325b6916@ideasonboard.com>
 <20241122-i2c-atr-fixes-v2-1-0acd325b6916@ideasonboard.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8/uD0BkUaIsMXUbi"
Content-Disposition: inline
In-Reply-To: <20241122-i2c-atr-fixes-v2-1-0acd325b6916@ideasonboard.com>


--8/uD0BkUaIsMXUbi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 02:26:18PM +0200, Tomi Valkeinen wrote:
> From: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
>=20
> i2c-atr catches the BUS_NOTIFY_DEL_DEVICE event on the bus and removes
> the translation by calling i2c_atr_detach_client().
>=20
> However, BUS_NOTIFY_DEL_DEVICE happens when the device is about to be
> removed from this bus, i.e. before removal, and thus before calling
> .remove() on the driver. If the driver happens to do any i2c
> transactions in its remove(), they will fail.
>=20
> Fix this by catching BUS_NOTIFY_REMOVED_DEVICE instead, thus removing
> the translation only after the device is actually removed.
>=20
> Fixes: a076a860acae ("media: i2c: add I2C Address Translator (ATR) suppor=
t")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>

Applied to for-current, thanks!


--8/uD0BkUaIsMXUbi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmd/oEAACgkQFA3kzBSg
KbYEYg/7BdKqdlniYnV0irGpiKZ/z1FqujCnAFo9VsV0YVkDMJB9Dr6t3NvgBjN5
zNX99Hi19p2XYEg0bH7ujp4jrxzpKCD0L6WGd1w5iL7iv+PD47bSd6m2cPQcziP4
RDifEvwQO2kKTcpyMDSt2puZ2+CPdKo6Hq/oM8At5pwEflBB1WgXFtvq8Is9MI4G
yPccKiEQF739c9+c1JJhqLDxojq7Y3mCJ2CJzi5yU5bnmRnRgJJ9iDu/RdjI92Fg
+UwH0LJ4+5naAaDPoXKEq9nVmGk7gnKoF9G/jLu+G/Vgd1818QWfSf+0n7TrkubE
nbENk0vnhebYgcnAXMJBaSFEFdgRQ50nm8ZeI4vPsB0XfI1lRTdQbwlpzFLAiny4
co/bph4+8DjiSNfO2B8eDo5dN93IBLtui/Rux9nfqTLEb6CHpTfAnRTQhAV67WjJ
RDss1NGwgs4S4nysPrQfbf87XKIicypO6jLYcUW8E0NgWReFrwhffsbXdC2beJqM
957A360QZFKIdtArmItDM04QYxlMP+XkwO3tQNleTAC0tinml+nNf4HK1wNrEuCK
xovKC7s3C4HWMbD8M/ISzJg7I+Ix+cPo4C9Cj+e8BUdkXvtAa/8FoVfJHYX2BxiO
fJb59dJWPvXLThDA3IvtHXily4X9r1gTHjUWvVloRJgFzEHauVQ=
=YcNM
-----END PGP SIGNATURE-----

--8/uD0BkUaIsMXUbi--

