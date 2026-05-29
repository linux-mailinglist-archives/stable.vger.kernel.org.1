Return-Path: <stable+bounces-256612-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBiRLjyBGWrVxAgAu9opvQ
	(envelope-from <stable+bounces-256612-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 14:06:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF9D601FB9
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 14:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C093F300370C
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 12:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17193D8900;
	Fri, 29 May 2026 12:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W0B/zdLV"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8163D3DEACE
	for <stable@vger.kernel.org>; Fri, 29 May 2026 12:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780056375; cv=none; b=Jx9n5JsTnQtNd4OU3OKHhLOaTkpGzXvgVEg8yMLVKzf/yf+Nb4uexaChOyGTKs8Ho0GM09V1pphsZYnE4k4nKE7krH6vEY425Q3chks0K533ZtzXLyoSNcJTzza5nLBGOsjeYOsHjpB4UpUaeJs6wDC1mLVJ3d6PQTKwtM0+ysA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780056375; c=relaxed/simple;
	bh=AY7YLc7DM7Bur7kuFzTZdDbr2bQsNDaW897mAT11cMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TI51kSfQbIEz8wyEZLD1ve37Z1o1SergCAvouChyjt0fJbvCiUr6rGkE8HBLNxKXG9v5IddeJgsEWN6QIO1aYyt+cXWRKSFcTdj02+KLsGRDkpMEpzRhz09TwTE683Mc2UAyMLw+qMIkkMh9xog04qafPOgPiTVj11bnYkOgIFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W0B/zdLV; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780056375; x=1811592375;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AY7YLc7DM7Bur7kuFzTZdDbr2bQsNDaW897mAT11cMU=;
  b=W0B/zdLVcXvvrmLwQqPJoTpbhETAO6g/Cggitgsim20Ahr6ugbzWqVL3
   saXrhMOZ7lMrgGsZOg6MnDplugKjV3ef8VaeX4vsC1wm62fHqPxqv+Cuf
   thIhr30WpzghOmNBCdHPooKX0b4VMXUUC74bAKItPXs2y5FIasPxVse3y
   VN6VpMJjTCi/g0QwT/B00fJ9CEP9fT0t/0vjeD72PoIv7xtmNIaBh+BQP
   5Lo6yNg9rsiJN/mB30ITUuYDAykVgyPOymkG6Yllkmsc/49wJHtEzbuui
   bK/VXmJfLe7+LUQDvNBwY6p95as07hdz2YQwJKmWNDMffJgEA1wUxIOHU
   Q==;
X-CSE-ConnectionGUID: zjtMJL2/RjWT+Rl2Y6+LMA==
X-CSE-MsgGUID: IX4p0Fh0S0GG/7lSL/38zA==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="92381113"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="92381113"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 05:06:14 -0700
X-CSE-ConnectionGUID: YRAgIjD/Sz2ZK8Nhy9urJA==
X-CSE-MsgGUID: aenAzjgCSAaHZE90gAoT2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="266704778"
Received: from mgoluns-desk.ger.corp.intel.com (HELO [10.245.80.25]) ([10.245.80.25])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 05:06:12 -0700
Message-ID: <9c0b071d-efd0-4b89-9e75-78b8355d90d4@linux.intel.com>
Date: Fri, 29 May 2026 14:06:09 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Add bounds checks for firmware log indices
To: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 dawid.osuchowski@linux.intel.com, stable@vger.kernel.org
References: <20260529115842.135378-1-andrzej.kacprowski@linux.intel.com>
Content-Language: en-US
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
In-Reply-To: <20260529115842.135378-1-andrzej.kacprowski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,oss.qualcomm.com,amd.com,linux.intel.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-256612-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[karol.wachowski@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.intel.com:mid,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: AEF9D601FB9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 29-May-26 13:58, Andrzej Kacprowski wrote:
> Add validation that read and write indices in the firmware log buffer
> are within valid bounds (< data_size) before using them. If
> out-of-bounds indices are encountered (from firmware), clamp them to
> safe values instead of proceeding with invalid offsets.
> 
> This prevents potential out-of-bounds buffer access when firmware
> supplies invalid log indices.
> 
> Fixes: 1fc1251149a7 ("accel/ivpu: Refactor functions in ivpu_fw_log.c")
> Cc: <stable@vger.kernel.org> # v6.18+
> Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>

Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>

> ---
>   drivers/accel/ivpu/ivpu_fw_log.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/accel/ivpu/ivpu_fw_log.c b/drivers/accel/ivpu/ivpu_fw_log.c
> index 337c906b0210..275baf844b56 100644
> --- a/drivers/accel/ivpu/ivpu_fw_log.c
> +++ b/drivers/accel/ivpu/ivpu_fw_log.c
> @@ -98,6 +98,11 @@ static void fw_log_print_buffer(struct vpu_tracing_buffer_header *log, const cha
>   	u32 log_start = only_new_msgs ? READ_ONCE(log->read_index) : 0;
>   	u32 log_end = READ_ONCE(log->write_index);
>   
> +	if (log_start >= data_size)
> +		log_start = 0;
> +	if (log_end > data_size)
> +		log_end = data_size;
> +
>   	if (log->wrap_count == log->read_wrap_count) {
>   		if (log_end <= log_start) {
>   			drm_printf(p, "==== %s \"%s\" log empty ====\n", prefix, log->name);


