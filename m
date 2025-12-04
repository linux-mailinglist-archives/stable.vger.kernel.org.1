Return-Path: <stable+bounces-200020-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E521ECA3C68
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 14:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F4E53055781
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 13:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B082FBE0F;
	Thu,  4 Dec 2025 13:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VwG0WAuy"
X-Original-To: stable@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7673433CE87
	for <stable@vger.kernel.org>; Thu,  4 Dec 2025 13:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764854159; cv=none; b=YQGq7grQIwR95aVGwaOPNX4tifWDOXUKrgHEQnNJscWbPpNM7XVe+fLduKtUmq0581SerDLKfT/FOLdvfn9VQtu1Kp4X0NbXThva4vPbclojbt5LsWz2DtiecEZgACVLZXBTQxe/26UHoSdXn9JQYOZeFybxQBpEAiWHvMZBMks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764854159; c=relaxed/simple;
	bh=ybH7x2KDbXBkDaWVwlH2cYcn9EPoixMp6t/Fyk3084o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=l2lBH7AWV5KFLmtD/UOxyr/rdUTgq0xQGQjkSOephyouJrkmADb03t8cPLC3AJbLrox/bd2o5z3DNXGGBlEEAKf0/Wn3GPACiLaUhM43Q7+38h9yDVV/fCFnZhBj/7fclFOMB4fRzmG6xSgiQvdyxenR1BbS7OvdnFvt8oDsmbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=VwG0WAuy; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20251204131555epoutp04d7ca9c6de6fcd7e2755809147be1eb28~_BYD7HZWM1032710327epoutp04I
	for <stable@vger.kernel.org>; Thu,  4 Dec 2025 13:15:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20251204131555epoutp04d7ca9c6de6fcd7e2755809147be1eb28~_BYD7HZWM1032710327epoutp04I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1764854155;
	bh=P6WcT+qxBHgUdkap/JDzpLygjk5zky/P5bSUXIAtC5g=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=VwG0WAuyoqd2wiKxRlSBJ832zOeeVFhlbWgu/hwR4sOE56aOFU0SRWja22Qu3c7Ea
	 W75UomatBi0pUsRl6DYAWdZ665MDx5zukivAnhFNEY9zcnke0WbXo6DjVxRdt71lbL
	 iG+8VSM81yD4n4MqROFLMIDLdLUlf8GnjvdIrjEU=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20251204131554epcas5p32cfbcc337f656fde7ab11640c80250c4~_BYDTPNMY0774007740epcas5p3D;
	Thu,  4 Dec 2025 13:15:54 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.90]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4dMZkx6JL4z3hhT3; Thu,  4 Dec
	2025 13:15:53 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20251204131553epcas5p43d885690c1c62f26cd6a2eb4decf3914~_BYBnBS-f0305203052epcas5p40;
	Thu,  4 Dec 2025 13:15:53 +0000 (GMT)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251204131550epsmtip1d4d75fc2802d2cdbc54707e72848eeb7~_BX-Lv5PE0249302493epsmtip1Q;
	Thu,  4 Dec 2025 13:15:50 +0000 (GMT)
