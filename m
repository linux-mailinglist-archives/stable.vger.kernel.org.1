Return-Path: <stable+bounces-160101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E85B6AF7FF8
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 20:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7AB2580B5C
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 18:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA4E2E6D1A;
	Thu,  3 Jul 2025 18:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="XebXWmeb"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87402279327;
	Thu,  3 Jul 2025 18:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751566916; cv=none; b=VTKo5ihjNsAHlZ10S8qwM3Kko/O1OiyoxzLRyGH4Ez8jLSMpbutPjpP2ZFt4yHWcWcxRIcbcCWGJuXlNf5kcJtbx5TRh7Gm0cWAX8AAWKZZ+VaEHt2EuODcPokvqxSXrY6NnRpAWzw06UIS+TUn3sQNJas+yW3w2vScZkZXEIRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751566916; c=relaxed/simple;
	bh=FhhOLMLtyQDceNm9+gbHyRjeGgsXtQe8Tb1/kHxH+LM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=db71cZS7kRIyM5AN6ev0LBgJr0AVHyVCc/FDfNaO6PqVTkw8IdB0cOiEJkgjqypN8Y29/AHbSVm1cHDbYeUf7I+a68f/g4K83eqbbSyOqDPGN/cKC7Yc3wQcfI2TGN83q1XAX0l2PchenuDILDhZ4PBvSNk7KOn3AjEi+MlqTzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=XebXWmeb; arc=none smtp.client-ip=217.72.192.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1751566863; x=1752171663; i=christian@heusel.eu;
	bh=tAuKAaTCum0yPt6lcI2S74zA5JZ+pTUwTYUWze5Xx34=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XebXWmeb7UsfBhWewH+ZC5yxyl/u5izFRnVWzcjTY1JI+KDrVW8RaFJDRZDruEsm
	 6sTIgt0qr8GspQGBWq85k5z0ve6diirUg75vQtQKvCSz3xSpEXMcPwIE5PDXTmCBu
	 LhoIl4iwjmtqMLR7rrgfHoztn7YHnwA3F1g0yu9wlSATtumGttj6sticFxwkPrK5Z
	 0SMoYP6qQeYQPH8G1L/Z4uDnE7XpmFz8cxSk+nDRgF2RyppgOVRJQdaAdMAyExTxk
	 x1fdkH5kvDoy60nzmZqQ6jtZa0XQtQi6B/SnfzZ3uU64UWjl4C4jwJKCHxfkaQxwx
	 P0rPZRvsM9dlwWJhXw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([80.187.65.235]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MQeI4-1uIUrx0EXW-00Rj1v; Thu, 03 Jul 2025 20:21:03 +0200
Date: Thu, 3 Jul 2025 20:20:59 +0200
From: Christian Heusel <christian@heusel.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.15 000/263] 6.15.5-rc1 review
Message-ID: <b7cd70ce-271b-49a6-8992-ed16d9e38cb0@heusel.eu>
References: <20250703144004.276210867@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qx6x64jksvhmxpwo"
Content-Disposition: inline
In-Reply-To: <20250703144004.276210867@linuxfoundation.org>
X-Provags-ID: V03:K1:4l3TB7DG62TWGuyCSamBdfl++LdHBPweGeqBkL2k818sVsQfwNn
 cEfgPZU5MIGlVJwu+VWEz/UPV78DU7fRRD2StExrY0Y8LJJrN7NVbXUNEniStQtSuuMigS0
 nUe/GDZVFRE/IDv3yGJAeDjiJYutz1RGM7cHcvMW+NHxqb0yofua3EYuwVwNbQ9CvuRVBLv
 V2HKoSCOgPeyE15spp5tg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yYAnX97DoNo=;7VFYY1d1Vs7kBqMeYUdIp2UKHva
 aUKM5aq/0cbmcJ0lVq4ezzqf2Nqg+Y7DiWp7juy8ams1Z9F64fqMbAwsnfu6V5vSZA038jGmm
 194W/PkxG9K/6BbXVN8Mc9w0dDfAOQaS/RlwTxMGYyD1onpgiw6/4GbY9/oonNxKrJX2ZZdpR
 NqtUtFTv5E+D+nhW7EejZzkLThHW//sAtbtPvYaFHLGD/QTfE+Xfifm019OOqkKepDUebJ51l
 qHd1I7hJUTLtvdBcUw5ZV0WVtR/zHtQbZ3ErZ0TV9Ebcdf97bF1faJMaLep65S0ANV+Z7ly9c
 vx+lBXKl9b3KKOquJiQbiPuULoPKvGFQjkiQ3qhCnn2ODxiSA4a40jY3oy43cVNLO3dZaDD7W
 HUwMvhXwgqztJGja4npGYByj79iqF7pKMAFWg+6LotG4uMqJvPVaaTR6w4yh6FarAce3GU6v8
 L2KavPtfPw9/JhGwiZn+XdimgJPTRdCPxqoLNGMBusSozKUqsuWoahNLVWuLISwti9geOH9dV
 xPqbowULrevjQG30hABrFtM1ZaysCRI5FJDgKEl8020jUM+JE96utehKkziiTp6n3XDlUCWY6
 2Z/Bjj3AkPw2Z8zuXQ3D8POBa2TddMxGsdDbPX1CthBxOhQMnin1mrCIp+d76wN/Mttos7xOj
 uz9OocP86loyPUvVWhVv3LeiEeVKawMhvcelqSzKtplTmBwttinKCJxB/xHdlJjy0Q+GrrU+P
 tBqOC70eyEJxGSwd7wHReLbYrOTuH5HMYzYzQ7hi8mxdCsHCVzGAHtQyrxJxcaqv4s/dVAcOx
 04Bq19Jth45EBMKnGeCDaL50Rw/sc4MP9kDS7QQIU/5O9PKXiKJ7KPVjEhs+PTUweoynYa81P
 rGoKNRFdJGtFvykw3AAxigy2J1xlprvMmsGfJb4JKACXra3Wcw56IsEcn48445eljj/EfB0CJ
 22QwDUv/Ola3gOe3MWuh07CIAolJlyPzImk9FimMuPt07n7wdBNyMy4s1yErGHqTu7Sz1ILdc
 IwYhztzTZ1EbpI5gHnSVUnHv/ukpizJ3bB0V7IXuAxyJz/EW9PPtzKivvfwX4bVbxPQWcdRsP
 1t9wfW6jcfQAHrQ08h4bN5TCINSZNOmY/epPOgktNlQBhqxpT/y8kojFe/A16yYJKLDXNoJ1q
 tsnedY2ofFk2XpsXcR252LU+WY6/o5YIJKR4l0nZ6wWdwYTzbSCicSKp3P+xW4PSVvP+c9bMK
 Gcc2hSdgVVZtKPYiB4PuA/wi6NFatpweYninpk7gkNCPfpsJoaK9ujZJNSmlyvC119fZsBFCY
 sQTnsm0UPvbREeB6CrfNEeJMTSc4iTNdvNqIdxf0mRnHlLV/gTXHXNbOOMYAQiaPjp09w8IBP
 H6QzudF+EN+ipmqjdVXiUSiPcI1liGGY+zNEyaLxuHwFbijjrkUMvGiWNVk0qnjCALxwzfoJW
 QECxBbwy3522+g19jynVH2TG55Nhq0s+hV23JV5f+KWze9/RvBjoEGTpUeIvYU9fdZYSiuA8t
 98NPv9mJv0ElkQFSCOFNeMj1HDcQP8Yo14ZBf7pSBX1ZRwviuLX8LNjJKIO5LZK1YMr1cZjX0
 vm3HdRGt9I=


