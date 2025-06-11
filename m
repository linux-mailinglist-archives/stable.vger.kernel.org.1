Return-Path: <stable+bounces-152398-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B10AD4AB8
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 08:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 382EB18979DA
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 06:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B765322687B;
	Wed, 11 Jun 2025 06:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="M5sE3XhZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BA21A28D
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 06:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749622113; cv=none; b=Dwx4rHzvgddmnm6T7yX5bvqdaSSXFA5MicfLBJB2HXBxqLzglviBFcFn53PwLiJJj4SYzmTSpwAJSQDXQEuFhjZXYE3IjVnUIU8XYnHzqo9Sq6ZLB1/wjjDkFMS/Z+XvW0fwHOGJjcc/aUCEkmgTD7JA64/Kqpbszxn5OwdSjNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749622113; c=relaxed/simple;
	bh=TzI4EeoPs8NkEW/D/TgALJ78j9b3ryyNH132NqXFP3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRmDiIuriGjEWa9U6atryn1aqlkxSjzIxBIu66qVmZkuVxk3yM5/pzuhS6/iNHdYTKOJEWBQVBVgX4MGGz3vpwfRdnAUNE9mDMjYOF9+g6xFv2BZr36vMH4kdrXAuth4UG3+SozJ+m7BzScHsKzJ5ZbBHxMxXrT5ZDMw2bvpcnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=M5sE3XhZ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-451d7b50815so54240365e9.2
        for <stable@vger.kernel.org>; Tue, 10 Jun 2025 23:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749622109; x=1750226909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PrBSD9FEMHISLkiX4p/Xsv7B3ZBXZdp0s4Om8LRZf1Q=;
        b=M5sE3XhZC/KprXxIaqvjtJcfW6rx/16d7ruQW9BQkvaqdtfToenqDhZqGMkY/19d/R
         eTaXFuIB0NsmmAM0LTLazBPx+18cxetEPKnkpb0xmbtMclq4y+6ggrRjkLIAqQ2bE4Uh
         Qbvv30BGyg80Cl9S9VMmJ12gB7yrAFdWDxXj+/IXho/BL25fHleaWjz57Ru8rpUFtrNR
         3yreTxygKuiredWyTQK2a5rmcVeDzvrK3u93UgYKWCpm5e/aPJwABo1UBjAWjguHQjvj
         LG58Y3qidrgjhqG63IOlqesFet8PAQ9R6V0HncZfFbXo84Vu4BZgGtazxffFQ948xAtg
         FbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749622109; x=1750226909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PrBSD9FEMHISLkiX4p/Xsv7B3ZBXZdp0s4Om8LRZf1Q=;
        b=e0YYjE58XH07Mqcev1nHCIPWJbczKudvkMZroRxt5QsqCddKToIE5FbQlhUQQt3Xyp
         KjnPCZYEiYCOIwJGQO12bXnvDd/j8t6UesdgdZN73bqnnCCIKgZnAoHloWyZrdBnSMRP
         EzR8v2ZS3JNbRxu0NOkHVQFRU7KT2x0TIT5mTWFAMPFGWhJ3FpJPOI5J1tW+W6RUjy2u
         /iiJjbn7NXMotRpZ4jiycN8MNWS15UtU2RpmVWkP3BwtzZSCQWypo0lbxos0WKe5BxNO
         eQ6WQYvYG0urzSzgV+kKbH7+a7OCQAVuJKbeqhazDmNAQj4q9FeLg48CAQ+wvm716IvI
         WXxA==
X-Forwarded-Encrypted: i=1; AJvYcCXbVOqIvXU7NErhHkXa4y99SBLQdKXi4yvN0ikn36Gl7y0kzdXePnEmkobbEvH+PRl1U72kC3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGBhWpR3RPlrF2jSuN6upWgpd5jsikQd7b1KFY9n/kMnmw9teB
	54h11r10D4H6nIIad+l7ZotcYxf0pdsjE5Lv+eXjw1UjUQmfFFIY8P5IpawWRFI+GiI=
X-Gm-Gg: ASbGnct8MGhKNqCZujVhOrgRzKucAupv4pmXDLHE7gQsfI/pOZD/lkdMKwSe+e4z6M1
	zvfkbIcBODk1+eO7iwrKmn4/VyYpG8gyx/ee558Yuje1+BOfnpJ60TkF+SqttqSBF0tNoc0FSrE
	FK7fRXNVi8XomupeDLjjxYHM1GcPxaAVnf/H9udXfle3c5yo/l65KIyOvWcUxYhyiJVzDXYe39H
	v25wzKepI9Z3HBygd7zcldKkKq7vKIDpfo7Thr8nzYm0HZLeCOEeP/9b3n4TkCpEGYbzIYO8y5k
	+7aJd0wn4CNHU+SR3Xchn1Q9f+1Dh4IQ9yThuqVx+/LTd6jEksgwi5AH9pRmRgb5cvxxLuVibs4
	Xg8cxUJTcE+8KlQBdYc9TUCK9uZ9g
X-Google-Smtp-Source: AGHT+IH9h6uvDdHKxP8MZ5QkofkFY0poxLBfsPG1vwe/7Q1zOw5Z3lbJcHdNFhJYAGpVfHz3Mm75iA==
X-Received: by 2002:a05:600c:3e85:b0:43c:f629:66f4 with SMTP id 5b1f17b1804b1-45324cfb301mr12517495e9.0.1749622108675;
        Tue, 10 Jun 2025 23:08:28 -0700 (PDT)
