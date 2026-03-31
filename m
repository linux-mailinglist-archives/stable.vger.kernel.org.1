Return-Path: <stable+bounces-232562-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UM9/KVsWzGnfOAYAu9opvQ
	(envelope-from <stable+bounces-232562-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 20:45:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E7437026F
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 20:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26EE53009CC5
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7909B38F657;
	Tue, 31 Mar 2026 18:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="nSow6ru6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646D638B13E
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 18:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774982696; cv=none; b=V4Gk7tiCv7VsYtfEXMvcskBv05a0V8qeJXiOQsgmApwtPqEhpjikiLfXsa8TAXpLPBKrVrn2hzO6lmKLnFLJ4HRFywHLX0PerC3+YH3SFvmXHu6IS/D5IPMhcdSaLolMadGarIHjEoY2br6OBdh+RR1gKNbfdXlLmVeYc5UL54k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774982696; c=relaxed/simple;
	bh=uT3Wywe2Ye+uMM+gXvvOmQMmNSWzvB1Lp4GHwg0ss/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qzgC4bb/2jmkqKS2gwdvWxiBf6nGh29Dt6h5ymNg7RKjXfB5YG9RH3pBxHqd1H937TOVWIGHPia3vK1OQZSjfzHESf20HMSj2kzvEGdlv1s7C2bviE3ThUzURuCtCpSyvqKoWnPFko6Y0N16RQnj7ShT5IZDI0Y0GSCL+TJglqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=nSow6ru6; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1774982689;
 bh=SGfD5RUo85f+4kW7EBlx3yRh1/KFzFoR81S/pihvcqU=;
 b=nSow6ru6o8SsIbeTsK6T0hD+rEJXoKftvZCzGV6NxuzWBYjOBB5O/WyfYZX0WlVPiFZe/vyyz
 HYSGayT7EfYlxalF9ND9xPOAMwL15jJfM7LNvR1Rk37KG/CGP6frqwuMNCNpKwFzLoh+fLM1JOq
 6FBBgIPg0pOuJ9/NxJQYxJZ7k1EGwPHnLWN5t0nKTidhjvA3qj827dcWgjHYrcrm68tQa2YtVQ8
 adCJvUTzYnNnqsHIkdyN76jSHRKJKqciRY7Q/3QPPXvjWzhpX2TksyHkbDTSuMHjla0gMbbgakZ
 NJWqkJ/XEjcpX6IhCAYKD5oKuO/UPf4OnOaWIchRR05w==
X-Forward-Email-ID: 69cc0ecb650cf26cfd1ee59c
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.6.64
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <3cd63b3d-1c5e-4a11-856e-c4aeb5d97d55@kwiboo.se>
Date: Tue, 31 Mar 2026 20:13:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/rockchip: fix page table allocation flags for v2
 IOMMU
To: Midgy BALON <midgy971@gmail.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Simon Xue <xxm@rock-chips.com>,
 iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260331075010.1463-1-midgy971@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260331075010.1463-1-midgy971@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kwiboo.se,quarantine];
	R_DKIM_ALLOW(-0.20)[kwiboo.se:s=fe-e1b5cab7be];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232562-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonas@kwiboo.se,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kwiboo.se:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 15E7437026F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Midgy,

On 3/31/2026 9:50 AM, Midgy BALON wrote:
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
>    memory above 0x100000000.  The hardware page-table walker issues a
>    bus error trying to dereference those addresses, causing an IOMMU
>    fault on the first DMA transaction.
> 
> 2. SWIOTLB bounce-buffer poisoning: without GFP_DMA32, page tables land
>    above the SWIOTLB window.  dma_map_single() with DMA_BIT_MASK(32)
>    then bounces them into a buffer below 4 GB.  rk_dte_get_page_table()
>    returns phys_to_virt() of the bounce buffer address; PTEs are written
>    there; the next dma_sync_single_for_device(DMA_TO_DEVICE) copies the
>    original (zero) data back over the bounce buffer, silently erasing the
>    freshly written PTEs.  The IOMMU faults because every PTE reads as zero.
> 
> Restore GFP_DMA32 (and DMA_BIT_MASK(32)) for iommu_data_ops_v2, which
> currently only serves "rockchip,rk3568-iommu" in mainline.
> 
> Tested on Radxa ROCK 3B (RK3568, 8 GB LPDDR4X):
>   - MobileNetV1 via RKNN: 5.8 ms/inference (IOMMU mode)
>   - YOLOv5s 640x640 via RKNN: ~57 ms/inference (IOMMU mode)
>   - No IOMMU faults, correct inference results
> 
> Fixes: 2a7e6400f72b ("iommu: rockchip: Allocate tables from all available memory for IOMMU v2")
> Cc: stable@vger.kernel.org
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Midgy BALON <midgy971@gmail.com>
> ---
>  drivers/iommu/rockchip-iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 85f3667e797..8b45db29471 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -1358,8 +1358,8 @@ static struct rk_iommu_ops iommu_data_ops_v2 = {
>  	.pt_address = &rk_dte_pt_address_v2,
>  	.mk_dtentries = &rk_mk_dte_v2,
>  	.mk_ptentries = &rk_mk_pte_v2,
> -	.dma_bit_mask = DMA_BIT_MASK(40),
> -	.gfp_flags = 0,
> +	.dma_bit_mask = DMA_BIT_MASK(32),
> +	.gfp_flags = GFP_DMA32,

This change is wrong because this struct describe the RK IOMMU v2 that
is capable of 40-bit addressing, used with e.g. RK3568 VOP2 MMU and MMUs
in other RK35xx SoCs.

What you have discovered is most likely that some IP blocks, e.g. NPU on
RK3568, is not capable of >32-bit addressing, and/or that such IP blocks
are still using IOMMU v1 blocks, or some variant with 32-bit limitation.

However, the RK IOMMU driver is currently not capable of supporting
different IOMMU revisions, if I recall correctly there may have been a
patch trying to address that already on ML.

Have you seen this issue with a variant of the rockit driver that add
support for RK3568 or a variant of the downstream rknpu driver forward
ported to mainline?

If your findings are correct it is likely that the NPU MMU needs to use
a different compatible, since rockchip,rk3568-iommu describe the IOMMUv2
that is capable of 40-bit addressing and is also used by other RK35xx
SoCs.

Regards,
Jonas

>  };
>  
>  static const struct of_device_id rk_iommu_dt_ids[] = {


