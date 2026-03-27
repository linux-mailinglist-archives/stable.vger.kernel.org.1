Return-Path: <stable+bounces-230688-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNkiE120xmmgNwUAu9opvQ
	(envelope-from <stable+bounces-230688-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 17:46:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A413F347AF1
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 17:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2463931C5C3D
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 16:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE4235C1B5;
	Fri, 27 Mar 2026 16:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WVwFT3Uk"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3072F1EB5FD;
	Fri, 27 Mar 2026 16:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774628887; cv=none; b=nCwX3pg/MKq7Kb+dNXE4UdqnsdiDi0v2ZDgTwMvZl2NWOXsRKB3ys2Tk3wope/VPKmD7c/wNp/iWGroqmePKBrt78bIGsAX7Y2AGC51nqsPhRrN8AUsgXxI+PY5i9Jkse26/r0VOzwc7hLo1K83umMpX7ZFrOP/T9jrtN2uExCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774628887; c=relaxed/simple;
	bh=SrWPints0vHGYHWyPjQHx90+UPQQEFjUU6Wx7ybHNCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GWdTWgjhXOrG5gWOWIt75zsoWPMdXczQrtspZvKvuzWB87jDN21eOm5TvcmhDiwxiItzByaplJaw2wAjuRymuu0eYnIm0iViBMSRas5JduA+sRG/JQjD54YM/mFnKf0/+t4FOBtBgwA+paAyVFaRN2zq+GVFQf2P9MVOcqW/er0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WVwFT3Uk; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774628886; x=1806164886;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SrWPints0vHGYHWyPjQHx90+UPQQEFjUU6Wx7ybHNCA=;
  b=WVwFT3UknHktYmTf6mDlPVFHQzFsB+n9E+1UtWdmo+Yf6v2UMFF/VILo
   hY9iLnCiXiMXAVpz8XbuYG7xJf/abYtJ1VN56Lu4pEdLk4s9zXaBV6lKO
   kUaYWIByTEENXvDIqZxSZYBUfXWbFzeG19n16JLxY/b2ysSeUJPSxBg4z
   95h/shwSz6i8AnGtxd3hoFCxvJaBCHL0jmgW64BRjOWs/V3eAi+e2BSsG
   q1UrauMSWruiY8XFSEWY18wH9MpmWpuKd3i8Kqrq2fr9CtFycA44AMk8i
   QlQrVjOU03hHDK7KOOUBHqTkyuPsPgjfkrEW1vMDthzc6IKq/E8V7nyIN
   w==;
X-CSE-ConnectionGUID: zfcZnkRsRluY9t29ixb7Pw==
X-CSE-MsgGUID: iScAQm9EQg+IZvZ77CoE5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="101164638"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="101164638"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 09:28:06 -0700
X-CSE-ConnectionGUID: I2iv5+elRe63QVWojFX58Q==
X-CSE-MsgGUID: z4Sf5YEUQ9SY46Mwe0Oxsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="218742875"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.110.180]) ([10.125.110.180])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 09:28:05 -0700
Message-ID: <d1cf65bc-7c0f-4f17-9c22-418a2f6df367@intel.com>
Date: Fri, 27 Mar 2026 09:28:04 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] cxl/region: Fix use-after-free from auto assembly
 failure
