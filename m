Return-Path: <stable+bounces-45355-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD168C7FF6
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 04:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DBBE1C2173F
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 02:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E928BEA;
	Fri, 17 May 2024 02:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcvu5ebm"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6844D8F54;
	Fri, 17 May 2024 02:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715913457; cv=none; b=C1H4LNFFGvx42HnK7N2qSVkoIFRqR3VmtOCUKbFbwMNaRZQEAxeZmuDhOlj1KldSOkN1RA/SQ/XekDKrA4xq9elkPq207GntRnsi+TqCQ22y+uwyMqLkDJjas9oA1u47ge+Zqfy8+QDPNclN1uXrPj0FisOZobQV1+cF+mAL+Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715913457; c=relaxed/simple;
	bh=2dKSI6wqijqA7agrm8EhcqT8ikiKT0WeullcDAYN1lI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uweOXJMyxS0NEhFtCVT3Ehbqxi6pk6kS+DOb4waBbpZ8IMQvngpBxDfu1o04XMuOgEJdZZ7k3wceOZeHLqnbnRZ+s7dQmzbla+ZAwfbektBqXZaStSIKrJ2qUbGti8i1paiflR69sS9AS0UnGa27ZNhvq9jcTidkqokkvwC4OJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcvu5ebm; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2b9702e05easo731192a91.1;
        Thu, 16 May 2024 19:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715913455; x=1716518255; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N1bV36pJMdeLqi57LPsIILR9dVkyUf6MNsXvOWFVqDc=;
        b=fcvu5ebmEWxcH/l8DYH+jkdui441uBkA1m1VeHHAKUk4vU0nhA8Em9ml0T26sqV/eI
         v3U3hefO3E1J1W5KClzimms+ApDPhcsC7t/NCkLL6rh8TXxMD46L3y0OVXRGzYQ5IxV8
         EzKinp8GB7XQmV1EjRj0UU+NyKDj7TVKuXfOKOWVDXj8fmxbuuVE/xFktN1sJiYhfGmf
         6JGoBYvQ6L0GcAgyyKQkNp2Z5fVTckjY8XLGb/KcQ0Lks3l+WJy87tXBrPEtGOASoKrG
         6l9wzKKC9jpzrfhAnjnRojaVhYs3lCsdAjCElGugcCibI4z/N+mxxN6tyVpqxrRsahwh
         TgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715913455; x=1716518255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1bV36pJMdeLqi57LPsIILR9dVkyUf6MNsXvOWFVqDc=;
        b=um3zRj4fEQ8rfS/28JySqdihzDhoEmY1ElFeeHzXtM8gMmeYRcn4tkS5hpYh9VvC0V
         6cEOfmIGvKVPx4VnW2MuNihJtKV+/9KsdFKBWpjlwJIVwignyxMYRyjXLQSipul0uQoC
         /BpLNy/qe7A8jG96vQOXXYGXOB99l+v7FO6HAE9SC345VEDK/EFOL/SElPT/CPGHhg/m
         Sh5tpVOq14mO8GWI1BScQdTgRk3FTUlz6Fos0XE95N1zzRff6napkgiimlkb+U+VqAan
         UF5CciV0VOmXAVAAbhrYtAFVgMSrWiLBVch3MJ1VD3Dg61IaLPCvXUmfgE+Xv0gkVg7N
         jNqA==
X-Forwarded-Encrypted: i=1; AJvYcCX1/ou8uB+7fC7mfhiwOApu8FppMqY6Pqij07Zl4i/hc4BxZYErEbZW8ASZZz9a/+4iB7y+pgYYWEx8Yf2G8fo1FupcrBgQHAh54f2DBBQexfQZSYwPAZa8GlzKOM4C3Fmq0dkF
X-Gm-Message-State: AOJu0YwyxRq4eXGffEhKHfsLOmvMKPz2dKSGu8OF8If4AftBGRDHoeOO
	lVPcqHbY8EIACQL573/y70vSSRHhLc1yh4gnxS1JovoQcmTFiw5y
X-Google-Smtp-Source: AGHT+IEx2E3lPYmU6R303wxd59YlljM+e4ZAMrpQgif5X9zHASJgK2YsiVwb5fSOSYVP/d/X7kLY0w==
X-Received: by 2002:a17:90b:3708:b0:2b6:2069:f825 with SMTP id 98e67ed59e1d1-2b6cc03f442mr19519560a91.8.1715913455409;
        Thu, 16 May 2024 19:37:35 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b62863a5fbsm16469563a91.4.2024.05.16.19.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 19:37:34 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 2B644186DD434; Fri, 17 May 2024 09:37:32 +0700 (WIB)
Date: Fri, 17 May 2024 09:37:31 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.9 0/5] 6.9.1-rc1 review
Message-ID: <ZkbC61CKkOPIZsFY@archie.me>
References: <20240515082345.213796290@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="L4pKaacYqaHosWha"
Content-Disposition: inline
In-Reply-To: <20240515082345.213796290@linuxfoundation.org>


--L4pKaacYqaHosWha
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 10:26:37AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.1 release.
> There are 5 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--L4pKaacYqaHosWha
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZkbC6AAKCRD2uYlJVVFO
o5eRAQDkJz6MyxYm59PTs4d8+39lgNKUgZtIRN7KBZlF5BPElAD/axDvZtbWhhNs
hQtZ/GkPLPnlA4Nyyk0US4omlilyWgQ=
=V7ou
-----END PGP SIGNATURE-----

--L4pKaacYqaHosWha--

