Return-Path: <stable+bounces-225525-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFmpDOLjt2mzWwEAu9opvQ
	(envelope-from <stable+bounces-225525-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 12:05:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 878C6298755
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 12:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15C293064E90
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 10:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D840D38F63E;
	Mon, 16 Mar 2026 10:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HLysQ27/"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2BE1A9FB7
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 10:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773658758; cv=none; b=s8yweK7ytcV8C+MgV6hnxSc1i5zyIAzRMdbFz843OTxdTGR9nfiR1Uc1BMsOlaC5qYHZDac+YB/nsMB15DLP+M4weKuKxZ0rfQ3ZaF71je7hEAeZDRGl0Vzd1tjGGDtYk60BggIlrEkFZCAsj93uwsmYMCuzhITMWy29eTbpnXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773658758; c=relaxed/simple;
	bh=r3iIREqSBSgpbKpQfWaTaivzADhH/g7ZwVqQFICbavU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YY6FTKZbbA9T4+eo4Cxqsg3nn7wOeitogUvXuVF2AbFYpOykZ5pT871DAe32tAQdizkCNbltwnOkUFN0UhHIienAyP9+rY/zlz66izom9jfk9Ay1SruCaVSTWx6VJtPFEzWyVvnRgyHzSAVr/QkBdrujqYfjSwZ+knNQI1ZWjOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HLysQ27/; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773658756; x=1805194756;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=r3iIREqSBSgpbKpQfWaTaivzADhH/g7ZwVqQFICbavU=;
  b=HLysQ27/8QWKAzLW/2TEN+UchAPyDoNttZVIAdSNZtM88r8bTMVc0VkZ
   8rNXycK5oiAn7zx6c7Wm2ImQWG+3I9mnDuShAFJ8Yxd/fBYK/HwIsjO0X
   Gx26mfVJZmabB6URmRfl+ccCw5yTDnyTEDjn8rPIeotbxKKayGg1MhOoC
   HoY+w8telvoEDxGNCRfybPRPo7l11yGyJ8ZtQO3JOU52Ff/ReelBP7Wpu
   xuCB1arkN3QmOfktZGfx2DurV5O1xPavyefLzypOOkV5LHQ5LPs6+h3sL
   pn67G3/Xqg77N827cq/K4v6Tq5Zhsb56+9zNeMq7SoSGl1N94Zt46lYOv
   w==;
X-CSE-ConnectionGUID: SUKUvJi2T7ie8ZQYH3wqmw==
X-CSE-MsgGUID: BLDf20Y7QauPCX1k/w6N+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="85751998"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="85751998"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 03:59:15 -0700
X-CSE-ConnectionGUID: xXejHu9nRbyqIvFv9F9IiQ==
X-CSE-MsgGUID: spqpExqZTAK0RvDj9Gm8JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="252396932"
Received: from amilburn-desk.amilburn-desk (HELO [10.245.244.246]) ([10.245.244.246])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 03:59:12 -0700
Message-ID: <4b32f17a-811e-453e-ac0a-e5fae77fea6a@intel.com>
Date: Mon, 16 Mar 2026 10:59:10 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] drm/xe/uapi: Reject coh_none PAT index for CPU
 cached memory in madvise
To: Jia Yao <jia.yao@intel.com>, intel-xe@lists.freedesktop.org
Cc: stable@vger.kernel.org, Shuicheng Lin <shuicheng.lin@intel.com>,
 Mathew Alwin <alwin.mathew@intel.com>,
 Michal Mrozek <michal.mrozek@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Jos=C3=A9_Roberto_de_Souza?= <jose.souza@intel.com>
