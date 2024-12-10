Return-Path: <stable+bounces-100413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3AB9EB081
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 13:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 351BB1889F6E
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 12:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C81E1A2543;
	Tue, 10 Dec 2024 12:09:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515A71A0BFB;
	Tue, 10 Dec 2024 12:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733832590; cv=none; b=uISrVx8zQvtHL0OlX/R4cXxQzcVRbgvZvuylITcN7ORYX/9Z5iPMX80aX+DeXCkbcfT4RKbdmoHbB7BP3iecVkPwtjn7+awXJz9hIOVDKSIs0vVL+OkjZkmhNBSwvGFQbeT1jyTQOlMSiDfkpT6knAgCv7xtjSDXPkx1OJLwZ7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733832590; c=relaxed/simple;
	bh=dWWmt8eL9lAWPMsB8OmsIb0Fd1ntA+doRb3gtxQozm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U5wEFGqfZhbwfQ4i277DZ0xe/ctmKls6Vowtd0PD/KPe3UtMMRTQCOHFGbc9QONHQxxQxieffoEiGAPCKgecLTlwhwzcyU7kAd/+83uMI7fGDt2Ab61NR/8SNUo7x8sDxzoA7Woqkr6aQMHxWQvPI4v0pfqzYIpjz/dbkuKtJno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5DE71063;
	Tue, 10 Dec 2024 04:10:14 -0800 (PST)
Received: from [10.57.91.204] (unknown [10.57.91.204])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE44B3F5A1;
	Tue, 10 Dec 2024 04:09:44 -0800 (PST)
Message-ID: <cc3b7d5d-bd98-4813-b5ea-71bd019c014e@arm.com>
Date: Tue, 10 Dec 2024 12:09:42 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "iommu: Clean up open-coded ownership checks" has been
 added to the 6.6-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Rob Clark <robdclark@gmail.com>, Yong Wu <yong.wu@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Orson Zhai <orsonzhai@gmail.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20241209112746.3166260-1-sashal@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20241209112746.3166260-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-12-09 11:27 am, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>      iommu: Clean up open-coded ownership checks
> 
> to the 6.6-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>       iommu-clean-up-open-coded-ownership-checks.patch
> and it can be found in the queue-6.6 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Unless you're also going to backport the rest of the larger redesign 
which makes this commit message true, I don't think this is appropriate.

Thanks,
Robin.

