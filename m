Return-Path: <stable+bounces-249804-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MG5/LY6PDWoIzQUAu9opvQ
	(envelope-from <stable+bounces-249804-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 12:40:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CBC58BE21
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 12:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5BEB8304AC20
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 10:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8E73AF641;
	Wed, 20 May 2026 10:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ILgFKeaZ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2637B2E92B3;
	Wed, 20 May 2026 10:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779273454; cv=none; b=TEgYgnjjy0I5VkVSa03mhDnu3hHSiZ1KglRtF2oLhKUyuPP1gmq5ia+ZN6ULRCyJJhUAGWF1+8D3oWf4R/W6Qp005JMI1ipU3tPYL8CiABxUM5fOBt0ybACxkaZ77gyifEZm8WRINx1uaMshIzeZjO2YdT+cqsVBkjrFEG4iGJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779273454; c=relaxed/simple;
	bh=uWZpbSqdF0Glgyt4dchwz+eQwccfAQiF4/g/zF76HAM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Lp/Ee0XddfkFyKSdtRgazmPy134ssxWKkszFzaAFc/EGfO1ceuCcktJcsNFY1HrWwNckUb5H1srj5HBkLbj7I6BcHuxWv2wmd2XNtcsmxgZAJ5J7ytQdfu88XhTOTlX2ajjrNJvKWK3hwSL3S4sScQzmvE76csvyaHgqDVMCxuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ILgFKeaZ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779273453; x=1810809453;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=uWZpbSqdF0Glgyt4dchwz+eQwccfAQiF4/g/zF76HAM=;
  b=ILgFKeaZIZcxm36pt46CsO+Pqofv74oBnW1Qf5i6RE/Cadjph/4HkGjM
   GLzewtMU1xtynJcmY+aTEM1aCmogyF07A1NgV88DSm44EfjqDgOeDi2nt
   zVe5ny49tO36wbjFbdoxYdbkKw6Sc5QWtb3q5D0kIPc1OxyV+aRMHNqml
   WVXeFAOWiJUxKRx9r3OTTno38SIzrD/NAVHlLxt/Kg+5aojJXl04jv7TI
   e0rrhUzsGKeUxuw1JnvWGE4QtQXES1xsWrkznyZ/4vPTNStS8Mb9GdUsu
   r5gIloKCaO0uSGRh4zDrSm1+G7bqHB364blQXsQhSlQAJSSCwKinnGioX
   w==;
X-CSE-ConnectionGUID: LYXWaAl0S4ub3fJErMiLAg==
X-CSE-MsgGUID: BgNbQlqWQD+4T3no2cvyyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="91561576"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="91561576"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 03:37:33 -0700
X-CSE-ConnectionGUID: jdQd7bv5TPupaulGhBhWbA==
X-CSE-MsgGUID: ILG0gVETSJmUKPvVbSHfdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="235695239"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.181])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 03:37:30 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 20 May 2026 13:37:26 +0300 (EEST)
To: ZhaoJinming <zhaojinming@uniontech.com>
cc: srinivas.pandruvada@linux.intel.com, Hans de Goede <hansg@kernel.org>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    stable@vger.kernel.org
Subject: Re: [PATCH 1/2] platform/x86/intel/tpmi: use cleanup helpers in
 mem_write()
In-Reply-To: <20260520054122.1630021-2-zhaojinming@uniontech.com>
Message-ID: <9de7a91f-2dfa-7a99-9580-378c7a044bce@linux.intel.com>
References: <b1006ce4-f596-b2aa-421a-518fe3cfe1f0@linux.intel.com> <20260520054122.1630021-1-zhaojinming@uniontech.com> <20260520054122.1630021-2-zhaojinming@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249804-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.intel.com:mid,intel.com:dkim,uniontech.com:email]
X-Rspamd-Queue-Id: 77CBC58BE21
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 20 May 2026, ZhaoJinming wrote:

> In mem_write(), the temporary array returned by parse_int_array_user() must be released on all error paths. Convert the array variable to use cleanup.h scope-based cleanup so it is freed automatically on return.

Not only on "error paths" but also when no error occurs.

> This also moves the array declaration next to parse_int_array_user() as required by cleanup.h usage guidelines.

Please fold any text paragraphs so they don't exceed 72 characters per 
row.

> Fixes: 8e0a2fc68ec3 ("platform/x86/intel/tpmi: Use 32 bit aligned address for debugfs mem write")
> Cc: stable@vger.kernel.org
> Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
> ---
>  drivers/platform/x86/intel/vsec_tpmi.c | 26 +++++++++-----------------
>  1 file changed, 9 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/vsec_tpmi.c b/drivers/platform/x86/intel/vsec_tpmi.c
> index 16fd7aa41f20..e7bc3474c7aa 100644
> --- a/drivers/platform/x86/intel/vsec_tpmi.c
> +++ b/drivers/platform/x86/intel/vsec_tpmi.c
> @@ -51,6 +51,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/debugfs.h>
>  #include <linux/delay.h>
> +#include <linux/cleanup.h>
>  #include <linux/intel_tpmi.h>
>  #include <linux/intel_vsec.h>
>  #include <linux/io.h>
> @@ -473,7 +474,7 @@ static ssize_t mem_write(struct file *file, const char __user *userbuf, size_t l
>  	struct seq_file *m = file->private_data;
>  	struct intel_tpmi_pm_feature *pfs = m->private;
>  	u32 addr, value, punit, size;
> -	u32 num_elems, *array;
> +	u32 num_elems;
>  	void __iomem *mem;
>  	int ret;
>  
> @@ -481,15 +482,14 @@ static ssize_t mem_write(struct file *file, const char __user *userbuf, size_t l
>  	if (!size)
>  		return -EIO;
>  
> +	u32 *array __free(kfree) = NULL;
>  	ret = parse_int_array_user(userbuf, len, (int **)&array);
>  	if (ret < 0)
>  		return ret;
>  
>  	num_elems = *array;
> -	if (num_elems != 3) {
> -		ret = -EINVAL;
> -		goto exit_write;
> -	}
> +	if (num_elems != 3)
> +		return -EINVAL;
>  
>  	punit = array[1];
>  	addr = array[2];
> @@ -498,15 +498,11 @@ static ssize_t mem_write(struct file *file, const char __user *userbuf, size_t l
>  	if (!IS_ALIGNED(addr, sizeof(u32)))
>  		return -EINVAL;
>  
> -	if (punit >= pfs->pfs_header.num_entries) {
> -		ret = -EINVAL;
> -		goto exit_write;
> -	}
> +	if (punit >= pfs->pfs_header.num_entries)
> +		return -EINVAL;
>  
> -	if (addr >= size) {
> -		ret = -EINVAL;
> -		goto exit_write;
> -	}
> +	if (addr >= size)
> +		return -EINVAL;
>  
>  	mutex_lock(&tpmi_dev_lock);
>  
> @@ -522,12 +518,8 @@ static ssize_t mem_write(struct file *file, const char __user *userbuf, size_t l
>  
>  	ret = len;
>  
> -unlock_mem_write:

The last goto is only removed in the second patch so this will cause a 
build failure mid-series which would be a problem when using git bisect.

Other than that, this change looked okay.

>  	mutex_unlock(&tpmi_dev_lock);
>  
> -exit_write:
> -	kfree(array);
> -
>  	return ret;
>  }
>  
> 

-- 
 i.


