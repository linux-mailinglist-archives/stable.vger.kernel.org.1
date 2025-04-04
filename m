Return-Path: <stable+bounces-128289-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC07AA7BB13
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 12:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7071188F360
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 10:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA481D89FA;
	Fri,  4 Apr 2025 10:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="DkOST7wn"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538071B0439;
	Fri,  4 Apr 2025 10:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743763166; cv=none; b=ptWy3cbPazlU56t7p7imii7ft/h+tn5YxhQ0xnCurMIrS0jjMpRG1ADq0yA8um/rkrafKw82zLclr/jjREUIMyTfGfIDp9mx76CTRszVTwXV7kiiy3dMTCsTAHLI6iiGEVqI8Dt0vJfWKO1FYTokNnJWs6pq0b1OZEVR/aK8Ncc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743763166; c=relaxed/simple;
	bh=RXAzAyUymUEGdjhF70f2rxVJquHJ+jHFiR1TdWzgpM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=io5u7KGsfmjZtSSrI3fNhBwaBGiC/2HqYEH7ERoobGkm7HETOsbQlAvgRgKJJtG+xUhmz2J82jQA+279lUdFpM6AKgAFCcJNAIEOD3xqxcIHVVoOtMcl75l4wZLpqURl6Dc/kopYVS4D+XVdF9ATi01/a60CtwCXANgIfpl59MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=DkOST7wn; arc=none smtp.client-ip=212.227.126.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1743763136; x=1744367936; i=christian@heusel.eu;
	bh=1Xvnr5xTHj5ffS6/z//aYoy8Zas4UgwcMAg/MTUZApk=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DkOST7wnNGh9FtRK5DDjFuAwMm/72uwDk7n9RYRjUnk2EvP34cetBuYXDl8dhmWa
	 /DD07DF6tvql1+nFDy1Z+sDUpE1mTV/gGQPLJmZ7LNHTaYBu3Dx5FhHPDHxZDldGF
	 /q+lC72d9aYrzU7Vz7KfWvwGzEGir3FcPMjLVqJUJEVBeAihPDbPVPuLkxsqZm5TO
	 CxfBYRfLpi8dEXo6juL+inVFMJPlPjZWxMl/vedRZz7bD6i6QYKN5Bxyqs1y+VpOF
	 wLiBokujTcyCDVmjqmzId5XQN+0AmYhmrvOlOyT16LKm3iEJoGAFcdP/o3Vm3DASS
	 YH8j40AmbQ3H+nBY9Q==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([94.31.113.55]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mnac9-1tH6V30reX-00edDE; Fri, 04 Apr 2025 12:38:56 +0200
Date: Fri, 4 Apr 2025 12:38:54 +0200
From: Christian Heusel <christian@heusel.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.14 00/21] 6.14.1-rc1 review
Message-ID: <c06931c3-c691-4acb-b3a9-9b2df8ef30bc@heusel.eu>
References: <20250403151621.130541515@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="v5wn7utr7ycxg3wj"
Content-Disposition: inline
In-Reply-To: <20250403151621.130541515@linuxfoundation.org>
X-Provags-ID: V03:K1:WLuhlQHS+PDXdBftMV8hO3bixlIHDBAynRCPn70q+P18m1hbFkk
 m2QrMhxTRsbtnHGKw64LCCDYLJlPEYLy+1SweYKrH5JgasoW37G0aG/szo/0rrQHivh5aMV
 GfYt78IsCAg9Rgl/o8FmoXxFVW7PnMk76z8YAvcmUr3HUUwtgqla1KG/NbuDPEYTBZY0d8i
 VJeItaZ467vuSsOGkkLPw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Fwx35pExTCk=;Sw0KzyRsOmAJETEZq5PX2yhvZO0
 NjAHxLu1TjT3/cZirx/ETRYmwuVGiT0BH3URDz5zS0B+dylj5pX/xGDUUlm8IT1xh9jh1/w9A
 vJm2QEl5pLORLfaDsJ+41VnacjmFHq3ANGLhQEORor3gPHCgSa2sGNUb+gH0rQJAKWsGHwaze
 /zlzycft93Wdnnmw7KnuTIrcQAo5aqWalndBHk156KzGxhdoAq9RYL5F5Mbm8F4Toz1EHTusX
 saPcmGVCjUWI1ujzIsITSOXtfFDqhCYkyhI1ypi2FZLm8IdW01o1TFc9ucCfq88P2FiWzk6Hv
 9RgrmtNaZaA48pyfN9iAIkf24F/OFQWAviwOlxt/7zY5vNkcGHSj8yMFTd4st4zDlHziqCubM
 i4AtH/s9KeN5ADSKyRuY1JQHimK3mzW1dR5fm00YYwFgNUQTElphBR/kd/eYLlb3a5VpgNwyB
 MYS98lsWIPxV5yI0OXwX/MGGBQptnQFan3s4tg1cYIPXiBH2ya6Xnk2M+QYWD69ffhsLCwsxj
 kksRtGTQlJPFkWFUas8+Z1YntpoMwcxAxMmL5GgwUqlnPvXBDT9BXSWEhlGrv19pWhpEvv9UU
 eBtdStbWBtfTum9PhRnuHSjOBcOat/b65XDGDAcu7DxXq3l8mzC1vC1DTzDHiZ4XS6GrJ5T7+
 IdpejU+B9XTHWHHg8IBHz8ZYpA9Yg7DCmcX03fiU/bNtVQdobxD+uacnjsK1nZa/c6H1EQpoT
 SAbrCMy+hH5lx+kTNWzQbHhZyQFpiMz5jNfHfXAR77jpM/MJjIzW/AwIU5SerO48Itv8GhBg3
 McMznwT+B36QoYA7g7OISjEa52y/mJODt7qPiY1MrXUwHPJTYtx7I8cmekYeb43osUNTL0LDw
 c3NVUClGNIVEFqbyh0gJ3Tno+gd7ZfG8kzVXLzL3ZK4WhuIcsH1/MqMaJqhXSQfv/VAOkxD0t
 KdiRjyYlo2PU/zdKZJkuG8xHcRUXwaFYid4D6RNK1AC0mqlxpFd5GH+SOOx03dyEi3Fnn/NCM
 EF9bWwwzWJFGClEh24AkP8k7g+Vj09EXdCT7UqnI2rgQZBWsfhYxWOJeoCMCswBHachfjgUql
 utkEIE8Y7B+T3DwT7S2BM7foRKtobquJi7+YRN6mD3kFcOIo8k1qEaGgGLvGlEh34zX88V4C0
 vRKu5hzAml8K2ZB0/wkkhnV97IwOse0lOQXrihOvdn/yaYTJZSJSo0EZyIJzKSfADkksV0AZS
 pXBxmn8c3SUq/4noWUaUWneTRy0cR/Ob11td6ngpkkh435zoJZeHFX5jZqhlal8m57PfOUK15
 Spr8lLV1uJhbDYo7AmVOldtXtoBGPn9x12k0lp+WIIEJkYRlEtFEY2IAqay2iwrmVfgwa9It0
 62Myp6dDz4DdHqrrEjpEtJf53sjbUnZNiqOLy09gjYNiPGRMiT7Ljsytgf


