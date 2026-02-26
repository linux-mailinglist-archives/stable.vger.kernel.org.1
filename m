Return-Path: <stable+bounces-219790-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMTJF1IooGlIfwQAu9opvQ
	(envelope-from <stable+bounces-219790-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 12:02:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B574E1A4C3F
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 12:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92E883128F7C
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 11:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BA33314DC;
	Thu, 26 Feb 2026 11:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="k+dgBE+J"
X-Original-To: stable@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A40330334
	for <stable@vger.kernel.org>; Thu, 26 Feb 2026 11:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772103609; cv=none; b=b9HHAwFtOl+bLf6tDsctQzmElnnCFSq2b5dXGu3w46xdQyNXZoQdDvD5ikOwiGg2h7RZpos+dVQGie/bPMLuwbPMhb/ZMqWEqwtditclwxzMHyaaVfcJ1liPlR9PskaSsGtJrX25ID0iCA8F7HoRFBzakr07c5SHZAs7rwBAp2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772103609; c=relaxed/simple;
	bh=gieEH8K96UPNel83M+RWW21YtyLgXoaQin5xHiogz1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=d1MfY8z80X+gadjD1khCTcsq6gLPQd792kWzIMKVULSqtV3bhPXdZMI8DZ2KufrNZhqAh+k13v0dHn/HunrT0RS/7yYGefIBZ8Z6r5jSjxBvf3U1nLiJ2nfa+u6KmNUoa+oejQqz//ydnMkMmmADX2OlMeZVnrwaKz8uqp4wcvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=k+dgBE+J; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260226110004epoutp013dfc583a8390676ec2536a114c9130d3~XxtbRWsMZ1317813178epoutp01I
	for <stable@vger.kernel.org>; Thu, 26 Feb 2026 11:00:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260226110004epoutp013dfc583a8390676ec2536a114c9130d3~XxtbRWsMZ1317813178epoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1772103604;
	bh=OE/1JwvYgxzCAc14VBywGHq+byYs/c5MBIpAQRfy4m4=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=k+dgBE+JThIE1505gC33Bl7U6RMhI01rUdpEVfwJp4jLbSdSo1HbpwW38dKEUJxQt
	 pE+9vA4AIfuXrMED2kBOzHmkwGfJdq4dq2fxJQIRE0ONopfNVkFxmQ01IFQk9Jw0+k
	 kADH4aPFNWEZpJRyHBtRZc0yswQvEXYdVAMFV9NA=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20260226110003epcas5p2fd570de868b6a641d51f9f3c3dccc4de~XxtazSUkN1588815888epcas5p2Z;
	Thu, 26 Feb 2026 11:00:03 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.92]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4fM7lQ16fSz2SSKj; Thu, 26 Feb
	2026 11:00:02 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20260226110001epcas5p28add4711e73a7829277a863ba1753a51~XxtYxEW__1588815888epcas5p2Q;
	Thu, 26 Feb 2026 11:00:01 +0000 (GMT)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260226105959epsmtip182f6e751b58b9906dd2bb295b88b7345~XxtWt75nq0619706197epsmtip1s;
	Thu, 26 Feb 2026 10:59:59 +0000 (GMT)
