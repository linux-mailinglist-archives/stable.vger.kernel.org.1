Return-Path: <stable+bounces-181791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0284BA4F8E
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 21:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A734388177
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 19:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D61827F756;
	Fri, 26 Sep 2025 19:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="tUtyt6xt"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0365F231842;
	Fri, 26 Sep 2025 19:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758915329; cv=none; b=rtCaTtaoznKjExTL5w1FinrifeifqmrVoOW/w2rIkOMA6I47X9ktFc30HJtwAGlhbBTxR/AWes7U3lofITPK0y2be/H9v4ZhIoxAwaZYTQXA7LsvHI8a9tS9C6T7+e2jSUUlcbWDEp0m0+Iyhhni8z12X9JeILyDD7vvb2CX+Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758915329; c=relaxed/simple;
	bh=Ez8O04TVMHIRGCKH1RLZv4FTMc5LUlJ4PfwBFQ+HxN4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=VpF0lnbYB3OZjvTjzyRCshWAjBuMZ9tSt6vdbHfDe4VIittHDC5SaaUp6DOWy3V+83oQLHZJWsiD0nGVAlC8O/AFG5cNJT7Cw3FZBLn+wtWEIhowOTZ1MEhAn6I4Y3GAPRLxCmWhye1fWbxqNZ3+UyTb4vDHjkHF4cYreeR/nLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=tUtyt6xt; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1758915314; x=1759520114; i=markus.elfring@web.de;
	bh=Ez8O04TVMHIRGCKH1RLZv4FTMc5LUlJ4PfwBFQ+HxN4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tUtyt6xtS+9lO4W3XNq3vQOO+7YLaq2EHga6Gl1VjnpTUQmtdylPaJEnluzq8YvW
	 gjyev7utoICF/tQTp3+/zDn/sit3OuFYga0mwKzjLeMVFvHD/ew2/5Biem9v6NKCh
	 AFdppfqfCp3vUUGgTJAc6FTKFMJeilmTBBAm0GCs0pqdlLanbc6GLuY6PcDPLXtDk
	 o+EHCV5mAQ9FxQWzzWsZvoR8v0zZfdvmInUxe9k1VYuHhijRlvxH7lbNJ+dgHCkPo
	 cMjV4N8vxkQz1Q6NC0bYxTnyKnQmVr3ht6zhJMC+4drt5yjDLT41Lm4A2hoG0v7B3
	 GbW9eb3fnHTu/M4pHw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.192]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MTfol-1uuhHr0sZR-00QLGK; Fri, 26
 Sep 2025 21:35:14 +0200
Message-ID: <83091f63-9462-44b9-8089-59af596cc712@web.de>
Date: Fri, 26 Sep 2025 21:35:12 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Johan Hovold <johan@kernel.org>, linux-tegra@vger.kernel.org,
 Jonathan Hunter <jonathanh@nvidia.com>, Russell King
 <linux@armlinux.org.uk>, Thierry Reding <thierry.reding@gmail.com>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20250925150007.24173-1-johan@kernel.org>
