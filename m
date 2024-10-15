Return-Path: <stable+bounces-86351-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E623199ED9A
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 15:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A63F4286066
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E43014D439;
	Tue, 15 Oct 2024 13:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pwLTvBhF"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B201FC7C9;
	Tue, 15 Oct 2024 13:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728999122; cv=none; b=gfLbb/4WZIFkIe4naT6NHTxeD6ZLiEpXCe82VGTGOlwRpJEAxiIrxcM5KP3GaLlEahPQ2FQjZ34RIiZQMd6WyOc8YkCe/EqMS6iuec0P2rQ1N5rEm9gfXvhbq3ANtaGfAYS21M6TzwrrEMxjQZ5KZVWDJdO2//SDZVm8KkcbHD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728999122; c=relaxed/simple;
	bh=zcN5Xlyqvbbdst9rfv6DJMy58JEgi17eQkmigmRX3n8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IW/M2FXdWYZTbgNuK9BINUw1a/0Swa+pTVedwoUOpGG0/VF7E4PAzKtgwLb6ZS0QtnmD1P7hGg7j/rBFQ2Ak2/h462MpB7adMhhIfj+gJiwEmwhBJJCoq3GKobLBQ6f0jqFt93EEAQ9CNp/3ypLrrV+jMGc+uxGH9hWLbk/SVFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pwLTvBhF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FC6w7P012825;
	Tue, 15 Oct 2024 13:31:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kA4AcdIzhQcdO4VO4nfKsSVq2Fnc0aE3VWrEIVio3s4=; b=pwLTvBhFoURX8EdS
	yVolPTqMsxrN2BonyROYGPD2FOgK1id3jEuC2egfK1oldYhDbDhAPGVAEPv5e862
	w9ID7Mwyknx+1x93IgqJkZTSFxuoMhY2SJjBYcggD5b9TqiqdApyaxYtEocgt8ug
	n3EqCR5CBE4VYfrEBU8GjtR/nFYhHK4bXdyxiDI7bxBdUuOuFKaNhav3vOTsWYGd
	O51z8zo0PctdYBVemBStAvxn8Pgx0KwMANNErsbU44OdIYsDGqaHLepCuLoyBj52
	N+qdluXIYLPgXlWGmk0EuI+gxG885OBbS9WEfMohNtVtkcaVb4fT5taY828m5rwT
	x9DI/w==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 429e5g1qdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 13:31:38 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49FDVb8S015831
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 13:31:37 GMT
Received: from [10.216.56.224] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 15 Oct
 2024 06:31:33 -0700
Message-ID: <d4a52579-0e2a-4df3-a1fa-e8e154ff1e90@quicinc.com>
Date: Tue, 15 Oct 2024 19:01:30 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/arm-smmu: Defer probe of clients after smmu
 device bound
Content-Language: en-US
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@ziepe.ca>,
        <jsnitsel@redhat.com>, <robdclark@chromium.org>,
        <quic_c_gdjako@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <quic_charante@quicinc.com>,
        <stable@vger.kernel.org>, Prakash Gupta
	<quic_guptap@quicinc.com>
References: <20241004090428.2035-1-quic_pbrahma@quicinc.com>
From: Pratyush Brahma <quic_pbrahma@quicinc.com>
In-Reply-To: <20241004090428.2035-1-quic_pbrahma@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: D576OjrQQ18vkOw66nyELqYH4K7rmAq7
X-Proofpoint-ORIG-GUID: D576OjrQQ18vkOw66nyELqYH4K7rmAq7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 adultscore=0 impostorscore=0 mlxscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410150092


On 10/4/2024 2:34 PM, Pratyush Brahma wrote:
> Null pointer dereference occurs due to a race between smmu
> driver probe and client driver probe, when of_dma_configure()
> for client is called after the iommu_device_register() for smmu driver
> probe has executed but before the driver_bound() for smmu driver
> has been called.
>
> Following is how the race occurs:
>
> T1:Smmu device probe		T2: Client device probe
>
> really_probe()
> arm_smmu_device_probe()
> iommu_device_register()
> 					really_probe()
> 					platform_dma_configure()
> 					of_dma_configure()
> 					of_dma_configure_id()
> 					of_iommu_configure()
> 					iommu_probe_device()
> 					iommu_init_device()
> 					arm_smmu_probe_device()
> 					arm_smmu_get_by_fwnode()
> 						driver_find_device_by_fwnode()
> 						driver_find_device()
> 						next_device()
> 						klist_next()
> 						    /* null ptr
> 						       assigned to smmu */
> 					/* null ptr dereference
> 					   while smmu->streamid_mask */
> driver_bound()
> 	klist_add_tail()
>
> When this null smmu pointer is dereferenced later in
> arm_smmu_probe_device, the device crashes.
>
> Fix this by deferring the probe of the client device
> until the smmu device has bound to the arm smmu driver.
>
> Fixes: 021bb8420d44 ("iommu/arm-smmu: Wire up generic configuration support")
> Cc: stable@vger.kernel.org
> Co-developed-by: Prakash Gupta <quic_guptap@quicinc.com>
> Signed-off-by: Prakash Gupta <quic_guptap@quicinc.com>
> Signed-off-by: Pratyush Brahma <quic_pbrahma@quicinc.com>
> ---
> Changes in v2:
>   Fix kernel test robot warning
>   Add stable kernel list in cc
>   Link to v1: https://lore.kernel.org/all/20241001055633.21062-1-quic_pbrahma@quicinc.com/
>
>   drivers/iommu/arm/arm-smmu/arm-smmu.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 723273440c21..7c778b7eb8c8 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -1437,6 +1437,9 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
>   			goto out_free;
>   	} else {
>   		smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
> +		if (!smmu)
> +			return ERR_PTR(dev_err_probe(dev, -EPROBE_DEFER,
> +						"smmu dev has not bound yet\n"));
>   	}
>   
>   	ret = -EINVAL;


Hi
Can someone please review this patch? Let me know if any further 
information is required.

Thanks
Pratyush

