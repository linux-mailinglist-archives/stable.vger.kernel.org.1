Return-Path: <stable+bounces-81572-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F253994635
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D59D286269
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 11:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648AA1D07A7;
	Tue,  8 Oct 2024 11:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="fUS5EOa5"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B9C1D017C;
	Tue,  8 Oct 2024 11:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728385542; cv=none; b=stzZ41q/QfCQh1MFEVcUgajMBHXqveAl4RpPS3erdT4ilq8LRkdTce2SIUxugBbYqlFY0kCTXwrYr2gasBYwEW3NMCOJE6Y5MedSxPkGk4He0wI1zaXVhNIP5GbXuNkbje0gF0Al5lr65Sc1H4vsm1KmXEvUPaojMM1q6/pg1QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728385542; c=relaxed/simple;
	bh=SIqKGT+neniNbPsLfdrsPDyN51fjdu4ct941Bu33hWM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=qixxqyZI8zvDVtzspXBds8ebMatTB2+taNibk5P3hdDZZRPUU/GMXSGG0UByTPUckuYlVo193VZCmGFRQC9bg9JkdblBOX4UJv9pbzZQFMWhW+hyRno7PTxAxzctPbIxn9tv1l6TH4q7Ea/xDqtZRc2PGcvd2JRPaRJF9YDcRXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=fUS5EOa5; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1728385513; x=1728990313; i=markus.elfring@web.de;
	bh=SIqKGT+neniNbPsLfdrsPDyN51fjdu4ct941Bu33hWM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fUS5EOa5VZHu5i2AuI+M37kw5kGm7izAfoqhQObLEBsZmZy5n7RYBzYSuSC9a1lW
	 gGPF2e5YUlyNc00wxHI6G+hx8meOWciKYK2VFHUN4n536wfD+9TjFCn3Ocw1Wvt37
	 UGnqqWapiwCAd1WuwBwhzfVrVK2N4sgig9LRKGkIRBhc13G6Bz6b6xj3mnT/HU2cw
	 6dVFaDxCljFlsmzt57NoM9w5fYQPdYYNkIXcBUW7ZYslGbYswsmaQKEndoOmH5yTo
	 y4v24J1gd1qeHpbv6x7XGERv4lglFcFL8VMiDaE/R9bUm3OtuIrgiU8+yvT4Y+NTy
	 1KPT72o4O6/YSA9oZw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MbTL1-1tZOaG3TwX-00bItp; Tue, 08
 Oct 2024 13:05:13 +0200
Message-ID: <7592ccd9-9706-4174-8530-61b3eab44140@web.de>
Date: Tue, 8 Oct 2024 13:05:11 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Boris Tonofa <b.tonofa@ideco.ru>, Petr Vaganov <p.vaganov@ideco.ru>,
 netdev@vger.kernel.org, lvc-project@linuxtesting.org,
 Steffen Klassert <steffen.klassert@secunet.com>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Antony Antony <antony.antony@secunet.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Stephan Mueller <smueller@chronox.de>
References: <20241008090259.20785-1-p.vaganov@ideco.ru>
Subject: Re: [PATCH ipsec v3] xfrm: fix one more kernel-infoleak in algo
 dumping
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241008090259.20785-1-p.vaganov@ideco.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O+REagGZQ+O4CqMfqUOMrun+TyUncCkc3fqqoPj9lx4Yp+MGvO2
 Icl5RgO/c9r5fptEQsmO/H+6qG52sGJfHA2kV+qkMslNGqkCDR2M8khj63YZEUllyamIcnc
 Ggisef4q1+yDu9O+ewRcPxkwF+8aKz84CCoGBMKbKQoCQczJtgSouEZsZT714zz7Ev6dr1L
 cUhZP87SxNP6q3KPN6yfw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Cvnl8CCzMWw=;rqpFD+lsTK36lt5e7wKJ43vKWph
 jZHjYbUVXzA0df5reuB5znyimH+ZXK2Q+XSdlW3kc2sxQG5BhhsmpY7SKupJRoQYYjk9K7nO/
 qR5BL+PCINdcqIJWLT6lbpBdeckj25S9fKvcfuMMGMLVDZQ7cgwVYuUpKyxtRdnJM5FXKgdvN
 x53beQ0FBBfrfUUbC7BrtUiKS7xvTZ9yZ54QA/eaQprphJ1mMRUy6kCBS17FeT6Gy4IXE185y
 dmFtlPveVaIQIHRWeQab9NfQ3vbGE9nPWqEcWlT6VtUkaO2PWgxMwB/seAL3joYAa1un0w2Hr
 fbm0cifXssKWIEPbY6ktEFqJ+VHMN6MfTcVx7cqP5FxnYTIEufqqExrz9Oi0lhZr9RcHBvKFg
 hc/MVnAl7NrUrp+Nt+NAWvCQufvZpf8kSod5HmymzmA5FWYupJASXIvpj5CxQjZiu5Nz2DTXW
 abc6+bLwDvCuW5mJuYcNoZJOYHGqdRt9m2xlkjdezD3DMuAWnGQkfSrWY6Ns+XJX0V9heNSo5
 QdIzKDjNWrRkkQZcTF9//reK/izyzitDmDBJhdCyZHIkRutlcJ64Hj23fKBNNwDM2UezGNkkT
 DCsC+dgYSY+WQ45f+dmfTjtcZfyJ3RnrPx+b2vfYo6qJY+Cob2OIZJqlcJYNIJY1CnfNGt+Az
 RnARlAdepsXz6YjH5dEGzDGAbA4hnzPuQFGc94jmjiV0CNU2SDhJUEf05SuAJ5X3MO7tG0z2O
 qJ/7kP66ZZTXZ8+5GwuXQU5nRJj/I9vN43JoOTQW+ky/tivV5Kf0ORJqCYPDhNg9A4a/XsXXj
 PIzQOyeRZOlL+8lgQ1Is+9Dw==

=E2=80=A6
> ---
> v3: Corrected commit description "This patch fixes copying..." to
> "Fixes copying..." according to accepted rules of Linux kernel commits,
> as suggested by =E2=80=A6

How do you think about to choose another imperative wording
for an improved change description?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.12-rc2#n94

Regards,
Markus

