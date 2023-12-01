Return-Path: <stable+bounces-3624-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4584800943
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 12:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5023DB20D14
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 11:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EF520B3E;
	Fri,  1 Dec 2023 11:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="oqFzbjX6"
X-Original-To: stable@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B443193;
	Fri,  1 Dec 2023 03:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1701428554; x=1732964554;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uYe92/+q2AsWj/XJIkpJZ54l5IPYR4MCNkD/UZeYmWw=;
  b=oqFzbjX6ULFXxdtehK7LoplXP+ipsXImo9MXSZtPAqUDcHmFmSeWzcMZ
   tIzNaR2CZ/tl/SABnEB0FMVLvy7co8kK0jtm2ufkUYB+d+djoTyRBl0RZ
   HQmTIaq90SdPl4Aa+4rmwPPFqskcc2q6fztpbUosjY6EQep+2/D60Bpc4
   d3019WgKpJ+i4JNk+QR1HN7FwoisPHg9xWZaz8GvS2yu48f8rbwL/Nv3s
   AY5v3gYM6JKyOJLrFbj4nweumcQCmJ6V4bUYfDKmkrXOlhgAoUxpo1SL1
   J6/mGHfIpsDKyimfsoSMzXWsYOcA0akOzTUJhkEoxHwQK9qrVHcSK7Hn0
   Q==;
X-CSE-ConnectionGUID: 1g/+sIhlTqCL1F9uWMaPeg==
X-CSE-MsgGUID: 1gQ5qdcPRny2WPun9EQ0Lw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="asc'?scan'208";a="12533231"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Dec 2023 04:02:32 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Dec 2023 04:02:03 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 1 Dec 2023 04:02:00 -0700
Date: Fri, 1 Dec 2023 11:01:31 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <stable@vger.kernel.org>, <patches@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <torvalds@linux-foundation.org>,
	<akpm@linux-foundation.org>, <linux@roeck-us.net>, <shuah@kernel.org>,
	<patches@kernelci.org>, <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
	<jonathanh@nvidia.com>, <f.fainelli@gmail.com>, <sudipm.mukherjee@gmail.com>,
	<srw@sladewatkins.net>, <rwarsow@gmx.de>, <conor@kernel.org>,
	<allen.lkml@gmail.com>
Subject: Re: [PATCH 6.1 00/82] 6.1.65-rc1 review
Message-ID: <20231201-manicure-annuity-c6f29c460878@wendy>
References: <20231130162135.977485944@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Y1RXsZqWw4Nlr+rB"
Content-Disposition: inline
In-Reply-To: <20231130162135.977485944@linuxfoundation.org>

--Y1RXsZqWw4Nlr+rB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 04:21:31PM +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.65 release.
> There are 82 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Sat, 02 Dec 2023 16:21:18 +0000.
> Anything received after that time might be too late.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--Y1RXsZqWw4Nlr+rB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWm9CwAKCRB4tDGHoIJi
0ucOAQCTmquaS9c+i69BPOHYxNf+7mGEk40LGA2D6UAabLaK9wD8D8D6SRHMaJZD
79QUsKox/3k+n55zZc7BJV15C4Ielg0=
=Srho
-----END PGP SIGNATURE-----

--Y1RXsZqWw4Nlr+rB--

