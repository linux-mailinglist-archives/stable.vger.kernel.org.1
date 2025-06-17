Return-Path: <stable+bounces-153806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9481EADD668
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B781A7A8C44
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EA02EF2BE;
	Tue, 17 Jun 2025 16:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="yz6OGYb4"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B2E2ED841;
	Tue, 17 Jun 2025 16:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750177157; cv=none; b=lffdnUp3c+SJkSh+hGHAP2S3R4TXPg4xufwX3tta2r7W96aOaSUC4UwiDVz5R6NcOQYmaLt65LSvmAGi8Ur0z0kJfTM7UTE5skGG+0YsR1V0STwhqcC0+HscL4Y54yLnj3PW/58p4nIRJTfLaIL7A/tiFpp87/9nJLtRT9UsSeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750177157; c=relaxed/simple;
	bh=odXfEf04AblCiwtd5oaSZsRjpkfGUvIS3F2wdch70Ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nF2q0TIfJ51G9mWxXB9HJbQMPzD8asZYShmg5waL2i8hL/oyRhazlz0gTsXvcQ5KvPNlcEd5DCurBnN5e5upCDmLmLkqFbKUv15VRzPYXGz7YHWEZn6Xc08pCkt/LzarRfGu2pbNlxrCYEUjTmGfyNgOzwYuykNqWG0apqpZQH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=yz6OGYb4; arc=none smtp.client-ip=212.227.17.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1750177153; x=1750781953; i=christian@heusel.eu;
	bh=9kwaX69BYlfOgsIpG/Pvl71vvTAMGxrM4gg1LwJXpw0=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=yz6OGYb4A5w2JEvZGPXWy4kZEzMuimbhJF8QH/dnAgYr0ueIL5E42XTpqBby2NmK
	 3ZrA77J8tmQWiIWntciNQjIbrL72UjkbdSq4bd93ASnzsCWNgV5Tp9f/ERSSzo+/s
	 dtvboIqK51jk3EG5ld8vRcFYEOCq14yCYvLLaRKemIGNYRbvQWWTKtPS1tP3ZgG4l
	 Q8XbPu+LBX4yqSFYJ4MtAW5Lpv6h6zuOsZFWEqFBmYfMz2SD/pCid7M7+WbKpRYG5
	 Y9cdNPf3a0b0D5W25cOQjAk8Vk69ha1rVlGnzKUsUz+458ULsooPNhLfZ7UfqgDqF
	 w9l6vZa9WZmgMr03pA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([89.244.90.55]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MEmAX-1uYSxd24sd-002fsg; Tue, 17 Jun 2025 18:12:58 +0200
Date: Tue, 17 Jun 2025 18:12:56 +0200
From: Christian Heusel <christian@heusel.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.15 000/780] 6.15.3-rc1 review
Message-ID: <fe2120f7-8839-4a0a-8bf8-70b841a8624c@heusel.eu>
References: <20250617152451.485330293@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b65wpbro3ixgg3e2"
Content-Disposition: inline
In-Reply-To: <20250617152451.485330293@linuxfoundation.org>
X-Provags-ID: V03:K1:rkeVi0aqo4aMzMglbOeMMhlCod2mVcFqnJiyVI5aZsidvr7CVy+
 5Cf/EVtrSMO0fPlek2bHC2ATQsWbao9hZsr2it240brdeZFZs21EfOCRztrj8+FZ9ZWuO2A
 akM/05d55SFX9Gf9RCSfIc27eTExAMwd+IDbR+1Q5+EeiWJqMfe5IKm5dZle0AkPFmu1gV4
 CXob+wKERhI2lgWvMowqQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:J0cjcYypcOs=;1Sh7VcgqT/rN3rSuVTlxzOlEnS4
 NwrreWl35/LQyRu5+HiAOHDZKkqLcHHxhJZ3eOBKlRAZbPhzxUq9yV6YRNusglGeE0hb8hINV
 zomKT6o+GUN2gL5YwN2flJen/32aCHIXTSbCNDYUqhwZcv2OSzXyt6s9P0wkyorocMvdxqvAA
 CWmvSvzcwXmPxI/epMoRmaQpyGD9SalXdSpdQ04UBdW8w1TxvQ2I671Czt05KmWV/i6jlVDH4
 86sZrQLOhfEaIA8gD9pzNEvFiHkSn3eLS6pkmFRbYIIuObaztSoI3QRCwavzKZncGa+4KJDw+
 e1sNSRaBgYNEJUqBxqOR3+KFJmGUmwkz4Lr8FjtyuowJtcEXaJRKC4qiImN3t5L6+D6Qx5AEi
 /M1j16cQX/XS2qIPI16kSjiwTeZYNlt2PCbH3UbZt5F7ORomXQlRxge1Oh5R4KVyiMWCoG++m
 eFzGKtQxnVQpyRGrs8IKbpK4j1TavEEnpXAJBOtqDXWBzYyRNHWfIV6GUcNk0ci7H0BkW5ImR
 d6JrUc5/qrxhi93+/UwUntUm5MFeF4qotnAeGsjRY4szEJmXL8jrj97sEqp+Q/CrzlJgrTqb2
 1zJEUAuUZHq9heLD+QjkMTxtonyg/xAYPw19pnmobQmns692qMeh/dsCrydE5eC4XdnPHbilB
 /Jw53YUwOssQcGS7vMcOYBnyOOANwNFHMzblyckp9nayC+ksgwfvwf0On83oT3EOgS6pzYtpP
 MJJ81HYKSTpGtKdTCamJoZJcj2Xco2ztZsiLuEwpPCMlkf+tXvWFck7fakBKPpN+3twanoMhN
 MKmWsN2WgnzPX+Enwzqy64lN5+rwcpL03cTfj51GHnagwEKJHqeQ7h9bo23SUJkatelUYig9l
 Vl2yetg+qHh7xGk7ZjLkjyphoi8YtrDjiP/g2S26CcxOQZMrZhsxtvnK0Xq3qfkjry9j5RBSZ
 jRYtRXt7RMabiRqr1wexm7hrZEmfmeboUjeAvVN1A4yk0y4aWafQVEdtItmxHMPLwrzemNcoG
 EkNqDZXR8kECFECm1gLjlKlCeknFTYSFErLAlqPgKrzjH3neLXy8E/Szs+YoGdQdYrx3vhb/U
 ZDXVaMGHjJxeawrOX3XCossv3H5gipwixV6yMnlsrXZlQBnhbCNMzL1Jq4U2XfDkItwHCGH4Z
 PgmEtOGUI2d0rpjjB34yFz/fNQd1FF8xBOCC4+WHmVkiukb6KL5eFMXxNS9xgIJWEbQPaNtE0
 31nKSNGie6laJb+VydTa2o50GcGSRMi4IziU1lvkWjO9GUXhPxOp3imph5UxjT6fFXbsTFySl
 yXk1SMU/Pc0nN4WsmCcjz0TH9o74d3PisFcgBZX8yIVOGmoJHozibAoHtqgtTliXjeVBhtB4K
 Q+RxrrdCuePh8EHaawg7zt+R+rhUV0e3Xt3SotNbUyqeo2q3UicXVberjP