References: <20260129000147.339361-1-jia.yao@intel.com>
 <20260316072257.255372-1-jia.yao@intel.com>
 <20260316072257.255372-2-jia.yao@intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260316072257.255372-2-jia.yao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225525-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.auld@intel.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 878C6298755
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 16/03/2026 07:22, Jia Yao wrote:
> Add validation in xe_vm_madvise_ioctl() to reject PAT indices with
> XE_COH_NONE coherency mode when applied to CPU cached memory.
> 
> Using coh_none with CPU cached buffers is a security issue. When the
> kernel clears pages before reallocation, the clear operation stays in
> CPU cache (dirty). GPU with coh_none can bypass CPU caches and read
> stale sensitive data directly from DRAM, potentially leaking data from
> previously freed pages of other processes.
> 
> This aligns with the existing validation in vm_bind path
> (xe_vm_bind_ioctl_validate_bo).
> 
> v2(Matthew brost)
> - Add fixes
> - Move one debug print to better place
> 
> v3(Matthew Auld)
> - Should be drm/xe/uapi
> - More Cc
> 
> v4(Shuicheng Lin)
> - Fix kmem leak issues by the way
> 
> v5
> - Remove kmem leak because it has been merged by other patch
> 
> Fixes: ada7486c5668 ("drm/xe: Implement madvise ioctl for xe")
> Cc: stable@vger.kernel.org # v6.18
> Cc: Shuicheng Lin <shuicheng.lin@intel.com>
> Cc: Mathew Alwin <alwin.mathew@intel.com>
> Cc: Michal Mrozek <michal.mrozek@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Signed-off-by: Jia Yao <jia.yao@intel.com>
> Acked-by: Michal Mrozek <michal.mrozek@intel.com>
> Acked-by: José Roberto de Souza <jose.souza@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_vm_madvise.c | 46 +++++++++++++++++++++++++++++-
>   1 file changed, 45 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_vm_madvise.c b/drivers/gpu/drm/xe/xe_vm_madvise.c
> index 869db304d96d..5d0acaad924c 100644
> --- a/drivers/gpu/drm/xe/xe_vm_madvise.c
> +++ b/drivers/gpu/drm/xe/xe_vm_madvise.c
> @@ -365,6 +365,43 @@ static void xe_madvise_details_fini(struct xe_madvise_details *details)
>   	drm_pagemap_put(details->dpagemap);
>   }
>   
> +static bool check_pat_args_are_sane(struct xe_device *xe,
> +				    struct xe_vmas_in_madvise_range *madvise_range,
> +				    u16 pat_index)
> +{
> +	u16 coh_mode = xe_pat_index_get_coh_mode(xe, pat_index);
> +	int i;
> +
> +	/*
> +	 * Using coh_none with CPU cached buffers is not allowed.
> +	 * Otherwise CPU page clearing can be bypassed, which is a
> +	 * security issue. GPU can directly access system memory and
> +	 * bypass CPU caches, potentially reading stale sensitive data
> +	 * from previously freed pages.
> +	 */
> +	if (coh_mode != XE_COH_NONE)
> +		return true;
> +
> +	for (i = 0; i < madvise_range->num_vmas; i++) {
> +		struct xe_vma *vma = madvise_range->vmas[i];
> +		struct xe_bo *bo = xe_vma_bo(vma);
> +
> +		if (bo) {
> +			/* BO with WB caching + COH_NONE is not allowed */
> +			if (XE_IOCTL_DBG(xe, bo->cpu_caching == DRM_XE_GEM_CPU_CACHING_WB))
> +				return false;
> +			/* Imported dma-buf without caching info, assume cached */
> +			if (XE_IOCTL_DBG(xe, !bo->cpu_caching))
> +				return false;
> +		} else if (XE_IOCTL_DBG(xe, xe_vma_is_cpu_addr_mirror(vma) ||
> +					    xe_vma_is_userptr(vma)))
> +			/* System memory (userptr/SVM) is always CPU cached */
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
>   static bool check_bo_args_are_sane(struct xe_vm *vm, struct xe_vma **vmas,
>   				   int num_vmas, u32 atomic_val)
>   {
> @@ -455,6 +492,14 @@ int xe_vm_madvise_ioctl(struct drm_device *dev, void *data, struct drm_file *fil
>   	if (err || !madvise_range.num_vmas)
>   		goto madv_fini;
>   
> +	if (args->type == DRM_XE_MEM_RANGE_ATTR_PAT) {
> +		if (!check_pat_args_are_sane(xe, &madvise_range,
> +					     args->pat_index.val)) {
> +			err = -EINVAL;
> +			goto free_vmas;
> +		}
> +	}
> +
>   	if (madvise_range.has_bo_vmas) {
>   		if (args->type == DRM_XE_MEM_RANGE_ATTR_ATOMIC) {
>   			if (!check_bo_args_are_sane(vm, madvise_range.vmas,
> @@ -500,7 +545,6 @@ int xe_vm_madvise_ioctl(struct drm_device *dev, void *data, struct drm_file *fil
>   		drm_exec_fini(&exec);
>   free_vmas:
>   	kfree(madvise_range.vmas);
> -	madvise_range.vmas = NULL;

Do we really need this change?

Otherwise,
Reviewed-by: Matthew Auld <matthew.auld@intel.com>

>   madv_fini:
>   	xe_madvise_details_fini(&details);
>   unlock_vm:


