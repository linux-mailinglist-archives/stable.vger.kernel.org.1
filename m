Return-Path: <stable+bounces-104129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D145B9F1162
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 16:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 918D228096B
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 15:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F921E0DB3;
	Fri, 13 Dec 2024 15:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PSqyHddo"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206491DFE23
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 15:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734105136; cv=none; b=QreOWY/bCpdHFnhGZGrp+JZmJWK0+QJuRYyaGQi8iFM2BbmhEfMb61E9IdNK9+YQF4csl5OvOepwD2tHlBEpQA7Nmbi5Et+OHQGR3Udcq5D8xQFALgNGKHKMvp8g5+EzXUkZuvHmUNxnLgDrtcFkHt5GUUaKDJWhBn1yj5k/pto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734105136; c=relaxed/simple;
	bh=dwbAgLN7wOeup8afofTlH+j077v4hvEELyMHFY7A/j0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=U4FImNfLb5zZfOFx/LPuYJYaJ3tKrqZlgEkkbHHrvJh3BSI1SbB0rPEZ5bnkLSqeGI8QAv6bZLfO5IdDP6DsWuFGS3uY4sUOBu5KNq3trJY6/Pod3+FFgKByhKBaN8b8NGOO2bnZMkCbH3mx5iYhGBQkQ6iNwnEBSp+mVEBdoVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PSqyHddo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD80m2b032708;
	Fri, 13 Dec 2024 15:52:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UgnROq1vuYgmqCuJXhX8nM6TKA3LlEqSCIyNjDl+1lE=; b=PSqyHddof6xOAqEx
	PbavCwcYKbToFnnGZgXowSbHvwSqoflYi+/rKk/ToviaWkqgmHqajRGowZXuU2SK
	Ecn2hBCUq0KsV8B9+5JetWlG5W4O7fa7ptoByXXw2HVFoTZi55uzuchRB+riPcWZ
	hJTQHihYPpvDsDFgp4+EcgaPZDuX3V83KefSpLEuFBQmB617PSx4oPzfaSOrzIGp
	3kPnfAvgUlNGC4JHgR6OEhUS9na3tfe5lznrozuZZD2KQNpFJHoUe2ln7HY6XDcP
	2dJZRcOUGl1FTwksjGQo5uEl6sMXy0WgPAtjpB+1WOIXxnUTzcqu+4Pps9G1p9kk
	ZTOXbw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43f6tfg37v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 15:52:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BDFqALV029783
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 15:52:10 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 13 Dec
 2024 07:52:09 -0800
Message-ID: <4823e374-cb3b-5a23-93c0-db7286e12679@quicinc.com>
Date: Fri, 13 Dec 2024 08:52:08 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 1/3] accel/ivpu: Fix general protection fault in
 ivpu_bo_list()
Content-Language: en-US
To: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        <dri-devel@lists.freedesktop.org>
CC: <oded.gabbay@gmail.com>, <stable@vger.kernel.org>,
        Karol Wachowski
	<karol.wachowski@intel.com>
References: <20241210130939.1575610-1-jacek.lawrynowicz@linux.intel.com>
 <20241210130939.1575610-2-jacek.lawrynowicz@linux.intel.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20241210130939.1575610-2-jacek.lawrynowicz@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5SBk49dQkwv2oZsD42_l6GMavmjnPW0d
X-Proofpoint-ORIG-GUID: 5SBk49dQkwv2oZsD42_l6GMavmjnPW0d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130113

On 12/10/2024 6:09 AM, Jacek Lawrynowicz wrote:
> Check if ctx is not NULL before accessing its fields.
> 
> Fixes: 37dee2a2f433 ("accel/ivpu: Improve buffer object debug logs")
> Cc: <stable@vger.kernel.org> # v6.8
> Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
> Reviewed-by: Karol Wachowski <karol.wachowski@intel.com>
> ---
>   drivers/accel/ivpu/ivpu_gem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/ivpu/ivpu_gem.c b/drivers/accel/ivpu/ivpu_gem.c
> index d8e97a760fbc0..16178054e6296 100644
> --- a/drivers/accel/ivpu/ivpu_gem.c
> +++ b/drivers/accel/ivpu/ivpu_gem.c
> @@ -409,7 +409,7 @@ static void ivpu_bo_print_info(struct ivpu_bo *bo, struct drm_printer *p)
>   	mutex_lock(&bo->lock);
>   
>   	drm_printf(p, "%-9p %-3u 0x%-12llx %-10lu 0x%-8x %-4u",
> -		   bo, bo->ctx->id, bo->vpu_addr, bo->base.base.size,
> +		   bo, bo->ctx ? bo->ctx->id : 0, bo->vpu_addr, bo->base.base.size,
>   		   bo->flags, kref_read(&bo->base.base.refcount));
>   
>   	if (bo->base.pages)

Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

