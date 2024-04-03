Return-Path: <stable+bounces-35678-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 328648966E2
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 09:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 639011C25EC2
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 07:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF614EB2E;
	Wed,  3 Apr 2024 07:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DTHFvxYU"
X-Original-To: stable@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761E5134B2
	for <stable@vger.kernel.org>; Wed,  3 Apr 2024 07:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712130187; cv=none; b=m8PKifdF2+mkYqfib5rl8dCh3PzKQmHCq5dmOk+yzi5UvwVwwMEoL6q8tRrB8bpEnHjEh+EIfpJVvggXpzGKw3lIOPJsRN6k6aTxS/shQCopTDtPTLOnegE49fwbLfxciCOxP8dzRU5Efo3aOFulNBm4edSG7A+JRC5VXmOInGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712130187; c=relaxed/simple;
	bh=8GUfyMpfUxxwsfYZy18lB0UcL/QiywioGdkMmWO6JTo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sbVatL9I12GwDnX4SuzXh8k81/WxeRNpsFskqikmRJLoSRlT7PkIX1TreFmfN1zn1sDOFDxv5z5xUrx66S2vUx4fMRsFRP15KHfM7WugvtZwmaF3xAEvnLgmozvErOnpDVoeC63dKPvhDt3EIRPe2+RYD3q9Yz/Yr376Nzduato=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DTHFvxYU; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712130183;
	bh=8GUfyMpfUxxwsfYZy18lB0UcL/QiywioGdkMmWO6JTo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DTHFvxYUxdXeiQNc245XfGp0qS/3bVadnx/xtEboHKgoLISP/c4/bmuIgXNIcBm8m
	 Hn9KSb8BiPbkHKWpJB9athTnJbFbd6v2IxAt4BdTCL5W6NpDb1eGoKKg2CwVctM4D+
	 XNxlHTvYf5U99Zun0mYXlp/rjzkpTPOobxGD1sxFy7Ff+xiviO9PhI7JZgAX35cvuI
	 NbHMq4Gyjg8nvqVvn8T83erZN/LSNqQEKQtnuDI7ht5LozhX46Kp03cykPYnUmi86+
	 5WmvO6oTGRAXsShFXLuVmwrtl7CbVRTR7QLKrq32rbpOVzuSX/fF68wOkxFTlpOjKr
	 ejXvJf2eGeVZQ==
Received: from eldfell (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pq)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CE96837820F5;
	Wed,  3 Apr 2024 07:43:02 +0000 (UTC)
Date: Wed, 3 Apr 2024 10:42:46 +0300
From: Pekka Paalanen <pekka.paalanen@collabora.com>
To: igt-dev@lists.freedesktop.org
Cc: Zack Rusin <zack.rusin@broadcom.com>, dri-devel@lists.freedesktop.org,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, ian.forbes@broadcom.com,
 martin.krastev@broadcom.com, maaz.mombasawala@broadcom.com,
 stable@vger.kernel.org
Subject: Re: [PATCH 5/5] drm/vmwgfx: Sort primary plane formats by order of
 preference
Message-ID: <20240403104246.6c94eea0.pekka.paalanen@collabora.com>
In-Reply-To: <20240402232813.2670131-6-zack.rusin@broadcom.com>
References: <20240402232813.2670131-1-zack.rusin@broadcom.com>
	<20240402232813.2670131-6-zack.rusin@broadcom.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hA.YcA_c1NuAy1Btlx+H8RG";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/hA.YcA_c1NuAy1Btlx+H8RG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue,  2 Apr 2024 19:28:13 -0400
Zack Rusin <zack.rusin@broadcom.com> wrote:

> The table of primary plane formats wasn't sorted at all, leading to
> applications picking our least desirable formats by defaults.
>=20
> Sort the primary plane formats according to our order of preference.

This is good.

> Fixes IGT's kms_atomic plane-invalid-params which assumes that the
> preferred format is a 32bpp format.

That sounds strange, why would IGT depend on preferred format being
32bpp?

That must be an oversight. IGT cannot dictate the format that hardware
must prefer. XRGB8888 is strongly suggested to be supported in general,
but why also preferred?


Thanks,
pq


> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> Fixes: 36cc79bc9077 ("drm/vmwgfx: Add universal plane support")
> Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadc=
om.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v4.12+
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_kms.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h b/drivers/gpu/drm/vmwgfx=
/vmwgfx_kms.h
> index bf9931e3a728..bf24f2f0dcfc 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
> @@ -233,10 +233,10 @@ struct vmw_framebuffer_bo {
> =20
> =20
>  static const uint32_t __maybe_unused vmw_primary_plane_formats[] =3D {
> -	DRM_FORMAT_XRGB1555,
> -	DRM_FORMAT_RGB565,
>  	DRM_FORMAT_XRGB8888,
>  	DRM_FORMAT_ARGB8888,
> +	DRM_FORMAT_RGB565,
> +	DRM_FORMAT_XRGB1555,
>  };
> =20
>  static const uint32_t __maybe_unused vmw_cursor_plane_formats[] =3D {


--Sig_/hA.YcA_c1NuAy1Btlx+H8RG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmYNCHYACgkQI1/ltBGq
qqcCOhAAqFtBj7+geV1SkcyGkPs5VJCwgfvQgDA/r26bGjben/EL1sP0ZmGNVhnq
B+laklYfFji+v9CR4DAYNGv6XOVur4Aji6ZV/WaJgeDNX+/8ZOp17FGy47c26AoG
d9rcINU+bMhmVxZKh9KZdRCS1HA8/cTH0ajeLIkXcIv3sCmjpzDe4gbae4XAKN7w
00P2jVuo+Und7Eai+aDAiB5YTTUUynkjqLkodQQZCjZBO0yfwKGnFMujwiMRuLqE
BYMlZQOM1aVawl4CQBxjG+MNUzpfKArFaZRp4AHae3qmQtC9AT1fsxb0hK5bAqGL
mr7qlxAj+S5vruyxRezuwxFuE4lQ1kmSPJAh+xUGE+YtgRACGfs0qrkVDOdLuRTY
n9458Fhdph69orV9K7cNGAK1+jN2D342Tx35uvs6f1lrqTLh9OTd1TvCaF8UbkuW
1x7VB/yINAL3/mv4M7NbJKlfOkCkukNRxXNwHJd/3muOAenDILZXWyMyYUQN+vru
1sQhZfIUjYoK3v3YfDdJ3Lq0m9NzMKrGNitAwR26GqLF+LhPrmiVT2PH+h7I412V
Ynz+pVV+eh2+EQ98vSJUJk43RzMQOLQbNOktvqYQXQJ2jzjtziwJeE5w8f0pokTM
ReagiASt2ZkmYOR2ttiqlv+UQHUtAkq8Ve7E4T2gOpCcQCyK5IU=
=0d+L
-----END PGP SIGNATURE-----

--Sig_/hA.YcA_c1NuAy1Btlx+H8RG--

