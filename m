Return-Path: <stable+bounces-232767-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDnYDK8SzWmMZwYAu9opvQ
	(envelope-from <stable+bounces-232767-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 14:42:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA44B37A9DC
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 14:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B72B300EF51
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 12:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B843E0254;
	Wed,  1 Apr 2026 12:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="h77EyTLn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9C2384221
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 12:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775044905; cv=none; b=Rz1AJTau79PfYXBNVR4SxbZkXzZP2Oh/usURhdngdNna0L4fmUy0qJp2+1PjBkFyWKCSek1vHPjFpTjZURdnuUdGzkFr3uAyLGZ+N0VhYkVp8riqtmVKc73eL9KTiZgktYVpcRDs/lvhbQlf+hOpXInkQkLQOfndOSy96EjXmIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775044905; c=relaxed/simple;
	bh=pvVv7D8UQ2G4Mw/nmqu8vkM8+Pe0lRNW4/kqqhlVXbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PEhz6Alsgt/hLzzQnVNl3G/glQSUO47zV6JblXNs88y2mS2jzOUkAgUNdLTH7q8KuDk90mbofjcmT9j9fqx61o/4FDvP44ki8qmlL9kH9JD4a5b6TN5aePl2nTPoBL/8Sg4NZOjImuUbZnP2FdNCvaSHRIdN2AsFgu2JT+sFeuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=h77EyTLn; arc=none smtp.client-ip=121.127.44.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1775044903;
 bh=SqAh8+J+p74P/kyDkkVzKjpnfMDd7XwXqLzKDtTGffs=;
 b=h77EyTLn3yo5NqYd/571d+UQlvBEnTHNv7HmkuxN+2dHiwnarRIcEzhCjSNA+Dg5lkFkISGXl
 7ebBdsNvjKShc4ezNd6q3lGK/h3+YvY5pGYxAED6DgsWkDh+T5FBvjg6YwewnaP7469VB1rsKQq
 x/gY/oHz/cvzzwKtp1/Y30mhbwa2h59BqiADjJXWwSAm1ai4bSHHjvg/YsIappNtZ/04b0LUhdn
 ZJiBsTgse1EVAivspUdMTpt9MCCq0oqU2RJZtSUU7T5MA/ajYMODGR3dzU0W0iL+ZV6TDPw8O5N
 gep2UyglFTW/DDsyRgqdlFxp/OlgdQ8fD3j2JNRjPjTw==
X-Forward-Email-ID: 69ccda55842394fec82951f9
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.6.64
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <e622cc9e-8fb0-454a-b88e-dc13cf2ff507@kwiboo.se>
Date: Wed, 1 Apr 2026 10:41:54 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/rockchip: fix page table allocation flags for v2
 IOMMU
To: Simon <xxm@rock-chips.com>, Midgy BALON <midgy971@gmail.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260331075010.1463-1-midgy971@gmail.com>
 <0f285782-b12a-4abd-bca7-b6c549bed59f@rock-chips.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <0f285782-b12a-4abd-bca7-b6c549bed59f@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kwiboo.se,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kwiboo.se:s=fe-e1b5cab7be];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-232767-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[rock-chips.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kwiboo.se:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonas@kwiboo.se,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.977];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kwiboo.se:dkim,kwiboo.se:email,kwiboo.se:mid]
X-Rspamd-Queue-Id: AA44B37A9DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Simon,

