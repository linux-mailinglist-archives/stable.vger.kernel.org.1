Return-Path: <stable+bounces-166920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8474B1F5A8
	for <lists+stable@lfdr.de>; Sat,  9 Aug 2025 19:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C28CC560448
	for <lists+stable@lfdr.de>; Sat,  9 Aug 2025 17:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA912BEC52;
	Sat,  9 Aug 2025 17:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="UpdC7Emb"
X-Original-To: stable@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7652BE7BA
	for <stable@vger.kernel.org>; Sat,  9 Aug 2025 17:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754760904; cv=none; b=Vwwa/KzcYpCaW1wrscgtIfQxrLnAis/rtS6yatEFxg9EpXx61/AM5t7SQKxapNaR3+dMw0AhbQ32qJHQgLdeEY/2SBdkIR0m4MFmUVcnPqIpN/G4MnXY3aJUOG6e3OZBT6mdZ8n08FjdnrRnYROUNep+xlzAsvi19DFizjbpiXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754760904; c=relaxed/simple;
	bh=GaiXKFj06EKzWM3cwTRt4zPflhb4z5ZAlRARKzBicFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k32wUNZEGDs6Tosl5Ip67Xsk25oBSk/TTk5CpJuSc5X+Mdawg4+JvCkhrIJeZcSxAK3GISCsHaHsEZkQXffi6uo2iL5fSgU2wmZFxBWal6ZmJhvRp+ndDUxsZkaCZg6BYTPrsZA1MDfkTsI8GrARxRvXYKOZsLBsA+wMrS2jr9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=UpdC7Emb; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=Jy4R
	CQzC4CWh7/PrWweAqu8kFz7W0uIQuS9di8xCb2c=; b=UpdC7Embea6HoDCi1ZBL
	XjXLFw5WqgPgwVRhN2T2nNUj6GO1vfeSruEAJOH2C3gGhDrka/4Swsf8G0J5KP6u
	5Xt3wuWcDwZXvJVfaJpm5p7VN+Zrtmym2EcW+0WSfzow+6lY3EWdhmPGHwIMnu+b
	ODqI1Fv7GxBccakzlQ2H0S9tUA5S52paifgH+ZJ3Ljwn8UdQIS96R/n3zwEcGfQZ
	vv7Z//X3eL6OX5CEdp5Rz2fZPmds/uJrFenYQd9BH38eSu98BHANdUAAQGl89hbr
	rQg69JG796EHDEqwy7fWIHeTwxOY1XfgiaGGLBaPjQ/WwlzxrWvH1ywSwZtqIRaX
	TQ==
Received: (qmail 2148172 invoked from network); 9 Aug 2025 19:34:56 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 9 Aug 2025 19:34:56 +0200
X-UD-Smtp-Session: l3s3148p1@GcHUG/I7iONtKDNQ
Date: Sat, 9 Aug 2025 19:34:54 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Sven Eckelmann <sven@narfation.org>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	Harshal Gohel <hg@simonwunderlich.de>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Alex Guo <alexguo1023@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH i2c-host-fixes v4 1/5] i2c: rtl9300: Fix out-of-bounds
 bug in rtl9300_i2c_smbus_xfer
Message-ID: <aJeGvoSYS5Raqxyk@shikoro>
References: <20250809-i2c-rtl9300-multi-byte-v4-0-d71dd5eb6121@narfation.org>
 <20250809-i2c-rtl9300-multi-byte-v4-1-d71dd5eb6121@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LLfJenckN6oSwQa8"
Content-Disposition: inline
In-Reply-To: <20250809-i2c-rtl9300-multi-byte-v4-1-d71dd5eb6121@narfation.org>


--LLfJenckN6oSwQa8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 09, 2025 at 08:40:54AM +0200, Sven Eckelmann wrote:
> From: Alex Guo <alexguo1023@gmail.com>
>=20
> The data->block[0] variable comes from user. Without proper check,
> the variable may be very large to cause an out-of-bounds bug.
>=20
> Fix this bug by checking the value of data->block[0] first.
>=20
> 1. commit 39244cc75482 ("i2c: ismt: Fix an out-of-bounds bug in
>    ismt_access()")
> 2. commit 92fbb6d1296f ("i2c: xgene-slimpro: Fix out-of-bounds bug in
>    xgene_slimpro_i2c_xfer()")
>=20
> Cc: <stable@vger.kernel.org>
> Fixes: c366be720235 ("i2c: Add driver for the RTL9300 I2C controller")
> Signed-off-by: Alex Guo <alexguo1023@gmail.com>
> Reviewed-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Tested-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--LLfJenckN6oSwQa8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmiXhrsACgkQFA3kzBSg
KbYsxg//c6JAqXX7UQ3nihMt2s+4Z5AfdahtyhF0v3L4ccT+YtXGxFP3JNftpeec
HBT9s3t+0V6Y4kI8sVOZ49xw4D4UxAJqDijOSn927S/j4geEBd8DOV+hwnn8cSzs
JiclnehZ5Uhu7WcsTYWx49QmrpFbWCr5X5OaGH7PR2ObAfDfSly1GEIdrPNFASig
gIViZmSvLmcttuq4cDwX32KU0xbFwq3y8pJ7szSv/TbCTyAh0tHAanuVoLBHSkVt
sUhMoAGh2JPXKloC4tdvpzS4xedw90nz8d5W2kG71NusCsmEpQMWmk5A622GH1GR
fTS7Tr+j9++i4xxVFl5ybf3k5F120mWqCPlZJdRd5aF5/2aFL1Aks+KzwlPVRuB0
2I8bsppQ6CVwYz9WqiYuFMvlR/cCmBnTgANSrfXIIOf1UKYiUSdkbYYR/RxBwrRa
AjlxyxT0FpBSXFtnG0vd01iQxOhWCx6WmLAkGanCVPT9Mw/R5b3XbFk4OnCV2c7U
R8JFC7bP/2j+TIK+az6rUZ5+P+uPGQH/hwIpHHdTkzKz/kWe1wyJEM3jDnF7ot9h
xWnxSh25bkV3X2XuclD/OszsVQiIeKK6THDcaNMH5QOonE/Zq581nmkxAN0T5rNK
HdMcUfw7LNDCxLauP7Y2cW6a/I7dAHe/bjgaBQYpds+li6+GMdU=
=19xn
-----END PGP SIGNATURE-----

--LLfJenckN6oSwQa8--

