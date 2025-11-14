Return-Path: <stable+bounces-194804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 19135C5E1CC
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 17:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 70F814EF818
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 15:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9803328602;
	Fri, 14 Nov 2025 15:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0hmEfvF"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696C9326926
	for <stable@vger.kernel.org>; Fri, 14 Nov 2025 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763133129; cv=none; b=E3lt/pbEpSatBbgqNOfkDx247dBvdW+l43COZ2JFPJ0mhGSq5eGJFpcHhliZTTI0LkolmmAnt4r2CHMV9q+2n0PTYZ/15fARwBm8acigWHpU4NzW09V7Kkl7WE5H3UY1lsPPSqMxtFMl4cijBRzXw8TxCupOWRlwfRDtm4YIeCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763133129; c=relaxed/simple;
	bh=voAb5/VWXrSfyBk2pDRuVMB2qmR4O+wj6U1yYvtSv08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cW+7NaZh4W81nzKkQW5SuRPKogHqn/Aeei8A89Ukv6GZ5dx505wuaiZdkerJLdZi8OKk10JrZNvhiwrRIKQ97+8OsQ5W5nxA2hr8ydGlJEY0mwV5ghG35nDgXgMLvXL7viDtL/Rp0NX2SzBU99JHRQbE5hmOiGcmKt/tDZ2Ab84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0hmEfvF; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4774f41628bso16980805e9.0
        for <stable@vger.kernel.org>; Fri, 14 Nov 2025 07:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763133125; x=1763737925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8r5/EliQfOua7xX65iMj9ifBX816MRf+D+dek3dRiuw=;
        b=m0hmEfvFZuEOLuMKtdSUXPHAX67QYXl3plv8CznL289WbP8YkEFjNL/5x73cTTbUrf
         XqbvaK62C1C1pmKhW6Hp0ypWdjBUuRiEWeZ9FS9fbm++xS4hHt2NdgDT+KCJPvoJfvlT
         mc7klBN/rbDxmL8K3yWIWkUpgSW+ZavQgU/88Bc9h8RYLtGI8jMvma8+eKQ0qbLTZJPR
         STW9qDR0+9R4tVCpihR69RfcED4OkqR3p16SC40nF2yzsHreJ8Z170T2Sey6DSUh4PBT
         vniAaV5VZX99oMOxyMbzXEW9RD7HnYwtDffmUvspgv0R6Z5LBZbl0OnFOGIXrF6RD3I8
         gijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763133125; x=1763737925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8r5/EliQfOua7xX65iMj9ifBX816MRf+D+dek3dRiuw=;
        b=Lw6jm9i5ROTHljvFVMuEJOQxqw8u0MrJKJREJ63PpdQ+ssO5mFIqlRooQld5lhhhi4
         c/lWWxZzpaGMD+m7rPVLlt3otJoWpFIDuOC5c7xA94lymShyUM1R8BfWk3KQ51MzO7e4
         SC3OUlLkPxszfS7YWco7gJDINc1SEryazgFlq2yu7jMcW5uLI1PIZzpgr9owjJeHugkr
         J738IuJ9avNkWVTxX6FydBbEfgmvFDThcoswiYHnOODNBQ2PnBcsGLOgHZs//JdI5+lW
         sXV4q0l46I9xjrHbVTPDRqxLG696PKKBOY+LWtmhOkLS0TutKUc1iYe5vjUR6unMYqo0
         SxYw==
X-Forwarded-Encrypted: i=1; AJvYcCV8zAdqFvOR7RxcDiRGfp3ZxzbBZqd80VEstZYA3GyJj0i+7m5fO4+KXQnilQecbXVCppaUocw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLX2Xgit10P3RCvzH+aYibgMAlp2Qo9PROBz3Dw1Vd/kKfvPWy
	hCsYMv14sKidNr2jui/KnMmEinSxI8Jcd90qAKAnAA5v4zGCmaoDNi4f
X-Gm-Gg: ASbGncu2RWjFqTf2kz60f5vdIpVtFLGZX/pb2iIifeLFLmXWxtFbJwKgjSAug+YrkkF
	kpkdKqffDl5Y8mV8uZzp0NNMMPF+t/9rtQzf9Dcm5J6i+T+NmXBHk1UjsTlGEtL2EhENowjRufn
	I1g1F0tOcXgEaRMM0tMgIHncPcmXtQB5nZcU2/s9IerubU7DiivhEXbM9EvYDFXBx5q26QwfLAd
	1ZudXJDe/EAEzdJuC5w0whAUJQYBGeKDMdPtBULQYmdWfwFjMAjvaducRCzzK6ox8F5VlmaduRH
	2jXMGzs35HXxP8om+TADssyeGuFD2JzthsoOVOjoHDuQRFAQxIEKcKBBRgmd2TH3WAC7bBkuXBZ
	XGE3uuUgnNeLF/NndPXmNe1Sr8RkEyYvs/c+HHU3UO+a0w2hRHafiXIdnJQ0WQvcjxxLIGUqVbl
	3yR5prvKxcjhU2mhUzjpYTT1FaRqZkbuIjoMXRQrQoO0ePKbJe+mr2JAiTBrfhcBg=
