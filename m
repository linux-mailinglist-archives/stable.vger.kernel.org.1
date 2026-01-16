Return-Path: <stable+bounces-210045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFD3D30F14
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 13:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 44DDD300D568
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 12:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C29389452;
	Fri, 16 Jan 2026 12:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3aan1N9"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900AD379998
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 12:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768565668; cv=none; b=uaq2H9gtV+PqHQ/sEJN98Frq/SszTigaW2OMZBGjJ65bGEDrooLmrUaCw6GZ4sy/DOXKmlxFFIufVgZ1hCigOlPieg2S5w1Z8kKOJYpfOUVatynYYadSHykqtNpvAchqaOB01qbGJFBd3ch5/64qTZUjBfa8dz/WyhMum0hvwhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768565668; c=relaxed/simple;
	bh=Uxqonx1XGSWgxig0BtGNWMI5iLc4WClMnDhq6CDU1vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OR8Hy4+6yVY1Xp1HDEUWZy2IvjS9dXjwe42Rog7dl+4zPplEdbH4EvaMpEC5MGy4J7pUL4yCXGkDYPR2+u1puaRzja71cHzu9K4AJ0MH2vKxd+jH3A7fTP2evAMb/HlAY+B0xvQ59VM/3CVXXlbR1WsnRrNgTjDmNfmrBhSKwg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3aan1N9; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-121a0bcd364so2395218c88.0
        for <stable@vger.kernel.org>; Fri, 16 Jan 2026 04:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768565666; x=1769170466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SxbenU8ZSpGXilJflF1lFNLpWQ3tMY8MCLmXY1GJJ+Y=;
        b=T3aan1N9vZr+5T9Tod/449jAoOF/1REgnLQSFM/ZyejDx25IkkmskhkiH5jjPI2jDU
         Bwnv288phMFySTmEpL1W8popKOa4OYvoq7RWrcWM7b20OpPHGpvKoDQ3Wd9cd3H67gA4
         wqa64BcbI1CjsB/UyTNzFB61cerzZyWNRPske1QLnqJAobiwuBmJmHbjbmhtpb0TyrbJ
         af6JkrQWmuWQg0djBWeQmSWXm7qeiRmAHL5fSE9ueLnamhAT2NKDATGf8YlRAqmDfFgB
         mDY1QpFwRv1asQAEKkOc7dWd6BP5vxkjckuwTmXdjMNdT7NWj4IqCYNAsJAruM2io+E7
         YxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768565666; x=1769170466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SxbenU8ZSpGXilJflF1lFNLpWQ3tMY8MCLmXY1GJJ+Y=;
        b=k6INthHB919Bc+eYqypijdVZl+E58ctiqe5b4l4xl+SSb8PtQTtAj9lwXpNzPhFuHA
         etE/W3V5TdUzFFVgCNVn34UPmhVTww+xe/Jaz8S/l+Ad/CfBILmtI5W1Ogmbv3FQdBqM
         gX4nsT+7R9rgGx8TQY/U2Pr9j/TsYAZ7f3/KXT4QcUmiFGFPdgzynXvia+4koaIvJ5q1
         GDcCnL3YGDmhFfNtwGN/jBU6sWKMYh96uS7A0ejsYawoZ6pa/nMQURbfj9wEJAVDMRP2
         YpzVMBlP9BxC9NsDy0bEDIC2ty58G7PK1zJD6axn6AWAlmQKFlCEu47PnMaSqdgvI8PC
         iMRg==
X-Forwarded-Encrypted: i=1; AJvYcCU7yy6cdsKbB6nP6rl2z2c8u5X2ZWV683jQ53jl1dcS8HPTm8B0Yv33vLFYeefZZAkufVS7+4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiXeK7b8l/LRokhaw8ncpXI7oB9/+aBrC4X/zqswzr1juHnRhc
	ti1OMuHMa4xOlmvluf7lv9s35Jy0Up44xETFKF5l4sZNaepQkIcrUWJh
X-Gm-Gg: AY/fxX6JqZbUe20f2xDyWsLS9CBa+kbHAt76RzpLDIzEYTj9OqLLbu/m0cfsG0a7FVR
	bF04r4UpJTOhUmLlMnhiFtIGW6+guPHibU5DUNH2Ze0Pjv9Jc0Fk04sSEzpj8iUIO52GlA9n5nn
	QZURUNS0tN1/OUpQYXAX20dDA1562P5aUwpPXOwRTwtQ8vUStlM1eD/698v6ze682mPDrntTyB8
	AYTJpwENyEiE6W5rb8hkpmslj2dU0RCW4Z3fccu7BfdjK7VZKdrOYq4mRBB6daRmdS5hUcYVBwv
	F46vx5sxalVMB9gHfriyUUV8b8P+oAGutEo3+AOZIQ19uf5g+yYa5ea5wZEbZOVodIEP2H6SrC1
	oK2cb3I6LvESQRjqUkpCEL5tigLuHgZWxJNeHb878yky26Amck25vpwySnRHokTN6BRV5VKexM7
	+E/QfPsm0Bkgp68g9PqDWuHA4qKnPTcXtHHOFaZma29XDxghjWXGm62SZiqK1YIcINEC+Dk3Djl
	YdyZerTnHql
