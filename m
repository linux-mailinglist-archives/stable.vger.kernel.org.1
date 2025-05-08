Return-Path: <stable+bounces-142935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4BEAB05E7
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 00:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A1665064C5
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 22:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33ED224AF2;
	Thu,  8 May 2025 22:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZbmWy7B"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9982E1F37C5;
	Thu,  8 May 2025 22:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746742649; cv=none; b=TVg3SzG8Uve+XKDSeaEwTmtWAj6VeXfQ+9Crm+Xo/KswQnRynZ48Zkal90RZY1Q0QiSgdASccsJgiBtH3l/8ffSo0Mcm2Qw3W1Bp92HF1ogdyQnZF/GfgbTmp9s/JhhE1IeOcT3NLpIxJ9Oiju78P7RqrfkZ+RMqZEdmymfC5Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746742649; c=relaxed/simple;
	bh=Ad2CMG3+OTXk61CjO6UEMKfXUcG0X3CTDjAoiwXpmv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCKVEwEFTJwc83N27ODj8DYotckFeOskb/JwwAbojI1Mrrpk/1/4gxZ8ctBbHJYAFAYSJ4BpdKs/wU0Uziktf5Nh0WvWiXizTbyHwVEgVeFes2JCfeRZlC91kY44a/GPv+XMbf5cdYufMJhGF0U7ocua4OjvIgY7LEGmw7AyleQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZbmWy7B; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cfdc2c8c9so7482165e9.2;
        Thu, 08 May 2025 15:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746742646; x=1747347446; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lJ1iMb0NXCpxItNtCO1N1ZOA2I/6OFEbD4mrQhwulzQ=;
        b=NZbmWy7BIvGJpwtzB2se5vJE3g/iF+H43Zk+DEfHU+mtLFbOC/RtUEfNoreB9i/D9o
         IV5FwTPCmp9TGrdfQmQKwYxFXqJFORNpqcol0ImOrc6X2Plkfi5WLPslPbewR82kxPuY
         gxgK23LEq1VI6FhCKVh+pMLE5Q6NQwF9F+syhxX/m19dGujZJFmJL5NMvlim49M6Aj2r
         dMp6JIuiSM/b2cV77hbzbWg6+ZAizp3JeCixzgNWeIhWCaY9ilwHq1If1nNj5c9uj11O
         ucjvdxbZzalxa/jMWbraRwrxl+Pq+LA6VFd/LdYurjHt5zs401QBx+04NkvxluPCNpX3
         mQBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746742646; x=1747347446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJ1iMb0NXCpxItNtCO1N1ZOA2I/6OFEbD4mrQhwulzQ=;
        b=j2B+IGjSO+mwDV1x6afDg1cOZxpt1w1Ud/6bDvDdjsrS5dImTIVq4/axz5yCubZXuG
         4OyvWrWuAdS54DIB31p1EQxYBBuHFNr3aQPVaH1+OwwQIE8L2FfiszHlcmY7YAdGLgth
         GkOnvpSNYz9ATIio5EyTdx0WJn+ZRBgpXBu3OfSbl0zG/qnhqhqpebwwKb2uaFfucHXc
         e3WMuRehKlraxu2Ts3c3imHo2nQC7DIt34+pPicgX7iiUESDiSCJftT82zd3Gw0FgFGg
         gVGLqzQqGtG87gO1NrI6tGQbhjEV44NghxTKajiQ6RydE9kYWe6JwSpT7BT7PwX4LnQv
         hFtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlNlwBGu211crTigvoelGDfXgJR7jTX8k0W9M5quKm9kt5SEOHcsv9nMcaQpTn0oOYsVx4RyxoLvKrlCg=@vger.kernel.org, AJvYcCV0F6ofSB5W0ynmpHbUwiJplUvLklmdTaAI5DzzeQzKJE/ZUMCcFcFVwP8Hw/YR/wCI3So96frD@vger.kernel.org, AJvYcCVspSqSakP52l0qJEqam7gsLNe0mTMQUCG6yocFHraYaaSvC91aKp/n8MMOPmXItRv+He26OrDTNsquPBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjzNUyoYlpFKkEHMgcfSB/lYlrUPtMlmr7yMNkKaq49qVtCgxx
	qFhoUrpwUnliLhBThBJizMjNDPGjBOpOMlcvo0CVhe8/UuNZv2248opZlQ==
