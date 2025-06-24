Return-Path: <stable+bounces-158463-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AF2AE725A
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 00:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0CF91882EA0
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 22:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F5B25A349;
	Tue, 24 Jun 2025 22:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="mfWXTP1R"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD1A3074AE;
	Tue, 24 Jun 2025 22:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750804567; cv=none; b=fn3zB0AAY6+GPi8VpTRygL8lzcjxFToVcg8hE6x8+3ZA0ZiPqXWcPYFYIjtTRD8kFCXXOufH3cRHBxYSnazZMErSObk14vRfAZp/ZkJKdJPR++vtNe/uo8lhoj32+pHNsAsCh4Y6BMQSTCu+DKfExKE9D+NykfTshnJXuy3rats=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750804567; c=relaxed/simple;
	bh=1eED4mBxxa41vGVxedCAPzdxMNfIB9r1fcfLhnFfTog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hzVQgcf05MsdE2tcyKx7awuhPg+RWq6umY2nUtbdAlGgGoMlRGjdDJM3CaRXgm4xjBGabVMxDBQ2D+H13g77+xbZchTfYeADt1ejpWgF33DvP/hI0BQslhe3sZ4RDDZgg2rRZhCBLPY7hQTdcLMDv8K8TIzLC2HGRa5Kg07G4AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=mfWXTP1R; arc=none smtp.client-ip=212.227.126.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1750804563; x=1751409363; i=christian@heusel.eu;
	bh=k84MJ9mlpMMXjFPHzH7zdej7Q7ifP2HIEnnm12B0cgg=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mfWXTP1RreVwXcuBH2ykPJj66SnBYfy8ewI7d2aaOeESk2xPCE0eUVQO3WjAQ/2x
	 LX3FoWUgxF0E8/+J4EXu8nx9nBZn9vwFcpCFBwL2WDIGYsW8KxVXSE36Ao8gjcYUt
	 vc3juZQTqKQD32L0viaRiJyJvzbY7GFemswsO55mMUp3dFAYHVsfXUd4RTPYfxXRv
	 ms07ExJzfTA9fzuOscwB0HndPwB45rR94NBf8cgIyuQ3XtyviRrOKEurXYzGfAWM6
	 XfzquxIc2aCahVX/ZEqY4pPUy1D8A5bQ4luymhAOB8ossHDHg7EeYQK+LhN/u7WJ+
	 nATHb/MHJhAlKJBElQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([89.244.90.39]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MkYLW-1vAeHu0hzy-00nH2w; Wed, 25 Jun 2025 00:20:40 +0200
Date: Wed, 25 Jun 2025 00:20:36 +0200
From: Christian Heusel <christian@heusel.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.15 000/588] 6.15.4-rc2 review
Message-ID: <77c62de0-8236-46b9-a94a-8bc68873cffd@heusel.eu>
References: <20250624121449.136416081@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nturzagk3ts5ndbq"
Content-Disposition: inline
In-Reply-To: <20250624121449.136416081@linuxfoundation.org>
X-Provags-ID: V03:K1:UTT0E38s87OzCdAygoU8p56GP4oApCv4yiNnw4v3qWs7Ly8eVk/
 lQzZATJn9BN9GRpbXUi/VJMjUnfiMIGlvoNyzsskp+FpU8GsOmLz9doN7T/VpkNuUnQBG3B
 tpbs+OYWR+MsV9br8o55StL4svvGDUEOtFUGCGiyWBaJRJ+dAw6P8A1DmBNRzwgFAX6dzWp
 ktWh2P2VwUk2iAnfSLaFw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YrarjtneV4c=;vJnEpwAEy0LcytAt9yOGOYQtsQ3
 a2c8iqet12T+SKcWO40jHxi/qQxhEdhVOOpN7gCg0YqRw43srD8Txzt8/kwwFYi7AYmVdMoHP
 gUY54AglvqqIiuJl9hSzlsIBVN36jCc9A7DsN2Qahc3vmHd2i5jSnFkV/etDe8Gn9UfDozc8j
 KMlu6ZzRrHMqb4vdS6+97U9gEtDgQJSbMB+LE7VauqFa0u53w3Ke4jmRxegbBKDqecn7fgABx
 CrupENbV6zRnxHirnBArvqMqcxXzwZ858CRCKizDB39hhatOr8AJfiIKTJAzrtOJgSC8NxQwo
 NotuNaufuu5YQVkPoC87P9hYg700vxOzn86q5OClojv/BVMnI176E9BiMN2UC5mP/QC1uCrqz
 eFHcfnsrJDLER4bG+x7IgxHRP7E982ZyPjQgXZqgew/bw4HDRsBPlluqEaqrP9Otta1wqZz3u
 17OgUJVJs2wngZwaFde/2lQK9BCRFB3aBidSVsQIwMduEq8glJerOLyS3OM90u7u3IaOM5Zwz
 uQZdLkGC2lxcauJMkFNgb34kvDWZ9dy6CFwOs2g9/yrNtzCHghEYz17cwx4Izw39vAkjVZUP3
 Yr2C9ilR0cyZ+8K0TZI4yjQIPau7jXZEGauCBIrZTK7VNS55GY8Ncu1yNU+jfGgIftj0DkJZf
 HNf/VkAPOkOj27Wjtuwysl3xCCv8dzs8w7XWH7qjCd3hPDFy7dskwmNBuqk1pdiD6n1ZH0hwd
 4cPwF6U38XYq/KLi3jMNe+aEK3qKh9QaUUXMGQAm2+0bnLXMTj/8amdVY/IVAcylmOMMS9tGj
 G0Ra1I36v9DYL/7suLe1xz/beNE7ehfFONLKJ1CGg9TA+utSw4zZmlxGxubcJ/7DFdlxKK6yU
 Zcwey/05XhZEok7AyOKa/YEqBtYh4GZM70qtddHydgK8fGn+UgteZZQqENynOEOjYOBSO8lRq
 vNI+ivaspCS9Axa6zrrRzB5HMEvMTWA50cGt8LmHg8vvviTMNph/cfnEs5JQV+swlE+CjR2Wx
 Tm+61QuuWKl/sgPudqDJYQvoV2EwPCEaTuDx3ovoWV6aawsmfkLxDxkMPW+sERCGpPf0+VNaU
 q05QS1ZFPC8vvPLsSJhZhavte4EjISzL7XQqEJFhxLHMbubcX8zITqfXtVQJ6l5YjhzjVVmxw
 u2yveG+q2kcU9nb4X1lqNPHoZpQCHJVpdfSvcwO2/s0RYoF3qvdyE9yKdm0VKXdTRqi1o2MSR
 eZygDOCNt6czoI+G5ckIW2rwFQ76bHMhSjk+tStojulzFedyiiU4HPlzdB7omDMOJJJWr6ftN
 Gi/3y6fXLniGu0hnCuWwZV91xSDl67U+HwSLp8XQx9rDoGRGLQo7+sfqutRmqsL63W2FZ0X0W
 DAFcx5gJ4ayMGdYRu4DdSBx7Wdv+T5U83SLGm6AhNCmWDIn5lI4V+q6GTC


