Return-Path: <stable+bounces-183666-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F61FBC7D2F
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 09:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 575091892552
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 07:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23632D0639;
	Thu,  9 Oct 2025 07:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWguEwY+"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE362BE648
	for <stable@vger.kernel.org>; Thu,  9 Oct 2025 07:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759996586; cv=none; b=DChkryETgVGteg54m/pQ9ktRCpKnyer9J6JA3wFzYQzQZZLnZYIrGd6TNWYcrfGDhqEiHbDUbVk5ROl64acoY1mmMhF3DqiqC6QQm9l1ngSokVvkRalXuBVveyaQvGujjtBOvzzBMwl/wVT/KSBNaEiB9lA4TxJudVLxWgZO0xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759996586; c=relaxed/simple;
	bh=rhd2Vz+1e/iOi2LHto5xUh03sKP51Qg56huR5FisGJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+S+pjWkrYmgqeGVmmmW8pzJteKYCRW8v9Tk5t2+RE5FddHP7942bNEofTqpLuk90dgVTKLhlYEv0YRibs3O7yd1BfEc+hcbHIg22KFNsAA6gVdTn35uTlJbpaUuM3hk/xizYRV7OCzdL9HfPAUjSA/YpYFpn1K4dWJ8ja2YbOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWguEwY+; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ecdf2b1751so498539f8f.0
        for <stable@vger.kernel.org>; Thu, 09 Oct 2025 00:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759996583; x=1760601383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T0a1fYc0MJ9EuqumxNBgOSane0jVrbsSTPrQvSq4lE4=;
        b=nWguEwY+dp1rfzkVgoYo68UeyX8pTm+R7OayCMfo31qBdEZGuUxtM8OGSS3KZ2Udsb
         D7YyPyFoSey16FgsYH1rY1cI6z0zAzekveMn8h6P+2SlIPdMRmiwvWplDlEWNpMn4duv
         fkmCz/ABT2OI8vmgoMtv5T7p8ut+IDwGOyT5d9tR3KXCV/79wx9CTMRAueOKnukASYQI
         0xoo5ohwvBXfBNUZ3JW5ANhILVvYd2YHu3kJrNJ9sNrPSroPdQJX9OGy1F5K1G6muNlF
         kio502NkjsbTAsvrdg5wUqr+RNW4jwmM1uODNJ6m/OH6XyIa0zzIWta0wuxvsa+8a1uP
         +JAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759996583; x=1760601383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0a1fYc0MJ9EuqumxNBgOSane0jVrbsSTPrQvSq4lE4=;
        b=M7UAGP57u+qI8mq4uFW7oAQ+Sswta9xOCXgHZ2SlL26FUqxmwVe/T9h5S/HNPn8h0P
         u064Phmohd+fpNeFDOr+wTCyFJdmpmBMmxmq8/jppXCNpLD73Gro7KfFScwZAx153A+L
         NQSJ2eFds410QhE5o6TF0Rxr3E/tC/Q51Zg6lM6xBmzQ0fsdDtAHWnm9sfCviTnzfFa0
         SAjILkqQRPM+4Vh/mju+tFQ+ZIsRfZy41urhp4j+jg5xzktf6aPb0oFk6nCBpLGU4kDQ
         cOCbw5nJA4xLBfdOQ5baVviH4M5/Uh3h7VsVcPPhfni9N2bSMkrWZLQtj1xGE/beWgri
         f5gw==
X-Forwarded-Encrypted: i=1; AJvYcCUNjzs040wIfkRs46kMvzuesqX/N6SEGmZuij1cHy6fj/kTLdCi9T37bwFSlrYDKY1FbyUTXpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzQef/kOPhAiNt2zVRn8SCREqkDS6vbIpQbtz8GNXBBdkI+1T8
	QCokOY7S5b6AI3Yl1FQO15QF1LKszPoxT59iJ5BqBQr2wm7OzRWppjsOPqTY6Q==
X-Gm-Gg: ASbGnctu5basisZw/afV55gCnMb+DA+5Jv9WF2LQQ/rcwnYGdaXemp6clUeDY01pETG
	0SeL0zQxcdvAx8FlV+GJvS2eMa+XAd8IWiCQJFJxTj3QE7U3xdPyB0xV5GULhrlv2MixMb22MX5
	JHjan7NuWxf99tjpsIPHxbNVrRiAl6qPr1qXe5Iidh9wBvmkd9dtcKs/gnekH4SjMjjthqzDQWP
	RVClO1T7bQLe8x+9z6G4weTNnBJsyGE8lC0CfGZ5TfA/kzeaSotu3Dt8XpAZkbWFfWAvpluOHh0
	6SHPhrWIrKTg4X6h1ZGVxk67ABc1RiVbrjCzNWZ2W9UYmhdqrfFgsTu8Fnw3/ZjcZLC1dwZq/0M
	m6r2GW7eqhyKo9BNeiEp0LaUnrazTXmX1xjkHknyHmzXv2Py6iDC2L+wP0D6WeulEATc4iRT26U
	6YQuhCUj8w2trqhQDMelxNGl5xeAWzajXQ5W3D0ohnHcZv
