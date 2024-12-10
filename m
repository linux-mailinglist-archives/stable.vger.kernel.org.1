Return-Path: <stable+bounces-100414-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5829C9EB092
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 13:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22063161186
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 12:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D6F1A256B;
	Tue, 10 Dec 2024 12:14:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C1E19F13B;
	Tue, 10 Dec 2024 12:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733832890; cv=none; b=oR3Ak6Otxsb9wioZBDab9qMdtoHGXcyW4dNiugXn4VD7BbGdk+52ohwE0RuYEPWCCWOvUqbb44ErjBVLK7STFayOh33WzIB3/H3zlwM2vtnbK0H13AFvjeDVXs99ZeDhUYESJIYv/UxkVxJUo3FQJCOuWqb8SCg0Ecvoc0/f2vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733832890; c=relaxed/simple;
	bh=vn4DZzOkxHRteqWvMCRUR0+hUhrDn5jRe/hjkhx6U8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JrUosvHqAEcAM7W/I3DzSGqKK9aMEj1Pd2NtPWkFKIijhMaH56ei5Zl8JtUPnmbLrLxxfahZSRkqjZGtDzmylt8xO+7vg35Hk8cdUylmPcu4doLys+DL4DgTn7IOtLD4+eYqqVWlG/7iNPFh/U0As/eMvuMvyMsgWBIHZzo8Ng8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 248431063;
	Tue, 10 Dec 2024 04:15:15 -0800 (PST)
Received: from [10.57.91.204] (unknown [10.57.91.204])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D6933F5A1;
	Tue, 10 Dec 2024 04:14:46 -0800 (PST)
Message-ID: <7dc48afa-1ea8-4ed4-8e55-7c108299522b@arm.com>
Date: Tue, 10 Dec 2024 12:14:44 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "iommu/arm-smmu: Defer probe of clients after smmu device
 bound" has been added to the 6.6-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org,
 quic_pbrahma@quicinc.com
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>
References: <20241209112749.3166445-1-sashal@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20241209112749.3166445-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-12-09 11:27 am, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>      iommu/arm-smmu: Defer probe of clients after smmu device bound
> 
> to the 6.6-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>       iommu-arm-smmu-defer-probe-of-clients-after-smmu-dev.patch
> and it can be found in the queue-6.6 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

FWIW the correct resolution for cherry-picking this directly is the
logically-straightforward one, as below (git is mostly just confused by
the context)

Cheers,
Robin.

----->8-----
diff --cc drivers/iommu/arm/arm-smmu/arm-smmu.c
index d6d1a2a55cc0,14618772a3d6..000000000000
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@@ -1357,10 -1435,19 +1357,21 @@@ static struct iommu_device *arm_smmu_pr
   		fwspec = dev_iommu_fwspec_get(dev);
   		if (ret)
   			goto out_free;
  -	} else {
  +	} else if (fwspec && fwspec->ops == &arm_smmu_ops) {
   		smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
+
+ 		/*
+ 		 * Defer probe if the relevant SMMU instance hasn't finished
+ 		 * probing yet. This is a fragile hack and we'd ideally
+ 		 * avoid this race in the core code. Until that's ironed
+ 		 * out, however, this is the most pragmatic option on the
+ 		 * table.
+ 		 */
+ 		if (!smmu)
+ 			return ERR_PTR(dev_err_probe(dev, -EPROBE_DEFER,
+ 						"smmu dev has not bound yet\n"));
  +	} else {
  +		return ERR_PTR(-ENODEV);
   	}
   
   	ret = -EINVAL;

> 
> 
> 
> commit 62dc845a353efab2254480df8ae7d06175627313
> Author: Pratyush Brahma <quic_pbrahma@quicinc.com>
> Date:   Fri Oct 4 14:34:28 2024 +0530
> 
>      iommu/arm-smmu: Defer probe of clients after smmu device bound
>      
>      [ Upstream commit 229e6ee43d2a160a1592b83aad620d6027084aad ]
>      
>      Null pointer dereference occurs due to a race between smmu
>      driver probe and client driver probe, when of_dma_configure()
>      for client is called after the iommu_device_register() for smmu driver
>      probe has executed but before the driver_bound() for smmu driver
>      has been called.
>      
>      Following is how the race occurs:
>      
>      T1:Smmu device probe            T2: Client device probe
>      
>      really_probe()
>      arm_smmu_device_probe()
>      iommu_device_register()
>                                              really_probe()
>                                              platform_dma_configure()
>                                              of_dma_configure()
>                                              of_dma_configure_id()
>                                              of_iommu_configure()
>                                              iommu_probe_device()
>                                              iommu_init_device()
>                                              arm_smmu_probe_device()
>                                              arm_smmu_get_by_fwnode()
>                                                      driver_find_device_by_fwnode()
>                                                      driver_find_device()
>                                                      next_device()
>                                                      klist_next()
>                                                          /* null ptr
>                                                             assigned to smmu */
>                                              /* null ptr dereference
>                                                 while smmu->streamid_mask */
>      driver_bound()
>              klist_add_tail()
>      
>      When this null smmu pointer is dereferenced later in
>      arm_smmu_probe_device, the device crashes.
>      
>      Fix this by deferring the probe of the client device
>      until the smmu device has bound to the arm smmu driver.
>      
>      Fixes: 021bb8420d44 ("iommu/arm-smmu: Wire up generic configuration support")
>      Cc: stable@vger.kernel.org
>      Co-developed-by: Prakash Gupta <quic_guptap@quicinc.com>
>      Signed-off-by: Prakash Gupta <quic_guptap@quicinc.com>
>      Signed-off-by: Pratyush Brahma <quic_pbrahma@quicinc.com>
>      Link: https://lore.kernel.org/r/20241004090428.2035-1-quic_pbrahma@quicinc.com
>      [will: Add comment]
>      Signed-off-by: Will Deacon <will@kernel.org>
>      Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 8203a06014d71..b40ffa1ec2db6 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -1354,6 +1354,17 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
>   			goto out_free;
>   	} else {
>   		smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
> +
> +		/*
> +		 * Defer probe if the relevant SMMU instance hasn't finished
> +		 * probing yet. This is a fragile hack and we'd ideally
> +		 * avoid this race in the core code. Until that's ironed
> +		 * out, however, this is the most pragmatic option on the
> +		 * table.
> +		 */
> +		if (!smmu)
> +			return ERR_PTR(dev_err_probe(dev, -EPROBE_DEFER,
> +						"smmu dev has not bound yet\n"));
>   	}
>   
>   	ret = -EINVAL;