Message-ID: <264c4448-8e67-4918-8d5d-60b6bba1162f@samsung.com>
Date: Thu, 26 Feb 2026 16:29:46 +0530
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
In-Reply-To: <20251212012108.wjn2pavyg6qaiytt@synopsys.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260226110001epcas5p28add4711e73a7829277a863ba1753a51
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251204015221epcas5p3ed1b6174589b47629ea9333e3ddbb176
References: <2b944e45-c39a-4c34-b159-ba91dd627fe4@rowland.harvard.edu>
	<20251121022156.vbnheb6r2ytov7bt@synopsys.com>
	<f6bba9d1-2221-4bad-a7d7-564a5a311de1@rowland.harvard.edu>
	<4e82c0dd-4a36-4e1d-a93a-9bef5d63aa50@samsung.com>
	<CGME20251204015221epcas5p3ed1b6174589b47629ea9333e3ddbb176@epcas5p3.samsung.com>
	<20251204015125.qgio53oimdes5kjr@synopsys.com>
	<9d309a6f-39b2-43da-96a6-b7c59b98431e@samsung.com>
	<20251205003723.rum7bexy2tazcdwb@synopsys.com>
	<20251205011823.6ujxcjimlyetpjvj@synopsys.com>
	<28035b59-3138-40e6-beb3-1a3793e8df84@samsung.com>
	<20251212012108.wjn2pavyg6qaiytt@synopsys.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[samsung.com:+];
	TAGGED_FROM(0.00)[bounces-219790-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,samsung.com:mid,samsung.com:dkim,samsung.com:email];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[selvarasu.g@samsung.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: B574E1A4C3F
X-Rspamd-Action: no action


On 12/12/2025 6:51 AM, Thinh Nguyen wrote:
> On Thu, Dec 11, 2025, Selvarasu Ganesan wrote:
>> On 12/5/2025 6:48 AM, Thinh Nguyen wrote:
>>>> I was hoping that the dwc3_gadget_ep_queue() won't come early to run
>>>> into this scenario. What I've provided will only mitigate and will not
>>>> resolve for all cases. It seems adding more checks in dwc3 will be
>>>> more messy.
>>
>> Hi Thinh,
>>
>>
>> Thank you for the insightful comments. I agree that adding more checks
>> directly in the dwc3 driver would be messy, and a comprehensive rework
>> of the dwc3 ep disable would ultimately be the cleaner solution.
>>
>> In the meantime, Introducing additional checks for
>> DWC3_EP_TRANSFER_STARTED in dwc3 driver is the most practical way to
>> unblock the current issue while we work toward that longer‑term fix.
>> We have applied the patches and performed additional testing, no
>> regressions or new issues were observed.
>>
>> Could you please confirm whether below interim fix is acceptable along
>> with your proposed earlier patch for unblocking the current development
>> flow?
>>
>>
>> Patch 2: usb: dwc3: protect dep->flags from concurrent modify in
>> dwc3_gadget_ep_disable
>> =======================================================================================
>>
>> Subject: [PATCH] usb: dwc3: protect dep->flags from concurrent modify in
>> dwc3_gadget_ep_disable
>> The below warnings in `dwc3_gadget_ep_queue` observed during the RNDIS
>> enable/disable test is caused by a race between `dwc3_gadget_ep_disable`
>> and `dwc3_gadget_ep_queue`. Both functions manipulate `dep->flags`, and
>> the lock released temporarily by `dwc3_gadget_giveback` (called from
>> `dwc3_gadget_ep_disable`) can be acquired by `dwc3_gadget_ep_queue`
>> before `dwc3_gadget_ep_disable` has finished. This leads to an
>> inconsistent state of the `DWC3_EP_TRANSFER_STARTED` dep->flag.
>>
>> To fix this issue by add a condition check when masking `dep->flags`
>> in `dwc3_gadget_ep_disable` to ensure the `DWC3_EP_TRANSFER_STARTED`
>> flag is not cleared when it is actually set. This prevents the spurious
>> warning and eliminates the race.
>>
>> Thread#1:
>> dwc3_gadget_ep_disable
>>     ->__dwc3_gadget_ep_disable
>>      ->dwc3_remove_requests
>>       ->dwc3_stop_active_transfer
>>        ->__dwc3_stop_active_transfer
>>         -> dwc3_send_gadget_ep_cmd (cmd =DWC3_DEPCMD_ENDTRANSFER)
>>          ->if(!interrupt)dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
>>           ->dwc3_gadget_giveback
>>            ->spin_unlock(&dwc->lock)
>>              ...
>>              While Thread#1 is still running, Thread#2 starts:
>>
>> Thread#2:
>> usb_ep_queue
>>     ->dwc3_gadget_ep_queue
>>      ->__dwc3_gadget_kick_transfer
>>       -> starting = !(dep->flags & DWC3_EP_TRANSFER_STARTED);
>>        ->if(starting)
>>          ->dwc3_send_gadget_ep_cmd (cmd = DWC3_DEPCMD_STARTTRANSFER)
>>           ->dep->flags |= DWC3_EP_TRANSFER_STARTED;
>>             ...
>>              ->__dwc3_gadget_ep_disable
>>               ->mask = DWC3_EP_TXFIFO_RESIZED |DWC3_EP_RESOURCE_ALLOCATED;
>>                ->dep->flags &= mask; --> // Possible of clears
>>                    DWC3_EP_TRANSFER_STARTED flag as well without
>>                    sending DWC3_DEPCMD_ENDTRANSFER
>>
>>    ------------[ cut here ]------------
>>     dwc3 13200000.dwc3: No resource for ep1in
>>     WARNING: CPU: 7 PID: 1748 at drivers/usb/dwc3/gadget.c:398
>> dwc3_send_gadget_ep_cmd+0x2f8/0x76c
>>     pc : dwc3_send_gadget_ep_cmd+0x2f8/0x76c
>>     lr : dwc3_send_gadget_ep_cmd+0x2f8/0x76c
>>     Call trace:
>>       dwc3_send_gadget_ep_cmd+0x2f8/0x76c
>>       __dwc3_gadget_kick_transfer+0x2ec/0x3f4
>>       dwc3_gadget_ep_queue+0x140/0x1f0
>>       usb_ep_queue+0x60/0xec
>>       mp_tx_task+0x100/0x134
>>       mp_tx_timeout+0xd0/0x1e0
>>       __hrtimer_run_queues+0x130/0x318
>>       hrtimer_interrupt+0xe8/0x340
>>       exynos_mct_comp_isr+0x58/0x80
>>       __handle_irq_event_percpu+0xcc/0x25c
>>       handle_irq_event+0x40/0x9c
>>       handle_fasteoi_irq+0x154/0x2c8
>>       generic_handle_domain_irq+0x58/0x80
>>       gic_handle_irq+0x48/0x104
>>       call_on_irq_stack+0x3c/0x50
>>       do_interrupt_handler+0x4c/0x84
>>       el1_interrupt+0x34/0x58
>>       el1h_64_irq_handler+0x18/0x24
>>       el1h_64_irq+0x68/0x6c
>>
>> Change-Id: Ib6a77ce5130e25d0162f72d0e52c845dbb1d18f5
>> Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
>> ---
>>    drivers/usb/dwc3/gadget.c | 16 ++++++++++++++++
>>    1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index b42d225b67408..1dc5798072120 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -1051,6 +1051,22 @@ static int __dwc3_gadget_ep_disable(struct
>> dwc3_ep *dep)
>>         */
>>        if (dep->flags & DWC3_EP_DELAY_STOP)
>>            mask |= (DWC3_EP_DELAY_STOP | DWC3_EP_TRANSFER_STARTED);
>> +
>> +    /*
>> +     * When dwc3_gadget_ep_disable() calls dwc3_gadget_giveback(),
>> +     * the  dwc->lock is temporarily released.  If dwc3_gadget_ep_queue()
>> +     * runs in that window it may set the DWC3_EP_TRANSFER_STARTED flag as
>> +     * part of dwc3_send_gadget_ep_cmd. The original code cleared the flag
>> +     * unconditionally, which could overwrite the concurrent modification.
>> +     *
>> +     * The added check ensures the DWC3_EP_TRANSFER_STARTED flag is only
>> +     * cleared if it is not set already, preserving the state updated
>> by the
>> +     * concurrent ep_queue path and eliminating the EP resource conflict
>> +     * warning.
>> +     */
> We need to explain the underlining problem here and in the commit
> message. The function usb_ep_disable() is expected be used interrupt
> context, and it's being used in interrupt context in the composite
> framework. There's no wait for flushing of endpoint is handled before
> usb_ep_disable completes.
>
> We are adding a temporary workaround to handle the endpoint
> reconfiguration and restart before the flushing completed.
>
>> +    if (dep->flags & DWC3_EP_TRANSFER_STARTED)
>> +        mask |= DWC3_EP_TRANSFER_STARTED;
>> +
>>        dep->flags &= mask;
>>
>>        /* Clear out the ep descriptors for non-ep0 */
>> -- 
>>
>> 2.31.1
>>
>>
> For your case, it may work because the endpoint is probably reconfigured
> to be the same in usb_ep_enable(). If we reconfigure the endpoint before
> the endpoint is stopped, the behavior is underfined.
>
> You can create the patches and Cc stable. However, I would not add the
> "Fixes" tag since they (IMHO) are not really fixes. May also need to
> note that under the "---" in the commit explain why there's no Fixes tag
> also.
>
> Thanks,
> Thinh


Hi Thinh,

This is a followup regarding the temporary workaround patches.

In v3, I will incorporate the actual underlying issue into the commit 
message proper, and include a note under the '---' separator explaining 
why the Fixes tag was not added.

Please review the updated patches in below and let me know if you have 
any concerns.



Subject: [PATCH v3 1/2] usb: dwc3: gadget: Prevent EPs resource conflict
during StartTransfer
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The below “No resource for ep” warning appears when a StartTransfer
command is issued for bulk or interrupt endpoints in
`dwc3_gadget_ep_enable` while a previous StartTransfer on the same
endpoint is still in progress. The gadget functions drivers can invoke
`usb_ep_enable` (which triggers a new StartTransfer command) before the
earlier transfer has completed. Because the previous StartTransfer is
still active, `dwc3_gadget_ep_disable` can skip the required
`EndTransfer` due to `DWC3_EP_DELAY_STOP`, leading to the endpoint
resources are busy for previous StartTransfer and warning ("No resource
for ep") from dwc3 driver.

The underlying framework issue is that `usb_ep_disable()` is expected to
complete pending requests before returning, but is allowed to be called
from interrupt context where sleeping to wait for completion is not
possible.

Add a temporary workaround to handle the endpoint reconfiguration and
restart before the flushing completed. Specifically, a check is added to
`dwc3_gadget_ep_enable` that checks the `DWC3_EP_TRANSFER_STARTED`
flag before issuing a new StartTransfer. By preventing a second
StartTransfer on an already busy endpoint, the resource conflict is
eliminated, the warning disappears, and potential kernel panics caused
by `panic_on_warn` are avoided.

------------[ cut here ]------------
dwc3 13200000.dwc3: No resource for ep1out
WARNING: CPU: 0 PID: 700 at drivers/usb/dwc3/gadget.c:398 
dwc3_send_gadget_ep_cmd+0x2f8/0x76c
Call trace:
dwc3_send_gadget_ep_cmd+0x2f8/0x76c
__dwc3_gadget_ep_enable+0x490/0x7c0
dwc3_gadget_ep_enable+0x6c/0xe4
usb_ep_enable+0x5c/0x15c
mp_eth_stop+0xd4/0x11c
__dev_close_many+0x160/0x1c8
__dev_change_flags+0xfc/0x220
dev_change_flags+0x24/0x70
devinet_ioctl+0x434/0x524
inet_ioctl+0xa8/0x224
sock_do_ioctl+0x74/0x128
sock_ioctl+0x3bc/0x468
__arm64_sys_ioctl+0xa8/0xe4
invoke_syscall+0x58/0x10c
el0_svc_common+0xa8/0xdc
do_el0_svc+0x1c/0x28
el0_svc+0x38/0x88
el0t_64_sync_handler+0x70/0xbc
el0t_64_sync+0x1a8/0x1ac

Cc: stable@vger.kernel.org
Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
---

Note: No Fixes tag is added because this is a workaround for the
gadget framework issue where the gadget framework calls usb_ep_disable()
in interrupt context without ensuring endpoint flushing completes.
A proper fix requires refactoring the framework to make sure
usb_ep_disable is invoked in process context.
---
drivers/usb/dwc3/gadget.c | 5 +++--
1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 502d54ce13bc..949a9e6b176a 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -951,8 +951,9 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep 
*dep, unsigned int action)
* Issue StartTransfer here with no-op TRB so we can always rely on No
* Response Update Transfer command.
*/
- if (usb_endpoint_xfer_bulk(desc) ||
- usb_endpoint_xfer_int(desc)) {
+ if ((usb_endpoint_xfer_bulk(desc) ||
+ usb_endpoint_xfer_int(desc)) &&
+ !(dep->flags & DWC3_EP_TRANSFER_STARTED)) {
struct dwc3_gadget_ep_cmd_params params;
struct dwc3_trb *trb;
dma_addr_t trb_dma;
--
2.34.1



Subject: [PATCH v3 2/2] usb: dwc3: gadget: Protect endpoint flags during
  concurrent ep disable and queue

A race condition exists between dwc3_gadget_ep_disable() and
dwc3_gadget_ep_queue() when manipulating dep->flags. The underlying
framework issue is that usb_ep_disable() is expected be used interrupt
context, and it's being used in interrupt context in the composite
framework. There's no wait for flushing of endpoint is handled before
usb_ep_disable completes.

In the race scenario: when dwc3_gadget_ep_disable() calls
dwc3_gadget_giveback(), the dwc->lock is temporarily released. If
dwc3_gadget_ep_queue() runs in that window, it set the
DWC3_EP_TRANSFER_STARTED flag via dwc3_send_gadget_ep_cmd(). When
ep_disable resumes, it unconditionally clears all flags except those
explicitly masked, potentially clearing DWC3_EP_TRANSFER_STARTED even
though a new transfer has started. This leads to "No resource ep"
warnings on subsequent StartTransfer attempts.

As a temporary workaround for the framework limitation, add a condition
check when masking `dep->flags` in `dwc3_gadget_ep_disable` to ensure
the `DWC3_EP_TRANSFER_STARTED` flag is not cleared when it is actually
set. This prevents the spurious warning and eliminates the race.

Cc: stable@vger.kernel.org
Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
---

Note: No Fixes tag is added because this is a workaround for the
gadget framework issue where the gadget framework calls usb_ep_disable()
in interrupt context without ensuring endpoint flushing completes.
A proper fix requires refactoring the framework to make sure
usb_ep_disable is invoked in process context.
---
  drivers/usb/dwc3/gadget.c | 17 +++++++++++++++++
  1 file changed, 17 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 949a9e6b176a..1b16d103d94e 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1078,6 +1078,23 @@ static int __dwc3_gadget_ep_disable(struct 
dwc3_ep *dep)
          */
         if (dep->flags & DWC3_EP_DELAY_STOP)
                 mask |= (DWC3_EP_DELAY_STOP | DWC3_EP_TRANSFER_STARTED);
+
+       /*
+        * When dwc3_gadget_ep_disable() calls dwc3_gadget_giveback(),
+        * the dwc->lock is temporarily released. If dwc3_gadget_ep_queue()
+        * runs in that window it may set the DWC3_EP_TRANSFER_STARTED 
flag as
+        * part of dwc3_send_gadget_ep_cmd. The original code cleared 
the flag
+        * unconditionally in the mask operation, which could overwrite the
+        * concurrent modification.
+        *
+        * As a workaround for the interrupt context constraint where we 
cannot
+        * wait for endpoint flushing, preserve the DWC3_EP_TRANSFER_STARTED
+        * flag if it is set, avoiding resource conflicts until the 
framework
+        * is fixed to properly synchronize endpoint lifecycle management.
+        */
+       if (dep->flags & DWC3_EP_TRANSFER_STARTED)
+               mask |= DWC3_EP_TRANSFER_STARTED;
+
         dep->flags &= mask;

         /* Clear out the ep descriptors for non-ep0 */
--
2.34.1


Thnaks,
Selva



