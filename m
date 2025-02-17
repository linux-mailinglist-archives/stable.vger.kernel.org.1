Return-Path: <stable+bounces-116542-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FA0A37E47
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 10:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1F5C188A13C
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 09:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F30201261;
	Mon, 17 Feb 2025 09:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kfcSHVit"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB11B200BA8
	for <stable@vger.kernel.org>; Mon, 17 Feb 2025 09:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739783959; cv=none; b=RrdynYNhDw8IuOuJGSSYVBdaw8TmJABDTdM+hr5jBV7kWqIvmloUK7YtGR1gfez79DFlQ84zr207O32Hv/6q4nQy42AzNrXQf7xtXupNTJktdy3b8N1wni7ES9m8VinuOqSL1RLhP9YlS+CzSHIwMcqpYPlOWlSSLIODMcz8gIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739783959; c=relaxed/simple;
	bh=r/Gwa//y0lYyDEogMeLWJ5YpBC9J0mVmavf3W+j2hgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DsixebBs7p3zYj/8We39ewTrIKnrjm19mjbh9oJDokOAufVyxI1W93vuN9nGQsIRV5Muy1a3KYPSymNKazBenQHCZeR0C7z3CG5Yx5nltD9uMDFzSeODAghzuk4HKPWVrGerTIhwDNwaADsEJ8yh/5AmQleciZoQ8/OkeVGo5hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kfcSHVit; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739783957; x=1771319957;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=r/Gwa//y0lYyDEogMeLWJ5YpBC9J0mVmavf3W+j2hgU=;
  b=kfcSHVityMhYUie2h1WyZMwaGEo/wEf78BgqYKEl4f+LvQ4YjDB8fKCE
   KZpgMHb4LGtc4LhehxSTIkU4wY20ukjRq43N2p0ZeJxMcIKRZ+hVaPPBb
   gpup4TFD9W3IqKQfGQUQ2AvW1Cnt+gbcvhSV2WnprlBJ580O1lsFIOu0J
   TdY+vwrYdWts2tnQQRWWb7YYgh8dPCYDGIz6G4LHPCxSWqUzAaR32XzZt
   g4HtUzh8dMIeq7Lzvlz0EaRfh/v4IelUTXWsRZr04S7xE08hUNdrZdYYc
   4A0jOQZcCY7TlmH0b+481vJxEQ6dLWF2q1equc2a8p3kZywUh2PzVVNYu
   Q==;
X-CSE-ConnectionGUID: BXFXsUZVSN6TZQ0/HZb3dg==
X-CSE-MsgGUID: KPBXvIsKRHybmcNnEq+xTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="62928926"
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="62928926"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 01:19:15 -0800
X-CSE-ConnectionGUID: X7ejjno2RTaQtvlQD1L2aA==
X-CSE-MsgGUID: CnPUX6qNQFWlbEzKVIvWvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118703860"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.244.174]) ([10.245.244.174])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 01:19:13 -0800
Message-ID: <43e7703d-b53d-4b68-b4d3-edcfea95e44e@intel.com>
Date: Mon, 17 Feb 2025 09:19:11 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] drm/xe/userptr: fix EFAULT handling
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 stable@vger.kernel.org
References: <20250214170527.272182-4-matthew.auld@intel.com>
 <20250214170527.272182-5-matthew.auld@intel.com>
 <Z6/skmsP0lw0+GUi@lstrano-desk.jf.intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <Z6/skmsP0lw0+GUi@lstrano-desk.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/02/2025 01:23, Matthew Brost wrote:
