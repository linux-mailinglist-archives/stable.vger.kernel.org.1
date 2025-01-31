Return-Path: <stable+bounces-111806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 701D5A23DD0
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 13:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26DE0168E86
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 12:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270021C2317;
	Fri, 31 Jan 2025 12:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="jFm3dj8r"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D691C173D;
	Fri, 31 Jan 2025 12:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738326764; cv=none; b=JfM/tEzZ2DV6+7VwPjwzeSO8paFk6FZ/alve42O4q9VHJcRYhj0lMQFSj3cgUGbiGpSMzNQUWXEK3vC8FbFIJU/NVSG9T8L6tVRECd1UgoMWQg+k08D3R0S/5CEF8rRw6HOUBFe7IyF8+vfaN4KsKmPD/sjtSdV3SgbbZtpUgGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738326764; c=relaxed/simple;
	bh=gIGzR8MwypIs43ehe0ZGBgsYNZYPnTzbEi5lyxcOLk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1dipefBbPfead3QqeYhl/gdyT1GDPKnrELRQD7bVZHW69bdnsl9R/AbpFYADR84XfSOvNbxjRFz/muZwL0rz5ZezpdzAml31D4tTX0KiPrz/EtxBV6CMH1pXahn9hKb5JRlGMTUtG0HO1MMp/V4qUt3IkARi1AuwUOyYQXSluU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=jFm3dj8r; arc=none smtp.client-ip=212.227.126.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1738326760; x=1738931560; i=christian@heusel.eu;
	bh=H/WeaIDMM/Hlhi8zDV0LnE+8YereH3OqT7dcQ/IUAJs=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jFm3dj8rUvW06jEUYjxy6LyaEcjLNgL7OQrptE2HbXQAapAj21+7bztg4qoGxAlb
	 I/vy+I5DSThaZP3Hf9qqGV1KJg19n/EJxukmHFi4Ej8buTOaNpA4nGcZa6VVklsNw
	 FooTjzCF7xgKvnJgpJBMJUUrEg341TQUQBP5QL7ZCT3j686aF9B91ZR0O5vOqaqOp
	 uLpFjfPVURFcObGWGxsGmL6ttDH5hZ4wvqMCfBRJp4Ye90m+syYUhARiI8B9o8Y/e
	 q1gufGx2oXWCVq00LFhsM9+MnfCtE2XF32Ohsufhc4kWKluFKceVwAxVjJSEr+dxy
	 pdLzyW3+XgQ60Oq+Nw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([80.187.66.70]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MWAjC-1tyBxZ1yAc-00LcfS; Fri, 31 Jan 2025 13:17:55 +0100
Date: Fri, 31 Jan 2025 13:17:50 +0100
From: Christian Heusel <christian@heusel.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.13 00/25] 6.13.1-rc1 review
Message-ID: <380a5d29-13c9-4735-ba71-de2721b840c9@heusel.eu>
References: <20250130133456.914329400@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5xvjg22pvmcceoyp"
Content-Disposition: inline
In-Reply-To: <20250130133456.914329400@linuxfoundation.org>
X-Provags-ID: V03:K1:wKHUbdppmSGgLyqdQZfXjjRn4wINOmsdTUXtUenkn/iK5cfEgB1
 RiO4Ohr43F4o+Vs/gc1bDpOAm1QBNE85b89iaBk4AGcrqYYDtpdZZx2CKVg8O9+kTWGghbS
 RaVTuq9FHQAjYev/GTlE8v52lc/HnvDwOMa6VZ4ltmlaFytPxcnomXrK7fPPUW2lpXdva7s
 z3wfmTtfbpdCsex/lVdJQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:utouhk2Bb2k=;ZSJn2M7uk9J6lJKQcfebyL+GgWr
 zlkORHlBC5Z4EppIj9bHkCQLnhm5mVcjcd2x48bYPDeuku+7tTTN8XkgfEaNUJ84XkZTGvrwr
 FzhPei1omRMoB92EYnIV9JMKmqUuUnHAuKoV6DX6LVqftkdt/Y7VfzYPXTgIKi7QzabF3FNJk
 u9HHUY04rjCBbnM4Nt2Gsx3IhgvxifIF04CESreE1Vr/C6NpX8sC1S65X2kVWySpuThX329MM
 pMzQP8BEs/s32IBQou2YEuFGmCO8iFig4k80cXyjkTRJdIpSfjDbiBTuA4BCDjhDPq9TEGg3p
 eJiTvbMw/Lg8nlB3fXMU/OWHbeT8EXEngTzzyKWB4S3PyPR84JGSkYf8MbvXe+lgJ8Q2cClzA
 Izq/XLbfiRNO+fbeqLWqb0r1MBe9oh+kEJ6N9jcLOxY3khe0hFxNjC/KFvEp6o3oVwhrmyf4c
 8b7ovFHxW+bSZ+8sCl7HAopdq/7hde5nGWgCyekdlhIW3KYcVe7z+GFU9UpYjRselUbUQs6Fg
 jesnk32YX+WnR0yv64G4hmzvRjjdah3vAhBDreDUGyXcEUXwvgjrYLEi1tg+VS69YN9qsuwsF
 zwmcc9sgINPBC3xxB+5QDitgX4cGZRiGT0TgZ6Sx3w3wYoOPRxZrpI4u6TVS+uRF/w1CscALf
 DnudwzhpIspSoWZwmyszIOsGjPqu84daHpObPS/Mn290lXf0+m/unliy8kNLrXFtW3ELo6uHH
 xnxz1T6AIOzQmdUx6glanx0BSg5aKUzEeiCwQTapUhaIRA7naXMWMSuO3v6OAY/bM3sNqE94Q
 rHkx++rKFCBtQi1WASn0ilh7m6+0tep2rLFbBzXLKgrCOIV+dyiH05Gl/5eSqhb5iIDoZYCvh
 l3+DRxQkL6z8n7iZ7smYfzhzLI/8Gdar0E9cjySw5lsWdm3Y95ukwmscvqyE+P1HuA/tyNE6E
 SNS/lnEmFd/JvALHI/OIY7DZ4ztt1TmOCkILyv27A8X217NvHr58k9jh8Qzi+JDELCD3HPfAD
 lhAXE3Nt0c1UH3xdAbrchY++t0i/eqwNqpjxOCurSK1OsHE9K857gQjuOcYQNE5brOPgrLCgT
 nAqmBj5PKZ6+Y/oY4RHxCiL3fakd619X9Cdu+dmrKn3wQBW5JGH3LjXmqf1cRU2r9JpusgzKG
 x90BdQNxlkUeKv2uOBkffneoAOy/rS7Q7j32cIK1+w4OMpvAxaKxvEqihngq1dko0MPIbOeD5
 gAjWVY4pZL3o+pWewERCviqAnokinHk/Wf6O8Vp+amJfhScYmgpFoE0=


