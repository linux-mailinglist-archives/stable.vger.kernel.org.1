Return-Path: <stable+bounces-87716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A769AA22C
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 14:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09D0F282FBD
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 12:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF72E19D074;
	Tue, 22 Oct 2024 12:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HytuyHtL"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4677196DA2;
	Tue, 22 Oct 2024 12:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729600493; cv=none; b=iJBnaoBmiKgpDlKRCy/rZyvCvQs0lMpCaVuxq/MhqO4QKlTMQruVBdImHLrIERXhhfoEhyO++KleYZvpc86aBebqauFjJXA5AvvtYKP/hRGJn0ndL7UAfWwmGkTyr3ou+IxH7Zy8s/l+DDj/8ZSrM94IKncOMfQEVcpD+PsemJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729600493; c=relaxed/simple;
	bh=97uomaLB7yZNzX/ZjdKxgN95mOMRvgyTl2H1lwFRh3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NDlJfu/xjKt95SGzPb0k/kMdM8tp2XZYZh+s2otsb6gyh+GcWJxMzHI+MoCPggCPoTnj7QzZhSbnsLPH6cLwm3e2MfW9/Wskzv8usb87V06eTi4cB0Afwutc1sb477Titpo2jVIXWur5wgnTmM7KOtcg4UtvJfTPBoOkteBj4KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HytuyHtL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49M6ug8b019356;
	Tue, 22 Oct 2024 12:34:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qEcYoP34s/5lkGWzYfdtvlYJgT9GtRSNKTn8S2tmwcw=; b=HytuyHtLH5WQ6hp+
	RqSeJt3FClHAq4t4c4RO9JM6EiRMQibwegDc9qYTlFlb3EEa3XmOQv8Bum/iFeu8
	8ZNiinsPqvEUbhptt/dPtqHtbL0NoPW0ziPMhKaJnRJPZKrtV0Q0n17SpqJd2yyu
	KP74UFnr+4YBfmj5D6j/sjKgLXgxfHhFOJ3HPCr4PuD3OHa4vQu+ljl3P3iYgWmL
	yRqd1Yut6xir6d0RZHz9+eJbmle32zGGC82xZSwIFZfkXxbygy3/x1awwMFi4osM
	9YVqW/gTETRDmR2DTLbEKhLNCxUbVnPvEaEhrxp40z6UsDkeWdmpb1rn+7T/BBgo
	L6PylQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42e77pgyxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 12:34:46 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49MCYjLa001444
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 12:34:45 GMT
Received: from [10.218.25.132] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 22 Oct
 2024 05:34:43 -0700
Message-ID: <07744fc7-633f-477e-96e9-8f498a3b40e8@quicinc.com>
Date: Tue, 22 Oct 2024 18:04:41 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] xhci: Fix Link TRB DMA in command ring stopped
 completion event
To: Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20241021131904.20678-1-quic_faisalh@quicinc.com>
 <51a0598a-2618-4501-af40-f1e9a1463bca@linux.intel.com>
Content-Language: en-US
From: Faisal Hassan <quic_faisalh@quicinc.com>
In-Reply-To: <51a0598a-2618-4501-af40-f1e9a1463bca@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bLTDxxQ60xar-EkQjxwtjRbG7bVG9iYs
X-Proofpoint-ORIG-GUID: bLTDxxQ60xar-EkQjxwtjRbG7bVG9iYs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 priorityscore=1501
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410220080

Hi Mathias,

