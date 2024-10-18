Return-Path: <stable+bounces-86883-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 169859A4869
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 22:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CC54B21691
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 20:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33501209674;
	Fri, 18 Oct 2024 20:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DSgVihOz"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E364208D89
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 20:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729284298; cv=none; b=gBhvbIqAwigq/t1+mNva6q1qnBAO0L9tKwwTXH1uSZoTqhVHx7BIvapQTr5GR69c04hD0RYO+m1NWmcj+2Aupy39YyNXVEosqX+Rano07Oio/HYwtlzrddFJw6sRMp1mMB1ODG/r0OYbHvAUfelluPuUE1GK8xQHuWcd8sjky6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729284298; c=relaxed/simple;
	bh=UOPVUjYYpyhkrKTbr7TBD7LxdCqfM80WcT7UgU+k3S4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aGdiYAUM896kIlgLefUCYpTnIZvdMpm2gkS6u/s9CD5/0vni+82Ngh7FDKpSGgbRkLAqpmTWT4ubzrGAOl/DxKD9lavxL3NdgqL/k/liRxO7Vqu6KtiG2mO7MH6BZ/u56F2fEHOrMTSb5bwnFqwzJstpRjNrv71m9Mp49tACers=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DSgVihOz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49I9dh3g019911;
	Fri, 18 Oct 2024 20:44:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	djD97t/1pqdO0YvT1XfLWBgRvfISWNevVPNgZchv8oE=; b=DSgVihOz02yS+yx4
	YrZSKDQLSwjoK5+Zq5wn3L4JpOdIghkrfhtMW80VCRGyhMQx1V+ZW0A0DaRSLoRU
	Lfut+dN2QPs8PoAGZZzXgDTM4JDQ97IbWkhl4jzpPDsZEDMFlJNiITBmO6DhSu/C
	CCKvChY0hPNntxEDCVsCrZgxziIxl64d5w3DYnfICIQTy5U6g1DvAmuPXMFiscUb
	Xy7o83T4hseOwm1cSldAIAn/Pa0zD0auPHhKEuI1hbH3KFf88Fm0CwcYlxhKLnlY
	PTk7a0QmIkuRGBkti1HqWa5uV3GyMav7lnQQOm1G/OB+FKItaSqk6pfOJMbQmKK6
	OttK2w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42b0rx5asr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 20:44:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49IKiqiJ029692
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 20:44:52 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 18 Oct
 2024 13:44:52 -0700
Message-ID: <96bfcac0-603e-0cc8-b267-e9ba43fe913e@quicinc.com>
Date: Fri, 18 Oct 2024 14:44:51 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] accel/ivpu: Fix NOC firewall interrupt handling
Content-Language: en-US
To: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        <dri-devel@lists.freedesktop.org>
CC: <oded.gabbay@gmail.com>,
        Andrzej Kacprowski
	<Andrzej.Kacprowski@intel.com>,
        <stable@vger.kernel.org>
References: <20241017144958.79327-1-jacek.lawrynowicz@linux.intel.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20241017144958.79327-1-jacek.lawrynowicz@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zTuv5g5ayVBdMLwF2O79RCufW-aep9Hs
X-Proofpoint-ORIG-GUID: zTuv5g5ayVBdMLwF2O79RCufW-aep9Hs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1011
 mlxscore=0 priorityscore=1501 spamscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180132

