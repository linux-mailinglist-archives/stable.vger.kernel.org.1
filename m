Return-Path: <stable+bounces-120075-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10703A4C5C1
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 16:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB8393A4E32
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 15:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7FB214A79;
	Mon,  3 Mar 2025 15:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbjRlL3Q"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084341F4166;
	Mon,  3 Mar 2025 15:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741017111; cv=none; b=e7GLtbnirjPqyDtaQP/VEqi221ZqHpSMKFUvWu8BgXCG5FmL6FwkyrKYFeTwN8RhYLx+ETio3HZtamjymZ3xQSvPa6qrABPkeYqAkus0mxgsEjgquF7KJ5/Fllep0U6Gfl5Nix8lGzLXqHrUW+1U7W+ImQQjpS8f9NPdyIuzuH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741017111; c=relaxed/simple;
	bh=DwMUbenydy2FQEW7DlKyiMhaS8TJZxKKH1OKptuTw9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XxsDupVr3llpSlSWqwNJTOIhlIzD9mOY0Ekfvny+oEBrM9pyFhm6n0Uq573Zl7i76sSKM7Bri1jXBbjrpRz6W7oaoHkUqqLIWKh2tDIQ98BsGtfENMWddicojTryYcAbE63I5NTJeo6OfnFFMXj6z2PFf89FqDOPcm8Ob9caayI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UbjRlL3Q; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so29484695e9.3;
        Mon, 03 Mar 2025 07:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741017108; x=1741621908; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dtryQxotpz8U5ArYfvfuETSf+fKZsakZSrz5Z30r0AU=;
        b=UbjRlL3QVswzHVsnp6SbDg+IzEzsgrxGYkDcGqghI8PSKDHUWzjyJHIdfyMkfgzGTx
         Rh7raibQcFIC+9gVeK/DH4GQxk55csBYNmoKGvdc5a8rWsY4DTec7U/ivH0JA06avoc1
         BuV/AmJI7tvSBYGKSgOFoSpPEGtkNgJuqZ5+zITXCvpDQ2nGnUOBU3nuopv3gF0Obm0d
         jMkeFbODmLbCz2KQC9I7gI82NSuAA3LS+1sEr8wVie8goB+s0Q40mqoQgU7G6eTdBcb3
         KuCbaKhVTzT/rcj6oZYDHlTe4OD7G2gNGc2EJY8QL1nfr9smky3MNxpOQcgIswVOO0Fi
         RLqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741017108; x=1741621908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtryQxotpz8U5ArYfvfuETSf+fKZsakZSrz5Z30r0AU=;
        b=Aj23z+Lqo7LUUkFaTDHnJdNZ36irOSCxp1i1OaLEgzNi4QHazQF2Ql5hc5mXCmlaRX
         onBRllEFpBRxv7NpFKBp6v1ToKisCa47rvkenMKprMJmpDbDeYRCn7arO7hRIPdz265f
         8cXC4/7Nb+WMsLPWx08K0j0yoFSpdTwN5mMJFmJOYi/14Yv/C40FZkZP/LLnvokkNkZ6
         4jdYlpgAcWebbb/BugZ1mNZcpHIWZGoxzVxjNwf3/rWRm9Jz4uOGDJnQ6/Jb3Y34O/QD
         yYpIwYmOSvbazrZtm/N7kVa7kSuWNrycEpPBRKPgDtavPmLscVJi9hpJ23llNMu6V8ZK
         23VQ==
X-Forwarded-Encrypted: i=1; AJvYcCUV90F3+jWXtW4oRvHY7Z5bpcJUJORZ14wOzJJ1wL2D6ufUR8+AqsLA3/cYIdxFt2f2r4QBf5Gz@vger.kernel.org, AJvYcCUarvCrcV+wPotI5Ti6Nx+hiCjNEYWhMNASZ1jR6oqADoeGqdr0hEE6j6lMKjqzxtTuC/mAKjLjEPeJ9Cs=@vger.kernel.org, AJvYcCV2nK4V38nTl/5SozuPwh79izFPl+c6rD2/uJ2Ke/ydBbcbbs3Y+u35jftUaeZB7MeRjM35E81X1+uDUlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNYDLOBSGc3nfU2tjmwO4E4Nwwgw4niV35Um/vn/eRBl8jNwLQ
	9Ulg2pFPvtivVWYWOJzvFlH7akp9LFpEXf4LoupMO5LGrs0BQl+M
