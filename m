Return-Path: <stable+bounces-94554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C79A29D5478
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 22:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7879D282891
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 21:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722231CB50D;
	Thu, 21 Nov 2024 21:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Iv2YFGKS"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808311C4A37;
	Thu, 21 Nov 2024 21:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732223146; cv=none; b=Xr8fRhc8CF5YhEIPY+Nv9p/CjWWHdlYfu2+DVtCdVIMBMGIcC4XdBIFcGcEMYsICImjaM7yKLYxXnI+rn+Gysm7F8PAHuresMunu78zZcXNO47GmGn0evR+3VGTH2TyqWVQoWTTRoi6ZqG+TKS0HVrTLpRfEJaPrhyQ+a8NMPvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732223146; c=relaxed/simple;
	bh=gw1tJIqkMGOaEZEiHOVMnC3z/QBXOhvkX2lqrb9Gtk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=T3rW1EMJ3zVN9BzT/YRvSQA/B1TbX6brtEPGJVmEDcxil7QG+ySnKi2YP5ns3/u9NaChiE0oyhpY2ba0/ac3hossop3WS80O78pfS3pVw3HjBdvF7HYtDYLlZPuZXCrhpOJYmG7CnZzw6KHtmC/JRcfgfi4296y9n+n7UEWzgng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Iv2YFGKS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALAVfa4019543;
	Thu, 21 Nov 2024 21:05:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	un1FCtaOdcHIAYWQrVaVMRtafW+TeXyGpU1qCbD4cQU=; b=Iv2YFGKS4ChNkTql
	g8iCYQuZrqDLbxlwuPivpxxigwj+Kmnm5ld9fUNXJaRbdeeiCEtqBej81IX/VhaH
	jB5bm6YumqMz8XHyF28XTyvsFyjzaGa6iIqnyAXRsfekmuW9+FRWc4S2NFM0Lwaa
	Bebuq/lfxeYlUHp14D3FccIrKMQwMzg1VGhP2eSELfmn85TiLfo3Oy60Jf/NWeto
	qZDPr/Zhk+wDysMe1T3NjbZLZI+KwAlaKFQjQ3jY5e6w0MXZ22JI/ncfmfG8DBXT
	8DR3Xs77uKBbQK+AQyY7ICMRtHXcpYfMhsuEpWXW3glWiHtzFAOQVpBJWtQWmKTN
	+L60Ww==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 431sv2k4na-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 21:05:24 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ALL5MQm005703
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 21:05:22 GMT
Received: from [10.216.44.227] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 21 Nov
 2024 13:05:17 -0800
Message-ID: <124a3aba-138c-41e8-abe0-e6b75f0d8aee@quicinc.com>
Date: Fri, 22 Nov 2024 02:35:13 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/arm-smmu: Defer probe of clients after smmu
 device bound
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
CC: <catalin.marinas@arm.com>, <kernel-team@android.com>, <joro@8bytes.org>,
        <jgg@ziepe.ca>, <jsnitsel@redhat.com>, <robdclark@chromium.org>,
        <quic_c_gdjako@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <quic_charante@quicinc.com>,
        <stable@vger.kernel.org>, Prakash Gupta <quic_guptap@quicinc.com>
References: <20241004090428.2035-1-quic_pbrahma@quicinc.com>
 <173021496151.4097715.14758035881649445798.b4-ty@kernel.org>
 <0952ca36-c5d9-462a-ab7b-b97154c56919@arm.com>
 <1d3dcd91-d246-4db3-9717-9edfe405f431@quicinc.com>
 <57477eba-ef6a-454b-85d1-d0244f6116d1@arm.com>
Content-Language: en-US
From: Pratyush Brahma <quic_pbrahma@quicinc.com>
In-Reply-To: <57477eba-ef6a-454b-85d1-d0244f6116d1@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MawJVwAjKTK0gsoaaSF6X6yYMat8Kf2R
X-Proofpoint-ORIG-GUID: MawJVwAjKTK0gsoaaSF6X6yYMat8Kf2R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1011 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411210157


