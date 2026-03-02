Return-Path: <stable+bounces-222717-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPSOC2wBpmmfIwAAu9opvQ
	(envelope-from <stable+bounces-222717-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 22:30:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADEE1E30E0
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 22:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7A293441AF1
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 21:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE998385527;
	Mon,  2 Mar 2026 20:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KcUMyNvO"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01505367F3C
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 20:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772484307; cv=none; b=W797zFd0+bzmQxOBn4ncMc4UJuk7WT+l7qXNh5NzAhzTo9dWPpuWO2pHeUH+LqEf0wdHXgewlvucrJBDZ7FLC3qOpckbv+SGaqaszSBKvSvAbKw0iwlV/fymYR8Uio8osUEeEDFS43/47Rbr52KUljV0OZDU82eKQ2FPNrY0J5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772484307; c=relaxed/simple;
	bh=9I2+mEPa7NxCRX220PgjQYU72fVD3rhhW2qohLXitZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WjltQQdqdwjAZKAEIKIGtb9Cljabo+dtRaMxV9e7IJuHVxpMj965glsA5NxTsghVPHXJZpf5zHfKnpyJKdm1af/KtODCqDNs8VGZtAycA9JS6b+kaIMNPQ5qZO+3Lowvnf/ZML3Nk6i9ZpaWvJ3Ykh8IRIQxWvwVegwhvfO1FCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KcUMyNvO; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772484305; x=1804020305;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9I2+mEPa7NxCRX220PgjQYU72fVD3rhhW2qohLXitZ8=;
  b=KcUMyNvOc2yfdrbcqbIQogCDuor3Avba3jWTH8aDc5m+2GeozXtoZYL2
   2f6Pm4MDzWMEIRyNbEFXst0v3UjYyFsslEj9LT0rNZXxjMhs74rW08ja+
   gKBpGO+tm6CgMtzpQTYcGOzwksJzUGN4Nz2tAkG7RLg5zeXgheTDx7SyQ
   Egj5gF8BTXk0xx87NJxDtwoX2w1DbRSx5l9E2r8vhO9zeSOv8JEGHtTa3
   20wJElH6EzMrotXZye4abijCqVsPQFyNUjhM0vnNNmO0O2wYT+78VdvcV
   dGEX/iDJov696maV7MEeAxooJksxHVGWWBjnQwHoD63EiNeZfv75uwU2H
   Q==;
X-CSE-ConnectionGUID: CiXe3PMUQM+Hl2j08M6k1A==
X-CSE-MsgGUID: IL1vssk7TOq++NEFYIutJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="72534791"
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="72534791"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 12:45:04 -0800
X-CSE-ConnectionGUID: kuYd4bT9RpmbHfOAadWY4Q==
X-CSE-MsgGUID: h1aLMEPQRMay/MOFwmW7pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="215362053"
Received: from unknown (HELO [10.241.241.198]) ([10.241.241.198])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 12:45:04 -0800
Message-ID: <6569e4c4-1d60-40cc-b9f2-9bf0b0c0441c@linux.intel.com>
Date: Mon, 2 Mar 2026 12:44:58 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe/xe2_hpg: Correct implementation of Wa_16025250150
To: Matt Roper <matthew.d.roper@intel.com>, intel-xe@lists.freedesktop.org
Cc: Aradhya Bhatia <aradhya.bhatia@intel.com>,
 Tejas Upadhyay <tejas.upadhyay@intel.com>, stable@vger.kernel.org
References: <20260227164341.3600098-2-matthew.d.roper@intel.com>
Content-Language: en-US
From: Ngai-Mint Kwan <ngai-mint.kwan@linux.intel.com>
In-Reply-To: <20260227164341.3600098-2-matthew.d.roper@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9ADEE1E30E0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-222717-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ngai-mint.kwan@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email]
X-Rspamd-Action: no action

Hi Matt,

On 2026-02-27 08:43, Matt Roper wrote:
> Wa_16025250150 asks us to set five register fields of the register to
> 0x1 each.  However we were just OR'ing this into the existing register
> value (which has a default of 0x4 for each nibble-sized field) resulting
> in final field values of 0x5 instead of the desired 0x1.  Correct the
> RTP programming (use FIELD_SET instead of SET) to ensure each field is
> assigned to exactly the value we want.
>
> Cc: Aradhya Bhatia <aradhya.bhatia@intel.com>
> Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>
> Cc: <stable@vger.kernel.org> # v6.16+
> Fixes: 7654d51f1fd8 ("drm/xe/xe2hpg: Add Wa_16025250150")
> Signed-off-by: Matt Roper <matthew.d.roper@intel.com>

This looks good to me.

Reviewed-by: Ngai-Mint Kwan <ngai-mint.kwan@linux.intel.com>

Thanks,
Ngai-Mint Kwan

> ---
>   drivers/gpu/drm/xe/xe_wa.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/xe/xe_wa.c b/drivers/gpu/drm/xe/xe_wa.c
> index 26950b8a7543..183c5c86c35a 100644
> --- a/drivers/gpu/drm/xe/xe_wa.c
> +++ b/drivers/gpu/drm/xe/xe_wa.c
> @@ -249,12 +249,13 @@ static const struct xe_rtp_entry_sr gt_was[] = {
>   
>   	{ XE_RTP_NAME("16025250150"),
>   	  XE_RTP_RULES(GRAPHICS_VERSION(2001)),
> -	  XE_RTP_ACTIONS(SET(LSN_VC_REG2,
> -			     LSN_LNI_WGT(1) |
> -			     LSN_LNE_WGT(1) |
> -			     LSN_DIM_X_WGT(1) |
> -			     LSN_DIM_Y_WGT(1) |
> -			     LSN_DIM_Z_WGT(1)))
> +	  XE_RTP_ACTIONS(FIELD_SET(LSN_VC_REG2,
> +				   LSN_LNI_WGT_MASK | LSN_LNE_WGT_MASK |
> +				   LSN_DIM_X_WGT_MASK | LSN_DIM_Y_WGT_MASK |
> +				   LSN_DIM_Z_WGT_MASK,
> +				   LSN_LNI_WGT(1) | LSN_LNE_WGT(1) |
> +				   LSN_DIM_X_WGT(1) | LSN_DIM_Y_WGT(1) |
> +				   LSN_DIM_Z_WGT(1)))
>   	},
>   
>   	/* Xe3_LPG */


