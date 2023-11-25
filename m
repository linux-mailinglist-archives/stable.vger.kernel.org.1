Return-Path: <stable+bounces-2583-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CC97F8ACA
	for <lists+stable@lfdr.de>; Sat, 25 Nov 2023 13:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D680D28173C
	for <lists+stable@lfdr.de>; Sat, 25 Nov 2023 12:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CC510A14;
	Sat, 25 Nov 2023 12:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2hrU8id"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201B010D7;
	Sat, 25 Nov 2023 04:34:16 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cfaaa79766so9020655ad.3;
        Sat, 25 Nov 2023 04:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700915655; x=1701520455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=07knrX4pVFE0iOcmmvEQbY06HxioBNIgSOZlMbJ9JQM=;
        b=O2hrU8idQd1JULRvXlc9X3LdflbrqHC55eFNrJy9a14MzcUOGG70vrsDcz72216sx/
         f3snZ/fxvlFN63dOwgVouXgGAsoIMiXhJn0265nsVYMC2CreP/hGyuqJI3+PBlfrGeVE
         fTsUgimBx3phoCguIwxPGinNrxnlcpQQD8kOsJfwKlnN0ToSyWZELDbYrpmAN/8rmV+U
         IfEy1Igee6F9MjE9LH4OVMixbAPt4CLWuDSMKgdqQ3FbxR2/KcUWZ7vrmDBHh2t6MruU
         BeRXdGxY62e71YBX2fMldaUStTitQi6GGf1sGGrLi2uxZ/NF2DVUBJhxjNnmpqsO1t7u
         mWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700915655; x=1701520455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07knrX4pVFE0iOcmmvEQbY06HxioBNIgSOZlMbJ9JQM=;
        b=gmgM59dpnKDcc3pLFV+rsB/v9WdMoDWGFxUUPAdZHOGA+59Hv14owZrlsKLFmvvA4W
         H/1NpqfiDaCAAc/hhX05ETtyYDPLIRqYmLVcfnKjpOp6NKEgOmm2gjAV8kTC/8ilYYW3
         x6Ncytui6/+xizYqPPDW1hoqLwO4eajEEsrd63EKmzh8IMV8/zlnbixgYCPFGC/R/Ql4
         li/pzBZ6cIUdFUdBY4pOScWKFCxSLELhUUxA1ZdbVx45gLsmkN6yev/O39P2INmBiLwV
         Rz6ioBMA9KR1BgaztXVwOvvFJkElRzO92FbnuQl19aqwLLLOAAK3/S36WHt12kBzg1xK
         7OYg==
X-Gm-Message-State: AOJu0YxTfBnIgD4aHANe3UWnoe/9q/V85Kd37sc6Lmr8vsPdK/hpjwZY
	1JdwdLrKWSY+Tt8lGPsR+iE=
X-Google-Smtp-Source: AGHT+IFSYXWSODIoCE4XcmiZvqVb1mjna/JEsLe922nb/2SDAE+e19R3bI850BIxAfSpI9cV9TV4QQ==
X-Received: by 2002:a17:902:e887:b0:1cf:689e:5811 with SMTP id w7-20020a170902e88700b001cf689e5811mr7873263plg.18.1700915655399;
        Sat, 25 Nov 2023 04:34:15 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id h19-20020a170902f7d300b001ca4cc783b6sm4826080plw.36.2023.11.25.04.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 04:34:13 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id CDD1410205C47; Sat, 25 Nov 2023 19:34:10 +0700 (WIB)
Date: Sat, 25 Nov 2023 19:34:10 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.6 000/530] 6.6.3-rc1 review
Message-ID: <ZWHpwvYUQ3l1Dwv1@archie.me>
References: <20231124172028.107505484@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3UlSeso7lPb9eNYa"
Content-Disposition: inline
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>


--3UlSeso7lPb9eNYa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 05:42:46PM +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.3 release.
> There are 530 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--3UlSeso7lPb9eNYa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZWHpvgAKCRD2uYlJVVFO
o3BGAP9E4lmr3Mn5TH36iNQYs/endw9utiAxgj75ukuKNytFUAD/WROePuv9jQO2
zSPxguvXD3tmTRHDpSpdX1kSpOAgJAU=
=z1ZP
-----END PGP SIGNATURE-----

--3UlSeso7lPb9eNYa--

