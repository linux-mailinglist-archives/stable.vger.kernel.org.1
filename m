Return-Path: <stable+bounces-247200-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIuWKfDHBWrDbAIAu9opvQ
	(envelope-from <stable+bounces-247200-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 15:02:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3808F542121
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 15:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E3FE301A1FC
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 13:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1409A2773C3;
	Thu, 14 May 2026 13:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SH6sGKX8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB93318A6CF;
	Thu, 14 May 2026 13:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778763728; cv=none; b=mkF9i0BEyk1QN7gU9MHC7MzPAf5re5CL6xWJ4+ZHw0/vus0wgNYwyPp1Ykt8/nnjzAqYZRhT8/9GfObOpQ2GJbPitZuxoS+ojlTVOexxwAUF0jrkxQsJ4aTTEuZiBqF98YQ22Box8KQPYdQhwuk2IgX2BVIZSgYDNXN1wZDAfy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778763728; c=relaxed/simple;
	bh=6XkcIGEtELfy3FNPsRMpEtSIdSkCha1v4oFloaN5a2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRkcXz/0S2QnWxk+tlGn0qbgl6rsFZ+9O/kME6d+lL2MVHjRArPUqX3HLXNmz3ot0HxHjBtEAYOYG3H0zKZae6EU61AQauD1+d/QLrPFBE5xssOl3eEnhpaXkvLROO662Po7c1Feg/bNTotNonEqW33sm7WzS8vowTZZUI2tHHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SH6sGKX8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F8CC2BCB3;
	Thu, 14 May 2026 13:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778763728;
	bh=6XkcIGEtELfy3FNPsRMpEtSIdSkCha1v4oFloaN5a2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SH6sGKX8F7y134uKrqajCxGs00yhXlupBiuPqzVIUY36b/thUbq9Z21AkAvVUCz/1
	 DYaZoMbeTIMQngQ/t6kQnkyY90yRlBGAWBF08CXB/kw0DXsGLRkOvUp0Vj6+Fz4oX6
	 4QQOFrS4Qb2Is1u7tQKJIBMa3deSDa3h4XZbMrFw=
Date: Thu, 14 May 2026 15:02:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Yuriy Havrylyuk <yhavry@gmail.com>
Subject: Re: [PATCH] nvme-apple: Reset q->sq_tail during queue init
Message-ID: <2026051400-concert-cartridge-e96b@gregkh>
References: <20260514-nvme-apple-sq-reset-v1-1-8931e455281e@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514-nvme-apple-sq-reset-v1-1-8931e455281e@gmail.com>
X-Rspamd-Queue-Id: 3808F542121
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247200-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,jannau.net,gompa.dev,kernel.dk,lst.de,grimberg.me,lists.linux.dev,lists.infradead.org,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 08:54:59PM +0800, Nick Chan wrote:
> Fixes controller reset on Apple A11 / T8015.
> 
> Fixes: 04d8ecf37b5e ("nvme: apple: Add Apple A11 support")
> Suggested-by: Yuriy Havrylyuk <yhavry@gmail.com>
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---
>  drivers/nvme/host/apple.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
> index 423c9c628e7b..c692fc73babf 100644
> --- a/drivers/nvme/host/apple.c
> +++ b/drivers/nvme/host/apple.c
> @@ -1009,6 +1009,7 @@ static void apple_nvme_init_queue(struct apple_nvme_queue *q)
>  	unsigned int depth = apple_nvme_queue_depth(q);
>  	struct apple_nvme *anv = queue_to_apple_nvme(q);
>  
> +	q->sq_tail = 0;
>  	q->cq_head = 0;
>  	q->cq_phase = 1;
>  	if (anv->hw->has_lsq_nvmmu)
> 
> ---
> base-commit: 5d6919055dec134de3c40167a490f33c74c12581
> change-id: 20260514-nvme-apple-sq-reset-53e22e88c7b0
> 
> Best regards,
> -- 
> Nick Chan <towinchenmi@gmail.com>
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

