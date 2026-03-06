Return-Path: <stable+bounces-223338-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFZBOFnSqmn3XQEAu9opvQ
	(envelope-from <stable+bounces-223338-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 14:10:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FCE2216A5
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 14:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFA4E307650A
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 13:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB95B392C56;
	Fri,  6 Mar 2026 13:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="m5pqdISy"
X-Original-To: stable@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE59A25A655
	for <stable@vger.kernel.org>; Fri,  6 Mar 2026 13:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772802416; cv=none; b=uO1TigGzaJIWcVuwxz7D+z5q8tZcOGYDINmrLGOD5N0lcWU4Myq3kpRrLT+HFhK7LTbEgsWbWyTHeMfGBtW2bX048keFvgDP7pMrGcJ41pzecG4Q8hcVpPIT7HELy/a8ukF2I+kVEUPlTH0gyyxLMKPP6bB2pJOSg6BOB7KskMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772802416; c=relaxed/simple;
	bh=sub6SrAvM26hT3A2v1j2XexzqEbSiD12Hc10869wByM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=rQPjjgE7Ni+moJY7Yg8MCX/VomjbLcayQ5PyZ1BpVaO5bM3C6vABDiBvGvsFsGUUYjfM/FWOmuabxaHKd7Y4GPbNNqnAYhrsl43BAMznCAvQkzcW4uOwkZ3nZivH6d3+QsAGXBp/8LGAmmvUacEf2kj9mr6p4mtB3IKErZpstWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=m5pqdISy; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260306130651epoutp02c2c3b0ac58ae8a008fe578ba98150ca9~aQmaGnmbI1193811938epoutp02S
	for <stable@vger.kernel.org>; Fri,  6 Mar 2026 13:06:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260306130651epoutp02c2c3b0ac58ae8a008fe578ba98150ca9~aQmaGnmbI1193811938epoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1772802411;
	bh=n3LMl5Zi4sPPlfpsm0WvuuN09+O7qYxWpTXVegp0u14=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=m5pqdISyFXDRuxBalvh5BrUf7MmOCfvNnphXnL9LDFPUG2g2Ln/D/ocC+tqnT3GkH
	 dC3sOpEnfT7g1t28X3O6L7rDNC6MRZqgFKDF7ly4qlZuLVTJtNyuS9L4WSH0SWcgMd
	 qXJSquMN0MiMME3hNRsBOFXqPofsol9tWUjONtBY=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20260306130651epcas5p3b0853477fb4af80b127ecabfec9c7ba8~aQmZxUpm90362403624epcas5p3v;
	Fri,  6 Mar 2026 13:06:51 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.87]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4fS6B20lPzz2SSKX; Fri,  6 Mar
	2026 13:06:50 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20260306130649epcas5p192fe5f950447e3c51232a2a9bb2821bb~aQmX2Lpxm1152411524epcas5p1S;
	Fri,  6 Mar 2026 13:06:49 +0000 (GMT)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260306130642epsmtip1ba292795323ba4ed525b25da8cf5b772~aQmSPjo3m1863218632epsmtip1c;
	Fri,  6 Mar 2026 13:06:42 +0000 (GMT)
Message-ID: <08273adc-d8cf-48b3-ba45-853d363af0e6@samsung.com>
Date: Fri, 6 Mar 2026 18:36:31 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] usb: dwc3: gadget: Prevent EP resource conflicts
 during StartTransfer
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jh0801.jung@samsung.com" <jh0801.jung@samsung.com>, "dh10.jung@samsung.com"
	<dh10.jung@samsung.com>, "akash.m5@samsung.com" <akash.m5@samsung.com>,
	"hongpooh.kim@samsung.com" <hongpooh.kim@samsung.com>,
	"eomji.oh@samsung.com" <eomji.oh@samsung.com>, "h10.kim@samsung.com"
	<h10.kim@samsung.com>, "shijie.cai@samsung.com" <shijie.cai@samsung.com>,
	"alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
	"muhammed.ali@samsung.com" <muhammed.ali@samsung.com>,
	"thiagu.r@samsung.com" <thiagu.r@samsung.com>, "pritam.sutar@samsung.com"
	<pritam.sutar@samsung.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Content-Language: en-US
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
In-Reply-To: <20260303003955.5lbb6xdrg7tp3zzi@synopsys.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260306130649epcas5p192fe5f950447e3c51232a2a9bb2821bb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260227121338epcas5p4baebb406db37f07223545b2f85751bf2
References: <CGME20260227121338epcas5p4baebb406db37f07223545b2f85751bf2@epcas5p4.samsung.com>
	<20260227121236.963-1-selvarasu.g@samsung.com>
	<20260228002711.e442cuxwld4s2f66@synopsys.com>
	<20260303003955.5lbb6xdrg7tp3zzi@synopsys.com>