Message-ID: <9d309a6f-39b2-43da-96a6-b7c59b98431e@samsung.com>
Date: Thu, 4 Dec 2025 18:45:49 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: dwc3: gadget: Prevent EPs resource conflict
 during StartTransfer
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jh0801.jung@samsung.com"
	<jh0801.jung@samsung.com>, "dh10.jung@samsung.com" <dh10.jung@samsung.com>,
	"naushad@samsung.com" <naushad@samsung.com>, "akash.m5@samsung.com"
	<akash.m5@samsung.com>, "h10.kim@samsung.com" <h10.kim@samsung.com>,
	"eomji.oh@samsung.com" <eomji.oh@samsung.com>, "alim.akhtar@samsung.com"
	<alim.akhtar@samsung.com>, "thiagu.r@samsung.com" <thiagu.r@samsung.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Language: en-US
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
In-Reply-To: <20251204015125.qgio53oimdes5kjr@synopsys.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251204131553epcas5p43d885690c1c62f26cd6a2eb4decf3914
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251204015221epcas5p3ed1b6174589b47629ea9333e3ddbb176
References: <20251117155920.643-1-selvarasu.g@samsung.com>
	<20251118022116.spdwqjdc7fyls2ht@synopsys.com>
	<f4d27a4c-df75-42b8-9a1c-3fe2a14666ed@rowland.harvard.edu>
	<20251119014858.5phpkofkveb2q2at@synopsys.com>
	<d53a1765-f316-46ff-974e-f42b22b31b25@rowland.harvard.edu>
	<20251120020729.k6etudqwotodnnwp@synopsys.com>
	<2b944e45-c39a-4c34-b159-ba91dd627fe4@rowland.harvard.edu>
	<20251121022156.vbnheb6r2ytov7bt@synopsys.com>
	<f6bba9d1-2221-4bad-a7d7-564a5a311de1@rowland.harvard.edu>
	<4e82c0dd-4a36-4e1d-a93a-9bef5d63aa50@samsung.com>
	<CGME20251204015221epcas5p3ed1b6174589b47629ea9333e3ddbb176@epcas5p3.samsung.com>
	<20251204015125.qgio53oimdes5kjr@synopsys.com>