X-Gm-Gg: ASbGncvo8DYYQ8B9JpLarxFwgVN8MmgW4Hf3cmsRDXAjzokTiPDGjIDvPUv5cLw/1Bu
	C3fB3bd5V0RvbAsOHCtG9soIAI59wN06irVQk1id4pZYS8jl37Vj1BzNYIINSpjRjTihCSiQ0OG
	EYsqu1GKGUR1gP3Cr53JBWBextlESkWiWRYt/i/MSqBcqYEPk68NMC2LgDrBQ4zVApGwVp33ckN
	RPt5+XTLfAeT5X5D1rtupOpwff9+0S8SnjzJLHvn8A5eZEDoOFjAwKs4f9MB0zycrXbn572+yOp
	0KVOdcWXy6yl8wMWtNKkDY0EuhqzkBimZvRwxHk7IVD+CC8Pd2wv0IFjJpkS5ckSZbKPqZTkE2T
	GM0jpZdjm/fauzW0qNDRRA3/15VlzMH8=
X-Google-Smtp-Source: AGHT+IGVA2kkwtzvyc7wmuOevfFku3iq8bCghvi0ovoAVjUJkQ+OukYLz0HXfZag+lj/EmUrcnnfBg==
X-Received: by 2002:a5d:5c84:0:b0:390:f116:d23e with SMTP id ffacd0b85a97d-390f116d675mr6558402f8f.19.1741017108217;
        Mon, 03 Mar 2025 07:51:48 -0800 (PST)
Received: from orome (p200300e41f187700f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f18:7700:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4847fe5sm14941073f8f.73.2025.03.03.07.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:51:47 -0800 (PST)
Date: Mon, 3 Mar 2025 16:51:45 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Ma Ke <make24@iscas.ac.cn>
Cc: jckuo@nvidia.com, vkoul@kernel.org, kishon@kernel.org, 
	jonathanh@nvidia.com, linux-phy@lists.infradead.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] phy: Fix error handling in tegra_xusb_port_init
Message-ID: <lieqwndlwojiwh7ipqbhf45iv37k2e52yl5jsmpe4wifki3tby@qndkynn5qogf>
References: <20250303072739.3874987-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dogd6n2uv5zyr2bv"
Content-Disposition: inline
In-Reply-To: <20250303072739.3874987-1-make24@iscas.ac.cn>


--dogd6n2uv5zyr2bv
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

Acked-by: Thierry Reding <treding@nvidia.com>

--dogd6n2uv5zyr2bv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmfF0BEACgkQ3SOs138+
s6HeIBAAimqmNAdbUICiy7xT16w1yKGIbmD9HklsSfEO8yLwmRf0JsegiRpWqVbx
nJCXDDAUnzaUXv3u58rwUdhEAXtdX3ENEt1RojEnjxGU2x45FclbR+57gE5jw67L
01cjFcaaZT6mQK8Rwq38m2s287W+da7gEdcWlZe1PK63wL1bgqvEygtMMbZtS4yw
IVXoDPCMv+IKLuW3EfrnUeUT+7lBrL73HuFhUlKRv3Nu5Kj6V7esx8K4bv9meaUl
+q/K84lkENYo5xEYnoSWFgwO+MZcF+MsuCIZsXWqBvXuFHtYJB1ce8siBrpq+Ggg
ZeyP1loDD/4hyGTfwoX3XkiLdBXRX1yNXs1NK3MJjKg/SMjQ79QxVdMzWJ7vRIO9
08t74Vt4CguKGHCeLgdwgHxSzgOhLSCKhjXBa4cphmDBlYGvARYd2X/WPjgbZyd5
dSLsOrMvCtnEfW9gtKb0xEWuLX0eVBiKnYI/3ga8BmE2vQ8CbOyrczs5EwmVoVWf
MyDtqVnJGxDEN+tIOOdN0FzY65If7kDCShc7GHln+6QLXHZlr1q7vmfomrhWCLXG
2Gn2sE8gvnkshPo5LUFBrLVzIX6OoCnHKMgZXch4Oy0hm/8nncKDAiQZWJgnbq3i
lfJsJGYOD4Htj1Aco035O+S95fnEwUyZwWOlTsHi7l/YIzpGkNQ=
=CVRC
-----END PGP SIGNATURE-----

--dogd6n2uv5zyr2bv--

