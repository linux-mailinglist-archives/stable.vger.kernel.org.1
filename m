Return-Path: <stable+bounces-244563-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLI2Hk+H/GkaRAAAu9opvQ
	(envelope-from <stable+bounces-244563-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 14:36:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4374E8465
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 14:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 919F4301BF5A
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 12:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBF33EDAAC;
	Thu,  7 May 2026 12:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RwJRvyUJ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03A03C73E5
	for <stable@vger.kernel.org>; Thu,  7 May 2026 12:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778157313; cv=none; b=XNvjcNWWZXIOo+vyq3Xcr1NiNMCFRi52ams/gHOmyZMt7pJj/E4CV1huVaq1OhC8wTN7HAekAiruPCFcphwSfdPEW9Jns2DzJky5MbyClw0AjlTD7iaA3Y/wpY8XpvxDjt4mZqeiEzdEKFo1r5nQlLEQwONwVxV0MHp7fbOJw/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778157313; c=relaxed/simple;
	bh=PBADSmOMe2NT6XOFFz6WVrGYyIAeD+KgWK82GtrsFZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KLkjZcPtNoX0Nqr7DKca4WrKHldj66fY2Hu6EtvDcAURtJMKGdCAVF1C/7/+qku2KZvfgI/S1mma1IKSsoqPy4dY9VElk4RQjvTTyswn8jqvMx60fr8zF99aYOrQedc/ZAtxbTJ04IUPjTJAhbh+9+9H/h6oSSKyLGt23CMkyvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RwJRvyUJ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778157310; x=1809693310;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PBADSmOMe2NT6XOFFz6WVrGYyIAeD+KgWK82GtrsFZE=;
  b=RwJRvyUJ5GutFRyk/Xw6OQJLMc826FJsjecAptdQzp+a+Vr+KwSgmYH7
   gizGGAZLFfoX3SORLWnBPaOAzjwwb7QAHhnc95i/9VUwnHA94lPI7pmQF
   xWMhVtXV6S9Aj+aiIMBCfM6MlgyDDTlA3TXPxfvahEbvy65cMdDxKL7x8
   gHUrGq7hv7OUwEUeGil4XiOsSTa3i4lRYbDtxmK7ETiScQyofDqPqDE61
   TIQZgn3r7zt/349uXHt+DuYrzpJI+FUCMB7AsmpnziEjdJz8gbY4FO0mf
   xC5p6W9ppWLIAGpyv/dNbgvpbblEtKTupAy1Z3UbZZ0ny4n6JUEtH7oKQ
   w==;
X-CSE-ConnectionGUID: BTVUenc0TSSWL6iHhjTxiA==
X-CSE-MsgGUID: CH4ywpRfS+Ob3W66vd+WkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="89799781"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="89799781"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 05:35:09 -0700
X-CSE-ConnectionGUID: SeAzFMQCTMmXEY5UV0t3BQ==
X-CSE-MsgGUID: td/i78DBRKa75JOnhMAI7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="274588110"
Received: from amilburn-desk.amilburn-desk (HELO [10.245.245.139]) ([10.245.245.139])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 05:35:08 -0700
Message-ID: <231f271e-4f57-4d41-905a-9691b9eebe5d@intel.com>
Date: Thu, 7 May 2026 13:35:05 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/xe/dma-buf: fix UAF with retry loop
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>, stable@vger.kernel.org
References: <20260507115519.115309-3-matthew.auld@intel.com>
 <20260507115519.115309-4-matthew.auld@intel.com>
 <c434737c3613a2dff0e2442e89c7ec58640efed4.camel@linux.intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <c434737c3613a2dff0e2442e89c7ec58640efed4.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CE4374E8465
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.auld@intel.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-244563-lists,stable=lfdr.de];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+]
X-Rspamd-Action: no action

