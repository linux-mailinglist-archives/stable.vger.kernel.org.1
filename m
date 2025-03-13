Return-Path: <stable+bounces-124255-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 278E2A5EF3A
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 10:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02C9C1891268
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 09:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD8D262D35;
	Thu, 13 Mar 2025 09:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Sr7FQmbf"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE31D260366;
	Thu, 13 Mar 2025 09:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741857165; cv=none; b=Zt4fqTACrLNpzCb6mONtv0VfIBZ/EVrklgKBGyF6aGWCU4G2Yj0PHOxezfRxa9vX9Z0dbnLtQfN7JoNG+bX7ZAm3Hd54n/KmehsvN6G1DLuMQgjZhVWmAwwAMDYwVQdBraUPf6swQxTbLFVeFPZ0MHcuqNUrg8qji3hOT39nsUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741857165; c=relaxed/simple;
	bh=uTEaSRZsJgFfgkZ3VOyolYc6GyqLe0yGcrYdw2LuRww=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Fqg5666+AXhil8gpv3toOVNH19CSQhL1lJmlDAqKWAbvB4xA1GPcjiqwjb6N0ue7yrq1FIMySVaKJn6oNGvVoAklcUp5eO9plOnTOkP2mhdOW+j+FQt0JcC8T8JYRNfyItfmkPOmbLeavMsd0aZee0q1WJTm9aJM+SQQT/296qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Sr7FQmbf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CL0qh1015201;
	Thu, 13 Mar 2025 09:12:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s0gGelYTtUTXED4sQM7Y1qb3R7xRCkT2NjyZq2RIRXY=; b=Sr7FQmbfh+Ap2aZt
	8DtC2ddyaUuhz0GhFo5i6eMFsDzGp3munsBgaGKg35dbemU3e6loWwrndSKI5RSx
	nF29QJNdN7ITWlevWLLDeU+mMcVvyO7ADZ3x7caklLcKj7iKBfNDC7M3DDpt2G5b
	PU/XL6WmqgH5z5u/eMzpB0MxqF5mx6N6O3G5G1xIe2M4Ue8NYtIWlMP2lS/N8KaN
	JouE/wncnwwh87SiDAcrwuvRatSq7GeOvhhOwZu6nIgm+USXcmNceH3pUxyXtDFx
	CzcNA8ZfVz/y0X2qEpXSaCOAzxhaStym3IvIUXVEnvPjwKXC5PaZhNhVdzQgongN
	zYNK2Q==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2nw9ug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 09:12:39 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52D9CdvH031911
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 09:12:39 GMT
Received: from [10.219.56.132] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 13 Mar
 2025 02:12:37 -0700
Subject: Re: [PATCH v1] remoteproc: Add device awake calls in rproc boot and
 shutdown path
To: Mathieu Poirier <mathieu.poirier@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250303090852.301720-1-quic_schowdhu@quicinc.com>
CC: stable <stable@vger.kernel.org>
From: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Message-ID: <ec46a72f-f31b-c306-e57d-9bb7f58b24a2@quicinc.com>
Date: Thu, 13 Mar 2025 14:42:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250303090852.301720-1-quic_schowdhu@quicinc.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3nGPCc_mljfrqdTVSlxiDDPjyPJwDPlp
X-Authority-Analysis: v=2.4 cv=ZObXmW7b c=1 sm=1 tr=0 ts=67d2a187 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=N659UExz7-8A:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=Gcv-zj3phD6dloYkHJcA:9 a=9OQxM8gU87OQXBgV:21
 a=pILNOxqGKmIA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 3nGPCc_mljfrqdTVSlxiDDPjyPJwDPlp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_04,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130072

Gentle Reminder.


On 3/3/2025 2:38 PM, Souradeep Chowdhury wrote:
> Add device awake calls in case of rproc boot and rproc shutdown path.
> Currently, device awake call is only present in the recovery path
> of remoteproc. If a user stops and starts rproc by using the sysfs
> interface, then on pm suspension the firmware loading fails. Keep the
> device awake in such a case just like it is done for the recovery path.
>
> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> ---
>   drivers/remoteproc/remoteproc_core.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index c2cf0d277729..908a7b8f6c7e 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1916,7 +1916,8 @@ int rproc_boot(struct rproc *rproc)
>   		pr_err("invalid rproc handle\n");
>   		return -EINVAL;
>   	}
> -
> +	
> +	pm_stay_awake(rproc->dev.parent);
>   	dev = &rproc->dev;
>   
>   	ret = mutex_lock_interruptible(&rproc->lock);
> @@ -1961,6 +1962,7 @@ int rproc_boot(struct rproc *rproc)
>   		atomic_dec(&rproc->power);
>   unlock_mutex:
>   	mutex_unlock(&rproc->lock);
> +	pm_relax(rproc->dev.parent);
>   	return ret;
>   }
>   EXPORT_SYMBOL(rproc_boot);
> @@ -1991,6 +1993,7 @@ int rproc_shutdown(struct rproc *rproc)
>   	struct device *dev = &rproc->dev;
>   	int ret = 0;
>   
> +	pm_stay_awake(rproc->dev.parent);
>   	ret = mutex_lock_interruptible(&rproc->lock);
>   	if (ret) {
>   		dev_err(dev, "can't lock rproc %s: %d\n", rproc->name, ret);
> @@ -2027,6 +2030,7 @@ int rproc_shutdown(struct rproc *rproc)
>   	rproc->table_ptr = NULL;
>   out:
>   	mutex_unlock(&rproc->lock);
> +	pm_relax(rproc->dev.parent);
>   	return ret;
>   }
>   EXPORT_SYMBOL(rproc_shutdown);


