Return-Path: <stable+bounces-40769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8478AF894
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 22:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 094FF1F25C9D
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 20:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68D620B3E;
	Tue, 23 Apr 2024 20:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="H1zi+uW1"
X-Original-To: stable@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B697C143865
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 20:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713905563; cv=none; b=jvsKDmm+6ykL3DmTHcFSmUZCcfsvRRvNdHg85Y9/izzLc5hMNicARpKAae921Lvu3PU1foVqEHr2e+b7AX9jDsLq0O8DlTLjHsKsZMBDlYSIdwJRVxvm5SiWiVUXOBMhWi4L2IiaqKsSM+PS/nxEHQ3cz3hw0cQbZ4DtA4VHa5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713905563; c=relaxed/simple;
	bh=R8iQ8Hov4GJ1MakW6Sr+IudRZUGc4LJ0u0efMMaVDpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=hjfBI/USuQQrFSILXR0MRmepgyOz6i/op72mvXoDuzoM0917I4N5rXyGyqQTmQtFDzD68JsFR3x7Pxi8dg3qdEiJAZBjzJjDg3nl0WyAN6/sogTeduL770HWfXQUUQyQUHwoRIBEnQvs8mfjLdb1B/hvlk09lR8FiQ+7QXBUbyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=H1zi+uW1; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240423205238euoutp029e72b1dd70df2ec9a0ff7a8a817fc167~JBAZyuK3T1827718277euoutp02B
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 20:52:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240423205238euoutp029e72b1dd70df2ec9a0ff7a8a817fc167~JBAZyuK3T1827718277euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1713905558;
	bh=2otvmutdKyHoEaA06cEeWxPbYOppyD/0lNiNCzbg05g=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=H1zi+uW1Z40x3XzIdNP7JwVEN55zswPVuI83E8PnzeYo7AGafSU4/xym3YmwHJy6Z
	 95zKIBALSaJ09yNcvVMzQK7ECyQu3xsueOVFTUpOpUpJ+FfPRfmTh4n7yKv4ErKye9
	 svKNVDazSl/l2oFy9kW0Ir2CHrjNVxzF9zr38dJQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240423205238eucas1p1d42dca0b203ed18170c2360dc670194a~JBAZQPWYy1461514615eucas1p1_;
	Tue, 23 Apr 2024 20:52:38 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 4C.2A.09875.69F18266; Tue, 23
	Apr 2024 21:52:38 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240423205237eucas1p193f07dfa95bb54c2d3d23a6187c4614e~JBAYr64GL1461514615eucas1p19;
	Tue, 23 Apr 2024 20:52:37 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240423205237eusmtrp25e0512fb14637a6a188206f796ce90c5~JBAYrUESH3042330423eusmtrp2F;
	Tue, 23 Apr 2024 20:52:37 +0000 (GMT)
X-AuditID: cbfec7f4-131ff70000002693-cb-66281f968a0d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id E8.17.08810.59F18266; Tue, 23
	Apr 2024 21:52:37 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240423205237eusmtip1f46664a45102f838da2f722dc193cfcd~JBAYOW64C0206202062eusmtip1K;
	Tue, 23 Apr 2024 20:52:37 +0000 (GMT)
Message-ID: <e9d4378e-60c6-4004-ae56-6b4f55eb3400@samsung.com>
Date: Tue, 23 Apr 2024 22:52:37 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/exynos: fix .get_modes return value in case of
 errors
