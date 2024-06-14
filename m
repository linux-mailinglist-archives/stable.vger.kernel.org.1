Return-Path: <stable+bounces-52123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB739080E9
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 03:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 136981F22644
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 01:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C31183073;
	Fri, 14 Jun 2024 01:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8uaseqf"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6058365C;
	Fri, 14 Jun 2024 01:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718329481; cv=none; b=K8nYGHCoq/W8FG7ZROOXBihcFtkBoPFQHlWERZPPTzVdJ8qXXahIfbzNtZap5pAyafPjqNrcFAXQTc2esmqeTjlzOmaG33ZkryaQGtB2jF18SmgyWNzVdwsz6RMuFFg34ZUkwys08OMeB2QKss8RTGKRWcBG+3tkjfi9TntShLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718329481; c=relaxed/simple;
	bh=fH40zqOTfVcgLYU0HRNRBYRHUfogY6LIleH0ta3aoJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezi1KXFscGBRP8ZsUKS+l4RdSUQgEwKTm3kgFgb69b0Pl3rSMeaLwUWqvrgAGlN2CWusXvo9bnckcMFFTJBuvYFT53h9Rd+MF3S0V3lXGi7RtptfmYtJQTgd/fRdabMVc6s1CU3URrsdThcML040fD0aiMEKaO8W5DTnsI0IL1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8uaseqf; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-24c9f73ccaaso935854fac.1;
        Thu, 13 Jun 2024 18:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718329479; x=1718934279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ygO5V+oG+XeF4PldGgpxH0Gz5/YrIXpA9VZRkyom+l8=;
        b=c8uaseqfVWD0M8v1N859SAoHjUguwfF6RVnjfrS3NR83O1MGTuWznoLLg75Jtg6A84
         NaCx64dDYzSGBTNYrkcJtzb2MRjQbAgZyPNXMq3WsKMihYiUkhIMyhx56go4BHWNVWtx
         IFvWzWSJWp/NH955d0TzjYHHbbUVRgiY8If9OizgAv4bwq+h+OYLzd24F2G6ciPmgg+h
         6PpeuI9A5Iw2k0j9JjDp29Lz7hTCE3Xb/Hcy7LhAb7y1PvjE/h6oP0jZ7o5Yk341J+a8
         BQ8pbnGPNKYLNiCA+kiZP6vAfZZC2Kp5vTx6fcqR20/BeoN631V3H9LrF1eJL4G8bVP+
         fTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718329479; x=1718934279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygO5V+oG+XeF4PldGgpxH0Gz5/YrIXpA9VZRkyom+l8=;
        b=vRTOqwl3clRfInPqBpUsr8WaeEJaltzGL04WlmiGt+KNg/GjP5dGp+uVt87YhIhCnb
         yuci6te5XeK7oxFc7ArSb0yyE+LLz5xfymhpgvd+xgthjYj1CHvjXn/ZgLFostGO6PUe
         4BbPgHaFRMwG8OdFswqQkk/ce0UXQvxHIKsU2ZYfsiI5j6eaZ8lobOprri6s5Jrhw2RE
         eIJ0K6T4XZzcxXFjU//7ix9+m8cXmqVtYgfVnnNkweJDDJyloKYHEcoyUVM3Rfcexqdq
         a5PF0oy0ku3wQafqt3VnhSTQYkzmO3l2LfdmexkQKQSyRxFcHpYWao+L6giSH8Nha0oR
         t4Sg==
X-Forwarded-Encrypted: i=1; AJvYcCVgEIUMmO+PRHIoDYaTMP5O7CfE5bgTl0NRjtJaSQoeZ6SBpYd572Yelrvp1Q0NsOzLJtR7BAEXIhn/M2NfBB6Q4vm9B0IX7EnF2ZT/hyep57hzF6af5A4bTUhQ+76gctp6LGUS
X-Gm-Message-State: AOJu0Yy0wSo3rO/mvgPcqHlXBf3pesnok7FTxJFJpWiK1FFkRID+sF6T
	gujmCf3xdnP5C/9G0tgmIAi0csO5Atel2k2+SjNROhwRxBpEhxl2wrgOTw==
X-Google-Smtp-Source: AGHT+IEZNY45DlLX5atGCT7NUZFz3BiwjbgcpArIED+Q9TZq29Fi//7Ul5VjM9LWMV5ado+PfzRDVw==
X-Received: by 2002:a05:6870:164b:b0:24e:8987:6f34 with SMTP id 586e51a60fabf-25842897a04mr1528609fac.3.1718329477885;
        Thu, 13 Jun 2024 18:44:37 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc925ffdsm1994881b3a.22.2024.06.13.18.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 18:44:37 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id E37D218462DE1; Fri, 14 Jun 2024 08:44:34 +0700 (WIB)
Date: Fri, 14 Jun 2024 08:44:34 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.9 000/157] 6.9.5-rc1 review
Message-ID: <ZmuggqznvQti5rq-@archie.me>
References: <20240613113227.389465891@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fBpbOS8Qy13v8RwX"
Content-Disposition: inline
In-Reply-To: <20240613113227.389465891@linuxfoundation.org>


--fBpbOS8Qy13v8RwX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 01:32:05PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.5 release.
> There are 157 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--fBpbOS8Qy13v8RwX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZmugfgAKCRD2uYlJVVFO
owDMAP4oFLWEZ5eEs6Yl479fX2vWtXOpMgM6mr73knmW4lvM7AD/V/Ws/vvbov62
a6CqQOuybYHNYr6SQVXZPktuVwr76Q4=
=Th66
-----END PGP SIGNATURE-----

--fBpbOS8Qy13v8RwX--

