Return-Path: <stable+bounces-56912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3357A925242
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 06:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 625A51C20316
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 04:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F1C1C6A5;
	Wed,  3 Jul 2024 04:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGpd7bj7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F132F61FE0;
	Wed,  3 Jul 2024 04:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719980761; cv=none; b=Uytod4oNkd3XIU1AOkVHVOv3p9iCNq60EStZFziSP1SNCZbHumttsz8H53mAu5w0rDp+DYL47RDHTQOkiyv1NQGLgsNOsI8C13vS2arm1LsZhL3qIiECxQm+CKFaY+YWOxTehJWCMwnx+zZUE/0bpPjBFe5EBUY72hkd56En9uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719980761; c=relaxed/simple;
	bh=CTqwihBOux67otfyvZtz70kvvZA4Vo/MhZfFROMw1yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udfbtSnqYVxnu+2CBP53o2UAFi5TXTZWIvNrS0YSJ+KYUOSq0FWcz9YBBxFrFJJgLGSBTvJu9lMiGZFOaFyK4hpKnA5h8VcDj1Wb2vwp23vLOAhPpZXH0Gu6sGKxtNzSJRzezMWQIGSMgidaxZ/+OQtAb29Gxk/pG6sBQlym/5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGpd7bj7; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fafc9e07f8so9468315ad.0;
        Tue, 02 Jul 2024 21:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719980759; x=1720585559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cBnaqUZYK96vUrgWPYxgC+5OHY9C7ZJqIA02ClmSNCQ=;
        b=EGpd7bj7ErSyMJ3X3h4ine+6143TfgdZOLopzdCg9Za2v9D2XgWtKWvzg36sAzKtd8
         Hh+wZ6po5d60Y/KvMlEImfwrn7n3E+Esn00OEYsVhzm6XC9SE1U6k0GoW/ZD7MX1icKr
         /VZZ1SwaGtfvnW9zDuzixDDVgnX3LG8V33qF5H1g8Q1TbjeJvdanq1qHNqREH9HzewgZ
         KszMt2DsMXjY1yEDDtiRBCQ0KgXgeSTXzfwVS4Ub3ovf2oyrZ2NE0juiKnUQFQM2ChAd
         PJe1kycdaLDaxZlLGom8+t91wvL9mqvubi9zVFp3uWZnBEv8hb48OWWlwYsEXJXXu4Qs
         2CzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719980759; x=1720585559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cBnaqUZYK96vUrgWPYxgC+5OHY9C7ZJqIA02ClmSNCQ=;
        b=LWdmCwX2hs9uaNqLps4UTctsKkPcI8lgr43UTeJm+8iyB/pwbhI4UHI38Zby9faDoz
         lyZYTB9xWg3ctVTonxk1S7TDOJSaVxohJn0fD+1SHu0KbpnkJMqPI2xfjoYq7BonNX21
         x9k1N19d6OsKMZ3OCFdxtxlKmXz2brIc/sQn8VndgDRveE32JPivCAgTPpEoT56hmbgd
         x7BdecBRseLhu0VsfNXm2kSoVxj1tQ2Q1wjFI9MLAYKSvUT7jFNpQia1zlMRLTCF6+q7
         NNlmZHjLuQrM/FPvCOLtBa2SmDYTEPnW2fm6YOxMDbLsskpDFZs6iGlPf4cxLf/tjW1D
         597A==
X-Forwarded-Encrypted: i=1; AJvYcCXY+GDzVVdvTFLfn9v4SlLgax1qIbhIY7H2Cf5wg2xBW1QJsaDdDGlPL4n5x824gE5LXRJHgYhK8Vn9jsr6bp0ojC+ML5KgSUlmrY9Pl64iy0VZELGLd/GZ2CklghDkfrM7hcFQ
X-Gm-Message-State: AOJu0YxcctFzygX4DkBAa4gFYzpoa3McsGACQP0kWM5EH/yC9M/xgM0f
	Mq9xDqiJKk08egN3rC2BForIP+el4r3ydoCCOzEin6EwVnrKo+YS
X-Google-Smtp-Source: AGHT+IHUeV3QCOeOWx1/Vbhxgd3leWzYw8PWTNlqtzJ85bI+P6YvI5aKH2cmkg1+QJ/JlB4oC5AlvA==
X-Received: by 2002:a17:902:f611:b0:1f7:1a31:fae8 with SMTP id d9443c01a7336-1fadbc85fc7mr122403305ad.26.1719980759067;
        Tue, 02 Jul 2024 21:25:59 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10e2197sm92898705ad.63.2024.07.02.21.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 21:25:58 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id A567A185B99C8; Wed, 03 Jul 2024 11:25:56 +0700 (WIB)
Date: Wed, 3 Jul 2024 11:25:56 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.9 000/222] 6.9.8-rc1 review
Message-ID: <ZoTS1NEjgv1FoVfC@archie.me>
References: <20240702170243.963426416@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y20GA+L+N+D68gra"
Content-Disposition: inline
In-Reply-To: <20240702170243.963426416@linuxfoundation.org>


--y20GA+L+N+D68gra
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 02, 2024 at 07:00:38PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.8 release.
> There are 222 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--y20GA+L+N+D68gra
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZoTSzwAKCRD2uYlJVVFO
oyEHAQCNKXYyjiaXYt1QH1Hl7jD8dw00fbeEs3uPj+bf7HmoWQEA0jcs3111Kssk
96nRJRvfR2+2ZJa6T5eSZ4TMzMD7LAc=
=lKUP
-----END PGP SIGNATURE-----

--y20GA+L+N+D68gra--

