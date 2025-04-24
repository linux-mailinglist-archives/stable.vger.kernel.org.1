Return-Path: <stable+bounces-136519-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1718A9A280
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 08:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F2107B1443
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 06:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE251B4F1F;
	Thu, 24 Apr 2025 06:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="0EXX+F56"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109D98F5E;
	Thu, 24 Apr 2025 06:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745476983; cv=none; b=MAVMZ37bjS3mno317jd42ObDzhcL3pTtHkuX46LpwcbVR1ecaHUxWQRCB6YurXVgiQwYGIzHEa6JM9pUjAiTxc86qkaC90TdPk6JEfOXgVoFiiavPrw9AUy/jaWEdlbqYB6mvhiBL1DHkDqrlo6TQnjb3CYZmUiFSW5AQLJ20wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745476983; c=relaxed/simple;
	bh=/jSPP5jRjyGm2EyKagVSup3qGysKbQLr9FSymPXCeis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ds0wRReXuBt9gN2Vc8t3ezV0idxWYsfWETbyMssKMDdd9rUPRKmyhezr/a74hBOrhwEf7kJr+x7zpA7NnZWY6fZWBwVY6X3Pje41q1MMVhPD+vQ7iHsvsX+caSVlx2IExwH6j0BxcjYIWaBm0Hs01Ts7xQGQ4jaw3R8k9WqL4xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=0EXX+F56; arc=none smtp.client-ip=212.227.17.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1745476974; x=1746081774; i=christian@heusel.eu;
	bh=EbSvx2qQa9ddzKM9jOKOli59TXLhM3lPCc288iVCqC0=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=0EXX+F56Mt4YIOOMlmjCVnNVD1ccCfObzWnGxJFxW2pEibGle8AkhZ1XIQrEbVlB
	 03qIY/lIA6JrbdHfhlWxDZrqEtXSn+8+pann35mhrnFXKbwbS2baM5D1mhgCP61Ln
	 pHIeDUaEHDaUVI/eOnewJTlD8otCTmk4zEuHpiNKUat4lnvxBB553ONkl2+7XjCD9
	 3v08KdFpAhzyW99/w5nebQdV77o4EBEY7s+0//ftEsLEkAyPO9NbGEH+zrewxV3J/
	 av15slS8QE80+ZTYFeaFnQRNLOnYYr4Pxk+hEe0IIGW3sjv6EobuA3kSvqhWecxsm
	 Pq5o4wlnh8FxUDGtIw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([89.244.90.34]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MBmI6-1uFZQV1jMi-00BTBI; Thu, 24 Apr 2025 08:36:35 +0200
Date: Thu, 24 Apr 2025 08:36:33 +0200
From: Christian Heusel <christian@heusel.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.14 000/241] 6.14.4-rc1 review
Message-ID: <ced73860-417c-4f08-b84a-db0d88f24bf4@heusel.eu>
References: <20250423142620.525425242@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="easgnngilahnb3q5"
Content-Disposition: inline
In-Reply-To: <20250423142620.525425242@linuxfoundation.org>
X-Provags-ID: V03:K1:rWc6rPP0Fts8PfvlGsVBGrBbx43vcw4/gLEHVN1kV74+s25pwl9
 SPCCUBlS+IvNOpWEmg4z6mHGOMHUnlpVmHSauw4qGJfqPYjXoEqTl4kg+ST/fDLVb4RJXqu
 /J/NFv7gZiENpE15AvrBdw4PC86EySs3j1grF4GiYyDAh6/UV2Wr6dDxkhFrER1PuAd47zV
 czQ1p3tVSIrt/QSi2Jk1g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:olsaJd3uAfA=;dKha/rSnyH4RqEOfeYQNYOB4mN6
 BzuX3o6RV9ANhUfQhTdtruC+tYTPz9YXmZvIlCwHMSl8ivJ4sprzp2u7walkMOHzt7r/xceiM
 MZH5wJdMTjk4xqBDRQ7aIaKWM56pGgxQDhYrGFpkGFo1sOhlKS5X00tScTYW15V/xpFa3nLD+
 gyU7UMJDGS1MmIVqMzLHoD0yZytlZXiY1PXi3dvWl0OPoQ0lPUxV9IFXjgTcBVcArOEsR9lj1
 29E3QobIsCjz+2lJYB4bOXfYA7F29UxdLWQ2gZvy/apuzQJ3kbmZ7XTheppQ4atJ+Nlj1xz6m
 lLNj95vo1zRUg1ytj98BNEVRYGOZu5rBrXi2m+D+wLS3RqyMXPWC1QBMulcx6Qsiu196t64Pt
 nANQRdfiVxxFW4Ol5g1fHF2BuC1aa4oDNWBEyFOQAS4qWT1mZ6IYT3Gzhfxn+86NpE6T+lUpM
 53yB+at2JSzHsdhiGWTgEQZ3W++XMEuc0qFPKGEP4DT0AuSq4dDfiHTV5aQBcGEncR0eYRdKE
 EgXw4qkF0efxEaM2ItqYgtd+fJ1Lyw95LlVHNgl5Joh2jc/OKZGsSJukK4eYM1vJ0kMJkPNTL
 Xqan6muE1u/L79kxaimO5CG+4zTJIXCtJ3zFdMekeePGnhHOMyf/JkCW7nDrwmGJG7sC0jFta
 usItj0L1hl3g4f0OBqnQgQbCi02ZK5OqGcVkfyCtiHWXvvA89D+acQZbp78pd8Clx//+Jl0Zs
 d5vcdOob6TnnhZ+dCIgcMuDkubjGncbYne1x4tdvqFWqGNUEXQH3kbo/HbqWVSlOPzyKZjWPu
 WNdmw8TQtT4ZKECcAFnaRn+6d/5hPvLF7Mt7TkJxUXhLxyQCoCZ3jLDvNRVVvUSPxJGkCGQbl
 tANopfAm6AWqvivFLmF4Dl0S/v6vZ8DUJe+OQjfZJOQAvJrlRxQhMZDpLi5fxuFZpTGuq4hzJ
 wfXtVy7tAkhZqy6T/PK7yq/PYU/Qk/pLV6ULXCY8Yo19Vn8Mhe5bQsNEzjUvkOo/4kHSi8ZAb
 JyvjWKoOv6tq+gpCI84F2O7wc12b440SOu6EeUmvQAkwHgExXp63QR5xoAIRuAVsAiTEZZUwV
 mi1fWZD3o6kbKKUHSU6/H4HMbI+ic5wprWvF4Q8Ar+3iWEIb7MOkl/rk2dQXz2Vpo47ntB/sP
 f30PJ3SdBycX8jk9Vszs7sIk+t/ISTHqz1s9JlTmvbn/Oz/wRO45kcXIzkaMiaoFHZn+mxbrz
 7IpslyKqe2If1flnZHJhlfe0Wj/O5RNQ1ZX7ALCaFeWVCFX0XTcOrm4VVQmr3XMJovQYxrXle
 u/eby3UGtETad2k4YxxXAglpy1qPyN9ZPJmXe7uYAQ8K6P7+D5MyaaF0PAxvp6hZxFZRvukJv
 GLh8cS9WcbcKizJFeWIRXyO+dWLucg/+SBTUI=


