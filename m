Return-Path: <stable+bounces-233322-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OTIAdMW0mktTQcAu9opvQ
	(envelope-from <stable+bounces-233322-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 10:01:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A63B39DC0E
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 10:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61FC93009B0F
	for <lists+stable@lfdr.de>; Sun,  5 Apr 2026 08:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55056340DB8;
	Sun,  5 Apr 2026 08:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uFHE7f/A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E42A3043DB;
	Sun,  5 Apr 2026 08:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775376078; cv=none; b=RZzXdGk1WFmbCzQINsZSMAWf9NN5kQS7V4LUEmkmz+drPrkXnVLVcNeQjttZQ/nJiCYEjmubk4r1d3KdMjK3VncVxUNOpw9R0RGC1B/YMUEXk5TOi+Fu0HaglNlxihxmaGVWcFnJxhnyJSE0afpUdWm6tkrMHGc9tokxzCUXrxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775376078; c=relaxed/simple;
	bh=AatU60ODGbDZPeHi6KBKgNc9oe17XkVYz0/6mGzQnEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMj++F3FvaYm8TQ+koGt+S8WQuKB8ciTZAc5jc19E5uL6RlulsCTotNn/t6g22xRKldtec9PDNrtcC8jxS/inZHsOtRgpY/WafDG0bId3mx4Bz/IDS+i64GT53J1CAAPZSM9Kova9z1DKKXjO3ZRv6Sz+BmFPS77iNlveyKBirE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uFHE7f/A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444C2C116C6;
	Sun,  5 Apr 2026 08:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775376077;
	bh=AatU60ODGbDZPeHi6KBKgNc9oe17XkVYz0/6mGzQnEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uFHE7f/A6VCoSydGTBSqp2KE5abifESOypue7YJEu14WC0R3S989xBns+AK7x2FvW
	 m/0jg70jmtDEwlf1KDrBQIu1X2uXqoS/VU1CiN7efpC/UkAPirevYGfq/aVKhw6sGL
	 yZVqROy0wPBh5x2uPcTRist/vcH0fhZWpTiWYkvc=
Date: Sun, 5 Apr 2026 10:01:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Delene Tchio Romuald <delenetchior1@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8723bs: fix integer underflow in TKIP MIC
 verification
Message-ID: <2026040501-subheader-tried-87e4@gregkh>
References: <20260404225752.61297-1-delenetchior1@gmail.com>
 <20260404235522.72483-1-delenetchior1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260404235522.72483-1-delenetchior1@gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233322-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 5A63B39DC0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 05, 2026 at 12:55:22AM +0100, Delene Tchio Romuald wrote:
> In recvframe_chkmic(), datalen is computed as:
> 
>   datalen = len - hdrlen - iv_len - icv_len - 8;
> 
> All operands are unsigned, so if the frame is shorter than the sum of
> header, IV, ICV, and MIC lengths, the subtraction wraps to a very
> large value. This corrupted datalen is then passed to
> rtw_seccalctkipmic() and used as a pointer offset, leading to
> out-of-bounds reads on kernel heap memory.
> 
> Add a minimum frame length check before the subtraction to prevent
> the unsigned integer underflow.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Delene Tchio Romuald <delenetchior1@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_recv.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
> index f78194d50..1fc8bcf39 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_recv.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
> @@ -390,6 +390,13 @@ static signed int recvframe_chkmic(struct adapter *adapter,  union recv_frame *p
>  				mickey = &stainfo->dot11tkiprxmickey.skey[0];
>  			}
>  
> +			/* Ensure the frame is large enough for TKIP MIC verification */
> +			if (precvframe->u.hdr.len <= prxattrib->hdrlen +
> +			    prxattrib->iv_len + prxattrib->icv_len + 8) {
> +				res = _FAIL;
> +				goto exit;
> +			}
> +
>  			datalen = precvframe->u.hdr.len - prxattrib->hdrlen - prxattrib->iv_len - prxattrib->icv_len - 8;/* icv_len included the mic code */
>  			pframe = precvframe->u.hdr.rx_data;
>  			payload = pframe + prxattrib->hdrlen + prxattrib->iv_len;
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

