Return-Path: <stable+bounces-232955-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEKhH6w6zmmAmAYAu9opvQ
	(envelope-from <stable+bounces-232955-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 11:45:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A888387231
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 11:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4324730DCC33
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 09:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C297A3932CE;
	Thu,  2 Apr 2026 09:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dUErAqnl"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B59139B97A
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 09:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775122084; cv=none; b=NQHJu766NfbzvpdRWlPERPFdUnuvkSGdU1Bv2jvJFL4HFA8U6WdfLuNv/GMSBVRC7SW6/khgRtiob/e07hjBYsTQA7kaqVnSAHLYRs6Z/EW/UcZyTg5sU21uXxq9eAipg9DaOvp/48D5ozrlY2T9qZLSyIslcuMIdTM05v+EV+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775122084; c=relaxed/simple;
	bh=klwNKV48BjDQnzhLT0czwxW1UGoTMOPzQeGUWvNL5Uo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kcGXYBCe8FFmESHaQ6dEjT1PXMHegOz7e4W1LmH6c5vKQX3nGtWhF1HpApwtqqCGDL5aI858Glt7VZwAFf7ImEAR7oBWHHnxsNYpl+NqOinEtGjN1kenG7LaJHtLxFKJneryvYqw9C9Yxo4MTcleKeGCjDZpScVTKRSqcPhfNmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dUErAqnl; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775122075; x=1806658075;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=klwNKV48BjDQnzhLT0czwxW1UGoTMOPzQeGUWvNL5Uo=;
  b=dUErAqnlTcTaeEpPEq6CVyaCclSiIyKG1XBADYbGtSHFu+25OjgK+7Eb
   HkLQ4tHLB1e7v5MZ/KXJczONY59Zaw9bwJcyy8XXPx+4IYH1ex49lv533
   8ZpWw/hN1SiwXqj9VKL9LPcRW0QDU3v2utFstErwlvU4/wGOrX4Djlj0L
   IWh08wtAM3kOJMEBGGXqZg39jwf0/XvvDM+m7Kqp6VglwxxWsuj8zlPqh
   MCPfz1B/Co3UFXZwHJiLmicRJ1Gk4q4/iwFs84xXDOamfHHo1kPMPUb3D
   /oPRaDG0+r5sFDxnHWJqZJUFNi6rPelSxiBYjatspcq0AHIujuXU1n1lR
   g==;
X-CSE-ConnectionGUID: cRkMOOjzQSmthBpjqWmgNA==
X-CSE-MsgGUID: mlw6liUzRQugjzMgPWqe1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="98790133"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="98790133"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 02:27:54 -0700
X-CSE-ConnectionGUID: XS3ZfqYPQxS9ySkaxOMlpg==
X-CSE-MsgGUID: F9nwgGqtQ1+SDOAO7gAAZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="257411207"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO [10.245.245.52]) ([10.245.245.52])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 02:27:54 -0700
Message-ID: <9a7b9651-c818-457c-b52d-7fc2544e0b56@intel.com>
Date: Thu, 2 Apr 2026 10:27:50 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe: Fix slab-out-of-bounds on PT update ops retry
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>, stable@vger.kernel.org
References: <20260402091539.4114-1-thomas.hellstrom@linux.intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260402091539.4114-1-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232955-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.auld@intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7A888387231
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 02/04/2026 10:15, Thomas Hellström wrote:
> xe_pt_update_ops_prepare() calls xe_pt_update_ops_init() at the start of
> each invocation to reset per-attempt state, but current_op was not
> included in that reset. When vm_bind_ioctl_ops_execute() retries due to
> ww-mutex contention (drm_exec_retry_on_contention), ops_execute() calls
> xe_pt_update_ops_prepare() again. The second call walks the same op list
> and fills ops[] starting from current_op, which still holds the value
> from the first attempt. This indexes past the end of the ops array
> allocated by xe_vma_ops_alloc(), whose size was computed for a single
> pass.
> 
> KASAN reported:
>    BUG: KASAN: slab-out-of-bounds in bind_op_prepare+0x89c/0xae0 [xe]
>    Write of size 8 at addr ffff88812e72bae8 by task xe_evict/2848
>    [...]
>    bind_op_prepare+0x89c/0xae0 [xe]
>    xe_pt_update_ops_prepare+0xbd0/0x1570 [xe]
>    ops_execute+0x3ae/0x2030 [xe]
>    vm_bind_ioctl_ops_execute+0x4d5/0xed0 [xe]
> 
> The write lands at ops[1].vma (offset 360 into the second element of a
> one-element 384-byte allocation) because entries[] is exactly 360 bytes
> and current_op was 1 at the start of the retried prepare pass.
> 
> Fix by resetting current_op to 0 in xe_pt_update_ops_init().
> 
> Fixes: e8babb280b5e ("drm/xe: Convert multiple bind ops into single job")
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: <stable@vger.kernel.org> # v6.12+
> Assisted-by: GitHub Copilot:claude-sonnet-4.6

Out of curiosity, was it able to suggest the fix given the KASAN splat?

> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>

> ---
>   drivers/gpu/drm/xe/xe_pt.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
> index 8e5f4f0dea3f..3607cd57fc4c 100644
> --- a/drivers/gpu/drm/xe/xe_pt.c
> +++ b/drivers/gpu/drm/xe/xe_pt.c
> @@ -2291,6 +2291,7 @@ xe_pt_update_ops_init(struct xe_vm_pgtable_update_ops *pt_update_ops)
>   	init_llist_head(&pt_update_ops->deferred);
>   	pt_update_ops->start = ~0x0ull;
>   	pt_update_ops->last = 0x0ull;
> +	pt_update_ops->current_op = 0;
>   	xe_page_reclaim_list_init(&pt_update_ops->prl);
>   }
>   


