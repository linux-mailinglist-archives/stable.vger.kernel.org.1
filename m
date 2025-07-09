Return-Path: <stable+bounces-161476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C62C5AFEFB2
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 19:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19F4F1672EE
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 17:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29537224AFB;
	Wed,  9 Jul 2025 17:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="1Z7aObks"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116001E5B6A;
	Wed,  9 Jul 2025 17:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752081626; cv=none; b=HaV0PthqQ+Pw29UCo4Mb95AkSiqiFU0uH1PYl2kUnWuIis9hbSyNxcKaKlqFQkiEmGlXvOM64bJ4Yw7DUz+TTIzg4fhJPfWwpYpmaPDzCtIf32sSugaqcN5irOIQjaCGG7R+68MHYKYKwQTxLU3hrg8vzIkHV0WXLjW91j5+qq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752081626; c=relaxed/simple;
	bh=X5qPewITFNQEpAwzhGsLHekYx+r+paofysPe4hNI+10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7lbtBKlgo/UkWfihT3olQE3m0xW+I/JsP/8/utkfBdax2/zH9g1/yigl9vjMqJyg93Dqsw95rIYsHjlz/rEZlGM81YKguDcAxbEWyovClTm1FtSkSl3x4SMcqy1UR74/0B9jOBsWUZsCouR5IcIHtfQ/xDdXpOO0O/ob9MmFPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=1Z7aObks; arc=none smtp.client-ip=212.227.17.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1752081580; x=1752686380; i=christian@heusel.eu;
	bh=c0IEYQyWxD4AtFpY+qQMDcLFAoe1atswqtNGUdt4E2o=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=1Z7aObksVVF8PCFb3pqEQWFqBqBwIMs2nD1c4yHK+30F7WbO9g0h7/OMMSkr689x
	 b9opYEroow0UisUbULtMqX+GH8qWgf1bBkkGvqzvHb4Bg6L/PSw9CqcfP65QSkVyQ
	 oOqaPFhoADktUF3byKLoKg6OIwmW263mytneGZoaTzs1RAFSQRtHSKmWZNoGiu7VC
	 spsmCpNRa/O8yrsWMt7RQEJnnoBxXeF/vu2hWeh5YdAcbvURM8uzl67bVj9K3nwDd
	 9DCQegBJvkKN6WINLe8mehrxJveAj7Aj4FA2a1ysCeOcW4Wj3irdRBxt3/jaYGUjw
	 b0me0pGe4UZHk3nXNQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([80.187.65.231]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MwPjf-1uqFxZ1Rkz-015qvq; Wed, 09 Jul 2025 19:19:40 +0200
Date: Wed, 9 Jul 2025 19:19:32 +0200
From: Christian Heusel <christian@heusel.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org, linux@frame.work
Subject: Re: [PATCH 6.15 000/178] 6.15.6-rc1 review
Message-ID: <75a83214-9cc4-4420-9c0c-69d1e871ceff@heusel.eu>
References: <20250708162236.549307806@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tnngkyygq5ckjtkw"
Content-Disposition: inline
In-Reply-To: <20250708162236.549307806@linuxfoundation.org>
X-Provags-ID: V03:K1:f9RkAiyKxt0ACuJu7rJckYHMUflUzZLGuynR6Y2E/rj+gO/WWFS
 SIvigM78jbMo2NNw84kIz64MHs/X32xwLUlSQm9wqZLJ7Qf85YJrcpbzcpDg7uKkOsvnpSA
 /1LyOQ747uoUyfW9qF7Z/xk6QxsB6Pg3quTmrb0WPD0kg6tyf74ILA2Pjmv7e9lOB8RdnMX
 0hr85HNm+oGJ1LNdtrBnQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+E3u7xBLHbI=;KkN7PRlJHauyfFf68byveHYXcgK
 bQt6fJ3g+Xu36JXRUyY7Cs3Aru4WO3SyfL48dnl+ZPdGfqjsygHIS6m8KYDfzYO9NPYmkCCYy
 UGtDnUT/mtz5hy+JOGkMN6C/zIUDSrJFk/7BK7pjaeO3bVKqyHRz8Raj1I3xt4u7gDRHVUYxz
 mvnDV7J/M96HCLFzua+90j6zj/7wHwxLDmFxosQL1a5RvE1y0qR+Qf+2DAWiDemKTw6Tnx1IB
 jIcrl1dgNoHSJvpdY39CXjnufWn2QWGdScVYGs+Uuk1/Fl33OsPmqkl1Afmx3J9alsqM6G3YL
 jGtAxtFi/JfcPDKCp4YJf5DzdmY/h7f1WEOHeFyBeXeFMD51iUvrYch6VK/RQyZIvWM5Jxi26
 uF9rAJBw67Ph8MFeBYqhbwUFQj5MOWFMs+iiFNntpSZKSixpu/PggAIDVe09o/MlPKCiMkwJT
 9NJl2NwXbCZPm5vYxAe4eaGYmQSfDlFnYZsvB2Op7kYBSpr+i60ZItMrXXbnxNuw8zbupBD3H
 fConO3HrOTd7LA3bK1NthmTqpakffAFc25Bsz69EeV1TxKu31+OzUPCJy+LNG9dn2zEMy/wow
 VF6N7lBFtQX4pi3KaeUu89NAWn3iBIFYtbFSQU8IM+BW8P7lrG5rCKF6W/WvHLdOxAa3uB6O/
 RauMT/+fPWsO2ptBiM+pNZ6HBBnGPtfYOXm73rx8/QL6dFywqBTcdUdJDUHQ3o6pbAZaORv7i
 oebQ3CcPGnd7Ele0Vlnu9KfTV6q1BHCf90D7XV1USU9RIGrzH7g3vxzT2MVT9Mgfy8Usotqej
 HIocxdRc1mhXCpMWhi5IuysWnVozhbKwOKT0DOuJtUmY3hLn5UUzVOgsxpJX0FB67lCHAumIi
 i1+/3r3i5Mf24jUX4HPKkYbZe7XG+cmcrf9mFUMeFhJA86eKeoQDM1bJJqgptFznM/KTw+O/A
 c/nHke0C6N/6Np2AW2W129KhNdcx+kCrOc7aR5eH8W6Ds3KV1OpIwnCKShAsmtOSC1Qi00mIL
 ROHa4l6W1hiRsZD0i7hz4KDiaW8z6KTiFJLIbpinlT71qVUG73OChY05iYLTk3bURRO7DLQNw
 YRkyvSwD7vAEujxe1VkYpZ3ZTDkTBLYWwC4vT19nwoi6UQgK8rA74skk3SvRDYBNSX2wTQHp1
 KP9tkxGSFgrAObVHxGSV5qh4CJg9SpRtM8H/lbU/l3hVpP17ObCJOPyVGErXBls4GDKAmyrmx
 hjQYHC0a+BKOWJ5pG/6ksgGiEBlKi7dw0mSTGfFqP3iNGhtnpM8qoWs9NlrFfVREC1xGdIsIh
 zRdcDidaJ14OUOucYwgsSVQULXXuSIgvcUFIndDSYBFiCxZ4mZncEMLt3ErPMlQOb/aYaKZRp
 3Ceo3ipYe0LORUws9UJ4M06zIihVvzFqcOGvIPlfGdhvXuHjHzWx2014hn9uQriCZJzIUp591
 BRMeXX5n7gx/uc/rrum9hBL6xxHDN5P/G7IVKjzsGSS2n/tvkSR8KfJxK/77uCXUPBoOSpxJb
 j8UKklT/CB9RLjjYqcca0e0CiVJpyc3lui4Kc4qtau77RJ9Yo0jWddvaBz+jHA==


--tnngkyygq5ckjtkw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 6.15 000/178] 6.15.6-rc1 review
MIME-Version: 1.0

