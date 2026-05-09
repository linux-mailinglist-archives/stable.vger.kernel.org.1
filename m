Return-Path: <stable+bounces-244930-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wshrAy77/mlT0wAAu9opvQ
	(envelope-from <stable+bounces-244930-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 11:15:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BFA4FEF51
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 11:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A47A30158B9
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 09:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0735E3914E2;
	Sat,  9 May 2026 09:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZHIvoU4+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A1638AC93
	for <stable@vger.kernel.org>; Sat,  9 May 2026 09:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778318122; cv=none; b=CaXAbHZJVnS3tR51fSWHU3UVzeESjb0fHzbw8JGzupGs8lvqeDcssdmCbVMLUFcL5ElhRBEA67RWnpPsA+kQp+8GLqF0R7C3eefQ/Zjm/tUfsBsYJKIY0u2fVmaHBk92RJlDC5DN7mQQVOGcnVlSsqawcs8xgWIgyFq6OEA9ca8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778318122; c=relaxed/simple;
	bh=9bdbjTFqTI0+biyvb76O1yAIXRHZnWM1s1VhiIQ+Xiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EfmRyeXlBjMBN91oroCRa771Qqxa/7+bk99pOXhTpUs5vFwOWFX3akdK5rcyCuWLUkcxovsqjyBpCPPHJ1sdHnBOtbyOYOmCtULP7+2qXoD4aBbrQPuRTMVMRM3X9pxeIW7yrbyFOYJOKD4502UPhuEh1m+yUNJnRH7gm3wVh0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZHIvoU4+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA75C2BCB2;
	Sat,  9 May 2026 09:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778318122;
	bh=9bdbjTFqTI0+biyvb76O1yAIXRHZnWM1s1VhiIQ+Xiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZHIvoU4+2DVbwi4i+Rd5SEPo3rCMTTKlaib7+xF0/wpsE/djWeQw4haW8j4eY95+x
	 Ar1JibjE7nFugD4vBGLBXvWSqe80C3ftUfDUPrOp5MHv5vt9JGvwRyZc5aqZK553jR
	 uJjGNaeBHlr616oFtiVzBSwUaSMzrh9Z7IxIo4P8=
Date: Sat, 9 May 2026 11:15:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Rion Kiguchi <kiguchi.r.sec@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH v3] staging: vme_user: validate slave window size against
 buffer size
Message-ID: <2026050955-awaken-revise-f2e7@gregkh>
References: <2026050935-designing-glancing-2e16@gregkh>
 <20260509090721.1136091-1-kiguchi.r.sec@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260509090721.1136091-1-kiguchi.r.sec@gmail.com>
X-Rspamd-Queue-Id: 54BFA4FEF51
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-244930-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sat, May 09, 2026 at 06:07:21PM +0900, Rion Kiguchi wrote:
> The VME_SET_SLAVE ioctl in drivers/staging/vme_user/vme_user.c accepts
> a user-controlled slave.size and forwards it to vme_slave_set() without
> comparing it against image[minor].size_buf. The slave-image kernel
> buffer is allocated at probe time with a fixed size of PCI_BUF_SIZE
> (0x20000 / 128 KiB), but the configured VME window size can be made
> much larger via the ioctl.
> 
> The subsequent read() / write() handlers (vme_user_read /
> vme_user_write) clamp the I/O range against vme_get_size(), which
> returns the size the bridge driver has programmed for the window
> (i.e. the attacker-supplied slave.size). vme_get_size() does not
> consult size_buf, so an oversized window passes the existing bounds
> checks, and buffer_to_user() / buffer_from_user() then index
> image[minor].kern_buf with offsets beyond the actual allocation.
> 
> Result: a local user with read/write access to /dev/bus/vme/s* can
> trigger out-of-bounds read and write of the kernel slab adjacent to
> the slave-image buffer.
> 
> Fix: reject slave.size > size_buf in the VME_SET_SLAVE handler.
> With this check in place, the existing bounds checks in
> vme_user_read() / vme_user_write() against vme_get_size() are
> sufficient to prevent OOB access; no additional checks in
> buffer_to_user() / buffer_from_user() are needed.
> 
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Rion Kiguchi <kiguchi.r.sec@gmail.com>
> ---
>  drivers/staging/vme_user/vme_user.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/vme_user/vme_user.c b/drivers/staging/vme_user/vme_user.c
> index 11e25c2f6..6fd051f49 100644
> --- a/drivers/staging/vme_user/vme_user.c
> +++ b/drivers/staging/vme_user/vme_user.c
> @@ -394,6 +394,14 @@ static int vme_user_ioctl(struct inode *inode, struct file *file,
>  				return -EFAULT;
>  			}
>  
> +			/*
> +			 * Reject window sizes larger than the kernel buffer
> +			 * allocated at probe time, otherwise subsequent
> +			 * read/write would access memory beyond kern_buf.
> +			 */
> +			if (slave.size > image[minor].size_buf)
> +				return -EINVAL;
> +
>  			/* XXX	We do not want to push aspace, cycle and width
>  			 *	to userspace as they are
>  			 */
> @@ -401,7 +409,6 @@ static int vme_user_ioctl(struct inode *inode, struct file *file,
>  				slave.enable, slave.vme_addr, slave.size,
>  				image[minor].pci_buf, slave.aspace,
>  				slave.cycle);
> -
>  			break;
>  		}
>  		break;
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

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

