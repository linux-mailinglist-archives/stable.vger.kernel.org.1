Return-Path: <stable+bounces-2884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 844E97FB84F
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 11:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B55F61C213FF
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 10:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A8945BED;
	Tue, 28 Nov 2023 10:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="J/11Q00V"
X-Original-To: stable@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5885E19AC;
	Tue, 28 Nov 2023 02:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1701168246; x=1732704246;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N/NUrzO2PErprF82qE85GTu43xecUWk7SuyD+T42OuY=;
  b=J/11Q00VdmK0ex2atBw/laB9ZhdatHpM09VJzIUq8gU1L/T79+zEn/Jm
   aTRVDfdLpOJEhr5f9hPeqqGiv4UzvE1yW8OyE4t+XEj5Wvz5RvUK30r/7
   qw9Mbc8WcAvUwFh5vgXDn8Fx8oCU8S/2AQCkqcsXXF/dYHlwm4IWPZorA
   nq645dGlUfhxWc6rRISVFP/pYG9WfQskowXM7VnbdQ9mFRV7jkh2ULsu0
   l5FDyOkv9dQSmXhUuzr09yoOcD578dRqkK0JmP967ma/pSS/s/lIN0s6A
   2SnABtM6MWphdbTeMCUVUGYTfXTHLC3VeYmT+nTxvs2lGzgX3tYtFlBwT
   g==;
X-CSE-ConnectionGUID: JUteezYWQAu/qC0geM9gZw==
X-CSE-MsgGUID: 6vH2AyD3Tp+taL/nW+9jDA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="asc'?scan'208";a="13171676"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Nov 2023 03:44:05 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 28 Nov 2023 03:43:41 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 28 Nov 2023 03:43:38 -0700
Date: Tue, 28 Nov 2023 10:43:09 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <stable@vger.kernel.org>, <patches@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <torvalds@linux-foundation.org>,
	<akpm@linux-foundation.org>, <linux@roeck-us.net>, <shuah@kernel.org>,
	<patches@kernelci.org>, <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
	<jonathanh@nvidia.com>, <f.fainelli@gmail.com>, <sudipm.mukherjee@gmail.com>,
	<srw@sladewatkins.net>, <rwarsow@gmx.de>, <conor@kernel.org>,
	<allen.lkml@gmail.com>
Subject: Re: [PATCH 6.5 000/483] 6.5.13-rc4 review
Message-ID: <20231128-lunchbox-zigzagged-2e660e15a34b@wendy>
References: <20231126154413.975493975@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dU+rk7O5SqGQQLzG"
Content-Disposition: inline
In-Reply-To: <20231126154413.975493975@linuxfoundation.org>

--dU+rk7O5SqGQQLzG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 26, 2023 at 03:47:04PM +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.13 release.
> There are 483 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--dU+rk7O5SqGQQLzG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWXEPQAKCRB4tDGHoIJi
0hQRAQC4DLmpg3eOiK+eybGDt8psf+xUpKETkKF40NgUCNWYGwD/ah5I7Ua5uI84
GXdFM7dgTNNWgZ/Tk7zXh3N8dGBFSgs=
=wkmM
-----END PGP SIGNATURE-----

--dU+rk7O5SqGQQLzG--

