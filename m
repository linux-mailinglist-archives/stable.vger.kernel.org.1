Return-Path: <stable+bounces-121443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAF2A57177
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 20:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ED1E188C5E2
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 19:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81372566D5;
	Fri,  7 Mar 2025 19:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="oIbAT696"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103A6250BE9;
	Fri,  7 Mar 2025 19:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741375108; cv=none; b=tU7aHxBt6BBWLj1DSRXv+qThFaBEH9YZfhCbuOYvgxDWZwmbjXe3CrJItcbqGbyROmaUDbZq79y0hmKzSoTpfAw1RpQlSwaVwJYxaf6xoIbbAWGktIJYOv3mVwOHSpfG+dA/g9C+YdngoKMF9gwUtjY6nPowHu/a5hSqhPNCf18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741375108; c=relaxed/simple;
	bh=XO6eoc2L9VIlXdKSv70QkK1kPfBWdjWFGNB+o6b0OCU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=SMyIJGs2kSzU2fDvAQKwdpKB94FSERIx4IGMSBGZVkOmmtAhr+XTpSW1r/QqMx/p2e0/lyWsVsWHbM9snGURfjb6AcaluPNh/5C87G7zFFRB65Xf4JS6jE6w0A+/vxch+IsVbM0SbBXTuM/fMMVTllYkUcEz4LE9MyNtZGGmwAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=oIbAT696; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741375095; x=1741979895; i=markus.elfring@web.de;
	bh=XO6eoc2L9VIlXdKSv70QkK1kPfBWdjWFGNB+o6b0OCU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=oIbAT696x7mY9H7ybTZVR5vKDZso+TD7pj2OFyEgNBB0n/yxydp3qmuIrvkMyKfV
	 0i5FoQcnpiH1HY5xO4zIJiu8f1MM040f/wRxeTKHuyP+ur+lXRUJs//nFEM9j/xRJ
	 cmaROWKkItt3aPZe4yrFA/zS25o8u0D2skWjnG11nZBm4lzY/RWvEnmzipXJdAbBu
	 3NaPHdaUAn/kp2B7oPKFSpDhVc+kHvQFOFUifCW0A1RQm6PCkC6ix0EZxsOhap8yh
	 084h3qM0QVA3qMCFkSpksfTLwmui3HOqSe+3BBTWL2a+KJZuvN4XYy788nN6zH4Nb
	 QOswN2hKfj+5FBLIZA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.70]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M1rPI-1toRLz17GK-007Ua2; Fri, 07
 Mar 2025 20:18:15 +0100
Message-ID: <85a61dad-46df-4920-bbff-7f500ef692da@web.de>
Date: Fri, 7 Mar 2025 20:18:09 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Florent Revest <revest@chromium.org>, x86@kernel.org
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20250307131243.2703699-1-revest@chromium.org>
Subject: Re: [PATCH] x86/microcode/AMD: Fix out-of-bounds on systems with
 CPU-less NUMA nodes
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250307131243.2703699-1-revest@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oTC+wNwkr78wPpL0D7N6au6+BRYDOflbySeDqknRF7PnWunPgw6
 n09CEbl+6yOcQZr6tYINMNK3H/klIzFRyF2ZEX4XzLPmU6o2PEBXXWG32D5Jh5gHq7yOVSN
 e0jaDtKna87wDe3oGfS6JN308rk+pIwDRVKkyLNo2CpDcLAfql1/HlkajPHfzWXDYWoQXOH
 lOaHR9jpdDaoF2+xT2GTQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:04z+TJWa0Xs=;eqmRtTFiaJAo1iFFN0yEKMKniBw
 +abQEHIRPmpTG0VyjgfsB5zGISY7droePnaOD2Atn4YU25M6fO268ZDeVfHkHkp7LuoBEpf1I
 qwIH/nqAbaL0Dm5jEVN0VoKB+NSE08e4Ak1mhC0sSe47pj+I1S9sN8msAOluy3h3EmPUw+WIL
 rw6GHNbj6wXqO/D6EHeP04GQWMHWl/q8YgiduNUewSiA6lK4fc7xWiNwg1qfNHPmmmCvqmahf
 IjBAp25KIury+s8a7zcyIB8GOcL99ujU63VBJN/WKB/2JvILqPsn8fvkY4INDQjwPKUbdEhi4
 AXzqa3HaUBBzU32D0qBRhzz+pspiQaY6fi94FEF728cDC3oTbQoH0PN/ZkgMW5pOJF5+Imdrt
 6EcBHIXpTsQy+K4PLBdMrzqTiUmlFn4LOdvVs6VzkxWbMvwOV97IVzmcXGTYwDLMQixaMT0Su
 pIohAk4AW7hJMGE/kpckA66U+Em6iOA8Lo02zBfgI1mGN+sjSAOjNdAng8zk0wKEdr/TNh0wW
 +zGMLTQspIjFeRC8XHQ4zvfp2dPuhdrNLqcY/jokHr0Igu7ru7FIFv0goN80x7jCct2jsC1CK
 F3LVchusUbYyhEkKEQ97ZbS0AMDBY9gZWgvqel2Do82hp+6DjNw3dFWFMDpNaYWVF/w6lYBFB
 qoN9rfVFV+NY5dMR90KlV5YPF/9eiUMQiGE+qK/3jEHMWjlrUDuS2N4OXiYjGDJTZMh0Dd+x7
 zAUJcCxtaj/3Qe1XDHerRNx8enviQrBG4fHbNGwPyBqF3j29xmn4uD/nzju7bhUFjk3OclyTT
 9Yd1QQIrRdR94YEMaDqYNcJ9oNav+AWs1Q8CKD/go5WedtpSe7jeaVsX2hs5ZN8gyVsVdHOHj
 3uPaBTbZMfnAmmLGrWYmJPSv4bGkdZ+rqBrnsX9puTodn5GbFRqaSEAzTF+iRQfUAV6jgyvZB
 tBPJjnyTQxFCHN+XbkLekZpphuEyn34og/c4SgFEgk6bagZJT8ONYXR00OPuVqStlx5gitRWU
 RDK8s1PB4d3hJX5zkQQhhOVIpMxwdHidasTKQIXMNhOiDTjUijifp7rXbOE1Cf/fHxYDXCUnf
 X8SDepmnkYDMMyjqwP2psiBVrzE3WGk/vGsGJJkC8k1d16UOvjzAPsJM038dXx7/wHG8YAFcg
 B0M10UPNJ4GhkqFilqXVT/C2COsq0iK0Ez3mXXckD+m1H9/Yc1cIkCaUgFJnGc5fuSPPgaaCk
 lUFQhSODchxxBSh4yupSx59yIPtrF4B6UEd/I1mNWnsjz8rv4HaGGjcl3a641FaeuisjsM9lT
 d7M0LJf2ZIN9QYcvOFD8c09hoFg+TyJDV5UYW3FClqJEiC80F4kf1aNWkZp2H5fUFR9fXweDo
 R4aeh4WxaQudspPMH93BwgqeMBTd1ckKE5S7JL+4yP6f3FcU5/NdULLfpWfmpWRtfokFwgRCt
 38JTDqoafKa6AQrYzFQRjWjOQZxQ=

=E2=80=A6
> This patch checks that a NUMA node =E2=80=A6

Please improve such a change description another bit.

See also:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/process/submitting-patches.rst?h=3Dv6.14-rc5#n94

Regards,
Markus

