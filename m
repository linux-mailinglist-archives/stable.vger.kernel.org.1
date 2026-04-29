Return-Path: <stable+bounces-241934-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2F+jOEBX8mm5pwEAu9opvQ
	(envelope-from <stable+bounces-241934-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 21:08:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7764998C2
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 21:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 567193078427
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 19:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF7C42317B;
	Wed, 29 Apr 2026 19:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b="GUwG85sZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00328421A12
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 19:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777489688; cv=none; b=o51fsVQmUo7/Pp9JIgutBsXGxK2H+qdavt4FtQh/GoLrjoT19l8sPXqh8YJi5iRHfMHqVy6M1gIDYCnRa1S8PZE9FbePaZcLdywOYVwoDCvwF3RGs29YfrMJVKOj5Ba+qThVkKIdObo/cnRxh4krsl7chd366akcvrQMZNUvx/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777489688; c=relaxed/simple;
	bh=7+Hvv4+54ohcqqP5bPt0lbTIfMcofDo1/arHFiSOaAE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C/AQQjrnNk2/qwX4udfS54MIwRG8re373UNtR3MiPK+SDDr+fMO1G8Fq+TGpO0e50lHNXQpnRmkaH9P5ruPOL5pmJU1guqvs76SedQ5N8Xmma3tDN/yZzUzM26a2ieWnNUhEVnV8jmSclOBxCWzsB0VJi0ha+Phbyay0C1bfETU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b=GUwG85sZ; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50d876329bbso414211cf.2
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 12:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20251104.gappssmtp.com; s=20251104; t=1777489685; x=1778094485; darn=vger.kernel.org;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ysVs+tGOn7Mjhq3uiCYR8hMiyn+nHB8HC49fRVE07mw=;
        b=GUwG85sZAEQn+CH3KIx4pYpsli4KMNjOSjV3xQGIXR1JI/KeuxKZ1tvVW71Z78x200
         5oVuohzxxse+aDSD9UoX7IAQJy4ELZescDTbA3Aebi/580taARxrfFKNXigAwvLOuWGv
         x0UCNl1fyNM5TJXpDywhOxQrD7SpBN0ap4Rx4qqrFViq3stRcEtcUA26qoJSACSyP3rB
         sjUKrOEsbNFEmdKujd4w0dgDYTiab0ebcoWEY3SKz09Y2yZpxWqEcou1yumSR9e9GEm7
         1RaT0a8I6EwsYCgarVV5cTScFt+9Vw8xG0acYRSDv7YvMCmwvejTWs8WqJWE7OxYZ0T0
         IqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777489685; x=1778094485;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ysVs+tGOn7Mjhq3uiCYR8hMiyn+nHB8HC49fRVE07mw=;
        b=azfPj2a7fKuUjHGIuE14s+0c2K32IpFcehEt7aY8IJYoDtv8uKErd5jUXeXNv73UjP
         j58pIMhs9qw/asdoPj1sychZ2Zn/SAbcaNNiQwehYzk0lHOnzr0iJV4u+eUvUbUVjTED
         DL1fd7CutwiiFZkEtbvEzkYSRZkFX1FUl/kVlzAd9OI8+kO4XbGY0GnRaRCdlxIhNm5n
         1gkfBamqUU7EwGrL9CGv2H/bNSdmWfOYpwLUA258aZ9eVOpYebAbt1jqr7rCSKAuwQ7b
         3UFXfrj/+EcCbAmf5G6uSRqPcXc94PPcEI4FQxnccqKARZqNUeSIBrLMwlXgwmBND8ne
         uKZw==
X-Forwarded-Encrypted: i=1; AFNElJ/blBYUevck/QXXkhC56KjVvJ/EwQ3PF+ERV/7dYedwNZuln96YZKCVjL2d4Na2JUhsqejuOdE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3METaMIMHw7/D8NmkzQiDRUxV6SzHGvGCOQ121HkTZiSToP2s
	BXlT5dYlOl1IXjj4o+41+5EgcktFJjBxfV3kINnBM2IzQDCz3zAQoyqq3F0Q2sdyxQc=
X-Gm-Gg: AeBDietAFObAj/y7GRL44eC9s3EIyjoKIQPolDk4O3tK5HIjrGIFO/V1R8xrDlMM5LY
	MllNSq691K0LRQB3GTnvE3cVnWVLOx3WsbRw/MszKE0PE3cuiF2VWk9gRm2BckFwZ15ydKpK7wC
	ZNYSVZcvVkRB6V8Kj3Rmqe7XzePvQuLiEMUPm/mKnU5yqdOlOJ6P5asU1zXgRbPtX2jrw33fcJw
	jNspQ44QXUx02O2ARW/GjQjF/GMnkfummjYsZ7PO+ZqW+fwLuCp6MN6iTtFR54vHG9htw5g0uGf
	9TZb1eKzyElh85oo8Pz3udOgx6SEIjcnkck60mKNeGZFpx9gr80C5PQFOr/oRFVITE/AsG6P6dV
	ne1jVg1JbftBBQBOmYj5V9Az7lb7+01w9P/wjtHIB3xw8azmaL4JkUh2zGhFHHYtR6dg22kL1rZ
	PrDnapLMXU6KaNcA6vonV2q6MI1yR/I2XF2pNn5UIgj+YI0Px5ng==
X-Received: by 2002:ac8:7d51:0:b0:50d:6ee0:3822 with SMTP id d75a77b69052e-5100e0f4ed9mr120711691cf.4.1777489684869;
        Wed, 29 Apr 2026 12:08:04 -0700 (PDT)
Received: from ?IPv6:2606:6d00:15:e06b::c41? ([2606:6d00:15:e06b::c41])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5101ae657d7sm23790771cf.21.2026.04.29.12.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 12:08:03 -0700 (PDT)
Message-ID: <6b9544538177a833c7de635782c67f3fae0beef5.camel@ndufresne.ca>
Subject: Re: [PATCH] media: cedrus: clean up media device on probe failure
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: =?UTF-8?Q?=EB=B0=95=EB=AA=85=ED=9B=88?= <mhun512@gmail.com>, Maxime
 Ripard <mripard@kernel.org>, Paul Kocialkowski <paulk@sys-base.io>, Mauro
 Carvalho Chehab	 <mchehab@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  Chen-Yu Tsai <wens@kernel.org>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Samuel Holland	 <samuel@sholland.org>
Cc: linux-media@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Ijae Kim
 <ae878000@gmail.com>
Date: Wed, 29 Apr 2026 15:08:02 -0400
In-Reply-To: <20260427100049.29034-1-pakmyeonghun@bagmyeonghun-ui-MacBookPro.local>
References: 
	<20260427100049.29034-1-pakmyeonghun@bagmyeonghun-ui-MacBookPro.local>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual;
 keydata=mDMEaCN2ixYJKwYBBAHaRw8BAQdAM0EHepTful3JOIzcPv6ekHOenE1u0vDG1gdHFrChD
 /e0J05pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPoicBBMWCgBEAhsDBQsJCA
 cCAiICBhUKCQgLAgQWAgMBAh4HAheABQkJZfd1FiEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrjo
 CGQEACgkQ2UGUUSlgcvQlQwD/RjpU1SZYcKG6pnfnQ8ivgtTkGDRUJ8gP3fK7+XUjRNIA/iXfhXMN
 abIWxO2oCXKf3TdD7aQ4070KO6zSxIcxgNQFtDFOaWNvbGFzIER1ZnJlc25lIDxuaWNvbGFzLmR1Z
 nJlc25lQGNvbGxhYm9yYS5jb20+iJkEExYKAEECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4
 AWIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaCyyxgUJCWX3dQAKCRDZQZRRKWBy9ARJAP96pFmLffZ
 smBUpkyVBfFAf+zq6BJt769R0al3kHvUKdgD9G7KAHuioxD2v6SX7idpIazjzx8b8rfzwTWyOQWHC
 AAS0LU5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXMuZHVmcmVzbmVAZ21haWwuY29tPoiZBBMWCgBBF
 iEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrGYCGwMFCQll93UFCwkIBwICIgIGFQoJCAsCBBYCAw
 ECHgcCF4AACgkQ2UGUUSlgcvRObgD/YnQjfi4+L8f4fI7p1pPMTwRTcaRdy6aqkKEmKsCArzQBAK8
 bRLv9QjuqsE6oQZra/RB4widZPvphs78H0P6NmpIJ
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-ArOwzQZ1bmZyT5qFP9QG"
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 8F7764998C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[ndufresne-ca.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[ndufresne.ca : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241934-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,sys-base.io,linuxfoundation.org,sholland.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,lists.infradead.org,gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolas@ndufresne.ca,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[ndufresne-ca.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ndufresne-ca.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]


--=-ArOwzQZ1bmZyT5qFP9QG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lundi 27 avril 2026 =C3=A0 19:00 +0900, =EB=B0=95=EB=AA=85=ED=9B=88 a =
=C3=A9crit=C2=A0:
> From: Myeonghun Pak <mhun512@gmail.com>
>=20
> cedrus_probe() initializes the media device before registering the video
> device, the media controller, and the media device. If any of those later
> steps fails, probe returns without calling media_device_cleanup(), so the
> media device internals initialized by media_device_init() are left behind=
.
>=20
> Add a media-device cleanup label to the probe unwind path and route video
> registration failures through it as well.
>=20
> Fixes: 50e761516f2b8c ("media: platform: Add Cedrus VPU decoder driver")
> Cc: stable@vger.kernel.org
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
> =C2=A0drivers/staging/media/sunxi/cedrus/cedrus.c | 4 +++-
> =C2=A01 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/stagin=
g/media/sunxi/cedrus/cedrus.c
> index 6600245dff..2c25654640 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
> @@ -507,7 +507,7 @@ static int cedrus_probe(struct platform_device *pdev)
> =C2=A0	ret =3D video_register_device(vfd, VFL_TYPE_VIDEO, 0);
> =C2=A0	if (ret) {
> =C2=A0		v4l2_err(&dev->v4l2_dev, "Failed to register video device\n");
> -		goto err_m2m;
> +		goto err_media_cleanup;
> =C2=A0	}
> =C2=A0
> =C2=A0	v4l2_info(&dev->v4l2_dev,
> @@ -533,6 +533,8 @@ static int cedrus_probe(struct platform_device *pdev)
> =C2=A0	v4l2_m2m_unregister_media_controller(dev->m2m_dev);
> =C2=A0err_video:
> =C2=A0	video_unregister_device(&dev->vfd);
> +err_media_cleanup:
> +	media_device_cleanup(&dev->mdev);
> =C2=A0err_m2m:

This label is left unused. Can you fix this warning please.

Nicolas

> =C2=A0	v4l2_m2m_release(dev->m2m_dev);
> =C2=A0err_v4l2:

--=-ArOwzQZ1bmZyT5qFP9QG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCafJXEgAKCRDZQZRRKWBy
9Jb5AP0W2NO3lfYARP66qlgaOk81oBVFPzJbTkbCjtmBnCuWbQEAqCvyLm4BXXjp
0DRDRSToJuHjR05VHYK2ozXTCeXXgQw=
=JKEn
-----END PGP SIGNATURE-----

--=-ArOwzQZ1bmZyT5qFP9QG--

