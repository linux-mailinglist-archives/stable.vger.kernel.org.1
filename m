Return-Path: <stable+bounces-28582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B28886312
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 23:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1F0A1F23DFF
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 22:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EA413792E;
	Thu, 21 Mar 2024 22:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j0n8hnEz"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37008136980
	for <stable@vger.kernel.org>; Thu, 21 Mar 2024 22:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711059067; cv=none; b=ioiX8NFIbHdgref3QMNRMiHdeGVcaGhmvBuQ5wvzf/ytk02uCi7k8u3Y1AMiCVaSc99tmNKdy/7qtAwp5Llx3O7ADgKamSkqvYPMZjJ8fNxELRcBxutHEVx9y1NWc0oF5fMCqACW+xEfG84C/ztpvGH73mNLA5Sw4maNpfZbsV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711059067; c=relaxed/simple;
	bh=pKjKl9i5c93gXnY/iwtL/e7AMNd9og0/gIVEjmydyD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K+TWTeVBxMAvdSrXEawFW8XhvNcuhewX2zHdsdaUaloE+WZvjnEVPhsir6g8sy5XXz8SARREUB4lSINf3YiuAjXxAg/+n1jWEf9D6NAzB2I8SwBX8azMTfpcioUkLR1cveWBcwe0eEk9iSoZU1BzpUcGvHzSc6NP/XLL5Dm9CXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j0n8hnEz; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711059066; x=1742595066;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pKjKl9i5c93gXnY/iwtL/e7AMNd9og0/gIVEjmydyD8=;
  b=j0n8hnEze0NWy97vAMWq0XF6GPPPcjiYIdRFCrLWjNs7/RgEpNFQgmRo
   W22KEOqB9LzeD4LwIy1Oo53fdJpim268Z8FQFMQDRpkpHSdphARGRtjKQ
   IXUg3C8eVQk98+OBuvOn3Oc8SJJWHSKoT2RKqqPns/+4aFeUaHOselJU3
   ZTCLfa9IXIy3x9nF/WYln2SsXFtW8HnSKlnfC7j1vMC0w21kej/CmSc1b
   7odrF/lvncrdNNWKZoQsFynrE6VvbVne7sJ9imvCkZ2EFzOO4DoRMKgcV
   CID5xXzeoTJQqwVFdRVY5UNtYjg4otgCehG93RIVpOLDCeVcq+XL28GW3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="31525157"
X-IronPort-AV: E=Sophos;i="6.07,144,1708416000"; 
   d="scan'208";a="31525157"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 15:11:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,144,1708416000"; 
   d="scan'208";a="52112652"
Received: from nirmoyda-mobl.ger.corp.intel.com (HELO [10.246.36.15]) ([10.246.36.15])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 15:11:02 -0700
Message-ID: <674ea24b-b7a0-477b-bd04-f951c5581d3d@linux.intel.com>
Date: Thu, 21 Mar 2024 23:11:00 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/i915/gt: Report full vm address range
To: Andi Shyti <andi.shyti@linux.intel.com>,
 intel-gfx <intel-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>
Cc: Andi Shyti <andi.shyti@kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Chris Wilson <chris.p.wilson@linux.intel.com>,
 Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
 Michal Mrozek <michal.mrozek@intel.com>, Nirmoy Das <nirmoy.das@intel.com>,
 stable@vger.kernel.org
References: <20240321151726.207866-1-andi.shyti@linux.intel.com>
Content-Language: en-US
From: Nirmoy Das <nirmoy.das@linux.intel.com>
In-Reply-To: <20240321151726.207866-1-andi.shyti@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andi,

On 3/21/2024 4:17 PM, Andi Shyti wrote:
> Commit 9bb66c179f50 ("drm/i915: Reserve some kernel space per
> vm") has reserved an object for kernel space usage.
>
> Userspace, though, needs to know the full address range.
>
> In the former patch the reserved space was substructed from the
> total amount of the VM space. Add it back when the user requests
> the GTT size through ioctl (I915_CONTEXT_PARAM_GTT_SIZE).
>
> Fixes: 9bb66c179f50 ("drm/i915: Reserve some kernel space per vm")
> Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
> Cc: Andrzej Hajda <andrzej.hajda@intel.com>
> Cc: Chris Wilson <chris.p.wilson@linux.intel.com>
> Cc: Lionel Landwerlin <lionel.g.landwerlin@intel.com>
> Cc: Michal Mrozek <michal.mrozek@intel.com>
> Cc: Nirmoy Das <nirmoy.das@intel.com>
> Cc: <stable@vger.kernel.org> # v6.2+
> Acked-by: Michal Mrozek <michal.mrozek@intel.com>
> Acked-by: Lionel Landwerlin <lionel.g.landwerlin@intel.com>
> ---
> Hi,
>
> Just proposing a different implementation that doesn't affect
> i915 internally but provides the same result. Instead of not
> substracting the space during the reservation, I add it back
> during the ioctl call.
>
> All the "vm->rsvd.vma->node.size" looks a bit ugly,

Yes, this need document and also vm->total should be vm->total and may 
be we should have

vm->usable which will be used by kernel internal and return vm->total.

For me, I am fine with the kernel change as long as UMD is aware/fine of 
side-effect if

UMD ended up using the reserved page. Basically we need to document this 
well :)

Also may be we should limit this reserving page only on platform where 
it is required ?


Regards,

Nirmoy

>   but that's
> how it is. Maybe a comment can help to understand better why
> there is this addition.
>
> I kept the Ack from Michal and Lionel, because the outcome from
> userspace perspactive doesn't really change.
>
> Andi
>
>   drivers/gpu/drm/i915/gem/i915_gem_context.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/drm/i915/gem/i915_gem_context.c
> index 81f65cab1330..60d9e7fe33b3 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
> @@ -2454,7 +2454,7 @@ int i915_gem_context_getparam_ioctl(struct drm_device *dev, void *data,
>   	case I915_CONTEXT_PARAM_GTT_SIZE:
>   		args->size = 0;
>   		vm = i915_gem_context_get_eb_vm(ctx);
> -		args->value = vm->total;
> +		args->value = vm->total + vm->rsvd.vma->node.size;
>   		i915_vm_put(vm);
>   
>   		break;

