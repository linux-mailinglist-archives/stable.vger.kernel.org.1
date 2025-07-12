Return-Path: <stable+bounces-161750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAC2B02CFB
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 22:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4F751AA5937
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 20:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C3522652D;
	Sat, 12 Jul 2025 20:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZV9JftxO"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE77B2AE99
	for <stable@vger.kernel.org>; Sat, 12 Jul 2025 20:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752353889; cv=none; b=XBjd71x9FntJRct14m4Ms0/KSVEcta4Mil+mm1wt2QNZvc+RkGiz/aJ2ZqcvrMW1A/qdS42ea4nlQNhOw0ZnixuHKDZxDGktNZYWGzIL2xtgVe//FV8b7XG2k4FcdBIX4UGe1LZIVsWZ7cx6ZAZk3Gms6HH7dWcjFpaM3zrv/54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752353889; c=relaxed/simple;
	bh=VSEpu8ujeUFhDwIvkuodUsE8d8xEQEygKNs1oPQsa54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0HVYqbsg3DyQdK52p1Qnx5h6P//uLNmuA5jWHyjU8InoWrp6gZobvz5QYXJxeh9baY+21+H09fhU/hazEdGac9qMBoX88cdLEuuvozXj69gTsibjLW23kQUVm9dx8UcmSj4U16W5gNEi0diKUWdVFCjczz5+Xqo8x8hb8a/x0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZV9JftxO; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a16e5so6078294a12.0
        for <stable@vger.kernel.org>; Sat, 12 Jul 2025 13:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752353884; x=1752958684; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VSEpu8ujeUFhDwIvkuodUsE8d8xEQEygKNs1oPQsa54=;
        b=ZV9JftxOuMORSjfCpBKZQSvcIhRp0CmFuRLyhoL+3klWqVun1ioLuJLJmlpdn0037V
         j5sP6HQTC8gBlx/MUstSJTWz76NtGPdJHRdyrH+Dh73TvBAJXs3DUMKEIm84VBTfVwPE
         knYbl2Z6nVA6EAnu5O7SQXzPM4f1D4Qlq6RA8dXbaxyzQ8+CPXR/PwchMqL5oVtphcWQ
         T0yBUvBMnHhn+uvBuILMC8bXgxL5sThIcdf7rpbH92fbFsy7tBkRYKE0kEp6X3VVNsh9
         Aow6B8LV0PSYUzEA0/I4kGYkYxsOIku6Aky3xup4aXJ7U6ZaWhgp868rWKtP8h5PC2/G
         HOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752353884; x=1752958684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSEpu8ujeUFhDwIvkuodUsE8d8xEQEygKNs1oPQsa54=;
        b=MzkuR8EAtTN5g8+6XdXk+X9sW72ILDwE0MynMjimFOReLt2B7aHaWIIPouyfMag3K1
         D3ak3+iubPUoU96FoCzOxlh2w9AoQ09hO48Mnn5XFtQgJhwPN/IScScxRpSt8Uio4mVm
         ET21N4rvdVfho7pdm9oGZvLSvkfc+1ct+/YwK7jLGeNrCkJrKXulLqUua4JNtw2T1DJk
         Erkh195qghUsOaJDYWjuMErEyGgZRxVhJfVFhttPAoqu1sHRT9X0QXfkFK44SO9c52/h
         I9L/gczK1m4gfq6wasDsSNGNSmIdifhX808vGeFkMzT0zZK19BSab0pghiE2A1+EkxSg
         porg==
X-Gm-Message-State: AOJu0YyVwUq+jWu0XCG6zsSUmdGmgIWDkpvqHizSvBRBIAuTeKQELqIW
	ZahpaBS3DOa+GO+wYPTBTvIg52IGiMnIiC/12t0q4HydYOUGmTPOYZmjUqDPvxGeZE4=