On 25/07/08 06:20PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.6 release.
> There are 178 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Thu, 10 Jul 2025 16:22:09 +0000.
> Anything received after that time might be too late.

Hey Greg,

on the Framework Desktop I'm getting a new regression / error message
within dmesg on 6.15.6-rc1 which was not present in previous versions of
the stable kernel series:

    $ journalctl -b-1 --dmesg | grep "PPM init"
    Jul 09 14:48:44 arch-external kernel: ucsi_acpi USBC000:00: error -ETIM=
EDOUT: PPM init failed

Maybe I can free some time to debug this tomorrow, otherwise the
Framework folks are in CC of this mail.

Cheers,
Chris

--tnngkyygq5ckjtkw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmhupKQACgkQwEfU8yi1
JYWKORAAg9XLN+v3Zg64qslKfwTNySut0W1FDVCZlTOn7jBlCqDgUWcbqffcyGkz
W9y8tthHWtXDAQMVfs30+TWR9ONurrtjNLUxk7zbrEPx+S2p1QZXspRU/daXhLmx
Yp4REnPlIRrdTubAdJH4jC52ra9YnFxLsAQ0Vx0BSB7ZqhztH7Hi1NgIq8Yd8qJV
yp6R8a2bVRWxkAXoIScog2AcOuuJNyHmfCWOzZcdEWQG5LE691T1CKfHDsCgO2Rn
3eG9dGH8I/zLgle8JGM3hZxn153CIBNRXPvilCl3PlwuW7ONKdWzM4YGG6wqxYE9
PZWsAH7ERgHZqBFIOnBmiWEnTHfj6uNz77mGVsU6iXCHVKE7s3ewzTeFbMs9aRe9
yo5X5zU2mEmQpbkzQSZvRYRFki1I0XAs3qzUTOb9WrIyAbhfYHPFi+mW1CSgvxss
XxBfUbOt0OqJwoZWL0K5sBVbpFRAbN26mEu3ag/sV6BiIIvKYAMVLFB01le4y4xW
IW9SRIg8cIdGcDD2btREVe0PJM9WpGoh7KtHX8/vgHtzi5ljtJGlhz8uPyendLY1
CS+iVwt4Fu3rweXuugb07TVjePLpFE1sALsqA0W/ABYzvsf/FuvOoTcq3pFrH7a+
EO1mdo2kjDG2+j5nDFoO3hDM7CONaBjwehHC4ObtCUNqWcA1WEg=
=qFiL
-----END PGP SIGNATURE-----

--tnngkyygq5ckjtkw--