On 10/21/2024 9:09 PM, Mathias Nyman wrote:
> On 21.10.2024 16.19, Faisal Hassan wrote:
>> During the aborting of a command, the software receives a command
>> completion event for the command ring stopped, with the TRB pointing
>> to the next TRB after the aborted command.
>>
>> If the command we abort is located just before the Link TRB in the
>> command ring, then during the 'command ring stopped' completion event,
>> the xHC gives the Link TRB in the event's cmd DMA, which causes a
>> mismatch in handling command completion event.
>>
>> To handle this situation, an additional check has been added to ignore
>> the mismatch error and continue the operation.
>>
>> Fixes: 7f84eef0dafb ("USB: xhci: No-op command queueing and irq
>> handler.")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Faisal Hassan <quic_faisalh@quicinc.com>
>> ---
>> Changes in v2:
>> - Removed traversing of TRBs with in_range() API.
>> - Simplified the if condition check.
>>
>> v1 link:
>> https://lore.kernel.org/all/20241018195953.12315-1-
>> quic_faisalh@quicinc.com
>>
>>   drivers/usb/host/xhci-ring.c | 43 +++++++++++++++++++++++++++++++-----
>>   1 file changed, 38 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
>> index b2950c35c740..de375c9f08ca 100644
>> --- a/drivers/usb/host/xhci-ring.c
>> +++ b/drivers/usb/host/xhci-ring.c
>> @@ -126,6 +126,29 @@ static void inc_td_cnt(struct urb *urb)
>>       urb_priv->num_tds_done++;
>>   }
>>   +/*
>> + * Return true if the DMA is pointing to a Link TRB in the ring;
>> + * otherwise, return false.
>> + */
>> +static bool is_dma_link_trb(struct xhci_ring *ring, dma_addr_t dma)
>> +{
>> +    struct xhci_segment *seg;
>> +    union xhci_trb *trb;
>> +
>> +    seg = ring->first_seg;
>> +    do {
>> +        if (in_range(dma, seg->dma, TRB_SEGMENT_SIZE)) {
>> +            /* found the TRB, check if it's link */
>> +            trb = &seg->trbs[(dma - seg->dma) / sizeof(*trb)];
>> +            return trb_is_link(trb);
>> +        }
>> +
>> +        seg = seg->next;
>> +    } while (seg != ring->first_seg);
>> +
>> +    return false;
>> +}
>> +
>>   static void trb_to_noop(union xhci_trb *trb, u32 noop_type)
>>   {
>>       if (trb_is_link(trb)) {
>> @@ -1718,6 +1741,7 @@ static void handle_cmd_completion(struct
>> xhci_hcd *xhci,
>>         trace_xhci_handle_command(xhci->cmd_ring, &cmd_trb->generic);
>>   +    cmd_comp_code = GET_COMP_CODE(le32_to_cpu(event->status));
>>       cmd_dequeue_dma = xhci_trb_virt_to_dma(xhci->cmd_ring->deq_seg,
>>               cmd_trb);
>>       /*
>> @@ -1725,17 +1749,26 @@ static void handle_cmd_completion(struct
>> xhci_hcd *xhci,
>>        * command.
>>        */
>>       if (!cmd_dequeue_dma || cmd_dma != (u64)cmd_dequeue_dma) {
>> -        xhci_warn(xhci,
>> -              "ERROR mismatched command completion event\n");
>> -        return;
>> +        /*
>> +         * For the 'command ring stopped' completion event, there
>> +         * is a risk of a mismatch in dequeue pointers if we abort
>> +         * the command just before the link TRB in the command ring.
>> +         * In this scenario, the cmd_dma in the event would point
>> +         * to a link TRB, while the software dequeue pointer circles
>> +         * back to the start.
>> +         */
>> +        if (!(cmd_comp_code == COMP_COMMAND_RING_STOPPED &&
>> +              is_dma_link_trb(xhci->cmd_ring, cmd_dma))) {
> 
> 
> Do we in this COMP_COMMAND_RING_STOPPED case even need to check if
> cmd_dma != (u64)cmd_dequeue_dma, or if command ring stopped on a link TRB?
> 
> Could we just move the COMP_COMMAND_RING_STOPPED handling a bit earlier?
> 
> if (cmd_comp_code == COMP_COMMAND_RING_STOPPED) {
>     complete_all(&xhci->cmd_ring_stop_completion);
>         return;
> }
> 
> If I remember correctly it should just turn aborted command TRBs into
> no-ops,
> and restart the command ring
> 

Thanks for reviewing the changes!

Yes, you’re right. As part of restarting the command ring, we just ring
the doorbell.

If we move the event handling without validating the dequeue pointer,
wouldn’t it be a risk if we don’t check what the xHC is holding in its
dequeue pointer? If we are not setting it, it starts from wherever it
stopped. What if the dequeue pointer got corrupted or is not pointing to
any of the TRBs in the command ring?

> Thanks
> Mathias
> 

Thanks,
Faisal