Received: from localhost (p200300f65f13c80400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f13:c804::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45325160ebbsm10675475e9.14.2025.06.10.23.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 23:08:28 -0700 (PDT)
Date: Wed, 11 Jun 2025 08:08:25 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Cassio Neri <cassio.neri@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Alexandre Mergnat <amergnat@baylibre.com>, 
	stable@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH 5.10.y 2/3] rtc: Make rtc_time64_to_tm() support dates
 before 1970
Message-ID: <gmtaj7qyeas7ehtgdek4sivwgyuzrvq3whm5crwlxeoan3kxi5@oijfw2afn7em>
References: <cover.1749539184.git.u.kleine-koenig@baylibre.com>
 <955e2c8f70e95f401530404a72d5bec1dc3dd2aa.1749539184.git.u.kleine-koenig@baylibre.com>
 <CAOfgUPg0Z6e5+awuqVMa7QUPiJ7aPp-dX6QNk80Y-bhpBYcsoQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="anlvrwtevjodh2tk"
Content-Disposition: inline
In-Reply-To: <CAOfgUPg0Z6e5+awuqVMa7QUPiJ7aPp-dX6QNk80Y-bhpBYcsoQ@mail.gmail.com>


--anlvrwtevjodh2tk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 5.10.y 2/3] rtc: Make rtc_time64_to_tm() support dates
 before 1970
MIME-Version: 1.0

Hello Cassio,

thanks for your input.

On Tue, Jun 10, 2025 at 09:31:48PM +0100, Cassio Neri wrote:
> Although untested, I'm pretty sure that with very small changes, the
> previous revision (1d1bb12) can handle dates prior to 1970-01-01 with no
> need to add extra branches or arithmetic operations. Indeed, 1d1bb12
> contains:
>=20
> <code>
> /* time must be positive */
> days =3D div_s64_rem(time, 86400, &secs);
>=20
> /* day of the week, 1970-01-01 was a Thursday */
> tm->tm_wday =3D (days + 4) % 7;
>=20
> /* long comments */
>=20
> udays =3D ((u32) days) + 719468;
> </code>
>=20
> This could have been changed to:
>=20
> <code>
> /* time must be >=3D  -719468 * 86400 which corresponds to 0000-03-01 */
> udays =3D div_u64_rem(time + 719468 * 86400, 86400, &secs);
>=20
> /* day of the week, 0000-03-01 was a Wednesday (in the proleptic Gregorian
> calendar)  */
> tm->tm_wday =3D (days + 3) % 7;
>=20
> /* long comments */
> </code>
>=20
> Indeed, the addition of 719468 * 86400 to `time` makes `days` to be 719468
> more than it should be. Therefore, in the calculation of `udays`, the
> addition of 719468 becomes unnecessary and thus, `udays =3D=3D days`. Mor=
eover,
> this means that `days` can be removed altogether and replaced by `udays`.
> (Not the other way around because in the remaining code `udays` must be
> u32.)
>=20
> Now, 719468 % 7 =3D 1 and thus tm->wday is 1 day after what it should be =
and
> we correct that by adding 3 instead of 4.
>=20
> Therefore, I suggest these changes on top of 1d1bb12 instead of those made
> in 7df4cfe. Since you're working on this, can I please kindly suggest two
> other changes?

It's to late for "instead", and we're discussing a backport to stable
for a commit that is already in v6.16-rc1.
While your concerns are correct (though I didn't check the details yet),
I claim that 7df4cfef8b35 is correct and it's the right thing to
backport that today. Incremental changes can then go in the development
version (and backported if deemed necessary).

> 1) Change the reference provided in the long comment. It should say, "The
> following algorithm is, basically, Figure 12 of Neri and Schneider [1]" a=
nd
> [1] should refer to the published article:
>=20
>    Neri C, Schneider L. Euclidean affine functions and their application =
to
> calendar algorithms. Softw Pract Exper. 2023;53(4):937-970. doi:
> 10.1002/spe.3172
>    https://doi.org/10.1002/spe.3172
>=20
> The article is much better written and clearer than the pre-print current=
ly
> referred to.

I'll add that to my todo list. (that =3D improving rtc_time64_to_tm() and
reading your paper :-)

> 2) Function rtc_time64_to_tm_test_date_range in drivers/rtc/lib_test.c, is
> a kunit test that checks the result for everyday in a 160000 years range
> starting at 1970-01-01. It'd be nice if this test is adapted to the new
> code and starts at 1900-01-01 (technically, it could start at 0000-03-01
> but since tm->year counts from 1900, it would be weird to see tm->year =
=3D=3D
> -1900 to mean that the calendar year is 0.) Also 160000 is definitely an
> overkill (my bad!) and a couple of thousands of years, say 3000, should be
> more than safe for anyone. :-)

I already did 2), see https://git.kernel.org/linus/ccb2dba3c19f.

Best regards
Uwe

--anlvrwtevjodh2tk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhJHVYACgkQj4D7WH0S
/k5m6QgAsyw2rgvweuAYld+Tb+7A7qqJCaayWdwdXEX9uPvqZBXoowckpLTrTm6o
FIBA/YSZIqkGKYfljGkIEX1kvtFGUiE9Cq+Ciw7ZGf5xoFmOwDbcv02i2XLoxNXe
tVLAFijU9WBtpXUbC0+ozycLVewmx9dPgf5Zi0R6bLXqU/H4PGAlq8g2jjINKTtM
SDqgZ1b13/TREcZJhoWYw+4dM2XNSW4a6FU5tqMtw5ryxLmVS5HrYyY4YCn33Gwk
xFi942v+g8KMvjQPc7rNqWhwFAHdrgJo8w6U4JB+UlvUjDZHW6rvs4jXEHVWZDyK
yuAZZ7lF01o78mw/Sp1dYT3iVka+WA==
=m0ef
-----END PGP SIGNATURE-----

--anlvrwtevjodh2tk--