On 10/17/2024 8:49 AM, Jacek Lawrynowicz wrote:
> From: Andrzej Kacprowski <Andrzej.Kacprowski@intel.com>
> 
> The NOC firewall interrupt means that the HW prevented
> unauthorized access to a protected resource, so there
> is no need to trigger device reset in such case.
> 
> To facilitate security testing add firewall_irq_counter
> debugfs file that tracks firewall interrupts.
> 
> Fixes: 8a27ad81f7d3 ("accel/ivpu: Split IP and buttress code")
> Cc: <stable@vger.kernel.org> # v6.11+
> Signed-off-by: Andrzej Kacprowski <Andrzej.Kacprowski@intel.com>
> Reviewed-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
> Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
> ---
>   drivers/accel/ivpu/ivpu_debugfs.c | 9 +++++++++
>   drivers/accel/ivpu/ivpu_hw.c      | 1 +
>   drivers/accel/ivpu/ivpu_hw.h      | 1 +
>   drivers/accel/ivpu/ivpu_hw_ip.c   | 5 ++++-
>   4 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/ivpu/ivpu_debugfs.c b/drivers/accel/ivpu/ivpu_debugfs.c
> index 8958145c49adb..8180b95ed69dc 100644
> --- a/drivers/accel/ivpu/ivpu_debugfs.c
> +++ b/drivers/accel/ivpu/ivpu_debugfs.c
> @@ -116,6 +116,14 @@ static int reset_pending_show(struct seq_file *s, void *v)
>   	return 0;
>   }
>   
> +static int firewall_irq_counter_show(struct seq_file *s, void *v)
> +{
> +	struct ivpu_device *vdev = seq_to_ivpu(s);
> +
> +	seq_printf(s, "%d\n", atomic_read(&vdev->hw->firewall_irq_counter));
> +	return 0;
> +}
> +
>   static const struct drm_debugfs_info vdev_debugfs_list[] = {
>   	{"bo_list", bo_list_show, 0},
>   	{"fw_name", fw_name_show, 0},
> @@ -125,6 +133,7 @@ static const struct drm_debugfs_info vdev_debugfs_list[] = {
>   	{"last_bootmode", last_bootmode_show, 0},
>   	{"reset_counter", reset_counter_show, 0},
>   	{"reset_pending", reset_pending_show, 0},
> +	{"firewall_irq_counter", firewall_irq_counter_show, 0},
>   };
>   
>   static int dvfs_mode_get(void *data, u64 *dvfs_mode)
> diff --git a/drivers/accel/ivpu/ivpu_hw.c b/drivers/accel/ivpu/ivpu_hw.c
> index 09ada8b500b99..4e1054f3466e8 100644
> --- a/drivers/accel/ivpu/ivpu_hw.c
> +++ b/drivers/accel/ivpu/ivpu_hw.c
> @@ -252,6 +252,7 @@ int ivpu_hw_init(struct ivpu_device *vdev)
>   	platform_init(vdev);
>   	wa_init(vdev);
>   	timeouts_init(vdev);
> +	atomic_set(&vdev->hw->firewall_irq_counter, 0);
>   
>   	return 0;
>   }
> diff --git a/drivers/accel/ivpu/ivpu_hw.h b/drivers/accel/ivpu/ivpu_hw.h
> index dc5518248c405..fc4dbfc980c81 100644
> --- a/drivers/accel/ivpu/ivpu_hw.h
> +++ b/drivers/accel/ivpu/ivpu_hw.h
> @@ -51,6 +51,7 @@ struct ivpu_hw_info {
>   	int dma_bits;
>   	ktime_t d0i3_entry_host_ts;
>   	u64 d0i3_entry_vpu_ts;
> +	atomic_t firewall_irq_counter;

Why atomic?

>   };
>   
>   int ivpu_hw_init(struct ivpu_device *vdev);
> diff --git a/drivers/accel/ivpu/ivpu_hw_ip.c b/drivers/accel/ivpu/ivpu_hw_ip.c
> index b9b16f4041434..029dd065614b2 100644
> --- a/drivers/accel/ivpu/ivpu_hw_ip.c
> +++ b/drivers/accel/ivpu/ivpu_hw_ip.c
> @@ -1073,7 +1073,10 @@ static void irq_wdt_mss_handler(struct ivpu_device *vdev)
>   
>   static void irq_noc_firewall_handler(struct ivpu_device *vdev)
>   {
> -	ivpu_pm_trigger_recovery(vdev, "NOC Firewall IRQ");
> +	atomic_inc(&vdev->hw->firewall_irq_counter);
> +
> +	ivpu_dbg(vdev, IRQ, "NOC Firewall interrupt detected, counter %d\n",
> +		 atomic_read(&vdev->hw->firewall_irq_counter));
>   }
>   
>   /* Handler for IRQs from NPU core */


