Return-Path: <stable+bounces-238349-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ON5KNWMo4Wl0pwAAu9opvQ
	(envelope-from <stable+bounces-238349-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 20:20:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D383413B0D
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 20:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D3653011063
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 18:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3790C322B7D;
	Thu, 16 Apr 2026 18:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="aNpYPdS7"
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF5F30C62D
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 18:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776363617; cv=none; b=uQGuMA9kHXeV+GB85/8lWXEq+zXOLSELH7oEfql2IlyBBju9s0e8QtF+5UyJKajn3XwQhsAJEgfveB12oCMMFbPF3nhCKPFG1oB6tXudk/5GzmcATLi0Q1JSpssr3E+OcUvtFmk4SJXHJ0weMU/gvnh0a6kuq7do9hrdCtlZ2wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776363617; c=relaxed/simple;
	bh=+turttpIQmHXTclCmSyNTE5++FudpvOpqobqEdEmwh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BbjIWj1HZ2VkkculnzKxxuRsY97p4w7zDihXSl/tUs4oJ37bLZXrfz4YgLoYfPg5jBfXLjxVf57geulbhe5cG4Fd6np+6jr9rY10RaJHGpfDf6aNAVuFliyBc3Q738Ar0Ftaq5GqzrofnhQm3gBRdOsNp3jbJXmlO2lqd5LjLS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=aNpYPdS7; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9BAA4103EDC;
	Thu, 16 Apr 2026 20:20:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1776363612;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=8mu6+Lx8bask9UvrYUKO0JD2GAEyGj7uFT87yPCVajY=;
	b=aNpYPdS73XDVS8i6Z4CzB2vyD4mCjrJbqgIY0qnP2GqBU4yLWZDz5naD+uN+3S9Pok6swY
	r9B7DU/ektzwCG6DMLjR8+rCRNTkbiXuMTIODyFvtA4eMoxWLIKHCsuz+fqrlQ7jVmsfQX
	u/py27vMxjNCniaTyAxMUiKcjkFNAIdV2V3ugKpVYcyOWOr4FAWjIJ0VPMa/2hvMO0G8Rb
	ciO7uyfwHlu6udIBbshQfX/Twcers0pCm1eOdlO2/sqCvfOL11bpwzqZiaaZ4xZW4ufwoT
	S2dQesRbJe3igDXxXjktBSQTBFzatGz01ciBQ3igFwPemTup5gtINe7XNlZYBg==
Message-ID: <8c909ddd-c8ff-43a1-987f-1a348917d75a@nabladev.com>
Date: Thu, 16 Apr 2026 20:20:10 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 311/491] dmaengine: xilinx: xilinx_dma: Fix unmasked
 residue subtraction
To: Ben Hutchings <ben@decadent.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Vinod Koul <vkoul@kernel.org>,
 Sasha Levin <sashal@kernel.org>
References: <20260413155819.042779211@linuxfoundation.org>
 <20260413155830.683657586@linuxfoundation.org>
 <e4bf9ba9ceba4f2e23483b4aa0ebcff8251c0b73.camel@decadent.org.uk>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <e4bf9ba9ceba4f2e23483b4aa0ebcff8251c0b73.camel@decadent.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-238349-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marex@nabladev.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[nabladev.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nabladev.com:email,nabladev.com:dkim,nabladev.com:mid]
X-Rspamd-Queue-Id: 4D383413B0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/16/26 7:58 PM, Ben Hutchings wrote:
> On Mon, 2026-04-13 at 17:59 +0200, Greg Kroah-Hartman wrote:
>> 5.10-stable review patch.  If anyone has any objections, please let me know.
>>
>> ------------------
>>
>> From: Marek Vasut <marex@nabladev.com>
>>
>> [ Upstream commit c7d812e33f3e8ca0fa9eeabf71d1c7bc3acedc09 ]
>>
>> The segment .control and .status fields both contain top bits which are
>> not part of the buffer size, the buffer size is located only in the bottom
>> max_buffer_len bits. To avoid interference from those top bits, mask out
>> the size using max_buffer_len first, and only then subtract the values.
> 
> This change is harmless, but the problem it claims to fix does not
> exist.

The current code subtracts two independently read values which both 
contain status/control MSbits and the actual value LSbits. Depending on 
the MSbits being identical in both separately read values is unsafe, so 
the change in this patch masks out the MSbits first and then does the 
subtraction on the actual value LSbits only, which is safe.

Why do you think the original unsafe behavior can not trigger a failure?

> Ben.
> 
>> Fixes: a575d0b4e663 ("dmaengine: xilinx_dma: Introduce xilinx_dma_get_residue")
>> Signed-off-by: Marek Vasut <marex@nabladev.com>
>> Link: https://patch.msgid.link/20260316222530.163815-1-marex@nabladev.com
>> Signed-off-by: Vinod Koul <vkoul@kernel.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>   drivers/dma/xilinx/xilinx_dma.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
>> index ca80a1dee8489..a89a150be3284 100644
>> --- a/drivers/dma/xilinx/xilinx_dma.c
>> +++ b/drivers/dma/xilinx/xilinx_dma.c
>> @@ -964,16 +964,16 @@ static u32 xilinx_dma_get_residue(struct xilinx_dma_chan *chan,
>>   					      struct xilinx_cdma_tx_segment,
>>   					      node);
>>   			cdma_hw = &cdma_seg->hw;
>> -			residue += (cdma_hw->control - cdma_hw->status) &
>> -				   chan->xdev->max_buffer_len;
>> +			residue += (cdma_hw->control & chan->xdev->max_buffer_len) -
>> +			           (cdma_hw->status & chan->xdev->max_buffer_len);
>>   		} else if (chan->xdev->dma_config->dmatype ==
>>   			   XDMA_TYPE_AXIDMA) {
>>   			axidma_seg = list_entry(entry,
>>   						struct xilinx_axidma_tx_segment,
>>   						node);
>>   			axidma_hw = &axidma_seg->hw;
>> -			residue += (axidma_hw->control - axidma_hw->status) &
>> -				   chan->xdev->max_buffer_len;
>> +			residue += (axidma_hw->control & chan->xdev->max_buffer_len) -
>> +			           (axidma_hw->status & chan->xdev->max_buffer_len);
>>   		} else {
>>   			aximcdma_seg =
>>   				list_entry(entry,
>> @@ -981,8 +981,8 @@ static u32 xilinx_dma_get_residue(struct xilinx_dma_chan *chan,
>>   					   node);
>>   			aximcdma_hw = &aximcdma_seg->hw;
>>   			residue +=
>> -				(aximcdma_hw->control - aximcdma_hw->status) &
>> -				chan->xdev->max_buffer_len;
>> +				(aximcdma_hw->control & chan->xdev->max_buffer_len) -
>> +				(aximcdma_hw->status & chan->xdev->max_buffer_len);
>>   		}
>>   	}
>>   
[...]

