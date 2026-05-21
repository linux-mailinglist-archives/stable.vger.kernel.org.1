Return-Path: <stable+bounces-253541-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHc/Mb4ND2qSEgYAu9opvQ
	(envelope-from <stable+bounces-253541-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:50:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D9E5A64D5
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64DEE30416E2
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 12:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C647A3C76B8;
	Thu, 21 May 2026 12:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CVfgL+96"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BCF3769FD;
	Thu, 21 May 2026 12:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368336; cv=none; b=lRs+NR1Mqcl1++RJKvZiY2Ffrh9nMXP4V8/B3L6Bm2ufoTDLAOfPz82IrX5PzgsNzAn9G5aV1WbcyQcluYT3RFO4OZrGrVMupk+T6nSkp9n3InurW7LzbcMGzGbI0WolWMnJ0MdzMXXzj/zuG3Z6njPoBIjCyeJLW3HC6A1VsnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368336; c=relaxed/simple;
	bh=UfWN5XE/kLa6+X4DlY9NuHe+pOv8XNTPHIJJojaugxQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sbcqE/22vB4g1lMFhhBbI+UfwCoMLUaNXY9UwW08Z4AY7LRV75GqXyOBGuNghPpCWZGPq+V4AeIyJHhPP40+Msa9+qOvdGhPRY1cwshagVglMijV26mFstU+IT7shJx5CkEs6YsZh1OuFj+iuLmBNz1CJ8MlFkWEOXUofPIqteQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CVfgL+96; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779368335; x=1810904335;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=UfWN5XE/kLa6+X4DlY9NuHe+pOv8XNTPHIJJojaugxQ=;
  b=CVfgL+968/569hHAxkUX/d0+MZsfBntOacqqkVPcz/0NhH2DArRraRe+
   442bhU754PTalU67B0uXrKky4gXW2ebOVzQtaq2dIm43n6lv9ZbuQ1GEy
   AUiMVXcW1LJeScJDmxRH7ForzShMBw4Qs8kZqOdHUi19TpmNDGcmZ/gye
   9xqN6psvgvim0IfQCgf1ho/WxwmqFbsYgR5gebbfdxxXPyBln4I13iCHt
   Xk5Qvv0ZxZ7Rvhl/XLBS2G66gu/Icyq4rL82zT0PibipmZOYMhxaL4xSQ
   cvvruMXP/CCXDWQzNx0vGbjF3liegKmztzwcOlYMaDKjc+v3oeZT9dV/l
   Q==;
X-CSE-ConnectionGUID: l+HI7hC8Q46KemoFT7vDiw==
X-CSE-MsgGUID: eNM/HMuEQl6CZVSrVDqMVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80250774"
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="80250774"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 05:58:55 -0700
X-CSE-ConnectionGUID: LcrBAtmJTB6/Y1Z+vfoa9w==
X-CSE-MsgGUID: 99Ygv6hsQoSac83sYGge4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="264325394"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.98])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 05:58:52 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 21 May 2026 15:58:48 +0300 (EEST)
To: ZhaoJinming <zhaojinming@uniontech.com>
cc: srinivas.pandruvada@linux.intel.com, Hans de Goede <hansg@kernel.org>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    stable@vger.kernel.org
Subject: Re: [PATCH 1/2] platform/x86/intel/tpmi: use cleanup helpers in
 mem_write()
In-Reply-To: <20260521035623.1426374-2-zhaojinming@uniontech.com>
Message-ID: <35a143db-461b-7d2a-2641-4d526bcb4af4@linux.intel.com>
References: <9de7a91f-2dfa-7a99-9580-378c7a044bce@linux.intel.com> <20260521035623.1426374-1-zhaojinming@uniontech.com> <20260521035623.1426374-2-zhaojinming@uniontech.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253541-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,uniontech.com:email]
X-Rspamd-Queue-Id: 18D9E5A64D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 21 May 2026, ZhaoJinming wrote:

> In mem_write(), the temporary array returned by
> parse_int_array_user() must be released on all exit paths.
> Convert the array variable to use cleanup.h scope-based
> cleanup so it is freed automatically on return.
> 
> This also moves the array declaration next to
> parse_int_array_user() as required by cleanup.h usage
> guidelines.

Now you made these much shorter than 72 chars. :-(

> Fixes: 8e0a2fc68ec3 ("platform/x86/intel/tpmi: Use 32 bit aligned address for debugfs mem write")
> Cc: stable@vger.kernel.org
> Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
> ---
>  drivers/platform/x86/intel/vsec_tpmi.c | 25 +++++++++----------------
>  1 file changed, 9 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/vsec_tpmi.c b/drivers/platform/x86/intel/vsec_tpmi.c
> index 16fd7aa41f20..88f14d0ad410 100644
> --- a/drivers/platform/x86/intel/vsec_tpmi.c
> +++ b/drivers/platform/x86/intel/vsec_tpmi.c
> @@ -50,6 +50,7 @@
>  #include <linux/auxiliary_bus.h>
>  #include <linux/bitfield.h>
>  #include <linux/debugfs.h>
> +#include <linux/cleanup.h>
>  #include <linux/delay.h>
>  #include <linux/intel_tpmi.h>
>  #include <linux/intel_vsec.h>
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
> @@ -525,9 +521,6 @@ static ssize_t mem_write(struct file *file, const char __user *userbuf, size_t l
>  unlock_mem_write:
>  	mutex_unlock(&tpmi_dev_lock);
>  
> -exit_write:
> -	kfree(array);
> -
>  	return ret;
>  }
>  
> 

The code change looks okay now.

BUT, please send the next version properly versioned (it "v4" or so in 
it's subject, I think) and in a fresh thread. As is, b4 gets confused 
which patches are the latest version so I cannot apply these with my 
maintainer tools.

-- 
 i.


