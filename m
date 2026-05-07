Return-Path: <stable+bounces-244537-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJJ4KzVW/GlOOAAAu9opvQ
	(envelope-from <stable+bounces-244537-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 11:07:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6554E5850
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 11:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D5F330237D7
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 09:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B30B3B9D8C;
	Thu,  7 May 2026 09:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H1yvM1WU"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2DC370D75
	for <stable@vger.kernel.org>; Thu,  7 May 2026 09:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778144642; cv=none; b=BqPhTujx9EgMN/aNerI37NnsaxGfh3Lsj0KrlkOyXYSXlEpvjhUSu4iRYHOBkw9LY7as95LZLwxN3P9YLTxPHFdWv7h7v+gpP39PPaR4Ss20bxzUjEpQUCOocwqCjQVS5AvWCk6OTBkh3Byf8HAKd5o7T0qXyvgm07uZdVKyoi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778144642; c=relaxed/simple;
	bh=8KKCqCLdP7VcTPidivBPuZRSXLAgixp2kuM6JXfRflQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wh1V3cSYyjrPDNBVUsI7fzYygt89ZAJFb+/HkEUl8ON+KCCsd6D0WRhy/cUg5oZ8Bpf6EOujfxJ2yTSo4X+co7md23bHQh6afyj7rzaETUd6Vj4FzgS5y7GVqg4xN0PKntVhQOrLpdvI8vtRwqhLZVftmxCY+I1zE7cGg814ae4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H1yvM1WU; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778144638; x=1809680638;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8KKCqCLdP7VcTPidivBPuZRSXLAgixp2kuM6JXfRflQ=;
  b=H1yvM1WUsJfQ2460hA7qN8zQkb9IUvyswoUiNH46NuIRVf4a/JXsW2KB
   IZxX0zr/u74mB6MxuBLxju0azjJ66cI9W2UM2CpgAYS/8ZlVS8VFx/Zxn
   jw+ng3pOSCbvuYw/ZFvRunG8bya34d/o5T7BMXr/ImHcfVBBcgqChgGD3
   yqwqfcO4gVmPGEQ74tlZyn79rPz/tYN+KoTQHPzlD+GFbw+DzA2o4gkCM
   LuO6VPmUMXyWNCKSRTGh1sEwlj+JCjnnn3ZJjnPjv/XNlDpxQ7kTeTCuq
   AMF0LMY2kC+nhg+xvU1WSJDziMcQ9UdR+2lFYB5NMtoOtF1BVPyZpt0ir
   Q==;
X-CSE-ConnectionGUID: i8h8EXS0Qnq9qb4De0OmpA==
X-CSE-MsgGUID: MK+MZKXyRnC3Ifvd0woZ0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="78940752"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="78940752"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 02:03:57 -0700
X-CSE-ConnectionGUID: 4iO4Kb+2RTyWikIpTfbF8g==
X-CSE-MsgGUID: MlY12JthQASlk1ZUlFd1+w==
X-ExtLoop1: 1
Received: from amilburn-desk.amilburn-desk (HELO [10.245.245.139]) ([10.245.245.139])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 02:03:55 -0700
Message-ID: <f4957d06-3c0b-4ffe-928c-e82bf7615d75@intel.com>
Date: Thu, 7 May 2026 10:03:53 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe/dma-buf: handle empty bo and UAF races
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>, stable@vger.kernel.org
References: <20260506184332.86743-2-matthew.auld@intel.com>
 <ac67eec8376792e795f37645b83c1f4c7fed8ba4.camel@linux.intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <ac67eec8376792e795f37645b83c1f4c7fed8ba4.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2B6554E5850
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244537-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.auld@intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 06/05/2026 20:59, Thomas Hellström wrote:
> On Wed, 2026-05-06 at 19:43 +0100, Matthew Auld wrote:
>> There look to be some nasty races here when triggering the
>> invalidate_mappings hook:
>>
>> 1) We do xe_bo_alloc() followed by the attach, before the actual full
>> bo
>>     init step in xe_dma_buf_init_obj(). However the bo is visible on
>> the
>>     attachments list after the attach.  This is bad since exporter
>> driver,
>>     say amdgpu, can at any time call back into our invalidate_mappings
>> hook,
>>     with an empty/bogus bo, leading to potential bugs/crashes.
>>
>> 2) Similar to 1) but here we get a UAF, when the invalidate_mappings
>>     hook is triggered. For example, we get as far as
>> xe_bo_init_locked()
>>     but this fails in some way. But here the bo will be freed on
>> error, but
>>     we still have it attached from dma-buf pov, so if the
>>     invalidate_mappings is now triggered then the bo we access is gone
>> and
>>     we trigger UAF and more bugs/crashes.
>>
>> To fix this, move the attach step until after we actually have a
>> fully
>> set up buffer object. Note that the bo is not published to userspace
>> until later, so not sure what the comment "Don't publish the bo
>> until we have a valid attachment", is referring to.
>>
>> We have at least two different customers reporting hitting a NULL ptr
>> deref in evict_flags when importing something from amdgpu, followed
>> by
>> triggering the evict flow. Hit rate is also pretty low, which would
>> hint at some kind of race, so something like 1) or 2) might explain
>> this.
>>
>> Assisted-by: Gemini:gemini-3 #debug
>> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/7903
>> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/4055
>> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel
>> GPUs")
>> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: <stable@vger.kernel.org> # v6.8+
>> ---
>>   drivers/gpu/drm/xe/xe_dma_buf.c | 23 ++++++++---------------
>>   1 file changed, 8 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c
>> b/drivers/gpu/drm/xe/xe_dma_buf.c
>> index b9828da15897..e6c2f7d30abb 100644
>> --- a/drivers/gpu/drm/xe/xe_dma_buf.c
>> +++ b/drivers/gpu/drm/xe/xe_dma_buf.c
>> @@ -357,11 +357,6 @@ struct drm_gem_object
>> *xe_gem_prime_import(struct drm_device *dev,
>>   		}
>>   	}
>>   
>> -	/*
>> -	 * Don't publish the bo until we have a valid attachment,
>> and a
>> -	 * valid attachment needs the bo address. So pre-create a bo
>> before
>> -	 * creating the attachment and publish.
>> -	 */
>>   	bo = xe_bo_alloc();
>>   	if (IS_ERR(bo))
>>   		return ERR_CAST(bo);
>> @@ -371,6 +366,13 @@ struct drm_gem_object
>> *xe_gem_prime_import(struct drm_device *dev,
>>   	if (test)
>>   		attach_ops = test->attach_ops;
>>   #endif
>> +	/*
>> +	 * xe_dma_buf_init_obj() takes ownership of bo on both
>> success
>> +	 * and failure, so we must not touch bo after this call.
>> +	 */
>> +	obj = xe_dma_buf_init_obj(dev, bo, dma_buf);
>> +	if (IS_ERR(obj))
>> +		return obj;
> 
> IIRC this publishes the bo on the LRUs, as per the removed comment.
> What happens if, for example, the shrinker kicks in and shrinks it? But
> similarly perhaps we should have obj->import_attach set already at
> publish time?

I don't think anything bad will happen? I would view it as an sg object 
without any real backing store or attachment. Trying to 
move/shrink/evict should be a noop, like moving from SYS -> SYS 
(starting placement for type_sg). But since this a type_sg bo, I think 
shrinker will already ignore it right?

 From user POV, the handle is only published until much later at the end 
of drm_gem_prime_fd_to_handle(), after our import callback here, AFAICT. 
So I don't think there is a risk of the user somehow using the imported 
bo in an ioctl, before we have done the attach etc.

One other data point is perhaps amdgpu, which does seem to do the create 
+ attach as normal steps.

> 
> If this is indeed the case we might have to revert to some trickery.
> Like invalidate_mappings() returning early if the init is not complete,
> and set obj->import_attach under the lock in xe_dma_buf_init_obj?
> 
> Also I think IIRC xe_bo_alloc() was created specifically for this
> situation, so unless there are more users of that, and the ordering in
> this patch is indeed correct, we might be able to get rid of the two-
> step bo creation here.
> 
> /Thomas
> 
> 
>>   
>>   	attach = dma_buf_dynamic_attach(dma_buf, dev->dev,
>> attach_ops, &bo->ttm.base);
>>   	if (IS_ERR(attach)) {
>> @@ -378,21 +380,12 @@ struct drm_gem_object
>> *xe_gem_prime_import(struct drm_device *dev,
>>   		goto out_err;
>>   	}
>>   
>> -	/*
>> -	 * xe_dma_buf_init_obj() takes ownership of bo on both
>> success
>> -	 * and failure, so we must not touch bo after this call.
>> -	 */
>> -	obj = xe_dma_buf_init_obj(dev, bo, dma_buf);
>> -	if (IS_ERR(obj)) {
>> -		dma_buf_detach(dma_buf, attach);
>> -		return obj;
>> -	}
>>   	get_dma_buf(dma_buf);
>>   	obj->import_attach = attach;
>>   	return obj;
>>   
>>   out_err:
>> -	xe_bo_free(bo);
>> +	xe_bo_put(bo);
>>   
>>   	return obj;
>>   }


