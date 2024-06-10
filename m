Return-Path: <stable+bounces-50062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B0690193C
	for <lists+stable@lfdr.de>; Mon, 10 Jun 2024 03:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A7E41F21A19
	for <lists+stable@lfdr.de>; Mon, 10 Jun 2024 01:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43801879;
	Mon, 10 Jun 2024 01:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iinQ1gYP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750DA17C2;
	Mon, 10 Jun 2024 01:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717982894; cv=none; b=jUEZUKdeYx4ADPlzdQ2pTDLz2Iq19Hx/ECJllcajN4IkxnEhuDUZpxLAde2QtjlnEz1aqble2Mm5icunLz5Ivi5Uy8oQV8vt09/gz1UH4PpFrXgT04W7RS228+/GBZseRCEhCbFbUlUN/xzMZbXjwKMXDu3oJDMia/IpQuGRwhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717982894; c=relaxed/simple;
	bh=jDFwegCSWuUb75W10N3HVQWRCXQBrTGSItHT892scmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lgjnw3HNjO8hhNBJmxNF6b9MrypUC0DTjQQwM7E+PKx8n5lYU8Gmz0ZQpsAWVWQnvP02ZESt41h9n8ieFy76mhYz90eIb0jBY/wkjvlSMJyUSYqKL1KUs//i97sLq7YOkKxx+k6G+Y/FOOGttNpqL3+2h8s6JeJABimhM+CReG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iinQ1gYP; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-681bc7f50d0so3304512a12.0;
        Sun, 09 Jun 2024 18:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717982893; x=1718587693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ogGDeikgVtP2/JojZOHyH+g7X1ICvG0a8hd8lBtiypU=;
        b=iinQ1gYPmF3544rayN9OYS3GTQj00kXqEW1/9YiVqLEvN5RpPTpnjel7+vslkxKDcK
         t9mLTlGshv1DBpRpM1cBEAsFCzI9l7vSS2TP1fEeZ/auGV6koJ67qeuO/PZPcbOcUlGA
         b44miov4071ocNIFYdnhL6/va2qSdndSBL/CzU4eWDWNbzYFqve6JHicRnF64aPpwonE
         mWX3C4ijkL0QSuawaDGueW7IefiRXEjJvg2HQ1e013aSyJL2+6xkIA5qbg9854peEC9Q
         N6i84/snam1E7zTpNS//eiB4Dv7Moo2hgjpjbhLfHDNz1QkHNSC/23BQCm9nZ0qDN6l4
         wYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717982893; x=1718587693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ogGDeikgVtP2/JojZOHyH+g7X1ICvG0a8hd8lBtiypU=;
        b=p3Hg09ep6WBRatQNyr/HCe9jTTIFInhvL5v6J1/Af+bJP0za5HhXysPVPOygdDhW7Y
         pSf6vBOKg3a0CxduqHhXIKl/TLrgAiR0OZpYRggVngJxVBv5jyfa2WKTUfcc+T/AYGAv
         mpGB2/4oJD0fcIyL8zhsXs/Vg0kuzMZmqs8zj1VyvnBGljWC9cj5Z5Fc8e9a+muiglks
         l+kfNykhTeHxUWWuq51OQf9QRaJTgAk+7lc2d2lidFRr4Tpbt7IAXd1COBDpDuq0DnOL
         RUrWq3cKTHdqu5Hz4YxMYSDpJLckQrRi7IfwH3ZLEfGUdfoi3bvj+afbOMsMCjs6VGGR
         p1+w==
X-Forwarded-Encrypted: i=1; AJvYcCWvMiylTksWtGmn6PQaPtJvhxP8YH849erHCmI1og7Jn/ufd+CZpuT0d6h7V5c19d8Sj6c73zH5jijsmVvMkP8Jp+akHSml1gH+H0SPr0+hLMGN/HugYzOXAlObrTclP9p4kcHD
X-Gm-Message-State: AOJu0YyBDswVLmyre3W2lvMPP7N/Clso+HpNye8NwiDijRyFdbFJUEpf
	2C3VIADzbqfXbC0+/9c2FlAViEOIq9VUyYTPn6Vsv+zrnI6fmNgOhKg6Yg==
X-Google-Smtp-Source: AGHT+IFJo7eHVjaNg2drL50B9+RvvT9/t/rU7YReGKAasPj++KS22No3SWU21pQ0mLV8XqqTCBaCqw==
X-Received: by 2002:a17:902:ccc9:b0:1f4:8a31:5a4c with SMTP id d9443c01a7336-1f6d019ef8amr117255655ad.24.1717982892523;
        Sun, 09 Jun 2024 18:28:12 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd81c9c2sm71291645ad.308.2024.06.09.18.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 18:28:11 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 30EC41846908D; Mon, 10 Jun 2024 08:28:08 +0700 (WIB)
Date: Mon, 10 Jun 2024 08:28:07 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.9 000/368] 6.9.4-rc2 review
Message-ID: <ZmZWp2YnzYmjkAsi@archie.me>
References: <20240609113803.338372290@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="W41JxYyyql6NqAfX"
Content-Disposition: inline
In-Reply-To: <20240609113803.338372290@linuxfoundation.org>


--W41JxYyyql6NqAfX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 09, 2024 at 01:41:29PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.4 release.
> There are 368 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--W41JxYyyql6NqAfX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZmZWowAKCRD2uYlJVVFO
o2lGAP0dGu+7nBNV09SeIbB9xdX9a/utxgv5ORMtcJHB0JXHZQD+KI/VDJTKPMbg
1slqhmM7JjCzxCKLUSgL/r7C3WSmNwk=
=D0Gy
-----END PGP SIGNATURE-----

--W41JxYyyql6NqAfX--

