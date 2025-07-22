Return-Path: <stable+bounces-164283-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4281CB0E36A
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 20:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 722AFAA6C6D
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 18:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524D3277814;
	Tue, 22 Jul 2025 18:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="apm/SbS0"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C0C26A0FD
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 18:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753208613; cv=none; b=XfReCwsZfbKesTQ9hRTsQ58D8hLhpJzIKelRKgPHcRkHvaoOFeBw821MeVfmpH52uqdKWG2gOI60I5SPVg7aTe+k+GmGSptikhwfxm4EKMWYHcNKUwPkL0HbapwHpoNfwmE8LvdjHVCQF5zrYwhZ5KkABCnjOcR7rJbRjh2E31k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753208613; c=relaxed/simple;
	bh=qAi5yfWh+jYmjX0bdG5CXGf8W5oEyS26pkxeGUjFk4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hprxc+ep7TIEvxBo8cRk6ygv61s6wQykDFnFVPnNdGbMyTdCyz7TOTDp5bbqOc4D8qxJs6EsCzaCyN4rxGc/Y83nfwWQv/iMDi09jnBXYyzwg1B7Chq4hPRUJfensZVRO9s0Lk88vU5TSoP4HYlX8B7d7zSqzyYBstaOfHO5DMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=apm/SbS0; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-23f8d27eeeaso10005835ad.2
        for <stable@vger.kernel.org>; Tue, 22 Jul 2025 11:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753208611; x=1753813411; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OQGCd5lV64hx5eIJ73TZCqmMkIPGhtau8Q2iyjlhZ0g=;
        b=apm/SbS0jMZbpzPefXQvg2FoDgKrYQWdNd5Ps68Uvo0mme3ZvQHW2Wzk9JEyxBf/+A
         m976SIIphgUtQEka8/gDoWPEYu4XmKfpRQWDW4LrF9NVlt8zxpPsModKZohL2DHz6vmO
         DpE/IuN1aGo2Iy1/pG7ljExDeVBZeMi3Fh32Eg2hCUOR/NWXJd7mv41ZcmUkRQW5lwmi
         j+1n0GyfuRVi+2Ts6s3FkhPXuE1zY/YE8fSTIZ28+Jr7ZlMdouYl7RYbkau2jyGICc5G
         S40MW6I123LSKY9gRcjvDk15ArE3/bP26HwKatv0h7ad11i9eGsxvRlBvu1ptVhSiaH0
         lTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753208611; x=1753813411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQGCd5lV64hx5eIJ73TZCqmMkIPGhtau8Q2iyjlhZ0g=;
        b=KYQeC2MSbcv10cMPA3MB1XZLyLAxZfECEFdH+eQbStRLEBqCbVmIgSUgvF9VwTZpX7
         coQY8eG6+1OTHoTRGoGcbKDDRLdbHVG6WsjxJwLiO9PU0v88rWG27Mh2+8hnF5hMLTuu
         zSM+K/hvtMzsSzUUo5XL5GNzO6EVv9qSeRNQPBzArLIhp73z4uvR9QtyZRMS55sMwksQ
         xuOOm+yXW9o1eARSbt61yd+ST/Ddf4tRRgMThYPthogrnqj1Q4Z6iwx3cxqk1npF1hLS
         DAN2oZyfRwUUWyo6P4OCJ14mPvsYK1nrPCjdzw44OKc/dHM5FbMMgj891U7zJOO2qvFN
         aTzA==
X-Forwarded-Encrypted: i=1; AJvYcCVVZMjjk47MH0ICWMTFDAiNoXCmvlylsyPBccx45VVRpJuQNyS2HNkksdtmIGl2sNm2z6wJxPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOAlCqUxuS2sGK/qeWFCfjWiAChlLTmhiWEGgjGQU5gyI9RCXx
	NvlqMaTcRAnyqLXGkbecweelHOXdMCf89X7MaJxJPcmHaKJfj9EXQya94OaN1IyH6g==