On 11/21/2024 8:19 PM, Robin Murphy wrote:
> On 2024-11-19 7:10 pm, Pratyush Brahma wrote:
>>
>> On 11/7/2024 8:31 PM, Robin Murphy wrote:
>>> On 29/10/2024 4:15 pm, Will Deacon wrote:
>>>> On Fri, 04 Oct 2024 14:34:28 +0530, Pratyush Brahma wrote:
>>>>> Null pointer dereference occurs due to a race between smmu
>>>>> driver probe and client driver probe, when of_dma_configure()
>>>>> for client is called after the iommu_device_register() for smmu 
>>>>> driver
>>>>> probe has executed but before the driver_bound() for smmu driver
>>>>> has been called.
>>>>>
>>>>> Following is how the race occurs:
>>>>>
>>>>> [...]
>>>>
>>>> Applied to will (for-joerg/arm-smmu/updates), thanks!
>>>>
>>>> [1/1] iommu/arm-smmu: Defer probe of clients after smmu device bound
>>>>        https://git.kernel.org/will/c/229e6ee43d2a
>>>
>>> I've finally got to the point of proving to myself that this isn't the
>>> right fix, since once we do get __iommu_probe_device() working properly
>>> in the correct order, iommu_device_register() then runs into the same
>>> condition itself. Diff below should make this issue go away - I'll 
>>> write
>>> up proper patches once I've tested it a little more.
>>>
>>> Thanks,
>>> Robin.
>>>
>>> ----->8-----
>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/ 
>>> iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> index 737c5b882355..b7dcb1494aa4 100644
>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> @@ -3171,8 +3171,8 @@ static struct platform_driver arm_smmu_driver;
>>>  static
>>>  struct arm_smmu_device *arm_smmu_get_by_fwnode(struct fwnode_handle 
>>> *fwnode)
>>>  {
>>> -    struct device *dev = 
>>> driver_find_device_by_fwnode(&arm_smmu_driver.driver,
>>> -                              fwnode);
>>> +    struct device *dev = 
>>> bus_find_device_by_fwnode(&platform_bus_type, fwnode);
>>> +      put_device(dev);
>>>      return dev ? dev_get_drvdata(dev) : NULL;
>>>  }
>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/ 
>>> arm/arm-smmu/arm-smmu.c
>>> index 8321962b3714..aba315aa6848 100644
>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>> @@ -1411,8 +1411,8 @@ static bool arm_smmu_capable(struct device 
>>> *dev, enum iommu_cap cap)
>>>  static
>>>  struct arm_smmu_device *arm_smmu_get_by_fwnode(struct fwnode_handle 
>>> *fwnode)
>>>  {
>>> -    struct device *dev = 
>>> driver_find_device_by_fwnode(&arm_smmu_driver.driver,
>>> -                              fwnode);
>>> +    struct device *dev = 
>>> bus_find_device_by_fwnode(&platform_bus_type, fwnode);
>> I think it would still follow this path:
>>
>> bus_find_device_by_fwnode() -> bus_find_device() -> next_device()
>>
>> next_device() would always return null until the driver is bound to 
>> the device which
>
> No, this is traversing the bus list, *not* the driver list, that's the 
> whole point. The SMMU device must exist on the platform bus before the 
> driver can bind, since the bus is responsible for matching the driver 
> in the first place.
Ah I see. Thanks for the explanation. That makes sense.
>
>> happens much later in really_probe() after the 
>> iommu_device_register() would be called
>> even as per this patch. That way the race would still occur, wouldn't 
>> it?
>> Can you please help me understand what I may be missing here?
>> Are you saying that these additional patches are required along with 
>> the fix I've
>> posted?
>
> I'm saying my change makes there be no race, i.e. the "if (!smmu)" 
> case can never be true, and so no longer needs working around.
Got it. Thanks.
>
> Thanks,
> Robin.
>
>>> +
>>>      put_device(dev);
>>>      return dev ? dev_get_drvdata(dev) : NULL;
>>>  }
>>> @@ -2232,21 +2232,6 @@ static int arm_smmu_device_probe(struct 
>>> platform_device *pdev)
>>>                      i, irq);
>>>      }
>>>
>>> -    err = iommu_device_sysfs_add(&smmu->iommu, smmu->dev, NULL,
>>> -                     "smmu.%pa", &smmu->ioaddr);
>>> -    if (err) {
>>> -        dev_err(dev, "Failed to register iommu in sysfs\n");
>>> -        return err;
>>> -    }
>>> -
>>> -    err = iommu_device_register(&smmu->iommu, &arm_smmu_ops,
>>> -                    using_legacy_binding ? NULL : dev);
>>> -    if (err) {
>>> -        dev_err(dev, "Failed to register iommu\n");
>>> -        iommu_device_sysfs_remove(&smmu->iommu);
>>> -        return err;
>>> -    }
>>> -
>>>      platform_set_drvdata(pdev, smmu);
>>>
>>>      /* Check for RMRs and install bypass SMRs if any */
>>> @@ -2255,6 +2240,18 @@ static int arm_smmu_device_probe(struct 
>>> platform_device *pdev)
>>>      arm_smmu_device_reset(smmu);
>>>      arm_smmu_test_smr_masks(smmu);
>>>
>>> +    err = iommu_device_sysfs_add(&smmu->iommu, smmu->dev, NULL,
>>> +                     "smmu.%pa", &smmu->ioaddr);
>>> +    if (err)
>>> +        return dev_err_probe(dev, err, "Failed to register iommu in 
>>> sysfs\n");
>>> +
>>> +    err = iommu_device_register(&smmu->iommu, &arm_smmu_ops,
>>> +                    using_legacy_binding ? NULL : dev);
>>> +    if (err) {
>>> +        iommu_device_sysfs_remove(&smmu->iommu);
>>> +        return dev_err_probe(dev, err, "Failed to register iommu\n");
>>> +    }
>>> +
>>>      /*
>>>       * We want to avoid touching dev->power.lock in fastpaths unless
>>>       * it's really going to do something useful - pm_runtime_enabled()
>>
>
-- 
Thanks and Regards
Pratyush Brahma


