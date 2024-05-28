Return-Path: <stable+bounces-47553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D39078D15B7
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 10:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DEB5282FE1
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 08:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E416F757EA;
	Tue, 28 May 2024 08:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5vZ1hc6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722FA73537;
	Tue, 28 May 2024 08:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716883301; cv=none; b=WMLCD1pRC8bygsGCGCur7mMHP3xLooqzrw6jgMhJcqh1hrXrjTmW4/RUe84b22RalL7M9ZLJwd1HdzwYHuYBjhCroXzE039fsrEgWGwhacWk942TeYu5F/MUeI73HTDcmXtP1FSS0prwq61eTbNBltSYOh6ZJvVozArztKmQZQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716883301; c=relaxed/simple;
	bh=4H9cFlulqedFws2ELO1wUMUgihOiv3ZYDtZ7xTuTPvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3lB4PFdk8eWYs9bzV+ol+Ts9T9KZXNX2YcwEV+iXI8njTE8Jp/8xLjb5yR8RyYPF6YKp65xTUvZyxdEYTTaD4VKJibR74Hob6dMa2GFomMEwgzGJdySq3uK/iZip6blNOPpjkVmO4eaMmPb7h6TIL/R3nBSnFJdHEhCUWq4kKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5vZ1hc6; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-66629f45359so451604a12.3;
        Tue, 28 May 2024 01:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716883300; x=1717488100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9A1HK7uMZTsEiYLsWkAO7fFC+9pdvWjOj3bR/6+kgQM=;
        b=H5vZ1hc6jemuykzfF0l4R2y4klo/qNzzxhTC+zwkkq4nRa+lBpiLfbRB45Aj8Sx2Jc
         c/EgEcQl2gLwVxrB8eAEUaNMwhWBuHolA/YS7C1mYmPugsAlMv2IOgWXX/8Zv1E6/LYv
         J6vRVGpini6yHnxNhRmLPdceuoChOR0ljSvVadS7w/9a9W/CUaLRxkjngzI9Fg9ilCEa
         u+rVz7hMBf3pScNZ7/EcgTRBYlBI+DmH1iYX0pgnf0H1IlIoSg0FzzGXP8KABxhLSNpv
         JU2abrSKCl86TSdh5D8So60nF8lndVQibyzJZSEzlVvV+6rD9pGPRaHkTJ9dKyAczJwD
         JvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716883300; x=1717488100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9A1HK7uMZTsEiYLsWkAO7fFC+9pdvWjOj3bR/6+kgQM=;
        b=o21lMqeiOQhVVUuTMUyUB9yE9TIIaHwWITiTkILzndbi/z+PKCzLQyhkvgvfp5Z1om
         eNxv6FcNbh3kaAkrlgnV45JRN9oCk2PHTsM3TsB79YXCeh62jZSwL3VuWAvja0IR91NE
         3lbJivF/hoaZjI3tSk5GtkGlEzNWAWhEx2KEa+TP24b80dp43ilzIyhB+2c4nZincTlB
         zgESMHh17cwT+VIzoFkKACJFVX7kKq9D65hREkUY6ju+7ufamWb1IuyVRdRZKbt7y6Mv
         ukolJBao6oJjpa4Il4OGlQ4SpdbI1ED1s6Nqr3AuJDqFGVY7VDkTgASvsRLId4PJ77pZ
         lGvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWY04L+zHXkPKxnvkxY7kw1o//zPp0RhPB789nubXOE9b5yhjg36GcPHGUbvnG2ljBS1SB6/dpaB4tJvDCmXhXHFZ3FthUlvjUUb61XlU3JCNUKM1QGOwlvnDzSzQmbW2YWpjqj
X-Gm-Message-State: AOJu0Yz2BhxQBtaBNG8q2sZQmQ282C2QPBKsrOBaiM8aZlIULe/lY09g
	avTYnkoF4k6PnqQpjsnTpCjMg6QYa70/MNQjfJ/33TC75VPkDlPe
X-Google-Smtp-Source: AGHT+IEJ6aceDOomDqURkRUNgS+9piMb9beoRjZInDw1nHavLfkOAVtKIoDkY7FT9cEeOUBTgDxyvg==
X-Received: by 2002:a05:6a21:8188:b0:1ad:1c9d:f682 with SMTP id adf61e73a8af0-1b212e3aa44mr10271937637.35.1716883299638;
        Tue, 28 May 2024 01:01:39 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fc36d22fsm5939450b3a.86.2024.05.28.01.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 01:01:38 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 78DD018479822; Tue, 28 May 2024 15:01:28 +0700 (WIB)
Date: Tue, 28 May 2024 15:01:27 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.8 000/493] 6.8.12-rc1 review
Message-ID: <ZlWPV3O9RM0-8HEs@archie.me>
References: <20240527185626.546110716@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nMrHX7joLy6h3Dw8"
Content-Disposition: inline
In-Reply-To: <20240527185626.546110716@linuxfoundation.org>


--nMrHX7joLy6h3Dw8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 08:50:02PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.12 release.
> There are 493 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--nMrHX7joLy6h3Dw8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZlWPSQAKCRD2uYlJVVFO
o2NpAQDxIa33gd6wIvlou7jNwGSyvHiyO867qMsfr8H0gZtovAEAsN3b+pJGFQTK
iPV8y8iqOYiIwHSvhaNjM7igI4SssQI=
=AK79
-----END PGP SIGNATURE-----

--nMrHX7joLy6h3Dw8--

