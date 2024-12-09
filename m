Return-Path: <stable+bounces-100185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2969E9894
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 15:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C31A2283019
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 14:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D731ACEA3;
	Mon,  9 Dec 2024 14:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czuJDqZa"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C246B1798F;
	Mon,  9 Dec 2024 14:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733753926; cv=none; b=WNWA5xaR0HHNx/6oq0ztXfBY+i6iuNB5BIrvBnzsZwHqKLrDharUNCLwrhPxKSteK0eCkY5zTN/f7Shzfdy36FdSI6U/PbMKIUfjztMCpw06gFkBJWZ/La6QlrytwWetgjeDa762KfLoLC92UKvv2q4+kOfIgi0wQH/ZYFNJxS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733753926; c=relaxed/simple;
	bh=8FsLJNnBvkyb0aie8QpxEfYPGhWI0ZQ/I6okIqIV6dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HqTxSnv/YbJ5hktPWR1PeeWADBHj2oeQQC7VQCxuvVqFRxWBjovrgLh9wEWrNefKxUr2DKrIBTymZMvZh0LRMhl8TLyCdjJy7oQHV8wp6Tk9iss91EKskAcYVdCXmcy9kSk2mGJDCvbW6si+pUnRQOazMHTa7wGqYR+ztxm6m9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czuJDqZa; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3862df95f92so2257241f8f.2;
        Mon, 09 Dec 2024 06:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733753923; x=1734358723; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uqQ7Av76sCQ67PddSXj4+y1Hwv1xMZkPsZ7ivaLRViI=;
        b=czuJDqZa8HdHq8zEHJi/y8mcs2rMV9ytqqtsnlCptdIC9bsKDBBXnCFalh7jzhz35y
         OmFU+xrBQt9JwCv0ErEZBQmh9KUJZkd1DsosJpq1pJFxDd9Sqqt+2KIdLPjbVo8QW1Lb
         +iTY4jHiskl1PiFIvWqdcEaF92v5bSAISjFKMdWhGOrbfG8jjUh6IEEGXynS2CU+tB0k
         EJG/pv9kZYNQ9z4dxqNI3LSR7FofZ3U32bJLuqTq+pt5WJP7REuNCv4Gl5EdCmRHy3ei
         EQKauPIRgXEpA5K6bgGVXRN4V7xT4EUXG+pMaYOAN/6Fs0Y0Wca7L+B8CvLP85ai0wu2
         4uVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733753923; x=1734358723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqQ7Av76sCQ67PddSXj4+y1Hwv1xMZkPsZ7ivaLRViI=;
        b=WlN22Ak7Bfn+ViCJVbC1u7/Ck5l+lMMj+Y81eHUPat55eeLa0rQOJ9MZIoHCtacdIh
         kEKVsSSeHAta+kObUdFw3k1HwHW8n8BJ4T7OMekwMKHoEjnHN1bM7gOggATWCL6j9DCD
         1CFaZKXkDfTqzufyLiKejRDq8xfe4rW0nwuS4swKnx3T67ZNHnxe0OW2HgoOrYIrtCFt
         0HeJ4ONOufJcRsOW1gs8BibNqupIEdS1C6dvUdpnW9531qxjfAQsbkUXXc0LjiaOMJkx
         AnflRL2u3aMNH5knnrAQn+rB0zzeP4/2n7DCDW7Prg95Uxg0hF5zRw+6Vf/KWlVIcUog
         DlSw==
X-Forwarded-Encrypted: i=1; AJvYcCURPSwZFb6OwqlZLjJI5BZKH3ME3zqy0C3g3ToM8E6Mf0h/SSrD3lNGQWufPLF/olW3lNBU1aaZ2ggs@vger.kernel.org, AJvYcCV+o9hIg6UlOniZOOSMT1uGj6jD8fnMl8arBN7v9P6D2mhy1z8ZFsRhQrc8TlzIroHy6KKR6k7y@vger.kernel.org, AJvYcCX4iy7C3wgIOIXDMhxHB4IURsRdKmfYJFvV2HJWefUbjiDGiaebXXWvHl7VzfgJUJqPa1nhgXUIDF+ZrMI=@vger.kernel.org, AJvYcCXABmySfnsrT4zszJDLXGqApeFkRknSZqJj4L4d62pEk9H9pHB5mbxaIQwFpDllB0U5sUQz5lABXOA/kI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YydJaAB6bgHpZRp9sdaoMnyRjUTZhzlIfw7qe5bgqVbzbmd38yu
	L3QsCmuzg/TbSdre6gIuQhyQ+SPzFZGGLnUA45inUQLNYW/kp0EseUp6Ng==
