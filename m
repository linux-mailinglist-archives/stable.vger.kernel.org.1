Return-Path: <stable+bounces-108117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF94A077D3
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 14:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A6073A79B3
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 13:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3182219A91;
	Thu,  9 Jan 2025 13:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jw+g0SSq"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B204E217725;
	Thu,  9 Jan 2025 13:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736429841; cv=none; b=hVRdYRdhqjD1N/2z6wLDw8bqtEjRbBrp6es6a+qTD9InSvkqtp7qZ0WL3D9d/C/DyOHmUo0/ybqyimXmvbccsy5IzGiCRfW9vlephhHdFN6hUS2NGftNtWmPSe9DG02Kc6nsIV3TFYsbccXONYW9PzUkqSODm6Xw5jbKiQrHINI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736429841; c=relaxed/simple;
	bh=3xlV+7JgOATwhp6cpCOiMLwZBp4Kt5lRkkMwtfILMD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgp/lcm0syb9zFYY/4PJHaYmjkmG+9siDGXHvp0hN2Ej4sDhxsgsGpMS0KkusNti2yzVbxEuq5DHF0jXOSwxhrYD+IQRXAZhTyRfUJGKdDvC2qMpSzwhgaeiGxtSSQjZZrNo1EnZ5kl5SB4EkhwJtI1vJmvlKQZY4reYWjD3E+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jw+g0SSq; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-436637e8c8dso10582965e9.1;
        Thu, 09 Jan 2025 05:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736429836; x=1737034636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SmH93BYvyCnSPbMq0jHZyuUQVQaG/vWQ+Adhu1NOeU8=;
        b=jw+g0SSq72Tp+hI6SCzCAXK6DPkuSkbyVpcMtm7GsH0re1tUlPz9SkufKDIucHoP7Y
         TpJlR0qs9NfGybzelQf2Rl2O6vkUAKEbYgDUxenDzDiOEE5nfkwOz4dAjjK+tG/BFmoF
         bppUlV5ndymh3WgeDDf75H2092M3BKNlpSjmd9FYrgvKYQtyXVlZU+KKRDeEdQPXDIon
         1YYNe3vsaODushzMabgrJNjh32KpiNdYw8H30MrtWo4eAknxiAMp4cL8JwtD78dd0N63
         ajLIFr1r4+TcxsCuzYfmD+GPVWvk1kRlpVmubcALbrlWSMC479xolYQ8ubbig3Nttloc
         LGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736429836; x=1737034636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmH93BYvyCnSPbMq0jHZyuUQVQaG/vWQ+Adhu1NOeU8=;
        b=UpNIE4Ic3butYO7XoR2ydRBIi2x6EydBijcvy32myzrC930drmRbHDDqQaMDUoZlQ9
         +x3AAypSsF3gapX1oJSKWqb64FPALPot/8xh5s6goZ7soA9ATvVCs3yX6QBy3VEGiHqE
         kAeJPDFuuXU9fsIWyeucDKA7ZX2nvMQlazXYsC6JFHxVxlfoB3tUOiEqQeHgIc7SR9IE
         Xw6tWpfg88FpxnXrWwITMQ2t19qh1MXzW5201kQEDY7dlKClBTwauAx1hrZBEpsz4qSm
         lb/elBDxUYBJrpiKvqNBHt9/QDr98y8YbTkr+2XadcfS8rOZfzrgwwjE0mxG7/10HwWf
         IxUg==
X-Forwarded-Encrypted: i=1; AJvYcCX4kfbuP2bTWga6Tfi1axdyxm5n84rR7UL2kGIOlGZhOIY9INbiML25EGSL/MuJhLV1VXE4/OiBmDg8gyI=@vger.kernel.org, AJvYcCXZq3Fi1DHiuRd+K1uoG4p1QsQ4jG/lwi4SESSppElYJmYcTUb/uw+z40GcyK+H3ZnMxQsCvMkoyxTL7Ag=@vger.kernel.org, AJvYcCXdKU7c8guJD9d02KvSbZx/BGjy4UycDQkNj3tXf1gbNX7dgnhowkSZu/LRaIb3/QDDCrIFx2Yp@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0pIikeZlAIBu2GzqvR8Bub7qPKich2fOfP/+ZsIuO0gQlVSsJ
	fdf74DOXr7Yj/Ic0fm4dU1PYQ3pIHkNeusCPHLfEMyPLWDW897YA
X-Gm-Gg: ASbGncuNhZvqxHCX+Y48NQq8CyRvj9LdpSO5HOPXZnAYxHASVWVD9NIAqtWOdzJYv+a
	FzdkGKpwJAMkCrG3MXrtKZPGtfpO3bQ5FtTuuy1YVjgcWp2oPqRKBTppZkPniG1D3BRhjDpqsUm
	JDzy1uQIHlr3gqNdhTlE+BOQJ7yns0na1c9xgMhuoCJIFNalgJHcrGA7RzS54nDYARQdZ4WDqEm
	DQbOtBDWj0mxqxxI39knyVoCoL+eyg2tXczjiEpMWCQKBeyn98j2yFF+D5jO9jdoEwm3MvYb0Ky
	ZHq5+eH73oyj3h4ldJ90KT7bkLJ8y4U2rBJ0/xY65oM=
