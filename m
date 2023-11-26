Return-Path: <stable+bounces-2663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D57B87F9087
	for <lists+stable@lfdr.de>; Sun, 26 Nov 2023 01:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43D9EB20E3C
	for <lists+stable@lfdr.de>; Sun, 26 Nov 2023 00:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5BAA59;
	Sun, 26 Nov 2023 00:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckMBdsB2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F507182;
	Sat, 25 Nov 2023 16:52:38 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cfa5840db3so13303315ad.2;
        Sat, 25 Nov 2023 16:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700959958; x=1701564758; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KKbAS2Hz5r5UYPT9wOmOu1Kao71kWGzQNplLWwlmgQU=;
        b=ckMBdsB2id3LK26Mv6+dz0EwE4Kq173WdDS2sPFuFh2Fu3R5BltksI5v65zfmV5tFS
         1L/x/TIhKSHye3p7vmUthJRDLtUgkuxAceia1NdW97Hyh2M6gC9KCOk4miUFVcsq9G3y
         Q+MG2MpMTCiiFJSuROThO7ZI3Hx7ACJdeCsBljr/m19WF4PHtSxiEmgk6vDX5yt6j+fw
         l1K9dDKSpvy7gGFgORE7P9jYiz67LGayk44PENJDAxSnPpJBlHx9cWWJwF40z0wh/1MU
         Q6M7TnTs52kd+JUgcjQXncLUbB/tC42GSULCuTBfqy5ztUpx+0uUdlLEYeR9zg5Yu1NV
         kquQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700959958; x=1701564758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKbAS2Hz5r5UYPT9wOmOu1Kao71kWGzQNplLWwlmgQU=;
        b=SWD91WWo4O0DnecE/cnzdmj0DOmy1dnjR5tNk2DFkYvRanQNjFyU8/6x5yoktiGT1p
         ZvtUjh7KhQR3xnn8GRqHZoAj6g10YqAkYSqRyfduqkx7GTj+6HIeB0Mak9B1MdtKQqvK
         phI5alhS/XpeflV4oelI1tDYkHiygvgpQ1wQQKawBwi3bQ0NuvSc80jwFX3eSAdIhTsF
         2HXX51OkCAuOZrXnJB1rRS5ssjH4jh8YzQiCKU+NRi7DMx0VVE0mPVkxtxMVUTai5t0V
         d62UqQHysBDAVCyG/2mYLgXSPm/tDkLTvf5wgq34CrWkdjpIWH3w8W3zM7tuqlLSlO0E
         8mqw==
X-Gm-Message-State: AOJu0YwJvUZvBb8wxV76sE9P8+RAZRNtB8dGGO2C8cn3FWZSTtQAgqjq
	DDKlJl+cpolLaI/Ka60fH/U=
X-Google-Smtp-Source: AGHT+IH6FyNJyJqu6BLrI29L97TNTsQiQLKSRLQqESyUex6zppGa1K4ONTCLBwy7o/MD+4fL1ghkiA==
X-Received: by 2002:a17:902:d2cd:b0:1cc:4467:a563 with SMTP id n13-20020a170902d2cd00b001cc4467a563mr10099829plc.3.1700959957964;
        Sat, 25 Nov 2023 16:52:37 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id jc11-20020a17090325cb00b001ce664c05b0sm5509447plb.33.2023.11.25.16.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 16:52:37 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 56C7F10205C41; Sun, 26 Nov 2023 07:52:35 +0700 (WIB)
Date: Sun, 26 Nov 2023 07:52:34 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/527] 6.6.3-rc3 review
Message-ID: <ZWKW0rxstUR9Qnen@archie.me>
References: <20231125194417.090791215@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YjTMKzLNLP7oLp3F"
Content-Disposition: inline
In-Reply-To: <20231125194417.090791215@linuxfoundation.org>


--YjTMKzLNLP7oLp3F
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 25, 2023 at 07:45:29PM +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.3 release.
> There are 527 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--YjTMKzLNLP7oLp3F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZWKWzwAKCRD2uYlJVVFO
o/F9AQDS2pa83YDWDhWxMzoiLWzfNPcGYt2GVvwS4pBVMs7wTAEAyYfn/Fvrxdj/
jEtZeTGhjlo+BcrcpQT+79IChb732Q4=
=zVdp
-----END PGP SIGNATURE-----

--YjTMKzLNLP7oLp3F--

