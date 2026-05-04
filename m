Return-Path: <stable+bounces-243001-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPAsG6WK+Gl+wQIAu9opvQ
	(envelope-from <stable+bounces-243001-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 14:01:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1A04BCB75
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 14:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4EC7303181F
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 12:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A42C3C660C;
	Mon,  4 May 2026 12:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bWSxx+8w"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390B13C73F6;
	Mon,  4 May 2026 12:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777896019; cv=none; b=CiNerVecXVGsg0S+ljLGk1vqD0IAgAORDP+FySg8jfUltJC0CVRwrk8oZJNyGhzNeFePBYwq5KUEQfusXTKKoL2YMGsemL/ogCSBbFLeBRp54pvWh2PT27osUYtL/M7zfZJoLAYq9aUE9/20B1QZs+Z1Ji5p6j1anXxg0k8llHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777896019; c=relaxed/simple;
	bh=5KQnnvpLs2kRk2hShgf0dtzYCKkXuy92iY9XBGVZAKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+dcr7vJ22IZZAtVm5uQCUHlzMRq53bK0he4djdrrVBdu8XjXM2E7yOrbyl93Av1WsaJpk1iYOXsOmQYihm0d3KQ86KuuKG80JTx6Qg+QvrALRvFhvf6zNWWwOLqsd9T9N4eK78cYW1vn32dOEE5uhFGg2tTd0jyq6kyxDXxw4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bWSxx+8w; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777896014; x=1809432014;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5KQnnvpLs2kRk2hShgf0dtzYCKkXuy92iY9XBGVZAKk=;
  b=bWSxx+8wQ+wtSiJFv+PsKbDhUpuZLWCQ7agSc4gggeryFCDN94pf0ms5
   h3aySig+T0DQqMgqHCPQaF3ab6xrBpjWD00fApT3akBKJU7oVD1mkv6AX
   jrNTcBXEB5O6hdn4VyvAcn4VQxQ9kCbTfIv8yrmbifEbZqkLXA5bsA63b
   d+k/r9vS4AmpYqbNQs+wtsyhr0dV/xma2kN6IXCwu5huD1Sku3SYbZRdV
   4O4zlZtriWLKqkYc5k0MTXsw8R4r42c/8F6OsyRz6hIa6zPagzY9VJ5xZ
   yvCt+J9n7bSeYNP0R21csFdJpVu3mtXRmzLLn3VjUPqlaqiAGhOCIocz3
   g==;
X-CSE-ConnectionGUID: DVyhZUW4QoOyY79C5+iIZg==
X-CSE-MsgGUID: niBS2Ff3ScS4pgnKaF9qFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="78943134"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="78943134"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 05:00:08 -0700
X-CSE-ConnectionGUID: FC3TFhvFSpepvKVhKsbDhQ==
X-CSE-MsgGUID: J8PrAzbITribWHXyds1nbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="237274768"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa004.fm.intel.com with ESMTP; 04 May 2026 05:00:05 -0700
Date: Mon, 4 May 2026 19:37:17 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Sebastian Alba Vives <sebasjosue84@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-fpga@vger.kernel.org,
	conor.dooley@microchip.com, mdf@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4 1/3] fpga: dfl: add bounds check in
 dfh_get_param_size()
Message-ID: <afiE7f1R6YN/Qo0h@yilunxu-OptiPlex-7050>
References: <20260407172230.40775-1-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407172230.40775-1-sebasjosue84@gmail.com>
X-Rspamd-Queue-Id: 0C1A04BCB75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243001-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yilun.xu@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim]

On Tue, Apr 07, 2026 at 11:22:15AM -0600, Sebastian Alba Vives wrote:
> dfh_get_param_size() can return a parameter size larger than the feature
> region because the loop bounds check is evaluated before incrementing
> size. If the EOP (End of Parameters) bit is set in the same iteration,
> the inflated size is returned without re-validation against max.
> 
> This can cause create_feature_instance() to call memcpy_fromio() with a
> size exceeding the ioremap'd region when a malicious FPGA device provides
> crafted DFHv1 parameter headers.
> 
> Add a bounds check after the size increment to ensure the accumulated
> size never exceeds the feature boundary.
> 
> Fixes: a80a4b2b2e4f ("fpga: dfl: add support for DFHv1")
> Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
> ---
> Changes in v4:
>   - Resubmit as full series per maintainer request.
> Changes in v2:
>   - Use (size > max) instead of (size + DFHv1_PARAM_HDR > max).
>     The previous check unnecessarily guarded against the next parameter
>     header, which is not relevant at this point in the loop.
>     Suggested by Xu Yilun.
> ---
>  drivers/fpga/dfl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 4087a36..81d7a68 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -1132,7 +1132,8 @@ static int dfh_get_param_size(void __iomem *dfh_base, resource_size_t max)
>  			return -EINVAL;
>  
>  		size += next * sizeof(u64);
> -
> +		if (size > max)
> +			return -EINVAL;

I'd prefer a blank line here.

>  		if (FIELD_GET(DFHv1_PARAM_HDR_NEXT_EOP, v))
>  			return size;
>  	}
> -- 
> 2.43.0
> 
> 

