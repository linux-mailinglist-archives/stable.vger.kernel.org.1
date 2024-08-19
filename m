Return-Path: <stable+bounces-69483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4409566E6
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 11:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4984A2816AF
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 09:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BD715ECD1;
	Mon, 19 Aug 2024 09:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bdyDEa3r"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09BA15ECC2;
	Mon, 19 Aug 2024 09:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724059744; cv=none; b=Y5iE9EB6uvly7NuCbOcu9XpgYIHlJx+gLvz+gPFJaDydSS+Scre0ei3VG/kgJVLz6jcIiCgj62nGWCG0ZVeOBVq2U2AKluiZjBC8Kg2fvN2nkzROk4sYQIYZPKBhH0is0PhnV/U5mjuvajZ9pDImRr226gtARhqr5jwuO615kPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724059744; c=relaxed/simple;
	bh=O3anHyxZGKI47++zGmsoUsfSAf8M8dwURXdMCZnQxTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SHTQjtSI8yCunoGQ585vvodVhHoQCEptUeP1zdMeV/wvAT9XdA9pTGgz1FJUF9zHQh6QFwesOQvOUuZA0jZyE73XhXNsHTOgARKwg2Yy9pnCyeurN5+v0VPeJC3KwuzGj4n6sJyREq0H+BrPzyZcTLH2mbaV7I1EVIVGG0UpaiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bdyDEa3r; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47INk1Za002536;
	Mon, 19 Aug 2024 09:28:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5oqXScjibZQjsUj+JfXXMkmZzpjNKCj5FEqv1WndicE=; b=bdyDEa3rWCYoBwEl
	kdtWwVQpvFKkm4rNx+SF8eSnUw5ft/DEhg/Pqz1f9SRXIa3JuBJ1KLT40WJ2vKDq
	HlJoIuDzFrLLSEaLv4t2ERoI9Bys3+Jau1l7bOiAL3IRwDlefgt5VC7340XU9PbB
	+CvjJiJp+YCCc8RJa/KYkkYZv8azZZCjtttW8QRE4GB7wkeBP5eVxZtd7JbH/XOP
	vCZF+Ay399uwx6beyVFgsvQBtnefzQTcFY16fkCuuaOFcs5BMSJqFn2KiAP8go6X
	9Fz77EZzDxy5sCgHbUlmnFga11TPbpeHSVVappFMTmJYEcDyR2C2BGlJyVfKt7Cr
	gUMcGQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 412key3pdu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 09:28:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47J9Ssmb013173
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 09:28:54 GMT
Received: from [10.216.31.248] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 19 Aug
 2024 02:28:49 -0700
Message-ID: <9de9be29-2f75-41a1-931b-f8cf0a9904ac@quicinc.com>
Date: Mon, 19 Aug 2024 14:58:46 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: dwc3: core: Prevent USB core invalid event buffer
 address access
To: Selvarasu Ganesan <selvarasu.g@samsung.com>, <Thinh.Nguyen@synopsys.com>,
        <gregkh@linuxfoundation.org>
CC: <jh0801.jung@samsung.com>, <dh10.jung@samsung.com>, <naushad@samsung.com>,
        <akash.m5@samsung.com>, <rc93.raju@samsung.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <taehyun.cho@samsung.com>, <hongpooh.kim@samsung.com>,
        <eomji.oh@samsung.com>, <shijie.cai@samsung.com>,
        <stable@vger.kernel.org>
References: <CGME20240808120605epcas5p2c9164533413706da5f7fa2ed624318cd@epcas5p2.samsung.com>
 <20240808120507.1464-1-selvarasu.g@samsung.com>
Content-Language: en-US
From: Krishna Kurapati <quic_kriskura@quicinc.com>
In-Reply-To: <20240808120507.1464-1-selvarasu.g@samsung.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xDRjhdP30BnRxcaFntPhAlO8_h_fcSGR
X-Proofpoint-GUID: xDRjhdP30BnRxcaFntPhAlO8_h_fcSGR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_08,2024-08-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 clxscore=1011 impostorscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408190065



On 8/8/2024 5:35 PM, Selvarasu Ganesan wrote:
> This commit addresses an issue where the USB core could access an
> invalid event buffer address during runtime suspend, potentially causing
> SMMU faults and other memory issues. The problem arises from the
> following sequence.
>          1. In dwc3_gadget_suspend, there is a chance of a timeout when
>          moving the USB core to the halt state after clearing the
>          run/stop bit by software.
>          2. In dwc3_core_exit, the event buffer is cleared regardless of
>          the USB core's status, which may lead to an SMMU faults and
>          other memory issues. if the USB core tries to access the event
>          buffer address.
> 
> To prevent this issue, this commit ensures that the event buffer address
> is not cleared by software  when the USB core is active during runtime
> suspend by checking its status before clearing the buffer address.
> 
> Cc: stable@vger.kernel.org
> Fixes: 89d7f9629946 ("usb: dwc3: core: Skip setting event buffers for host only controllers")

I don't think the fixes tag is right.

This fix is independent of whether controller is host only capable or 
not. This is fixing the original commit that introduced the cleanup call.

Regards,
Krishna,

> Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
> ---
> 
> Changes in v2:
> - Added separate check for USB controller status before cleaning the
>    event buffer.
> - Link to v1: https://lore.kernel.org/lkml/20240722145617.537-1-selvarasu.g@samsung.com/
> ---
>   drivers/usb/dwc3/core.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 734de2a8bd21..5b67d9bca71b 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -564,10 +564,15 @@ int dwc3_event_buffers_setup(struct dwc3 *dwc)
>   void dwc3_event_buffers_cleanup(struct dwc3 *dwc)
>   {
>   	struct dwc3_event_buffer	*evt;
> +	u32				reg;
>   
>   	if (!dwc->ev_buf)
>   		return;
>   
> +	reg = dwc3_readl(dwc->regs, DWC3_DSTS);
> +	if (!(reg & DWC3_DSTS_DEVCTRLHLT))
> +		return;
> +
>   	evt = dwc->ev_buf;
>   
>   	evt->lpos = 0;

