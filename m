Return-Path: <stable+bounces-253620-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EbJOIZBD2qcIQYAu9opvQ
	(envelope-from <stable+bounces-253620-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 19:31:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B08F5AA4A3
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 19:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96A173131634
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 17:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A777C3812DE;
	Thu, 21 May 2026 17:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SViPrI0D"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1795139A4B3
	for <stable@vger.kernel.org>; Thu, 21 May 2026 17:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779383237; cv=none; b=C8ZIrvzsu9gnjkTBqcCgu03W1u7RgwMGKNNjorBy8jmhIfMoHJ7MtzWM4fDAd2iYmc17Xj85oZbUc0OFMps9hSP4dffQPoXG8GO13WoTYg1k+91PVFIGSxSey/XM+lWOQSrvxU9XC9fQizOkrIh61foPzgaCG5D22YkiAgRXpDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779383237; c=relaxed/simple;
	bh=ugbeN2jtHUSTcQ497xSY4KAxjDkxiNhaARCuk08QBEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QRAuJkn6vOPDgBDno5ESc/QTFYbBBT4R5baGufLd5LDyWAlkGZh/dPZ/yCpQ96G9JTD/aihO2J060mu4NYIjN/qBmqB+aCZvgv/+O/EjmsII5lodU6R0I3WCgFXdFncvt0DsUNJ62/p4lpLeimj+X44UDqHvpkBUzvMOm372oRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SViPrI0D; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779383237; x=1810919237;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ugbeN2jtHUSTcQ497xSY4KAxjDkxiNhaARCuk08QBEs=;
  b=SViPrI0D8GqzTlN7aXTrcczhNLBA128vwBifChLRrdAp2wMdmxD3LqLm
   5KnWUge5tIs6cijH75NugY8FFbr5gGB2YEIjkPL76YeVSrhytFc2uFXVR
   W2kn/51nNTuShhBl24mJATYJqFePJrc9hPFLEpgeFRlSPUcuuDHOD15Hv
   mJ4BPLP9x+Opax8wayydQivri+6jcETYbQudwq2J5siTojxnPormOA/xq
   VqEjqYDj4YXIMbrRoFwyya0AXDfi3Bb5C2CtxVlz4/JLmwBZPBmUIBMik
   dVaieRt6gDqZSU2qRxxf12NdoFPU29Kp9u5M3vJnpBtckOQfLQXmlQc59
   A==;
X-CSE-ConnectionGUID: K+GikGYmSTmSw2WFQ4j2ag==
X-CSE-MsgGUID: UbQqb0E0TmOe0SFHfkVebA==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="80363602"
X-IronPort-AV: E=Sophos;i="6.24,160,1774335600"; 
   d="scan'208";a="80363602"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 10:07:16 -0700
X-CSE-ConnectionGUID: xAqh50h4QeWOIBV8DqqUew==
X-CSE-MsgGUID: 1Xz14Tt4SG6KA8vHCv3sIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,160,1774335600"; 
   d="scan'208";a="239561269"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO [10.245.244.79]) ([10.245.244.79])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 10:07:14 -0700
Message-ID: <2ffc43e3-560e-406a-9bb6-5dde24b1f897@intel.com>
Date: Thu, 21 May 2026 18:07:12 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe: Use PDE mask for 2M page reclaim entries
To: Brian Nguyen <brian3.nguyen@intel.com>, intel-xe@lists.freedesktop.org
Cc: stable@vger.kernel.org, Zongyao Bai <zongyao.bai@intel.com>
References: <20260520234946.1055572-2-brian3.nguyen@intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260520234946.1055572-2-brian3.nguyen@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253620-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.auld@intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4B08F5AA4A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 21/05/2026 00:49, Brian Nguyen wrote:
> 2M pages use PDE encoding where the physical address occupies bits [51:21],
> but generate_reclaim_entry() uses XE_PTE_ADDR_MASK (bits [51:12]) for all
> leaf entries. Add XE_PDE_ADDR_MASK and select the correct mask based on
> whether the entry is a 2M PDE.

