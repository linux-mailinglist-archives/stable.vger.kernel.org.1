Return-Path: <stable+bounces-114077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22183A2A7CD
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 12:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49415162DCF
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 11:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D96C22B5AC;
	Thu,  6 Feb 2025 11:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="1qsBiAi9"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A32228CA0;
	Thu,  6 Feb 2025 11:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738842197; cv=none; b=OJOImyL8WfSx9ammH/1P9QrCcIGrUjbuLJ85nhtJm8dDRpMNbseu3RvRcTteoyUCP0i6MrQ1m15WtcSC5DLaZFdizRcEGZxYOGB+/2GfJ3RBpwKVRwFpAXJgwe8xkPyi0Qq1cPvSX1uNSAR7pwCgk6L5gn8lu8iUUzaqQLwVe2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738842197; c=relaxed/simple;
	bh=qkU7mN3WsjPDpBNtFt3YNB/Qn72CCJ1Masnk7K2NHIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kV9n1U27y9nTb60bCzTPttrez985qxI9aqLroDKxY2zoG5dMHa8sVOLnT45GdUBteEr5Jn8HRkEavV/Yd0VUD+Z9xEHNz7EnYVsh7AEzC3nM6HgMSG2PdBt5aLAS3/OWnKVbnRNgF3zsl+A0ssKyns1udxa85F0yGoUeHcgAztk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=1qsBiAi9; arc=none smtp.client-ip=217.72.192.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1738842152; x=1739446952; i=christian@heusel.eu;
	bh=sKaacpelINh+QPZCj7WfmXqNHAh/vXPNTGfxtluWYqg=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=1qsBiAi9MHKI7A0Gk4eIhzAaUwqbh4mz9/MQQ3nf/+8BMTo8EEzQkyWGU+6+VLGm
	 1g0qpj1JM2ttxJI12U7duvLnJgZeIGgh4naQcG4M+IOrnQWCcfnfy45D7VJjJrptD
	 MGaI3zkPnef08uslAXf88QLqG9MdOW+Fu6cdfFKvy/1HzKGgTRKw+XmI3kGCU7lMu
	 y8N3ppx7+cWxrWllYaum1q0EO6Bi8yRufHaXOjrfi5yleR/5iw0gM2WAboNO1vA4S
	 fDxkTe98phQAWTTEgZEtRqOC0OEGvsLTruRIfF6VFpT1GpI77rHvjmRq3PfE6Z2+r
	 uSF9ernJziuliS64Dg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([141.70.80.5]) by mrelayeu.kundenserver.de (mreue108
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MI5cP-1tbJq43KOl-00Fthz; Thu, 06
 Feb 2025 12:42:31 +0100
Date: Thu, 6 Feb 2025 12:42:29 +0100
From: Christian Heusel <christian@heusel.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.13 000/623] 6.13.2-rc1 review
Message-ID: <798f3ac3-ac78-4463-a2cb-68fec03f8136@heusel.eu>
References: <20250205134456.221272033@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ouvuviv5axtginyy"
Content-Disposition: inline
In-Reply-To: <20250205134456.221272033@linuxfoundation.org>
X-Provags-ID: V03:K1:h+PZD6BVMcDnThJ7eIWrKvUJMEFfpEYRpQWcYef5xzHcenUCVXp
 tD+FgW3ofNvGF+rw6WReYBNpmrfTOSefs0+hShoSuSPLksUcJ4V2S09WxT6CLTK2+pRsjb6
 9IGrd+77DRPrmngIoEmupmBd4IGR3FLmglbOSch+9zW2chT8cDbNJorBKr4B1jscF2QARrE
 Jnk1nHEeColYiTdXDD2Fw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Hz9o2WSSMG0=;UViQF+ak1W7UqDQKkdjuyYgkzAZ
 s96i6Fsa0NceOO4RQnc8aqYGHwCBj18dQdd19HqcClyz9wO7NpN8DJUlV7HsP65qn7hkh2Ifg
 5qnjasigSb6nNyHZ69onMyACLNqU3TsYg+Rf41R5HVxolBIGH1m3umNzlsaYPCNOm8eU5Y9m8
 1bhkyTsm9lNMkRFfPAu0MUbUHCrkDzWaH1zKOZ0wt4nFScikb6hQCaaxWfEmVxTdF47t6viku
 +JWAiPqp1N5/sQwtGuEHKhEaYqMenYVF98I1sVMtOh0Nx0tNiV67ETh7PA0ZQu00omGzOtdoa
 lpKB4VXarxB1TiM1tLOY2/wWmsl9DvqP+mQdgDYTlyCJIUvSg+SrvWNqZWaZTOvJSzbKGGQOE
 IU4Oxmt85DJpU4vmi1AKfxrAuh7YPtCFaj+x3jc875km3QGb5Bolj3jylqE3InK6LDzQHbFzE
 DFH4R+oKG9/A0kYaqGPs1+VXnUR3HWh3Ovc7/iuInTzmovP3DlY4US+AaIfU/0O6ciUkH/jfE
 6P6LUaDuyhKm5y1B34wXky3fVbpnuG+8S3MDg0bCo0gsDYI1UmSdvM2PKU/d5tJbJIehSkD7I
 M29Kg8u7bM43E+4qMBp2o6TxFFlzBdfi5BcIaafSiIVK7Vuk5Gj1vws+3x/vMA099fp3U8m0b
 D0dELmcKPd1+1niPiqxOIc2/f4El20Y38C+a8BKwmsT3y27I0IuOmEdpby4Nmv6Xu6+f5Kv7c
 0eQXfK/pqjkx0l1SMW6QbMcZ5khbHlrU+kWSIH1v7jHR/m/isENOZ+ZW7oVuXjMC8ty/8w8C+
 /ZhFepBka8LccATRPHsrtk8IplbIRj6ISuHssayNMAFn1kFrcIf8S4t2xGEIdIYvj9Ka18O4D
 T5lGat4uuGJzRgKm0WHRjxAuVua4GxcUgfq++Y7kUJQ8bGO0XR2krgMxtphK/XvJjJpdtpoul
 e583LXu5AtEI5smmsvTQi7sTRhDBVb947GfZ1QUOMOQyny1OqRBzdfvAnSZCCHVog08d3DluV
 SMJSg+UTFP5PefDdNb+NQGZgjzE+uPCGLarwYrSCmrUuXKC2HavGM25c4RYEPF2/1tVXA3xyv
 lj1japKC/6jRWVfsWRw6jKk2xRE7iGonZ40alwwixiAPQ1fMW10uHDcExGRqmmE1CbhfW7109
 blHy3bj96+TI/Y1lMSvt298+8rzRSbw0DyrrR3C0Ml96i1a/zcWKhMngrOOLuX1lMPsiiVQUI
 QafUI8NbjGmnPOW+4YU/hbgCYI+GDnD9qsRk1PoV7iAjZIvNG9SA7F11rqjqf/WDYi8DrZ2RU
 UfLjzJ/djFAYOYpxIJ9oyVtne3EzzDPTNlSAlfQVZVAuJA0iUXn1Elx4jJU1nMxc4Cwaml5lT
 DkmxZRG5xeeRI9Tg==


--ouvuviv5axtginyy
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 6.13 000/623] 6.13.2-rc1 review
MIME-Version: 1.0

On 25/02/05 02:35PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.2 release.
> There are 623 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Fri, 07 Feb 2025 13:42:57 +0000.
> Anything received after that time might be too late.
>=20

Tested-by: Christian Heusel <christian@heusel.eu>

Tested on a ThinkPad E14 Gen 3 with a AMD Ryzen 5 5500U CPU and on the
Steam Deck (LCD variant)

--ouvuviv5axtginyy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmekoCUACgkQwEfU8yi1
JYUouRAAsm7lYVm2lu6MTYGEL+LLpdZ25cGOUjAGsZiWra/xJQqXZXVLEpcjOLL7
BSoliqflrtMVpy8xZe2/2Wwjhw8boYP2DVrm7sg5eH6tg12Z/rOV08tOvL/wIkxg
ewBTdlJ/niVGwmndRjJdGXcWEr5E0Ll/57mBfF6HCDP0opF0i3ijOxs/IRgHg3IO
eikRInbaUj2fAEbNSKEdxTMLSigATEQC4VUgANydBvqF0aS/zP81alyCjAI1n5Bv
GRXwfI0VhqB6nNNvaJvQJAFrXdaJVipNUst9eYVqsFo388Qkaz3r04TwdBCwKbMl
kBQOUjulv/fyAs0W+iIoVNt4fJcB585zCRC4P4Ql6ugwf+4dlTS8plQWoqZChFWc
9m9Qg0WSzr/+aYV2TlZzu9aTKSr4BNk8HyuKAujVbrVfE+smrSCu2q8vEVZQm9YK
I8tGXEmq+RNCBKP5BHJxe5AysDQLZbiWihikMfDj8prX4O9PkAx+U0GuCxsjTLoc
vmhpZ+0XTp1Wd1u+k+s/7tbPne9snozU7Im0cYz/2OjN+Jifje75WvS/KjamIfgn
BBf7N4FCVPGxG4hrKSL9YUH3fYAw5ZXvUGBTt1Mw9lJdlPlUCjNv1XfdBeDtjney
bvaBmqua0/7eRVl5F//pMDpdOq2HUFoWZDbZZ+4K7IGkTGnEBws=
=m6t/
-----END PGP SIGNATURE-----

--ouvuviv5axtginyy--