X-Google-Smtp-Source: AGHT+IHlbOOTvrmcjU3ZGEriGOa14ojvkFk4Zj94HNl1yT+L3RpIuFB0z5aqf2JpxrCIuwwdjhRyAg==
X-Received: by 2002:a05:600c:1c23:b0:477:8b2e:aa7f with SMTP id 5b1f17b1804b1-4778fd874acmr46993815e9.5.1763133124615;
        Fri, 14 Nov 2025 07:12:04 -0800 (PST)
Received: from orome (p200300e41f274600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f27:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e43c2fsm146920545e9.6.2025.11.14.07.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 07:12:03 -0800 (PST)
Date: Fri, 14 Nov 2025 16:12:01 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Kartik Rajput <kkartik@nvidia.com>
Cc: jonathanh@nvidia.com, sdonthineni@nvidia.com, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] soc/tegra: fuse: Do not register SoC device on ACPI boot
Message-ID: <i3kz66ndhxptxz2vvgdnfqqxjop3ivaj6brdnvbihwby6sfmab@bneli45jube3>
References: <20251008111618.703516-1-kkartik@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ysn2tryu6hxuc6n6"
Content-Disposition: inline
In-Reply-To: <20251008111618.703516-1-kkartik@nvidia.com>


--ysn2tryu6hxuc6n6
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] soc/tegra: fuse: Do not register SoC device on ACPI boot
MIME-Version: 1.0

On Wed, Oct 08, 2025 at 04:46:18PM +0530, Kartik Rajput wrote:
> On Tegra platforms using ACPI, the SMCCC driver already registers the
> SoC device. This makes the registration performed by the Tegra fuse
> driver redundant.
>=20
> When booted via ACPI, skip registering the SoC device and suppress
> printing SKU information from the Tegra fuse driver, as this information
> is already provided by the SMCCC driver.
>=20
> Fixes: 972167c69080 ("soc/tegra: fuse: Add ACPI support for Tegra194 and =
Tegra234")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kartik Rajput <kkartik@nvidia.com>
> ---
>  drivers/soc/tegra/fuse/fuse-tegra.c | 2 --
>  1 file changed, 2 deletions(-)

Applied, thanks.

Thierry

--ysn2tryu6hxuc6n6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmkXRsEACgkQ3SOs138+
s6EmIg/9EKMefuMWc6CjJS4aAAyAzAicRRkohm78OqPgrMKIy8VX+gdiKMxOoP30
uBM9/Q9QB4N5cOCneHwhRqJDokJFqy9jwxVmD7s8yzI1C395cB0oxRlEhnk3um19
+J2j1CusFgC9x29xlc4IJHNFye/UOlbcNY/pRCGr0eCW/HTU1cygfWXRyY2qWSDQ
z6Dnz2ZhUpGZf0HlwU0BfiYXp0JmVaJi5Y0Q2lH1h8eiW/axJd1JCD+TrvD/tMuI
KlTmvmtkDboMzjvzHJ7iFkvW5yOnIuTEyU7+nRI9FoMsSbPIihKSeW9Z+tZWfJOM
4dJseXOEbDOgCsY8m9ueE5bdDAja7SBgWHafZKX7UDHRs3srVsVzl4sT7un7NU8V
UOYbNqikghvH5AzH2O3RBYsUVAuMrId4RPalnwR3zPyjifa7dMy2Xc7jqPaRe3c5
dl2nz3kbwwhdNk4YwQPqyORgWOXNQLrnbREFszFWczANlLwKXqewsgU2PxbcTkGR
3oCP9K3047febHqNPTkEk2ukHLqtcHnbn0TPswH4TtDDW/FcCRHvSkjl/UZeROv4
D/sviOCvplsuArAZ8mrl29bolOqWPjVCxuopIXsW8ydFvExdobwvPG5ga8jcdPNr
16e5d9yUvE46G5smdHVJuf7+5pC9gsBPu4PNTQ780/u6jDOLXio=
=dH9v
-----END PGP SIGNATURE-----

--ysn2tryu6hxuc6n6--