Subject: Re: [PATCH] amba: tegra-ahb: fix device leak on smmu enable
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250925150007.24173-1-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:19Rf9yaobtODFqmWWuVxvvKspow1H+UTU7ocfaS8qymEz4oMBaf
 HL4MDvs40stb3P3oUJTpncDEHt/DPynzh+kYwGHjaLaGlfzzNPhb38nWsT+/7DK9PlmKM/C
 zkgNPaPW3OfBNnuTQi9Yswp36r3C4wXlOYo2GJBrg1bSKV4Ds0v4R2DQSSsly7rJVjL1sj9
 TdZwg04STyNoy5wSTPCXA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wtfFQD5klkg=;e9KiydikxPm+B4upoXP3n8X+wZi
 6oVwJEaLu/Ja0OA8BST0Am0oAzZIcWR3SwT7puXPtpcFnP4cymtRTxZZzE+Lw60Gx/aLw1EF9
 XzAeImdEtII6+ObZu9w+vJptnUjcTeTaOyFuWCyyk6pxSn0bPjOnDqcDPlRyopJLENnC//fc6
 1J0b3dy16kCDN97uiOH0zWzR4rpDDCmcjq4xVXUF5ccLLT8QdqYBp3glD9bsBJk/wbKJleCeh
 PRVVYERLQh83XQk3BjA07vup70V/AaN7J63u8TqvpcaJY3t5IQZhN+cS02ejmRqq8BPCiSpqN
 N2tZloXEzmSaTGsu9TldUHfSBI5mYL/aRE1zZTdOs0DpCgbLHf2EHP/wfBirEZPmMRHzcL6t/
 ZBI45frWzY7ZPzfPhfKLQlQeQsrZNGeld1KJB00TGboOEWIbfNlA0ioFgPk1+2ttS/xWHa8DO
 b4C0MkrgZEdUDyqVvHYk0tPMX8qsqlka1/vEUl0FydI0YfTNLtIOYI5aKQV8RYqBhdaS1bNlb
 ZHlwBlfuEXqlxOSJvwgjYy/y702U1xPB5glBa93FFEDF6VG6X78a0n5ZoBZmu6Yw42yQDCvRe
 9c16qJtZ0ANxzdQQwrLi/xQFt21BURfChVY8KdJ90Rhd4/6Yt+Y+IbDZhpkibZ+a+21oNKfTp
 eKKkkuL5/HblNiYSJte1LWWR7DfrT1Dp3dbOwNzDV2fMClHbTNr0cSYRRfb+EBEUxuTX8n5yd
 f7saS/b7CV7EaNGdfF60p1BYauspd2htEe5yqs0ZPJ5PrCdXnj9kx6ZJ8iDe7fu24C8d7/kA/
 mo6zVMYf1WfviUaRlmdAbWq7fgnt78X5oc3iBrxztDN6CLnCTcefLYVQwHJRrH9BR7swr2RTm
 oxoGGCts9F0YgyLHKqMVw4RpChe67p8qBao6Z+zJwCxivYxnnJvWbvxzLEpYRMhg4Y9sJeotH
 jxrPg9KcDKAaafy5bAPCi5xJenLnB4zY6mIgwuZpRem3aM9HDe2B0xW7A3HK0fXz3R9gUBU4l
 gj8V6D8wHk9GGHjw0BJbvuxSIeutXQP+WfTrUNRcPDo/De0msMULdAwz7wHVH9xIb/GlQaCSG
 1p4wqS7IbqlSKAP8jzKnZn17PLNW7fiHPz2iQ4zXhNdCxjiByrsrJm3QB8dV+bw61CFUUg6kZ
 xRV/GQ+weSgwPs5nUpZIHqmkZOkyhfjhyusYHJEg8sgi+5/kAk0e9xUloZLfK6gf4LNFynfZj
 ZP7c2oxRg+cp3zhSHclSSCo3vC6Nl9OAjmUsVui+z1FT5i3jdXdt6oYEeVSHYhcPUUImbfJPK
 ex1flj1cHaoZXOG2CbjqPHjcEzYH7j/pzEt0z1A+FzBSiO/u5xVLqMpUiimSCArEbhfRijHW1
 PBy4ioHMZyp7bRWm2yJJ9eN6l0mC8DAKW+RR/oAII5pw9C0oClQmKx2fGJRSQ14Gud6eUUmf5
 0psHLvcZnM+Y90ISJG80p3iC5+zqrwbVN/u9W9f/hXA+/KYv/Pd6pNO7DTOkHxfYNox1lSWBc
 xHLGBZO3QzM/P23VrvWsDFp/h3S5XVIDxNhwAwx3cYkZaz4mV9dXm37JfQm6+T4n8EBroUYTw
 7HmmK8A2ODa8uLYs+5ANWpULm/nL3TFivIu2DwCi93UNPL5C0/XsGWDw5uWzru7JpOSxMvYFA
 0WzIq4ZPkLtMwl3VI89lr1I1kr99SVfNprRDn//FD1YeOJuGDn9vey5vbr7iuiRFCKteFeYwb
 luoAQ+Gzy0p0TzXQ0rZDOqOIjczM5GtIBbNQ1qfgPpJUuAV/rXEP2lTesvs/vT65t7q/LufLy
 Vv/lEhoe7h4NjGvLhbjPZBIv8K1tXykLJEWBr3f9drZjhInliqvWMEnKPXY4GDOhjNjMDB6YD
 g61c9mAFL+RuX0zEf2QAX4qQilRmc01NMcvSlo1Zs2b4tYpMZcDN/+Dgk7dmPE6cKIu3gRTWS
 s4kZJ6YXM0nJG9v3bRyTBWsBrkd5qvGLOOLXHGqqmSljs11xwfNFDz+5CwP/Zyw6E5Sph/g1f
 nBdWyPTI4JTRQw2GndnpVSd1QMwSqBtnkF3bCdCJzg0mLI2srl7A6xkpQEXMbORk4GckxV78B
 AI3en6qQyosyPv5Zc8gnbUQYzxnEtFuUwhOHePKuumwaoth0wq/Lh9Loy/y9m5NV6VjiOtI5s
 lY6WV1hliMWBa5HT+eOffBihHbNC13soi6rHFbZRBJXe4bKpvMIMQSvtUxq16oaRslA3FrrSp
 CoBsC1IAsrJj5MaeKUV2PW8E+g1n9aY05rqN2MwgOJvM6qftJCDzqT0CDPq3EQjWl92CEUzf2
 SFbaN2bzoatEhpgLQFwIARxgiMj20QY0KpKqQOHuNz/PGTuhIy+s+RFdNzqxDba+CBoMx1Kbs
 Bdh1ciakQcb7izqjoiwYQw2+ZXhuTIXQjdwTGwBO1CImHpAkKgKvFghjxCwjoWKzU8Y1u0PXK
 C1fmh6jk1IqdOz6g/wmkZ8ywlkk5XXRblz1+NFTNx72isXSH+wJYvpQTlG7iyXB3coZKr+cHo
 mds7VrLDDW6EboyAEQrdpjCxCB9PFsVQmEQPPRaQqEDTWCD67R4nBpFzOZoMJYfeqFZgwtsVx
 dYnB1N7+qga7qmdTjL6U2j+BQ+buX1dFHd6/CmNh9OucPtAVtFoF6WiUBp7vXooeiIWEiJDAx
 vHGUHhUyq6B/UpYkhvNSVcPlN4BcYhpCtPh/HadmOhztoXiy3yTH3vUY610xaqV9TuUoR4hC9
 vqrVJiOJcwrkdqGOZQPr3ao0Sa2tCQLgMP65utK4TKuPUKGVraVxhOwSsiaz8Kg5bRAysjy2L
 VLjoEYUXlGJFLi7ZIso0b6krmJglrfzXdW2iK63miMmZhTKf0MUruVlCuhmu50Rp9Yq31O65u
 VVQ7JXq5vF1leIO05TauYOtVnT1xSLAzWhhU2Lz88xfF5mHiHzwPTggIZI+1DNohmo3yRKN7o
 1q1uPikrJtu8JS2NTICxhHM1UmjxnffTq0eqWVlDXEdVEFr9YPfQcUQ2EFxXLiO1qGiT2THkS
 P4se8PikWZB33lJkBuHL6XboNf/fAix5ABRXM8WIM5PN1JvHId9Ania3xCj1VFSXMA9N3dw03
 ink6168qyJ9v5DLzVbRadzixZNZNm8bhIwF0CK/zfcXqz3683bGZJjbMbWRwaMn3ZlloWL8I2
 VCsxH6/6gBS150MAmeECa3MgpRuX8XMwtfz8ioPQMG3m9qaxHKrm63YMmla/2R1VNrqURbEXS
 qnHtUEozTlSsXf9CU+cDEPKbTMU1O9eWjJxwEKIMqXystZLhIaDKTWC8C3sXvD+1OPse40U5X
 dbjFGQsI0fg2HMlusiGcfz5FPozJ2APn3GRlf/lMa+/GV3C1rM88gDqv1NyhtM67k6qAVVyVY
 zLZY5DiGB7FNEM74Z8Mmnh2CDrRDmS3IswOpsXrHxGiTyPXMLDiXCNvAzBiTB3mKdNnFKo17j
 zqTGNfV+Citm/5Gmu5IUEZJF1SGM4QUsIR1d19ziDjQvwl9xeWwcjQgNSOAvt+b4AIysUb6Ht
 CAr3Ms4YCK0lUyOYN8Iwkmq8ZuIgnwz6+thdqYpKKWBzwoo5jmC4pGIVZHnnGjiEGv1sDrC5Y
 ngWFcBoPSjZnDywsfahP95MHc8GznMUx5L/gwBnPo32so2JSJ8pHIIKVTUhMaNcunc3VHmAUK
 0cskPmKo9vnpjgqe0zYqybuMZp+UqZlgBCDlXNw+jr2D+A7/4Ud3patrPZMkVUoCg4MxMPR+z
 UK0nU7kv6TnRhhTyafwYc0fuKT61Yrba0NXTLZF+MI+XPva014a2ZNYK03Ywpb3UCjfUm+aDk
 tFndH79JacXSOnWnaT3iXqjheab45al9+X1wsd1E5+WH4QkgVsx5gu8UF8jlXfrQAWYKNIB0Y
 QuVl+QitaUHTJomaZPaw0BmEOtpl9kIf84eRMD+y6te0776ckzTyFUIcV0udaMhRSHe/hWfoe
 xcIxbnV+X02cjTB+Ii2ZourQrGVWI2d6MUHN14cpwOgs1n8xdvI55mLGa7ASvUqB9lz1o4n6N
 6E07cIwuvLFD83VkkdajAJjOiCo5H7OTYPr6GGtah5mobS/aUkfNsFT/Ky/KzCqhbtZKuv80K
 fYpUMDxPsTB+hXu/RUSdX0RY2Kxdxxi4oofigoY3OMt7gEyre4xUML0EuGIho/xCcKV7nSObz
 IPZdlL3TQSbml/eIPYOjGMUYRw1j/HIKhN2lh2nioGAvPIwXB1h/mqT+HbbIPCmlyzYj0RRhu
 7oP3IKuNAD+XP346+QB9x6hSYGohHpgYigUJSrRWgDCvtu/oDhbHomq1YdzdVXWB2Bj5Xjiub
 /W9pI8PGRC1FI0Jqb/36EmaXLFpfgE6klM6wlwr1n+ihSeTP+eg7+Mt/vNPw1SkcZQAChzy12
 6LRZg0g0+ROlQdrz56G+lr5QI2QRkbVTnAG86tdEtm3750tpULYRJ5iG+iHmH7ffmEhZTqcr7
 jt0Ul5JX6b5PXl4XReT2G5QLDzU5vU/46BR5lczswVegm9JcfHc7yBDxi4aac3YcvrsYZn9+o
 OrrWHBWx4P6thBkeIe3/aBGOWKuGO57D4RQcatfR712ZS0RiUtCcublcDvt+ATtvyMJtvQtyE
 rwKKCgLPo3VDOX0ZbBebV5FtMdjW7HcnH5sn2YQ3Z/5EySrr7Kqmh3lICFEGGuelmX82rWjp3
 o3n5xr17m+rnM3mG5eaBgkseDwTtJKCfNM9S2NPkasCP0hdDKiV1aNCmTE3cTyEoguTI4H0og
 ZjTNvu0B/ykd+ggIWN6WYWD/2sGPFmaPJwQPKlpOMY469Jcq7fyWLJOOaCO1FG5uC1g0V0zmA
 YRvqOjPfdUM2DUm2iimdh5PRAhzEOZTI4vuSj7vHpPwsGmDaBjVMAUmyDdvFuf00MS8FIn8JT
 KsdG5z7rlo0eFQ9FNKx8S8ZaffHcWnQZOhODTRmDKDhUENqTfkNEVmWKPDEKFfwml

> Make sure to drop the reference taken to the ahb platform device when
> looking up its driver data while enabling the smmu.
=E2=80=A6

How do you think about to increase the application of scope-based resource=
 management?
https://elixir.bootlin.com/linux/v6.17-rc7/source/include/linux/device.h#L=
1180

Regards,
Markus

