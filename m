Return-Path: <stable+bounces-194797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 430FEC5D7E4
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 15:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D7784EA8E8
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 14:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E904306B0D;
	Fri, 14 Nov 2025 14:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RwnRUDRk"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637141EB195
	for <stable@vger.kernel.org>; Fri, 14 Nov 2025 14:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763129118; cv=none; b=dWBvYtwIZoZHZyqOtp7xkaYQy1OWVkJGW+VnIY+T9lLE5voZbL5xWv8+mpXPNuDUj1KZTW4ZbvIzi/erq1bAXSM5IJlIW4KUPinsEGiYfzxkhLaw8k8gnStwHwVNowDrHeV99x4NJdFG+Dpqt6r/Avt1tlVVZi1B/lCiCsiFR1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763129118; c=relaxed/simple;
	bh=PQszCpf/77jd/myDNzNExlDVeGv2LjpI5PKDDM++TGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rx4TJptIBbhTvSkWxr/IktgLQQs0bG/cuym/MIrYlZqMzF8QMIbjGvP3FmnyW10bGAiJB9X7kJ1vt7wOlEo+q9xY4jM2c+hzG8E0VvSmhSxGaPx9NkWtPD9h0xzTmVXHqQhdekjESWmb/MEoWXFZdntFPkPdlfspAuDUxb/zukQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RwnRUDRk; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763129116; x=1794665116;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PQszCpf/77jd/myDNzNExlDVeGv2LjpI5PKDDM++TGk=;
  b=RwnRUDRkNg7HDrNlIpKA9n25Z7tmy5kTCDl4nEt8ammUu27b+qcLjJUS
   RbOUkgeYjmuQ57jzQmx67xGi9KT/Hcq6UV1O8uwQBwmXfFjJ56YQoLvDC
   txISXmH6NBtg/bWcr7cIkymxiz0o649usEbFvhxTM+1+u9xuW+v8fVHRv
   gjBQsEuBBa5XQNwsxIl1ImW17pv6Kn3coOwoQ1qZxMRpeCTONOPbzil4u
   4LcM6gFhrCCWpMjtHPz9JVZe1fCNl7sw6iGB9gd2SE3FTDzMvn7ZtrsCG
   F+Thf2le+yAtnuWtHzveN9p46QkkGX6w8m+WxmdmXBj5qkE2DWswtWSFM
   w==;
X-CSE-ConnectionGUID: gHorZ+OMQxCAq2doKX0rhg==
X-CSE-MsgGUID: 55MV3nfmTW6UfrnQlWvHbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="76569450"
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; 
   d="scan'208";a="76569450"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 06:05:15 -0800
X-CSE-ConnectionGUID: hwyWzw3OTser45lcqEaXqg==
X-CSE-MsgGUID: uoZLd03+Q9SnNpfVrN65MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; 
   d="scan'208";a="190031087"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO [10.245.244.26]) ([10.245.244.26])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 06:05:13 -0800
Message-ID: <d2ddc2b2-e22a-4cfb-aa27-9332b03ecbc3@intel.com>
Date: Fri, 14 Nov 2025 14:05:11 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/xe: Prevent BIT() overflow when handling invalid
 prefetch region
To: Shuicheng Lin <shuicheng.lin@intel.com>, intel-xe@lists.freedesktop.org
Cc: stable@vger.kernel.org
References: <20251112181005.2120521-2-shuicheng.lin@intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20251112181005.2120521-2-shuicheng.lin@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/2025 18:10, Shuicheng Lin wrote:
> If user provides a large value (such as 0x80) for parameter
> prefetch_mem_region_instance in vm_bind ioctl, it will cause
> BIT(prefetch_region) overflow as below:
> "
>   ------------[ cut here ]------------
>   UBSAN: shift-out-of-bounds in drivers/gpu/drm/xe/xe_vm.c:3414:7
>   shift exponent 128 is too large for 64-bit type 'long unsigned int'
>   CPU: 8 UID: 0 PID: 53120 Comm: xe_exec_system_ Tainted: G        W           6.18.0-rc1-lgci-xe-kernel+ #200 PREEMPT(voluntary)
>   Tainted: [W]=WARN
>   Hardware name: ASUS System Product Name/PRIME Z790-P WIFI, BIOS 0812 02/24/2023
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0xa0/0xc0
>    dump_stack+0x10/0x20
>    ubsan_epilogue+0x9/0x40
>    __ubsan_handle_shift_out_of_bounds+0x10e/0x170
>    ? mutex_unlock+0x12/0x20
>    xe_vm_bind_ioctl.cold+0x20/0x3c [xe]
>   ...
> "
> Fix it by validating prefetch_region before the BIT() usage.
> 
> v2: Add Closes and Cc stable kernels. (Matt)
> 
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/6478
> Cc: <stable@vger.kernel.org> # v6.8+
> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
> Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>

Pushed with added:

Reported-by: Koen Koning <koen.koning@intel.com>
Reported-by: Peter Senna Tschudin <peter.senna@linux.intel.com>

Thanks for the fix.

> ---
>   drivers/gpu/drm/xe/xe_vm.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index 8fb5cc6a69ec..7cac646bdf1c 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -3411,8 +3411,10 @@ static int vm_bind_ioctl_check_args(struct xe_device *xe, struct xe_vm *vm,
>   				 op == DRM_XE_VM_BIND_OP_PREFETCH) ||
>   		    XE_IOCTL_DBG(xe, prefetch_region &&
>   				 op != DRM_XE_VM_BIND_OP_PREFETCH) ||
> -		    XE_IOCTL_DBG(xe,  (prefetch_region != DRM_XE_CONSULT_MEM_ADVISE_PREF_LOC &&
> -				       !(BIT(prefetch_region) & xe->info.mem_region_mask))) ||
> +		    XE_IOCTL_DBG(xe, (prefetch_region != DRM_XE_CONSULT_MEM_ADVISE_PREF_LOC &&
> +				      /* Guard against undefined shift in BIT(prefetch_region) */
> +				      (prefetch_region >= (sizeof(xe->info.mem_region_mask) * 8) ||
> +				      !(BIT(prefetch_region) & xe->info.mem_region_mask)))) ||
>   		    XE_IOCTL_DBG(xe, obj &&
>   				 op == DRM_XE_VM_BIND_OP_UNMAP) ||
>   		    XE_IOCTL_DBG(xe, (flags & DRM_XE_VM_BIND_FLAG_MADVISE_AUTORESET) &&


