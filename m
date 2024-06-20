Return-Path: <stable+bounces-54689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9787D90FC11
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 06:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 184DDB228B8
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 04:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8B622F1E;
	Thu, 20 Jun 2024 04:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHIm6FWq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715C41EA71;
	Thu, 20 Jun 2024 04:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718859371; cv=none; b=L31msqQjuP16uc81E4s2vBiOVNyZ/qkhhwlInUZgY4HEM4zOeebgSsiQJNduKbbdc9zIPRMBBQc2tlJrgmcOwtxm8KJ1Il8XTGW1R1xZ310mUbGR6428vMvotjyN7pfED8K6R5Dip1ac+jeju2l+dZJpzcafrLDEiAtevD4i4Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718859371; c=relaxed/simple;
	bh=rVDIQAc9vjhMOZPIPBM4LIv8Mccbp+xBGtcT29Kj1HA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0RdU4jSk6D9xdMBaBLHbWXL4dufjAPPX94RGoCGOJtCdHCG0r7KJCizHWRPz0gy+WaLOSVBdwVOAeHIBll1hx/mQc0+z5PR1ftYWWgmpg0449lbpIVKtn1bIQITdupv5GLnhi7JJCzD7MpmWv4i0MIDE898jo6xt+LIy5xTE8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHIm6FWq; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f44b45d6abso3968765ad.0;
        Wed, 19 Jun 2024 21:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718859368; x=1719464168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KAXM/BEJGp3eeIPmRiUCt+sE2+R+WUmpjHtlnzxQA6o=;
        b=LHIm6FWqDkoa1FDea7lfCnVoOXd+DR9jqwqMXeen1K2fRdXg8Cgo76dYdzZ/zAwTAL
         Zg8qZcKlq6uTzQcuI59I/50MRGupKki7tuXNoH5MZkqFSQrHDNSkS5RnS7vNnCXxtUQZ
         RIJFVY8hkMUXgjq23EFMuB2NvPegKuReOqn1ufGNTAt9wYXaf15+4frIOumytPiR79bu
         veuA8HHy2m3onbUsXj5tWwp/KPk8SUWnS3YpJgT3mJ7uZ/sDluUvGOQ6rJI1ireFp+OW
         Jtuo2C3SX9f636FMsjnWgHv+dLUzw6trwiz6lekUJfkTDMEZpE0zzkYBekU3XMcp7uOo
         IeNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718859368; x=1719464168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KAXM/BEJGp3eeIPmRiUCt+sE2+R+WUmpjHtlnzxQA6o=;
        b=RyMfB2VfQNs5rc5fP+NdAnF7SD4FhfH01dF0mArb/KInnE1IhgJu9U8Sk7jQo0FqjP
         8Bv4OZyW0JfV7AyPKdyuYmONgO5QNiglBF2OYPmXsBNEF9VdQeHr7G/kypLQb/BV75/6
         nAo3GTOQu2GETUNM65G3UzgGJHLuQPwHH9gRIkEzpaYDbIJSbAtuE53aVE0rQ66k9Frd
         UeaCdBKM+RbjYVmvu7pvQtgrLAoe4wn51BJ+Pk4nCdZRk8DJowVSlTBsxzP4mRKlKnjk
         hjYoiMEGMG0kkjzi1n2hiLX0WuS4bj9i8S2RS1+1+7LCm/ZhZLPgF03aLoDzjquYwsBh
         8Ptg==
X-Forwarded-Encrypted: i=1; AJvYcCVukE+22r4IKRxfMEcEY/XrZIHYoxnyhtGl0B+tY0KCpGpu1XM294tVmARO4bk+9HIcjaFtvVufLfY9TE5VYj2XCKTAxqpsGSj+EJ8Rt30ynyp50Px6CgnFlvRx24y+vIi8JUTd
X-Gm-Message-State: AOJu0Yy4QWB3x1nCI/GlhjWL/DPsZQ/QFRnOYBBmFx3sdsHdHVRtg6PV
	P7M/wxrl/BpltyMcOhIeYU5JIfA1nhjumGvBincDQgDlANPIflv1
X-Google-Smtp-Source: AGHT+IGL3dntDRBlrzjs5w7kuOREiPO+yFKeVR8D6K5ki/cB+QXlUmkYICKqlN4JJk97p5uqYH6xFg==
X-Received: by 2002:a17:903:120d:b0:1f8:3f13:196a with SMTP id d9443c01a7336-1f9aa44fc82mr49269515ad.45.1718859367530;
        Wed, 19 Jun 2024 21:56:07 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e55eb0sm127560575ad.18.2024.06.19.21.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 21:56:07 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id D7AA118462BA1; Thu, 20 Jun 2024 11:56:03 +0700 (WIB)
Date: Thu, 20 Jun 2024 11:56:03 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.9 000/281] 6.9.6-rc1 review
Message-ID: <ZnO2Y1AVvR6zsJET@archie.me>
References: <20240619125609.836313103@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HHnYLKCUkPdXYh/d"
Content-Disposition: inline
In-Reply-To: <20240619125609.836313103@linuxfoundation.org>


--HHnYLKCUkPdXYh/d
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 02:52:39PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.6 release.
> There are 281 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--HHnYLKCUkPdXYh/d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZnO2XwAKCRD2uYlJVVFO
o0BZAP9VnGEX2jdauijbtQv78ZO9JOEAy7J0zC4a5bSdnU1yQQD/RaTw7cwNufhh
GhUTFq1Airetl4uqBwhLZZyq1yOudQU=
=LzJt
-----END PGP SIGNATURE-----

--HHnYLKCUkPdXYh/d--

