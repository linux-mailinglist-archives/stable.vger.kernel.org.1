Return-Path: <stable+bounces-136496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C23A99EDE
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 04:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A020B5A3D5A
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 02:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D050F35957;
	Thu, 24 Apr 2025 02:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MHWwPe8e"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928A82FB6
	for <stable@vger.kernel.org>; Thu, 24 Apr 2025 02:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745462164; cv=none; b=Fq2lZSazO/3Qv1tahzcJjMtt5a9Kf9IPNAFqFDAjGB6M3zCgeaFB/xN87TAg1CT3g99jsvuUBNSt0G2FDTTJBbqbI1tvJ1dGxTrS38DDQ4DACI8A/hMzUILkCP2lsL8SNdE7/Ct2myUgeiIF/O8tIRlninXEJf0Km8j6f6TCbDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745462164; c=relaxed/simple;
	bh=IFXv9LueD8GivNx4+x6NOlzoL88iQ0Su8QnNIUdsklg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kS2uF9L5UEQszgjZXeRhkb5iHa9e0NHFeVl/vpJ+LaQNXcgkV82eHGD/2RSEpGhrkfxakmIWgy5Zl3vtEZfml7Ztwnaju11IiBkT5pBm534hRXg56Uizg9MBnD3gLqjboUOethz61njazFG4Eoy3CXI0o1p7mYf7ghQZUaiYXA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MHWwPe8e; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745462162; x=1776998162;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IFXv9LueD8GivNx4+x6NOlzoL88iQ0Su8QnNIUdsklg=;
  b=MHWwPe8eyHN3vdvwlT/icjMYw6W16hkWNIzGctNvMjMwS/Bi442OI5xr
   8uA73IYUvfaj90Csb0jKkyRehUXDEdqM6IeGz3XUL4n/QbL6eC1L+LjQ9
   6nYXSVmp7V0AK3BF1HUp2tSjuT/cvqJyag7oUZarugQevoRk6i6wQ2hT4
   jVSHZ3ya+xlvSAf1nCeomoUAzdfCYpgIJ496SFF0v8sJWmjOpRvls2+7k
   DB6d+18vM/u5ylOyM3xr6xrtj0ki9eSs7m4BpBWLiNM8N+SVxPTmLb21b
   9jRVgdULMAzD1Ul6G1i2dwMzQzldZl/CHxIBTzVDxGisuDrLpUiQta8Lj
   g==;
X-CSE-ConnectionGUID: KRqyHxjmRq+SZJ40+TNg+A==
X-CSE-MsgGUID: 4crSDLMhQf6dXrtcXENcBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="46311414"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="46311414"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 19:36:01 -0700
X-CSE-ConnectionGUID: fsmBfNENTpaM7yFQj3EdTw==
X-CSE-MsgGUID: 8HRQyNtESuOHyLOPxjUccA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="169694568"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.124.221.159]) ([10.124.221.159])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 19:36:00 -0700
Message-ID: <7f1c8e94-9be7-4ff7-a2a4-063edce48c96@linux.intel.com>
Date: Wed, 23 Apr 2025 19:35:59 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configfs-tsm-report: Fix NULL dereference of tsm_ops
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc: stable@vger.kernel.org, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Steven Price <steven.price@arm.com>, Sami Mujawar <sami.mujawar@arm.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, Cedric Xing <cedric.xing@intel.com>,
 x86@kernel.org
References: <174544207062.2555330.2729112107050724843.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <174544207062.2555330.2729112107050724843.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/23/25 2:01 PM, Dan Williams wrote:
> Unlike sysfs, the lifetime of configfs objects is controlled by
> userspace. There is no mechanism for the kernel to find and delete all
> created config-items. Instead, the configfs-tsm-report mechanism has an
> expectation that tsm_unregister() can happen at any time and cause
> established config-item access to start failing.
>
> That expectation is not fully satisfied. While tsm_report_read(),
> tsm_report_{is,is_bin}_visible(), and tsm_report_make_item() safely fail
> if tsm_ops have been unregistered, tsm_report_privlevel_store()
> tsm_report_provider_show() fail to check for ops registration. Add the
> missing checks for tsm_ops having been removed.
>
> Now, in supporting the ability for tsm_unregister() to always succeed,
> it leaves the problem of what to do with lingering config-items. The
> expectation is that the admin that arranges for the ->remove() (unbind)
> of the ${tsm_arch}-guest driver is also responsible for deletion of all
> open config-items. Until that deletion happens, ->probe() (reload /
> bind) of the ${tsm_arch}-guest driver fails.
>
> This allows for emergency shutdown / revocation of attestation
> interfaces, and requires coordinated restart.
>
> Fixes: 70e6f7e2b985 ("configfs-tsm: Introduce a shared ABI for attestation reports")
> Cc: stable@vger.kernel.org
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Steven Price <steven.price@arm.com>
> Cc: Sami Mujawar <sami.mujawar@arm.com>
> Cc: Borislav Petkov (AMD) <bp@alien8.de>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reported-by: Cedric Xing <cedric.xing@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---

