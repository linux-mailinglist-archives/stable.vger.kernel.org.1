Return-Path: <stable+bounces-165516-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D1BB1615C
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 15:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 521DA564340
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 13:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E7E299A87;
	Wed, 30 Jul 2025 13:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="abB+6CaC"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3AD299923;
	Wed, 30 Jul 2025 13:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753881866; cv=none; b=fFi0Yq0hHlIW7RcQloxGOSFcgrhk1RRMn9pKqGwAWRuTw3S2fjVjosKKnm9dF+ndZhy4GpTDgBwqZ0i2ABeYeI3neva1b2uXoQl2eEhxy7dBRpg9xgHUU/FgVZpiPI4xA+guHfgtCfCixVhrjP7fKfvjuCEUpHfizMOHzp/mdw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753881866; c=relaxed/simple;
	bh=lCuqhOrWg0T3ijnvoon7IE1CXll6OeKPOnk5bcyzb00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkMMqdXeMOe5StUjhls1KsRoGY4a4xplLS/u3HX8FP8NqS/1NcT37oLJuMfOe26x6fsJMXicZZtJMAMwjO0ECGs1Q/Qvg7a15AuEedoccwZyiTnvqyRspfYEjoiUfnPpeBIwtUYs7veRc8U8GUFyZefqG+AwFc16e3LdJQwnNgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=abB+6CaC; arc=none smtp.client-ip=217.72.192.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1753881857; x=1754486657; i=christian@heusel.eu;
	bh=F+f+ZzjCVEINsWps0V76Rygvtyr7S2FjfQcZbbWPwss=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=abB+6CaCSErfOVO/Pxz4BUcMdgiZlcXou/LPhWMz4QOmXR8oS9rJ0IZjP+8vADhi
	 KoHVppgPR0kizHP5iw4ZSUF3zn1x0cDFPWKhZ9+QozN8varq/6QIiZm/7MkhUbRH3
	 kEBm8XJsHO1xOaa7MX+55zYDSy2AEU7+QyoNb2GVPFeZpQ5M1IlbDSrhrxMz8s6Ua
	 PcS9sLiRjcmaMPEhTskL3uVlR2lD42lRVp5afvConKktmZ1ZaOUIFxFqqYV1yLEVR
	 UhhpD4Q8zC+M3QiLeOiZkeqxtLyQ+xBgN8vTQ2+JHbYDJboViWRC2OpFzuohUJKi/
	 jyly3/euCgRtQUaJPg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([94.31.75.247]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M597q-1uiD1A48nc-009CYn; Wed, 30 Jul 2025 15:09:13 +0200
Date: Wed, 30 Jul 2025 15:09:10 +0200
From: Christian Heusel <christian@heusel.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.15 00/92] 6.15.9-rc1 review
Message-ID: <a200f754-82df-4a66-bd85-b0ba0c9ac345@heusel.eu>
References: <20250730093230.629234025@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qw7jpb2xcpdsmjqy"
Content-Disposition: inline
In-Reply-To: <20250730093230.629234025@linuxfoundation.org>
X-Provags-ID: V03:K1:kuMtRY/zmeaeg3zNX+ncSB8G5XJd6JH3T0cqn6L3CfLcP3mwDy4
 zhUCWrH2MkBzGDLyFIgTMVjv8nez+CxvBvWTle7O6MAKnhMO74K1lel6NR4GrbgHYWtllao
 NGvkdRZFgCrqX8uUHTZJ1DTEUrlJ98IkqVveFa8LH8eifVAlVJhB8aRgRrpqUC55iQi6H1m
 hI1i1ioHhG/xq6TRQvo4Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VyGm44GzmUY=;yaLSiRjpPG7nD8KZqBql+0wnuZA
 /52hXsSBMTQufVRxe3+YtpLJbMRnSvpOLCobkimUJyQaf95k1hERiUP/+hJqmbDmIekM9eSUl
 cC9labZUbHejy5cGctNUOihG90rAOVhj88eeH0iYHzo95gVxQFUzTG6/XFWvWHvdpgx3Xcbo6
 IqTp2Cuv29m21OCL6O/KUKI+qt0fjfojvCN6QqY1u1LQydbxi3g51UfS04NrazCmtdN5LjMEz
 DsGe9UKFMHHZ02nSgaVIoQQ013aAEWXbJiiORiM7A80/lXiwxl6ZZ1t1cgrXtXBisBd6IvtCW
 31hYsWdwA7ypZ2EdZBvUNK1NUjCMY8Danzd8uEUaeNcfqRm5OYR1XJ7/jjnVOlQ/fnKEhHknz
 rIMazgh/LZ74t1FHXp+PA0CKE4N2hV4ERt29KQ50TW7IkZDhDsdr6sAKFWNdElCltgkX7bc1t
 mCogamFgHhzAutkfpqUC6vnSME/zfSdJbhS0XVo2CMvupAPTGrtztqugqCjOKeED8XNghc30J
 p/mc+UcPsn8Sng2Cuf9oDIoHb449uHnyQt1wkb59shomLTEGS0+HZsSGtJ4vA1SKmsaOXFUy2
 ylSHGCmrMefObSNpYZQNry18/375Awu+9lWkda1R5TRBohFN7US5cS2Fef5kzCOgHG2ztBDHF
 ChVMWyT3f//dJGruPO+qeuhZ502edM7jIY6bIerRKw7emvphYNRr0pYr2hJIXu4I0GCRgfKWt
 SsK0VhA3Vep4aG9oEjKtdQ2L4rsHDieHQTdODKUOTrNNRQnKW96JY6nZS7UTSKc6q6Ou0pxbR
 iQ/0Gbd9lIRyanqi7Hmm9NjU7rfkKRu1AtgFnh4WiNs78ejgRWbtoHXM4Q/2ERUAfM8SIqCNg
 5hDNDzKhC6ZSHBalsTyU5Z7nhvrqs/OmWuhR3uj4Jm8O56SnqpGOlhCnaAhs3pUbc6alPPB+q
 rRPKv+WRmLrxTMYXin6E7e2ihF+eFxIHDPvgQAQqfgGGQbZ20wV3ezc//AA7ByV9Tlw334vXh
 vntoN8ZGmGxJ1SD4eqvvPfHLdx2gGsQoNAOL84MX5HTcjetaQK3Ji3yKvjcPbbYfJbS5uwYWT
 feVCdboIRaNNU8Yi15FclyKEtuJaTtmfpHxqM1GjdNwCzH1QW6ZFRRXKhaqjRe4mzlMrRubG4
 3sKaGA/zcNMMb4VO5KQDOea1gluMPfcuOaA3TThLbR4FFrxErMc6f1RMH7JxST6xqGGY1AV3+
 NxqhH60zLGpKlGfSght3fLuOSgHzJI813oQmTYS/XaPRFqMeay+I9l03DyvGB0Mi3aF4Wyd8k
 Lmkn8wuiks/lEbI/5zU0unaVRN6zASopdrf2OK5i5Ts6ItWJctypQmJZ++LHPHEYSsXUSsllS
 GmhScjixkBUlNx5n6ovnE6xXwCwPjfxh3V+pibCQNO2UaVWHST28ryP8PqQuC6P87S25Ri8oO
 c9l69pxWTTGVuobnafoKa++GbQE3ZKTdN0zcTbrxVYZARQC9jFMqpnFMCJisSxxNv1ghyT/87
 NYoC7bbhcAwkm5lVMF2BXxUZKeBE+MR/BiKLjZ33HUUNIuwlL44ieyibnLBu4PtWsw86ZFgDA
 73Q75hNDko3HAPO3EUeCifVMXh8WZst