--qx6x64jksvhmxpwo
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 6.15 000/263] 6.15.5-rc1 review
MIME-Version: 1.0

On 25/07/03 04:38PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.5 release.
> There are 263 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Sat, 05 Jul 2025 14:39:10 +0000.
> Anything received after that time might be too late.

Tested-by: Christian Heusel <christian@heusel.eu>

Tested on a ThinkPad E14 Gen 3 with a AMD Ryzen 5 5500U CPU and on a
Framework Desktop.

--qx6x64jksvhmxpwo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmhmygsACgkQwEfU8yi1
JYXb2w/+MciSSyewEhofOHBkHLxwY0PzWs2/dYmJo0oNKVxhoLRTsYzH5g+v8qH5
9yeXohqEiFuLGJpYC3AfwPE5kgByCr6hQo1jVJio5JB2eRtlNlaCu4TQqe3kaAsb
VkeCU5nwJbRowK8E/fAnnDlGd5KzJaoTxR4KZ3KDFh5mCd+QG0m0dR4Jo4LNU2TR
HCH6EIdxnf+f7DrSPdcPPSpqF9fr5n0CNFL4+xTcx7tXWmOKFl8qZnbUB5y+s5pP
K18Fwug1CIc17YTv5seCC0LmxI2Irl1bR/VE6i5zQVUJtGUPskEkzf6lEQJ6XKBx
JZExlyQVH9HFppWntIMjbq+F0r11omEp9D90q69Euunq2OCz1dhpVrwDeKg+csYm
cwjWccHXsyhPVF94+kSnWlMzwiAQw68+eu1UYZTJReDeIh47trXbgoQ6cBCf26GH
+Xf06FC/v+KZqcVVHcoPI9A8Tf/fubxpbLczDn+vqUGAGkIkSDLhUOgqAe15HpjS
zsLZChVS8uxZAk2a6MqPfSqtOSk6S08lqOJ7zQksWf86IAiF492FmgGsFBvkrJV0
ljkRi91Ez1mVLpoEBhnA7vI5bJuEiDdB3hYSi9HZ4pelc8ulU2jIiy8jn1HCKx1z
ITgFBGNTD+M7mLFXJ7roaIBBgjKhkY8GrKT4bxGdct4G4xM6YUg=
=1lYc
-----END PGP SIGNATURE-----

--qx6x64jksvhmxpwo--