X-Received: by 2002:a05:7022:2484:b0:119:e56c:18a5 with SMTP id a92af1059eb24-1244a7257afmr2539382c88.13.1768565665644;
        Fri, 16 Jan 2026 04:14:25 -0800 (PST)
Received: from orome (p200300e41f0ffa00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:fa00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ad7201fsm2116504c88.7.2026.01.16.04.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 04:14:24 -0800 (PST)
Date: Fri, 16 Jan 2026 13:14:19 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Johan Hovold <johan@kernel.org>
Cc: Mikko Perttunen <mperttunen@nvidia.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH] drm/tegra: dsi: fix device leak on probe
Message-ID: <aWorgofgDfxprcPG@orome>
References: <20251121164201.13188-1-johan@kernel.org>
 <aWd3iFrujbRWyyyx@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xzdfoibcbt5qb265"
Content-Disposition: inline
In-Reply-To: <aWd3iFrujbRWyyyx@hovoldconsulting.com>


--xzdfoibcbt5qb265
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/tegra: dsi: fix device leak on probe
MIME-Version: 1.0

On Wed, Jan 14, 2026 at 12:01:28PM +0100, Johan Hovold wrote:
> On Fri, Nov 21, 2025 at 05:42:01PM +0100, Johan Hovold wrote:
> > Make sure to drop the reference taken when looking up the companion
> > (ganged) device and its driver data during probe().
> >=20
> > Note that holding a reference to a device does not prevent its driver
> > data from going away so there is no point in keeping the reference.
> >=20
> > Fixes: e94236cde4d5 ("drm/tegra: dsi: Add ganged mode support")
> > Fixes: 221e3638feb8 ("drm/tegra: Fix reference leak in tegra_dsi_ganged=
_probe")
> > Cc: stable@vger.kernel.org	# 3.19: 221e3638feb8
> > Cc: Thierry Reding <treding@nvidia.com>
> > Signed-off-by: Johan Hovold <johan@kernel.org>
>=20
> Can this one be picked up now?

Sorry, forgot to notify you earlier that I've picked this up into
drm-misc-next.

Thierry

--xzdfoibcbt5qb265
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmlqK5sACgkQ3SOs138+
s6HMLg//aI6kPwRqWPyFQ4dxrRNAzkjky7szL1OQcea0JIHd4zW2vzOOL9qtmj3M
S9FW2T2r9mpNxR5MYMtu2F6HDhzBVvGQBgrTJ9H7JBz6zypyan0K2Iw5agjlb2I8
GnSMiAaBTH6Y9XhOW3gG6t7zF3NTemfhCfxX2y0wj5ZRa3NarOEGB+X1YByx0HKM
Jk6BQKGMXcWYRnb6Gxaa83FjC2kI5KkJymlubk+tlOgzcfWcywYXs1TOBbXt/OkP
BCVyhQ89sT0X7Lojl+UCcr7/6LrkPgLWz1bKInlzQ0mjHhuVjL4PBNBwSDuE591z
qiQHGhJGHlTXY+8Lp4ndQAMLp5FBBfKguR7Odxf+4+/VDaGnDvqhpNXU540tU/jP
E8u5pjviUIjSuhSYHTcggcqJ8m9WalGq5CcLXExIl1J66MrRgw1AqJB6nPF4gIPS
fCcMHGkua0XIGD9FoG5Ij+j80uq1cbyKITP0auDAKRgpiEC2nXLkCbl5YQEwcTYp
eUWMnu5tmloUmGc1dLrN39UsJBHzaPm/DFgU3uc938uF7Bc9NF49Hq4sADkwcD0R
+v1OcHotaFOkGqvcPKeNhfuoJ/2jMBs78geOGfJtYVlpGXWZ7T8tndAxGEb/HMmG
25DWp72ALnZJeClQZn5wi30wGTsyKNvyNm7343GAeLQrROXg9Bk=
=pibZ
-----END PGP SIGNATURE-----

--xzdfoibcbt5qb265--

