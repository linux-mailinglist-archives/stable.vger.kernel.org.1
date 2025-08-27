Return-Path: <stable+bounces-176526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A162FB3893A
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 20:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8AF17B9A79
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 18:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF432D73BB;
	Wed, 27 Aug 2025 18:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="t+gFtHFp"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0526E2C031E;
	Wed, 27 Aug 2025 18:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756317774; cv=none; b=HZh3N5lAdKn+FTWaklCpl1CIv7puNOz23/uIiYkkip0z9SjxDLA1KM90s5pvjaTPgm+ufXkpW4AJtoGNyJjHUwyixJnYWoeWVS8skWpOHmc61bpILiu2+510Y9ZutpU0PUHh2cYuPCgM6vlMdk2yS7jrA8zRoF3rI8TgGkLUxZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756317774; c=relaxed/simple;
	bh=3CJtJ5vFXngowMKB7Bdgd6eKQKDaN0DObWec9lgfDkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tAQDeG6xrlvr8NP6KpanU5IYTjKiQ2Zn+8HlWSP+Y7TmPztgXmLPfl/CaEKeqSMoU7kIBpBoBZouo6+syQxYnTZmkJb5SVYKfLNhS1GXQ1SK2oQ/Z/tl8/5UWJDndS0wxcgsB5ttSaXlxltA7rWr4Ne8S5OiXQ37J7uXNRXAUIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=t+gFtHFp; arc=none smtp.client-ip=212.227.17.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1756317765; x=1756922565; i=christian@heusel.eu;
	bh=4BgvfIWpq1zAjrUiinTpJPpwIdUp6H5Arkv0i8oX8Sw=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=t+gFtHFptdj9AoV+fP72sKXRAYCt8RvCPuFyvXys2sS46UNEmwzrKmfDNak7eVue
	 FiMQSio83rfR0p4W6/TlxOFGh78diBboxJ05mPt6K4gfPaYqQTomcpduexY9fgGU4
	 J360f5LMrG4W9GjwTCu5027kDfz8lqyo68aHKks4w7XA8Xl6yUMiXRBo2Vo5js5Ff
	 oSx5o5JRjHisr+g+wqYePdvILGRyWOTPMWOziAzUYQ3q7YgAWREgy6nG9kCafTTwf
	 wTdyxifKwLJLJX9/RRlQMKPxcihl9ObU0++j1LlJqmxfV3yLn1Q6rY8tOZnRmbAJL
	 Fb7XDXQXevxCKcPkaQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([94.31.75.247]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N1gWU-1uOtQN1H2m-00vn2N; Wed, 27 Aug 2025 18:45:43 +0200
Date: Wed, 27 Aug 2025 18:45:41 +0200
From: Christian Heusel <christian@heusel.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org
Subject: Re: [PATCH 6.16 000/457] 6.16.4-rc1 review
Message-ID: <f51c8113-d240-472a-9231-81deaaf95e54@heusel.eu>
References: <20250826110937.289866482@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nbtzd3b2lmwkf4dz"
Content-Disposition: inline
In-Reply-To: <20250826110937.289866482@linuxfoundation.org>
X-Provags-ID: V03:K1:0C3SdLhtqc3V/gIlldVy2ea9maxR/9RwiMUFRqJrB3uMF9g0vam
 ijbpq/1+3eANieFhnV2mTunH5VmSHCKp68DdfDJ/HfqHJa/Mh9vXvQMXdoPHRLPBKiLCmqB
 f1Ct6zB8j+FPg9uQNS6Qn256sFswHWBQdsVfU557MXWrIavG0upziNxpp1Ps9xYI107Inld
 n4xjN/SLfeOyIP3uJY9DQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:76cPjcPL7Vc=;F8vSAOKAuBDnvgsOakKu20vLiTJ
 QeiHeQt1nxMgrb86MBSLB9fGQEXK7ldj48cQLcbxee1YxjdH0dTk65BMlTV+tBIKVuHTUxp08
 bz28RxG2cD+rQsUwBGGiONYmPYs3ffVu5v0J306ti4mdqBmWBJOVfkf6LKwViiIdqiFoi4zur
 SVni9dgwbN304Tv/Tu65bJ+nTnYPi5KoJrf5E0xkr6DcovpO74SsJ4Znc9ootfKAqar15diSS
 cwbLeZ7IEVbaO6Zc8GzpMCgoLr0WpQf3yytN4iCigo+csZgETEFMtyNVwyshWua9gPT+lr+te
 /VNJSfIYr1MnUR6UO0bB0I4Jw/1O5ivIvXeqswWYvvYxBcQ2sXZClYjA7aZ08pblpWKLN6dFO
 fSSVVIk+FLd8mEeZSgoBBba1wsMbKnme/AyeiC71Sebewbn9CJZgUvYTn8F4NVNnzHf/gzbFF
 8AOq3vOIJG2B1RJxvmp+a4NBYy/+V7OUmu3wXVjRXEqcaTIGDUakCCjQCmzqyqmmkWo0dRm+p
 ycgexEsE3TO7LxopzB16WJGprCKA30eixCNXiBjWZn9tqEw6gkMRBF6xkorjz31aGeela/j4n
 r5FS/+yiRExytrGlI6UbkyJIGGEQPNQwdRpQrX/Vc5DGlVRB7XKrtMJIcW+Gb3bLp0bmHuaoL
 MWq/qEUAhOwprTP4btar1QN9rZLKtr9QFCEE6OyPoWrPopJEQQtoghLpe0xe1v8lIB3m1GZuA
 u/A0JPUF4O7TJvJukZEu8lTKPuX3gkxHg0GFlEXFmMfIso5uHPxpC+78NJLb/67+sOprTyxtK
 Es1ySywyl7CNpvMCjW3I1M1uEtFzyXdXiqdZwYimct6ECYmTWsb4YW6tsHcUjYdzNH9Rm4M/g
 OPB++kRgPmOxCY3W1zQvyNesjaGQYEoBIgGTXkk2Jn2jlcby31j1gbdfa7Ff8A0xKprK2sdMf
 JdzxkptqHjKj8XqaeLgeCZa4zAlMJB2O8HpQ70ZbnejYyc9+Pp1G2VgKhXVYZcyZXKKIWEMG3
 TJUlak713/5ItPJK7kByy7e9/iAW/eOHGSJ/waYRA/ftMqrA46EmU5aTif6pnpH/RgbhqfQI4
 YB0B6SvzlD0Z931B7G3mwnmNlMTHxJAS4L70WPVE9XxU1OAjRBSir5aHcIqGmgYIxB2q689xc
 peKC6DY3pjRuKeefKhizvzL6De563+WKnVxHyHLDx9RgBbWRlkL6pT9BM2qErnyAA5o0S4llt
 3UaawfSD9Y/ayj+yM1SJ9fM5DMPmZQJdNBUWQgVPh/GXCaXaApyA9mqYt1aaJNKkeVWuqoMEI
 huvrbbI1HxooaxZJ6JIWyLMVk1X6LPJLBKiiwETgHT6vYsKoZ+ufQbpo4YpM+CXU6jzeDt+ka
 nFTIPDDn+ep7XpjhxX8TJF0z2USwE5kP2vMAnUsmI33TPeiJoayLNLY65/WBOay5HsAlfcGLS
 oR+acnKtyxfq0LqIWALSsZtyRmEcYydE9Qgdsq5kdzw2rpo8jDCLDOGc5KEvmfAczoRqT3tbQ
 NI5lt1XT19OhOtBjqWYPV/TfXUiyIA1YpMpIm0NPKa6v6/qVoqvdX0q7z/K86NL1ifKalZXwJ
 neIQtandN/sEB7C+3TdxdHYYFRVnB62Z4RFlrknHp6dt5pzDX/ltlZQS57eaZmzEZ4vJ5APJu
 4juuDvfP3f9OuwsoEQupDwp5gOSQoSRuIg+9M9TQGq+GZ7g/KxAnVt7d7SB/z2eFU6dXlRb6i
 R6X33QOGL4Wj3


--nbtzd3b2lmwkf4dz
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 6.16 000/457] 6.16.4-rc1 review
MIME-Version: 1.0

