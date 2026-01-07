Return-Path: <stable+bounces-206073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8EECFB830
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 01:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C6E2302D928
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 00:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AC378F4A;
	Wed,  7 Jan 2026 00:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="m750ACGR"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2658AF4FA;
	Wed,  7 Jan 2026 00:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767747144; cv=none; b=E0RYCdMiBSq+TDDLkm5Wt+NDLgwkNEzJVdieT8X4D+wNXNmrQRrs1dk3jFarWMMU3yInbzhRa7OtIhyHn8qv+eTsdw+7UcRTmIDBMUl5VbZayOLUAUH1OSdocvmSf0mAv7ME0uLpYxlkYFRCHWWj1TQGWEpThtLud19UQXD051M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767747144; c=relaxed/simple;
	bh=DJ8x18+rVbeTdWZC5rb6mndc40okBcea9rPwS6mh9vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P58BsIBIGjuIXcVt3WdluKwe9jT9an33E//UcaHyhlNcxaoTdaKw0xce6bCLTn+30kQCQqlTEDFSt5hYji7xIQGnvXWWFAYN0+zK3jH3JvS6pJkrFZSvZIMA32pA71+H/+8tCTOWOO6d2RPwvStxhbMhULUP5oqCgjQSEdfH2xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=m750ACGR; arc=none smtp.client-ip=212.227.17.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1767747113; x=1768351913; i=christian@heusel.eu;
	bh=f+eVlcAsT4+f3dANXhZgKxe5UluorPMUS8CUY3So/s8=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=m750ACGRw5WJtCNimu1WoRxiMiicLEkdj395hs9xbSxxUxuM1vUbdAUIbHFExGhu
	 kONmvQVT/gmdfdJZaWAaoVlttx53+/RdDTBVI+PjYeHm5rbLsV4oyksF+tul+YL0B
	 AUnlHj6MJLQM0bL0kO5mhWQUXPvQ5HditypKFpkBlI39mBBLQvugLolbFkpfkAteA
	 7U8MVxJGNd3c6ixYLeDfmi5pcHTEYy+YQ+NUbi/6bqDzrlMsvvxynqZ/T3eoKHNVr
	 n+AdEjiecl4667UUxjEwbFmlc5yQf2tI+jZ/Sh5Bjw9AFT1Mts6iPSarXsrwVrBoF
	 xtIGcXoIw18p0zbq+g==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([94.31.75.239]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MuUSa-1vvMex2xak-00riJa; Wed, 07 Jan 2026 01:51:53 +0100
Date: Wed, 7 Jan 2026 01:51:51 +0100
From: Christian Heusel <christian@heusel.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.18 000/312] 6.18.4-rc1 review
Message-ID: <f7ea70a5-a8ef-470a-a8c5-e8dd59b27da0@heusel.eu>
References: <20260106170547.832845344@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mu3qtd4ostqhaly4"
Content-Disposition: inline
In-Reply-To: <20260106170547.832845344@linuxfoundation.org>
X-Provags-ID: V03:K1:ndKig8m4M8Ew+C5qnt+FauN9bwinCMshLxsDvYLsvO/IFHowLwe
 SI2Izn1H24x2dJiHjxXxdHThlpgXFjjwzydehVScUrb1liM53qdMZ3nlqm4//oTO6+LmSNY
 zq6mPgSj2pvzQGwClKuQOu5lKuPyWCz6mSVtN5POUrkx33q8uQ66xutW7e4KA5eo+h9reG+
 l/Ypi96gTh+tulsuCPrQw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5ZXq2Y00YM0=;NKhrncd7nLaIOtshVy8vKzKrleK
 HSChgP0IIDKJIr11VvrrsEWHQsahmNSwGfKHbvjt7OTxxBDgUkGAwjG2+QAAFG2LaLbQ8LnC/
 NVdF5m93vIMQjVzweg7VU7s20KbfpyDfA4rMoadF5kdoGL7I2J5AXZtWK6QLqtqGLmxfJsBLY
 DDcV98P2RnfeVrX7hf8QDUFVxRaGl69QMPdPVM5Zbl/6FTr4ps4e8PiSSrGyXbd0ANV/XJEYg
 gyGvVLKkhWQNORpoQ0sTIjDdCXmhGCi9mv6K44uIKhL72rLDSxKVbcW41djL2J1IEgujcl2jB
 FGLqxqg1P6x1XfhNyJHxL5ahWpK6+qVyZCcXTHpLTVXK3gaipJSVFm6mlUoZv3GyP6K1G4LzM
 yNqtQw2LLvJN8gUaKxMhucVyfYrhPDeYKGswVSJpo8j5Etz42NJGC4O0A64pt1lMsf22PeWAT
 xN7wkjpOXoHAoXL2H65RXeJcuBMi83X5beCVv0U484W8O5cidEJXX15W9sa9ZVhQqzjnpb7b7
 JZZUVoTPoQhdYuGMXkM7OKIlamqcp4hl1RU9tMZEhQWitQ2Olk20HZFjW92iAb570wjztmF9x
 nq9AoL+kuXxvB9Q8xj4/lfDUGNNQc4RXEJ5tPgNqOF5EUBYA9MSFGev4twccB1LsicJKI3Ujf
 sXY8OY9o+FDJCtrz0e2CQB05bTMj8b1qFSADscK67ARou3SLSrLs4ZlycsJchW3+122hHn7hx
 pTi6LRLTMkM6MvLvRZXVBiOmRCruo4FfgmnLR71dETOJFPNaCCkgUgJynrxSR6sEwosSHBefs
 grwz2kthaZxbrAo2aK3Lcr/NWlWguZIg0lFEBoMifiJMtq6joUaJNB2KwNCh5ejk44sGmbtcJ
 C+uG1kF1BxeTFXHD4c9vaZ2BNm6R5OGB9BHI5bQiUbmBZMLtTweCbxObWo0IOFXKuM49TMxDJ
 1MugKHeA6EwDUYNM8v6Vu5Z/8YBtSvJ5aa1Yx2UFJZ0VBp8mmNZsnPtS1YSyj1/482Hj75s4q
 cOSARE+Rw0u50vkt9j0S7LFmzq2+Pa7F7RsY3UyeH1WZF9CF+pFX8C5goEHJ4IKTagJcBfj2R
 r0AUVbXVNYj9JHgoMxcrCWH9EtMu4qmkVux/TK+Hfx8bVB9yFwAk577nYRHBkRBXZJN06Igv/
 E008Vm5qvy+lXg6dYwhESUTGUwzkYrOMDYtkrhjcmGrK09Mha1vBoLkvF5QtiHLJruhm8CjRZ
 abdkT6K9+1v9D1J7HfAEg/BHWJOFWRu+qYCuxagkowd9drfPbTtfybsBnf0ZKcd4qnfD0iEny
 nbKkcByxF/QcSqvxiArxIol29ziz8TYdSZ/PXJJcTHRwGxdp1VCqlae0v36cOfblbEVmKJawk
 1Yd0vcXyh43ZTcBiTpwlkBZ0QWKJX6vX72eZX3cgMboEz003emi7D5IyY1RZp1a/a6uR/qsp1
 EyCcrqWWG1lzFYd+CjpujkXmhyJtprKUM9MnZJzc2KnzB4ELD4J8JS3O8Lfejtz69FT0fzYdn
 PBEd5tb+70JJ1XJ9A1cgUp61LKUL9SWW2nTVq8/bR3nj685JcXQAtgQ2bmjwFMZszPYq4dMCl
 IVBKyaV6Jz767SYlVewtcG0ubU7dVz4KcLFhuy22V2FcwoHGUcMAYIF0SSxGlRc7P93TytHY6
 0G5Kqwz/ibxPXBy9bv+YR/MukfbEXKq6AwEg+PQZOZcPXn8DfzHkmV1OEEWvIRfK+yJMj3IqN
 +0Mw5zIBCvDIS9uSAXMCVFe8PwdtkfFkqDZdovnQvEs9Xicti0KHOHZudD/bGmJH8SavlqUzA
 kuRp