--b65wpbro3ixgg3e2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 6.15 000/780] 6.15.3-rc1 review
MIME-Version: 1.0

On 25/06/17 05:15PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.3 release.
> There are 780 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 19 Jun 2025 15:22:30 +0000.
> Anything received after that time might be too late.

Tested-by: Christian Heusel <christian@heusel.eu>

Tested on a ThinkPad E14 Gen 3 with a AMD Ryzen 5 5500U CPU and on the
Steam Deck (LCD variant) aswell as a Framework Desktop.

--b65wpbro3ixgg3e2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmhRlAgACgkQwEfU8yi1
JYWrxRAAr22WwpGat0STLhfFC5l4KRlbFOPLB4jgZV9IPwkgK4dAL5jSfLxJxMcY
0EbBI8mo4+Dn+A4N24VMy7XasicUdtg/48l5ImbyHEveZhWqu9LxtEg4hSEc1hLp
qV3XaMGQ1BnYzTZnUsYqywJVJQylytUSjFIhgvvAALg8NYSnzGNQJ78U14sQjx6y
OIVxucmlhHchMoRcPhrcorxJuk0ui9FgFwejpgyZ8RE+x1l/lGUGX9vm4nqQprgE
xxd0H7HGomVh427b1i3avDDFu+k924McKQB6NVu3vhXmH3gd6pmHff/D2EFc9ase
ocP9JJvH58I45PRLG6kOk1cxIwyS8h2G86/eiIcnttE6xqD/2xOj/J+ufyAdkMAe
02r4F0oVtkZaYWLM/hgEkXMBkn944lWsMNQoFUPO/WcAM/A6+SSK8AlDgoxiprTK
9uuegqCh3+8/E8+dj8hOpg8m0f43b6XULP8EmD0GVDlWaUCqeMpyBYes97wifDhM
he3zfH8R+2ib0z0zeCjQbCiZYD+uwafC601DWOwhpZiPK4K6IMPMsbIegJhDwG/d
YgzN5CZYJkRq65jYDLl4vHwVWq5HjBLgjPNew7/ul5CoaoaiUO4y6uaEub7LWGvG
Thp3B8M4PC5ZnvFda4ATaMW2nVrbg9XDCIc7CuklYX8uHNhv260=
=8EQi
-----END PGP SIGNATURE-----

--b65wpbro3ixgg3e2--

