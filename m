Return-Path: <stable+bounces-238112-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKLwLY+B32mcUQAAu9opvQ
	(envelope-from <stable+bounces-238112-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 14:16:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2545A404298
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 14:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 173D23023E11
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 12:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DA554654;
	Wed, 15 Apr 2026 12:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QbRy8jZ5"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9073C1E515
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 12:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776255308; cv=none; b=Ysv5HkcJPbyLYPYbhEnzoS8sYii/DwPQ/n/ZJJPFCHCyXGTMjxeaxDRBt1AWdVritKC2CcRO+ZG/boVWCZ9jStFqz648VACBPfQqxjQMmu57Ng1hbezQjfPi3wQA5FCk89Udr+zTMack5nP0jP7kzzDCWFfIhanOaF0k2RGAgtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776255308; c=relaxed/simple;
	bh=XVwY6PmwvfRm+MrqjaTcSzgwzTO6ZRD5DBuaCXCbY0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aQHjGAJxxWDujSFLBAGTv9SeFWl6TiAgpSsBgdI+PlghB0hjTSI3Y7f0pVBXAesTFhqRJ2ZnaHaOM/WN3dLE9A4feNR4kybdggcUiH/ywIpa9n+Q9V/LN6Hj1Ymk5KvyFyO9iKvfD2XWAUslOOFb6MEdKoBdb0CQnX9/ivhvtWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QbRy8jZ5; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776255307; x=1807791307;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XVwY6PmwvfRm+MrqjaTcSzgwzTO6ZRD5DBuaCXCbY0U=;
  b=QbRy8jZ5N0IsQEep54HEB53sA3NsxwT2R3o7BI584WeS83+0jMa/elbj
   Ac9R6ql0S2zB5hIMdh6b/mBdt6wRc/GAnvNqDIeQOLA/cL6Q9MFxY3Zg9
   gBtQMCvhZz98SG1/arI0u+GsclabDrtGrOhJxN9/jArecgy3s9WyC3OKm
   Zk19PRKqCvzUQ9WaqJLL6vj9dSHli27evBlVpHehXq/A8ook0bfUV+DaX
   NSDvvAB/G5lvKNB7AGSMjCXJZDes4wJHTdxbWaT4ewShP1NDC/K8/Xchy
   QUJWgBmTaEawasGiY7d951sTdKES3Ykjt/5GavTZyoSwycAEXpUephNZ0
   g==;
X-CSE-ConnectionGUID: Fe2N/BjCSmeN2XFBmbc4fg==
X-CSE-MsgGUID: uWXHEq8sSuuSLFvHDlzyXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="87853501"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="87853501"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 05:15:07 -0700
X-CSE-ConnectionGUID: vGuuNXZYQOW3P1xqpETZFA==
X-CSE-MsgGUID: GebHZkpnRJeQ8EBJw7nr6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="223902153"
Received: from rvuia-mobl.ger.corp.intel.com (HELO [10.245.244.112]) ([10.245.244.112])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 05:15:05 -0700
Message-ID: <c9962533-d9a4-40bb-b42a-7e7855c271d0@intel.com>
Date: Wed, 15 Apr 2026 13:15:03 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] drm/xe: Reject coh_none PAT index for
 CPU_ADDR_MIRROR
To: Jia Yao <jia.yao@intel.com>, intel-xe@lists.freedesktop.org
Cc: stable@vger.kernel.org, Shuicheng Lin <shuicheng.lin@intel.com>,
 Mathew Alwin <alwin.mathew@intel.com>,
 Michal Mrozek <michal.mrozek@intel.com>,
 Matthew Brost <matthew.brost@intel.com>
References: <20260129000147.339361-1-jia.yao@intel.com>
 <20260415061951.427699-1-jia.yao@intel.com>
 <20260415061951.427699-3-jia.yao@intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260415061951.427699-3-jia.yao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238112-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.auld@intel.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2545A404298
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 15/04/2026 07:19, Jia Yao wrote:
> Add validation in xe_vm_bind_ioctl() to reject PAT indices
> with XE_COH_NONE coherency mode when used with
> DRM_XE_VM_BIND_FLAG_CPU_ADDR_MIRROR.
> 
> CPU address mirror mappings use system memory that is CPU
> cached, which makes them incompatible with COH_NONE PAT
> indices. Allowing COH_NONE with CPU cached buffers is a
> security risk, as the GPU may bypass CPU caches and read
> stale sensitive data from DRAM.
> 
> Although CPU_ADDR_MIRROR does not create an immediate
> mapping, the backing system memory is still CPU cached.
> Apply the same PAT coherency restrictions as
> DRM_XE_VM_BIND_OP_MAP_USERPTR.
> 
> v2:
> - Correct fix tag
> 
> v6:
> - No change
> 
> v7:
> - Correct fix tag
> 
> v8:
> - Rebase
> 
> Fixes: b43e864af0d4 ("drm/xe/uapi: Add DRM_XE_VM_BIND_FLAG_CPU_ADDR_MIRROR")
> Cc: stable@vger.kernel.org # v6.18
> Cc: Shuicheng Lin <shuicheng.lin@intel.com>
> Cc: Mathew Alwin <alwin.mathew@intel.com>
> Cc: Michal Mrozek <michal.mrozek@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Signed-off-by: Jia Yao <jia.yao@intel.com>
> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_vm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index 2408b547ca3d..619a22fa9abe 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -3657,7 +3657,7 @@ static int vm_bind_ioctl_check_args(struct xe_device *xe, struct xe_vm *vm,
>   		    XE_IOCTL_DBG(xe, obj &&
>   				 op == DRM_XE_VM_BIND_OP_MAP_USERPTR) ||
>   		    XE_IOCTL_DBG(xe, coh_mode == XE_COH_NONE &&
> -				 op == DRM_XE_VM_BIND_OP_MAP_USERPTR) ||
> +				 (op == DRM_XE_VM_BIND_OP_MAP_USERPTR || is_cpu_addr_mirror)) ||

Chatted to Michal, and it looks like on dgpu an incoherent index is 
being used with cpu_addr_mirror, so this will cause regressions. I think 
for both patches we need to limit this change to igpu, where coherent 
index is fortunately already being used.

>   		    XE_IOCTL_DBG(xe, xe_device_is_l2_flush_optimized(xe) &&
>   				 (op == DRM_XE_VM_BIND_OP_MAP_USERPTR ||
>   				  is_cpu_addr_mirror) &&


