Return-Path: <stable+bounces-86920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 607689A502A
	for <lists+stable@lfdr.de>; Sat, 19 Oct 2024 19:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16E491F21485
	for <lists+stable@lfdr.de>; Sat, 19 Oct 2024 17:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378E618E04D;
	Sat, 19 Oct 2024 17:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bcxRXkYW"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3277F2F2F;
	Sat, 19 Oct 2024 17:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729360366; cv=none; b=qg+MEWVVPxT7LswVQzyikzZvuVIORJR+DcjXjsFYjo6NxpIRGc9QWTi+l4uuTOnXPrNDB/jfZ2ZSgfvK5xECzcW9Ha4X1kuAM7Gpd7dPXFIhGFOXDfO7cW8Fm8iLkN8sYq0VepMQmNNUNyxNXlr1oYktIqMdUmWEZ6S54biDPuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729360366; c=relaxed/simple;
	bh=sDC3BBP3o3pyI9b3om/e/G0CfoeRN0560j8xwPhITRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DYR1CE7ewpy4+1FiDW6tFuKa/QIWAMcefKO5uww5r0vZApI9AgPEEwmUZLDDbA/yDsuBoKyhldpRyWb9++tLp1gkVdMJNtKot6JlAepKhyUJszdFk+5ZR7Sgg/UwjycBt7ZLkuDVswdv8mBuQD7kSKt4nkn3Mi/mLtNmHWLs/t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bcxRXkYW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49JHCkRJ005529;
	Sat, 19 Oct 2024 17:52:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	i/hbgokUVLypeCZmR+eiHup995hvVAkdjDDle3EgDYo=; b=bcxRXkYW8LTo1fZl
	fVhyda0ovFFOR/pGbuY8Svl+uhN3LqUTYHEqe72isKC5fWZjAGLT4Y9/O0v/ulxX
	TRQGHCxLjeM5VP1lWBSp7npf+Hzb3i6xkmj8tm25I5bSljZHuSGrKallTffVtJN4
	5w/j/D27h5mCwQyQxx147fHDwlNzqoGs5PiLPiY57vezixk0iXXmCWoi9WvjdHGd
	8CGFOfbGVM6qBkdtOG1SarYZezAioErdk0S8kFzZTbRwqvbBqqViMAOD5e3xbM/C
	NMGhpVKv4dbCZrBpJCxPXk14P4G5uEQnFElNttt5jP6NmXa8Dpix4s2agrFx4x+D
	G0HSZQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42c6vurxrx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Oct 2024 17:52:40 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49JHqdhe032076
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Oct 2024 17:52:39 GMT
Received: from [10.216.44.170] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 19 Oct
 2024 10:52:36 -0700
Message-ID: <e64f1487-b3a8-4035-90f8-0062649996fd@quicinc.com>
Date: Sat, 19 Oct 2024 23:22:33 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xhci: Fix Link TRB DMA in command ring stopped completion
 event
To: =?UTF-8?Q?Micha=C5=82_Pecio?= <michal.pecio@gmail.com>
CC: <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <mathias.nyman@intel.com>,
        <stable@vger.kernel.org>
References: <20241019092023.5d987d7e@foxbook>
Content-Language: en-US
From: Faisal Hassan <quic_faisalh@quicinc.com>
In-Reply-To: <20241019092023.5d987d7e@foxbook>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FF2AaW0JV8-jBqFB3y_VEZSG_GtmLnx5
X-Proofpoint-GUID: FF2AaW0JV8-jBqFB3y_VEZSG_GtmLnx5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 mlxscore=0 clxscore=1011
 suspectscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410190131

Hi Michal,

On 10/19/2024 12:50 PM, Michał Pecio wrote:
> Hi,
> 
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
> 
> Thanks, I remember having some issues with command aborts, but I blamed
> them on my own bugs, although I never found what the problem was. I may
> take a look at it later, but I'm currently busy with other things.
> 
> No comment about validity of this patch for now, but a few remarks:
> 
>> +static bool is_dma_link_trb(struct xhci_ring *ring, dma_addr_t dma)
>> +{
>> +	struct xhci_segment *seg;
>> +	union xhci_trb *trb;
>> +	dma_addr_t trb_dma;
>> +	int i;
>> +
>> +	seg = ring->first_seg;
>> +	do {
>> +		for (i = 0; i < TRBS_PER_SEGMENT; i++) {
>> +			trb = &seg->trbs[i];
>> +			trb_dma = seg->dma + (i * sizeof(union xhci_trb));
>> +
>> +			if (trb_is_link(trb) && trb_dma == dma)
>> +				return true;
>> +		}
> 
> You don't need to iterate the array. Something like this should work:
> do {
> 	if (in_range(dma, seg->dma, TRB_SEGMENT_SIZE)) {
> 		/* found the TRB, check if it's link */
> 		trb = &seg->trbs[(dma - seg->dma) / sizeof(*trb)];
> 		return trb_is_link(trb);
> 	}
> 	// try next seg, while (blah blah), return false
> 

Sure, this looks good. Let me revise the patch.

> We should probably have a helper for (ring, dma)->trb lookups, but
> for stable it may be sensible to do it without excess complication.
> 
>> +	if ((!cmd_dequeue_dma || cmd_dma != (u64)cmd_dequeue_dma) &&
>> +	    !(cmd_comp_code == COMP_COMMAND_RING_STOPPED &&
>> +	      is_dma_link_trb(xhci->cmd_ring, cmd_dma))) {
> 
> This if statement is quite complex now. I would be tempted to write
> it this way instead:
> 
> /* original comment */
> if (cmd_dma != dequeue_dma) {
> 	/* your new comment */
> 	if (! (RING_STOPPED && is_link)) {
> 		warn();
> 		return;
> 	}
> }
> 
> Regards,
> Michal

Thank you for the suggestions. I will submit a v2 version.

Regards,
Faisal