--v5wn7utr7ycxg3wj
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 6.14 00/21] 6.14.1-rc1 review
MIME-Version: 1.0

On 25/04/03 04:20PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.14.1 release.
> There are 21 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Sat, 05 Apr 2025 15:16:11 +0000.
> Anything received after that time might be too late.

Tested-by: Christian Heusel <christian@heusel.eu>

Tested on a ThinkPad E14 Gen 3 with a AMD Ryzen 5 5500U CPU and on the
Steam Deck (LCD variant) aswell as a Framework Desktop.

While testing I have found a regression that was already present in v6.14 t=
hat I will report separately.

Cheers,
Chris

--v5wn7utr7ycxg3wj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmfvtr4ACgkQwEfU8yi1
JYXKow//U0IOkLZJ2LbkAACQbWxGZCfcjMvN+GOh5EU64ecvFc0UxOnqVnC/xyHu
up2JxT0kPJZ15zm4vgKWUlS383dUBuDlqEyvN6oEqZBuiiNivEyaEk06QgRlfAc4
G7L3pDD71+MPa+FIsoja0wPeh/MX2f5ftvtsqvRET7ZijHY7wF+oZQ7RBTkW8yfb
f0KufR/ml8ai6RLULP3BAwn8y6odAXbgdSzWy5S8tGEqCjdENdfG0/cL/xvXU69a
qqBBaDMk1BVYW6Dt4NXWqoE1Dr1uJcjAA+9ItPMq4R/EglnWEB83mKru9EqXJJuE
YgbMdRYKeRZ58IJy3+ww6yAVRMjNW6DyJ8atKpj7NLjWoF0FWFFbKh1Z4SF2zxWm
FhkQZdVXKr/iTIjFrZiF+xCJjSce1GnERIrFkUvRHQdEo1O9v35ewjq1GAi25dle
HijPdlpk9ZRxJM/UuBWSC/wR7MkObRfx6nZA250Nark5hO3nq4xpBPXezSL/WoFi
1AispsVSj5JU61I7tO9sDV/iiV7tVG8RAzJ6o62t88NiynJmy0IcK1Xz8pkqWWyZ
zzLL5rueRcRA5l7kPY45wmx+oJQIJGgPqrV62c9RYcKTOjVEpMUE2yk+UCu4tQ7G
KXftXts0LNGcM/uGAuXJ/hD0wq0Tqe66od4Ghp/TCNSZ9DfAMLA=
=DfJe
-----END PGP SIGNATURE-----

--v5wn7utr7ycxg3wj--