--qw7jpb2xcpdsmjqy
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 6.15 00/92] 6.15.9-rc1 review
MIME-Version: 1.0

On 25/07/30 11:35AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.9 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Fri, 01 Aug 2025 09:32:07 +0000.
> Anything received after that time might be too late.

Tested-by: Christian Heusel <christian@heusel.eu>

Tested on the following hardware:

* a ThinkPad E14 Gen 3 with a AMD Ryzen 5 5500U CPU
* a Framework Laptop with a Ryzen AI 5 340=20
* a Framework Desktop
* a Steam Deck LCD Edition

--qw7jpb2xcpdsmjqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmiKGXYACgkQwEfU8yi1
JYXu/g/+NxM7Lexz5g8+vNOzP2RphQ7ymAD0vecStCKuZl/BdhkPtYzQc+OIQH0m
JcrrUPZwHE12R5XuV9JDHwed41Le9yorD8A/llddnyTBDxYjQB82KKZD5+XvoLnU
wj7JiIP+TQzYE4ZiGHB5t29Z0/wqraoBGT5UgaJrxsOS2aEncqOnOyVGCFjqwpmW
wFux2qHuaJaqXT7pArg3qdwMYdqBfNi4/EwOJfZit8rCpJY57Ln68bi5Qle3h1rU
A0heuo42giNQZDizjGo1Yh/RZ2xJLwxD875Y65B+pZJbLEdABYa3LsYXz1b+KN25
3fGjc/E0zWKG11hyrmHrMl/Km53KjkcNKokXof0Qtr5br65yg2pyD8vazLiUJCaW
tEghoKViV3vmKV1vxKu2D8t1r2eUQcI/XagD0mh7CBo6dB0Vq/3tDR7usspCzCyN
RFQBec7xBOAFMdCOPFFWFdcY+XQFRKfYDjOS681Mwu5h23qCjSeaAn57ElQjJCoM
Xa7wq3oWo0iSAE8uiZHRp4TxdkJSmmycZLxiSGPy3WXyzWEtP0S8a7NeK7joJ2JU
cue0sArzEA16aiYLqpIX2fXCHVeYLr4gVdJBqBraD3eCXzAgt2I/qKkiJKd/e4k8
te2Letxo9H/EgwbkV8tWDJW375GHXv5PqkOX5g40LbddkU1DIbk=
=Q1Ru
-----END PGP SIGNATURE-----

--qw7jpb2xcpdsmjqy--

