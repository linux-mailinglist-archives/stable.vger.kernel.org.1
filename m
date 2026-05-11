Return-Path: <stable+bounces-245258-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBeUFpz9AWppnAEAu9opvQ
	(envelope-from <stable+bounces-245258-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 18:02:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE571511BD9
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 18:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 31CEB311F93D
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 15:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABF9407591;
	Mon, 11 May 2026 15:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="La+ttmjw"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605893FD152;
	Mon, 11 May 2026 15:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778514146; cv=none; b=QoiRJ5Z9I3kXdNiOJt2NSqtnwRbP1+ms2BS+hbBZswt6EsIOIk0D556KHc4ctHU69GfCetetscZaesVY/F5JdmSl4lqZ4FmBy3SwkrEL3XDGQvHOYBITlK8qH6XuczTz8CwcKhZkK+83MAxcd3wDanZYdj864lYpldVJ6K7GJv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778514146; c=relaxed/simple;
	bh=5xkwwt0IhI1fL6Su+oxiTo0tOlXF+xjkOAnP7BUrFgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=myUtDXetlJaqho+XWCQ6I12RtwVZvRWY9ZbTBGArp26DPqlXDwYwI2VMsdkGkqR7C3dFCdROJMEXkw7lzSEEOzo0DPAikfs+UnI6YNuqyBUzGRpTKlmTcVhgAvAdKYwEXnoSOaX0rxjknNJIuF7AEhRVVdyn7LmkpoqbHivhlJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=La+ttmjw; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778514146; x=1810050146;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5xkwwt0IhI1fL6Su+oxiTo0tOlXF+xjkOAnP7BUrFgQ=;
  b=La+ttmjw4rHtAUNYZ3BSrqtzcCZee15LJ2pY35Iy6AmCk4q/WQTaftbp
   n+fQiwDti+maAUn0jG/miHeTo16rRHO778ATyZThmCXGffsmEo8d88JGu
   vVB/JYYxO72ivLNdsBEVqWSAv2XT195hE1jcWgW6DF7DVXBf3jMpIu3ns
   h+Sw4Or8AX7GwuXMXaVo0nQLhdwSH8zFjN79liZFX9VTaUE6Uiwdv2HlE
   PWWGOU/Xc08nODStHLZP/Oirj9gE9emMcjrpl+7Rfwr+NGPJPYAolwBWc
   LXvBxjuNBmk++3uH0rbEeXMuUjuP+AH2Q+2V0iBpuels23F06BWIwj98H
   w==;
X-CSE-ConnectionGUID: aAWbd3RmS9GUNvilqtXmDg==
X-CSE-MsgGUID: Z7Ew5BY5QWCCyHYECRx9Uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="96969690"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="96969690"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 08:42:17 -0700
X-CSE-ConnectionGUID: uDQDU3tDS7ySpzg9MsqqGA==
X-CSE-MsgGUID: eDrwlhyITL2Mto68flGG3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="237443700"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa008.jf.intel.com with ESMTP; 11 May 2026 08:42:15 -0700
Date: Mon, 11 May 2026 23:19:06 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Sebastian Alba Vives <sebasjosue84@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-fpga@vger.kernel.org,
	conor.dooley@microchip.com, mdf@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v5 1/3] fpga: dfl: add bounds check in
 dfh_get_param_size()
Message-ID: <agHzavPSk2XJp775@yilunxu-OptiPlex-7050>
References: <20260504121332.1053563-1-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504121332.1053563-1-sebasjosue84@gmail.com>
X-Rspamd-Queue-Id: CE571511BD9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245258-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yilun.xu@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 04, 2026 at 06:13:30AM -0600, Sebastian Alba Vives wrote:
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
> Changes in v5:
>   - Add blank line after the new bounds check.
>     Suggested by Xu Yilun.
> Changes in v4:
>   - Resubmit as full series per maintainer request.
> Changes in v2:
>   - Use (size > max) instead of (size + DFHv1_PARAM_HDR > max).
>     Suggested by Xu Yilun.
> ---
>  drivers/fpga/dfl.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 81d7a68..4c63c7c 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -1134,6 +1134,7 @@ static int dfh_get_param_size(void __iomem *dfh_base, resource_size_t max)
>  		size += next * sizeof(u64);
>  		if (size > max)
>  			return -EINVAL;
> +

Hey, please provide a patch that can apply to linux-next. I can do
nothing to your series. Please read Documentation/process/ before
submit.

Also, please make a cover-letter (Patch #0) when you make the patch
series.

>  		if (FIELD_GET(DFHv1_PARAM_HDR_NEXT_EOP, v))
>  			return size;
>  	}
> -- 
> 2.43.0
> 

