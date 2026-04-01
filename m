Return-Path: <stable+bounces-232752-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IK/wOpf0zGl9YQYAu9opvQ
	(envelope-from <stable+bounces-232752-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 12:33:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CA137891A
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 12:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F2B7930C174E
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 10:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7946B3CBE72;
	Wed,  1 Apr 2026 10:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="kzDcT7Rn"
X-Original-To: stable@vger.kernel.org
Received: from mail-m49227.qiye.163.com (mail-m49227.qiye.163.com [45.254.49.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF8E364036;
	Wed,  1 Apr 2026 10:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775039299; cv=none; b=amVmASafIrs0ErGiEWo5kMg/fYC7EcnhLokD43ZM5jsHqIES7yWqC/w42rD9aNkL5bQUz5/tEoF6NSewemU2N65QaIFjBzFNWQvVIsfCm62lIP1ab58M3sKs2eSprwnBTu8p3GCWeWWO2zv/6tl62sEAkJQaSr0D9UZLIQnmDS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775039299; c=relaxed/simple;
	bh=ToXdSAiG2ukRlE8CMGRDUOn0v/a/0i23KHe9Ndyh16o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pGcH7qua6FtIM1TGwl5byO8xp5OHu/2J99FdPDvBa2iQcQf7jAzE0Lda5Gd6RQt8rxPHmebko7o6qsjtyY+/cJTbTQbVEbXRPK5Hvksq4Zohjbnrx0DApIYQk+dmg+xY7lSXJBTbGSpxTwnLxeblrffgwCqYpwFz3cAKIMkBURk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=kzDcT7Rn; arc=none smtp.client-ip=45.254.49.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [192.168.31.31] (gy-adaptive-ssl-proxy-3-entmail-virt135.gy.ntes [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 39264eeb0;
	Wed, 1 Apr 2026 18:22:55 +0800 (GMT+08:00)
Message-ID: <89ed223d-1a2c-447d-9f21-76969e668855@rock-chips.com>
Date: Wed, 1 Apr 2026 18:22:55 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/rockchip: fix page table allocation flags for v2
 IOMMU
To: Jonas Karlman <jonas@kwiboo.se>, Midgy BALON <midgy971@gmail.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260331075010.1463-1-midgy971@gmail.com>
 <0f285782-b12a-4abd-bca7-b6c549bed59f@rock-chips.com>
 <e622cc9e-8fb0-454a-b88e-dc13cf2ff507@kwiboo.se>
From: Simon Xue <xxm@rock-chips.com>
In-Reply-To: <e622cc9e-8fb0-454a-b88e-dc13cf2ff507@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d48914e3b03ackunm4823f0772adc63b
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhpIS1ZJH0NOHUpPQh5CTE1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUJCSU5LVU
	pLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=kzDcT7RnWwCk3Y4o8m+2cHyGHq1Rr0VD9cWbOCUL21H0mBhESMrWBYP1wKZIoIpdD5uMzURuDWWH3P3UA4u2BccWXVWun59thPVe+xElZDcfmpvQi/JQPDpD5V7wT5lFXB6gb8IvjXGLixl+VFSAspHMBeDpn2ymh+TtVaZt/ak=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=NXQT496PYS36KJp6vCAGj5npGg3wNXTk4VoH64MRv4g=;
	h=date:mime-version:subject:message-id:from;
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rock-chips.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[rock-chips.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-232752-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kwiboo.se,gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[rock-chips.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xxm@rock-chips.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.955];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,rock-chips.com:dkim,rock-chips.com:mid]
X-Rspamd-Queue-Id: D4CA137891A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jonas,

在 2026/4/1 16:41, Jonas Karlman 写道:
> Hi Simon,
>
> On 4/1/2026 9:48 AM, Simon wrote:
>> Hi Midgy,
>>
>> 在 2026/3/31 15:50, Midgy BALON 写道:
>>> commit 2a7e6400f72b ("iommu: rockchip: Allocate tables from all
>>> available memory for IOMMU v2") removed GFP_DMA32 from
>>> iommu_data_ops_v2, reasoning that RK356x and RK3588 IOMMU v2 hardware
>>> supports up to 40-bit physical addresses for page tables.  However, the
>>> RK3568 IOMMU page-table walker uses a 32-bit AXI bus: it cannot access
>>> physical addresses above 4 GB regardless of the address encoding range.
>>>
>>> On boards with more than 4 GB of RAM (e.g. 8 GB LPDDR4X), removing
>>> GFP_DMA32 causes two distinct failure modes:
>>>
>>> 1. Direct allocation above 4 GB: iommu_alloc_pages_sz() may return
>>>      memory above 0x100000000.  The hardware page-table walker issues a
>>>      bus error trying to dereference those addresses, causing an IOMMU
>>>      fault on the first DMA transaction.
>> Which IP block is hitting this? We'd like to take a look on our end.
> I have seen reports that the NPU MMU on RK3568/RK3566 is having some
> issue using DTE/PTE with >32-bit addresses, maybe it uses a different
> MMU hw revision or has some hw errata?
>
>  From my own testing at least the VOP2 MMU on RK3568 (and RK3588) was
> able to handle 40-bit addressable DTE/PTE, hence the original commit
> 2a7e6400f72b ("iommu: rockchip: Allocate tables from all available
> memory for IOMMU v2").
>
> As also mentioned in my reply at [1], maybe the NPU MMU has some hw
> limitation or errata and may need to use a different compatible.

Yes,  We are checking internally whether different IOMMU versions 
integrated.

I will share what we find once we have results.

> [1] https://lore.kernel.org/r/3cd63b3d-1c5e-4a11-856e-c4aeb5d97d55@kwiboo.se/
>
> Regards,
> Jonas
>
>>> 2. SWIOTLB bounce-buffer poisoning: without GFP_DMA32, page tables land
>>>      above the SWIOTLB window.  dma_map_single() with DMA_BIT_MASK(32)
>>>      then bounces them into a buffer below 4 GB.  rk_dte_get_page_table()
>>>      returns phys_to_virt() of the bounce buffer address; PTEs are written
>>>      there; the next dma_sync_single_for_device(DMA_TO_DEVICE) copies the
>>>      original (zero) data back over the bounce buffer, silently erasing the
>>>      freshly written PTEs.  The IOMMU faults because every PTE reads as zero.
>> This probably need a separate patch. One way to fix it would be to track the
>> original L2 page table base addresses in struct rk_iommu_domain,
>> then have rk_dte_get_page_table() return the tracked address instead of
>> deriving it from the DTE.
>>
>>> Restore GFP_DMA32 (and DMA_BIT_MASK(32)) for iommu_data_ops_v2, which
>>> currently only serves "rockchip,rk3568-iommu" in mainline.
>>>
>>> Tested on Radxa ROCK 3B (RK3568, 8 GB LPDDR4X):
>>>     - MobileNetV1 via RKNN: 5.8 ms/inference (IOMMU mode)
>>>     - YOLOv5s 640x640 via RKNN: ~57 ms/inference (IOMMU mode)
>>>     - No IOMMU faults, correct inference results
>>>
>>> Fixes: 2a7e6400f72b ("iommu: rockchip: Allocate tables from all available memory for IOMMU v2")
>>> Cc: stable@vger.kernel.org
>>> Cc: Jonas Karlman <jonas@kwiboo.se>
>>> Signed-off-by: Midgy BALON <midgy971@gmail.com>
>>> ---
>>>    drivers/iommu/rockchip-iommu.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
>>> index 85f3667e797..8b45db29471 100644
>>> --- a/drivers/iommu/rockchip-iommu.c
>>> +++ b/drivers/iommu/rockchip-iommu.c
>>> @@ -1358,8 +1358,8 @@ static struct rk_iommu_ops iommu_data_ops_v2 = {
>>>    	.pt_address = &rk_dte_pt_address_v2,
>>>    	.mk_dtentries = &rk_mk_dte_v2,
>>>    	.mk_ptentries = &rk_mk_pte_v2,
>>> -	.dma_bit_mask = DMA_BIT_MASK(40),
>>> -	.gfp_flags = 0,
>>> +	.dma_bit_mask = DMA_BIT_MASK(32),
>>> +	.gfp_flags = GFP_DMA32,
>>>    };
>>>    
>>>    static const struct of_device_id rk_iommu_dt_ids[] = {
>