--easgnngilahnb3q5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 6.14 000/241] 6.14.4-rc1 review
MIME-Version: 1.0

On 25/04/23 04:41PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.14.4 release.
> There are 241 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 25 Apr 2025 14:25:27 +0000.
> Anything received after that time might be too late.
>

Tested-by: Christian Heusel <christian@heusel.eu>

Tested on a ThinkPad E14 Gen 3 with a AMD Ryzen 5 5500U CPU and on the
Steam Deck (LCD variant) aswell as a Framework Desktop.

--easgnngilahnb3q5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmgJ2/AACgkQwEfU8yi1
JYU98xAAmxjwxgb7cnrL/Vy4J0Yt5RmG9badIxxaJM52ds6KW4zcjd3RFvbrfkQo
lXA77TrWKkZ5q60uZTqxjBpPIpzjKC1+eWCAsXV7AWfXl3u0VMzVGGxJ5fDrKFUR
8EvhFjX7KjB5/9wI7dQ/48t/HjOkngSJPZmuLgAlXr9+t1E9N1l7rMADyHdiT50T
9A9xyhSDO1KaIFeE9VXREWBCDfc02fEuRpfOQ5WVRFof1ff8jOoHRPvHFHxUEDpV
6QAJcFFXWKIx6w8qaJKI2xV4DeNCuFqcNposhgJ89QgK/rSS3j4g9HyXmsb9bAO9
nraXScWRUPC86nSAb7UD6kKZFKyzyPYHN1AtdQKD8rWz0BJkr5DEGFITUmRV9rGm
NPPHSoDtyejO0DuOzj13mQPalDuYG072pChRjVPs7wVZQp3kZigMVX0PCTFIvRNM
rA58fYM39DwLFXQ7BEwo3evuC97hn29pkyyZ7UIveK6aQMJ5JJfx0J1YJGubXu1l
3rkxq7zY8YaoFtFTDZtOCnOCmOTlXB7agjMBnHx7Dv79UrKMMi1IDFdkqLDZa+Id
0/ojj+Fqo2CQdiGC58Vw5RpHKqlNwmNIZ0PCsbNybxF4Qmkp0hQfsMf+wb463Axd
utQExkZapgrIj7J8K13JpDr3gdIqYpVhlc0Ba7AByLIjbtvNtDE=
=mHAX
-----END PGP SIGNATURE-----

--easgnngilahnb3q5--