To: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Cc: Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>, stable@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20240423204431.3288578-1-m.szyprowski@samsung.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsWy7djPc7rT5DXSDLr2CFlc+fqezWLS/Qks
	FufPb2C32PT4GqvFjPP7mCwWbHzEaDFj8ks2B3aPTas62Tzudx9n8ti8pN6jb8sqRo/Pm+QC
	WKO4bFJSczLLUov07RK4Mh6+WcVWcECo4sJXgwbGbv4uRk4OCQETieOrdjKB2EICKxgl5jSz
	dzFyAdlfGCVWbv/IBuF8ZpTYv3AZE0zHweNnmCASyxklNj6/yQzhfGSUePz6HlgVr4CdxJGj
	V9hBbBYBVYmeyw2MEHFBiZMzn7CA2KIC8hL3b80AqxEWCJCYeXIamC0ikCdxdVo7K8hQZoEe
	RolVs64wgySYBcQlbj2ZD7aATcBQouttFxuIzSngIDFzeg87RI28xPa3c8AukhC4wyEx8+IG
	Voi7XSTW9V+BsoUlXh3fwg5hy0j83zmfCaKhnVFiwe/7UM4ERomG57cYIaqsJe6c+wW0jgNo
	habE+l36EGFHianXD4KFJQT4JG68FYQ4gk9i0rbpzBBhXomONiGIajWJWcfXwa09eOES8wRG
	pVlI4TILyZuzkLwzC2HvAkaWVYziqaXFuempxUZ5qeV6xYm5xaV56XrJ+bmbGIEp6PS/4192
	MC5/9VHvECMTB+MhRgkOZiUR3l9/VNKEeFMSK6tSi/Lji0pzUosPMUpzsCiJ86qmyKcKCaQn
	lqRmp6YWpBbBZJk4OKUamFQZw3XVXy0VVVA+Nn/llpxTWRIyf//MZH3f6vn6gfeuvV4uS9KN
	ylhu1C12dvqh1iDWx5kukmF057XA7QnKInFOHN+WSLrPTV4pKnX4UFWofWhnuffr+l/Wxs75
	PNvPCLMuLtl145sO17vO78Idc3ti+96Wih7vtzuWKGZ4O0z6q2j8hP2/jHeUvT3t9vCW5qrT
	m0uzrNX63u9lbHg9I/7o38hj52LvcV92D/3weUruk3O/b3Ptq9nFbP82506mTVEV/znbxKSF
	yxZcq69JdGjjUF/XmfvA3yvAbvG/iqwdmpE60++4nJt20GnPqQl/1IPkXdNXpE6a9F3jq7Pb
	HsmfF3Z99swQSOi8s82qTYmlOCPRUIu5qDgRABXiTMOwAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsVy+t/xu7pT5TXSDBZeULG48vU9m8Wk+xNY
	LM6f38BusenxNVaLGef3MVks2PiI0WLG5JdsDuwem1Z1snnc7z7O5LF5Sb1H35ZVjB6fN8kF
	sEbp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZTx8
	s4qt4IBQxYWvBg2M3fxdjJwcEgImEgePn2ECsYUEljJKnNthCRGXkTg5rYEVwhaW+HOti62L
	kQuo5j2jxKbZq9hAErwCdhJHjl5hB7FZBFQlei43MELEBSVOznzCAmKLCshL3L81A6xGWMBP
	4uOkfrBlIgJ5EouWHmAFGcos0MMosWDxV2aIDZMZJV59fwG2mllAXOLWk/lgHWwChhJdb7vA
	NnMKOEjMnN7DDlFjJtG1tYsRwpaX2P52DvMERqFZSA6ZhWTULCQts5C0LGBkWcUoklpanJue
	W2yoV5yYW1yal66XnJ+7iREYc9uO/dy8g3Heq496hxiZOBgPMUpwMCuJ8P76o5ImxJuSWFmV
	WpQfX1Sak1p8iNEUGBoTmaVEk/OBUZ9XEm9oZmBqaGJmaWBqaWasJM7rWdCRKCSQnliSmp2a
	WpBaBNPHxMEp1cCk09R0qS70vt3K862P69p/NXx11LCT2qmuwXTt34HvLJyC7WuLa2x+R9cu
	Nrxw75nu79cfl71SsFvp+kT0rfyu1aXpnJ++cezbafDvzQf9X0WBMe8mp/HMUW1dUCaX7/rh
	0LStZyUYNzQoJScaKCYeuOW4fFXFERnpn9rHHM6drI8+Z/HuQ2z2fO5T/Kur3n64vlfxT6dC
	TtNExzjX27OFfdMPcD5fP93bsWCv2vMUx8+aK6UmM1quZtXyUMh2inS5WqdvKDxliyPbCdGl
	s2vXRfYvYnzWWGV95VDor4evlx282mjJ9VI6Wrx6neak0EmTmlZmPHu8YK624+LsGSnnzv7X
	XeBW3cHD8myDe7yfEktxRqKhFnNRcSIAvPqvK0IDAAA=
X-CMS-MailID: 20240423205237eucas1p193f07dfa95bb54c2d3d23a6187c4614e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240423204435eucas1p2c0a9a75f87b31d11faa59fec40878f23
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240423204435eucas1p2c0a9a75f87b31d11faa59fec40878f23
References: <CGME20240423204435eucas1p2c0a9a75f87b31d11faa59fec40878f23@eucas1p2.samsung.com>
	<20240423204431.3288578-1-m.szyprowski@samsung.com>

On 23.04.2024 22:44, Marek Szyprowski wrote:
> Commit 7af03e688792 ("drm/probe-helper: warn about negative
> .get_modes()") clarified, that .get_modes callback must not return
> negative values on failure, so fix sub-drivers to return 0 in case of
> errors. This fixes strange Exynos DRM initialization failure on boot
> (timeout waiting for VSYNC) observed on Trats2 board.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Ah, I've missed that this has been already fixed in -next by the patch 
13d5b040363c ("drm/exynos: do not return negative values from 
.get_modes()"), so ignore this one. I'm sorry for the noise.

> ---
>   drivers/gpu/drm/exynos/exynos_drm_vidi.c | 4 ++--
>   drivers/gpu/drm/exynos/exynos_hdmi.c     | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
> index e5662bdcbbde..e3868956eb88 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
> @@ -315,14 +315,14 @@ static int vidi_get_modes(struct drm_connector *connector)
>   	 */
>   	if (!ctx->raw_edid) {
>   		DRM_DEV_DEBUG_KMS(ctx->dev, "raw_edid is null.\n");
> -		return -EFAULT;
> +		return 0;
>   	}
>   
>   	edid_len = (1 + ctx->raw_edid->extensions) * EDID_LENGTH;
>   	edid = kmemdup(ctx->raw_edid, edid_len, GFP_KERNEL);
>   	if (!edid) {
>   		DRM_DEV_DEBUG_KMS(ctx->dev, "failed to allocate edid\n");
> -		return -ENOMEM;
> +		return 0;
>   	}
>   
>   	drm_connector_update_edid_property(connector, edid);
> diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
> index c5ba32fca5f3..603d8bb0b03a 100644
> --- a/drivers/gpu/drm/exynos/exynos_hdmi.c
> +++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
> @@ -878,11 +878,11 @@ static int hdmi_get_modes(struct drm_connector *connector)
>   	int ret;
>   
>   	if (!hdata->ddc_adpt)
> -		return -ENODEV;
> +		return 0;
>   
>   	edid = drm_get_edid(connector, hdata->ddc_adpt);
>   	if (!edid)
> -		return -ENODEV;
> +		return 0;
>   
>   	hdata->dvi_mode = !drm_detect_hdmi_monitor(edid);
>   	DRM_DEV_DEBUG_KMS(hdata->dev, "%s : width[%d] x height[%d]\n",

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


