Return-Path: <stable+bounces-233324-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIU5GfwW0mktTQcAu9opvQ
	(envelope-from <stable+bounces-233324-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 10:02:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7115B39DC2D
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 10:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6C6E23003494
	for <lists+stable@lfdr.de>; Sun,  5 Apr 2026 08:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144203368A6;
	Sun,  5 Apr 2026 08:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yOGBeCOy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6452D46B3;
	Sun,  5 Apr 2026 08:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775376118; cv=none; b=mP+QFttoUUu7vf2hpGdGvMcvp06HKQEhXAqnvJuohI9Ff0DMaqBjE5GYQI7qrYMdH3D/2MM5faGcDNVD+7sAN2jXSJJy6DdTvWTreKCM+mT3apPSZp5Fv2tbDzFRreCzj77MHUQKSMmbHNAa5TsHRoWV2CtVqE7FDQPubWA2FNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775376118; c=relaxed/simple;
	bh=ebEPxSiDxdrXFmfFwUoGhFThu7qDqVMdGVdPMeWW5eA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkiXGTV6bV8hYocsXozSC5CSvSEwB26hNSt1pkl0aP8UMELwU60PVNE+uILmemElRUWNyU9i2prvsREdh47Mic89dQuPYinrrXYasWvWmltogU00SUGECs1LbPYAAHn/+JRrjWxY4z3MTERkI1a3qmk/16iNSwc2Fyt1DISJclk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yOGBeCOy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C07C116C6;
	Sun,  5 Apr 2026 08:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775376118;
	bh=ebEPxSiDxdrXFmfFwUoGhFThu7qDqVMdGVdPMeWW5eA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yOGBeCOymOm5MPgzszy7Z4CL5Hf1VhEv8TGpByzZbYDfB3c9FKDjQ2MV1kQLbADQ4
	 vhzDWIlMor89WmK5a2QH8SV98o98Yy1fNtoxOQkSsnxk0mxxfODVRuKw0qf+BZ00wI
	 F5lVsVch/RjAYWxNMXDXlSUXDx4uGJj1oH0IzZpM=
Date: Sun, 5 Apr 2026 10:01:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Delene Tchio Romuald <delenetchior1@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: fix out-of-bounds read in portctrl()
Message-ID: <2026040541-carload-mace-42e6@gregkh>
References: <20260404231449.63661-1-delenetchior1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260404231449.63661-1-delenetchior1@gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233324-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 7115B39DC2D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 05, 2026 at 12:14:49AM +0100, Delene Tchio Romuald wrote:
> In portctrl(), the pointer is advanced by hdrlen + iv_len +
> LLC_HEADER_LENGTH and then 2 bytes are read via memcpy() to extract
> the ether_type field. There is no check that the frame is large
> enough to contain these fields, so a short frame leads to an
> out-of-bounds read on kernel heap memory.
> 
> This code is reachable during 802.1X authentication when the station
> is in the ieee8021x_blocked state.
> 
> Add a frame length check before the pointer arithmetic and wrap the
> existing ether_type extraction in the else branch so that short
> frames are dropped safely.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Delene Tchio Romuald <delenetchior1@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_recv.c | 28 +++++++++++++++--------
>  1 file changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
> index 337671b12..1c84a5f6d 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_recv.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
> @@ -532,17 +532,25 @@ static union recv_frame *portctrl(struct adapter *adapter, union recv_frame *pre
>  
>  			prtnframe = precv_frame;
>  
> -			/* get ether_type */
> -			ptr = ptr + pfhdr->attrib.hdrlen + pfhdr->attrib.iv_len + LLC_HEADER_LENGTH;
> -			memcpy(&be_tmp, ptr, 2);
> -			ether_type = ntohs(be_tmp);
> -
> -			if (ether_type == eapol_type)
> -				prtnframe = precv_frame;
> -			else {
> -				/* free this frame */
> -				rtw_free_recvframe(precv_frame, &adapter->recvpriv.free_recv_queue);
> +			/* Ensure frame has LLC header and ether_type */
> +			if (pfhdr->len < pattrib->hdrlen +
> +			    pattrib->iv_len + LLC_HEADER_LENGTH + 2) {
> +				rtw_free_recvframe(precv_frame,
> +						   &adapter->recvpriv.free_recv_queue);
>  				prtnframe = NULL;
> +			} else {
> +				/* get ether_type */
> +				ptr += pattrib->hdrlen +
> +				       pattrib->iv_len +
> +				       LLC_HEADER_LENGTH;
> +				memcpy(&be_tmp, ptr, 2);
> +				ether_type = ntohs(be_tmp);
> +
> +				if (ether_type != eapol_type) {
> +					rtw_free_recvframe(precv_frame,
> +							   &adapter->recvpriv.free_recv_queue);
> +					prtnframe = NULL;
> +				}
>  			}
>  		} else {
>  			/* allowed */
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

- You sent multiple patches, yet no indication of which ones should be
  applied in which order.  Greg could just guess, but if you are
  receiving this email, he guessed wrong and the patches didn't apply.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for a
  description of how to do this so that Greg has a chance to apply these
  correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

