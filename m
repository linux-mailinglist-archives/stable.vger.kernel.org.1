Return-Path: <stable+bounces-183036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E29BB3D7F
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 14:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE2173BA8CF
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 12:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1B4310620;
	Thu,  2 Oct 2025 12:05:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738EF3101DB;
	Thu,  2 Oct 2025 12:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759406718; cv=none; b=Cjf1rKi0Y8xmgMukpM2FerQOZAHNE73kk3mWz0IrWqcProWUe9u5tCgZxVLVpRVwmT4L4SWJTSFAyYhzfjG0Yt/k2m/Es673TMj3Y5vrfvyhJm02h14eY3deQT09ZR4153018KJy/JatTAW+QlUZBW/pDP3ew+eyOctp7iXNs64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759406718; c=relaxed/simple;
	bh=6W3Vy4HMSC/bCOzdV9y65fLEP+yshFxn9SuPxaybkws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OpT+AA8ucv719SapLfZmedMjKX1HcgGbWO29rkuc5nBXUzXkY5jdje42fFZa2k9MRZVszGQGmaB40DFVqhufqOCuOg/lYfg3oWW1//edLnf5pBsbN23FC/1leF+6KLPDiBhi9XSBgfmsWidBLhkFHHqwqkQINs1Vujci0bRyPLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C17A9168F;
	Thu,  2 Oct 2025 05:05:07 -0700 (PDT)
Received: from [10.57.2.183] (unknown [10.57.2.183])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FCD43F66E;
	Thu,  2 Oct 2025 05:05:12 -0700 (PDT)
Message-ID: <8e98159d-5c13-453f-8d4b-c7ff80617239@arm.com>
Date: Thu, 2 Oct 2025 13:05:08 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/14] iommu/omap: fix device leaks on probe_device()
To: Johan Hovold <johan@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Yong Wu <yong.wu@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Chen-Yu Tsai <wens@csie.org>, Thierry Reding <thierry.reding@gmail.com>,
 Krishna Reddy <vdumpa@nvidia.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Suman Anna <s-anna@ti.com>
References: <20250925122756.10910-1-johan@kernel.org>
 <20250925122756.10910-12-johan@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250925122756.10910-12-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-09-25 1:27 pm, Johan Hovold wrote:
> Make sure to drop the reference taken to the iommu platform devices
> during probe_device() on errors and when the device is later released.
> 
> Fixes: 9d5018deec86 ("iommu/omap: Add support to program multiple iommus")
> Fixes: 7d6827748d54 ("iommu/omap: Fix iommu archdata name for DT-based devices")
> Cc: stable@vger.kernel.org	# 3.18
> Cc: Suman Anna <s-anna@ti.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>   drivers/iommu/omap-iommu.c | 27 +++++++++++++++++++--------
>   1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index 6fb93927bdb9..77023d49bd24 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -1636,7 +1636,7 @@ static struct iommu_device *omap_iommu_probe_device(struct device *dev)
>   	struct platform_device *pdev;
>   	struct omap_iommu *oiommu;
>   	struct device_node *np;
> -	int num_iommus, i;
> +	int num_iommus, i, ret;
>   
>   	/*
>   	 * Allocate the per-device iommu structure for DT-based devices.
> @@ -1663,22 +1663,22 @@ static struct iommu_device *omap_iommu_probe_device(struct device *dev)
>   	for (i = 0, tmp = arch_data; i < num_iommus; i++, tmp++) {
>   		np = of_parse_phandle(dev->of_node, "iommus", i);
>   		if (!np) {
> -			kfree(arch_data);
> -			return ERR_PTR(-EINVAL);
> +			ret = -EINVAL;
> +			goto err_put_iommus;
>   		}
>   
>   		pdev = of_find_device_by_node(np);
>   		if (!pdev) {
>   			of_node_put(np);
> -			kfree(arch_data);
> -			return ERR_PTR(-ENODEV);
> +			ret = -ENODEV;
> +			goto err_put_iommus;
>   		}
>   
>   		oiommu = platform_get_drvdata(pdev);
>   		if (!oiommu) {
>   			of_node_put(np);
> -			kfree(arch_data);
> -			return ERR_PTR(-EINVAL);
> +			ret = -EINVAL;
> +			goto err_put_iommus;
>   		}
>   
>   		tmp->iommu_dev = oiommu;
> @@ -1697,17 +1697,28 @@ static struct iommu_device *omap_iommu_probe_device(struct device *dev)
>   	oiommu = arch_data->iommu_dev;
>   
>   	return &oiommu->iommu;
> +
> +err_put_iommus:
> +	for (tmp = arch_data; tmp->dev; tmp++)
> +		put_device(tmp->dev);

This should just pair with the of_node_put() calls (other than the first 
one, of course), i.e. do it in the success path as well and drop the 
release_device change below. It doesn't serve any purpose for client 
devices to hold additional references on the IOMMU device when those are 
strictly within the lifetime of the IOMMU driver being bound to it anyway.

Thanks,
Robin.

> +
> +	kfree(arch_data);
> +
> +	return ERR_PTR(ret);
>   }
>   
>   static void omap_iommu_release_device(struct device *dev)
>   {
>   	struct omap_iommu_arch_data *arch_data = dev_iommu_priv_get(dev);
> +	struct omap_iommu_arch_data *tmp;
>   
>   	if (!dev->of_node || !arch_data)
>   		return;
>   
> -	kfree(arch_data);
> +	for (tmp = arch_data; tmp->dev; tmp++)
> +		put_device(tmp->dev);
>   
> +	kfree(arch_data);
>   }
>   
>   static int omap_iommu_of_xlate(struct device *dev, const struct of_phandle_args *args)

