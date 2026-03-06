Return-Path: <stable+bounces-223398-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEhWBiNfq2mmcQEAu9opvQ
	(envelope-from <stable+bounces-223398-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 00:11:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F92E2288AB
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 00:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A61B306F3BA
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 23:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A156366831;
	Fri,  6 Mar 2026 23:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FFjX5gS0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E73235F8D1;
	Fri,  6 Mar 2026 23:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772838436; cv=none; b=PV4oB0o5H2IVl83ttHS1epSWXvnzpR+8oWxsHdb42F2e2Gt3jEC9sUomsfx6RrT4mx8cWjz9f1JPeMAqleF/cT2qNIJd7l8bPqqzKkT03YhFP/VSBd0mqycIrs1X7zlw+J6bF+rvzBxOaEUAjMANMiewcYvlXTMXYkadLualjC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772838436; c=relaxed/simple;
	bh=PdHCUukFlxrWW/nddVc5tlezV0SBl4aeJn3BRRZeIO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gi0FLDjifE3I6zbO7FxMHd0V5MASfo0gaavcN2mFGIoOLHrDD8FKsHJ8/NQnPYam+MJktBjcY2i4q4nyQm1cueyFHtj875mGShspDezNu95LPuVGD+qHARKnE+bZPIxDVohQ0WlLJ/TsGhg5sjjlkTkb6O+qLTml8lu9fVCQEHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FFjX5gS0; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772838435; x=1804374435;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PdHCUukFlxrWW/nddVc5tlezV0SBl4aeJn3BRRZeIO8=;
  b=FFjX5gS0ImY+t/ym9UvBYPHijnsbKxPbidFWtw5djtuZsEi86fuzAgKJ
   +q1lbzvt8Yq/qwpfFHgKP6q2UhEsGE1zZXdt2WlLLEj0HXdnq+fYb8kxk
   EWcRLuRrg9L7MnPCiwc0gYa2cDrwIPQqMaWwWisSaVk/Z2nQjnaErlNor
   ckFGml8n/0kt9TNEFRHo/BgWrETFFmGvAx5tawPCyrmE4Zi8Gsnz70T8k
   jdXVrCFQizlizf2Cv9339KBh8GWmL/ljieQLNv7lHxJVsaIORd/1lxdfv
   Uz27vY+/h10DDI7UuxPPoQ1nEHEB1yEuWpxI7kHVBDx8G2C/OPfyZUbx7
   A==;
X-CSE-ConnectionGUID: S8/AXV+UTYCaFBnaTKpvew==
X-CSE-MsgGUID: uUZo+9QzRzuV2rwIt9dGGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="72978267"
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="72978267"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 15:07:14 -0800
X-CSE-ConnectionGUID: ZAF4Po+XSGWmH2iE8lpinA==
X-CSE-MsgGUID: Mrc+AfC2THyIdrmzaO0Brg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="242154765"
Received: from jdoman-mobl3.amr.corp.intel.com (HELO [10.125.109.87]) ([10.125.109.87])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 15:07:13 -0800
Message-ID: <18b6665b-2964-423c-8ba2-b7df28b95d62@intel.com>
Date: Fri, 6 Mar 2026 16:07:11 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvdimm/bus: Fix potential use after free in asynchronous
 initialization
To: Ira Weiny <ira.weiny@intel.com>, nvdimm@lists.linux.dev,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dingisoul <dingiso.kernel@gmail.com>
References: <20260306-fix-uaf-async-init-v1-1-a28fd7526723@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260306-fix-uaf-async-init-v1-1-a28fd7526723@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6F92E2288AB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223398-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.984];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Action: no action



On 3/6/26 11:33 AM, Ira Weiny wrote:
> Dingisoul with KASAN reports a use after free if device_add() fails in
> nd_async_device_register().
> 
> Commit b6eae0f61db2 ("libnvdimm: Hold reference on parent while
> scheduling async init") correctly added a reference on the parent device
> to be held until asynchronous initialization was complete.  However, if
> device_add() results in an allocation failure the ref count of the
> device drops to 0 prior to the parent pointer being accessed.  Thus
> resulting in use after free.
> 
> The bug bot AI correctly identified the fix.  Save a reference to the
> parent pointer to be used to drop the parent reference regardless of the
> outcome of device_add().
> 
> Reported-by: Dingisoul <dingiso.kernel@gmail.com>
> Closes: http://lore.kernel.org/8855544b-be9e-4153-aa55-0bc328b13733@gmail.com
> Fixes: b6eae0f61db2 ("libnvdimm: Hold reference on parent while scheduling async init")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/nvdimm/bus.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
> index bd9621d3f73c..45b7d756e39a 100644
> --- a/drivers/nvdimm/bus.c
> +++ b/drivers/nvdimm/bus.c
> @@ -486,14 +486,15 @@ EXPORT_SYMBOL_GPL(nd_synchronize);
>  static void nd_async_device_register(void *d, async_cookie_t cookie)
>  {
>  	struct device *dev = d;
> +	struct device *parent = dev->parent;
>  
>  	if (device_add(dev) != 0) {
>  		dev_err(dev, "%s: failed\n", __func__);
>  		put_device(dev);
>  	}
>  	put_device(dev);
> -	if (dev->parent)
> -		put_device(dev->parent);
> +	if (parent)
> +		put_device(parent);
>  }
>  
>  static void nd_async_device_unregister(void *d, async_cookie_t cookie)
> 
> ---
> base-commit: c107785c7e8dbabd1c18301a1c362544b5786282
> change-id: 20260306-fix-uaf-async-init-3697998d8faf
> 
> Best regards,
> --  
> Ira Weiny <ira.weiny@intel.com>
> 


