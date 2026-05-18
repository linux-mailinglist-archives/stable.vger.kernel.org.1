Return-Path: <stable+bounces-249365-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBLhCDFgC2pgGQUAu9opvQ
	(envelope-from <stable+bounces-249365-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 20:53:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72845572766
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 20:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7F42301F30A
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 18:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7C938BF75;
	Mon, 18 May 2026 18:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NKrQEC8t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFEA29D291;
	Mon, 18 May 2026 18:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779130356; cv=none; b=XyoDJEecQkK33kmEwyHxXcy8eAMiPKrCLfoCENDpCoQA0igYwFP9Wu1+jaLIYrVPFU9L7DgZwIJHgQWXFrclNL+X5jqc3wteJp6N7K/N0G4NmYVtLN2bMJPTZbyoKmDOdi0U9wTNwSaoPnLUA3be4/87kuiO6+V3+DaAA6BC724=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779130356; c=relaxed/simple;
	bh=cN9ag78TztArFuWuOfxv3gwdfM668ZkfYAsbDso04QM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FwqpVmnLZ5EGrSzTSKVXdytLxjXNwMM/ztMz6e+6meDCd14E6Hvt5IfQgAdkIK90XOAeJs5mYn1EEVIbBTA0m/7FZw2AJO488/lQ0Cxko2aM5/chMqBqy6JTAYlV/8UGXmipgNoyf1IZxG98DRD55LFjW1ZwSphqjSkNFhQbvO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NKrQEC8t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B40BC2BCB7;
	Mon, 18 May 2026 18:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1779130355;
	bh=cN9ag78TztArFuWuOfxv3gwdfM668ZkfYAsbDso04QM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NKrQEC8tnZ8egVpHpIpp9Jz08rLL85//6lXZrZB2jucv4GOI7pzvnm9nfO9kEuHCR
	 p158b41+axeYauvtuU+V+JCbP5ngWMcFT3Uzq8itjtFnZEnfwqHqfGNq3IVH+sJJ9J
	 HFeF7q/zCzL0U8MS1zj9LaBd8TQabUnYrV5YcQ7E=
Date: Mon, 18 May 2026 20:51:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sebastian Alba Vives <sebasjosue84@gmail.com>
Cc: yilun.xu@linux.intel.com, linux-fpga@vger.kernel.org,
	conor.dooley@microchip.com, mdf@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v7 1/3] fpga: dfl: add bounds check in
 dfh_get_param_size()
Message-ID: <2026051837-aggregate-garnish-ca3c@gregkh>
References: <20260518165218.35388-1-sebasjosue84@gmail.com>
 <20260518165218.35388-2-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518165218.35388-2-sebasjosue84@gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-249365-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 72845572766
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 10:52:16AM -0600, Sebastian Alba Vives wrote:
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
> Fixes: 4747ab89b4a6 ("fpga: dfl: add basic support for DFHv1")
> Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
> ---
> Changes in v7:
>   - Correct the Fixes: tag commit hash (checkpatch).
>     Reported by Xu Yilun.
> Changes in v6:
>   - Rebase onto linux-next. Add cover letter.
>     Suggested by Xu Yilun.
> Changes in v5:
>   - Add blank line after the new bounds check.
>     Suggested by Xu Yilun.
> Changes in v2:
>   - Use (size > max) instead of (size + DFHv1_PARAM_HDR > max).
>     Suggested by Xu Yilun.
> ---
>  drivers/fpga/dfl.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 4087a36a0..4c63c7c85 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -1132,6 +1132,8 @@ static int dfh_get_param_size(void __iomem *dfh_base, resource_size_t max)
>  			return -EINVAL;
>  
>  		size += next * sizeof(u64);
> +		if (size > max)
> +			return -EINVAL;
>  
>  		if (FIELD_GET(DFHv1_PARAM_HDR_NEXT_EOP, v))
>  			return size;
> -- 
> 2.43.0
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