Are you not also missing the PDE 64K handling? AFACT there is only PS64? 
Does it not incorrectly treat it as 4K? With PDE 64K the pt is_compact, 
IIRC so you have like 32 entries for the entire thing, which each entry 
being 64K. So I think here you are only reclaming 4K from each entry? I 
might have missed something though.

> 
> Fixes: 83b914f972bb ("drm/xe: Fix page reclaim entry handling for large pages")
> Cc: stable@vger.kernel.org
> Suggested-by: Zongyao Bai <zongyao.bai@intel.com>
> Signed-off-by: Brian Nguyen <brian3.nguyen@intel.com>
> ---
>   drivers/gpu/drm/xe/regs/xe_gtt_defs.h | 1 +
>   drivers/gpu/drm/xe/xe_pt.c            | 8 ++++++--
>   2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/regs/xe_gtt_defs.h b/drivers/gpu/drm/xe/regs/xe_gtt_defs.h
> index 4d83461e538b..22a6c197ed96 100644
> --- a/drivers/gpu/drm/xe/regs/xe_gtt_defs.h
> +++ b/drivers/gpu/drm/xe/regs/xe_gtt_defs.h
> @@ -10,6 +10,7 @@
>   #define XELPG_GGTT_PTE_PAT1	BIT_ULL(53)
>   
>   #define XE_PTE_ADDR_MASK	GENMASK_ULL(51, 12)
> +#define XE_PDE_ADDR_MASK	GENMASK_ULL(51, 21)
>   #define GGTT_PTE_VFID		GENMASK_ULL(11, 2)
>   
>   #define GUC_GGTT_TOP		0xFEE00000
> diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
> index 2669ff5ee747..ae5ed0370d72 100644
> --- a/drivers/gpu/drm/xe/xe_pt.c
> +++ b/drivers/gpu/drm/xe/xe_pt.c
> @@ -1615,7 +1615,11 @@ static int generate_reclaim_entry(struct xe_tile *tile,
>   {
>   	struct xe_gt *gt = tile->primary_gt;
>   	struct xe_guc_page_reclaim_entry *reclaim_entries = prl->entries;
> -	u64 phys_addr = pte & XE_PTE_ADDR_MASK;
> +	bool is_2m = xe_child->level == 1 && (pte & XE_PDE_PS_2M);
> +	/* 2M pages are encoded as PDEs, other reclaimable pages use PTE encoding */
> +	u64 addr_mask = is_2m ? XE_PDE_ADDR_MASK : XE_PTE_ADDR_MASK;
> +	u64 phys_addr = pte & addr_mask;
> +	/* Page address is relative to 4K page regardless of entry level */
>   	u64 phys_page = phys_addr >> XE_PTE_SHIFT;
>   	int num_entries = prl->num_entries;
>   	u32 reclamation_size;
> @@ -1641,7 +1645,7 @@ static int generate_reclaim_entry(struct xe_tile *tile,
>   		xe_gt_stats_incr(gt, XE_GT_STATS_ID_PRL_64K_ENTRY_COUNT, 1);
>   		reclamation_size = COMPUTE_RECLAIM_ADDRESS_MASK(SZ_64K); /* reclamation_size = 4 */
>   		xe_tile_assert(tile, phys_addr % SZ_64K == 0);
> -	} else if (xe_child->level == 1 && pte & XE_PDE_PS_2M) {
> +	} else if (is_2m) {
>   		xe_gt_stats_incr(gt, XE_GT_STATS_ID_PRL_2M_ENTRY_COUNT, 1);
>   		reclamation_size = COMPUTE_RECLAIM_ADDRESS_MASK(SZ_2M);  /* reclamation_size = 9 */
>   		xe_tile_assert(tile, phys_addr % SZ_2M == 0);


