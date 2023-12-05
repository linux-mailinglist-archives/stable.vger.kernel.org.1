Return-Path: <stable+bounces-4657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5234F80511E
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 11:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 072A51F21554
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 10:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582854AF62;
	Tue,  5 Dec 2023 10:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="HQEm+H6V"
X-Original-To: stable@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A608CE;
	Tue,  5 Dec 2023 02:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1701773279; x=1733309279;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6EKUKmr83ChMD0Oh4BcIpqtIiujZ994PDO1wujmu8yA=;
  b=HQEm+H6V8wJqBIlv+CItzQjCzUUY7Zjd2BLCpBCZcJP2coT01+MfaBdZ
   2zyRL2UfifLbWUHOL69s1aKYQV3zN4mG8MHk/VFamCejeOcY/RUuKRh/p
   NHCX5/eHpOnv4Qv6nn93Z4d77kWwU7pLbDkK/TYDvUUKX4xie14ROscRb
   /QzDQafjlgvXdh0GLFjBi9avUv/b/B9vkKViQQNBl4SLXonNGjtt8cdKZ
   PVLpEEW4gR21uf6NYG4LYXXpMEXh+OnceFlt3qDj29e3N2i1r5CCQ70lc
   cGgwTSus4jbcLiOeD5rFThbbfzkzLvh4GTSUbcZ5LMZBmhAWj666QcbW/
   w==;
X-CSE-ConnectionGUID: hxs/bVEHRTK3IpCKYIjljQ==
X-CSE-MsgGUID: +OeQPf4aSmCL+lYaCxhuyQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="asc'?scan'208";a="12720840"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Dec 2023 03:47:58 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 03:47:58 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 5 Dec 2023 03:47:54 -0700
Date: Tue, 5 Dec 2023 10:47:25 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <stable@vger.kernel.org>, <patches@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <torvalds@linux-foundation.org>,
	<akpm@linux-foundation.org>, <linux@roeck-us.net>, <shuah@kernel.org>,
	<patches@kernelci.org>, <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
	<jonathanh@nvidia.com>, <f.fainelli@gmail.com>, <sudipm.mukherjee@gmail.com>,
	<srw@sladewatkins.net>, <rwarsow@gmx.de>, <conor@kernel.org>,
	<allen.lkml@gmail.com>
Subject: Re: [PATCH 6.1 000/107] 6.1.66-rc1 review
Message-ID: <20231205-parting-molecule-8ea45639321d@wendy>
References: <20231205031531.426872356@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SZCJSgyL//So0XBB"
Content-Disposition: inline
In-Reply-To: <20231205031531.426872356@linuxfoundation.org>

--SZCJSgyL//So0XBB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 05, 2023 at 12:15:35PM +0900, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.66 release.
> There are 107 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

The perf patch I pointed out breaks the build in all my configs on
riscv.

--SZCJSgyL//So0XBB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZW7/vQAKCRB4tDGHoIJi
0jafAQDzGHXfjwwZGGKQcFr6zIaPDvQPF4IfDQarNJSh35vqUQEA1v7jKDvrH5Jf
tntF7B9KKvwSKxSKjZWKQMi7p++fIw0=
=X0MD
-----END PGP SIGNATURE-----

--SZCJSgyL//So0XBB--

