Return-Path: <stable+bounces-225809-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BJ+KPQxuWnsuQEAu9opvQ
	(envelope-from <stable+bounces-225809-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 11:50:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 039DC2A8442
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 11:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B7333053774
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 10:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A107F32D7F0;
	Tue, 17 Mar 2026 10:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lcrdKgLX"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6932EF652
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 10:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773744328; cv=none; b=fh0dEEgskNWWJ5rcvBEz3M/HYkg40O4V1edPWwc4b0kO0PoJct0kq3StKwd5SsBjlky1yDECnOkcTJf2Nunemo2JK1wU8OB81tu4bIWzm59kGhwElq4lde23W5AzbETRU2uJMXJyfM6Mz2fRUNaexdJ+bbRXNDMbz7lrjZ3TQvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773744328; c=relaxed/simple;
	bh=rchWW5a+2wWcJZRD+Xz4sWsrBBSKlG/inHusim50V38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j7chu1Jgy7ZVL6f4gDqayyjJKwi2EYG7TZgBOQFpOBDBxe7DFi3KG74usW7fHG9kbMieubOvVrxFHhsZNwAUPsKS3HuuJBPFuGOt80u4b4LW98keorDuVxe7aFOdO0eMRqkOZ+8agGI9uOB3XfftPzglehwhljdfySCmCahelE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lcrdKgLX; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773744327; x=1805280327;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rchWW5a+2wWcJZRD+Xz4sWsrBBSKlG/inHusim50V38=;
  b=lcrdKgLXH7pOR9cgtPBAeGfRr1WdxtYBAglR2zKkDtC0U9HjxiFQgnr8
   q9KBZhLoHX1Il2B7fPYjn6V7h+eRvue7StqxlbeXFm38NG8Boyc8B/7TQ
   Q1byn6QhCVNZzOd06PDhITLB6+kOBk651zbbJsQZHEy5Bq129GqIEVHsa
   UwqT6/L5BjeoqeIWkfdXjjV3xpJsLMa3Su6VJy6ySWXX4ycs0j73i44YS
   lQNzCPpYKCihrhzXxUYFldQUseyCY7zFVgKb4NuHhhbhRWYBVxZRGjJcb
   x04bWUOTJ5yTx/+DDKs+jQ/qZr+vJDEY08R1dVmvp8da62KFawpdLhM7s
   A==;
X-CSE-ConnectionGUID: hEPXGJQKSGu7CKMxZhf8Dg==
X-CSE-MsgGUID: maWYWbmbT5GYSKa4bxCBfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="77382229"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="77382229"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 03:45:27 -0700
X-CSE-ConnectionGUID: WYVWxBfCSA6YeL3Kf3CIeg==
X-CSE-MsgGUID: i/7bohZxQvGFo5MugMrFhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="221456845"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO [10.245.245.147]) ([10.245.245.147])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 03:45:24 -0700
Message-ID: <80b5e2f3-88e4-44c6-84b2-1fae9444467e@intel.com>
Date: Tue, 17 Mar 2026 10:45:22 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] drm/xe: Reject coh_none PAT index for
 CPU_ADDR_MIRROR
To: Jia Yao <jia.yao@intel.com>, intel-xe@lists.freedesktop.org
Cc: stable@vger.kernel.org, Shuicheng Lin <shuicheng.lin@intel.com>,
 Mathew Alwin <alwin.mathew@intel.com>,
 Michal Mrozek <michal.mrozek@intel.com>,
 Matthew Brost <matthew.brost@intel.com>
References: <20260129000147.339361-1-jia.yao@intel.com>
 <20260316164253.262406-1-jia.yao@intel.com>
 <20260316164253.262406-3-jia.yao@intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260316164253.262406-3-jia.yao@intel.com>
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
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225809-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 039DC2A8442
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 16/03/2026 16:42, Jia Yao wrote:
> Add validation in xe_vm_bind_ioctl() to reject PAT indices with
> XE_COH_NONE coherency mode when used with
> DRM_XE_VM_BIND_FLAG_CPU_ADDR_MIRROR, consistent with the existing
> validation for DRM_XE_VM_BIND_OP_MAP_USERPTR.
> 
> CPU address mirror mappings use system memory which is CPU cached,
> making them incompatible with COH_NONE PAT index. Using COH_NONE with
> CPU cached buffers is a security issue: GPU can bypass CPU caches and
> directly read stale sensitive data from DRAM, potentially leaking data
> from previously freed pages.
> 
> Although CPU_ADDR_MIRROR mappings don't create actual memory mappings
> (the range is reserved for dynamic mapping on GPU page faults), the
> underlying system memory is still CPU cached, so the same PAT coherency
> restrictions as MAP_USERPTR should apply.
> 
> v2:
> - Correct fix tag
> 
> Fixes: e1fbc4f18d5b ("drm/xe/uapi: support pat_index selection with vm_bind")

I don't think addr_mirror existed yet?

Maybe:
Fixes: b43e864af0d4 ("drm/xe/uapi: Add DRM_XE_VM_BIND_FLAG_CPU_ADDR_MIRROR")
Cc: <stable@vger.kernel.org> # v6.15+

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
> index 5572e12c2a7e..1c4b4a5eeadb 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -3491,7 +3491,7 @@ static int vm_bind_ioctl_check_args(struct xe_device *xe, struct xe_vm *vm,
>   		    XE_IOCTL_DBG(xe, obj &&
>   				 op == DRM_XE_VM_BIND_OP_MAP_USERPTR) ||
>   		    XE_IOCTL_DBG(xe, coh_mode == XE_COH_NONE &&
> -				 op == DRM_XE_VM_BIND_OP_MAP_USERPTR) ||
> +				 (op == DRM_XE_VM_BIND_OP_MAP_USERPTR || is_cpu_addr_mirror)) ||
>   		    XE_IOCTL_DBG(xe, comp_en &&
>   				 op == DRM_XE_VM_BIND_OP_MAP_USERPTR) ||
>   		    XE_IOCTL_DBG(xe, op == DRM_XE_VM_BIND_OP_MAP_USERPTR &&


