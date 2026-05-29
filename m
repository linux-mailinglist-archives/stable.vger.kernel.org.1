Return-Path: <stable+bounces-256619-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CcEKGWGGWouxQgAu9opvQ
	(envelope-from <stable+bounces-256619-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 14:28:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1D460241A
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 14:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 61836302739D
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 12:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8447B3BA24F;
	Fri, 29 May 2026 12:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qwh7z1YN"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7941236AB7C
	for <stable@vger.kernel.org>; Fri, 29 May 2026 12:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780057434; cv=none; b=B2f6SvIPHpaF8WC4R9SXQH/1rt0PEP7e9mUpZUwallT/EvdIMnLrHCbIiSTBeri8VEfjNyqREacNZsBFLK8T2UpFAxXuhPtD5ARYQR7SqsiNYthLnmDEc+3x3E0B+zXN29FjZ/hBQ48H6SXJc1r+LQJhf8UfreLYXUI4r5QR9/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780057434; c=relaxed/simple;
	bh=fDrEew63oKedZYzWJjWxYyWisAICIOrMMrTYw4gEUeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PQtGHo75EbyZmllvuqPp6bzBjJyer5vX4wNe83aiaYSJ5XGsS7Wq3B5OGZXoxrRMFLb7ewrPZhQDuEzigv3EBMSmdtl4GNYs6w6ndapB12m06Qjw3EbnD1B5GJi+dgZfunuRhNk36KIw5igVQpUyyYy5N4usIaY1glf5EtHccTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qwh7z1YN; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780057432; x=1811593432;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fDrEew63oKedZYzWJjWxYyWisAICIOrMMrTYw4gEUeA=;
  b=Qwh7z1YNoe1iZBCyxSBpBeZ3UC3SAzSmMGM+oom0X1TI1vCYVU5BgQG+
   cwwkBAtJiUd91LfDxtQ4t/dTi5B8XxF6IFqtFVgBHZkmo+EsoiD3JIV9J
   C0nUbMX4P844ckviVZnuBr/vF9z8fwWPke8udLoWeXOufa7dFwQoqkQCB
   Mhm/nuCaWQ12cIruic0uAChkCniud2H5XNIFDlV1CaskiHjd34JYe50yY
   JSeYMbP/G1hFJTHhR0+V8Cq1IVY7AUikp4mcVp5pzg3c5Os8t2ymnJCP3
   m3sWuufoBb1OHGg/CuD/Sfh1YBLdIGtDWUWHGTqQlecnB8VCXmn+rL5Jh
   w==;
X-CSE-ConnectionGUID: nJzgD7r0Q8a4fz3FODKIxg==
X-CSE-MsgGUID: G+LlJc4fTCOkm9ZFNy8BCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="80634668"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="80634668"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 05:23:49 -0700
X-CSE-ConnectionGUID: pZLvH75iQ/Kj7tE+ncKrRA==
X-CSE-MsgGUID: Al7sdM+RTQ2Zjc7FpR6YAQ==
X-ExtLoop1: 1
Received: from mgoluns-desk.ger.corp.intel.com (HELO [10.245.80.25]) ([10.245.80.25])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 05:23:47 -0700
Message-ID: <8cd98877-6535-4ca4-8c96-88c136a2dac1@linux.intel.com>
Date: Fri, 29 May 2026 14:23:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Add buffer overflow check in MS
 get_info_ioctl
To: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 dawid.osuchowski@linux.intel.com, stable@vger.kernel.org
References: <20260529120841.135852-1-andrzej.kacprowski@linux.intel.com>
Content-Language: en-US
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
In-Reply-To: <20260529120841.135852-1-andrzej.kacprowski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,oss.qualcomm.com,amd.com,linux.intel.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-256619-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[karol.wachowski@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: CD1D460241A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 29-May-26 14:08, Andrzej Kacprowski wrote:
> Add validation that the info size returned from the metric stream info
> query is not exceeded when checked against the allocated buffer size.
> If the firmware returns a size larger than the buffer, reject the
> operation with -EOVERFLOW instead of proceeding with an incorrect
> buffer copy.
> 
> Fixes: cdfad4db7756 ("accel/ivpu: Add NPU profiling support")
> Cc: <stable@vger.kernel.org> # v6.18+
> Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>

Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>

> ---
>   drivers/accel/ivpu/ivpu_ms.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/accel/ivpu/ivpu_ms.c b/drivers/accel/ivpu/ivpu_ms.c
> index be43851f5f32..cd176e77b9a0 100644
> --- a/drivers/accel/ivpu/ivpu_ms.c
> +++ b/drivers/accel/ivpu/ivpu_ms.c
> @@ -291,6 +291,13 @@ int ivpu_ms_get_info_ioctl(struct drm_device *dev, void *data, struct drm_file *
>   	if (ret)
>   		goto unlock;
>   
> +	if (info_size > ivpu_bo_size(bo)) {
> +		ivpu_warn_ratelimited(vdev, "MS info overflow: %#llx > %#zx\n",
> +				      info_size, ivpu_bo_size(bo));
> +		ret = -EOVERFLOW;
> +		goto unlock;
> +	}
> +
>   	if (args->buffer_size < info_size) {
>   		ret = -ENOSPC;
>   		goto unlock;


