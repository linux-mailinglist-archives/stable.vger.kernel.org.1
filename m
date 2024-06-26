Return-Path: <stable+bounces-55817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E58F0917630
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 04:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05EBE1C22375
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 02:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B7221A0B;
	Wed, 26 Jun 2024 02:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWYVgdPW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05E21BC44;
	Wed, 26 Jun 2024 02:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719369302; cv=none; b=pUlttXYaOn+cDyA8DLYelh1P6d253+XjAf2v5YdbHTGkqf/jkMpLDUqrIOdXSJVDnUyhhx2R1CXVZxW2NtpxzffSF4itu0THou8a9T/rLkIOjol5diyBgz8VRss6QY164ONpQ4nvLYKs7r1mKOZHh5L1I4PSl3jHZhuSWdBWDKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719369302; c=relaxed/simple;
	bh=4Vjb2tHyAUUYGbzlCwqawkkir3yBKn8Rbhng8N62OCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqFpqwXxvR3EQZA4yeaHI4/7SwH/MPzz7Zy0kSyNzhdGTq55ZpISck+rUsDGsh1DJFHwUuRtd5t0FyI6kJw3Owo0c12NNumCm4h88xFMvYeTUm44/CSDEUnuj+fXevrr2t9S74dehcZJ1lOPcTFzHqWs3r6ZFFQhygSxW/lNMyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aWYVgdPW; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-6c53a315c6eso4314585a12.3;
        Tue, 25 Jun 2024 19:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719369300; x=1719974100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7ZWF9nN2QXFvBke0Huzd6wFb2kCuu+RIdg7vyQmFklI=;
        b=aWYVgdPW/as4BRWhdolwNOBXIigWv8ShsnDHWVNJrfWovVwTEcNWuD8UmGDL2q4uhZ
         NYePUrRSn1Ff3dnN8LmJL02sbNQ2kjt6GF8WqFh4eOTyOShZw5IpV13YapZ8WdJqeqDv
         QxKQWUUMhjcaSq2+QeEsgVLu+f1JZB2GClRSWnWmrW4dGn4GnZFX3evP2IJJpIV7FmuM
         BN/Z8qfPUgEccoh7gq2ro9YTvWRigkwv69Esn5mXdQH1xJwG4A4dgvMdEnjBjOtWYwVw
         tLPsjM6Sl2mD+umOoFBwX0/tf9YdNVMg8HDUF9zIBtxTuok3Q6ix6DfBOnNnw5YpdUfq
         4CYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719369300; x=1719974100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZWF9nN2QXFvBke0Huzd6wFb2kCuu+RIdg7vyQmFklI=;
        b=reTq+3kmmRzBV+kQOg/f5iC+XvbV/+g5X4OkoTaIxxoLCohdiD3JxEZdr0S+aUXIk5
         SvXzTqRjk/PWvQ5Pg4gaT33mLY47CXDtVAi3waE6HcdO/TMO6aveyGypU5y75+AONkMp
         xxQXQl4OcujqDfIdxfbl2aSFOcll6uBdZPg+ueWzQiPi3cGM/+UgCTH/2R7T2c/ypoXu
         O+rysDeKvzLh1BoI/lYUbgRqiSoJQ/7Z33FGv0/3U6m5T5t/aRIyvCVO/OTMvVDJrPDt
         vlZUzJoWyvpJ1ih4YpKiZ8F4EB/9t/c+eqsdzBn3DSbsdyrZTw5d8IUaKf6rTRYvRTJy
         /oHw==
X-Forwarded-Encrypted: i=1; AJvYcCWA9uuEpoe/zdh26YhdVlHCEPabWPY5ZOWX8347CN6wiIQUqXLP7OfBms9lp0ULtj/K0cpPgSxYeJ2yXymlPxnZahBUvYfiuMivP9lFLHhwb6Szsw12WqFzkLivE8TJN5w/PRBx
X-Gm-Message-State: AOJu0Yz3YLD2r2xVvlOCEyxOWNJPnj5YXnFatwlMrH/CBayJumD7WmvQ
	1l1FwwpZB8D28yTUsWQW5Ty7OLsq4mTVp6rRVQ8+mVErQPH9qSt9
X-Google-Smtp-Source: AGHT+IE5bYlswtKZymD8Gik2xErljLWxchhQv4CRUjhtZluoHqQo6z6WaSKQDizibqrINp0ODzbR8w==
X-Received: by 2002:a17:90b:3ec3:b0:2c2:d163:d761 with SMTP id 98e67ed59e1d1-2c85067faa2mr7154675a91.47.1719369300032;
        Tue, 25 Jun 2024 19:35:00 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c8d8068faasm363151a91.32.2024.06.25.19.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 19:34:59 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 9ED091834CA78; Wed, 26 Jun 2024 09:34:56 +0700 (WIB)
Date: Wed, 26 Jun 2024 09:34:55 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.9 000/250] 6.9.7-rc1 review
Message-ID: <Znt-T05Wn-7ZsxE9@archie.me>
References: <20240625085548.033507125@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tFBuSGGi66cKpezs"
Content-Disposition: inline
In-Reply-To: <20240625085548.033507125@linuxfoundation.org>


--tFBuSGGi66cKpezs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 11:29:18AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.7 release.
> There are 250 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--tFBuSGGi66cKpezs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZnt+SQAKCRD2uYlJVVFO
o6j+AP4s7/0Yttqfl2YJTsh8VuBKgw3rHiyfVY2mLQDyhmFVfgEArOmPKDFEscuS
LbWXxNC55x+tpspXHdo51bwcnUrekgE=
=noIh
-----END PGP SIGNATURE-----

--tFBuSGGi66cKpezs--

