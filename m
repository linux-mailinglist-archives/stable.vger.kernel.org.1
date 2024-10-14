Return-Path: <stable+bounces-85058-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CD999D46D
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 18:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D84581F22E1F
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 16:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA221AE01B;
	Mon, 14 Oct 2024 16:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hEWCJdsg"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D690F1AB507
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 16:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728922442; cv=none; b=RAPVTjaDFU5vnUe7k2y840jrgnDM7bibStUmdjYUeNM9D2xzL84by7V3VA4ME/IyqTJavhvgkLcfKVgdbIFfXdcxO1DRa+Pg8dg2qnv29PEQuaMR3uwbpjUX3CiOAWcsNJIw/a8JihQg6vPVuBD6+hZNCKKET8JfrArhQq0W/2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728922442; c=relaxed/simple;
	bh=bPKOF9hLp1gLmish3JLHjV9xayYIgOc9dRCesRJ75gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oj2bVVhcDAQl4PMAY3P5yacbl1O9XpeHH+MXu6CGJREtVb1J05nbK7grHV7CEMs4ixRGjZe/sErz+5jvsGUEA/lotFJd/IFjaTxSFA4U5mRhY0jGGCovfqo/ku2gyw+nq2D3d5cykDKN+YbVKTLI9xNa1w5OLZTsSKUNLVzYDmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hEWCJdsg; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a99b1f43aceso624470866b.0
        for <stable@vger.kernel.org>; Mon, 14 Oct 2024 09:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728922438; x=1729527238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bPKOF9hLp1gLmish3JLHjV9xayYIgOc9dRCesRJ75gw=;
        b=hEWCJdsgZ3T9dNYjNVdVp+vbg429E9OaIER2h6MjYwo8CTs5CDTDoKGVPyQIieQbFN
         5wnseuG/rYl/gIwzwcVyXWxoeADFIKXUqTLt4t1kKgl5y0tx6fu6kn3X6N/J60mziFDF
         oq8OW0/Oz662DCilomFWBkY0ys+42+Qvwz8fLHAnZhTOVNB4rnO0ibhRrEYQF1OPaCGD
         CrZOXbCehQuXceJwZNbz8hteSapOXPOhVKRCHKrdybz+ghlMUC08jcy3yFt7jd8NxFit
         1gT8Ii6u32xs0zwpWm0mb6rqZX1Xe4pyT6zxjerCk0QuEQk544W8J9fe+Zvdz/8kbRA4
         lCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728922438; x=1729527238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPKOF9hLp1gLmish3JLHjV9xayYIgOc9dRCesRJ75gw=;
        b=wPsBLTj9Ies5x6Dk0ihUvNIFJTqLat5mFtwRkFWmIZrHxMVEeTxKO1/gODAUaCECMA
         6s+41qUN/qtT9/jolWUoS1sBtn4LcRt3xw8lUFHpkKbehzhkN2vL6etSE0VyeSMo57ax
         z6i5JQvWgJERD5C9XktcXcJ3EvH+N3oCgUFzpac1f2ZFFsac+ICJiM8lhoSL1TOyRVM/
         JQYTapcyTANgR7HT6naCBkyVjfnTJft+j1Y0HJETf6pubFsjOo26qGYGoIQeubQPWD/8
         qh7koJU0jL/XNca17lBBmn6kRFTOnHgr5FbzXcIDlo3H06+FVdU5HeEOfmX+sIlhH9+O
         y98g==
X-Forwarded-Encrypted: i=1; AJvYcCW4IiBm8WEG2k26UTcGT6M7mOIIeyvAAGJmkm9qRtvxIgDhyaRodWqHAyQtH7m0XIZgVPy8LkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwmpB375z5RTBLvN80Wcr0YuLm7R9stY7jh9tysH9zg/fT5hdI
	AZ7qxCl2H67uHpp1hKG5GSrwpcLTvGZyeDdLfqPh38aREw2dXiguvVRrDdGSZl4=
X-Google-Smtp-Source: AGHT+IEFuTZaIGMTYsWaft98HaU5lwquKpMe/kwiufftguLSaKzTtM+rH5m2/C/7LkYKed1FDU7iJw==
X-Received: by 2002:a17:906:c114:b0:a9a:cf0:8fd4 with SMTP id a640c23a62f3a-a9a0cf09147mr410208166b.18.1728922438063;
        Mon, 14 Oct 2024 09:13:58 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83ae:c75a:6d73:cead:b69a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a06169946sm236846866b.204.2024.10.14.09.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 09:13:57 -0700 (PDT)
Date: Mon, 14 Oct 2024 18:13:56 +0200
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Santosh Shilimkar <ssantosh@kernel.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	Dhruva Gole <d-gole@ti.com>, Vishal Mahaveer <vishalm@ti.com>, srk@ti.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] usb: dwc3: core: Fix system suspend on TI AM62
 platforms
Message-ID: <fl5znng7ed2cgqmtrigra5y4e7ozorffozjxsg2ipeayzfubxd@cijl65vuutxx>
References: <20241011-am62-lpm-usb-v3-1-562d445625b5@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h4nmdfp7tndyngpt"
Content-Disposition: inline
In-Reply-To: <20241011-am62-lpm-usb-v3-1-562d445625b5@kernel.org>


--h4nmdfp7tndyngpt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 01:53:24PM GMT, Roger Quadros wrote:
> Since commit 6d735722063a ("usb: dwc3: core: Prevent phy suspend during i=
nit"),
> system suspend is broken on AM62 TI platforms.
>=20
> Before that commit, both DWC3_GUSB3PIPECTL_SUSPHY and DWC3_GUSB2PHYCFG_SU=
SPHY
> bits (hence forth called 2 SUSPHY bits) were being set during core
> initialization and even during core re-initialization after a system
> suspend/resume.
>=20
> These bits are required to be set for system suspend/resume to work corre=
ctly
> on AM62 platforms.
>=20
> Since that commit, the 2 SUSPHY bits are not set for DEVICE/OTG mode if g=
adget
> driver is not loaded and started.
> For Host mode, the 2 SUSPHY bits are set before the first system suspend =
but
> get cleared at system resume during core re-init and are never set again.
>=20
> This patch resovles these two issues by ensuring the 2 SUSPHY bits are set
> before system suspend and restored to the original state during system re=
sume.
>=20
> Cc: stable@vger.kernel.org # v6.9+
> Fixes: 6d735722063a ("usb: dwc3: core: Prevent phy suspend during init")
> Link: https://lore.kernel.org/all/1519dbe7-73b6-4afc-bfe3-23f4f75d772f@ke=
rnel.org/
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

Tested-by: Markus Schneider-Pargmann <msp@baylibre.com>

Thanks for fixing!

Best
Markus

--h4nmdfp7tndyngpt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd8KHufh7XoFiu4kEkjLTi1BWuPwUCZw1DPQAKCRAkjLTi1BWu
P/92AP9J1CFYQTr245Jv5ZxCyp/AAlTLgGGRp3SBiliOMn2cvAEA+vFrFVBosl4v
mTio+KqIdSttNo+JNteWPelEI0uGpQM=
=FbId
-----END PGP SIGNATURE-----

--h4nmdfp7tndyngpt--

