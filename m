Return-Path: <stable+bounces-195005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 058C1C65A4C
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 19:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C2A474E766B
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 18:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC73427877D;
	Mon, 17 Nov 2025 18:00:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35E91DB125;
	Mon, 17 Nov 2025 18:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763402425; cv=none; b=qCUiyPzjum4Yfzq/h5LQgS84X6MBjtogvPU4FXYxgCLtK2w1scUKXxCFQx822nqJONA3Fy3spZi/efE3d/EKMvJB/1Heec2nSkQiW0CBK3a4IRegC5KErcjjn/efH0AmikU6eGhnzBGPNQsgOtXnYEg72u2QjrqKKKHHvzc9ci4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763402425; c=relaxed/simple;
	bh=Y1d9XsSWtXQN5UtwmC6lMVTpaJZ8ScRdIDgzx9/SaZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OuR1Zjrl8okcFrrncVCMytWIiTRHEb8fmUZ6uKf6cvamE3pWV8fZIISDTww/HdeZyYeJUJsuOprNY2lUgA1eCThXuSU/5vfnwTVSEdi14ey+pn3EkwgaHf02hWox84Izvrj92wdqk8cBxcolIcWRnDxObPgPazFKxCozfpPv6Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6FEFFEC;
	Mon, 17 Nov 2025 10:00:15 -0800 (PST)
Received: from [10.57.87.92] (unknown [10.57.87.92])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF5AE3F740;
	Mon, 17 Nov 2025 10:00:21 -0800 (PST)
Message-ID: <1a485744-67fc-4530-b131-304f2cb84a8c@arm.com>
Date: Mon, 17 Nov 2025 18:00:19 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/omap: Fix error handling in omap_iommu_probe_device
To: Ma Ke <make24@iscas.ac.cn>, joro@8bytes.org, will@kernel.org,
 t-kristo@ti.com, s-anna@ti.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, stable@vger.kernel.org
References: <20251117033943.40749-1-make24@iscas.ac.cn>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20251117033943.40749-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-11-17 3:39 am, Ma Ke wrote:
> omap_iommu_probe_device() calls of_find_device_by_node() which
> increments the reference count of the platform device, but fails to
> decrement the reference count in both success and error paths. This
> could lead to resource leakage and prevent proper device cleanup when
> the IOMMU is unbound or the device is removed.

This is already fixed by Johan's comprehensive cleanup series:

https://lore.kernel.org/linux-iommu/20251020045318.30690-1-johan@kernel.org/

Thanks,
Robin.

> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 9d5018deec86 ("iommu/omap: Add support to program multiple iommus")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>   drivers/iommu/omap-iommu.c | 32 +++++++++++++++++++++-----------
>   1 file changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index 5c6f5943f44b..4df06cb09623 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -1637,6 +1637,7 @@ static struct iommu_device *omap_iommu_probe_device(struct device *dev)
>   	struct omap_iommu *oiommu;
>   	struct device_node *np;
>   	int num_iommus, i;
> +	int ret = 0;
>   
>   	/*
>   	 * Allocate the per-device iommu structure for DT-based devices.
> @@ -1663,28 +1664,26 @@ static struct iommu_device *omap_iommu_probe_device(struct device *dev)
>   	for (i = 0, tmp = arch_data; i < num_iommus; i++, tmp++) {
>   		np = of_parse_phandle(dev->of_node, "iommus", i);
>   		if (!np) {
> -			kfree(arch_data);
> -			return ERR_PTR(-EINVAL);
> +			ret = -EINVAL;
> +			goto err_cleanup;
>   		}
>   
>   		pdev = of_find_device_by_node(np);
> +		of_node_put(np);
>   		if (!pdev) {
> -			of_node_put(np);
> -			kfree(arch_data);
> -			return ERR_PTR(-ENODEV);
> +			ret = -ENODEV;
> +			goto err_cleanup;
>   		}
>   
>   		oiommu = platform_get_drvdata(pdev);
>   		if (!oiommu) {
> -			of_node_put(np);
> -			kfree(arch_data);
> -			return ERR_PTR(-EINVAL);
> +			put_device(&pdev->dev);
> +			ret = -EINVAL;
> +			goto err_cleanup;
>   		}
>   
>   		tmp->iommu_dev = oiommu;
>   		tmp->dev = &pdev->dev;
> -
> -		of_node_put(np);
>   	}
>   
>   	dev_iommu_priv_set(dev, arch_data);
> @@ -1697,17 +1696,28 @@ static struct iommu_device *omap_iommu_probe_device(struct device *dev)
>   	oiommu = arch_data->iommu_dev;
>   
>   	return &oiommu->iommu;
> +
> +err_cleanup:
> +	for (tmp = arch_data; tmp < arch_data + i; tmp++) {
> +		if (tmp->dev)
> +			put_device(tmp->dev);
> +	}
> +	kfree(arch_data);
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


