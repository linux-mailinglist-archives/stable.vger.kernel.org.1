Return-Path: <stable+bounces-195046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5571FC67327
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 04:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D24A935BA9F
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 03:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF7B3019CD;
	Tue, 18 Nov 2025 03:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qQsna0mX"
X-Original-To: stable@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE051EB5C2
	for <stable@vger.kernel.org>; Tue, 18 Nov 2025 03:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763438348; cv=none; b=IyRNmUC4vYy734V7VeCwwM4wozGs2C5R7/g5OLgNyWUkmRoKC6edvr2b1fGpIgw1kdQ67Pg4W9LitXDy38SrszEMHIcZuouXPLi97L7qPvLopbsdKiTHT7WrIMJGI+lmAy78MxX9RKONInJ6CUmrbQqGuBINMxjMDKx5RK84H1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763438348; c=relaxed/simple;
	bh=Cyu6cG7GfE4ZaPTRL5K2FrREvmda2mslMRCneaq7Sts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=IbKmMWNakYIucEZRFWEk9FyqkTH6HMHfwTLTgM0joxkJi/sZY8WdFmGFQHQsvOCzTq4VGDh6lo1lsKo4DHn/jGCyRiKV0F7dLysm+cBJDqAkmcGOzDgI+gKgBcyRI8B2YsW0EHZPWxWux+feCkpBFFMzn0dOiJrgghwU/LPkcaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=qQsna0mX; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20251118035903epoutp0425b03578fa4b3d8f8a04752bd3be8d4b~4-dSE_jW81498414984epoutp04w
	for <stable@vger.kernel.org>; Tue, 18 Nov 2025 03:59:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20251118035903epoutp0425b03578fa4b3d8f8a04752bd3be8d4b~4-dSE_jW81498414984epoutp04w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1763438343;
	bh=6GgrWcuSMb1+Xce+Hi0xeTGvJHbepGhALaWkZy0vLtQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=qQsna0mX8UVYnPRjZpd5Cjji9SjKNshsfRhwv/avHFO4hHvwqNTdkl8IuGasxsx12
	 cPJiurCX9oIogJpIMZCQt+wlDGFA8kueAREZCfca79chEpVrQilOxs5tJcxXaEKjAj
	 gn215gmo4DXGvGqjaDznN+Y9jK3M4MxiObes8p2s=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20251118035902epcas5p3faba3cb0f6c2aa6e7c3ec53c1ed2b521~4-dRnEyk01872218722epcas5p39;
	Tue, 18 Nov 2025 03:59:02 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.92]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4d9W7n5hX8z3hhT4; Tue, 18 Nov
	2025 03:59:01 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20251118035901epcas5p424fdbe9d2e23cf11767ca7844254678f~4-dP9Fm841692216922epcas5p4e;
	Tue, 18 Nov 2025 03:59:01 +0000 (GMT)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251118035857epsmtip166ee58879c2f9976c44e490a37ba2c65~4-dMxLGsj1288912889epsmtip1Y;
	Tue, 18 Nov 2025 03:58:57 +0000 (GMT)
Message-ID: <eb19ca1d-1919-4ead-9795-5dd24ca1950c@samsung.com>
Date: Tue, 18 Nov 2025 09:28:55 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: dwc3: gadget: Prevent EPs resource conflict
 during StartTransfer
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Alan Stern
	<stern@rowland.harvard.edu>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jh0801.jung@samsung.com" <jh0801.jung@samsung.com>, "dh10.jung@samsung.com"
	<dh10.jung@samsung.com>, "naushad@samsung.com" <naushad@samsung.com>,
	"akash.m5@samsung.com" <akash.m5@samsung.com>, "h10.kim@samsung.com"
	<h10.kim@samsung.com>, "eomji.oh@samsung.com" <eomji.oh@samsung.com>,
	"alim.akhtar@samsung.com" <alim.akhtar@samsung.com>, "thiagu.r@samsung.com"
	<thiagu.r@samsung.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"hongpooh.kim@samsung.com" <hongpooh.kim@samsung.com>,
	"muhammed.ali@samsung.com" <muhammed.ali@samsung.com>
Content-Language: en-US
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
In-Reply-To: <20251118022116.spdwqjdc7fyls2ht@synopsys.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251118035901epcas5p424fdbe9d2e23cf11767ca7844254678f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251117160057epcas5p324eddf1866146216495186a50bcd3c01
References: <CGME20251117160057epcas5p324eddf1866146216495186a50bcd3c01@epcas5p3.samsung.com>
	<20251117155920.643-1-selvarasu.g@samsung.com>
	<20251118022116.spdwqjdc7fyls2ht@synopsys.com>


