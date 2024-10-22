Return-Path: <stable+bounces-87744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B489AB206
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 17:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5503AB213DD
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 15:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675CA1A38C2;
	Tue, 22 Oct 2024 15:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eolUrfIE"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5444419D8A8;
	Tue, 22 Oct 2024 15:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729610883; cv=none; b=lxLZ6R5zmHo5M4rIl3HauAQc6lJhIBlYgASz4p1HSY5y90Z3b5EafdR6gHUsyFcy6c2fevPwJt7in+/88TmbbyNL+GVBNT3VcGEe8bNTnguLuWl9ecgvQ+dD7aJIJUrA1LmMkle+YgOKm9secm9CCfqQRXiFnfBQ13eBDvDkgv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729610883; c=relaxed/simple;
	bh=Q6/LCuHxtFaNWPS9zJ1PUM8zFCB+Qji/2TlyaQMqe74=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oExJ058RAYGhrfPiy34fjNAvh6SOfsLygz8I2QgpzJo4awLH/dNVJk5KqpR5rOSyDgZ36a0y+VeJ3SKc040rJBz3NNIEAb1sCIFLlxtNyJGihXhPp23UFU6NboVQ821x6KHnKGR7FeKlAqNDQ/4jOk4HDBOYljwUElOr+MegE0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eolUrfIE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MC9udB025848;
	Tue, 22 Oct 2024 15:27:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RIDLr4r/u/K1oPWDOMyoC7Dp7E83dotNNmd7J8LLHPs=; b=eolUrfIEJF3LThEo
	OAx0HVbaRw/w2KVL6DmdES0s6oI3VV1JhMJ4+snG11jhExNVJ25ArkAdobAwFspa
	K+MiAWZ+aS9DwiHM6wYUOQtevYfBvxZHvQ60YpfDag49QCGnfmrqRZ7hYnn0izk8
	xrFytqaBdf6GueiuZZGtXOBSYbCAQzbeNg6FvefVsXyYiyxx2jNW4XbemJomb4k5
	uwBg4FBQBoLeM0BS9KPRd8LqRf+X1cGkwBQ9fRDOfvFnMN+OebYuu66dE7sCI6TO
	VLDpd65NBYxl6Rj0rOqnWXD9DTXhAXodxzc2yco9goxpec2BvtTBsuqd0NdhOKXK
	5PjaaA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42ebtm8ka0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 15:27:56 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49MFRt1u012769
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 15:27:55 GMT
Received: from [10.216.52.6] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 22 Oct
 2024 08:27:52 -0700
Message-ID: <3c13bc31-1ee5-4f5b-9655-1e12465fa8ce@quicinc.com>
Date: Tue, 22 Oct 2024 20:57:49 +0530
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
 <07744fc7-633f-477e-96e9-8f498a3b40e8@quicinc.com>
 <118041cf-07b1-457c-ad59-b9c8d48342b9@linux.intel.com>
Content-Language: en-US
From: Faisal Hassan <quic_faisalh@quicinc.com>
In-Reply-To: <118041cf-07b1-457c-ad59-b9c8d48342b9@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: OaGEFgHReXcTYVJ-2ck0RwTPAMOrQQrX
X-Proofpoint-GUID: OaGEFgHReXcTYVJ-2ck0RwTPAMOrQQrX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 mlxscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=788 adultscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410220099



On 10/22/2024 8:03 PM, Mathias Nyman wrote:
> On 22.10.2024 15.34, Faisal Hassan wrote:
>> Hi Mathias,
>>
>>> Do we in this COMP_COMMAND_RING_STOPPED case even need to check if
>>> cmd_dma != (u64)cmd_dequeue_dma, or if command ring stopped on a link
>>> TRB?
>>>
>>> Could we just move the COMP_COMMAND_RING_STOPPED handling a bit earlier?
>>>
>>> if (cmd_comp_code == COMP_COMMAND_RING_STOPPED) {
>>>      complete_all(&xhci->cmd_ring_stop_completion);
>>>          return;
>>> }
>>>
>>> If I remember correctly it should just turn aborted command TRBs into
>>> no-ops,
>>> and restart the command ring
>>>
>>
>> Thanks for reviewing the changes!
>>
>> Yes, you’re right. As part of restarting the command ring, we just ring
>> the doorbell.
>>
>> If we move the event handling without validating the dequeue pointer,
>> wouldn’t it be a risk if we don’t check what the xHC is holding in its
>> dequeue pointer? If we are not setting it, it starts from wherever it
>> stopped. What if the dequeue pointer got corrupted or is not pointing to
>> any of the TRBs in the command ring?
> 
> For that to happen the xHC host would have to corrupt its internal command
> ring dequeue pointer. Not impossible, but an unlikely HW flaw, and a
> separate
> issue. A case like that could be solved by writing the address of the
> next valid
> (non-aborted) command to the CRCR register in
> xhci_handle_stopped_cmd_ring() before
> ringing the doorbell.
> 
> The case you found where a command abort is not handled properly due to
> stopping
> on a link TRB is a real xhci driver issue that would be nice to get solved.
> 
> For the COMP_COMMAND_RING_STOPPED case we don't really care that much
> on which command it stopped, for other commands we do.
> 
> Thanks
> Mathias
> 

Sure, I will submit a v3 with the command ring stopped check moved a bit
earlier.

Thanks,
Faisal

