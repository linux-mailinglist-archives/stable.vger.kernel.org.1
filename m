Return-Path: <stable+bounces-200790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C067CB589C
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 11:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED8C23014A1E
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 10:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281613019DE;
	Thu, 11 Dec 2025 10:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Rm6vn9vX"
X-Original-To: stable@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF543B8D47
	for <stable@vger.kernel.org>; Thu, 11 Dec 2025 10:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765449564; cv=none; b=ZbX76NYskGg+4k8cGaXeXbglZ4Ly18xjX43NrUiEXg2xjvmOzLrM57V56Bq6VqTU0SQCUWlLhN+Crbjo9310Z51ntqvQL9exBF6DfLvCtJBUKsj7VeD1qm3QVgShtLaeuaPyCilL6HJDEgBKjVKhkjmwTq3ZonZVH2dsvk2o7rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765449564; c=relaxed/simple;
	bh=qABJOo8oOFEG1OweryeWiTFWLN9RiXCN+KEzLNHzknI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=BlMqDagw66DkuTJXQUF52zgzddF1n8D7otofNgLLO3GmA89QWOkWWBS3M+FWEXplIhiYsea21yQ6UfFVmrn8rrj6xU/+aaUvMT63tG1ECW9S8R00xBOl1THY3ei1Ok3bKG7R5Dk4/EiYPxR7LXLX40Cjy+vFDz0E9/X9dXIGhtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Rm6vn9vX; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20251211103914epoutp04689a71d4956d29537ddf4b003d96cad3~AIwQ0ogyt3153231532epoutp04D
	for <stable@vger.kernel.org>; Thu, 11 Dec 2025 10:39:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20251211103914epoutp04689a71d4956d29537ddf4b003d96cad3~AIwQ0ogyt3153231532epoutp04D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1765449554;
	bh=V0eiS3ZVFCeOHYOQQbhUnlJf3vqcq3vAoAYPLSxPpkA=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Rm6vn9vXr0oEFrtvrEe2ARjRAvxbie9gMfSyXI4/2xQuXgMe2zggzzAzIhMJHcLzL
	 gP+L0rvaCBshLCQBBSh5ZCR+nsrlLexvn2Uikk3V+qna/pTWlyvWVgR2vb7TMqjX29
	 FEJqlANTlWk9Xc5yXgEIOjVqUh/gEeq8tEbklitk=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20251211103914epcas5p1b1fc8771704506544af7f9aa5ccbcfce~AIwQTR98M2358423584epcas5p1U;
	Thu, 11 Dec 2025 10:39:14 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.92]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4dRpwx21XFz6B9m6; Thu, 11 Dec
	2025 10:39:13 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20251211103912epcas5p3d3a11e7eab0d0be0ec131ba973965ea4~AIwO1xTvR2520425204epcas5p3n;
	Thu, 11 Dec 2025 10:39:12 +0000 (GMT)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251211103910epsmtip2d0a358546911f83e0c98f45b3fb539db~AIwMd9s7R0504305043epsmtip2F;
	Thu, 11 Dec 2025 10:39:10 +0000 (GMT)
Message-ID: <28035b59-3138-40e6-beb3-1a3793e8df84@samsung.com>
Date: Thu, 11 Dec 2025 16:08:59 +0530
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
In-Reply-To: <20251205011823.6ujxcjimlyetpjvj@synopsys.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251211103912epcas5p3d3a11e7eab0d0be0ec131ba973965ea4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251204015221epcas5p3ed1b6174589b47629ea9333e3ddbb176
References: <d53a1765-f316-46ff-974e-f42b22b31b25@rowland.harvard.edu>
	<20251120020729.k6etudqwotodnnwp@synopsys.com>
	<2b944e45-c39a-4c34-b159-ba91dd627fe4@rowland.harvard.edu>
	<20251121022156.vbnheb6r2ytov7bt@synopsys.com>
	<f6bba9d1-2221-4bad-a7d7-564a5a311de1@rowland.harvard.edu>
	<4e82c0dd-4a36-4e1d-a93a-9bef5d63aa50@samsung.com>
	<CGME20251204015221epcas5p3ed1b6174589b47629ea9333e3ddbb176@epcas5p3.samsung.com>
	<20251204015125.qgio53oimdes5kjr@synopsys.com>
	<9d309a6f-39b2-43da-96a6-b7c59b98431e@samsung.com>
	<20251205003723.rum7bexy2tazcdwb@synopsys.com>
	<20251205011823.6ujxcjimlyetpjvj@synopsys.com>


On 12/5/2025 6:48 AM, Thinh Nguyen wrote:
> On Fri, Dec 05, 2025, Thinh Nguyen wrote:
>> On Thu, Dec 04, 2025, Selvarasu Ganesan wrote:
>>> On 12/4/2025 7:21 AM, Thinh Nguyen wrote:
>>>> At the moment, I can't think of a way to workaround for all cases. Let's
>>>> just leave bulk streams alone for now. Until we have proper fixes to the
>>>> gadget framework, let's just try the below.
>>>>
>>>
>>> Hi Thinh,
>>>
>>> Thanks for the changes. We understand the given fix and have verified
>>> that the original issue is resolved, but a similar below warning appears
>>> again in `dwc3_gadget_ep_queue` when we run a long duration our test.
>>> And we confirmed this is not due to this new given changes.
>>>
>>> This warning is caused by a race between `dwc3_gadget_ep_disable` and
>>> `dwc3_gadget_ep_queue` that manipulates `dep->flags`.
>>>
>>> Please refer the below sequence for the reference.
>>>
>>> The warning originates from a race condition between
>>> dwc3_gadget_ep_disable and dwc3_send_gadget_ep_cmd from
>>> dwc3_gadget_ep_queue that both manipulate dep->flags. Proper
>>> synchronization or a check is needed when masking (dep->flags &= mask)
>>> inside dwc3_gadget_ep_disable.
>>>
>> I was hoping that the dwc3_gadget_ep_queue() won't come early to run
>> into this scenario. What I've provided will only mitigate and will not
>> resolve for all cases. It seems adding more checks in dwc3 will be
>> more messy.


