Return-Path: <stable+bounces-151315-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13828ACDB42
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 11:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 362E618833A6
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 09:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC7F28CF40;
	Wed,  4 Jun 2025 09:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bK4/H9u1"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92E028D8C0
	for <stable@vger.kernel.org>; Wed,  4 Jun 2025 09:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749030054; cv=none; b=C+FAW23DJVdo5cexd45z+ixUB9URAv7xuBQxJajHkPh0gleKCOVcDOBzn2rTS65l8bLMM+ERMpbw9BC8xLua3wtSirldgctc2zOxjdncfmUyElrSWahrlt1/53IcH5L7RvosVmq7hEBTVrhR5ZJlKabLeB1mY2nAwgx5SZjbuiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749030054; c=relaxed/simple;
	bh=as+iSqghy6GNwaA1sewJZbV6woQhiRpSAU5ONykIl0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhdGBh7tkPDBp+a/Nq8ivmun5ogkX88v4WEUeckHb2YB8Cx6KjDrpBSgcq5Df0I6vxf8KgSWVgxt+h105+bZaSJKCJ2Ws9fymBe6/Q5Zt1+OkmBE9dM/aSH+OF9UQjYD/0QQwTusjU8+FxLQceoSbt3ueyd/xVx7TdHK8I7EgqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bK4/H9u1; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a375888197so3394914f8f.0
        for <stable@vger.kernel.org>; Wed, 04 Jun 2025 02:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749030048; x=1749634848; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JYI3oUdEvBapqkfwny3CdaVIKxOUyl9weCW1cN9D3mU=;
        b=bK4/H9u1EV0Wzd0X1NQF5GosLquWT7VCGdMUoQQYAcoF+bGgB0zw5s1R3nzS4NSYQj
         lbf/A30sRJeonkK+VKYTXpVTui1UcQbdc/x0QuXlBNdFmx5WnJ5azWmNocoaA1w9IbRZ
         YES+dL8reXH+q3Pr6ozkOucUL0rn3VdVkqsOgT7zzcuZfuF7LvghFB2x9I07t1If3Vai
         1fpB4RN8RsZmNnYUe7TtivtLzvcGwcIAMZ4vNNRKRx+aH6Wj28PJCpge6Jls2vMAHu8L
         HNi0uEC0ScnVijs7k6cP/mmOjwgSNDFksBstAyKyDq2I1zrB7o/pKpS4dcnjDqrQdjLw
         Pk7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749030048; x=1749634848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYI3oUdEvBapqkfwny3CdaVIKxOUyl9weCW1cN9D3mU=;
        b=TL7OOVzamB40UTKd54oX0hsET7/Nmcgi84j+wqMVivFdyt1C7Hr8SeNhiVRQks4qSD
         r5Q+vWO3nSROSejkGnTgdty8Z3DeNdMKmwYGu2y8Tmz9ojAH6sbm05+1T/pZPJxQLXLk
         OBO1hwPPCN4sngxcBRusO9XYlw375urRYOJg+l3wfQDUhzqFKW/N05vUm/fLH6IBvHj6
         Lg1YtQqSHxPrf9jk9TrtZ7Gl4DTuw9nBmTSKX9y24N3e3sd20iCXqyrS908c1UMMFf1M
         v9wVJLxJAGL/OyKReHoD6ksCZO6iO/ngRL7DSp82AXDAtc48jxP+ZTpc6nxJY4n42WOu
         NZIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxnc37BqSLxgqMuqf6WzOQvr/ueloQqnhYHLS4xQJbHHbkvf7lPysMEW6d21GX/A0q4+A23vY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4v6FcQcc+9b6wZs0S/I4fSnyZXbjSZSQxpnVTUGTjY03/BhpV
	ZCR8bq2kAXS4VJvih6eTHAyRbMufRHVUhw7yysh6V6n6D4pBa6+m5o7B2ZzYLvazC5g=
X-Gm-Gg: ASbGncs5fVQJUEvTRkmt0axw0gUpeF3qDD+2TbmQ1w8wNfYHFlvny+WUVFKgDymQFKo
	phOjWJEq9mV6pWW8Y8pCvfceKSMpd87bAdrMG4UoFDVlh5J+gb7fq1bBuZ7PiQAM6KZ6i+7vusp
	q26KLOvbuVKSTl55ayWZghbVzPVdJNaRKHxNuBwXXOdLiWkbCNvh1UX/BypHPwbULExjdobTsyt
	+77mhflz50NkWMAxJiZgNDvMMPOJ4R9OjvvFDLhbqF3QrjxpSWyf/FdxJX3Guz98cvC4ZhV/ACX
	rLBO4MtPKPJ06nkS79cLXTaNeTeJK8GwvGB2flD7Pd0HIHRpd63pifHM5vJrVjtktlgYW94fA7E
	Q+eBxBoMWHAIP9sN+PA==