Looks good to me

Reviewed-by: Kuppuswamy Sathyanarayanan 
<sathyanarayanan.kuppuswamy@linux.intel.com>
>   drivers/virt/coco/tsm.c |   26 +++++++++++++++++++++++++-
>   1 file changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
> index 9432d4e303f1..096f4f7c0c11 100644
> --- a/drivers/virt/coco/tsm.c
> +++ b/drivers/virt/coco/tsm.c
> @@ -15,6 +15,7 @@
>   static struct tsm_provider {
>   	const struct tsm_ops *ops;
>   	void *data;
> +	atomic_t count;
>   } provider;
>   static DECLARE_RWSEM(tsm_rwsem);
>   
> @@ -92,6 +93,10 @@ static ssize_t tsm_report_privlevel_store(struct config_item *cfg,
>   	if (rc)
>   		return rc;
>   
> +	guard(rwsem_write)(&tsm_rwsem);
> +	if (!provider.ops)
> +		return -ENXIO;
> +
>   	/*
>   	 * The valid privilege levels that a TSM might accept, if it accepts a
>   	 * privilege level setting at all, are a max of TSM_PRIVLEVEL_MAX (see
> @@ -101,7 +106,6 @@ static ssize_t tsm_report_privlevel_store(struct config_item *cfg,
>   	if (provider.ops->privlevel_floor > val || val > TSM_PRIVLEVEL_MAX)
>   		return -EINVAL;
>   
> -	guard(rwsem_write)(&tsm_rwsem);
>   	rc = try_advance_write_generation(report);
>   	if (rc)
>   		return rc;
> @@ -115,6 +119,10 @@ static ssize_t tsm_report_privlevel_floor_show(struct config_item *cfg,
>   					       char *buf)
>   {
>   	guard(rwsem_read)(&tsm_rwsem);
> +
> +	if (!provider.ops)
> +		return -ENXIO;
> +
>   	return sysfs_emit(buf, "%u\n", provider.ops->privlevel_floor);
>   }
>   CONFIGFS_ATTR_RO(tsm_report_, privlevel_floor);
> @@ -217,6 +225,9 @@ CONFIGFS_ATTR_RO(tsm_report_, generation);
>   static ssize_t tsm_report_provider_show(struct config_item *cfg, char *buf)
>   {
>   	guard(rwsem_read)(&tsm_rwsem);
> +	if (!provider.ops)
> +		return -ENXIO;
> +
>   	return sysfs_emit(buf, "%s\n", provider.ops->name);
>   }
>   CONFIGFS_ATTR_RO(tsm_report_, provider);
> @@ -421,12 +432,20 @@ static struct config_item *tsm_report_make_item(struct config_group *group,
>   	if (!state)
>   		return ERR_PTR(-ENOMEM);
>   
> +	atomic_inc(&provider.count);
>   	config_item_init_type_name(&state->cfg, name, &tsm_report_type);
>   	return &state->cfg;
>   }
>   
> +static void tsm_report_drop_item(struct config_group *group, struct config_item *item)
> +{
> +	config_item_put(item);
> +	atomic_dec(&provider.count);
> +}
> +
>   static struct configfs_group_operations tsm_report_group_ops = {
>   	.make_item = tsm_report_make_item,
> +	.drop_item = tsm_report_drop_item,
>   };
>   
>   static const struct config_item_type tsm_reports_type = {
> @@ -459,6 +478,11 @@ int tsm_register(const struct tsm_ops *ops, void *priv)
>   		return -EBUSY;
>   	}
>   
> +	if (atomic_read(&provider.count)) {
> +		pr_err("configfs/tsm not empty\n");


Nit: I think adding the provider ops name will make the debug log clear.


> +		return -EBUSY;
> +	}
> +
>   	provider.ops = ops;
>   	provider.data = priv;
>   	return 0;
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


