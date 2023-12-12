Return-Path: <stable+bounces-6451-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EE280EE42
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 15:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D216B20D29
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 14:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6973173161;
	Tue, 12 Dec 2023 14:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="eIsX7IZT"
X-Original-To: stable@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EE6F2;
	Tue, 12 Dec 2023 06:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1702389713; x=1733925713;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5Sch1+xZFZH+/46UFQMxNowHUTXirXXiuk9gfutBcuM=;
  b=eIsX7IZTW6X82WXR7jKqagcOKCTREqbnCWPaUx95GHMpW0+D5bYMrvIB
   +/16v7GBAjUx5sJOlSdcNZlblf2rZKfsdPgD0kmpZKwXZZNQZex4Bf6ua
   rc3G0DhNoiQtAeH8yJpwpYhRfLjv5BnwMr96g+YWFZrYglT0JFX+0VSjP
   UaqDpg6XKTLf7DT7AKVuP8qiEqYCtaE84iOi0A1fT9Ij9pv1UScTAV/rF
   nLk0Rxj+Gx5KX2M2XK+KCOfYYwrS7JqaMFCUUlNM9hZEffhFj3OrLoju1
   CrIgoEFfqf9NHhNjd/C0rK/QHfAk0iFrpjxpDD5eueiJx+OwUdi9fcfyg
   w==;
X-CSE-ConnectionGUID: 8VfsQLqlRTyqn9Kjsjn4JA==
X-CSE-MsgGUID: wYsykXDaTEWPeQYHAl7Eyg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="asc'?scan'208";a="13531071"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Dec 2023 07:01:51 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 07:01:32 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Dec 2023 07:01:28 -0700
Date: Tue, 12 Dec 2023 14:00:58 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <stable@vger.kernel.org>, <patches@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <torvalds@linux-foundation.org>,
	<akpm@linux-foundation.org>, <linux@roeck-us.net>, <shuah@kernel.org>,
	<patches@kernelci.org>, <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
	<jonathanh@nvidia.com>, <f.fainelli@gmail.com>, <sudipm.mukherjee@gmail.com>,
	<srw@sladewatkins.net>, <rwarsow@gmx.de>, <conor@kernel.org>,
	<allen.lkml@gmail.com>
Subject: Re: [PATCH 6.6 000/244] 6.6.7-rc1 review
Message-ID: <20231212-lethargy-last-70cdfd90c42b@wendy>
References: <20231211182045.784881756@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RilTn9pzIrQ6W0pA"
Content-Disposition: inline
In-Reply-To: <20231211182045.784881756@linuxfoundation.org>

--RilTn9pzIrQ6W0pA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 11, 2023 at 07:18:13PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.7 release.
> There are 244 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--RilTn9pzIrQ6W0pA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXhnmgAKCRB4tDGHoIJi
0trXAP9pqI9+EuC2H/516x3d187LoWpkrg+Mk67rd1E24CRIsAEA5F5PutbXtfFS
RYZM4ugyl6tdFYfZcY1yKa3LZt/bhgg=
=A4oC
-----END PGP SIGNATURE-----

--RilTn9pzIrQ6W0pA--

