Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83CE879DFA6
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 08:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236106AbjIMGBX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 02:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbjIMGBW (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 02:01:22 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004A51728;
        Tue, 12 Sep 2023 23:01:18 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38D49nLY028976;
        Wed, 13 Sep 2023 06:00:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=7xvZKJ1P8gDgtYTLtgl8fjkiRhKHkp+w9oal0IrovlY=;
 b=Kf56t7qI6dc1GL670gdiVIsxFfcB6wrW/tXgD70AJuQgJv3jmsfNQjzdoiorIjvB4/in
 ux3PoWdC62NKkKu3/h45YuEF46jhNVEQI3LpOXpIVwPow6gh6q+ZuFKWfAS5IzXgaiR1
 xK4KW2anlu4iH6DerT1OMSnjEWWBv++oDgpg5rnUlHA9eImnuILweK5Ix6ljdqhVGxYg
 sb6FiUg2+8dbCMoxAo7oMuP8HImei5HwAzMj2BtCpPxLGFt1L7++5PCwN6UlGa9WEotp
 eflS/SU8jaxk8y1HdPsATzVnzE45F+XB3mzUVT4hi8CoIqySdVCjprTLJdxT1lg63/XO tg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t2y7wrv0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 06:00:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38D60nVx028769
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 06:00:49 GMT
Received: from [10.217.219.52] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 12 Sep
 2023 23:00:47 -0700
Message-ID: <42bcb910-7748-cf73-a40d-217c39a63dd1@quicinc.com>
Date:   Wed, 13 Sep 2023 11:30:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/4] xhci: Keep interrupt disabled in initialization until
 host is running.
Content-Language: en-US
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, Hongyu Xie <xy521521@gmail.com>,
        <stable@kernel.org>, Hongyu Xie <xiehongyu1@kylinos.cn>,
        "# 5 . 15" <stable@vger.kernel.org>
References: <20220623111945.1557702-1-mathias.nyman@linux.intel.com>
 <20220623111945.1557702-2-mathias.nyman@linux.intel.com>
From:   Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <20220623111945.1557702-2-mathias.nyman@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ThCtHQVabx9N3tQQlffw9qp6i6mF_beo
X-Proofpoint-ORIG-GUID: ThCtHQVabx9N3tQQlffw9qp6i6mF_beo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_24,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxscore=0 suspectscore=0 adultscore=0 mlxlogscore=635 priorityscore=1501
 impostorscore=0 spamscore=0 clxscore=1011 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309130050
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



On 23-06-22 04:49 pm, Mathias Nyman wrote:
> From: Hongyu Xie <xy521521@gmail.com>
> 
> irq is disabled in xhci_quiesce(called by xhci_halt, with bit:2 cleared
> in USBCMD register), but xhci_run(called by usb_add_hcd) re-enable it.
> It's possible that you will receive thousands of interrupt requests
> after initialization for 2.0 roothub. And you will get a lot of
> warning like, "xHCI dying, ignoring interrupt. Shouldn't IRQs be
> disabled?". This amount of interrupt requests will cause the entire
> system to freeze.
> This problem was first found on a device with ASM2142 host controller
> on it.
> 
> [tidy up old code while moving it, reword header -Mathias]
> Cc: stable@kernel.org
> Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> ---
>   drivers/usb/host/xhci.c | 35 ++++++++++++++++++++++-------------
>   1 file changed, 22 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 9ac56e9ffc64..cb99bed5f755 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -611,15 +611,37 @@ static int xhci_init(struct usb_hcd *hcd)
>   
>   static int xhci_run_finished(struct xhci_hcd *xhci)
>   {
> +	unsigned long	flags;
> +	u32		temp;
> +
> +	/*
> +	 * Enable interrupts before starting the host (xhci 4.2 and 5.5.2).
> +	 * Protect the short window before host is running with a lock
> +	 */
> +	spin_lock_irqsave(&xhci->lock, flags);
> +
> +	xhci_dbg_trace(xhci, trace_xhci_dbg_init, "Enable interrupts");
> +	temp = readl(&xhci->op_regs->command);
> +	temp |= (CMD_EIE);
> +	writel(temp, &xhci->op_regs->command);
> +
> +	xhci_dbg_trace(xhci, trace_xhci_dbg_init, "Enable primary interrupter");
> +	temp = readl(&xhci->ir_set->irq_pending);
> +	writel(ER_IRQ_ENABLE(temp), &xhci->ir_set->irq_pending);
> +
>   	if (xhci_start(xhci)) {
>   		xhci_halt(xhci);
> +		spin_unlock_irqrestore(&xhci->lock, flags);
>   		return -ENODEV;
>   	}
> +
>   	xhci->cmd_ring_state = CMD_RING_STATE_RUNNING;
>   
>   	if (xhci->quirks & XHCI_NEC_HOST)
>   		xhci_ring_cmd_db(xhci);
>   
> +	spin_unlock_irqrestore(&xhci->lock, flags);
> +
>   	return 0;
>   }
>   
> @@ -668,19 +690,6 @@ int xhci_run(struct usb_hcd *hcd)
>   	temp |= (xhci->imod_interval / 250) & ER_IRQ_INTERVAL_MASK;
>   	writel(temp, &xhci->ir_set->irq_control);
>   
> -	/* Set the HCD state before we enable the irqs */
> -	temp = readl(&xhci->op_regs->command);
> -	temp |= (CMD_EIE);
> -	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
> -			"// Enable interrupts, cmd = 0x%x.", temp);
> -	writel(temp, &xhci->op_regs->command);
> -
> -	temp = readl(&xhci->ir_set->irq_pending);
> -	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
> -			"// Enabling event ring interrupter %p by writing 0x%x to irq_pending",
> -			xhci->ir_set, (unsigned int) ER_IRQ_ENABLE(temp));
> -	writel(ER_IRQ_ENABLE(temp), &xhci->ir_set->irq_pending);
> -
>   	if (xhci->quirks & XHCI_NEC_HOST) {
>   		struct xhci_command *command;
>   
This is not available to older kernels [< 5.19]. Can we get this 
backported to 5.15 as well? Please let me know if there is some other 
way to do it.

Cc: <stable@vger.kernel.org> # 5.15

Thanks,
Prashanth K