X-Google-Smtp-Source: AGHT+IGlDLmpPl2zCWmrTLJq7SUerDnsdxtYZFczMcw9Hq88U0jJtCHAgf74LzMfHqeRTtLEa6i0Qw==
X-Received: by 2002:a05:6000:2913:b0:3a3:6415:96c8 with SMTP id ffacd0b85a97d-3a51d973ce1mr1542135f8f.41.1749030048074;
        Wed, 04 Jun 2025 02:40:48 -0700 (PDT)
Received: from localhost (p200300f65f13c80400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f13:c804::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a4efe6c8b4sm21566932f8f.36.2025.06.04.02.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 02:40:47 -0700 (PDT)
Date: Wed, 4 Jun 2025 11:40:46 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>, stable@vger.kernel.org, 
	Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] Revert "drm/amd/display: more liberal vmin/vmax update
 for freesync"
Message-ID: <jn3rvqffhemwjltd6z5ssa2lfpszsw4w7c4kjmkqqbum6zqvmi@pv6x2rkbeys6>
References: <20250530200918.391912-1-aurabindo.pillai@amd.com>
 <CADnq5_P1Wf+QmV7Xivk7j-0uSsZHD3VcoROUoSoRa2oYmcO2jw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gzfrlhuuaavchuze"
Content-Disposition: inline
In-Reply-To: <CADnq5_P1Wf+QmV7Xivk7j-0uSsZHD3VcoROUoSoRa2oYmcO2jw@mail.gmail.com>


--gzfrlhuuaavchuze
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] Revert "drm/amd/display: more liberal vmin/vmax update
 for freesync"
MIME-Version: 1.0

Hello Alex,

On Fri, May 30, 2025 at 04:14:09PM -0400, Alex Deucher wrote:
> On Fri, May 30, 2025 at 4:09=E2=80=AFPM Aurabindo Pillai
> <aurabindo.pillai@amd.com> wrote:
> >
> > This reverts commit 219898d29c438d8ec34a5560fac4ea8f6b8d4f20 since it
> > causes regressions on certain configs. Revert until the issue can be
> > isolated and debugged.
> >
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4238
> > Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> > Acked-by: Alex Deucher <alexander.deucher@amd.com>
>=20
> Already included in my -fixes PR for this week:
> https://lists.freedesktop.org/archives/amd-gfx/2025-May/125350.html

Note the way this was done isn't maximally friendly to our stable
maintainers though.

The commit in your tree (1b824eef269db44d068bbc0de74c94a8e8f9ce02) is a
tad better than the patch that Aurabindo sent as it has:

	This reverts commit cfb2d41831ee5647a4ae0ea7c24971a92d5dfa0d ...

which at least is a known commit and has Cc: stable.

However this is still a bit confusing as commit cfb2d41831ee has no Cc:
stable, but a duplicate in mainline: f1c6be3999d2 that has Cc: stable.

So f1c6be3999d2 was backported to 6.14.7 (commit
4ec308a4104bc71a431c75cc9babf49303645617), 6.12.29 (commit
468034a06a6e8043c5b50f9cd0cac730a6e497b5) and 6.6.91 (commit
c8a91debb020298c74bba0b9b6ed720fa98dc4a9). But it might not be obvious
that 1b824eef269db44d068bbc0de74c94a8e8f9ce02 needs backporting to trees
that don't contain cfb2d41831ee (or a backport of it).

Please keep an eye on that change that it gets properly backported.

Best regards
Uwe

--gzfrlhuuaavchuze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhAFJoACgkQj4D7WH0S
/k5n6wf/VlmfUOIe50cqBTUUIeeMNPBzDFT/pZ3xuy9BtsWt0RBVULTZv7v9YjGy
0ab2JCut1k2lBa3p77E6KTLkkeWgitWNBauo45cenQOj+EQBZnHOViNJmjfP5f7+
4d/GOCV2fZwwR3QDQmc50j2NqkMVs3hPYk7mv4RBEtRjyZJBNtnYBCNl1zZqIZw/
s7RjTnsXli8iUfDJwlu1Sk1RHv6sOtodWhSIaylwRag5+oGyxYNtW9KCMjOrrIbZ
i6DLxABGY7Nt3EPtTkvcTBAYOXmMNrxDRTvu1Njek0B5aCQkgnyEzqd1vplRgIkG
ahM1uNWSyCHT/zCjx9+7CGwcj8nMYw==
=drHe
-----END PGP SIGNATURE-----

--gzfrlhuuaavchuze--

