Return-Path: <stable+bounces-225529-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLWgBF/tt2l8XQEAu9opvQ
	(envelope-from <stable+bounces-225529-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 12:45:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E81298DC6
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 12:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50D493009168
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 11:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A410B2641FC;
	Mon, 16 Mar 2026 11:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wn5G6pff"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516CC1ACEDE
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 11:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773661230; cv=none; b=IoLSs756kDX8lsCJaODTwLIhzyuPARP/yPmrz9JzoFIBQ0BZpVgpw/HreVACgHdXUsmJcsytyXGFf2ZUdSPPA1UrPM/ALqe8x302Pislh72j+sw5uX/0lXSEmJoc4saxwVyn+ajs2eRTPbjlXlUAtHLriYinbpIC18/FUjRLmUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773661230; c=relaxed/simple;
	bh=QtdLGzEgYjjY0r5MVIbMvUXsQfAXquKsNJdipJSCY6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U4huaN94fs7W9nTGjSf4zsAuG81uXCCgpy10qYXSaJFLdN0B8mPkLusztkQSWhoD+RzNQ/QJq1HW44cJ5flENcQvm8+ikPmdViJb40LdsMVhTUr58vOa8LCTxH9X7yig1q7vX8zedp6uJgbdGGtgPgp4/P6aB9022/M3MYOTqbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wn5G6pff; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773661230; x=1805197230;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QtdLGzEgYjjY0r5MVIbMvUXsQfAXquKsNJdipJSCY6E=;
  b=Wn5G6pffHbxy+1VWnexZSWK3QyBqywFPh8TaSAaPAkKVxbYT+rP6f5EB
   HJrzJMj6Tmb+A/RXfNTXgCjOweUVlM+TlVBAbPMG/iKMMsH/G0J76hVYw
   2EjUgZipgOQp4+XLPZ1pY3jYPB9PDYasJXVk2Ux97SjZLAEcxBUnCtuSh
   Pgbpafhow4hUBaloW+UbHq6uz20JpwF210w5c2ghUz7z4Tn+nPvcbDtbG
   MrX1wFEX2aSkopIP3iw6t3i3qnKjfssiP9itcM+CRo5Iy+n3W8+rgJRAq
   xyTu/ZA4lkiyn/UHc6GVQ6/lAs4r6Y/mc6Whk0RzDqa+OY3zH1lNI8KUH
   Q==;
X-CSE-ConnectionGUID: bMJ4FwwlSU62+OsNX3VWXA==
X-CSE-MsgGUID: wQ3bZV/xT368Ftw7FGue3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="92056729"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="92056729"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 04:40:30 -0700
X-CSE-ConnectionGUID: WAa+yDxLQJ290BJg9DSemg==
X-CSE-MsgGUID: NJqI9ZK2Qoy7oqNTyHMzCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="226349347"
Received: from amilburn-desk.amilburn-desk (HELO [10.245.244.246]) ([10.245.244.246])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 04:40:27 -0700
Message-ID: <20732332-b75f-43e0-a244-210b47b44dc5@intel.com>
Date: Mon, 16 Mar 2026 11:40:24 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] drm/xe: Reject coh_none PAT index for
 CPU_ADDR_MIRROR
To: Jia Yao <jia.yao@intel.com>, intel-xe@lists.freedesktop.org
Cc: stable@vger.kernel.org, Shuicheng Lin <shuicheng.lin@intel.com>,
 Mathew Alwin <alwin.mathew@intel.com>,
 Michal Mrozek <michal.mrozek@intel.com>,
 Matthew Brost <matthew.brost@intel.com>
References: <20260129000147.339361-1-jia.yao@intel.com>
 <20260316072257.255372-1-jia.yao@intel.com>
 <20260316072257.255372-3-jia.yao@intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260316072257.255372-3-jia.yao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225529-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.auld@intel.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 68E81298DC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 16/03/2026 07:22, Jia Yao wrote:
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
> Fixes: ada7486c5668 ("drm/xe: Implement madvise ioctl for xe")

Is this the right fixes tag?

> Cc: stable@vger.kernel.org # v6.18
> Cc: Shuicheng Lin <shuicheng.lin@intel.com>
> Cc: Mathew Alwin <alwin.mathew@intel.com>
> Cc: Michal Mrozek <michal.mrozek@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Signed-off-by: Jia Yao <jia.yao@intel.com>

As discussed offline, I think this is needed. My understanding is that 
when binding an svm range we use the parent vma pat index, and without 
using the madvise pat control, the default pat index is whatever the 
user selects here, which could be incoherent, and on least igpu that 
will be problematic when accessing CPU cached system memory.

Reviewed-by: Matthew Auld <matthew.auld@intel.com>

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