Hi Thinh,


Thank you for the insightful comments. I agree that adding more checks 
directly in the dwc3 driver would be messy, and a comprehensive rework 
of the dwc3 ep disable would ultimately be the cleaner solution.

In the meantime, Introducing additional checks for 
DWC3_EP_TRANSFER_STARTED in dwc3 driver is the most practical way to 
unblock the current issue while we work toward that longer‑term fix.
We have applied the patches and performed additional testing, no 
regressions or new issues were observed.

Could you please confirm whether below interim fix is acceptable along 
with your proposed earlier patch for unblocking the current development 
flow?


Patch 2: usb: dwc3: protect dep->flags from concurrent modify in 
dwc3_gadget_ep_disable
=======================================================================================

Subject: [PATCH] usb: dwc3: protect dep->flags from concurrent modify in 
dwc3_gadget_ep_disable
The below warnings in `dwc3_gadget_ep_queue` observed during the RNDIS
enable/disable test is caused by a race between `dwc3_gadget_ep_disable`
and `dwc3_gadget_ep_queue`. Both functions manipulate `dep->flags`, and
the lock released temporarily by `dwc3_gadget_giveback` (called from
`dwc3_gadget_ep_disable`) can be acquired by `dwc3_gadget_ep_queue`
before `dwc3_gadget_ep_disable` has finished. This leads to an
inconsistent state of the `DWC3_EP_TRANSFER_STARTED` dep->flag.

To fix this issue by add a condition check when masking `dep->flags`
in `dwc3_gadget_ep_disable` to ensure the `DWC3_EP_TRANSFER_STARTED`
flag is not cleared when it is actually set. This prevents the spurious
warning and eliminates the race.

Thread#1:
dwc3_gadget_ep_disable
   ->__dwc3_gadget_ep_disable
    ->dwc3_remove_requests
     ->dwc3_stop_active_transfer
      ->__dwc3_stop_active_transfer
       -> dwc3_send_gadget_ep_cmd (cmd =DWC3_DEPCMD_ENDTRANSFER)
        ->if(!interrupt)dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
         ->dwc3_gadget_giveback
          ->spin_unlock(&dwc->lock)
            ...
            While Thread#1 is still running, Thread#2 starts:

Thread#2:
usb_ep_queue
   ->dwc3_gadget_ep_queue
    ->__dwc3_gadget_kick_transfer
     -> starting = !(dep->flags & DWC3_EP_TRANSFER_STARTED);
      ->if(starting)
        ->dwc3_send_gadget_ep_cmd (cmd = DWC3_DEPCMD_STARTTRANSFER)
         ->dep->flags |= DWC3_EP_TRANSFER_STARTED;
           ...
            ->__dwc3_gadget_ep_disable
             ->mask = DWC3_EP_TXFIFO_RESIZED |DWC3_EP_RESOURCE_ALLOCATED;
              ->dep->flags &= mask; --> // Possible of clears
                  DWC3_EP_TRANSFER_STARTED flag as well without
                  sending DWC3_DEPCMD_ENDTRANSFER

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

Change-Id: Ib6a77ce5130e25d0162f72d0e52c845dbb1d18f5
Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
---
  drivers/usb/dwc3/gadget.c | 16 ++++++++++++++++
  1 file changed, 16 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index b42d225b67408..1dc5798072120 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1051,6 +1051,22 @@ static int __dwc3_gadget_ep_disable(struct 
dwc3_ep *dep)
       */
      if (dep->flags & DWC3_EP_DELAY_STOP)
          mask |= (DWC3_EP_DELAY_STOP | DWC3_EP_TRANSFER_STARTED);
+
+    /*
+     * When dwc3_gadget_ep_disable() calls dwc3_gadget_giveback(),
+     * the  dwc->lock is temporarily released.  If dwc3_gadget_ep_queue()
+     * runs in that window it may set the DWC3_EP_TRANSFER_STARTED flag as
+     * part of dwc3_send_gadget_ep_cmd. The original code cleared the flag
+     * unconditionally, which could overwrite the concurrent modification.
+     *
+     * The added check ensures the DWC3_EP_TRANSFER_STARTED flag is only
+     * cleared if it is not set already, preserving the state updated 
by the
+     * concurrent ep_queue path and eliminating the EP resource conflict
+     * warning.
+     */
+    if (dep->flags & DWC3_EP_TRANSFER_STARTED)
+        mask |= DWC3_EP_TRANSFER_STARTED;
+
      dep->flags &= mask;

      /* Clear out the ep descriptors for non-ep0 */
-- 

2.31.1


>>
>> Probably we should try rework the usb gadget framework instead of
>> workaround the problem in dwc3. Here is a potential solution I'm
>> thinking: introduce usb_ep_disable_with_flush().
>>
> Actually, no. Let's just revert this:
>
> b0d5d2a71641 ("usb: gadget: udc: core: Revise comments for USB ep enable/disable")
>
> Reword the implementation in dwc3 and audit where usb_ep_disable() is used.
>
> Thanks,
> Thinh

