Return-Path: <stable+bounces-45356-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 365398C802C
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 05:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B6E61C213DA
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 03:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B6CB661;
	Fri, 17 May 2024 03:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XppLBvsy"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A58F9470;
	Fri, 17 May 2024 03:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715916484; cv=none; b=qsSe7nPBfgASfLrjk6z5eWtAJgLtUF7dDDBFHDabkeMnDIjYQJWD7bu0VD3uamYD7j+v56+oNcUfRLsYVz2eJznGpMlPjU+7y0prDCIQrIr4wjPf4h8kMC6RZCUIg1hdVHE7DvNUP1pX+mG1vdEnTPbxRFQdBzbffH0ivbm+cvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715916484; c=relaxed/simple;
	bh=2YlnU3dK1FoVSD9j1pKO2Ij73DNUAm/lDhMdu3e0DA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oN3cTp2UTcTM6N0DJ9bWVHRaY1N7IYFCASqufMBKNyKW64rsu8Mwo6vA108rfO7Y2cKCd7T4EjM2+2QtZ/iQ2lIV+jzYAFuyYsj7IbLQEUpUTdtuEhUwaNa3KKRcerLWyB96JMGL6JmYEqX4Vdkb65Yky6MHEQwD/AWLSsHTk+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XppLBvsy; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5b277e17e15so656284eaf.2;
        Thu, 16 May 2024 20:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715916481; x=1716521281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9fW8G/HvOS2fwoglBUvP9d7Wl+Tt937qFLudcraoP34=;
        b=XppLBvsy/MFFGCbpMuexgvbK21WC2nSroubzAEAnhLT4GmVnt26K8JefQ3K65cE11c
         JKvXwGtUPKvxulyKCcxXp9dticGNh4IK8ixv31Fng4TLn/VBnffhXsFZUJHSXseNoz/J
         TKBS8XMJQqiFTttGF9kti+CyQKjc34x/JYr4ghpgM5jthOSQhcbrYMpHitYmv6167Iy6
         go17oYGXdgrsHZYd8L8yMkxbs6/wkXcYccKifXY/oYLkvhx6DKn4qFFsKpCi+XAML+zi
         DRsg73E8AVC5jP/ehM0j90sIqEe9K2+NbGlunqaFg/a1NsH2I1YiIo452ri7fKfftu25
         OPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715916481; x=1716521281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fW8G/HvOS2fwoglBUvP9d7Wl+Tt937qFLudcraoP34=;
        b=hL42R7XRF8tqjA87y0rvMZVYEOI4HXcBuC5zHrt9sQRCKMm0aclXmB+XGh+IefXJu3
         xopuM8rtYtKtksCU/mmQnJpLveOA+WN41fH0jd/09+oMZLB0WmuwPJNcvhrokAl5zWGd
         j3HDPfpXuP9Zq0GPLEOfwblRhteXMqVsEVE20D1UV+zwWjxRrR7K1F9QQo9v6WENApwv
         2GAciDMVaJYscULUJaxiBqXJiTopBsKZXNAUbU7n4avlTqnVLgfIDSRwqsPwFqBh53h9
         RMNcDNzPANuvY2uy78PQab/Lk2TCpNO5KHhzT2TNU0NB35YEDwIxcqZlNvz46mFz+8TS
         hdLw==
X-Forwarded-Encrypted: i=1; AJvYcCVki0VAhR1GL4Hy2Jcegs4NS4NE1wcRH2reTHCaWlRkNvOjO7YUzoLthSVMTNPw0vlKHTyU3c8qs1mECvBVUKs+HO3GgZ1ZQnQROiXeqI80yC7umcZbae2ofc+DIvosyi4DK1ui
X-Gm-Message-State: AOJu0YxhK2Izp1dCHZoQ1odtCm0U5NRw3BfUbCMeDPdvwtM06B1PxW86
	B7jgmDLU7lliKamPUCwu8cSKT/eAXLC4snddO2RM3ZYECRZiGcml
X-Google-Smtp-Source: AGHT+IE00rADhK/l9n4od3Czggi3pFMm0JtiMdobVn8lr4Yb3oqDI8w/95tuuhXs2VHoz0x6KKlLvg==
X-Received: by 2002:a05:6359:4c9c:b0:194:8d2c:12a5 with SMTP id e5c5f4694b2df-1948d2c1ac0mr770608255d.31.1715916481045;
        Thu, 16 May 2024 20:28:01 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-634103f80absm14019096a12.65.2024.05.16.20.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 20:28:00 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 685BE187061DD; Fri, 17 May 2024 10:27:57 +0700 (WIB)
Date: Fri, 17 May 2024 10:27:57 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.8 000/340] 6.8.10-rc2 review
Message-ID: <ZkbOvSPM1ZHn1gZp@archie.me>
References: <20240515082517.910544858@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0IExNrFIihGLwV6u"
Content-Disposition: inline
In-Reply-To: <20240515082517.910544858@linuxfoundation.org>


--0IExNrFIihGLwV6u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 10:27:21AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.10 release.
> There are 340 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--0IExNrFIihGLwV6u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZkbOuAAKCRD2uYlJVVFO
o9p1AP4rhcrTfezKg0poR9HjvP+a1jf/DYeoQCc027IA1qtW/wD/eVY7RHrQo9ri
bdRLN1HPs4bT14VpsGJGnuhcJp20gwo=
=koyS
-----END PGP SIGNATURE-----

--0IExNrFIihGLwV6u--

