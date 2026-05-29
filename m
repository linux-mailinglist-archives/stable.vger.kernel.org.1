Return-Path: <stable+bounces-256611-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFH0J66AGWrVxAgAu9opvQ
	(envelope-from <stable+bounces-256611-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 14:03:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAC7601F70
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 14:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 999AD3018A2C
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 12:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50053DEFF8;
	Fri, 29 May 2026 12:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m+SgjH+v"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B243DB312
	for <stable@vger.kernel.org>; Fri, 29 May 2026 12:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780056231; cv=none; b=PiBnVMspc2/wHuP/DGRE4UdXG7PIqJUJ0NUN8AjbR719a5KL54AsEdTQEPGtxM9h+4XCCHG8y5YqpsybCDgzJXKA5lhnxwSdycDliSP2e0BesHJxjZ5+OxVgHnntRP/2g3pZ4oFHXNIqIK38vQWeLc350i0cxpAg3GvYEFj+p+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780056231; c=relaxed/simple;
	bh=ghM0U831hKCdDL+dTygEhGz4xGBPcfucNQVi/sbfTzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HCB9T/XSNUa7WWVdQ+uAN5okLPWSBJUVNx+oe4cN2U5l7g7tMjsVMgvcvgQWH8AbGmucNGvZsbfhuBGg2rFlkFTxHx7VWFnlHmdNBBIdIzo0hGlWABGKB+Ud9DS285L+MpoBmd+rdXcjVbhByiKQqhc2QFFq0bhqRp2s3bpu3WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m+SgjH+v; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780056231; x=1811592231;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ghM0U831hKCdDL+dTygEhGz4xGBPcfucNQVi/sbfTzg=;
  b=m+SgjH+vOuJJdDO0RwnQyeFRgE8YBjsbpiHsb/hxf4fwEVdSQ7SxuH59
   raNG5GQCh473KTS6JWMQwr7i8DBopQQF7R9B9KJHvJsq5uc5x4ysZRWeR
   zxjO+lcIBUyTB54VbhSLTTxg2amI+sTeTwb7vtEJa5UMSd8rF9FixD86U
   AMUByhFMlLeiO91wL5ZM3OTtwmbrQLvBukyjDAVhX7TzX7BFwtGGbUlBL
   DFdmZWfae2XDOfxbLzAM6k2CiBkPmKZC4cJ5/oATVPxL9GLTceXWsxjoz
   qAJNtA/b/Y593kHCSOzaznTWWUW+M6Eeq9Z3DdFnnUogN3tghEOXiE9zx
   Q==;
X-CSE-ConnectionGUID: q9tlzNLwReyotRAm648aBg==
X-CSE-MsgGUID: nTcbJYMoT0q0OgOkl97WpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="92380816"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="92380816"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 05:03:50 -0700
X-CSE-ConnectionGUID: ByWMDaHgS9e7kTtdJWvmKw==
X-CSE-MsgGUID: OtqxAANFR52hyHAy8NIIzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="266704016"
Received: from mgoluns-desk.ger.corp.intel.com (HELO [10.245.80.25]) ([10.245.80.25])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 05:03:47 -0700
Message-ID: <cf9be472-0d8c-4103-b2c3-345765e7594e@linux.intel.com>
Date: Fri, 29 May 2026 14:03:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Fix signed integer truncation in IPC receive
To: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 dawid.osuchowski@linux.intel.com, stable@vger.kernel.org
References: <20260529115453.132291-1-andrzej.kacprowski@linux.intel.com>
Content-Language: en-US
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
In-Reply-To: <20260529115453.132291-1-andrzej.kacprowski@linux.intel.com>
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
	TAGGED_FROM(0.00)[bounces-256611-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,intel.com:email,intel.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9FAC7601F70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 29-May-26 13:54, Andrzej Kacprowski wrote:
> Fix potential buffer overflow where firmware-supplied data_size is cast
> to signed int before being used in min_t(). Large unsigned values
> (>= 0x80000000) become negative, causing unsigned wraparound and
> oversized memcpy operations that can overflow the stack buffer.
> 
> Change min_t(int, ...) to min_t(u32, ...) to ensure large values are
> properly clamped instead of becoming negative.
> 
> Fixes: 3b434a3445ff ("accel/ivpu: Use threaded IRQ to handle JOB done messages")
> Cc: <stable@vger.kernel.org> # v6.18+
> Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>

Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>

> ---
>   drivers/accel/ivpu/ivpu_ipc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/ivpu/ivpu_ipc.c b/drivers/accel/ivpu/ivpu_ipc.c
> index f47df092bb0d..9980a7898bed 100644
> --- a/drivers/accel/ivpu/ivpu_ipc.c
> +++ b/drivers/accel/ivpu/ivpu_ipc.c
> @@ -276,7 +276,7 @@ int ivpu_ipc_receive(struct ivpu_device *vdev, struct ivpu_ipc_consumer *cons,
>   	if (ipc_buf)
>   		memcpy(ipc_buf, rx_msg->ipc_hdr, sizeof(*ipc_buf));
>   	if (rx_msg->jsm_msg) {
> -		u32 size = min_t(int, rx_msg->ipc_hdr->data_size, sizeof(*jsm_msg));
> +		u32 size = min_t(u32, rx_msg->ipc_hdr->data_size, sizeof(*jsm_msg));
>   
>   		if (rx_msg->jsm_msg->result != VPU_JSM_STATUS_SUCCESS) {
>   			ivpu_err(vdev, "IPC resp result error: %d\n", rx_msg->jsm_msg->result);


