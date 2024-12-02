Return-Path: <stable+bounces-95994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE949E00C6
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 12:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34FBD281533
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 11:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F30B1FA175;
	Mon,  2 Dec 2024 11:40:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from manchmal.in-ulm.de (manchmal.in-ulm.de [217.10.9.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184F11D932F
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 11:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.9.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733139606; cv=none; b=PtAFzWwSCPJs7O3D9Nam0pFGTyy2OLFeWOvaa9btzGkNS+8x6fb3cpboe9ytMjIa88tqu/4oMUeal3KlwjVCzF+1/VOvrrO+Aa8AdtXcGS3ORGj5UjZTFGrircpMgsnyJD+0WDwt/EhaeJ4sItJRbgAKFuIBcZO/bQSBboMrqtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733139606; c=relaxed/simple;
	bh=FJMhoaaRNnNJDTU0+pQdUKlkrTJXMrECZgUlazxVYBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJkUTYT5h/5b5TnqkubGICfrheHNORM5oAQRDEYorQROTjbQ8Pegd4A9riQw5D4R7zY6LAy7pDL/MS6MyP4OogYrPtRdidt1fozpSS+Wg2DZdnHghuOQ0WEa4ShzNI49p70wI56tVGxPamjokCdOGGpQIK5xmBZx9Jg7wmEPiqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=manchmal.in-ulm.de; spf=pass smtp.mailfrom=manchmal.in-ulm.de; arc=none smtp.client-ip=217.10.9.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=manchmal.in-ulm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manchmal.in-ulm.de
Date: Mon, 2 Dec 2024 12:33:48 +0100
From: Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	"Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>
Subject: Re: drm/amd/display: Pass pwrseq inst for backlight and ABM
Message-ID: <1733138635@msgid.manchmal.in-ulm.de>
References: <CADnq5_PCqgDS=2Gh3QScfhutgY4wf4hoS15fW5Ox-nziXWGnBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Whtp/Gp/cK3HnY/o"
Content-Disposition: inline
In-Reply-To: <CADnq5_PCqgDS=2Gh3QScfhutgY4wf4hoS15fW5Ox-nziXWGnBg@mail.gmail.com>


--Whtp/Gp/cK3HnY/o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Alex Deucher wrote... [ back in January ]

> Please cherry pick upstream commit b17ef04bf3a4 ("drm/amd/display:
> Pass pwrseq inst for backlight and ABM") to stable kernel 6.6.x and
> newer.
>
> This fixes broken backlight adjustment on some AMD platforms with eDP pan=
els.

Hello,

tl;dr: Was it possible to have this in 6.1.y?

after a lenghty bisect session it seems[1] this commit b17ef04bf3a4
("drm/amd/display: Pass pwrseq inst for backlight and ABM") indeed
fixes an issue with a HP mt645[2]: Without it, the backlight stays at
full brightness all the time, writing various values to the usual sysfs
place has no effect.

That commit was backported to 6.6.y (as 71be0f674070) but not to 6.1.y -
which is the series where I'd like to see that issue fixed. However, is
does not apply, lot of failed hunks and missing files. So I was
wondering whether it had been skipped deliberately because a backport
was deemed impossible - or whether it might be doable with some
more-than-usual effort. In the latter case, I might be willing to do the
task, but quite frankly, lacking any understanding of what the code
does, I'd only try to resolve the conflicts and check whether things
work.

So I'd be glad if you could give me some insight here: Would it be worth
the efforts trying to bring this to 6.1.y?

Kind regards,

    Christoph

[1] Being a bit blurry here for a reason: I bisected on the 6.6.y
branch, had to skip several commits as X would no longer start, and
ended up with

| There are only 'skip'ped commits left to test.
| The first bad commit could be any of:
| 18562b1691e2280858f291d00678468cf70bda5a
| a5ba95c226b5c25cd5c8b9df29a1953c85a1531e
| 71be0f674070a5ad54a1c4fb112bb2923b28ea50
| We cannot bisect more!

where the last one looks like the most obvious candidate, even more
after reading this thread, and re-testing with that one on top of the
last usable commit indeed gave a positive result.

[2]
=46rom lspci:

| e5:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [A=
MD/ATI] Rembrandt [Radeon 680M] [1002:1681] (rev 0d)

--Whtp/Gp/cK3HnY/o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEWXMI+726A12MfJXdxCxY61kUkv0FAmdNmxgACgkQxCxY61kU
kv2mhQ//Ruc2UNtc3AZi6pKpL0/QbKVcUFdcZTpHdsipfeITBr04SQI06xWYPpZV
4ltj5+JfB1o93H68WkjsKMyBBmaz4BnMMebRdpjFbWln7KA0OTt2pJemVrnPRo2Y
7bv0sDzGyZH/USYjD70e9QOAI3gQG686TEUX/TWp707/+XX827dQEXNcxu8OmXPn
RohqFIs/dQvs6dhcJlB1O6ipo296PLOOiTS6a4hMBb/8iY4TUVbKebVCnO0CpUL0
ks4ad0DyBMTrCQTAaLKjOdcx80b2V3wsuFy2jeXN5ptnyfUC2gdgs7wthhabsM10
yzL9KQRXmV/M3TrdR/ItqtnRqj+kGy+AhzAOC4Ko6XvgS6WSfKwfc2jxPO2p1gEg
EfjkYPDJGF1Le7K7L/TozJBVg58iczVcBtc8tSQ2+l1gfF9n2Q+WpOKQCW87nQ3E
q/nB1YNiFCUw1B/8Nbw7iZPKQxag5T/Iaa66mP8RIX7AFGpWQ382z0Oga0SwlET5
PErXeEd8dljVofZRCncQFy+lgwDLaTv0iZyGsF9cGV62E/0eO0CQkJC8oGT8SDwM
nOk6E83oqMB/tKxMm3HTZBvhYIRpwWYsVCMkxSSMYM7YxsaWUVqnqlrycYwaS8Tv
7fdaE2LAyZD8TfKgnBEVQN2xtEi2qZzd7n4VhGHBc8ynbC7ITRc=
=JRsF
-----END PGP SIGNATURE-----

--Whtp/Gp/cK3HnY/o--

