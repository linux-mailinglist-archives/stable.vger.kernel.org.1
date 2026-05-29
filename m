Return-Path: <stable+bounces-256620-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yK5ONWeHGWqdxQgAu9opvQ
	(envelope-from <stable+bounces-256620-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 14:32:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 567256024BF
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 14:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49F5B3084312
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 12:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B771B2641EE;
	Fri, 29 May 2026 12:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uq95sogn"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7D71946DA
	for <stable@vger.kernel.org>; Fri, 29 May 2026 12:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780057657; cv=none; b=t1Tq6T6rk06eWhr+/nFw1noWLSw+NeMslNGc2py5PYD8tLEeW2BkGhwldm+3cN3Pn+5aXBmBFAVUWvSiCl3E8qyyCBDxeZ5ojps7BtKKW800ibJv64uyBuNJrkrJ12A198pnsGHLcQfprADymQdDE4qM0HD7rS2maRYriekiIMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780057657; c=relaxed/simple;
	bh=CXuqIZDWCLi9QpcPkAQ/R27XriGKsnNHkBqh657t6Do=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DCdOgIosC5MmEN0I12J9Ca9TJpU1r1Tpb3bKl2Mz3/86IZRZI4yadEOIuZnvnAtrl2xAWK7TF/xkuNXXcXiqw89TM/eBFF6MI9LXvc3EvtLXH7wG4GsPq62qzvvS7KBMBHzxsbcuYyLkf7VkXEKGGI8KCTiQuOn+JC5pNNTaLIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uq95sogn; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780057655; x=1811593655;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CXuqIZDWCLi9QpcPkAQ/R27XriGKsnNHkBqh657t6Do=;
  b=Uq95sognb9+N/9K+MvXKe8i4FRBlpu0SUm430jh1wPhxkhKJ6UT6uvmc
   1zbduQ46uJDEBB+7wGn7zMCS447GEKkMRiHqAFIKOXfLlTvWQg9sP7ykQ
   zs7ZzLKpKtbNxySDJvh6dWpJhqCRzG8bxFv2ZbNAsUznlP8eolzUKS5+N
   A2ONtKVU36k8kfYtUpHidBEQXDqh9HHR66OJ0mH2VNykU1tNteClCI+fn
   1QAnjBJViAMO1oEhoZxo2l7uhdPEDsr2H2WloFZi66tK0dAoeXWR386Rp
   IgG8JrX8RIFZ6HjhlBDVZHF7zYl9UH0cidn0JwiqF62mBJDMm+YXVRhto
   g==;
X-CSE-ConnectionGUID: oKJavN+KSn2LlSW46FfZoQ==
X-CSE-MsgGUID: 0TjLODi6R5GuTLPUB6u4ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="80634925"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="80634925"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 05:27:35 -0700
X-CSE-ConnectionGUID: ztCH4yb9SK203vJ193d+XA==
X-CSE-MsgGUID: Hkhc2gMUQS6R6Vf4U8QtKw==
X-ExtLoop1: 1
Received: from mgoluns-desk.ger.corp.intel.com (HELO [10.245.80.25]) ([10.245.80.25])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 05:27:33 -0700
Message-ID: <fcad21ec-ebeb-41af-a94a-b31120fa945a@linux.intel.com>
Date: Fri, 29 May 2026 14:27:29 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Add bounds check for firmware runtime memory
To: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 dawid.osuchowski@linux.intel.com, stable@vger.kernel.org
References: <20260529120853.135876-1-andrzej.kacprowski@linux.intel.com>
Content-Language: en-US
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
In-Reply-To: <20260529120853.135876-1-andrzej.kacprowski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,oss.qualcomm.com,amd.com,linux.intel.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-256620-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[karol.wachowski@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,linux.intel.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 567256024BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 29-May-26 14:08, Andrzej Kacprowski wrote:
> Validate that the firmware runtime memory specified in the image
> header is properly aligned and sized to hold the firmware image.
> This prevents errors during memory allocation and image transfer.
> 
> Fixes: 2007e210b6a1 ("accel/ivpu: Split FW runtime and global memory buffers")
> Cc: <stable@vger.kernel.org> # v7.0+
> Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>

Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>

> ---
>   drivers/accel/ivpu/ivpu_fw.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/accel/ivpu/ivpu_fw.c b/drivers/accel/ivpu/ivpu_fw.c
> index 107f8ad31050..33c50779c06b 100644
> --- a/drivers/accel/ivpu/ivpu_fw.c
> +++ b/drivers/accel/ivpu/ivpu_fw.c
> @@ -259,6 +259,22 @@ static int ivpu_fw_parse(struct ivpu_device *vdev)
>   		return -EINVAL;
>   	}
>   
> +	if (!PAGE_ALIGNED(runtime_addr)) {
> +		ivpu_err(vdev, "Runtime address 0x%llx not page aligned\n", runtime_addr);
> +		return -EINVAL;
> +	}
> +
> +	if (!PAGE_ALIGNED(runtime_size)) {
> +		ivpu_err(vdev, "Runtime size %llu not page aligned\n", runtime_size);
> +		return -EINVAL;
> +	}
> +
> +	if (runtime_size < image_size) {
> +		ivpu_err(vdev, "Runtime size too small: %llu, image size: %llu\n",
> +			 runtime_size, image_size);
> +		return -EINVAL;
> +	}
> +
>   	if (!ivpu_is_within_range(image_load_addr, image_size, &vdev->hw->ranges.runtime)) {
>   		ivpu_err(vdev, "Invalid firmware load address: 0x%llx and size %llu\n",
>   			 image_load_addr, image_size);