> On Fri, Feb 14, 2025 at 05:05:29PM +0000, Matthew Auld wrote:
>> Currently we treat EFAULT from hmm_range_fault() as a non-fatal error
>> when called from xe_vm_userptr_pin() with the idea that we want to avoid
>> killing the entire vm and chucking an error, under the assumption that
>> the user just did an unmap or something, and has no intention of
>> actually touching that memory from the GPU.  At this point we have
>> already zapped the PTEs so any access should generate a page fault, and
>> if the pin fails there also it will then become fatal.
>>
>> However it looks like it's possible for the userptr vma to still be on
>> the rebind list in preempt_rebind_work_func(), if we had to retry the
>> pin again due to something happening in the caller before we did the
>> rebind step, but in the meantime needing to re-validate the userptr and
>> this time hitting the EFAULT.
>>
>> This might explain an internal user report of hitting:
>>
>> [  191.738349] WARNING: CPU: 1 PID: 157 at drivers/gpu/drm/xe/xe_res_cursor.h:158 xe_pt_stage_bind.constprop.0+0x60a/0x6b0 [xe]
>> [  191.738551] Workqueue: xe-ordered-wq preempt_rebind_work_func [xe]
>> [  191.738616] RIP: 0010:xe_pt_stage_bind.constprop.0+0x60a/0x6b0 [xe]
>> [  191.738690] Call Trace:
>> [  191.738692]  <TASK>
>> [  191.738694]  ? show_regs+0x69/0x80
>> [  191.738698]  ? __warn+0x93/0x1a0
>> [  191.738703]  ? xe_pt_stage_bind.constprop.0+0x60a/0x6b0 [xe]
>> [  191.738759]  ? report_bug+0x18f/0x1a0
>> [  191.738764]  ? handle_bug+0x63/0xa0
>> [  191.738767]  ? exc_invalid_op+0x19/0x70
>> [  191.738770]  ? asm_exc_invalid_op+0x1b/0x20
>> [  191.738777]  ? xe_pt_stage_bind.constprop.0+0x60a/0x6b0 [xe]
>> [  191.738834]  ? ret_from_fork_asm+0x1a/0x30
>> [  191.738849]  bind_op_prepare+0x105/0x7b0 [xe]
>> [  191.738906]  ? dma_resv_reserve_fences+0x301/0x380
>> [  191.738912]  xe_pt_update_ops_prepare+0x28c/0x4b0 [xe]
>> [  191.738966]  ? kmemleak_alloc+0x4b/0x80
>> [  191.738973]  ops_execute+0x188/0x9d0 [xe]
>> [  191.739036]  xe_vm_rebind+0x4ce/0x5a0 [xe]
>> [  191.739098]  ? trace_hardirqs_on+0x4d/0x60
>> [  191.739112]  preempt_rebind_work_func+0x76f/0xd00 [xe]
>>
>> Followed by NPD, when running some workload, since the sg was never
>> actually populated but the vma is still marked for rebind when it should
>> be skipped for this special EFAULT case. And from the logs it does seem
>> like we hit this special EFAULT case before the explosions.
>>
> 
> It would be nice to verify if this fixes the bug report.

Yes, reporter said it fixes it. Or at least the previous version did. 
See GSD-10562 if you are curious. Will re-phrase the commit message to 
make that clear.

> 
>> v2 (MattB):
>>   - Move earlier
>>
>> Fixes: 521db22a1d70 ("drm/xe: Invalidate userptr VMA on page pin fault")
>> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
>> Cc: Matthew Brost <matthew.brost@intel.com>
> 
> Anyways, LGTM:
> Reviewed-by: Matthew Brost <matthew.brost@intel.com>

Thanks.

> 
>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>> Cc: <stable@vger.kernel.org> # v6.10+
>> ---
>>   drivers/gpu/drm/xe/xe_vm.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
>> index 668b0bde7822..f36e2cc1d155 100644
>> --- a/drivers/gpu/drm/xe/xe_vm.c
>> +++ b/drivers/gpu/drm/xe/xe_vm.c
>> @@ -681,6 +681,18 @@ int xe_vm_userptr_pin(struct xe_vm *vm)
>>   		err = xe_vma_userptr_pin_pages(uvma);
>>   		if (err == -EFAULT) {
>>   			list_del_init(&uvma->userptr.repin_link);
>> +			/*
>> +			 * We might have already done the pin once already, but
>> +			 * then had to retry before the re-bind happened, due
>> +			 * some other condition in the caller, but in the
>> +			 * meantime the userptr got dinged by the notifier such
>> +			 * that we need to revalidate here, but this time we hit
>> +			 * the EFAULT. In such a case make sure we remove
>> +			 * ourselves from the rebind list to avoid going down in
>> +			 * flames.
>> +			 */
>> +			if (!list_empty(&uvma->vma.combined_links.rebind))
>> +				list_del_init(&uvma->vma.combined_links.rebind);
>>   
>>   			/* Wait for pending binds */
>>   			xe_vm_lock(vm, false);
>> -- 
>> 2.48.1
>>


