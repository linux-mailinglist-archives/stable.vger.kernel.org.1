Return-Path: <stable+bounces-55982-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB1E91AE4B
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 19:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0B8FB2AE5A
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 17:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02B019A2A2;
	Thu, 27 Jun 2024 17:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="M2y6MX0b"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC6D19A29A
	for <stable@vger.kernel.org>; Thu, 27 Jun 2024 17:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719509707; cv=none; b=K8gQpgq6/PTdsUaSt6M7zGCwlbcJWqkNkylb35py3l6dftmQ+E+t0fa0iIztifxUJu1VcpqkRAhJTcPejXh4LuhRPBVVfFHgVnoLrrwU35uFH7/2GzaVcIAZoS42ttQlNze+r9uivY0pixs5Eo430wrVPFC8IkOx2DzIuvdgNAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719509707; c=relaxed/simple;
	bh=gpOHZSjUWwwuSc80Iq46WGe79s0Xy9vm+P1ph9yiYOQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMWX4Nzkd3uk+9gqDVrzcguttnpdyvYAnOaSedbm3ahKQSvcNMsjyuD05j/R+p4NeNbUmljZbuXVp3vPSMHJ9rePzOD9FEIctpvxT7WVIE5Hr0pQwJ9Gs58OgIrGeW0ffKqsBLfOlJ6zWYGYBqLNWWVG2avp+YRJFspGhsQsBSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=M2y6MX0b; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45RBeKhr010649
	for <stable@vger.kernel.org>; Thu, 27 Jun 2024 17:35:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=igZDYm2sM2tRIfrKeQQCep0L
	C/7i+RjcDSKvO0GHFek=; b=M2y6MX0bO4MUgY7LwZ07b6thS8xfbb91Vsi+luPz
	ubh/wwGiaIY6ipXPo3mCgxdzVkIJUQKwu4elIAYsBLVtsgU+RNw/RGUdAzpFb7g5
	wM+8H4tnz8Wt3Wkmb93GoMN+b/hGoxdzmMyvA1sjIieKIZWidnfIL6NXj6pDXxkj
	SHsr+BIb92/LoCz3zpfkEokVaQhdtqIzyB8aoqXNcFKs9imjVeT3wtWy+Zhntm0K
	HQTkSut0+QNwZeXsFZPuxALvZGiLnYs0etv76GTk/8UMn+NqPX9O/BiIYVvxtIrx
	c3X7Kxv9gPJzEFn6+SzCr/hxl2jYbMZ5ngtIMonnhkHJPQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 400bdqcx45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 27 Jun 2024 17:35:04 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45RHZ3oq015524
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 27 Jun 2024 17:35:03 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 27 Jun 2024 10:35:00 -0700
Date: Thu, 27 Jun 2024 10:35:00 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
To: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
CC: Trilok Soni <quic_tsoni@quicinc.com>,
        Prasad Sodagudi
	<quic_psodagud@quicinc.com>,
        Satya Durga Srinivasu Prabhala
	<quic_satyap@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>, <kernel@quicinc.com>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH v7 3/3] firmware: qcom_scm: Mark get_wq_ctx() as atomic
 call
Message-ID: <20240627103449552-0700.eberman@hu-eberman-lv.qualcomm.com>
References: <cover.1719459967.git.quic_uchalich@quicinc.com>
 <02cbdb290d6a66ddc6e82b0839b007b9bcb7a6d1.1719459967.git.quic_uchalich@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <02cbdb290d6a66ddc6e82b0839b007b9bcb7a6d1.1719459967.git.quic_uchalich@quicinc.com>
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vDbdBFpbAQDRE2p8tNV_aaAxHtUojCdT
X-Proofpoint-GUID: vDbdBFpbAQDRE2p8tNV_aaAxHtUojCdT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_13,2024-06-27_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 clxscore=1011 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406270132

On Thu, Jun 27, 2024 at 10:29:05AM -0700, Unnathi Chalicheemala wrote:
> From: Murali Nalajala <quic_mnalajal@quicinc.com>
> 
> Currently get_wq_ctx() is wrongly configured as a
> standard call. When two SMC calls are in sleep and one
> SMC wakes up, it calls get_wq_ctx() to resume the
> corresponding sleeping thread. But if get_wq_ctx() is
> interrupted, goes to sleep and another SMC call is
> waiting to be allocated a waitq context, it leads to a
> deadlock.
> 
> To avoid this get_wq_ctx() must be an atomic call and
> can't be a standard SMC call. Hence mark get_wq_ctx()
> as a fast call.
> 
> Fixes: 6bf325992236 ("firmware: qcom: scm: Add wait-queue handling logic")
> Cc: stable@vger.kernel.org
> Signed-off-by: Murali Nalajala <quic_mnalajal@quicinc.com>
> Signed-off-by: Unnathi Chalicheemala <quic_uchalich@quicinc.com>

Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  drivers/firmware/qcom/qcom_scm-smc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/qcom/qcom_scm-smc.c b/drivers/firmware/qcom/qcom_scm-smc.c
> index 16cf88acfa8e..0a2a2c794d0e 100644
> --- a/drivers/firmware/qcom/qcom_scm-smc.c
> +++ b/drivers/firmware/qcom/qcom_scm-smc.c
> @@ -71,7 +71,7 @@ int scm_get_wq_ctx(u32 *wq_ctx, u32 *flags, u32 *more_pending)
>  	struct arm_smccc_res get_wq_res;
>  	struct arm_smccc_args get_wq_ctx = {0};
>  
> -	get_wq_ctx.args[0] = ARM_SMCCC_CALL_VAL(ARM_SMCCC_STD_CALL,
> +	get_wq_ctx.args[0] = ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,
>  				ARM_SMCCC_SMC_64, ARM_SMCCC_OWNER_SIP,
>  				SCM_SMC_FNID(QCOM_SCM_SVC_WAITQ, QCOM_SCM_WAITQ_GET_WQ_CTX));
>  
> -- 
> 2.34.1
> 