On 25/08/26 01:04PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.4 release.
> There are 457 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Thu, 28 Aug 2025 11:08:27 +0000.
> Anything received after that time might be too late.
>=20

Tested-by: Christian Heusel <christian@heusel.eu>

Tested on the following hardware:

* a ThinkPad E14 Gen 3 with a AMD Ryzen 5 5500U CPU
* a Framework Laptop with a Ryzen AI 5 340=20
* a Framework Desktop
* a Steam Deck (LCD Edition)

--nbtzd3b2lmwkf4dz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmivNjUACgkQwEfU8yi1
JYVSkQ/7BD60GKc9qzitZRgqv6jNdOen75IdoZ5yEVl/p2B/fZKMz7N8dj9t1cz6
wdHk2xhwWxpf5DxoiMDFO1cMBLWDz5RvYroBJDfr6PrmMqOoAtqJnmsiryHvHPyK
FVZzD6bO9WJb3SWjBhMYMWBNxUIu8jY/NlBGaJoaqhR2W2w529S4pZpcXVtsPAHz
CEQSrEuU10JHX0JdvhE3cz0npm6AMl9sPshfgxAuSOr8HTFSpyvd8r387bU0d38X
HXPFqG7Yj/uxDUs7p2WDQW6w2HV1BYd9Bgi/1dykDzUJ3MEO9iCzG9lkm/rtE7NE
Q0nQlFkLoQexyemyYD2iC3igFFQjq1A2j9MYWnj/MpJ4orZL386rP2oslcr7rOws
C6BS6kPVY+IN59GrrdQ6u7kZUgkbzqaWGYICepR25mrzm2vTYoSAIkxZsUwp4soZ
Oi60JPutKFXcBDE4o2Adzp24ru2vj7xZQ8uj03NQc9nxWD8UH7Sf074gc1Q8c1mm
UwWQMBa6zZW1aW44fEUw/7cAv5QWrgVFggH92qYfKbhbCM2OStjkrfFDPV5qr7cz
ueH7OYTL8IkuysikP7cqsDLXHkgPo40WEbJJS4zgVbScp/mwnRja7iz5nnPXsIjH
QyeYMDOyzF4yMPispVHhB/1HsryEGdUvakptBJjn8VmEVhA4Svk=
=UNhW
-----END PGP SIGNATURE-----

--nbtzd3b2lmwkf4dz--

