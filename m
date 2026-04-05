Return-Path: <stable+bounces-233323-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHdVKfMW0mktTQcAu9opvQ
	(envelope-from <stable+bounces-233323-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 10:01:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F28C39DC1D
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 10:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EEC6300A12C
	for <lists+stable@lfdr.de>; Sun,  5 Apr 2026 08:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B078340A7D;
	Sun,  5 Apr 2026 08:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HKdJSC54"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03B7282F21;
	Sun,  5 Apr 2026 08:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775376100; cv=none; b=hs7jZVqpOwR7eKSugTulJF9fgOducwm0MpwZsyTHKFIskPxF8m8BT+662p3mih4Pv1My75BUen1fBtgGV/+/pArE5CBj7iMVw8CUmxJqdihu4VLy/+LLZAGLxFgMU3sQCYwKiVgxUCX0LQBUZ/lFHgGTPw4YsJbIOeiMRv41ARc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775376100; c=relaxed/simple;
	bh=GAS5H0QOtCxfQJAGXIRGjAwlka8xn3if2L8QoNWlUsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJGNqXrWYtgit+TuY/1LXElCiXWTVqW/duZ9U+MbC2cYOpeKnAI0NN4oRAexOx9PeGb9RvnhwdVM2xlz46QVOHxWP02Rfnjqt55YLf3fntVlc+BhAwfuSuMcNknu8Pzo50Pa4VvnT3/HaTGy7/ggM6xZAZfpi+ZyF4BgsoOIPbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HKdJSC54; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E09C116C6;
	Sun,  5 Apr 2026 08:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775376100;
	bh=GAS5H0QOtCxfQJAGXIRGjAwlka8xn3if2L8QoNWlUsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HKdJSC54LAu8zZAUuzYinGuU3y8JgMTSIcw4zOobiEJEL88Cpz1kK6Gornd/EmKm9
	 mXiY2vfw4J/4vkXnNzEGTjMEK2OTLiE38azikuDTvdXdU2aH0H5rO73SdvbEuncLcC
	 4VY9Ydfc+/Xbe/1iVFlq698CE/pWkkhPNWHOPfmc=
Date: Sun, 5 Apr 2026 10:01:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Delene Tchio Romuald <delenetchior1@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8723bs: fix out-of-bounds reads in IE
 parsing functions
Message-ID: <2026040522-immovably-skies-3a11@gregkh>
References: <20260404222100.57946-1-delenetchior1@gmail.com>
 <20260405000024.73568-1-delenetchior1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260405000024.73568-1-delenetchior1@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-233323-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 2F28C39DC1D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 05, 2026 at 01:00:24AM +0100, Delene Tchio Romuald wrote:
> The IE parsing loops in rtw_get_wapi_ie(), rtw_get_sec_ie(), and
> rtw_get_wps_ie() check only that the element ID byte is within bounds
> (cnt < in_len), but then immediately access the length byte at
> in_ie[cnt+1] and data bytes at in_ie[cnt+2] and beyond without
> verifying that these offsets are within the buffer.
> 
> A malicious access point can send beacon or probe response frames with
> truncated Information Elements, triggering out-of-bounds reads on
> kernel heap memory. No authentication is required.
> 
> Add two bounds checks to each function:
>  - Ensure at least 2 bytes remain for the IE header (cnt + 1 < in_len)
>  - Validate the full IE fits in the buffer before accessing its data
>    (cnt + 2 + ie_len <= in_len)
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Delene Tchio Romuald <delenetchior1@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> index 72b7f731d..e0fed3f42 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> @@ -582,9 +582,12 @@ int rtw_get_wapi_ie(u8 *in_ie, uint in_len, u8 *wapi_ie, u16 *wapi_len)
>  
>  	cnt = (_TIMESTAMP_ + _BEACON_ITERVAL_ + _CAPABILITY_);
>  
> -	while (cnt < in_len) {
> +	while (cnt + 1 < in_len) {
>  		authmode = in_ie[cnt];
>  
> +		if (cnt + 2 + in_ie[cnt + 1] > in_len)
> +			break;
> +
>  		if (authmode == WLAN_EID_BSS_AC_ACCESS_DELAY &&
>  		    (!memcmp(&in_ie[cnt + 6], wapi_oui1, 4) ||
>  		     !memcmp(&in_ie[cnt + 6], wapi_oui2, 4))) {
> @@ -615,9 +618,12 @@ void rtw_get_sec_ie(u8 *in_ie, uint in_len, u8 *rsn_ie, u16 *rsn_len, u8 *wpa_ie
>  
>  	cnt = (_TIMESTAMP_ + _BEACON_ITERVAL_ + _CAPABILITY_);
>  
> -	while (cnt < in_len) {
> +	while (cnt + 1 < in_len) {
>  		authmode = in_ie[cnt];
>  
> +		if (cnt + 2 + in_ie[cnt + 1] > in_len)
> +			break;
> +
>  		if ((authmode == WLAN_EID_VENDOR_SPECIFIC) &&
>  		    (!memcmp(&in_ie[cnt + 2], &wpa_oui[0], 4))) {
>  			if (wpa_ie)
> @@ -658,9 +664,12 @@ u8 *rtw_get_wps_ie(u8 *in_ie, uint in_len, u8 *wps_ie, uint *wps_ielen)
>  
>  	cnt = 0;
>  
> -	while (cnt < in_len) {
> +	while (cnt + 1 < in_len) {
>  		eid = in_ie[cnt];
>  
> +		if (cnt + 2 + in_ie[cnt + 1] > in_len)
> +			break;
> +
>  		if ((eid == WLAN_EID_VENDOR_SPECIFIC) && (!memcmp(&in_ie[cnt + 2], wps_oui, 4))) {
>  			wpsie_ptr = &in_ie[cnt];
>  
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

