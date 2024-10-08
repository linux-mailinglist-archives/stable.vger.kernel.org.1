Return-Path: <stable+bounces-81506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D03993DEB
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 06:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04CD61C24293
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 04:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A817613A3E4;
	Tue,  8 Oct 2024 04:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jfc2h/by"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981D312C484;
	Tue,  8 Oct 2024 04:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728361486; cv=none; b=P64XfuqqWioJsPvt2vTjkDsFnL/5fothBq40ANykkmtV/DeNi6Bl7pje4JYEbk/tTiHzmlV9nXWrBon7MnqdTp9UyqV0kqpG86JodXXwU5/r/ixGK17hM9DO7qUphoTSHg3yH4atrEhErO9iXM2193tamUESOXre2liYDl3fzgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728361486; c=relaxed/simple;
	bh=kYAwpPEz6Y3q/ucp6yWxwFRrvxzbTjllblbaSlC8xI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BKkNSS4dtL3OxaX+s2h5awCp6ZjPFcH3WbF0ptzjloWtP9DttM68mpJFaqixICwxUnoC5vUuR6YnMk3r2PFwYIKMcNTISBAhz/oOPneTsdNWTkHFZkhn+oPx3qIAwPXzRwXSLFNAAxeiVzqCwyV+XsoVFMXjXW+u1DB29JlUNLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jfc2h/by; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4984CPJ3032334;
	Tue, 8 Oct 2024 04:24:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ouepXPGt0NMprp8/XMBwCLOZm+svf2WQeJuFXRb6ic0=; b=jfc2h/byG5vVfJC+
	sGTpay1sXziwHOIJjYp4kLaRAxMe/CgV5OrXmh8WPOSTcf8r9IO3Ls5QVWoC5eCW
	vUtPs9LtuUe/Y46DC8qTw/PE5OXgz2v+vuZueq93nAXMoR+zipjG+0qDzOHLo5mP
	AoC+hwmxxoJCXeIE4w47tHt0sZnjNgEi0sIkKFIQRQUJisH+4RQzdynKbYZu2cmx
	7Vm4J1R3/Wh7Pyg1ELVEFdqiQ/0Jcy9hxnNRqxQBG/C8DoZssvrn35ncccIn9kJN
	skgA7ZJJv33UY8VuxkgMqDqO4l4cYsfvBsd7FnpGiv4At3/BbbeR7BQ/6VT50UHv
	DpWmrg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 424wgs00n9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 04:24:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4984OeKd011713
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 8 Oct 2024 04:24:40 GMT
Received: from [10.218.35.239] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 7 Oct 2024
 21:24:38 -0700
Message-ID: <8fb5bfd8-966e-4f55-9563-b580ad3bb892@quicinc.com>
Date: Tue, 8 Oct 2024 09:54:20 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3: Wait for EndXfer completion before restoring
 GUSB2PHYCFG
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20240924093208.2524531-1-quic_prashk@quicinc.com>
Content-Language: en-US
From: Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <20240924093208.2524531-1-quic_prashk@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: acD5MiKBQhzLHCyLp5v_y26tzfR68cUx
X-Proofpoint-ORIG-GUID: acD5MiKBQhzLHCyLp5v_y26tzfR68cUx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=806
 suspectscore=0 impostorscore=0 bulkscore=0 clxscore=1011 adultscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080027



On 24-09-24 03:02 pm, Prashanth K wrote:
> DWC3 programming guide mentions that when operating in USB2.0 speeds,
> if GUSB2PHYCFG[6] or GUSB2PHYCFG[8] is set, it must be cleared prior
> to issuing commands and may be set again  after the command completes.
> But currently while issuing EndXfer command without CmdIOC set, we
> wait for 1ms after GUSB2PHYCFG is restored. This results in cases
> where EndXfer command doesn't get completed and causes SMMU faults
> since requests are unmapped afterwards. Hence restore GUSB2PHYCFG
> after waiting for EndXfer command completion.
> 
> Cc: stable@vger.kernel.org
> Fixes: 1d26ba0944d3 ("usb: dwc3: Wait unconditionally after issuing EndXfer command")
> Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
> ---
>  drivers/usb/dwc3/gadget.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 291bc549935b..50772d611582 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -438,6 +438,10 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
>  			dwc3_gadget_ep_get_transfer_index(dep);
>  	}
>  
> +	if (DWC3_DEPCMD_CMD(cmd) == DWC3_DEPCMD_ENDTRANSFER &&
> +	    !(cmd & DWC3_DEPCMD_CMDIOC))
> +		mdelay(1);
> +
>  	if (saved_config) {
>  		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
>  		reg |= saved_config;
> @@ -1715,12 +1719,10 @@ static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool int
>  	WARN_ON_ONCE(ret);
>  	dep->resource_index = 0;
>  
> -	if (!interrupt) {
> -		mdelay(1);
> +	if (!interrupt)
>  		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
> -	} else if (!ret) {
> +	else if (!ret)
>  		dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
> -	}
>  
>  	dep->flags &= ~DWC3_EP_DELAY_STOP;
>  	return ret;

Hi Thinh,

In case you have missed, can you please review this?

Thanks in advance,
Prashanth K

