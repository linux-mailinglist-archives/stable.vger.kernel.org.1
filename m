Return-Path: <stable+bounces-108222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EADDAA09915
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 19:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C25CE188C00E
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 18:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DA12139A6;
	Fri, 10 Jan 2025 18:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VTC54PXO"
X-Original-To: stable@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F562066E0
	for <stable@vger.kernel.org>; Fri, 10 Jan 2025 18:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736532628; cv=none; b=Z4jQh07vHCBhoiXJr+/YxfZJqSyhf/xRDbKhfE9tiwW5VTraGBAdHhE40SH4R7j2sYlsBnViS8kbMrNRk/pe1p+kAc55P/Yq+d0QGMa2pOgzjoocQZWovZS202s2C3Nx6/fpHeH+T2WeEoXZmFyUuw9kM27onl72ZT7mDPaXY8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736532628; c=relaxed/simple;
	bh=x6oczK3ug8bgzFqhIBsyiTUh3Szy74yr+KpLIuHRg8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EG3wCicdKOU17Sxq9pmdO1q/Xq4l+rsEa+S3tpMYqjdzSbDWFa8pj9HMKTByYRRW2ZABUiWDhoVeIPkOPm947thrmDAPgcryaZuwdKteGnx2DNfZKT2AEINvpNIwYHzUfBBvXvXi6HV4rzIIbenI9Fr9XBv6V/VrZ0MyKdrZnPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VTC54PXO; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b18dfc63-94fc-4459-ba0d-67b704d38f0c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736532613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1+ZK2sNVQG3CftxXFAyvg9WnLzu0fKqq3YAoWAkxSFo=;
	b=VTC54PXO0Q8s4bDBQnojNz3yhaEmT4/m2eBO8ccEqRBY8/HTl09MaK6eylomDEcPrfwfwp
	EZj2aiuTNcPodNCQsTaAt/YkJhW9Z+Q2ZLPhrUS2txsC9qb8CdY+ISQy4OdLnOEDupYQSx
	EK2Rh/GVToquQrg2gCyJzbMw9211hc0=
Date: Fri, 10 Jan 2025 13:10:09 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 10/10] drm: xlnx: zynqmp: Fix max dma segment size
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Vishal Sagar <vishal.sagar@amd.com>,
 Anatoliy Klymenko <anatoliy.klymenko@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Michal Simek <michal.simek@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20241204-xilinx-formats-v1-0-0bf2c5147db1@ideasonboard.com>
 <20241204-xilinx-formats-v1-10-0bf2c5147db1@ideasonboard.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20241204-xilinx-formats-v1-10-0bf2c5147db1@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/4/24 04:31, Tomi Valkeinen wrote:
> Fix "mapping sg segment longer than device claims to support" warning by
> setting the max segment size.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/gpu/drm/xlnx/zynqmp_dpsub.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
> index f5781939de9c..a25b22238e3d 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
> @@ -231,6 +231,8 @@ static int zynqmp_dpsub_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	dma_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(32));
> +
>  	/* Try the reserved memory. Proceed if there's none. */
>  	of_reserved_mem_device_init(&pdev->dev);
>  
> 

Fixes: d76271d22694 ("drm: xlnx: DRM/KMS driver for Xilinx ZynqMP DisplayPort Subsystem")
Reviewed-by: Sean Anderson <sean.anderson@linux.dev>
Tested-by: Sean Anderson <sean.anderson@linux.dev>

