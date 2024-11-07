Return-Path: <stable+bounces-91848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 083C69C0986
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 16:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5881F24A6E
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 15:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07BE20F5BF;
	Thu,  7 Nov 2024 15:01:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDA682876;
	Thu,  7 Nov 2024 15:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730991716; cv=none; b=HS+WM6UIMHW7vtchc21jIMoNDDWKeQfXGmpI4Tp7o71sWclM/ZPFefrKDiJnNdpo9CLL0n54m0o5r2lJtue2KZU8BgM06OpUqBnI7aWx3h7Ilz8t9FbKbXBEJTb/qM41UAabGKwbPrkYff62QNb3K3QTU1o03/cLS1BtLTkqu9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730991716; c=relaxed/simple;
	bh=V6f8vRy4baPyLD48lR195dH5xTj8jGCkHM5JSdBohLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kmhaBFPcnIXtvt9RICEzJjKH7y/lojXd/GHFkMNlfglUgVovuoOIqqC4eOaTW4KaQSlDbybelXss+NnFrV2wCHVpII7xsbZxdRVqjGq5zI1oWL7LdSFoJzJMq3q4SzUjtCMc2nzzLSjK8wEMDv1UmY2RnYNutCAIoGWOa9HVVx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E509D497;
	Thu,  7 Nov 2024 07:02:23 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE05C3F66E;
	Thu,  7 Nov 2024 07:01:51 -0800 (PST)
Message-ID: <0952ca36-c5d9-462a-ab7b-b97154c56919@arm.com>
Date: Thu, 7 Nov 2024 15:01:50 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/arm-smmu: Defer probe of clients after smmu
 device bound
To: Will Deacon <will@kernel.org>, Pratyush Brahma <quic_pbrahma@quicinc.com>
Cc: catalin.marinas@arm.com, kernel-team@android.com, joro@8bytes.org,
 jgg@ziepe.ca, jsnitsel@redhat.com, robdclark@chromium.org,
 quic_c_gdjako@quicinc.com, dmitry.baryshkov@linaro.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, quic_charante@quicinc.com,
 stable@vger.kernel.org, Prakash Gupta <quic_guptap@quicinc.com>
References: <20241004090428.2035-1-quic_pbrahma@quicinc.com>
 <173021496151.4097715.14758035881649445798.b4-ty@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <173021496151.4097715.14758035881649445798.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/10/2024 4:15 pm, Will Deacon wrote:
> On Fri, 04 Oct 2024 14:34:28 +0530, Pratyush Brahma wrote:
>> Null pointer dereference occurs due to a race between smmu
>> driver probe and client driver probe, when of_dma_configure()
>> for client is called after the iommu_device_register() for smmu driver
>> probe has executed but before the driver_bound() for smmu driver
>> has been called.
>>
>> Following is how the race occurs:
>>
>> [...]
> 
> Applied to will (for-joerg/arm-smmu/updates), thanks!
> 
> [1/1] iommu/arm-smmu: Defer probe of clients after smmu device bound
>        https://git.kernel.org/will/c/229e6ee43d2a

I've finally got to the point of proving to myself that this isn't the
right fix, since once we do get __iommu_probe_device() working properly
in the correct order, iommu_device_register() then runs into the same
condition itself. Diff below should make this issue go away - I'll write
up proper patches once I've tested it a little more.

Thanks,
Robin.

----->8-----
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 737c5b882355..b7dcb1494aa4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3171,8 +3171,8 @@ static struct platform_driver arm_smmu_driver;
  static
  struct arm_smmu_device *arm_smmu_get_by_fwnode(struct fwnode_handle *fwnode)
  {
-	struct device *dev = driver_find_device_by_fwnode(&arm_smmu_driver.driver,
-							  fwnode);
+	struct device *dev = bus_find_device_by_fwnode(&platform_bus_type, fwnode);
+
  	put_device(dev);
  	return dev ? dev_get_drvdata(dev) : NULL;
  }
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 8321962b3714..aba315aa6848 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1411,8 +1411,8 @@ static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
  static
  struct arm_smmu_device *arm_smmu_get_by_fwnode(struct fwnode_handle *fwnode)
  {
-	struct device *dev = driver_find_device_by_fwnode(&arm_smmu_driver.driver,
-							  fwnode);
+	struct device *dev = bus_find_device_by_fwnode(&platform_bus_type, fwnode);
+
  	put_device(dev);
  	return dev ? dev_get_drvdata(dev) : NULL;
  }
@@ -2232,21 +2232,6 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
  					i, irq);
  	}
  
-	err = iommu_device_sysfs_add(&smmu->iommu, smmu->dev, NULL,
-				     "smmu.%pa", &smmu->ioaddr);
-	if (err) {
-		dev_err(dev, "Failed to register iommu in sysfs\n");
-		return err;
-	}
-
-	err = iommu_device_register(&smmu->iommu, &arm_smmu_ops,
-				    using_legacy_binding ? NULL : dev);
-	if (err) {
-		dev_err(dev, "Failed to register iommu\n");
-		iommu_device_sysfs_remove(&smmu->iommu);
-		return err;
-	}
-
  	platform_set_drvdata(pdev, smmu);
  
  	/* Check for RMRs and install bypass SMRs if any */
@@ -2255,6 +2240,18 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
  	arm_smmu_device_reset(smmu);
  	arm_smmu_test_smr_masks(smmu);
  
+	err = iommu_device_sysfs_add(&smmu->iommu, smmu->dev, NULL,
+				     "smmu.%pa", &smmu->ioaddr);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to register iommu in sysfs\n");
+
+	err = iommu_device_register(&smmu->iommu, &arm_smmu_ops,
+				    using_legacy_binding ? NULL : dev);
+	if (err) {
+		iommu_device_sysfs_remove(&smmu->iommu);
+		return dev_err_probe(dev, err, "Failed to register iommu\n");
+	}
+
  	/*
  	 * We want to avoid touching dev->power.lock in fastpaths unless
  	 * it's really going to do something useful - pm_runtime_enabled()