--nturzagk3ts5ndbq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 6.15 000/588] 6.15.4-rc2 review
MIME-Version: 1.0

On 25/06/24 01:30PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.4 release.
> There are 588 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Thu, 26 Jun 2025 12:13:28 +0000.
> Anything received after that time might be too late.

Tested-by: Christian Heusel <christian@heusel.eu>

Tested on a ThinkPad E14 Gen 3 with a AMD Ryzen 5 5500U CPU and on the
Steam Deck (LCD variant) aswell as a Framework Desktop.

--nturzagk3ts5ndbq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmhbJLQACgkQwEfU8yi1
JYUW4xAAy3RZvpiOmTLoN9GNNxzlO8mUorLkvDo/9nQlrTQKVyScD8fDVTolEOnf
SddZR2ozuGN0uPsjp2j/yuQW9qR7ftwMrAQftBmvID3huSqfxMjEq9ukZxACd5bu
ElhniZZmWguGH2JtuVHwIWtnzwyNqMgX3b7zRqMuyQcSwn+GZ09569AZ494Y+IDj
cA83UmeASPS9dbZmS51QxU396GbwaGzYqonDes96hYZR8jd4tTCJmCcdS3d9JGBV
O1OQxTqpW1H1zJODhIGWN2ImVOLYjKSKX/HpZ0nPnausAb+Q12yFbocQ86zG4DeU
ZeKHeGEPJtJAsJP+BFR9CUGkwMgxlzAsewG/5DJUaGuH8yQQlHQmzGsRkzdD4/cr
8AStrVPozU/peVHMovwy/4I0q9OwQzEU50d9LsR16qu3bGcaIIiRtg6iKOid9ygA
Hm0qhACamtp4vck9duk1YjvlWngbbJmizywZOZUlxhQ715t3XcS7b+T9fic+XanO
WoSypOtLK7eyu4RnRYGXg9JrIFEBbp1cX6SxqWjaEnwMMATFfZNgUERfX5DzTN+S
rrR2zbMQnjDZuJcm1P8C+YkzE6z33gqdRW5Ls/qHTSzdddjqj2E8Q/WY9a7RHkDu
oKMLqTdRfyk2rF3vRCoEkUscyvN8Lq9BCI3UtFOG46u51kpkJm4=
=aWbh
-----END PGP SIGNATURE-----

--nturzagk3ts5ndbq--

