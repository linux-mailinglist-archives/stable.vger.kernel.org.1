Return-Path: <stable+bounces-238279-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CA9PDb+n4GlZkgAAu9opvQ
	(envelope-from <stable+bounces-238279-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 11:11:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB4240C067
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 11:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0AAAB3009828
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 09:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A459339098D;
	Thu, 16 Apr 2026 09:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fX/fSD8n"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9C438BF87
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 09:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776330676; cv=none; b=LJvcRZ74MrENOW/1fO0ywG61TLhDZ5jWqzz4mzHI9clb4Qptt+x4vOsOx2rMIsr3a4cLFRYIQRxoMNjzrbd26BX1tj67Urw2X4gjnjb7KADaiBNDwOispKC6kVsQo44LjhT81ZhWGYeXLGVR3Ct53rQgJj/AmLAOE8oDDHemQk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776330676; c=relaxed/simple;
	bh=RtibpALEXn08ivA4S1NSxloelocNX2yk0NnMCkkgPPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UTRSwUQzvyE/EFEKKAjcrvJfW12Iz89acEW75w+O1gwzUYRtAkt3Ds0TZCN8KPoOkfwfcazRdwcvHBKELx2kOp2GdssPez0EZhhRz2Dmh5AIaB8u3davPYRFQeDxsmK+MHdx2dVxbqfhSEqgTaM5Ct4RpvyAs/t8amatUOfavS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fX/fSD8n; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776330676; x=1807866676;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RtibpALEXn08ivA4S1NSxloelocNX2yk0NnMCkkgPPQ=;
  b=fX/fSD8nCEagGV/rCrc2XwOniR4dwwwX/3NOn55Sg58KMj6H9Bp6HbzJ
   3KYBtj/KpR8U4ZM9JKgxtm5vcupSBZMH3aZ4WSEbQ6VtoGqgSEerZ9rr3
   WcZPbSQLAAWee643zB1IYQx8dGoBt8qvAMe63dj/XNusRvLbOMe/aIDnk
   gDkgNPM8yOWYbaNdGWSU6HwLyVv/16RG6h7PmgVGIhp7IQy8bPTndAf82
   0gWZQ+y1cdaHb1r2oi+JJGmFGtLPOPIYSgg0ly3BOhmjJFJhzq+dWUJvu
   pa0nKpiV8gYRg3IXlZRAyeFd+uSOwuWxhW+qToAe2mbuNJ6eh9RNiAyF0
   g==;
X-CSE-ConnectionGUID: 5ka6vYHORxyp4NKCnaDzCw==
X-CSE-MsgGUID: uZrWGq6DTi+I2Gt5N65fiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="77506678"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="77506678"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 02:11:15 -0700
X-CSE-ConnectionGUID: aHTwOwBuSfeTE2pCFfuS8g==
X-CSE-MsgGUID: svS2aVecQVe1sQ8B22gkjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="253923678"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO [10.245.244.235]) ([10.245.244.235])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 02:11:12 -0700
Message-ID: <221abf47-70dd-4c47-b48f-09697d3db172@intel.com>
Date: Thu, 16 Apr 2026 10:11:10 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/2] drm/xe: Reject coh_none PAT index for
 CPU_ADDR_MIRROR
To: Jia Yao <jia.yao@intel.com>, intel-xe@lists.freedesktop.org
Cc: stable@vger.kernel.org, Shuicheng Lin <shuicheng.lin@intel.com>,
 Mathew Alwin <alwin.mathew@intel.com>,
 Michal Mrozek <michal.mrozek@intel.com>,
 Matthew Brost <matthew.brost@intel.com>
References: <20260416051957.651337-1-jia.yao@intel.com>
 <20260416051957.651337-3-jia.yao@intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260416051957.651337-3-jia.yao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.5.7.0.0.1.0.0.e.5.1.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-238279-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[matthew.auld@intel.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 9EB4240C067
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 16/04/2026 06:19, Jia Yao wrote:
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
> v9:
> - Limit the restrictions to iGPU
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
>   drivers/gpu/drm/xe/xe_vm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index 2408b547ca3d..f2e733c7ddab 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -3656,8 +3656,8 @@ static int vm_bind_ioctl_check_args(struct xe_device *xe, struct xe_vm *vm,
>   				 op == DRM_XE_VM_BIND_OP_UNMAP_ALL) ||
>   		    XE_IOCTL_DBG(xe, obj &&
>   				 op == DRM_XE_VM_BIND_OP_MAP_USERPTR) ||
> -		    XE_IOCTL_DBG(xe, coh_mode == XE_COH_NONE &&
> -				 op == DRM_XE_VM_BIND_OP_MAP_USERPTR) ||
> +		    XE_IOCTL_DBG(xe, !IS_DGFX(xe) && coh_mode == XE_COH_NONE &&
> +				 (op == DRM_XE_VM_BIND_OP_MAP_USERPTR || is_cpu_addr_mirror)) ||

Not sure if we want to change the existing behaviour for userptr. At the 
very least would need some IGT updates. I think maybe just limit to 
cpu_addr?

>   		    XE_IOCTL_DBG(xe, xe_device_is_l2_flush_optimized(xe) &&
>   				 (op == DRM_XE_VM_BIND_OP_MAP_USERPTR ||
>   				  is_cpu_addr_mirror) &&