X-Gm-Gg: ASbGnctALpEUoFNX5fqy9PT33qdL++BPCu1gK5losigobNDi9uwhdKqVAk8rbkDxzgM
	Cjufvl3KmeUSv0E/lxYRHqOkDCLpt8Ltg3YOXLGikmZ4OzaYsDn3h6np2VKG+da0ZwkCcsh6YYI
	RZMl6BeTqCWItO32TfmTLnU/NBELEAo8O52nPyyQOwDd1BBgLjlds5WS17icfK6hmsA4CisLV08
	mcYwFbE4pVTAYvsHG53IpsWtoK0bvRkO2rm4PYhrs9ksDqRflm+FMhJEiDcCQw8ZD14fTHQp/Du
	jIb02/NMKETm/T01WJeBD/7p5GpT3hrrhcf8UlG1Q+ZVGNzL1X6UWt/ALFLf/ZB5YXW7yhD3Upk
	fpIYWlX2nU3WDOUUlwANDa+4SNSNEemaltXaUKp1WU6PJqC7Lzoz4xfG8s3qq
X-Google-Smtp-Source: AGHT+IFv+X1tAQgAzc2B+P5hgL4CrcnzpzJG4wwZRBwLYWZA/u97/VEXl88uvgewWbqKkThljwosqA==
X-Received: by 2002:a17:902:e884:b0:235:129a:175f with SMTP id d9443c01a7336-23e2573647bmr353330175ad.34.1753208610639;
        Tue, 22 Jul 2025 11:23:30 -0700 (PDT)
Received: from google.com (236.219.125.34.bc.googleusercontent.com. [34.125.219.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6d397esm80620895ad.147.2025.07.22.11.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 11:23:29 -0700 (PDT)
Date: Tue, 22 Jul 2025 18:23:25 +0000
From: Benson Leung <bleung@google.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: bleung@chromium.org, gregkh@linuxfoundation.org,
	chrome-platform@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] platform/chrome: cros_ec: Unregister notifier in
 cros_ec_unregister()
Message-ID: <aH_XHRbzx-sLcS7X@google.com>
References: <20250722120513.234031-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/RhPvZ8/ehv5ls0I"
Content-Disposition: inline
In-Reply-To: <20250722120513.234031-1-tzungbi@kernel.org>


--/RhPvZ8/ehv5ls0I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 12:05:13PM +0000, Tzung-Bi Shih wrote:
> The blocking notifier is registered in cros_ec_register(); however, it
> isn't unregistered in cros_ec_unregister().
>=20
> Fix it.
>=20
> Fixes: 42cd0ab476e2 ("platform/chrome: cros_ec: Query EC protocol version=
 if EC transitions between RO/RW")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Benson Leung <bleung@chromium.org>


> ---
> This is separated from a series (https://lore.kernel.org/chrome-platform/=
20250721044456.2736300-3-tzungbi@kernel.org/).
>=20
> While I'm still figuring out/testing the series, it'd be better to send t=
he
> fix earlier (to catch up the upcoming merge window for example).
>=20
>  drivers/platform/chrome/cros_ec.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/=
cros_ec.c
> index 110771a8645e..fd58781a2fb7 100644
> --- a/drivers/platform/chrome/cros_ec.c
> +++ b/drivers/platform/chrome/cros_ec.c
> @@ -318,6 +318,9 @@ EXPORT_SYMBOL(cros_ec_register);
>   */
>  void cros_ec_unregister(struct cros_ec_device *ec_dev)
>  {
> +	if (ec_dev->mkbp_event_supported)
> +		blocking_notifier_chain_unregister(&ec_dev->event_notifier,
> +						   &ec_dev->notifier_ready);
>  	platform_device_unregister(ec_dev->pd);
>  	platform_device_unregister(ec_dev->ec);
>  	mutex_destroy(&ec_dev->lock);
> --=20
> 2.50.0.727.gbf7dc18ff4-goog
>=20

--/RhPvZ8/ehv5ls0I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCaH/XHQAKCRBzbaomhzOw
whuDAP9ayj8DW8AnAHr6chusHbOf7mtbHDO3mhmwfEveXmFSuAEA1ldJLMnzH3GL
GFEiGO8hMC9IHlpcxa7bM9WOmwF3cQ0=
=u4Ay
-----END PGP SIGNATURE-----

--/RhPvZ8/ehv5ls0I--