X-Gm-Gg: ASbGncswGm/1HNASfvVfwom6tKk4VxWlZsUSd6Kg5SgrhyprEhQSjoEuPKRWQh2ndim
	1Jz96haqD1buX0nm4BYPqtV+QcXftXdHMvoOFi4o2VfdzH5yVRxPDdlVuxGvOdyBMb9+Qdk0IY0
	f6QyhWWlIvFN/OzPOHaJWvECt1rthbca7tyvs9SEz0PlSQD+lLVqJd+iADAuuaDd4OgPa0HFlY+
	v3FuDiHaOlgYbWD1Yy4x2ElIXEKh5892y0X2RjugB0MPY9hn0ug8CzTg5XOWfX3uM3kxQBnEPdd
	L5cJhr81brJ6TUwEWmliiUHRSKyA+p3MKsTVh3yuNsQsBGft54sY491E112emtJCaB+o0QR11/L
	tvoV5uNTdJ4xNHfk4ITYpiyuePFo=
X-Google-Smtp-Source: AGHT+IGyoIq1C5JTqmLvirMvpABKzl3CVZynSx1Hq4rglMhON5XPQm1ykxQW2IV7tkB7/54J5cTVbA==
X-Received: by 2002:a17:907:1c8c:b0:ae0:e18b:e92f with SMTP id a640c23a62f3a-ae6fbc8c32emr696204666b.23.1752353883867;
        Sat, 12 Jul 2025 13:58:03 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ae6e7eead92sm547968966b.63.2025.07.12.13.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 13:58:03 -0700 (PDT)
Date: Sat, 12 Jul 2025 22:58:02 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] pwm: mediatek: Ensure to disable clocks
 in error path" failed to apply to 5.10-stable tree
Message-ID: <nnwmktibtyiugeifg47o2lkeiadmnlzgi5oq3o3pf2nrm2utbs@zhblnf36nfkg>
References: <2025071236-propeller-quality-54b9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wlosgh5puwlracvi"
Content-Disposition: inline
In-Reply-To: <2025071236-propeller-quality-54b9@gregkh>


--wlosgh5puwlracvi
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: FAILED: patch "[PATCH] pwm: mediatek: Ensure to disable clocks
 in error path" failed to apply to 5.10-stable tree
MIME-Version: 1.0

On Sat, Jul 12, 2025 at 04:00:36PM +0200, gregkh@linuxfoundation.org wrote:
>=20
> The patch below does not apply to the 5.10-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>=20
> To reproduce the conflict and resubmit, you may use the following command=
s:
>=20
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-5.10.y
> git checkout FETCH_HEAD
> git cherry-pick -x 505b730ede7f5c4083ff212aa955155b5b92e574
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025071236-=
propeller-quality-54b9@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

The patch I just sent for 5.15 applies fine on 5.10, too. I assume this
is good enough here. If not, please tell me.

Best regards
Uwe

--wlosgh5puwlracvi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhyzFcACgkQj4D7WH0S
/k4GoggAiSXixB3DY/v6+FpOk7n0jauX4Oh+CqSSrPgjaGTbZIWFUSFIcTP0H5kP
vQ00wJAKUxLngBpkoIzJmfrdmTlXR5zZbXEbzqWZmyNHanA3s0PefUMCy+wEFRUS
uMFp4dV6wecmHSGSrFFqjSzKeLE7ONDSGpD7ci01Z7kDnrzKs0HcSJ+UpZpb7il0
ScHnz/EJwerCZaXvb5gzwTaLY8mvHFfZS046OK3PuUeKgMby33RChHwvxWzL1rkF
v4fGuXAk3bOInUlVXpxfRryIZ692hAUvglAI/s7inDo/Uxdx9SsAcpvbQmpP+Wqo
FoeOsmEFXoXhIDhQYXxgXn4/OCH/uA==
=yAU+
-----END PGP SIGNATURE-----

--wlosgh5puwlracvi--

