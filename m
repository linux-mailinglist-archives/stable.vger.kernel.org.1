Return-Path: <stable+bounces-46028-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C8A8CE059
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 06:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF4E91C20BE5
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 04:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD39376E4;
	Fri, 24 May 2024 04:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4Es1mm4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5AF1EB21;
	Fri, 24 May 2024 04:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716524610; cv=none; b=HkXDDLVpfOM98W6aCUmv7A3A1Ug1oOT/V0yJc2f//vzNEDEzseZqtHkBtRO3Axcq0vfTkXBiHAtZMz5rm9rCNwsKJS8X3qtZl1w7vboVQIz8sGGT/zpPb4E8PuW6D9McszXHCef1HEopdfRqXd3P54SVS0u93NczSjYxjchKdSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716524610; c=relaxed/simple;
	bh=2LfolRYLLxKA0vNdufyOzsa+bWHaW30aM8s0d31YeWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=en6v01cMosezS4JbCviuV54MQv6+/43H4D/1y63DIJqwE3uhmtTblDQhk3rPwCMM9M7FI+h/S///TCpDnPBQg9rdFWCK+1fQMebNfYnUTkQIjFZ+s9zOYtjRU924M4tcVkFininnySwpqU45ru9KWSRiYJgxws4u+bWTnQvEALo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4Es1mm4; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2bf5baa2773so447422a91.0;
        Thu, 23 May 2024 21:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716524608; x=1717129408; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OeePSp/RgwC8Je30bbAZD6yPtJsoOz+P6dvGPXjZ8/I=;
        b=E4Es1mm4Wd6XcBt5F/5O/0Ej59vGqHcVdA2gjaATbOUKqtURy9HqeJ4a/CnWQf2VJp
         aHZZd1ggdAXmNG9nN2jXsjV/ixD288P86lqF+P8WfbCA028BcSw3J/1KLewC4PTcX+hX
         ENcuox7QzJnTg3gTrZEcIRKc3FvcuRu+zyRa2+AfG0OMOBi1XGTH8ynp5N9aSUaMlyi/
         H4s6g3TYEh5/7dUHMu2c/QRmWkhX/F9IogGM6pZFTOOKdiWI8BD6/VeZEHKavNJIthtl
         IGCy1KtriVzKQHPHbjl/HlCPCfGaIsN+2UxoMJ6/Bqi1uFJjFes8QhrS2gegmUog4uKy
         KNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716524608; x=1717129408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OeePSp/RgwC8Je30bbAZD6yPtJsoOz+P6dvGPXjZ8/I=;
        b=AfNx7U5STaEHHykut0uAw/EBNLLEPt9v+lm2zh66j24ijzvh+u1CDdaOZLjUXfpcZW
         qIRr80knZ+TLmvN3P/dP/O0rLUT21f32gR5fzWePSgIO2Z3+ooKUtekcTfTnv3g3X0/+
         IaSQaDXldykd/8eFl6UvcWNzpk5BuYhH5t87ojF1nhyBB14o/02Z8zVG4B7WxMo3hCbd
         kPYpzPTuoaUvuenzMEiQFy1jEAPRVH68C13IpkAZmkrENGbAssUl1R4/o8eetxE6usM8
         ZD9kGXzvvqMjyzqxTs25wyzNGyhPLPKdtMDs2qfplUEAp+t2QdUP+9MFbvneTscY0gL8
         0E+w==
X-Forwarded-Encrypted: i=1; AJvYcCXnNcQCbil9IqDoAlboTLMC9z7IblEJ/Am1ocL1Ry4XhMWpf6Mn/j9kgDuTrHuwH+p/Quv/TehauOkNuhqyJfr0R/PMYDZ6yhpNYaZUb5bjIhASn2vyHhMPzFsj88/0twQTupHT
X-Gm-Message-State: AOJu0YxdliUxAxWOQ1Xx8X2KvL4Dtk9s2n/qI4NF/L7Px3YSTr8vG4D7
	oWv+CAk+9IFThoxeNZdptPgV5gU4jSxZ6m2eEK6F6k0KvqQ8urRv
X-Google-Smtp-Source: AGHT+IGL6Qf/LrNMcPvOToaA6hvscgczsPZw6Uye4zSKUPm2OAeplwZ/7x7PKchhMiLbLC8a8/Tk5g==
X-Received: by 2002:a17:90a:34c9:b0:2b9:a7bf:8701 with SMTP id 98e67ed59e1d1-2bf5ef1c9c7mr1383796a91.21.1716524608227;
        Thu, 23 May 2024 21:23:28 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bf5f30aa1bsm460479a91.7.2024.05.23.21.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 21:23:27 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 8189B18305344; Fri, 24 May 2024 11:23:24 +0700 (WIB)
Date: Fri, 24 May 2024 11:23:23 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.8 00/23] 6.8.11-rc1 review
Message-ID: <ZlAWO3Z7YaD0_-aA@archie.me>
References: <20240523130329.745905823@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CTPA9SvdXJ6T5ZnG"
Content-Disposition: inline
In-Reply-To: <20240523130329.745905823@linuxfoundation.org>


--CTPA9SvdXJ6T5ZnG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 03:13:27PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.11 release.
> There are 23 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--CTPA9SvdXJ6T5ZnG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZlAWMQAKCRD2uYlJVVFO
o8VQAP0VBXeBkjyxR9vKizrdWjHQAeFmJX4ajFxSRfY4ScLLtgD8DMbEuCaDQFr8
VS9UdjMf+VYVgK16xeM6Vz0cFFF62gs=
=OANL
-----END PGP SIGNATURE-----

--CTPA9SvdXJ6T5ZnG--