On 4/1/2026 9:48 AM, Simon wrote:
> Hi Midgy,
> 
> 在 2026/3/31 15:50, Midgy BALON 写道:
>> commit 2a7e6400f72b ("iommu: rockchip: Allocate tables from all
>> available memory for IOMMU v2") removed GFP_DMA32 from
>> iommu_data_ops_v2, reasoning that RK356x and RK3588 IOMMU v2 hardware
>> supports up to 40-bit physical addresses for page tables.  However, the
>> RK3568 IOMMU page-table walker uses a 32-bit AXI bus: it cannot access
>> physical addresses above 4 GB regardless of the address encoding range.
>>
>> On boards with more than 4 GB of RAM (e.g. 8 GB LPDDR4X), removing
>> GFP_DMA32 causes two distinct failure modes:
>>
>> 1. Direct allocation above 4 GB: iommu_alloc_pages_sz() may return
>>     memory above 0x100000000.  The hardware page-table walker issues a
>>     bus error trying to dereference those addresses, causing an IOMMU
>>     fault on the first DMA transaction.
>
> Which IP block is hitting this? We'd like to take a look on our end.

I have seen reports that the NPU MMU on RK3568/RK3566 is having some
issue using DTE/PTE with >32-bit addresses, maybe it uses a different
MMU hw revision or has some hw errata?

From my own testing at least the VOP2 MMU on RK3568 (and RK3588) was
able to handle 40-bit addressable DTE/PTE, hence the original commit
2a7e6400f72b ("iommu: rockchip: Allocate tables from all available
memory for IOMMU v2").

As also mentioned in my reply at [1], maybe the NPU MMU has some hw
limitation or errata and may need to use a different compatible.

[1] https://lore.kernel.org/r/3cd63b3d-1c5e-4a11-856e-c4aeb5d97d55@kwiboo.se/

Regards,
Jonas

>
>> 2. SWIOTLB bounce-buffer poisoning: without GFP_DMA32, page tables land
>>     above the SWIOTLB window.  dma_map_single() with DMA_BIT_MASK(32)
>>     then bounces them into a buffer below 4 GB.  rk_dte_get_page_table()
>>     returns phys_to_virt() of the bounce buffer address; PTEs are written
>>     there; the next dma_sync_single_for_device(DMA_TO_DEVICE) copies the
>>     original (zero) data back over the bounce buffer, silently erasing the
>>     freshly written PTEs.  The IOMMU faults because every PTE reads as zero.
>
> This probably need a separate patch. One way to fix it would be to track the
> original L2 page table base addresses in struct rk_iommu_domain,
> then have rk_dte_get_page_table() return the tracked address instead of
> deriving it from the DTE.
>
>> Restore GFP_DMA32 (and DMA_BIT_MASK(32)) for iommu_data_ops_v2, which
>> currently only serves "rockchip,rk3568-iommu" in mainline.
>>
>> Tested on Radxa ROCK 3B (RK3568, 8 GB LPDDR4X):
>>    - MobileNetV1 via RKNN: 5.8 ms/inference (IOMMU mode)
>>    - YOLOv5s 640x640 via RKNN: ~57 ms/inference (IOMMU mode)
>>    - No IOMMU faults, correct inference results
>>
>> Fixes: 2a7e6400f72b ("iommu: rockchip: Allocate tables from all available memory for IOMMU v2")
>> Cc: stable@vger.kernel.org
>> Cc: Jonas Karlman <jonas@kwiboo.se>
>> Signed-off-by: Midgy BALON <midgy971@gmail.com>
>> ---
>>   drivers/iommu/rockchip-iommu.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
>> index 85f3667e797..8b45db29471 100644
>> --- a/drivers/iommu/rockchip-iommu.c
>> +++ b/drivers/iommu/rockchip-iommu.c
>> @@ -1358,8 +1358,8 @@ static struct rk_iommu_ops iommu_data_ops_v2 = {
>>   	.pt_address = &rk_dte_pt_address_v2,
>>   	.mk_dtentries = &rk_mk_dte_v2,
>>   	.mk_ptentries = &rk_mk_pte_v2,
>> -	.dma_bit_mask = DMA_BIT_MASK(40),
>> -	.gfp_flags = 0,
>> +	.dma_bit_mask = DMA_BIT_MASK(32),
>> +	.gfp_flags = GFP_DMA32,
>>   };
>>   
>>   static const struct of_device_id rk_iommu_dt_ids[] = {