--5xvjg22pvmcceoyp
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 6.13 00/25] 6.13.1-rc1 review
MIME-Version: 1.0

On 25/01/30 02:58PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.1 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 01 Feb 2025 13:34:42 +0000.
> Anything received after that time might be too late.
>

Tested-by: Christian Heusel <christian@heusel.eu>

Tested on a ThinkPad E14 Gen 3 with a AMD Ryzen 5 5500U CPU and on the
Steam Deck (LCD variant)

--5xvjg22pvmcceoyp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmecv24ACgkQwEfU8yi1
JYWkYQ//dHVgJEr+U79JiNAyqQxTm5c+7Fu7K7A4XjP4q4NyO4gCvknr9W+05HHX
ZBF8qi1GEd3IY6s9a4ZRYfRww2K5C1ahHkXM1g2UFHB/hRM0AK1biZpx8oaxuI0w
mhjeyDgM86wCLzhVkCDMb6Pv2aDCl+fdZmv3lOhjcDcOR1J9bZPg2ocCcxo5uHVz
gCAWXgB6ETzpw6wWI5+Z4PY0WUi2t45K19qI+EW/6GuzSh9wrPRtf+gFk/pUrZP1
39AEua9wnW18KIWdaHVwuTM8WorkLG9NxfoHSyhg2lilsp5hVp8hDyUENQxaF1YS
yb2MitBmeCTEMzIMshcdSaNRgETwcinnOhYWQEoIokEThCGri9xNMKxp2jZ7sTPm
U5lF+G3m1aoVFkwPb09+AeV1JXiiF0oy0cXS5MmF7lH30UQKYg6pf2aJZcZTZMXd
o0CWRvXWPXWj+POT4H4TZgIf5nbzcp95zj4XLUR780gY4Xa633ep7uHKeaZ7csWu
p6oTyhq+U71j9LVzWa/RPWAYaEyx01BhpFoEGn53ZKYC/f1IapDw2cvKl0X/PMAS
4vdaVFqPXtMej24EtFkG6ZC49wle3l14ZhLQq/SzTyhuZ28uv8b+Dcwp/W2xpFIy
oLgQXglFAgmh1bLf7a4yY61tLL1vAf7XOgXBgleC8LChQuZYthc=
=p0Zx
-----END PGP SIGNATURE-----

--5xvjg22pvmcceoyp--