On 12/4/2025 7:21 AM, Thinh Nguyen wrote:
> On Wed, Dec 03, 2025, Selvarasu Ganesan wrote:
>> On 11/21/2025 8:38 AM, Alan Stern wrote:
>>> On Fri, Nov 21, 2025 at 02:22:02AM +0000, Thinh Nguyen wrote:
>>>> On Wed, Nov 19, 2025, Alan Stern wrote:
>>>>> ->set_alt() is called by the composite core when a Set-Interface or
>>>>> Set-Config control request arrives from the host.  It happens within the
>>>>> composite_setup() handler, which is called by the UDC driver when a
>>>>> control request arrives, which means it happens in the context of the
>>>>> UDC driver's interrupt handler.  Therefore ->set_alt() callbacks must
>>>>> not sleep.
>>>> This should be changed. I don't think we can expect set_alt() to
>>>> be in interrupt context only.
>>> Agreed.
>>>
>>>>> To do this right, I can't think of any approach other than to make the
>>>>> composite core use a work queue or other kernel thread for handling
>>>>> Set-Interface and Set-Config calls.
>>>> Sounds like it should've been like this initially.
>>> I guess the nobody thought through the issues very carefully at the time
>>> the composite framework was designed.  Maybe the UDCs that existed back
>>> did not require a lot of time to flush endpoints; I can't remember.
>>>
>>>>> Without that ability, we will have to audit every function driver to
>>>>> make sure the ->set_alt() callbacks do ensure that endpoints are flushed
>>>>> before they are re-enabled.
>>>>>
>>>>> There does not seem to be any way to fix the problem just by changing
>>>>> the gadget core.
>>>>>
>>>> We can have a workaround in dwc3 that can temporarily "work" with what
>>>> we have. However, eventually, we will need to properly rework this and
>>>> audit the gadget drivers.
>>> Clearly, the first step is to change the composite core.  That can be
>>> done without messing up anything else.  But yes, eventually the gadget
>>> drivers will have to be audited.
>>>
>>> Alan Stern
>>
>> Hi Thinh,
>>
>> Do you have any suggestions that might be helpful for us to try on our side?
>> This EP resource‑conflict problem becomes easily observable when the
>> RNDIS network test executing ifconfig rndis0 down/up is run repeatedly
>> on the device side.
>>
>> Thanks,
>> Selva
> At the moment, I can't think of a way to workaround for all cases. Let's
> just leave bulk streams alone for now. Until we have proper fixes to the
> gadget framework, let's just try the below.
>
> Thanks,
> Thinh
>
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 3830aa2c10a9..974573304441 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -960,11 +960,18 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
>   	}
>   
>   	/*
> -	 * Issue StartTransfer here with no-op TRB so we can always rely on No
> -	 * Response Update Transfer command.
> +	 * For streams, at start, there maybe a race where the
> +	 * host primes the endpoint before the function driver
> +	 * queues a request to initiate a stream. In that case,
> +	 * the controller will not see the prime to generate the
> +	 * ERDY and start stream. To workaround this, issue a
> +	 * no-op TRB as normal, but end it immediately. As a
> +	 * result, when the function driver queues the request,
> +	 * the next START_TRANSFER command will cause the
> +	 * controller to generate an ERDY to initiate the
> +	 * stream.
>   	 */
> -	if (usb_endpoint_xfer_bulk(desc) ||
> -			usb_endpoint_xfer_int(desc)) {
> +	if (dep->stream_capable) {
>   		struct dwc3_gadget_ep_cmd_params params;
>   		struct dwc3_trb	*trb;
>   		dma_addr_t trb_dma;
> @@ -983,35 +990,21 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
>   		if (ret < 0)
>   			return ret;
>   
> -		if (dep->stream_capable) {
> -			/*
> -			 * For streams, at start, there maybe a race where the
> -			 * host primes the endpoint before the function driver
> -			 * queues a request to initiate a stream. In that case,
> -			 * the controller will not see the prime to generate the
> -			 * ERDY and start stream. To workaround this, issue a
> -			 * no-op TRB as normal, but end it immediately. As a
> -			 * result, when the function driver queues the request,
> -			 * the next START_TRANSFER command will cause the
> -			 * controller to generate an ERDY to initiate the
> -			 * stream.
> -			 */
> -			dwc3_stop_active_transfer(dep, true, true);
> +		dwc3_stop_active_transfer(dep, true, true);
>   
> -			/*
> -			 * All stream eps will reinitiate stream on NoStream
> -			 * rejection.
> -			 *
> -			 * However, if the controller is capable of
> -			 * TXF_FLUSH_BYPASS, then IN direction endpoints will
> -			 * automatically restart the stream without the driver
> -			 * initiation.
> -			 */
> -			if (!dep->direction ||
> -			    !(dwc->hwparams.hwparams9 &
> -			      DWC3_GHWPARAMS9_DEV_TXF_FLUSH_BYPASS))
> -				dep->flags |= DWC3_EP_FORCE_RESTART_STREAM;
> -		}
> +		/*
> +		 * All stream eps will reinitiate stream on NoStream
> +		 * rejection.
> +		 *
> +		 * However, if the controller is capable of
> +		 * TXF_FLUSH_BYPASS, then IN direction endpoints will
> +		 * automatically restart the stream without the driver
> +		 * initiation.
> +		 */
> +		if (!dep->direction ||
> +		    !(dwc->hwparams.hwparams9 &
> +		      DWC3_GHWPARAMS9_DEV_TXF_FLUSH_BYPASS))
> +			dep->flags |= DWC3_EP_FORCE_RESTART_STREAM;
>   	}
>   
>   out:


Hi Thinh,

Thanks for the changes. We understand the given fix and have verified 
that the original issue is resolved, but a similar below warning appears 
again in `dwc3_gadget_ep_queue` when we run a long duration our test. 
And we confirmed this is not due to this new given changes.

This warning is caused by a race between `dwc3_gadget_ep_disable` and 
`dwc3_gadget_ep_queue` that manipulates `dep->flags`.

Please refer the below sequence for the reference.

The warning originates from a race condition between 
dwc3_gadget_ep_disable and dwc3_send_gadget_ep_cmd from 
dwc3_gadget_ep_queue that both manipulate dep->flags. Proper 
synchronization or a check is needed when masking (dep->flags &= mask) 
inside dwc3_gadget_ep_disable.


Thread#1:
usb_ep_queue
  ->dwc3_gadget_ep_queue
   ->__dwc3_gadget_kick_transfer
    -> starting = !(dep->flags & DWC3_EP_TRANSFER_STARTED);
     ->if(starting)
        ->dwc3_send_gadget_ep_cmd (cmd = DWC3_DEPCMD_STARTTRANSFER)
          ->dep->flags |= DWC3_EP_TRANSFER_STARTED;


Thread#2:
dwc3_gadget_ep_disable
  ->__dwc3_gadget_ep_disable
   ->dwc3_remove_requests
    ->dwc3_stop_active_transfer
     ->__dwc3_stop_active_transfer
      -> dwc3_send_gadget_ep_cmd (cmd =DWC3_DEPCMD_ENDTRANSFER)
       ->if(!interrupt)dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
           ...
           While Thread#2 is still running, Thread #1 starts again:

Thread#1:
usb_ep_queue
  ->dwc3_gadget_ep_queue
   ->__dwc3_gadget_kick_transfer
    -> starting = !(dep->flags & DWC3_EP_TRANSFER_STARTED);
     ->if(starting)
       ->dwc3_send_gadget_ep_cmd (cmd = DWC3_DEPCMD_STARTTRANSFER)
        ->dep->flags |= DWC3_EP_TRANSFER_STARTED;
          ...
###### Thread#2: Continuation (race)
           ->__dwc3_gadget_ep_disable
            ->mask = DWC3_EP_TXFIFO_RESIZED | DWC3_EP_RESOURCE_ALLOCATED;
             ->dep->flags &= mask; --> // Possible of clears
                 DWC3_EP_TRANSFER_STARTED flag as well without
                 sending DWC3_DEPCMD_ENDTRANSFER

Thread#1:(Failure due to race)
usb_ep_queue
  ->dwc3_gadget_ep_queue
   ->__dwc3_gadget_kick_transfer
    -> starting = !(dep->flags & DWC3_EP_TRANSFER_STARTED);
      ->if(starting)
        ->dwc3_send_gadget_ep_cmd (cmd = DWC3_DEPCMD_STARTTRANSFER) ->
                 Results in “No resource” allocation error because the
                 previous transfer was never end with ENDTRANSFER.


     ------------[ cut here ]------------
  dwc3 13200000.dwc3: No resource for ep1in
  WARNING: CPU: 7 PID: 1748 at drivers/usb/dwc3/gadget.c:398 
dwc3_send_gadget_ep_cmd+0x2f8/0x76c
  pc : dwc3_send_gadget_ep_cmd+0x2f8/0x76c
  lr : dwc3_send_gadget_ep_cmd+0x2f8/0x76c
  Call trace:
  dwc3_send_gadget_ep_cmd+0x2f8/0x76c
  __dwc3_gadget_kick_transfer+0x2ec/0x3f4
  dwc3_gadget_ep_queue+0x140/0x1f0
  usb_ep_queue+0x60/0xec
  mp_tx_task+0x100/0x134
  mp_tx_timeout+0xd0/0x1e0
  __hrtimer_run_queues+0x130/0x318
  hrtimer_interrupt+0xe8/0x340
  exynos_mct_comp_isr+0x58/0x80
  __handle_irq_event_percpu+0xcc/0x25c
  handle_irq_event+0x40/0x9c
  handle_fasteoi_irq+0x154/0x2c8
  generic_handle_domain_irq+0x58/0x80
  gic_handle_irq+0x48/0x104
  call_on_irq_stack+0x3c/0x50
  do_interrupt_handler+0x4c/0x84
  el1_interrupt+0x34/0x58
  el1h_64_irq_handler+0x18/0x24
  el1h_64_irq+0x68/0x6c
  _raw_spin_unlock_irqrestore+0xc/0x4c
  binder_wakeup_thread_ilocked+0x50/0xb4
  binder_proc_transaction+0x308/0x6ec
  binder_transaction+0x1aec/0x23b0
  binder_ioctl_write_read+0xa28/0x2534
  binder_ioctl+0x1fc/0xb3c
  __arm64_sys_ioctl+0xa8/0xe4
  invoke_syscall+0x58/0x10c
  el0_svc_common+0x80/0xdc
  do_el0_svc+0x1c/0x28
  el0_svc+0x38/0x88
  el0t_64_sync_handler+0x70/0xbc
  el0t_64_sync+0x1a8/0x1ac
  ---[ end trace 0000000000000000 ]---

Thanks,
Selva

