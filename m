Return-Path: <stable+bounces-139307-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0759AA5DBB
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 13:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E3C91742D2
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 11:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14A9222570;
	Thu,  1 May 2025 11:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="TVMZGo0I"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AC8221FA9;
	Thu,  1 May 2025 11:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746098652; cv=none; b=KzoGDrnSo4/EQo90gxXjQDkHt5u9LwoLeG3jKMlhnQTz3129mr9ilCvQKDa7TaGN6uXfLTccS418f/GkbpigiyWwo47esi3CCXq/DXBqF9fH4yr6FCI6ffpecAZTuhn/vvXI5YJ0p1BDFLHH4OQ9zUvb7AGXi8qc4CWvmdME6VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746098652; c=relaxed/simple;
	bh=J7kijETQ2asEm+lK4uKe63fSwqBXyFmQ3v5eEz8FXwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMT/GgRWwjvgJeFQPGdc0rnrwz47WdixEMLR+EwPQCl4oYWkjWaimrqfdR2rSxMPIxl/SRnR4dpacYOIWepRcsNoepNrrn1M/OSYVNb7BOi4LutCFKoF0JvpMy2XiB1UhAH8lAqEd+woo62d3YCcEv6VEYuNMmzzRparUH3s3qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=TVMZGo0I; arc=none smtp.client-ip=212.227.17.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1746098641; x=1746703441; i=christian@heusel.eu;
	bh=hAjMdzaURmZllwIbYvh5tG3QTpVTx7txDeFWtmQfcZc=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TVMZGo0IuHR0vp+52X6w4HXwmVM16H5arLpEXBJW1378E8MuxHfGhrKs/tTbiP8b
	 F+u71cdmy/v6S2o22tQT/B1ZhH1fX9lD7+28LmYymYC+oZpTjW9b+X3GlY5gbiePn
	 hO+4T7zKXeyUGQgr7csU8RmNalUA7ssSMUUadcO1mR4zEzlb87yqzEx2OZWe40d7r
	 ydtTYFM+PU+U5MPUrplR84VoG2zbAmPMamP4fKZjHVy7VWcZf9UX36PVqH69s/Ube
	 I6vi36H/MWJtq2nTnz0ya7w4wY+JoYiN4XB8cYGWBJiKn9XLE2f9JXvFB20DJ+tA4
	 RAGdgh2qoERioeQgmA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([94.31.75.247]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Ml6du-1uvvAC1kzs-00qZ9e; Thu, 01 May 2025 13:09:12 +0200
Date: Thu, 1 May 2025 13:09:10 +0200
From: Christian Heusel <christian@heusel.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.14 000/311] 6.14.5-rc1 review
Message-ID: <04f1b7d6-affb-46bf-bb94-020f013e431e@heusel.eu>
References: <20250429161121.011111832@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jxvcqh6kinmdq26q"
Content-Disposition: inline
In-Reply-To: <20250429161121.011111832@linuxfoundation.org>
X-Provags-ID: V03:K1:l0dFvFXonn9aZ0DS7ojFGSZhcRkTDiLEEVC608hIClhlzOcRBO5
 n14VgP2kq1f3qLBf8ZZbljUWOxbpFKWa8JLcl8+eKwOdHmUEiNFBK5s6r5EynRuibgCmQ+/
 7bjuGoMPCPScy35Uk0QhyRjHI/9VXwuEn8lCHeZ4ARgTXGdAgNnRCTzRWD8VhhwQKoUO3hD
 Ci0bv5O9ImP0RII4a1jTg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:m+YhlqJMfDE=;m/ee0N/uHLyGg3BpWBvL3vMdeSt
 xe/CGgjPvccWFaQhlu8AYWYLo7Tv5HkCK8euSCHjD2hAysq/s6WFwjM3sjQGrB2lUiuSm+scf
 8S0SkipfIEnvHADo+2iDni7zNeq+nlxrY2dGWObFiQ228jZNRMC1lHtbYJUTiEBTa/y+6u9rz
 uz8nYlAurS3eKFHRCG3E0KjOys/PwGcfjGsHD7QY9XAPjbEPJbpokCfHjjUAR7qcNIM6dTGMG
 iLPtyMFwHYxU/zwvjLGihUiTx/85M+K+kEu0BL1v+r+z/rHmoVEvyK413FPyA3nS02braDXF/
 +77FhxzgGmMFDE9aFoA15JuvNa3sdwNsQJoKil1OhG79ztw26BNi2GSVb+81Ti4RPY/sZsz6t
 xfg1LIop/UH6PPU8fzr0o+QBNPqIA+6+dMcYXbGkZuHwJB/01X6Oo1D/pRZH3sMugUKQXdJQS
 S2fBD+1cVhzfeOSdkFmaF5PnW3Q0Xj/oK+rNjDUtFihLPly1OgoByag9r4IZLt4oO+pbdSMef
 +F/geDlC1MKUOOM/4mA3zwrCPDw89226AHclNQUvtEx7/wWW5vA59EJjhAMqmRKhn1yEuzzAD
 Ius/rMs2g5H77KdNvjLag0PaaUx5f5wn8x7drr+yKAz/ilhqmrUDwXYRUHp1T3x0DPuv9Pzjx
 YCjNj0Es8h3GSdCfWP02NfRWNTGeA1pMynxGrovWQO7QXxuF/iuMO7hm/M1oRtDnQRiEfN7QS
 IiKrxFIGSaNQ4pgxblLQRCgXvww3FtAZrf7Jk/Ley74MrZ2Aowdnr4BbJcUU9rd5q34ygHxgS
 45V+9Elr0Woz2Rjvn3ZtSV0vo9ntKSPsTE5pm3Hrq3TEfTVzTe5Gi9PxdZVR0tzIju6Z7q2wk
 0vEa5mRz9WLSeb4hKHZ9mlY5Q3Si0mrDAvT+T6s64zPRd/p2fjXMiZqhuhLU96qXBKbwmdENP
 rN4MpUAi5sWhho1fQBdMqHa9wQUn2NYEqnc2pbqw4+sN38OF1SrdN2BWy5dCPovYJXx+An2tD
 uLol3IP23XAIzAHX96mccEVsyz33FIFjV8wqzfFMddsld8X/5PxLS5jhPBTXsX3f2KgetOXNa
 BOYnLUWEeIVVpafbYDWz9ceBMonKJNuxyW1z74+xlfOIn8rnQjDpmO2zn9DL4cM0+HRIO2M5W
 of5Qybxujddib1l9Nz4FkWDT2JDLcfQkNTulBiS2T52+5utVcwguEiF83w79Y+fHNKitUoeJ3
 8FpqA2omzIip+kg1XuS1sTw/9YGi2mufVCvRdQskAX9yCJgGt3y61h5HZ6FniAPFvnQLiovvp
 rDlgULS/HwZ4PjfHLk0uslTUorxBOXSmCuk6Yn2HSnvsPqPpJDJd9JAPKm6/PFPB3ByR12dP3
 qIjCLQ5SpBHk710aS5xiiiMMnzUb0tzhM3GdkUcU7SGIi0jU4zE5EFzZFtpDgWBHLYUaFNxxC
 v+WS6DbrxXnIU1/sUxBK2edyloao=


