Return-Path: <stable+bounces-104316-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4542D9F2BED
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 09:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74F9E164A78
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 08:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DE31FFC73;
	Mon, 16 Dec 2024 08:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="A+XAdzXu"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9454A1FFC6E
	for <stable@vger.kernel.org>; Mon, 16 Dec 2024 08:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734337954; cv=none; b=fH8NhGGE2ax1cd9h6bAMxbppwcxQhTFh9ivllTP36PwjtKK9wGRQhMTd2lauqelsPJcbNf8aEnt1fdl7zZDMf7Npc0rj487bJBGQuAseFccy9Q9uSs4d/4dDBcEB0R0yQwEI8P8vICcA9b3rx+R5IlZtibwwpEoE1M3MY4DCgTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734337954; c=relaxed/simple;
	bh=s9i4fynPbPb54HJslZOOIfQYX4k8k6dPcc6T5ezUZak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZzS9175AI2oxQx+GfxWYzNhOBMP189+iytdeiSEwNJhkaM5Ddbieg9F6V5vM3wi92yMwd1C2AFB5QVHNDZDFIGNmV2ZInRC8OEOpkC2ccH5WO5w7JvYqu0hkNp3qBdRq8QcmZ98f5WT0Tx4rfQCsPTGuJitaBW+KZE4jKir8ToI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=A+XAdzXu; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa696d3901bso743252266b.1
        for <stable@vger.kernel.org>; Mon, 16 Dec 2024 00:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734337950; x=1734942750; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uRmgq3/9ZFrHukVfFBjr2ToUBw0ASB/QntZDZmfUjZg=;
        b=A+XAdzXu2mQlSdT/WO4lRleknI4sxaHQf/jhPhmQR3/P2BvgI5GoGVyEQ+JpxHFXJf
         L9ZU3KJ9pVt+QhPHpzH+JVWTT/PPMlVPtm0j4wGZ8NxCcj+UZewjAeIKBLM7cwo94MHZ
         NpoeyS39F4VjUxZepxx5S/OmhrIylMGJYJzdSycrYjND2QNtoMxO0SuDrfLrR/8R+6zs
         4Iwo3T3bCWm6sEgxeSYPv0R6PFw8UFHHIVoGHxVVX4FBtxXlRZ5c2djBS28iiL3QoezV
         SnEpmTKtkVBE94ovKg8/vSE2WIYI4rYqDjA3U0jJr60XCJArHhmGWhCeoRXQ7xm4Qc14
         mq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734337950; x=1734942750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRmgq3/9ZFrHukVfFBjr2ToUBw0ASB/QntZDZmfUjZg=;
        b=GgFcQ8nttMkGjO8XnnuhIyQ5kRp3aKUxql6v8eAWP/pd0kW3KcBNHntvEXiOq2XodO
         lY+0VjD2WmTyRupCOAGaVs/gbp81F8IZQYk54Z5G3sF3No0akEapHpzzjzV4JPX7mFzD
         cIMx/C39iIiiIKQlh3r5Sa3B5ouW8YjtXFi1i6f6sfoLcRQ4PKYAb+h8l2VfMNv4+pkp
         0p38D5F1LNnv+aBDN6RgLt/3T+zSg5RpSs00SGP7jrZHn6ub5c9W5B3SF0v6T6AwzgSU
         6NKZvt7DhWHpw6OqZZ7nt1oqVq0AIiJKelPPXNiXTVVQSmdhlgHhib585zMSirLLqUJD
         ZSiA==
X-Gm-Message-State: AOJu0YxA4S3Z2U56RfB00IN9zhmfjUDnUuBtnncSPC4rX1QPJYynjTVC
	CsoAZXP3c59Sduzb6/tNTgMEqK6mtpwd/MZHOjT8v2WpgYolFf+aoj9ACvpbTMMStNp12rR4D76
	S
X-Gm-Gg: ASbGncus67TG4G+HZf6HMgDdcrquo6wzZTs1KKnd/liSJJrYEedb7OpA0jzZ6MHbO/Q
	PDBCo2digDZ8Lx2kd4WNKhnggYfrvfLWkAu/FSfPTL4Ut76HZC+3nGRxKxNxTN3QzGZZjxahGEL
	1e2MNdfHIOy2xG+ZyTHhpOc1ntLSrUj+QwKwI8lEMbJFRBcAFbIuWiGR2POyTZGE1pxT/D5fM6i
	qt4ebhdVyrDAuiri9jY7MBQgn3URwTxOY4pT8Y7WU5QgKAp4PT55ygEFf8NoWimWRgAUJROQncV
	zJuvp6/2fA==