On 11/18/2025 7:51 AM, Thinh Nguyen wrote:
> On Mon, Nov 17, 2025, Selvarasu Ganesan wrote:
>> The below “No resource for ep” warning appears when a StartTransfer
>> command is issued for bulk or interrupt endpoints in
>> `dwc3_gadget_ep_enable` while a previous StartTransfer on the same
>> endpoint is still in progress. The gadget functions drivers can invoke
>> `usb_ep_enable` (which triggers a new StartTransfer command) before the
>> earlier transfer has completed. Because the previous StartTransfer is
>> still active, `dwc3_gadget_ep_disable` can skip the required
>> `EndTransfer` due to `DWC3_EP_DELAY_STOP`, leading to  the endpoint
>> resources are busy for previous StartTransfer and warning ("No resource
>> for ep") from dwc3 driver.
>>
>> To resolve this, a check is added to `dwc3_gadget_ep_enable` that
>> checks the `DWC3_EP_TRANSFER_STARTED` flag before issuing a new
>> StartTransfer. By preventing a second StartTransfer on an already busy
>> endpoint, the resource conflict is eliminated, the warning disappears,
>> and potential kernel panics caused by `panic_on_warn` are avoided.
>>
>> ------------[ cut here ]------------
>> dwc3 13200000.dwc3: No resource for ep1out
>> WARNING: CPU: 0 PID: 700 at drivers/usb/dwc3/gadget.c:398 dwc3_send_gadget_ep_cmd+0x2f8/0x76c
>> Call trace:
>>   dwc3_send_gadget_ep_cmd+0x2f8/0x76c
>>   __dwc3_gadget_ep_enable+0x490/0x7c0
>>   dwc3_gadget_ep_enable+0x6c/0xe4
>>   usb_ep_enable+0x5c/0x15c
>>   mp_eth_stop+0xd4/0x11c
>>   __dev_close_many+0x160/0x1c8
>>   __dev_change_flags+0xfc/0x220
>>   dev_change_flags+0x24/0x70
>>   devinet_ioctl+0x434/0x524
>>   inet_ioctl+0xa8/0x224
>>   sock_do_ioctl+0x74/0x128
>>   sock_ioctl+0x3bc/0x468
>>   __arm64_sys_ioctl+0xa8/0xe4
>>   invoke_syscall+0x58/0x10c
>>   el0_svc_common+0xa8/0xdc
>>   do_el0_svc+0x1c/0x28
>>   el0_svc+0x38/0x88
>>   el0t_64_sync_handler+0x70/0xbc
>>   el0t_64_sync+0x1a8/0x1ac
>>
>> Fixes: a97ea994605e ("usb: dwc3: gadget: offset Start Transfer latency for bulk EPs")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
>> ---
>>
>> Changes in v2:
>> - Removed change-id.
>> - Updated commit message.
>> Link to v1: https://urldefense.com/v3/__https://lore.kernel.org/linux-usb/20251117152812.622-1-selvarasu.g@samsung.com/__;!!A4F2R9G_pg!dQNEaMvjzrOiP0c9U6lyj31ysXGkjBAs8c_KjgDCp6ONSZcTrF15DXaJeFTK02v0RLS3w0NQ2K5_pvXak_7c8tIxKL8$
>> ---
>>   drivers/usb/dwc3/gadget.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 1f67fb6aead5..8d3caa71ea12 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -963,8 +963,9 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
>>   	 * Issue StartTransfer here with no-op TRB so we can always rely on No
>>   	 * Response Update Transfer command.
>>   	 */
>> -	if (usb_endpoint_xfer_bulk(desc) ||
>> -			usb_endpoint_xfer_int(desc)) {
>> +	if ((usb_endpoint_xfer_bulk(desc) ||
>> +			usb_endpoint_xfer_int(desc)) &&
>> +			!(dep->flags & DWC3_EP_TRANSFER_STARTED)) {
>>   		struct dwc3_gadget_ep_cmd_params params;
>>   		struct dwc3_trb	*trb;
>>   		dma_addr_t trb_dma;
>> -- 
>> 2.34.1
>>
> Thanks for the catch. The problem is that the "ep_disable" process
> should be completed after usb_ep_disable is completed. But currently it
> may be an async call.
>
> This brings up some conflicting wording of the gadget API regarding
> usb_ep_disable. Here's the doc regarding usb_ep_disable:
>
> 	/**
> 	 * usb_ep_disable - endpoint is no longer usable
> 	 * @ep:the endpoint being unconfigured.  may not be the endpoint named "ep0".
> 	 *
> 	 * no other task may be using this endpoint when this is called.
> 	 * any pending and uncompleted requests will complete with status
> 	 * indicating disconnect (-ESHUTDOWN) before this call returns.
> 	 * gadget drivers must call usb_ep_enable() again before queueing
> 	 * requests to the endpoint.
> 	 *
> 	 * This routine may be called in an atomic (interrupt) context.
> 	 *
> 	 * returns zero, or a negative error code.
> 	 */
>
> It expects all requests to be completed and given back on completion. It
> also notes that this can also be called in interrupt context. Currently,
> there's a scenario where dwc3 may not want to give back the requests
> right away (ie. DWC3_EP_DELAY_STOP). To fix that in dwc3, it would need


Hi Thinh,
Thanks for your comments.
I agree with you on dwc3 may not want to give back the requests right 
away (ie. DWC3_EP_DELAY_STOP) and might also ignore the End Transfer 
command.
Consequently, there’s no point in scheduling a new Start Transfer before 
the previous one has completed. The traces below illustrate this: for 
EP1OUT the End Transfer never occurs, so a new Start Transfer is issued, 
which eventually ends with a “No Resource” error.

1. EP disable for ep1in: (working EP)
----------------------------------

dwc3_gadget_ep_disable: ep1in: mps 512/1024 streams 16 burst 0 ring 8/0 
flags E:swBp:< dwc3_gadget_ep_cmd: ep1in: cmd 'End Transfer' [30c08] 
params 00000000 00000000 00000000 --> status: Successful 
dwc3_gadget_giveback: ep1in: req 00000000cfc03ba0 length 0/194 Zsi ==> 
-108 dwc3_gadget_giveback: ep1in: req 0000000075196149 length 0/194 Zsi 
==> -108 dwc3_gadget_giveback: ep1in: req 000000002b2ffaa2 length 0/86 
Zsi ==> -108
2. EP enable for ep1out:(Not working EP) -->(No End Transfer)
----------------------------------------------------------

dwc3_gadget_ep_disable: ep1out: mps 512/682 streams 16 burst 0 ring 
114/74 flags E:swBp:>
3. EP disable for ep1in:
-----------------------

dwc3_gadget_ep_cmd: ep1in: cmd 'Set Endpoint Configuration' [401] params 
00021004 06000200 00000000 --> status: Successful dwc3_gadget_ep_cmd: 
ep1in: cmd 'Start Transfer' [406] params 00000008 ad6b9000 00000000 --> 
status: Successful dwc3_gadget_ep_enable: ep1in: mps 512/1024 streams 16 
burst 0 ring 0/0 flags E:swBp:<
4. EP enable for ep1out:(Triggered start Transfer without End Transfer)
----------------------------------------------------------------------

dwc3_gadget_ep_cmd: ep1out: cmd 'Set Endpoint Configuration' [401] 
params 00001004 04000200 00000000 --> status: Successful 
dwc3_gadget_ep_cmd: ep1out: cmd 'Start Transfer' [406] params 00000008 
ad6b7000 00000000 --> status: No Resource dwc3_gadget_ep_enable: ep1out: 
mps 512/682 streams 16 burst 0 ring 114/74 flags E:swBp:>

The given fix will prevent in this failure case ,

dwc3_gadget_ep_enable:
---------------------

+	if ((usb_endpoint_xfer_bulk(desc) ||
+			usb_endpoint_xfer_int(desc)) &&
+			!(dep->flags & DWC3_EP_TRANSFER_STARTED)) {


Thanks,
Selva
> to "wait" for the right condition. But waiting does not make sense in
> interrupt context. (We could busy-poll to satisfy the interrupt context,
> but that doesn't sound right either)
>
> This was updated from process context only to may be called in interrupt
> context:
>
> b0d5d2a71641 ("usb: gadget: udc: core: Revise comments for USB ep enable/disable")
>
>
> Hi Alan,
>
> Can you help give your opinion on this?
>
> Thanks,
> Thinh

