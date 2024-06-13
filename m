Return-Path: <stable+bounces-52107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6940C907D36
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 22:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3EE91F25495
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 20:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC922130A4D;
	Thu, 13 Jun 2024 20:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qrtkMKCh"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A1B137931
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 20:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718309706; cv=none; b=Cms96rKjj0o/bXS7+7T1KhG1cC7IrmG6W1idGSXuq/2++Vjc4Hn62aCk9g+xL+7LTrsBEFUiesMK3nDqKs8W3dt1Wyex/umIdZnK6FFhUDgSpMLMXI+di/G3FSTfkIsIAcHDmSm/AvnAacvJq8QHey24Y8k/sclW4AOyk1wwbN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718309706; c=relaxed/simple;
	bh=dlGLscArDzy44oP2aurmhtbN5pHQToD2F91xsEh7q5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/ZyGfA0prrV0vM+PtgBV/by+71XiaZ+tQDa16IJCKUcWtvN/mjR4J5Gfge7PEHHLhVjS2QTiq1Fa1Qneb3Hmg/o3c17BoG26ool6iA0lq9L/VYVTw759AN8abxT1UWYFZCtqBBDIkkdN7JqAig1+fzDoYmZV+G3/ZET4CiGwHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qrtkMKCh; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57cad452f8bso1573285a12.2
        for <stable@vger.kernel.org>; Thu, 13 Jun 2024 13:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718309703; x=1718914503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hDhVeCL8wLH4kUjFDvyKZ8mFuEbjs6JnITirIhpJobs=;
        b=qrtkMKChtQsMGUQnqT6foS+xI1ef81/v0xyDQnHddeS0TuX5J04I+vb7wCf7QZgyLB
         ZBTLx+zEoNYG3Ys9Ounq5xyUu3pKAchQTP767el6Wi6bcP+//QD7RC61NrpZrDGc9chM
         0IjeWVufOkb3+AkrbkG7D5dZS+flhRFCWeUyRE2YWB1mD7wv2Kd9YjK9NRDfH6n1nY6C
         MgjMuRqw6hTAzRHB4VFKrfPduZkGbB02bhugJhF2s+1xduPAD2EMVE4w4HWYe+bgjqBm
         Cjfh2PkoQ5OfbwHZJeCXMewyQwHya+hbsUWeL17hnipgl+Pxj4u9N01l44ZILvY5WLVE
         0esg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718309703; x=1718914503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDhVeCL8wLH4kUjFDvyKZ8mFuEbjs6JnITirIhpJobs=;
        b=XWjprKhBaMwLNWfencj5ICcTt3E7YCn8wSn0CifISkdj7ZCHS/Bp2fllXB9G8q8Oec
         rIsfCWdLUXf3MZwrvRhmg2BbTi793QitYSQATHdBJKvw0bJIispBPxnd1ab9xNJLXHlG
         U0UY7gdVf+t38gPWHeNzC0Uv6FL7Ng6bk+fTcolSnMFeGtC4WQKIwMWaGDbZTNO24psJ
         7KNaNovNSNWDXaYkjFZGeQ/tSFUDpD4jV9NwJbfceAGGh44f9iG2U9oU5HQRZ7YPJJ9I
         sViYdCX2JjXMxUdDwHR6jhoxNIYWtCUHGWoNWJkzFkrS/AqhjDajpgERBCOwk4hqjfhB
         nElQ==
X-Gm-Message-State: AOJu0YxqRRB8+BP/Hg7+z+7b8PnUg4WPYTxNlCyFaU9HRejTriLKACWg
	xIUyV4PhgdDQrj6HuLQhsOCkWkb99JG04hT41pzfZiplfvNrqf/5qzgDJ5TMrcQ=
X-Google-Smtp-Source: AGHT+IE+Ca5W8n6Y3E0EYOqcEFRbIILXOlXEMM91s0YkQkAIFAu+a2XFGplvac6dVETmyv+Gd43IIg==
X-Received: by 2002:a17:907:7f26:b0:a6f:49f0:437a with SMTP id a640c23a62f3a-a6f60cef2b5mr74557166b.5.1718309702650;
        Thu, 13 Jun 2024 13:15:02 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:78cd:4cb6:e3af:4473])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f427b0sm105375566b.156.2024.06.13.13.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 13:15:02 -0700 (PDT)
Date: Thu, 13 Jun 2024 22:14:59 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 026/213] HSI: omap_ssi_core: Convert to platform
 remove callback returning void
Message-ID: <4yzk2jhrqq2ga5pirjlip56ezhnrdfyn6tpq2i3lhvlp3lahi7@zk4ohcap2lg6>
References: <20240613113227.969123070@linuxfoundation.org>
 <20240613113229.004890558@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5xdyfwqwofn5vjbg"
Content-Disposition: inline
In-Reply-To: <20240613113229.004890558@linuxfoundation.org>


--5xdyfwqwofn5vjbg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 01:31:14PM +0200, Greg Kroah-Hartman wrote:
> 4.19-stable review patch.  If anyone has any objections, please let me kn=
ow.
>=20
> ------------------
>=20
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> [ Upstream commit 94eabddc24b3ec2d9e0ff77e17722a2afb092155 ]
>=20
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
>=20
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>=20
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Link: https://lore.kernel.org/r/bc6b1caafa977346b33c1040d0f8e616bc0457bf.=
1712756364.git.u.kleine-koenig@pengutronix.de
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

It's unclear to me why this patch is included. It doesn't seem to be a
dependency for a later patch?! Also .remove_new() only exists since v6.3-rc=
1~106^2~108
and I'm not aware this was backported, too. So this probably results in
a build failure. Ditto for patch 27.

Best regards
Uwe

--5xdyfwqwofn5vjbg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZrUz8ACgkQj4D7WH0S
/k7ZPwgAjF9cgU8o0hT3ffzbMTjoCvTN+OIoZEoGY0QCxScExt+4p9gOPpre0Z1/
MBWnVH5OSoxeQigG7OwrbGYzc0oz9I8WYvBV09ePrmfUwgdCl8z8yjAzKFaIwmqL
twAfAfqgORk068mMJw051CgrL4oUpPu/1aqET+WCItZGvlWu8orA4diASgavHBGU
ngDcZ6xTf2xvUN+19z3Joalw6X20POD5MM+M5YqtroHRIDOQ6fhO4XH2Jv4jcxL8
rgm8S/wfTIdpFpjqLbH0Q2fWeFbtD4J8qO9TMjv7QmAoSNIV8OJ9lT3A3MQFmlJj
Lcls3CjizmV8ztgMSzsCFT9xM896kw==
=fIDv
-----END PGP SIGNATURE-----

--5xdyfwqwofn5vjbg--