X-Rspamd-Queue-Id: 41FCE2216A5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[samsung.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223338-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:dkim,samsung.com:email,samsung.com:mid,synopsys.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,urldefense.com:url];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REDIRECTOR_URL(0.00)[urldefense.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[selvarasu.g@samsung.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action


On 3/3/2026 6:09 AM, Thinh Nguyen wrote:
> On Sat, Feb 28, 2026, Thinh Nguyen wrote:
>> On Fri, Feb 27, 2026, Selvarasu Ganesan wrote:
>>> The below “No resource for ep” warning appears when a StartTransfer
>>> command is issued for bulk or interrupt endpoints in
>>> `dwc3_gadget_ep_enable` while a previous StartTransfer on the same
>>> endpoint is still in progress. The gadget functions drivers can invoke
>>> `usb_ep_enable` (which triggers a new StartTransfer command) before the
>>> earlier transfer has completed. Because the previous StartTransfer is
>>> still active, `dwc3_gadget_ep_disable` can skip the required
>>> `EndTransfer` due to `DWC3_EP_DELAY_STOP`, leading to the endpoint
>>> resources are busy for previous StartTransfer and warning ("No resource
>>> for ep") from dwc3 driver.
>>>
>>> Additionally, a race condition exists between dwc3_gadget_ep_disable()
>>> and dwc3_gadget_ep_queue() when manipulating dep->flags. When
>>> dwc3_gadget_ep_disable() calls dwc3_gadget_giveback(), the dwc->lock is
>>> temporarily released. If dwc3_gadget_ep_queue() runs in that window, it
>>> may set the DWC3_EP_TRANSFER_STARTED flag as part of
>>> dwc3_send_gadget_ep_cmd(). When ep_disable resumes, it unconditionally
>>> clears all flags except those explicitly masked, potentially clearing
>>> DWC3_EP_TRANSFER_STARTED even though a new transfer has started. This
>>> leads to "No resource for ep" warnings on subsequent StartTransfer
>>> attempts.
>>>
>>> The underlying framework issue is that usb_ep_disable() is expected to
>>> complete pending requests before returning, but is allowed to be called
>>> from interrupt context where sleeping to wait for completion is not
>>> possible.
>>>
>>> As temporary workarounds for this framework limitation:
>>>
>>> 1. In __dwc3_gadget_ep_enable(), add a check for the
>>>     DWC3_EP_TRANSFER_STARTED flag before issuing a new StartTransfer.
>>>     This prevents a second StartTransfer on an already busy endpoint,
>>>     eliminating the resource conflict.
>>>
>>> 2. In __dwc3_gadget_ep_disable(), preserve the DWC3_EP_TRANSFER_STARTED
>>>     flag when masking dep->flags if it is actually set, preventing the
>>>     race with dwc3_gadget_ep_queue() from corrupting the flag state.
>>>
>>> These changes eliminate the "No resource for ep" warnings and potential
>>> kernel panics caused by panic_on_warn.
>>>
>>> dwc3 13200000.dwc3: No resource for ep1out
>>> WARNING: CPU: 0 PID: 700 at drivers/usb/dwc3/gadget.c:398 dwc3_send_gadget_ep_cmd+0x2f8/0x76c
>>> Call trace:
>>> dwc3_send_gadget_ep_cmd+0x2f8/0x76c
>>> __dwc3_gadget_ep_enable+0x490/0x7c0
>>> dwc3_gadget_ep_enable+0x6c/0xe4
>>> usb_ep_enable+0x5c/0x15c
>>> mp_eth_stop+0xd4/0x11c
>>> __dev_close_many+0x160/0x1c8
>>> __dev_change_flags+0xfc/0x220
>>> dev_change_flags+0x24/0x70
>>> devinet_ioctl+0x434/0x524
>>> inet_ioctl+0xa8/0x224
>>> sock_do_ioctl+0x74/0x128
>>> sock_ioctl+0x3bc/0x468
>>> __arm64_sys_ioctl+0xa8/0xe4
>>> invoke_syscall+0x58/0x10c
>>> el0_svc_common+0xa8/0xdc
>>> do_el0_svc+0x1c/0x28
>>> el0_svc+0x38/0x88
>>> el0t_64_sync_handler+0x70/0xbc
>>> el0t_64_sync+0x1a8/0x1ac
>>>
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
>>> ---
>>>
>>> Note: No Fixes tag is added because this is a workaround for the
>>> gadget framework issue where the gadget framework calls usb_ep_disable()
>>> in interrupt context without ensuring endpoint flushing completes.
>>> A proper fix requires refactoring the framework to make sure
>>> usb_ep_disable is invoked in process context.
>>>
>>> Changes in v3:
>>>   - Revised the commit message to detail the real gadget framework issue
>>>     pointed out by the reviewer.
>>>   - Merged the two fixes for the same ep wringing into one patch.
>>> Link to v2: https://urldefense.com/v3/__https://lore.kernel.org/linux-usb/20251117155920.643-1-selvarasu.g@samsung.com/__;!!A4F2R9G_pg!cQzQQ5kAWF6CE5hQe7VqFdnaxqwzsTB1ZGNT1GvCH28GoB_nESZR5Y2jtxdZBls6wBIM4OtpvG4dSaylvNC3qbh547k$
>>>
>>> Changes in v2:
>>> - Removed change-id.
>>> - Updated commit message.
>>> Link to v1: https://urldefense.com/v3/__https://lore.kernel.org/linux-usb/20251117152812.622-1-selvarasu.g@samsung.com/__;!!A4F2R9G_pg!cQzQQ5kAWF6CE5hQe7VqFdnaxqwzsTB1ZGNT1GvCH28GoB_nESZR5Y2jtxdZBls6wBIM4OtpvG4dSaylvNC38z-CRD4$
>>> ---
>>>   drivers/usb/dwc3/gadget.c | 22 ++++++++++++++++++++--
>>>   1 file changed, 20 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>> index 0a688904ce8c5..3af1bbfe3d92b 100644
>>> --- a/drivers/usb/dwc3/gadget.c
>>> +++ b/drivers/usb/dwc3/gadget.c
>>> @@ -971,8 +971,9 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
>>>   	 * Issue StartTransfer here with no-op TRB so we can always rely on No
>>>   	 * Response Update Transfer command.
>>>   	 */
>>> -	if (usb_endpoint_xfer_bulk(desc) ||
>>> -			usb_endpoint_xfer_int(desc)) {
>>> +	if ((usb_endpoint_xfer_bulk(desc) ||
>>> +			usb_endpoint_xfer_int(desc)) &&
>>> +			!(dep->flags & DWC3_EP_TRANSFER_STARTED)) {
>>>   		struct dwc3_gadget_ep_cmd_params params;
>>>   		struct dwc3_trb	*trb;
>>>   		dma_addr_t trb_dma;
>>> @@ -1096,6 +1097,23 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
>>>   	 */
>>>   	if (dep->flags & DWC3_EP_DELAY_STOP)
>>>   		mask |= (DWC3_EP_DELAY_STOP | DWC3_EP_TRANSFER_STARTED);
>>> +
>>> +	/*
>>> +	 * When dwc3_gadget_ep_disable() calls dwc3_gadget_giveback(),
>>> +	 * the dwc->lock is temporarily released. If dwc3_gadget_ep_queue()
>>> +	 * runs in that window it may set the DWC3_EP_TRANSFER_STARTED flag as
>>> +	 * part of dwc3_send_gadget_ep_cmd. The original code cleared the flag
>>> +	 * unconditionally in the mask operation, which could overwrite the
>>> +	 * concurrent modification.
>>> +	 *
>>> +	 * As a workaround for the interrupt context constraint where we cannot
>>> +	 * wait for endpoint flushing, preserve the DWC3_EP_TRANSFER_STARTED
>>> +	 * flag if it is set, avoiding resource conflicts until the framework
>>> +	 * is fixed to properly synchronize endpoint lifecycle management.
>>> +	 */
>>> +	if (dep->flags & DWC3_EP_TRANSFER_STARTED)
>>> +		mask |= DWC3_EP_TRANSFER_STARTED;
>>> +
>>>   	dep->flags &= mask;
>>>   
>>>   	/* Clear out the ep descriptors for non-ep0 */
>>> -- 
>>> 2.34.1
>>>
>> Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
>>
> Oh wait, don't pick this patch up yet.
>
> This will cause a regression for UAS device. When switching alt-setting
> interface for BOT to UASP, the device needs to issue a Start Transfer
> command.
>
> This workaround won't work. Can we fix the usb_ep_disable() interface
> and rework this instead?
>
> BR,
> Thinh

Hi Thinh,

We’re trying to see how this change could cause a regression for UAS 
devices.
Could you explain why the workaround might be a problem for UAS? Are you 
concerned that it could miss a valid StartTransfer when a previous 
transfer finishes later than expected as part of ep_disable?

If we don’t use this temporary fix, the driver can still report “EP 
resource busy” when an earlier StartTransfer hasn’t finished 
before ep_disable returns. That can happen when a UAS device needs to 
start a new transfer during ep_enable while the prior transfer is still 
pending.

The patch simply blocks a second StartTransfer when the same endpoint 
already has a transfer in progress to prevent a “EP resource busy” issue.

And it can cause a new StartTransfer to be issued later from ep_queue 
while the starttransfer that should have been started during ep_enable 
is skipped.

Thanks,
Selva