--jxvcqh6kinmdq26q
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 6.14 000/311] 6.14.5-rc1 review
MIME-Version: 1.0

On 25/04/29 06:37PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.14.5 release.
> There are 311 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Thu, 01 May 2025 16:10:15 +0000.
> Anything received after that time might be too late.
>=20

Tested-by: Christian Heusel <christian@heusel.eu>

Tested on a ThinkPad E14 Gen 3 with a AMD Ryzen 5 5500U CPU and on the
Steam Deck (LCD variant) aswell as a Framework Desktop.

--jxvcqh6kinmdq26q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmgTVlYACgkQwEfU8yi1
JYVMXxAA48Su0UkecFjj05X9O4K57WK4IjMqZFb24rPCaXwdG+51KfEKIl+TZalh
FiQk4sWL5LgF08f6pEoAMBRG4B7X0J81IUi5Ik86O5UvrrC1wN80/qn8/QTn0BS2
uD4VdPckhA8CZjo/I0VP5ZFK/tdKGJUeXGXvYB0GPO+B6IWqietuH0hfpGVbIPZr
aINLSX6AMb2vrrwA4/33QCt/dRcMy/46Egjr35js8v/dG3hROVsY31ufa51+BeBw
oFedreV0E9Qt7hXsgmOrchgaCvYM7UahTi6R+EITdjnSdb2nXUJLrBkBc2MTo66u
1R3u+eQIIRFLoJLbL/GO0ZUvfQ9BWwLMypTblJEK+w4efgAfki4hiQmDq/AldSyn
QIXDN12l9uAG9eYRiVwGiWTAoxNJCtOUsYQhzrKla9aNVuMin1WPklBMLE0Ac7mX
9ytcjQld5WsBMVbC5DjXhqlEwfNdK1xY/TltieTfWghnRGVrp15a7vy3AVRBlOvx
ztqDvRHkxiimgd1ZUv8kKMc6NbOYaukUzMPniISibSIs/fq5NZFFRDgjmQU+QALj
hSKMi6TplDqPoTGlI8SjC7+m4JqQU5uhRJeCW9ytnzLXjwP4ZaMX/bywFqOxF6Wi
WGJ+XR9w7gbXu2jZ0cQm5urU/ql637oKNYEAFnEKdWHKNMj5Svg=
=Heyc
-----END PGP SIGNATURE-----

--jxvcqh6kinmdq26q--

