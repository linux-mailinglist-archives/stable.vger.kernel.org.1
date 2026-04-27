Return-Path: <stable+bounces-241454-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +C4WGJT572nbMwEAu9opvQ
	(envelope-from <stable+bounces-241454-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 02:04:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D32647C0A4
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 02:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61CF4301D695
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 00:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C2628E0;
	Tue, 28 Apr 2026 00:04:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-m3287.qiye.163.com (mail-m3287.qiye.163.com [220.197.32.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA4D800;
	Tue, 28 Apr 2026 00:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777334671; cv=none; b=hCK90aCoF4kil/NGQm0gW1yl+bv/yB6c3J3+XrmtfJqwoexOhoeIXvpOwuTWC4JV0HLoQbbrmvD9CKtsQyYnEjxje9irR1UP4oFlhvzCkaxD3DO1I7BIB9pRGhiK3N2cvl5ATt+m3GrVvyguKRJRDMcypL4mqUgNCeYMseDW0Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777334671; c=relaxed/simple;
	bh=KcqdrOPdZF/dfahk91kV4TTS0PX7Iq7BIwyKMo3OWpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UjSmUeWl4twSGNiFiAfbcWa4k1uL/tyArGLx8XDBgOlE7zAqj8SVSFTevEUxJaiPVa0nRPil09LDfSeDcTveLnrAAyz8Z8kdEuajXSNS8xZWdhbJTHi3Pqp7UDguEZR/JqQH7WtdzyBw4LEUM/EKQAo/ETx8r7CQ2fV358iQ9Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=autochips.com; spf=pass smtp.mailfrom=autochips.com; arc=none smtp.client-ip=220.197.32.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=autochips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=autochips.com
Received: from [172.25.88.78] (unknown [223.244.89.246])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3c5dc7f2d;
	Tue, 28 Apr 2026 07:59:03 +0800 (GMT+08:00)
Message-ID: <e963d293-63cd-4124-9a53-8fc16e44ec72@autochips.com>
Date: Tue, 28 Apr 2026 07:59:02 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: cdns3: gadget: fix request skipping after clearing
 halt
To: "Peter Chen (CIX)" <peter.chen@kernel.org>,
 Pawel Laszczak <pawell@cadence.com>
Cc: "rogerq@kernel.org" <rogerq@kernel.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20260423160601.2949010-1-yongchao.wu@autochips.com>
 <ae66WphA+lO6t3rE@nchen-desktop>
 <PH7PR07MB9538E83DB108635EAE7B21E3DD362@PH7PR07MB9538.namprd07.prod.outlook.com>
 <ae/qXIT19Z2zWsDs@nchen-desktop>
Content-Language: en-US
From: Yongchao Wu <yongchao.wu@autochips.com>
In-Reply-To: <ae/qXIT19Z2zWsDs@nchen-desktop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9dd161d68203ackunm846abe815c3762
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDHUgaVkMdHR9CTUNKGB4ZTlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSU9PVUNCVUlPTVlXWRYaDxIVHRRZQVlPS0hVSk
	tJT09PSFVKS0tVSkJLS1kG
X-Rspamd-Queue-Id: 7D32647C0A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[autochips.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-241454-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yongchao.wu@autochips.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 26-04-27 09:01:47, Pawel Laszczak wrote:
 >>
 >>
 >> On 26-04-24 00:06:01, Yongchao Wu wrote:
 >>> According to the cdns3 datasheet, the EPRST (Endpoint Reset) command
 >>> causes the DMA engine to reposition its internal pointer to the next
 >>> Transfer Descriptor (TD) if it was already processing one.
 >>>
 >>> This issue is consistently observed during the ADB identification
 >>> process on macOS hosts, where the host issues a Clear_Halt. Although
 >>> commit 4bf2dd65135a ("usb: cdns3: gadget: toggle cycle bit before
 >>> reset
 >>> endpoint") attempted to avoid DMA advance by toggling the cycle bit,
 >>> trace logs show that on certain hosts like macOS, the DMA pointer
 >>> (EP_TRADDR) still shifts after EPRST:
 >>>
 >>>   cdns3_ctrl_req: Clear Endpoint Feature(Halt ep1out)
 >>>   cdns3_doorbell_epx: ep1out, ep_trbaddr f9c04030  <- Should be 
f9c04000
 >>>   cdns3_gadget_giveback: ep1out: req: ... length: 16384/16384
 >>>
 >>> As shown above, the DMA pointer jumped to index 3 (offset 0x30),
 >>> causing the controller to skip the initial TRBs of the request. This
 >>> leads to data misalignment and ADB protocol hangs on macOS.
 >>
 >> Pawel, Is it a hardware issue? The cycle bit has already been 
toggled before the
 >> endpoint has been reset, why the DMA pointer still advances?
 >
 > Yongchao, could you confirm if the TD consists of three TRBs?
In our case, each TD consists of 4 TRBs.
The DMA pointer appears to advance within the same TD after EPRST.

Each 16KB request is split into 4 TRBs (4KB each):
- TRB0 - TRB2: CHAIN
- TRB3: IOC (last TRB of the TD)

After enqueue, the initial EP_TRADDR points to the first TRB:
   EP_TRADDR = 0xf9c04000 (TRB0)

After Clear_Halt (EPRST), it becomes:
   EP_TRADDR = 0xf9c04030 (TRB3)

Since each TRB is 12 bytes, the offset 0x30 corresponds to 4 TRBs.
This indicates that after EPRST, the DMA pointer skipped the entire
current Request and jumped directly to the start of the next Request
at 0xf9c04030

Below is the relevant trace (trimmed):

// enqueue request (16KB -> 4 TRBs)
cdns3_prepare_trb: dma buf: 0xf7abc000, size: 4096, ctrl: 0x00200415
cdns3_prepare_trb: dma buf: 0xf7abd000, size: 4096, ctrl: 0x00000415
cdns3_prepare_trb: dma buf: 0xf7abe000, size: 4096, ctrl: 0x00000415
cdns3_prepare_trb: dma buf: 0xf7abf000, size: 4096, ctrl: 0x00000425

cdns3_doorbell_epx: ep1out, ep_trbaddr f9c04000

// Clear_Halt
cdns3_ctrl_req: Clear Endpoint Feature(Halt ep1out)
cdns3_doorbell_epx: ep1out, ep_trbaddr f9c04030

This behavior is consistently observed on macOS hosts during
ADB enumeration.

So even though the cycle bit is toggled on the first TRB, the
controller still appears to advance the DMA pointer within the same TD
after EPRST.

Please let me know if you need more detailed logs or a full TRB
ring dump. I'd also appreciate any insight into how the controller
determines the next position after EPRST in this case.

Best regards,
Yongchao

