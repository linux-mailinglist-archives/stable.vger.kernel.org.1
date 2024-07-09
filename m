Return-Path: <stable+bounces-58275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71ED092B3C8
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 11:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16B83281E7C
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 09:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E26157496;
	Tue,  9 Jul 2024 09:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="m9aKwtBV"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82154156875;
	Tue,  9 Jul 2024 09:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720517113; cv=none; b=XD9AP4x9herI8n6EShXMYWn7GjhqFAcHXn9MNyx8lHPhlavLf7Pxcsua4Xbniv+WiTG/PYUxXlwYUv3AgSbM9WZ3Iq4CQCn97ndKrHiE7nW3AIOsLSDy1PiMofesStxV30/JY6woJxZVUhsfoa9hWVx37oUWEyXiNdGchdLBVRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720517113; c=relaxed/simple;
	bh=J+1hPuhHeGaLG8RaIcdJzDWKam0wGYfdcX5++xetsIw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=phbIH04BDx4btOPZmmHpelQ0l3w+iSdrTu+XYliiqt525dq1iqbv1Ejj6nVSQjxjJl391TX9ReIG9rBQddeh+U430aQLppPFbMUFvfUqbsC59+7/NQJJLZSw+XZVW80TP1FZySX8Djp8e6b2z+fTqDQHFmrJAfxz9vh0g9rzntc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=m9aKwtBV; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720517076; x=1721121876; i=markus.elfring@web.de;
	bh=J+1hPuhHeGaLG8RaIcdJzDWKam0wGYfdcX5++xetsIw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=m9aKwtBV7fvwLToEAu7ZcEZ3OmazsV/Cg68MjuCA5alZ2CwHKKTpBlBbCEoyFL/q
	 P3XhGTddnzFeRmGuWS14kmNgJ2Ot/VlKzmTB0CBEWfX958hHQM1g2P8z3mcsq6tLt
	 6r6ilFb4L2tBdSweeoawb003zq6aw41idfMAKNX3ARvu6HTuYPoQLJUspYzJFjxOU
	 XCkMVznAzZe6Cze7dHt8V7UnZlPtWdnC8oPfGDmkhqqSEX40Cr+mftrwsyRuq/8I8
	 R4uNGy4MQvyyiJoaG99MtuW2F6Ev7g2XidjkHXN9TCj9lNy9u9Pbd/NRdKXrbqBni
	 CA8z0PY6XPLx9AE5dQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M5j5y-1sTtJ02ilO-00DY7f; Tue, 09
 Jul 2024 11:24:36 +0200
Message-ID: <43d7a27e-5b45-4d45-8ff7-8c10e128db88@web.de>
Date: Tue, 9 Jul 2024 11:24:33 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: make24@iscas.ac.cn, dri-devel@lists.freedesktop.org,
 kernel-janitors@vger.kernel.org
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Alan Cox <alan@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>,
 David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>
References: <20240709085916.3002467-1-make24@iscas.ac.cn>
Subject: Re: [PATCH v3] drm/gma500: fix null pointer dereference in
 cdv_intel_lvds_get_modes
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240709085916.3002467-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RSrk3mncGUb8pKlEo1cdNPJk9W1ixGdfqI+k3kTLx2Jl/K9fR1y
 +P29RjkHCoyhpjabNt3iYTlwcqzKg95aJweUtEhupC2WZv0m9rEP/rxHPq4mhEraRxMUGBK
 P3gT++6GYtR3Rt/8+a3gXPDikk9lNQ3WKuQuA2PdclIx2vntMZNE+OE9Tu/bjl+Mos0md/9
 nI63PGF2oB4x2ze8LCJPg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7+yOAalgqd0=;CmFfosr4UNWvErVMkE0pCcB8JBa
 PFAjH7CW2L6+HTBs3Uxjgq5X4diF2BTMaQwOxWEhxU0HpdCUHL3UpaZ8cOvlEf+U7AklOWCRe
 foCvYzh7OfA5XuVmL6qkLUHQVS1aNYwit6r76e8RdvvZWhOr9DIxI1qckEUtWIQtGkd7b693W
 YO1DgLpbSroDo9+axdyDspX4nEv4BgidHRnZNERcs737lTf7fhrBDCMsei7jEZnAq77gKsDmj
 sfee0g1DxU/KfFvxRlblXleJFCQ8cy2F4Eq6Zhr1JUCwh9fWtV8Ik9jvqtVkjoKuErpTRDGoV
 1VXxUqM46OysUcV87DC8OQPHWhm0ekRd0zYFSmyXWg6QRdgQIeePzg005DnMD7n/zE9mF6sD/
 wehbzQCPUaOF7yiGHx2TL19GEo8Qa2Wg7pU4xU9XZtnkONxpxitiqsopqKhj8IDFEYkanpaCh
 SpOzITw7zzghHw8iHMeyaMaQ88Y2nDZTbh0UVVFEfAHdsN0+pPxbjjIL7t0KSJQRX132myfCw
 dSE/mO7Iq2/ojw89Vf1Hrv9rOO11fv38xvIha+yzqZdVTckkbqXvB9GsJXQdYC/f53F4heMJe
 /Y/5nP8ztidnt5YEpsS4G75q4t3hU9YDVGxZgzMxaJ0Yy7bYTu6uNIXqe6nJnr2HPux7kXh76
 bj+9PZiNf4ruGZ99XzJQR1mKoUblPLwDMlfU7AlU89c3uRCI9h5qDLZgbafyFaP5CbgVziDZE
 XlQYGPJNt3cIvamcRU8begghx9N6Po9hKrpIkfGp/kTW6uTojvXTXu2mCUftXB1AM8kVHYhOD
 Lei5YkwRnjIUEEYT20c3GX6Qf7gqC5TqmSieZBzGaIJJw=

=E2=80=A6
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>

Are you going to adjust this information anyhow?

The usage of mailing list addresses is probably undesirable for
the Developer's Certificate of Origin, isn't it?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.10-rc7#n398

Regards,
Markus

