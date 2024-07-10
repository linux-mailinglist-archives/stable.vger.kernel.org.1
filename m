Return-Path: <stable+bounces-58961-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE30B92C8A2
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 04:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF7881C214C8
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 02:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E4C15E88;
	Wed, 10 Jul 2024 02:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAjW5BJP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D2363A5;
	Wed, 10 Jul 2024 02:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720578985; cv=none; b=rn6ABhLsKBUFM7hYWJETezCb4Qd1UyKb6qf4GNaTvA04UzlU6xDM2ZEBe1havtfrKe/btPdcp0TM5d/miTcEi2JXZX/fl1pfP1YSEVCmz8HXm7RxAAewWkNqVouRCQKhaI1sX9PPY44kXflfPYsRFuUvvEjWSy1Zernxwz4ip9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720578985; c=relaxed/simple;
	bh=tGu8rw5vWLBsyolu3kJFWqz4hqJW9K9KWwC9yucMDSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7X+MknLJOIxQwBtFypB0FJw2QQlYSVYdnZdEVWJf6NsmGV5AP1qe84+cI1n4FtIxAPSQiZeY3Ju8yOoxzdL2prvwArrc91UGaQNpBVQZjgWPmzM24saLGd3GnIXlV1QONHomPx8ef2W5Nb/CvZkR1xD+rj9nTPZ291KM020S3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eAjW5BJP; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2c9df3eb0edso2678585a91.3;
        Tue, 09 Jul 2024 19:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720578982; x=1721183782; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E3eVF5jv0cXgwhtzNr2pMSO028nrJpif6y5JReYu+lA=;
        b=eAjW5BJP+/x6tb04Qs78EzQXWSaA+ViZcaEQHjtFLkcdwS8abu48aIYY/4Fjh2kxxR
         zCH8E29xGDV4CTPRPjEsLlJeRr64edYNjBM1tmBXuv8iXOUsE0Fuxk1piOtuX38c3v+l
         wyHNjfGtudsJQ9oGGw529hSGF8X9nRfW4pxWGgOn6BcxvmJGUidARDMmWK8hIlU60tAz
         N7MAYZURyXn6mF0L/XjbuepzdFDK5G4LuHxvrH6rilRRgietWd6zOGd3DE/2EF1iVNvS
         Hzn88v8pl7MbLvNB+5UxSIndA9xObqIgCAFtiIXUmSINfgElt6lQaQWjsKeE1Uw2rNUA
         O6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720578982; x=1721183782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3eVF5jv0cXgwhtzNr2pMSO028nrJpif6y5JReYu+lA=;
        b=KsuYaTXXDXXO1fok7UveMfYqsSBKBB/d6QaHuWtiinQ9HihZOzPkjcQxvfL+nS5vzf
         Mi7KyWFbzg7ZG76kcJIffPM9mQLxyjp4uYV6ogQAEg0XMk6/yvNmU9EBJm6w05pKiYUk
         M1nKxXislOmkwisHDBkvUaX6LcZJ36oYBWtkVWDlfEGEpu3904MxG5ASAJiqqyA4BhC0
         nbdj//PcZ3xCJAn6Q3UzzP7iG5pqStqCy6gaOdzYEsohLOb5rkY5OcIkwSO88aWWkon1
         2tVfFddD90GFik8Zkp/Fu5Muf2lOqQ/eM/HP5ZUfzDw0D74HSYGB7/nSxFeib7voEmaT
         IqAA==
X-Forwarded-Encrypted: i=1; AJvYcCVInYfnrqFlrN2yFKQZcECG7vWfp3GEAfaBDA+FbORlo656wmJRjq41tcbfcEnojggEwEfxm1yYSN7N3hzCAqM/2jH2rkxebT6eWWcBQYnzPxjkz0AH2vko4sM5xGNwjfNctrKr
X-Gm-Message-State: AOJu0YzwKMIAPRuXQz26AsL8WiVIG1jCAHZWNRov2MhsTLPyIixZ45Xk
	oMZWLlPAXXY2WCgitNFEgWjdeRzGWDPYjlM3W6lXH6VeAMi3KQMP
X-Google-Smtp-Source: AGHT+IF+Q+M86l7Qx4r0vqs78vkZcPhB/pCwYEDqZV+cSgfw6KiHKdWBc5piMJp6W/iMDhe00k4bHQ==
X-Received: by 2002:a17:90a:c595:b0:2c9:7611:e15d with SMTP id 98e67ed59e1d1-2ca35c36578mr3641145a91.20.1720578981795;
        Tue, 09 Jul 2024 19:36:21 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99aa65074sm10744798a91.39.2024.07.09.19.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 19:36:20 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id B791B184796BC; Wed, 10 Jul 2024 09:36:15 +0700 (WIB)
Date: Wed, 10 Jul 2024 09:36:15 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.9 000/197] 6.9.9-rc1 review
Message-ID: <Zo3zn6Jnb6YE4lmE@archie.me>
References: <20240709110708.903245467@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zic0MhIYsiJHXIn+"
Content-Disposition: inline
In-Reply-To: <20240709110708.903245467@linuxfoundation.org>


--zic0MhIYsiJHXIn+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 09, 2024 at 01:07:34PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.9 release.
> There are 197 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--zic0MhIYsiJHXIn+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZo3zmgAKCRD2uYlJVVFO
o+01AP4mIZ5kKbM9zklvAspFa6bsr7gp7U0T/+qaqHAhrD7v0gEAyp/AoqUHC3dT
9wZ3pJAqsLYzVT61PWU1pEQRTKYwlgI=
=4wD9
-----END PGP SIGNATURE-----

--zic0MhIYsiJHXIn+--