To: Dan Williams <dan.j.williams@intel.com>
Cc: patches@lists.linux.dev, linux-cxl@vger.kernel.org,
 alison.schofield@intel.com, Smita.KoralahalliChannabasappa@amd.com,
 stable@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20260327052821.440749-1-dan.j.williams@intel.com>
 <20260327052821.440749-2-dan.j.williams@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260327052821.440749-2-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8
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
	TAGGED_FROM(0.00)[bounces-230688-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: A413F347AF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/26/26 10:28 PM, Dan Williams wrote:
> The following crash signature results from region destruction while an
> endpoint decoder is staged, but not fully attached.
> 
> ---
>  BUG: KASAN: slab-use-after-free in __cxl_decoder_detach+0x724/0x830 [cxl_core]
>  Read of size 8 at addr ffff888265638840 by task modprobe/1287
> 
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x68/0x90
>   print_report+0x170/0x4e2
>   kasan_report+0xc2/0x1a0
>   __cxl_decoder_detach+0x724/0x830 [cxl_core]
>   cxl_decoder_detach+0x6c/0x100 [cxl_core]
>   unregister_region+0x88/0x140 [cxl_core]
>   devres_release_all+0x172/0x230
> ---
> 
> The "staged" state is established by cxl_region_attach_auto() and finalized
> by cxl_region_attach_position(). When that is finalized a memdev removal
> event will destroy regions before endpoint decoders. However, in the
> interim the memdev removal will falsely assume that the endpoint decoder is
> unattached. Later, the eventual region removal finds the stale pointer to
> the now freed endpoint decoder.
> 
> Introduce CXL_DECODER_STATE_AUTO_STAGED and cxl_cancel_auto_attach() to
> cleanup this interim state.
> 
> Fixes: a32320b71f08 ("cxl/region: Add region autodiscovery")
> Cc: <stable@vger.kernel.org>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>  drivers/cxl/cxl.h         |  6 +++--
>  drivers/cxl/core/region.c | 54 ++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 57 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 9b947286eb9b..30a31968f266 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -378,12 +378,14 @@ struct cxl_decoder {
>  };
>  
>  /*
> - * Track whether this decoder is reserved for region autodiscovery, or
> - * free for userspace provisioning.
> + * Track whether this decoder is free for userspace provisioning, reserved for
> + * region autodiscovery, whether it is started connecting (awaiting other
> + * peers), or has completed auto assembly.
>   */
>  enum cxl_decoder_state {
>  	CXL_DECODER_STATE_MANUAL,
>  	CXL_DECODER_STATE_AUTO,
> +	CXL_DECODER_STATE_AUTO_STAGED,
>  };
>  
>  /**
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index f7b20f60ac5c..b72556c1458b 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1064,6 +1064,14 @@ static int cxl_rr_ep_add(struct cxl_region_ref *cxl_rr,
>  
>  	if (!cxld->region) {
>  		cxld->region = cxlr;
> +
> +		/*
> +		 * Now that cxld->region is set the intermediate staging state
> +		 * can be cleared.
> +		 */
> +		if (cxld == &cxled->cxld &&
> +		    cxled->state == CXL_DECODER_STATE_AUTO_STAGED)
> +			cxled->state = CXL_DECODER_STATE_AUTO;
>  		get_device(&cxlr->dev);
>  	}
>  
> @@ -1805,6 +1813,7 @@ static int cxl_region_attach_auto(struct cxl_region *cxlr,
>  	pos = p->nr_targets;
>  	p->targets[pos] = cxled;
>  	cxled->pos = pos;
> +	cxled->state = CXL_DECODER_STATE_AUTO_STAGED;
>  	p->nr_targets++;
>  
>  	return 0;
> @@ -2154,6 +2163,47 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  	return 0;
>  }
>  
> +static int cxl_region_by_target(struct device *dev, const void *data)
> +{
> +	const struct cxl_endpoint_decoder *cxled = data;
> +	struct cxl_region_params *p;
> +	struct cxl_region *cxlr;
> +
> +	if (!is_cxl_region(dev))
> +		return 0;
> +
> +	cxlr = to_cxl_region(dev);
> +	p = &cxlr->params;
> +	return p->targets[cxled->pos] == cxled;
> +}
> +
> +/*
> + * When an auto-region fails to assemble the decoder may be listed as a target,
> + * but not fully attached.
> + */
> +static void cxl_cancel_auto_attach(struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_region_params *p;
> +	struct cxl_region *cxlr;
> +	int pos = cxled->pos;
> +
> +	if (cxled->state != CXL_DECODER_STATE_AUTO_STAGED)
> +		return;
> +
> +	struct device *dev __free(put_device) = bus_find_device(
> +		&cxl_bus_type, NULL, cxled, cxl_region_by_target);
> +	if (!dev)
> +		return;
> +
> +	cxlr = to_cxl_region(dev);
> +	p = &cxlr->params;
> +
> +	p->nr_targets--;
> +	cxled->state = CXL_DECODER_STATE_AUTO;
> +	cxled->pos = -1;
> +	p->targets[pos] = NULL;
> +}
> +
>  static struct cxl_region *
>  __cxl_decoder_detach(struct cxl_region *cxlr,
>  		     struct cxl_endpoint_decoder *cxled, int pos,
> @@ -2177,8 +2227,10 @@ __cxl_decoder_detach(struct cxl_region *cxlr,
>  		cxled = p->targets[pos];
>  	} else {
>  		cxlr = cxled->cxld.region;
> -		if (!cxlr)
> +		if (!cxlr) {
> +			cxl_cancel_auto_attach(cxled);
>  			return NULL;
> +		}
>  		p = &cxlr->params;
>  	}
>  


