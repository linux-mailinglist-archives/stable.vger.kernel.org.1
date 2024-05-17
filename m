Return-Path: <stable+bounces-45359-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B278C80BE
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 07:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 606521F21BC4
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 05:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A1F125C7;
	Fri, 17 May 2024 05:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luFCcyoS"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072DB1170D;
	Fri, 17 May 2024 05:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715925412; cv=none; b=d4PDZmnOM1bYiarYB6vyfBlNQzZJOIU4rSp3zRWInxNKIaieNBmzeKbQaCfWpBlk/vIg4+KZwWimmADdGiEfHkA1jjbwdfNZTt2HhagRwsVm3hfqRFB+j5wiEcELzTU/8YRZHOWetqpoT+tNK1oSgFk4Akb4nfevkVakMe7QMc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715925412; c=relaxed/simple;
	bh=YmSGsQFqP2sM/tghthyHZt/WfhYPDSOmoFnURY8upkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOBb+LdY43jjRwZxq1eAy/NKOxvCSxkyliWB88FVHzo5ukgp/64i5TWl6Sou0UmUzwD3LWH34ploMntF6dVhccO3fBApRk1bgm2G1s2xCiAi1e/+zdPWrmrBNlIK32TsUEdzpVJStqR5CNzRcJY76ffrhlLWEbkOXp84inswDR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=luFCcyoS; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6f0f0494459so621530a34.0;
        Thu, 16 May 2024 22:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715925410; x=1716530210; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=esvpS+HJVmGYN9zlMcpOZlojnY2YKhtm2CtrJvMWw1A=;
        b=luFCcyoStEU1ddeMN/HUQOHnAR+qkR1zzFcIa/7HZzkK2DamRgbSuyUkVJU9E7xVzi
         W2PJeDNYuz179Th2/327tahnnmIyq39MzjgsJtGZ2+coLLpgSbVnoWZqHy9WIWv7dhzu
         x6D1kxHiKZPxlNRY0jJMggrAmctwCIFHVaN1YELNcpe+mwq4dyBLxB3iqUeSRFsdChOw
         UxlWlIvm661a0n/b+A2KDX6KoD4xi8sczofJnmnCDyqIIz9Hq7XDkcABUCSn64CzX9DQ
         oFLiGTt32q384Yw2cKRZPRwN4v4VJmXYFTxjO1T/Bhh4WPsrj85KDw6WKi8f6msKnNzW
         FdRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715925410; x=1716530210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=esvpS+HJVmGYN9zlMcpOZlojnY2YKhtm2CtrJvMWw1A=;
        b=iQt4mnLJJ0MpsxL9HUc7ofqxvCxBXzkPs9vBNcuXd2V30UWnu5sT+SwN21KjwymBCK
         sS3F8OGJ55S+XA7jq1usBL2B1zWHsJURnuMfxL95SQrjoJKXxrAMrOpRm6/Rgajs7plZ
         yJ0d69XBe8jbBRsI/S5Ne7vGC2XEwhB8o27igDb6vPBuCZmuiZbJGdk8xjIdpPqVq6mb
         27/Yz7vd0OSQc3aFo/YnYWozp6fUocqUEJ6bXix2ZYof8eNx6qB4lTVe4xPRZV2R6t2q
         2AyWNMebMLFfo8LWCmvbc5g17gLAC/BLZO4PTN5w3ccgBk1y3kFYJ7/tGwIFWvKdGQHO
         HIQw==
X-Forwarded-Encrypted: i=1; AJvYcCWRvyoEK3u5+JFV9yBE2z5BPhBOErjN+Oprrfodomch3hS25AeYwVhHxVrUxbCfi7Sx4nRAq+MYpLi5p7sgOwIann7z5IWOD41BBBZD/v1ARPZVvYtedar7JXTOiVEeaGSXkLeF
X-Gm-Message-State: AOJu0YyLXrxdgZERad+syqeQpkHdkxs/LOMSjS9r8nhrDx5lcqpOa4jQ
	ke/OokBFeiEVv1J/yPjdiJkxQSTy04uBFVk1QWiG40gey4olKgte
X-Google-Smtp-Source: AGHT+IFlbXgIANme5udm932an91YyNDPFM783y6kvOlmYR2NH/ClaYk8g/x1Re/kZa/8KVe23/AyEA==
X-Received: by 2002:a05:6870:d69c:b0:23b:f2d0:7b9c with SMTP id 586e51a60fabf-24172bdf92fmr23759567fac.24.1715925409923;
        Thu, 16 May 2024 22:56:49 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a66428sm14021515b3a.27.2024.05.16.22.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 22:56:49 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 40BED186F78EA; Fri, 17 May 2024 12:56:47 +0700 (WIB)
Date: Fri, 17 May 2024 12:56:47 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.8 000/339] 6.8.10-rc3 review
Message-ID: <ZkbxnwyfeIiIwLPc@archie.me>
References: <20240516121349.430565475@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="X7EahXYUI8wOp0ZB"
Content-Disposition: inline
In-Reply-To: <20240516121349.430565475@linuxfoundation.org>


--X7EahXYUI8wOp0ZB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 02:14:57PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.10 release.
> There are 339 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--X7EahXYUI8wOp0ZB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZkbxmgAKCRD2uYlJVVFO
o/VcAQDd3hve2Ri08VYkrZpn/ZcRSgAxL1uotH5DpftZbVurZAD/UB5eW+D/E9Dd
ouHI00/F+H+zVxE0pf2w6eyCg6SPzAw=
=9d5O
-----END PGP SIGNATURE-----

--X7EahXYUI8wOp0ZB--