X-Google-Smtp-Source: AGHT+IHdPDeElx1hyAYh5U0ai1YogNJIHEcNDQIevaS+npNxA1G4K3X5r3iKDWJLm2QYPiZpKcmqQA==
X-Received: by 2002:a05:6000:2301:b0:425:72cd:8364 with SMTP id ffacd0b85a97d-4266e8e1afamr4240788f8f.53.1759996582753;
        Thu, 09 Oct 2025 00:56:22 -0700 (PDT)
Received: from orome (p200300e41f28f500f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:f500:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6bbesm33269369f8f.12.2025.10.09.00.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 00:56:20 -0700 (PDT)
Date: Thu, 9 Oct 2025 09:56:18 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Johan Hovold <johan@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
	Rob Clark <robin.clark@oss.qualcomm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Yong Wu <yong.wu@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Chen-Yu Tsai <wens@csie.org>, Krishna Reddy <vdumpa@nvidia.com>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Thierry Reding <treding@nvidia.com>, Miaoqian Lin <linmq006@gmail.com>
Subject: Re: [PATCH v2 14/14] iommu/tegra: fix device leak on probe_device()
Message-ID: <rp2yiradenf3twznebagx7tgsruwh66exiikal37c4fwo75t4t@4breto65stqt>
References: <20251007094327.11734-1-johan@kernel.org>
 <20251007094327.11734-15-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wgvpzj7uzsv4xh6z"
Content-Disposition: inline
In-Reply-To: <20251007094327.11734-15-johan@kernel.org>


--wgvpzj7uzsv4xh6z
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 14/14] iommu/tegra: fix device leak on probe_device()
MIME-Version: 1.0

On Tue, Oct 07, 2025 at 11:43:27AM +0200, Johan Hovold wrote:
> Make sure to drop the reference taken to the iommu platform device when
> looking up its driver data during probe_device().
>=20
> Note that commit 9826e393e4a8 ("iommu/tegra-smmu: Fix missing
> put_device() call in tegra_smmu_find") fixed the leak in an error path,
> but the reference is still leaking on success.
>=20
> Fixes: 891846516317 ("memory: Add NVIDIA Tegra memory controller support")
> Cc: stable@vger.kernel.org	# 3.19: 9826e393e4a8
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Miaoqian Lin <linmq006@gmail.com>
> Acked-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/iommu/tegra-smmu.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index 36cdd5fbab07..f6f26a072820 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -830,10 +830,9 @@ static struct tegra_smmu *tegra_smmu_find(struct dev=
ice_node *np)
>  		return NULL;
> =20
>  	mc =3D platform_get_drvdata(pdev);
> -	if (!mc) {
> -		put_device(&pdev->dev);
> +	put_device(&pdev->dev);
> +	if (!mc)
>  		return NULL;
> -	}
> =20
>  	return mc->smmu;

pdev->dev is what's backing mc, so if we use put_device() here, then the
MC could go away at any time, right?

So the goal here was to make sure that the MC stays around during the
entire lifetime of the IOMMU attachment. We don't currently release that
reference, ever, so there is a leak, but wouldn't it be more appropriate
to release it in a .release_device implementation?

Thierry

--wgvpzj7uzsv4xh6z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmjnaqIACgkQ3SOs138+
s6GKbhAAsfz1wZw0MTC9RsEY4Yd9FfbGZFwUqkdbKTFeuIj2pdIDddlr1W27EUR4
k8LSmG+B/zzQVAB+e6/9evMs0tBh7sAJqdN+4KS9Xu9oCSz0NZT/DVYKPEhAH44D
/LkM2+RGcyVcF/2ebov9rCMzHJpcNbgjU6gg9NfQlCrl7diKXSUGhTcSL/Emycmg
3FuBz6DDHAD0J1slkQ7Tfy+jUKm4Z8Ewh4NBTF0Cv8k+S6WdTq8TOlVhedYyOhii
YGJeu84qQoOfIf3wFIWqIswb0NmzL/uN/kMw4eLy3FaJ+H9LjYVrfHkDO5lNfW/N
wwj7QOHLllKcSavr7TPGLglzrRBj2l0ApXL+8Xe1zLvhTx7VX4ksEAVzkJY4mHmu
5M2JLtgntGiyAY8Korl+NY0K3G42D48qa4fWIewpTEjbT5IQB3C0GQsDMaz0uaZT
xQK1Ik2W4zP6w/de2FlZj7YF2D/8tAuS7Af8uEZXMny3addBpoICCgraDg4aU1XV
Nqx/TP3mFHu4V/J6twarFQM7zTeKiKdUyp0yJ428Jed/yGVREBjAqS8Vvml/Zmpn
e7LFJGHYCLUVymAE1z61G3HPSt1w1IAnRaHrSrq/IbanY3Jhfeu95Az/fpYcW2hU
FOjysPFAigkUvlqz6M954uRgLGHixqtm3vI/VA+LtKqjR1PJo3w=
=VlYs
-----END PGP SIGNATURE-----

--wgvpzj7uzsv4xh6z--