X-Google-Smtp-Source: AGHT+IFvL0Gl3HUH1ABcX80eRyPcCBoJZzn+KLBO6ORguLord7R6u7XCtTprJhajS4kjtCdwlCEKKQ==
X-Received: by 2002:a17:906:4c9:b0:aa6:552e:451e with SMTP id a640c23a62f3a-aab779c05d3mr1124086366b.29.1734337949901;
        Mon, 16 Dec 2024 00:32:29 -0800 (PST)
Received: from localhost (p50915bc6.dip0.t-ipconnect.de. [80.145.91.198])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9635999bsm304893466b.105.2024.12.16.00.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 00:32:29 -0800 (PST)
Date: Mon, 16 Dec 2024 09:32:27 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, 
	William Breathitt Gray <wbg@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: Patch "gpio: idio-16: Actually make use of the GPIO_IDIO_16
 symbol namespace" has been added to the 6.12-stable tree
Message-ID: <2cjlh3rtjqyrxvqkeklzdqxv2shy5fqolflx3fa2itxig2y4kc@gvl3fecajwqr>
References: <20241215165457.418999-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dultyyvhidpfb77t"
Content-Disposition: inline
In-Reply-To: <20241215165457.418999-1-sashal@kernel.org>


--dultyyvhidpfb77t
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Patch "gpio: idio-16: Actually make use of the GPIO_IDIO_16
 symbol namespace" has been added to the 6.12-stable tree
MIME-Version: 1.0

On Sun, Dec 15, 2024 at 11:54:56AM -0500, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
>=20
>     gpio: idio-16: Actually make use of the GPIO_IDIO_16 symbol namespace
>=20
> to the 6.12-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>=20
> The filename of the patch is:
>      gpio-idio-16-actually-make-use-of-the-gpio_idio_16-s.patch
> and it can be found in the queue-6.12 subdirectory.
>=20
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>=20
>=20
>=20
> commit 8845b746c447c715080e448d62aeed25f73fb205
> Author: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> Date:   Tue Dec 3 18:26:30 2024 +0100
>=20
>     gpio: idio-16: Actually make use of the GPIO_IDIO_16 symbol namespace
>    =20
>     [ Upstream commit 9ac4b58fcef0f9fc03fa6e126a5f53c1c71ada8a ]
>    =20
>     DEFAULT_SYMBOL_NAMESPACE must already be defined when <linux/export.h>
>     is included. So move the define above the include block.
>    =20
>     Fixes: b9b1fc1ae119 ("gpio: idio-16: Introduce the ACCES IDIO-16 GPIO=
 library module")
>     Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
>     Acked-by: William Breathitt Gray <wbg@kernel.org>
>     Link: https://lore.kernel.org/r/20241203172631.1647792-2-u.kleine-koe=
nig@baylibre.com
>     Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>

Hmm, I don't think the advantages here are very relevant. The only
problem fixed here is that the symbols provided by the driver are not in
the expected namespace. So this is nothing a user would wail about as
everything works as intended. The big upside of dropping this patch is
that you can (I think) also drop the backport of commit ceb8bf2ceaa7
("module: Convert default symbol namespace to string literal").

Even if you want to fix the namespace issue in the gpio-idio-16 driver,
I'd suggest to just move the definition of DEFAULT_SYMBOL_NAMESPACE
without the quotes for stable as I think this is easy enough to not
justify taking the intrusive ceb8bf2ceaa7. Also ceb8bf2ceaa7 might be an
annoyance for out-of-tree code. I know we don't care much about these,
still I think not adding to their burden is another small argument for
not taking ceb8bf2ceaa7.

Best regards
Uwe

--dultyyvhidpfb77t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdf5ZkACgkQj4D7WH0S
/k5MowgApoL6zkHrbOq0ga28NXsR63LkFJ+TNY/StY+Bsyi4nB9yix2eZFiJRJ6p
nivM+Y1gDzY6Y0CS+fOlBILLOC70aS2fJGfrXs6wQl9ikDC2t4iJSubMOe6S9Nkt
o0sSdJGqRODi8WGyrXIz8MJXfcBksHupdAn+NAfXCwFRKSbGQLQiYY6S5fygH053
xXI1SLGsTU0KVZGK5eBYoymsuBwCcjvFBlVPUx/lAyha74HDUI65QhJ2QM3eLt1l
n9DkVIJsDGclnQcCfQe55zbxpKu4cw92G5eJNl4OiPJCXQom+ApPgFkKWOnppAqG
gN+zYtq0d63G5g2/p4ctF5biG5LH0Q==
=VlO0
-----END PGP SIGNATURE-----

--dultyyvhidpfb77t--

