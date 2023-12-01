Return-Path: <stable+bounces-3641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2DF800BB9
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 14:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CFBB1C20CF8
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 13:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AC72D63E;
	Fri,  1 Dec 2023 13:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="c7IR14nm"
X-Original-To: stable@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BD813E;
	Fri,  1 Dec 2023 05:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1701436943; x=1732972943;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SFiMiObX9ZGFEyE4h8oReM51+m2Od7/qLb1KYhjjjLg=;
  b=c7IR14nm6CKShldHQDU/xM2tM+cDw5OP2LZN+pd7f+wgu5hpNfoMKFto
   HZBVFXN7kbIuiTbLkpSJHhHNmhz40iUN4bbP3jQ5p87N1mhsqE7NBRu/R
   l5bkj0ng9ho8e2CgLJ6tj713nNIO4Lq2VYKacvqT6Xqg8A6ef0Mrj8gmr
   J5Aj/UxYA+/hyrW/sxXLgg98PWi05pFr7DDnMnfsXIHem8kJsDLya3B96
   dQn3h3BweFhsCagKv9BOODV+zbQrvhcZncNIs62TufYzzjeBCFwpz+/i4
   jUsd57R164hx9SkcOFCh6AlF6Z4DBl1S6uUB8Fa01DyBGkk9ZytlcCJDa
   Q==;
X-CSE-ConnectionGUID: h4Jrgyr3T9i1kHEvfFr0NQ==
X-CSE-MsgGUID: QYF4eAE9TJCZvZov9yd8ew==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="asc'?scan'208";a="179742437"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Dec 2023 06:22:22 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Dec 2023 06:22:00 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 1 Dec 2023 06:21:57 -0700
Date: Fri, 1 Dec 2023 13:21:28 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <stable@vger.kernel.org>, <patches@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <torvalds@linux-foundation.org>,
	<akpm@linux-foundation.org>, <linux@roeck-us.net>, <shuah@kernel.org>,
	<patches@kernelci.org>, <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
	<jonathanh@nvidia.com>, <f.fainelli@gmail.com>, <sudipm.mukherjee@gmail.com>,
	<srw@sladewatkins.net>, <rwarsow@gmx.de>, <conor@kernel.org>,
	<allen.lkml@gmail.com>
Subject: Re: [PATCH 6.6 000/112] 6.6.4-rc1 review
Message-ID: <20231201-prize-deck-be172f77a4bb@wendy>
References: <20231130162140.298098091@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CGVL03bvG34QNHYM"
Content-Disposition: inline
In-Reply-To: <20231130162140.298098091@linuxfoundation.org>

--CGVL03bvG34QNHYM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 04:20:47PM +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.4 release.
> There are 112 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Sat, 02 Dec 2023 16:21:18 +0000.
> Anything received after that time might be too late.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--CGVL03bvG34QNHYM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWnd2AAKCRB4tDGHoIJi
0uO2AQDgaoRRvbNVU+L0vVmYKaIMArJIz6JH3K0QDUdd7M77KwD+O2iYvcBIwEeb
zZl1lG7BTtD04V/w8ec46x9ppu093wc=
=vWEC
-----END PGP SIGNATURE-----

--CGVL03bvG34QNHYM--

