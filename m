Return-Path: <stable+bounces-241684-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOfsATPP8GnDYwEAu9opvQ
	(envelope-from <stable+bounces-241684-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 17:16:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E2650487A6C
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 17:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9498A310AE2B
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 14:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD52C43DA4F;
	Tue, 28 Apr 2026 14:49:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-m1973176.qiye.163.com (mail-m1973176.qiye.163.com [220.197.31.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48A643E498;
	Tue, 28 Apr 2026 14:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777387753; cv=none; b=Nr3hwBUvCldEs0tQX77GYW4Wvmn2kH3cfCXvZtXqYjq/HjAOc120pQPBf9vGcrVagwfYw1C9lNgk/PWrsLFzIZO8H28pTpi099OD5xIRNRPvytCY4YtMhyEJJnYWmthg9uI5hcYjX+pvqQXj/srA0SQE3alaMf2o38nAuCJcIyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777387753; c=relaxed/simple;
	bh=7C2tT2XPsJ0tnqj+PNUNEghNWd4eaESITOn65UauzJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l6ymYdNzbfdH1jk8ha3uYk2D5/zKtDDHTAbGdoX3pz+C56JbKT06A2LdsB9b8KzCAPqXzZhCTrjPKAWndqBIwxFso2Uu906vsy1iuWJiGrL5JMieLHB5/P4Fn5FBIcr3jZJQcXWduDijSpRPkSCsJN1/w6YOtQvf7458b5teDoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=autochips.com; spf=pass smtp.mailfrom=autochips.com; arc=none smtp.client-ip=220.197.31.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=autochips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=autochips.com
Received: from [172.25.88.78] (unknown [223.244.89.246])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3c7c38f73;
	Tue, 28 Apr 2026 22:48:57 +0800 (GMT+08:00)
Message-ID: <49e3cff9-9ace-4eed-aa2c-7f83825c44ee@autochips.com>
Date: Tue, 28 Apr 2026 22:48:57 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: cdns3: gadget: fix request skipping after clearing
 halt
To: Pawel Laszczak <pawell@cadence.com>,
 "Peter Chen (CIX)" <peter.chen@kernel.org>
Cc: "rogerq@kernel.org" <rogerq@kernel.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20260423160601.2949010-1-yongchao.wu@autochips.com>
 <ae66WphA+lO6t3rE@nchen-desktop>
 <PH7PR07MB9538E83DB108635EAE7B21E3DD362@PH7PR07MB9538.namprd07.prod.outlook.com>
 <ae/qXIT19Z2zWsDs@nchen-desktop>
 <e963d293-63cd-4124-9a53-8fc16e44ec72@autochips.com>
 <PH7PR07MB95388984DB7A5265770CEE58DD372@PH7PR07MB9538.namprd07.prod.outlook.com>
Content-Language: en-US
From: Yongchao Wu <yongchao.wu@autochips.com>
In-Reply-To: <PH7PR07MB95388984DB7A5265770CEE58DD372@PH7PR07MB9538.namprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9dd490928303ackunmd1caf043686ad8
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSktDVksZT0pLTEsfS0lJGVYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSU9PVUNCVUlPTVlXWRYaDxIVHRRZQVlPS0hVSk
	tJT09PSFVKS0tVSkJLS1kG
X-Rspamd-Queue-Id: E2650487A6C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[autochips.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241684-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yongchao.wu@autochips.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.954];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On 4/28/2026 5:58 PM, Pawel Laszczak wrote:
> 
>>
>> On 26-04-27 09:01:47, Pawel Laszczak wrote:
>>>>
>>>>
>>>> On 26-04-24 00:06:01, Yongchao Wu wrote:
>>>>> According to the cdns3 datasheet, the EPRST (Endpoint Reset) command
>>>>> causes the DMA engine to reposition its internal pointer to the next
>>>>> Transfer Descriptor (TD) if it was already processing one.
>>>>>
>>>>> This issue is consistently observed during the ADB identification
>>>>> process on macOS hosts, where the host issues a Clear_Halt. Although  
>>>>> commit 4bf2dd65135a ("usb: cdns3: gadget: toggle cycle bit before   reset
>>>>> reset endpoint") attempted to avoid DMA advance by toggling the cycle bit,
>>>>> trace logs show that on certain hosts like macOS, the DMA pointer  
>>>>> (EP_TRADDR) still shifts after EPRST:
>>>>>
>>>>>    cdns3_ctrl_req: Clear Endpoint Feature(Halt ep1out)
>>>>>    cdns3_doorbell_epx: ep1out, ep_trbaddr f9c04030  <- Should be f9c04000
>>>>>    cdns3_gadget_giveback: ep1out: req: ... length: 16384/16384
>>>>>
>>>>> As shown above, the DMA pointer jumped to index 3 (offset 0x30),  
>>>>> causing the controller to skip the initial TRBs of the request. This  
>>>>> leads to data misalignment and ADB protocol hangs on macOS.
>>>>
>>>> Pawel, Is it a hardware issue? The cycle bit has already been toggled before the  
>>>> endpoint has been reset, why the DMA pointer still advances?
>>>
>>> Yongchao, could you confirm if the TD consists of three TRBs?
>> In our case, each TD consists of 4 TRBs.
>> The DMA pointer appears to advance within the same TD after EPRST.
>>
>> Each 16KB request is split into 4 TRBs (4KB each):
>> - TRB0 - TRB2: CHAIN
>> - TRB3: IOC (last TRB of the TD)
>>
>> After enqueue, the initial EP_TRADDR points to the first TRB:
>>    EP_TRADDR = 0xf9c04000 (TRB0)
>>
>> After Clear_Halt (EPRST), it becomes:
>>    EP_TRADDR = 0xf9c04030 (TRB3)
>>
>> Since each TRB is 12 bytes, the offset 0x30 corresponds to 4 TRBs.
>> This indicates that after EPRST, the DMA pointer skipped the entire current
>> Request and jumped directly to the start of the next Request at 0xf9c04030
>>
>> Below is the relevant trace (trimmed):
>>
>> // enqueue request (16KB -> 4 TRBs)
>> cdns3_prepare_trb: dma buf: 0xf7abc000, size: 4096, ctrl: 0x00200415
>> cdns3_prepare_trb: dma buf: 0xf7abd000, size: 4096, ctrl: 0x00000415
>> cdns3_prepare_trb: dma buf: 0xf7abe000, size: 4096, ctrl: 0x00000415
>> cdns3_prepare_trb: dma buf: 0xf7abf000, size: 4096, ctrl: 0x00000425
>>
>> cdns3_doorbell_epx: ep1out, ep_trbaddr f9c04000
>>
>> // Clear_Halt
>> cdns3_ctrl_req: Clear Endpoint Feature(Halt ep1out)
>> cdns3_doorbell_epx: ep1out, ep_trbaddr f9c04030
>>
> 
> Can you confirm whether the host had already sent some data for this TD
> prior to the endpoint reset operation?
>

I confirm that the host sent no data prior to or during the EPRST operation.

TotalPhase Trace:
0,HS,2700,0:06.078.671,2.057.666 ms,0 B,,13,00,Set Configuration,Configuration=1
0,HS,2710,0:06.080.811,1.125.266 ms,,,,,[10 SOF],[Frames: 1243.7 - 1245.0]
0,HS,2711,0:06.080.955,992.550 us,2 B,,13,00,Get String Descriptor,Index=5 Length=2
0,HS,2733,0:06.082.061,125.083 us,,,,,[2 SOF],[Frames: 1245.1 - 1245.2]
0,HS,2734,0:06.082.119,104.566 us,28 B,,13,00,Get String Descriptor,Index=5 Length=28
0,HS,2756,0:06.082.311,355.935.283 ms,,,,,[2848 SOF],[Frames: 1245.3 - 1601.2]
0,HS,2757,0:06.438.196,105.033 us,4 B,,13,00,Get String Descriptor,Index=0 Length=256
0,HS,2778,0:06.438.371,875.233 us,,,,,[8 SOF],[Frames: 1601.3 - 1602.2]
//1. Host issues Clear_Halt
0,HS,2779,0:06.439.278,51.433 us,0 B,,13,00,Clear Endpoint Feature,Halt Endpoint 01 OUT
0,HS,2789,0:06.439.371,500.150 us,,,,,[5 SOF],[Frames: 1602.3 - 1602.7]
0,HS,2790,0:06.439.874,51.416 us,0 B,,13,00,Clear Endpoint Feature,Halt Endpoint 01 IN
0,HS,2800,0:06.439.996,250.116 us,,,,,[3 SOF],[Frames: 1603.0 - 1603.2]
//2. First OUT transaction happens
0,HS,2801,0:06.440.350,1.066 us,24 B,,13,01,OUT txn,43 4E 58 4E 01 00 00 01 00 00 10 00..
0,HS,2805,0:06.440.371,66 ns,,,,,[1 SOF],[Frame: 1603.3]
0,HS,2806,0:06.440.453,4.283 us,218 B,,13,01,OUT txn,68 6F 73 74 3A 3A 66 65 61 74 75 72..

> Pawel
> 
>> Best regards,
>> Yongchao
>> Best regards,
>> Yongchao