X-Gm-Gg: ASbGnctb7QJIQT+1n3cVWKSzqxpQIBFZoHzUdIQ7pZwnni/yf2WK+X9AqVHDxHB5C5C
	hqt3ZRyhH5Nvcp8PX3VvQwpSNLSPELihkvbMwTTls8zfGIUWQpfmeAFKnV3DoBBvquJV5OLCo7g
	cMjdQH5QDJ70saafJRwtx1QGLWOr/fqMhVu2WPacrrOBE+/4h/S/9FiNLhHBR/dMXaRyXDZNHmR
	nesOsA1e+E5WcTeU61kncg8J68KeeLJvPx/XRBT7zcTJ0uqbwrxK8535hWRHQWsHVMUxTbfjmS/
	QZNmt7AJgT4AR7Ed7stQagp2hqfdj6t4wvg15wMGtTdLzk1n/W1mWFyqLF6SxFDrA2KgVhflI3+
	feh/dDNQXpfiikz+nnXWl1UtWcnc=
X-Google-Smtp-Source: AGHT+IESyJIya633Xs6OgbWXHxjXtmkZXYXzAK5Hqf5K3B0F04vkkc778CuVVzkBefKUzMwh3Ce8Lw==
X-Received: by 2002:a05:600c:4e46:b0:442:c993:6f94 with SMTP id 5b1f17b1804b1-442d6d3dafbmr8132225e9.12.1746742645750;
        Thu, 08 May 2025 15:17:25 -0700 (PDT)
Received: from orome (p200300e41f281b00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1b00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd3b7b83sm49241225e9.33.2025.05.08.15.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 15:17:23 -0700 (PDT)
Date: Fri, 9 May 2025 00:17:21 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Ma Ke <make24@iscas.ac.cn>
Cc: jckuo@nvidia.com, vkoul@kernel.org, kishon@kernel.org, 
	jonathanh@nvidia.com, linux-phy@lists.infradead.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] phy: Fix error handling in tegra_xusb_port_init
Message-ID: <hhtm6kn4vtdn4yimi7yvaxczzt5itig2mv4zfubfubrp37hpwy@rrhueuyrhbw2>
References: <20250303072739.3874987-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wx67l5oe5lmxpk5q"
Content-Disposition: inline
In-Reply-To: <20250303072739.3874987-1-make24@iscas.ac.cn>


--wx67l5oe5lmxpk5q
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 RESEND] phy: Fix error handling in tegra_xusb_port_init
MIME-Version: 1.0

On Mon, Mar 03, 2025 at 03:27:39PM +0800, Ma Ke wrote:
> If device_add() fails, do not use device_unregister() for error
> handling. device_unregister() consists two functions: device_del() and
> put_device(). device_unregister() should only be called after
> device_add() succeeded because device_del() undoes what device_add()
> does if successful. Change device_unregister() to put_device() call
> before returning from the function.
>=20
> As comment of device_add() says, 'if device_add() succeeds, you should
> call device_del() when you want to get rid of it. If device_add() has
> not succeeded, use only put_device() to drop the reference count'.
>=20
> Found by code review.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 53d2a715c240 ("phy: Add Tegra XUSB pad controller support")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Changes in v2:
> - modified the bug description as suggestions.
> ---
>  drivers/phy/tegra/xusb.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Vinod, Kishon,

looks like this was never picked up. Can you apply this?

Thanks,
Thierry

--wx67l5oe5lmxpk5q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmgdLW4ACgkQ3SOs138+
s6EG5w//fN/ghy8cT1CG6l/5SDKWSzugOJO2PyEvdPwHz6RFgkmhaNflD7MT/GxN
X3AzAY8IKxzf+KiY+uBGfljYJA5HWbhXMTI5xk2BrfGzgdmGSjM/6Vtg6VQWJXfK
7ooj0JcQpz5yoaWWgpGbtAOBNxltngEypA/xSurMjsF+8O3J84VenKYKoNPUOr4N
xYNbHsKqdL2oFNZV3f3s4X9iP4VhWPP/wwtN8kvhHy2cE3nhzxh4Eb9g05VMHqzz
NN8gDYbcDRHEEMJ5auYHKflYNKjq9sDUandoliYmeFhwz9vcX9S1mfVedguBOCDo
GwvbTmeJwdt7vdGp9uaYPycXki6ydcJPZAzmu/KPumYyohmwAtqKRi6MAoNdvBtH
+ZLjh6MJCTxf0kj9V02e5o9jgOCy4jo9OvphLq4GGMlX3AhL8OBkOzBdZNuWvMJ1
JstXIoj76oMRxBcvBcuScVHWUN4VJuDN0LOml6z5AQeEcaVZSsl8uYo3QLyI+9bE
qt89zzilKokKZ9nYkYPe7lxCKnlFMWHkD/CcDPQqzUuo/L27CypvXu5AyaAuxjfC
4I/Qeo0GnUM1POs5++MQgT33ViSXlCEAH+KDtSXIi3FWXoWdqGafYpo0jzdbiyAA
O235paAjx387+XnhTe/QSwipOPEzaztSs3xk//uQBhZp6glIejo=
=c4c0
-----END PGP SIGNATURE-----

--wx67l5oe5lmxpk5q--

