Return-Path: <stable+bounces-237931-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAKJKVN13mkqEgAAu9opvQ
	(envelope-from <stable+bounces-237931-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 19:11:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E49A3FCE31
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 19:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 46456300539B
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 17:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0AF2EC08C;
	Tue, 14 Apr 2026 17:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j/Lrg3Ro"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E841230ACE3;
	Tue, 14 Apr 2026 17:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776186552; cv=none; b=rwzNr2sCwV6C6/GpZ8qXleyO7gY6N74sKe+hkvrJIRfpfrSfgF9iJxbuNnVOZygkW02UsJQ62PBum6QcIVYhsBSh3AxfAxi3DFhn+ka3PHDW/ogdvvSNPU/s6FqVUQ3apaPUdcvxrzl3ThAoEGpWXWqgCgNku/CEA6aT1nsImi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776186552; c=relaxed/simple;
	bh=SQbCja9Bx3nlfZfmvXhTXp/zRmdVjX6BlUmQahqQ/NI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TqvvKARzrnwQi6HBRBH5zpi8laBiZsESF1Jjkihm970OEjONI5uEL6fDmoHOaEm3XSsqIGVfrmSMY0qWBf+OCle0iTrhFGs+J7JN9NWYlLPnTzSvUJDHjtlKCbvEUfxk4rR/kMX7hSkOs342JcmgIum1VGxYW0XLb4I9JJCA1hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j/Lrg3Ro; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE1DC2BCF5;
	Tue, 14 Apr 2026 17:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776186551;
	bh=SQbCja9Bx3nlfZfmvXhTXp/zRmdVjX6BlUmQahqQ/NI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j/Lrg3RoFRzU167ZAZtpbRuYOLNJYcmeGPom3DyHhop3q+kqgSQcwPhfJ0mexcQpS
	 gbZGH201zk70bYMlkKCabpmMvCOQ0pf1Yw/oxDjxeiHDdIoFS+bbLdMpgjZ2VQuZhM
	 v7PgTBdTgKAUY/sb+FRv6BPa69eFLxgt0rXqlMOs=
Date: Tue, 14 Apr 2026 19:08:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alexandru Hossu <hossu.alexandru@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	dan.carpenter@linaro.org, hansg@kernel.org, stable@vger.kernel.org,
	Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v2] staging: rtl8723bs: fix missing frame length checks
 in OnAuthClient
Message-ID: <2026041427-revisable-snipping-0fe9@gregkh>
References: <20260413202824.740653-1-hossu.alexandru@gmail.com>
 <20260414145350.903996-1-hossu.alexandru@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414145350.903996-1-hossu.alexandru@gmail.com>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237931-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linaro.org,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 1E49A3FCE31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 04:53:50PM +0200, Alexandru Hossu wrote:
> OnAuthClient() accesses pframe without first verifying that pkt_len is
> large enough to contain a valid 802.11 management frame header:
> 
> - get_da(pframe) reads bytes 4-9, requiring pkt_len >= 10
> - GetPrivacy(pframe) reads the FC field at bytes 0-1
> 
> Additionally, when pkt_len < WLAN_HDR_A3_LEN + _AUTH_IE_OFFSET_ the
> unsigned subtraction passed to rtw_get_ie() wraps around, causing it
> to scan well past the end of the buffer.
> 
> Add an early check against WLAN_HDR_A3_LEN before any pframe access,
> and a second check against WLAN_HDR_A3_LEN + offset + 6 after computing
> offset to guard the seq/status reads and the rtw_get_ie() call.
> 
> Reported-by: Dan Carpenter <error27@gmail.com>
> Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> index 90f27665667a..884cd39ec756 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> @@ -860,6 +860,9 @@ unsigned int OnAuthClient(struct adapter *padapter, union recv_frame *precv_fram
>  	u8 *pframe = precv_frame->u.hdr.rx_data;
>  	uint pkt_len = precv_frame->u.hdr.len;
>  
> +	if (pkt_len < WLAN_HDR_A3_LEN)
> +		goto authclnt_fail;
> +
>  	/* check A1 matches or not */
>  	if (memcmp(myid(&(padapter->eeprompriv)), get_da(pframe), ETH_ALEN))
>  		return _SUCCESS;
> @@ -869,6 +872,9 @@ unsigned int OnAuthClient(struct adapter *padapter, union recv_frame *precv_fram
>  
>  	offset = (GetPrivacy(pframe)) ? 4 : 0;
>  
> +	if (pkt_len < WLAN_HDR_A3_LEN + offset + 6)
> +		goto authclnt_fail;
> +
>  	seq	= le16_to_cpu(*(__le16 *)((SIZE_PTR)pframe + WLAN_HDR_A3_LEN + offset + 2));
>  	status	= le16_to_cpu(*(__le16 *)((SIZE_PTR)pframe + WLAN_HDR_A3_LEN + offset + 4));
>  
> -- 
> 2.53.0
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