On 07/05/2026 13:22, Thomas Hellström wrote:
> On Thu, 2026-05-07 at 12:55 +0100, Matthew Auld wrote:
>> Retry doesn't work here, since bo will be freed on error, leading to
>> UAF. However, now that we do the alloc & init before the attach, we
>> can
>> now combine this as one unit and have the init do the alloc for us.
>> This
>> should make the retry safe.
>>
>> Reported by Sashiko.
>>
>> Closes:
>> https://sashiko.dev/#/patchset/20260506184332.86743-2-matthew.auld%40intel.com
>> Fixes: eb289a5f6cc6 ("drm/xe: Convert xe_dma_buf.c for exhaustive
>> eviction")
>> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: <stable@vger.kernel.org> # v6.18+
> 
> lgtm.
> Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> 
> 
> 
>> ---
>>   drivers/gpu/drm/xe/xe_dma_buf.c | 42 +++++++++----------------------
>> --
>>   1 file changed, 11 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c
>> b/drivers/gpu/drm/xe/xe_dma_buf.c
>> index 2332db502c8b..a54ec278a915 100644
>> --- a/drivers/gpu/drm/xe/xe_dma_buf.c
>> +++ b/drivers/gpu/drm/xe/xe_dma_buf.c
>> @@ -258,16 +258,8 @@ struct dma_buf *xe_gem_prime_export(struct
>> drm_gem_object *obj, int flags)
>>   	return ERR_PTR(ret);
>>   }
>>   
>> -/*
>> - * Takes ownership of @storage: on success it is transferred to the
>> returned
>> - * drm_gem_object; on failure it is freed before returning the
>> error.
>> - * This matches the contract of xe_bo_init_locked() which frees
>> @storage on
>> - * its error paths, so callers need not (and must not) free @storage
>> after
>> - * this call.
>> - */
>>   static struct drm_gem_object *
>> -xe_dma_buf_init_obj(struct drm_device *dev, struct xe_bo *storage,
>> -		    struct dma_buf *dma_buf)
>> +xe_dma_buf_create_obj(struct drm_device *dev, struct dma_buf
>> *dma_buf)
>>   {
>>   	struct dma_resv *resv = dma_buf->resv;
>>   	struct xe_device *xe = to_xe_device(dev);
>> @@ -278,10 +270,8 @@ xe_dma_buf_init_obj(struct drm_device *dev,
>> struct xe_bo *storage,
>>   	int ret = 0;
>>   
>>   	dummy_obj = drm_gpuvm_resv_object_alloc(&xe->drm);
>> -	if (!dummy_obj) {
>> -		xe_bo_free(storage);
>> +	if (!dummy_obj)
>>   		return ERR_PTR(-ENOMEM);
>> -	}
>>   
>>   	dummy_obj->resv = resv;
>>   	xe_validation_guard(&ctx, &xe->val, &exec, (struct
>> xe_val_flags) {}, ret) {
>> @@ -290,8 +280,7 @@ xe_dma_buf_init_obj(struct drm_device *dev,
>> struct xe_bo *storage,
>>   		if (ret)
>>   			break;
>>   
>> -		/* xe_bo_init_locked() frees storage on error */
>> -		bo = xe_bo_init_locked(xe, storage, NULL, resv,
>> NULL, dma_buf->size,
>> +		bo = xe_bo_init_locked(xe, NULL, NULL, resv, NULL,
>> dma_buf->size,
>>   				       0, /* Will require 1way or
>> 2way for vm_bind */
>>   				       ttm_bo_type_sg,
>> XE_BO_FLAG_SYSTEM, &exec);
>>   		drm_exec_retry_on_contention(&exec);
>> @@ -342,7 +331,6 @@ struct drm_gem_object *xe_gem_prime_import(struct
>> drm_device *dev,
>>   	const struct dma_buf_attach_ops *attach_ops;
>>   	struct dma_buf_attachment *attach;
>>   	struct drm_gem_object *obj;
>> -	struct xe_bo *bo;
>>   
>>   	if (dma_buf->ops == &xe_dmabuf_ops) {
>>   		obj = dma_buf->priv;
>> @@ -357,22 +345,14 @@ struct drm_gem_object
>> *xe_gem_prime_import(struct drm_device *dev,
>>   		}
>>   	}
>>   
>> -	bo = xe_bo_alloc();
>> -	if (IS_ERR(bo))
>> -		return ERR_CAST(bo);
>> -
>>   	/*
>> -	 * xe_dma_buf_init_obj() takes ownership of the raw bo, so
>> do not touch
>> -	 * on fail, since it will already take care of cleanup. On
>> success we
>> -	 * still need to drop the ref, if something later fails.
>> -	 *
>> -	 * In addition this needs to happen before the attach, since
>> -	 * it will create a new attachment for this, and add it to
>> the list of
>> -	 * attachments, at which point it is globally visible, and
>> at any point
>> -	 * the export side can call into on invalidate_mappings
>> callback, which
>> -	 * require a working object.
>> +	 * This needs to happen before the attach, since it will
>> create a new
>> +	 * attachment for this, and add it to the list of
>> attachments, at which
>> +	 * point it is globally visible, and at any point the export
>> side can
>> +	 * call into on invalidate_mappings callback, which require
>> a working
>> +	 * object.
>>   	 */
>> -	obj = xe_dma_buf_init_obj(dev, bo, dma_buf);
>> +	obj = xe_dma_buf_create_obj(dev, dma_buf);
> 
> Cant you just use xe_bo_create_novm() here?

Yeah, I tried this out, but it got a bit ugly with the shared dma-resv, 
since I both need to add a new param to novm(), and also tweak the lower 
levels to accept it, which felt a bit too much for a backport. Hmm, okay 
maybe just another patch on top to do that.

> 
> 
>>   	if (IS_ERR(obj))
>>   		return obj;
>>   
>> @@ -382,7 +362,7 @@ struct drm_gem_object *xe_gem_prime_import(struct
>> drm_device *dev,
>>   		attach_ops = test->attach_ops;
>>   #endif
>>   
>> -	attach = dma_buf_dynamic_attach(dma_buf, dev->dev,
>> attach_ops, &bo->ttm.base);
>> +	attach = dma_buf_dynamic_attach(dma_buf, dev->dev,
>> attach_ops, obj);
>>   	if (IS_ERR(attach)) {
>>   		obj = ERR_CAST(attach);
>>   		goto out_err;
>> @@ -393,7 +373,7 @@ struct drm_gem_object *xe_gem_prime_import(struct
>> drm_device *dev,
>>   	return obj;
>>   
>>   out_err:
>> -	xe_bo_put(bo);
>> +	xe_bo_put(gem_to_xe_bo(obj));
>>   
>>   	return obj;
>>   }