X-Gm-Gg: ASbGnctTDB/dPHWHeRvcSlI0B2Lw5eXiNc18fZGffr5iI0CHtYExUDE646Thh930MDW
	eAr3ynnkLv+267v3en7EMnpDvOEcJSLyd3FxllidkXXDjo+eVZl1fJR6lhOkwVoTUkdu6WdmpjB
	EJ+Y/1l+/PDVgsczPyH+MY3KMXOty2vvn2g7J3sdg5uFIvxZ8Ki6oE3HSOh+wwmtzq3Y8/jCVzS
	la+F7egzN+7P/XF3Ju6h0HL710gogwDD260eX8pY36Kd6CENB7OQKLyZu4qSUhRdLanHNfyuQLD
	0J/zCEdBiaZ02WtLkQDnEXV3cZwKgmiaX1Ad
X-Google-Smtp-Source: AGHT+IFELAj1vgxKLoKs7dlvlEpcB4HXPiDSG1NhOtqIafP5sTUuMLFi7afz0ZNUuel47+Us0guQWQ==
X-Received: by 2002:a5d:588f:0:b0:385:f9db:3c4c with SMTP id ffacd0b85a97d-3862b33e5c1mr9840966f8f.9.1733753922778;
        Mon, 09 Dec 2024 06:18:42 -0800 (PST)
Received: from orome (p200300e41f281900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862a9705dfsm10955582f8f.4.2024.12.09.06.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 06:18:41 -0800 (PST)
Date: Mon, 9 Dec 2024 15:18:40 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Prathamesh Shete <pshete@nvidia.com>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, jonathanh@nvidia.com, 
	linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	anrao@nvidia.com, stable@vger.kernel.org
Subject: Re: [PATCH] mmc: sdhci-tegra: Remove
 SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC quirk
Message-ID: <sxqxmbsdnfieqdrld4xdhwkqngofm6bq64zqwsnpjjweeqkjrn@s7hdf2krdcvq>
References: <20241209101009.22710-1-pshete@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wxv6tqvev3dlmdnh"
Content-Disposition: inline
In-Reply-To: <20241209101009.22710-1-pshete@nvidia.com>


--wxv6tqvev3dlmdnh
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] mmc: sdhci-tegra: Remove
 SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC quirk
MIME-Version: 1.0

On Mon, Dec 09, 2024 at 03:40:09PM +0530, Prathamesh Shete wrote:
> Value 0 in ADMA length decsriptor is interpretated as 65536 on new Tegra
> chips, remove SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC quirk to make sure
> max ADMA2 length is 65536
>=20
> Fixes: 4346b7c7941d ("mmc: tegra: Add Tegra186 support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 1 -
>  1 file changed, 1 deletion(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--wxv6tqvev3dlmdnh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmdW/D8ACgkQ3SOs138+
s6HZ4g//abkNvj5aHoLv/O5qmK6fqI1BCApgACLXu5J9FnwoYqPCe6OwViy4iiP9
dmmqkBW+/wNrpJZZ3CgK2ZL+opMrC1ZfJLWTqzv3I9gB/EISOObv9JKRklBLMA1K
0KHSfsHcjHkFJDoGZY60OpkMD62ERvBbcCIz4GDEUtrLeyI75aFuxz6KvCWMupqn
8sp/p2kzKYamd7XMLsgbbpUH/Ex0l5HADnZBbeIHtV6ZzzyYETWQHKO87Y0baV52
wJ1kUEVV/mWajDS2NhZuJJDdqvt/DkEHjxu3pDe28ruO59964zZih95pcDwf7C5T
EEI9vHWsRXGvSCzbf291E5l/8bA/47hyIlmVNtuwUlMaMl+NEurtskYXR7qI1NNM
WJd+7FzVA/vjcc/l9pI+b7H/yqY8hA2gTsjMbl6qKAPNejhbTFUCjRBOw815+rht
8Z8JqpnM/aDLnMn4aULxAY1Ll+yhIF7UY4gmpi3R6IcxxuBArselQlnD/blFTFwu
ac+//nil2fBi5CeLZCjjRhxNrAA1UfGEGVtrBaKPVBS+wglO78yUuJFIQuQmL5GA
Fgqk8vRROvKH/YGuGNiR+HfVYVJUXVGkq+Sh1GBS97aJmDkAFxNFw/7zd4AwivMB
+jrCwGKSWTBHVTuKpfwtENLNYY/b/tydYmbh0dKK4kbq6hg8yTE=
=Cl3i
-----END PGP SIGNATURE-----

--wxv6tqvev3dlmdnh--

