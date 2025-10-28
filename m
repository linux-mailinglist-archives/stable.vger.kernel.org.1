Return-Path: <stable+bounces-191449-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8081C147B6
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 12:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B514042828E
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 11:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B85F314D19;
	Tue, 28 Oct 2025 11:57:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E78730F92B;
	Tue, 28 Oct 2025 11:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761652627; cv=none; b=F0BX2M7bU4mbGInP7Zh4vdd/mLqAuHGoVYHmJ/1EaAmv5Xn0hxKZuQUWkNdfaYzVDGdnP21zo5OrZnoQqhrMP3mHvQwQRyYHBcgr5nf9bGqFYrBIHtuBP+EiPdV0LjDOZFYpuNUcZ/Swsnclhxd9B5wsNFEKGnWbhnHrffS/Nl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761652627; c=relaxed/simple;
	bh=z5CXhGy/LBc2zpdHHMxomM5MbPIp7P2Uxn6ZD1HAR94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KLCA8tZm5B3OzNigbGa+y24d+cNUT5IihJLAN9oQRnJlef5jd6ti6uEop35qFTPpblA4LkIeHNmF0jf0BmX7goUMj7n/JcpTqwHD7+C1gMls1VD65cktClcr6LQ7MSWGHsd4EH7s7+aZd7P6+vJBe1mXoXEk2j/Pf2fq1Rum3M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7486F168F;
	Tue, 28 Oct 2025 04:56:56 -0700 (PDT)
Received: from [10.57.39.79] (unknown [10.57.39.79])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0BC743F63F;
	Tue, 28 Oct 2025 04:57:02 -0700 (PDT)
Message-ID: <6c35e1e4-8267-4eba-a53e-04ff74e224a2@arm.com>
Date: Tue, 28 Oct 2025 11:57:00 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/of: Fix device node reference leak in
 of_iommu_get_resv_regions
To: Miaoqian Lin <linmq006@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Thierry Reding <treding@nvidia.com>,
 Rob Herring <robh@kernel.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20251028063601.71934-1-linmq006@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20251028063601.71934-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-10-28 6:36 am, Miaoqian Lin wrote:
> In of_iommu_get_resv_regions(), of_find_node_by_phandle() returns a device
> node with its reference count incremented. The caller is responsible for
> releasing this reference when the node is no longer needed.
> 
> Add a call to of_node_put() to release the reference after the usage.

Just put the reference immediately after getting it - this inner usage 
only happens if it's the same dev->of_node we're already using for the 
outer iteration, so we don't need to bother holding an extra reference 
as it can't suddenly disappear anyway (or even if it could, that's still 
not *this* code's problem...)

Thanks,
Robin.

> Found via static analysis.
> 
> Fixes: a5bf3cfce8cb ("iommu: Implement of_iommu_get_resv_regions()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>   drivers/iommu/of_iommu.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 6b989a62def2..02448da8ff90 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -256,6 +256,7 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
>   				maps = of_translate_dma_region(np, maps, &iova, &length);
>   				if (length == 0) {
>   					dev_warn(dev, "Cannot reserve IOVA region of 0 size\n");
> +					of_node_put(np);
>   					continue;
>   				}
>   				type = iommu_resv_region_get_type(dev, &phys, iova, length);
> @@ -265,6 +266,7 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
>   				if (region)
>   					list_add_tail(&region->list, list);
>   			}
> +			of_node_put(np);
>   		}
>   	}
>   #endif


