Return-Path: <stable+bounces-231354-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SM5qCy2Ay2kKIgYAu9opvQ
	(envelope-from <stable+bounces-231354-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 10:05:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB4C365BC6
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 10:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EA3C430582A6
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 07:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D953DA7DE;
	Tue, 31 Mar 2026 07:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="FFStyb+B"
X-Original-To: stable@vger.kernel.org
Received: from mail-m19731115.qiye.163.com (mail-m19731115.qiye.163.com [220.197.31.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85EB3CCA16;
	Tue, 31 Mar 2026 07:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774943871; cv=none; b=EumeMWR5cpCDZkzKvMh3m7Uzc1BgSIlnelJ7cHXUVmxGpq5aI5m/5Zg74TApu+OfNdLB69RHrOsK5M4WbuLZPCUiCc5F8wjnrkBHfUpyKtWU4QVgDdFil+Bgtsmixa5fSsnz3Vwfp3+dery4z7SMLebM434HgzhiwEemQ3fjUsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774943871; c=relaxed/simple;
	bh=9GRPv5yytGjf3DYRtG28HAttACkCAsdrriMUcnOujPo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IfVmbhcQVxjVFJtXc0ex9KftgQw3jHrFlWDhZ99R99bi8a/jkaHTeo+kLKrnInI6SNWwQBXZHOdcCy9zlaM4f4dUSZkLsEdoWz2fDeTbsxjCgb1G8qzo5evY+xdOdkFJyfHhmNht9ubpwXIYAB5SM7y/HSp/tYtbj88879cDST4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=FFStyb+B; arc=none smtp.client-ip=220.197.31.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.17] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 38f5d4f4e;
	Tue, 31 Mar 2026 15:57:36 +0800 (GMT+08:00)
Message-ID: <66305bf3-338b-ee5e-c9ad-3ff5639f5002@rock-chips.com>
Date: Tue, 31 Mar 2026 15:57:34 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Cc: shawn.lin@rock-chips.com, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, heiko@sntech.de, jonas@kwiboo.se,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, iommu@lists.linux.dev,
 Simon Xue <xxm@rock-chips.com>
Subject: Re: [PATCH] iommu/rockchip: fix page table allocation flags for v2
 IOMMU
To: Midgy BALON <midgy971@gmail.com>
References: <20260331075010.1463-1-midgy971@gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20260331075010.1463-1-midgy971@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d42e5e66709cckunm1531d01ef14156
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUodGlZLQx5NTE9DTR1CHR1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=FFStyb+Bi2FuVK7Y0fE88p9wVWjK6i3ztZrv5fl141gBwzGBsSytLS6qGTslX6HwkQvRZs026r2/PvlvrNc12AwPJ8TtdRK20T/pGkYV4+SGmEucUkOkFep1ZUq91aYz4zuFa/P3AK54mO/WVW00SiHrOYchao+O/TNUhLeXIp0=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=7DgGO+0Bl7QC0qCoRe3NT49Uq/dkgfuo3K9jkSPj7GE=;
	h=date:mime-version:subject:message-id:from;
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rock-chips.com,none];
	R_DKIM_ALLOW(-0.20)[rock-chips.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231354-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shawn.lin@rock-chips.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[rock-chips.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kwiboo.se:email]
X-Rspamd-Queue-Id: CBB4C365BC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

+ Simon

在 2026/03/31 星期二 15:50, Midgy BALON 写道:
> commit 2a7e6400f72b ("iommu: rockchip: Allocate tables from all
> available memory for IOMMU v2") removed GFP_DMA32 from
> iommu_data_ops_v2, reasoning that RK356x and RK3588 IOMMU v2 hardware
> supports up to 40-bit physical addresses for page tables.  However, the
> RK3568 IOMMU page-table walker uses a 32-bit AXI bus: it cannot access
> physical addresses above 4 GB regardless of the address encoding range.
> 
> On boards with more than 4 GB of RAM (e.g. 8 GB LPDDR4X), removing
> GFP_DMA32 causes two distinct failure modes:
> 
> 1. Direct allocation above 4 GB: iommu_alloc_pages_sz() may return
>     memory above 0x100000000.  The hardware page-table walker issues a
>     bus error trying to dereference those addresses, causing an IOMMU
>     fault on the first DMA transaction.
> 
> 2. SWIOTLB bounce-buffer poisoning: without GFP_DMA32, page tables land
>     above the SWIOTLB window.  dma_map_single() with DMA_BIT_MASK(32)
>     then bounces them into a buffer below 4 GB.  rk_dte_get_page_table()
>     returns phys_to_virt() of the bounce buffer address; PTEs are written
>     there; the next dma_sync_single_for_device(DMA_TO_DEVICE) copies the
>     original (zero) data back over the bounce buffer, silently erasing the
>     freshly written PTEs.  The IOMMU faults because every PTE reads as zero.
> 
> Restore GFP_DMA32 (and DMA_BIT_MASK(32)) for iommu_data_ops_v2, which
> currently only serves "rockchip,rk3568-iommu" in mainline.
> 
> Tested on Radxa ROCK 3B (RK3568, 8 GB LPDDR4X):
>    - MobileNetV1 via RKNN: 5.8 ms/inference (IOMMU mode)
>    - YOLOv5s 640x640 via RKNN: ~57 ms/inference (IOMMU mode)
>    - No IOMMU faults, correct inference results
> 
> Fixes: 2a7e6400f72b ("iommu: rockchip: Allocate tables from all available memory for IOMMU v2")
> Cc: stable@vger.kernel.org
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Midgy BALON <midgy971@gmail.com>
> ---
>   drivers/iommu/rockchip-iommu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 85f3667e797..8b45db29471 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -1358,8 +1358,8 @@ static struct rk_iommu_ops iommu_data_ops_v2 = {
>   	.pt_address = &rk_dte_pt_address_v2,
>   	.mk_dtentries = &rk_mk_dte_v2,
>   	.mk_ptentries = &rk_mk_pte_v2,
> -	.dma_bit_mask = DMA_BIT_MASK(40),
> -	.gfp_flags = 0,
> +	.dma_bit_mask = DMA_BIT_MASK(32),
> +	.gfp_flags = GFP_DMA32,
>   };
>   
>   static const struct of_device_id rk_iommu_dt_ids[] = {