> commit 302639dd441533017096f8ebccb02440090fb09d
> Author: Robin Murphy <robin.murphy@arm.com>
> Date:   Tue Nov 21 18:04:03 2023 +0000
> 
>      iommu: Clean up open-coded ownership checks
>      
>      [ Upstream commit e7080665c977ea1aafb8547a9c7bd08b199311d6 ]
>      
>      Some drivers already implement their own defence against the possibility
>      of being given someone else's device. Since this is now taken care of by
>      the core code (and via a slightly different path from the original
>      fwspec-based idea), let's clean them up.
>      
>      Acked-by: Will Deacon <will@kernel.org>
>      Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>      Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
>      Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>      Link: https://lore.kernel.org/r/58a9879ce3f03562bb061e6714fe6efb554c3907.1700589539.git.robin.murphy@arm.com
>      Signed-off-by: Joerg Roedel <jroedel@suse.de>
>      Stable-dep-of: 229e6ee43d2a ("iommu/arm-smmu: Defer probe of clients after smmu device bound")
>      Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 68b81f9c2f4b1..c24584754d252 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2658,9 +2658,6 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
>   	struct arm_smmu_master *master;
>   	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>   
> -	if (!fwspec || fwspec->ops != &arm_smmu_ops)
> -		return ERR_PTR(-ENODEV);
> -
>   	if (WARN_ON_ONCE(dev_iommu_priv_get(dev)))
>   		return ERR_PTR(-EBUSY);
>   
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index d6d1a2a55cc06..8203a06014d71 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -1116,11 +1116,6 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>   	struct arm_smmu_device *smmu;
>   	int ret;
>   
> -	if (!fwspec || fwspec->ops != &arm_smmu_ops) {
> -		dev_err(dev, "cannot attach to SMMU, is it on the same bus?\n");
> -		return -ENXIO;
> -	}
> -
>   	/*
>   	 * FIXME: The arch/arm DMA API code tries to attach devices to its own
>   	 * domains between of_xlate() and probe_device() - we have no way to cope
> @@ -1357,10 +1352,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
>   		fwspec = dev_iommu_fwspec_get(dev);
>   		if (ret)
>   			goto out_free;
> -	} else if (fwspec && fwspec->ops == &arm_smmu_ops) {
> -		smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
>   	} else {
> -		return ERR_PTR(-ENODEV);
> +		smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
>   	}
>   
>   	ret = -EINVAL;
> diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> index bc45d18f350cb..3b8c4b33842d1 100644
> --- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> +++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> @@ -79,16 +79,6 @@ static struct qcom_iommu_domain *to_qcom_iommu_domain(struct iommu_domain *dom)
>   
>   static const struct iommu_ops qcom_iommu_ops;
>   
> -static struct qcom_iommu_dev * to_iommu(struct device *dev)
> -{
> -	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> -
> -	if (!fwspec || fwspec->ops != &qcom_iommu_ops)
> -		return NULL;
> -
> -	return dev_iommu_priv_get(dev);
> -}
> -
>   static struct qcom_iommu_ctx * to_ctx(struct qcom_iommu_domain *d, unsigned asid)
>   {
>   	struct qcom_iommu_dev *qcom_iommu = d->iommu;
> @@ -374,7 +364,7 @@ static void qcom_iommu_domain_free(struct iommu_domain *domain)
>   
>   static int qcom_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
>   {
> -	struct qcom_iommu_dev *qcom_iommu = to_iommu(dev);
> +	struct qcom_iommu_dev *qcom_iommu = dev_iommu_priv_get(dev);
>   	struct qcom_iommu_domain *qcom_domain = to_qcom_iommu_domain(domain);
>   	int ret;
>   
> @@ -406,7 +396,7 @@ static int qcom_iommu_identity_attach(struct iommu_domain *identity_domain,
>   	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
>   	struct qcom_iommu_domain *qcom_domain;
>   	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> -	struct qcom_iommu_dev *qcom_iommu = to_iommu(dev);
> +	struct qcom_iommu_dev *qcom_iommu = dev_iommu_priv_get(dev);
>   	unsigned int i;
>   
>   	if (domain == identity_domain || !domain)
> @@ -537,7 +527,7 @@ static bool qcom_iommu_capable(struct device *dev, enum iommu_cap cap)
>   
>   static struct iommu_device *qcom_iommu_probe_device(struct device *dev)
>   {
> -	struct qcom_iommu_dev *qcom_iommu = to_iommu(dev);
> +	struct qcom_iommu_dev *qcom_iommu = dev_iommu_priv_get(dev);
>   	struct device_link *link;
>   
>   	if (!qcom_iommu)
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index de698463e94ad..23c7eec46fff6 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -843,16 +843,11 @@ static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
>   static struct iommu_device *mtk_iommu_probe_device(struct device *dev)
>   {
>   	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> -	struct mtk_iommu_data *data;
> +	struct mtk_iommu_data *data = dev_iommu_priv_get(dev);
>   	struct device_link *link;
>   	struct device *larbdev;
>   	unsigned int larbid, larbidx, i;
>   
> -	if (!fwspec || fwspec->ops != &mtk_iommu_ops)
> -		return ERR_PTR(-ENODEV); /* Not a iommu client device */
> -
> -	data = dev_iommu_priv_get(dev);
> -
>   	if (!MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM))
>   		return &data->iommu;
>   
> diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
> index f1754efcfe74e..027b2ff7f33ef 100644
> --- a/drivers/iommu/mtk_iommu_v1.c
> +++ b/drivers/iommu/mtk_iommu_v1.c
> @@ -478,9 +478,6 @@ static struct iommu_device *mtk_iommu_v1_probe_device(struct device *dev)
>   		idx++;
>   	}
>   
> -	if (!fwspec || fwspec->ops != &mtk_iommu_v1_ops)
> -		return ERR_PTR(-ENODEV); /* Not a iommu client device */
> -
>   	data = dev_iommu_priv_get(dev);
>   
>   	/* Link the consumer device with the smi-larb device(supplier) */
> diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
> index c8e79a2d8b4c6..b5570ef887023 100644
> --- a/drivers/iommu/sprd-iommu.c
> +++ b/drivers/iommu/sprd-iommu.c
> @@ -388,13 +388,7 @@ static phys_addr_t sprd_iommu_iova_to_phys(struct iommu_domain *domain,
>   
>   static struct iommu_device *sprd_iommu_probe_device(struct device *dev)
>   {
> -	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> -	struct sprd_iommu_device *sdev;
> -
> -	if (!fwspec || fwspec->ops != &sprd_iommu_ops)
> -		return ERR_PTR(-ENODEV);
> -
> -	sdev = dev_iommu_priv_get(dev);
> +	struct sprd_iommu_device *sdev = dev_iommu_priv_get(dev);
>   
>   	return &sdev->iommu;
>   }
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 17dcd826f5c20..bb2e795a80d0f 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -969,9 +969,6 @@ static struct iommu_device *viommu_probe_device(struct device *dev)
>   	struct viommu_dev *viommu = NULL;
>   	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>   
> -	if (!fwspec || fwspec->ops != &viommu_ops)
> -		return ERR_PTR(-ENODEV);
> -
>   	viommu = viommu_get_by_fwnode(fwspec->iommu_fwnode);
>   	if (!viommu)
>   		return ERR_PTR(-ENODEV);