--mu3qtd4ostqhaly4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 6.18 000/312] 6.18.4-rc1 review
MIME-Version: 1.0

On 26/01/06 06:01PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.4 release.
> There are 312 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Thu, 08 Jan 2026 17:04:53 +0000.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.4-=
rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git=
 linux-6.18.y
> and the diffstat can be found below.
>=20

Tested-by: Christian Heusel <christian@heusel.eu>

Tested on the following hardware:

* a Framework 13 Laptop with a Ryzen AI 5 340
* a Framework Desktop with a Ryzen AI Max 395+

--mu3qtd4ostqhaly4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmldriYACgkQwEfU8yi1
JYWYBg//ZSEqxCRbL0/by2JJlcpRP7/szCImUpUyoH1IHOqgpnsd2lGtl3GwkAps
qR0Z1zdY60f7ImphE0ZfL1qAqXTL+/cBvFryG5nlNsjhtkG5BvUwd9y7w+Uc27Yk
dVPuW32r0fjR2nOBnrI53BTTOYigBQUF0c/eyqK7UyTr7h7fD1yIUto0D6TWkRmB
wXy3Un5v7t/EyuVJq9B9r/dycZTAHVEQXcDX1Nh4WCton/tcP7PMXVT7O7hsS6xV
+A2T8yqUDmM5IDsKJD7nkNi87lSp58iyBWdMEumnUIPsxLyPrUMr4shY0Or7s5Up
ZZlxehIvwVZF4o98YYMtuc57TUQK/P123wc2BQJoZuHKNO++eGzuPbvcCpek9EGx
wwIVGLzX3lDcwXrMF6ef43OtJfdWufhw/WELeojnr0TKQ7EIp8r7lKUrwt4Kl2nH
uiTbhke3uZHqYuYKQMv+wFp9YYPyWSjzhnvXEjKm0j76Fs8GBjaEpmZ79th0v7vg
vi+VwZV5gmbQXJE81ucX2LUUOwXgI0X9aC569CCFDm3bYArHJFVQVmrNPxz//c6U
qMTo+kz3my2Pea2ERsuE4Auy2cE0cB9Uv4QAp4IWwU4xvPF29oU3I7YeUa4PispO
4fAIynqMK54lf3RS6ZjDi2FxMYW9oTVSzA2kqrJDwO5c37ZUL2k=
=MbQe
-----END PGP SIGNATURE-----

--mu3qtd4ostqhaly4--