X-Google-Smtp-Source: AGHT+IGYP3yVvKkIjcpct+SNeD5GTm0cuYtD6iVaq7ZsZOZmk4hrtnLgZBoUgCLCbuu72ZfrfVYC3A==
X-Received: by 2002:a05:600c:3149:b0:434:f297:8e78 with SMTP id 5b1f17b1804b1-436e267fbe1mr60471065e9.7.1736429835836;
        Thu, 09 Jan 2025 05:37:15 -0800 (PST)
Received: from orome (p200300e41f281900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da66d9sm56299485e9.1.2025.01.09.05.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 05:37:14 -0800 (PST)
Date: Thu, 9 Jan 2025 14:37:12 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Ma Ke <make24@iscas.ac.cn>
Cc: jckuo@nvidia.com, vkoul@kernel.org, kishon@kernel.org, 
	jonathanh@nvidia.com, linux-phy@lists.infradead.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] phy: Fix error handling in tegra_xusb_port_init
Message-ID: <p4rkf6bfo76njky6ovyk2w5rgqugjrubnc7npfkj5vvpivufs5@6b4yzxoapbeq>
References: <20250107085129.812835-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="asmlsgho3wx3j5tl"
Content-Disposition: inline
In-Reply-To: <20250107085129.812835-1-make24@iscas.ac.cn>


--asmlsgho3wx3j5tl
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] phy: Fix error handling in tegra_xusb_port_init
MIME-Version: 1.0

On Tue, Jan 07, 2025 at 04:51:29PM +0800, Ma Ke wrote:
> The reference count of the device incremented in device_initialize()=20
> is not decremented properly when device_add() fails. Change=20
> device_unregister() to a put_device() call before returning from the=20
> function to decrement reference count for cleanup. Or it could cause=20
> memory leak.
>=20
> As comment of device_add() says, 'if device_add() succeeds, you should
> call device_del() when you want to get rid of it. If device_add() has
> not succeeded, use only put_device() to drop the reference count'.
>=20
> Found by code review.

While the patch looks correct, the commit message seems confusing to me.

device_unregister() will also call put_device() after first calling
device_del(). So the reference count /is/ properly balanced.

Instead, the kerneldoc comment for device_add() says this:

 * NOTE: _Never_ directly free @dev after calling this function, even
 * if it returned an error! Always use put_device() to give up your
 * reference instead.
 *
 * Rule of thumb is: if device_add() succeeds, you should call
 * device_del() when you want to get rid of it. If device_add() has
 * *not* succeeded, use *only* put_device() to drop the reference
 * count.

So the real reason that this patch is correct is because
device_unregister() should only be called after device_add() succeeded
because device_del() undoes what device_add() does if successful. In
this case we only need to undo what device_initialize() does, and that
is what put_device() will do.

Thierry

>=20
> Cc: stable@vger.kernel.org
> Fixes: 53d2a715c240 ("phy: Add Tegra XUSB pad controller support")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  drivers/phy/tegra/xusb.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
> index 79d4814d758d..c89df95aa6ca 100644
> --- a/drivers/phy/tegra/xusb.c
> +++ b/drivers/phy/tegra/xusb.c
> @@ -548,16 +548,16 @@ static int tegra_xusb_port_init(struct tegra_xusb_p=
ort *port,
> =20
>  	err =3D dev_set_name(&port->dev, "%s-%u", name, index);
>  	if (err < 0)
> -		goto unregister;
> +		goto put_device;
> =20
>  	err =3D device_add(&port->dev);
>  	if (err < 0)
> -		goto unregister;
> +		goto put_device;
> =20
>  	return 0;
> =20
> -unregister:
> -	device_unregister(&port->dev);
> +put_device:
> +	put_device(&port->dev);
>  	return err;
>  }
> =20
> --=20
> 2.25.1
>=20

--asmlsgho3wx3j5tl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmd/0QYACgkQ3SOs138+
s6EgOg/4rgyOGMZjMtdunsxWV1SjVj7jfWgylsyvw43B3u571vaaaBSceklwKPoo
H0ZfAQb3iVuGMmFLtMGm7YBHwdtT0rafA8D/m5H48HyxaIIFTduTkOphl2nLtCta
Co/oT49iVsJAEg+EQU7zUN7rcsGj5W1fJPCHs9yYk6jog87Lk4GKzVRFmVEc6hOw
yK8x9B+MTrioN6LEO11wjeVkef6pBJ5z35/Q3E6Fs/9+dcER3ljSXPIO6Q7sPm5Z
SCxzkPIcBtBO3N7UpND7i0gFt9VgNZySjIA/mdAKiWnu6Z7lUsnGmbnoX9BlyqTt
L1NmWYJ1kZGsuEYEXAXfsNZFosFfatGo/pfjMk9OGjyWeOSqoo/2ZcpF9fuEg08s
hIqX2v9lEP45RiLwWZxUOLW90nXs53D7QQ3ZOTDD6OfFzvJez0+BonuZMrA7JU3O
QZU1RtlWPKknYivDFPhJS6JMdhy2X5+QCgwoLLtw5VJP3lrsTjJ507ZxQOEEB5UL
z+qlLEWGZvmscX0v1654+nxs6fYtvjfm3ZvlGzYhrq6Tpx/dLQHvvMZSY/RTkDCR
TEl+gwcegL6LRN42ty5K8768mh/+TcXUBHdvAdjA2ITyzmxR6BPIUhgW1ZmExXJB
y5/6L0OSJOIQwgyDY7p0WmlO3Xau8+zP2TKjzkcMPhZG04PeFQ==
=pD0j
-----END PGP SIGNATURE-----

--asmlsgho3wx3j5tl--

