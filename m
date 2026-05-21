Return-Path: <stable+bounces-253572-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKj3I3saD2qeFwYAu9opvQ
	(envelope-from <stable+bounces-253572-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 16:45:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5114F5A78AA
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 16:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A3A1C3055DC2
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 14:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8283F2BDC29;
	Thu, 21 May 2026 14:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2b1jAPCe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C1623372C;
	Thu, 21 May 2026 14:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779372646; cv=none; b=D94jh4TdE+EJsW50dLZSdvV7ScKXBGHUSzp60wvqfGHyWRP73tANd5A2GQfWNp3ArRk84W6lOUDrDMBCOOFt5Xzm5uP6tPgb39ghWRxS64v37Oip+/XlrLyH1AuhFcxpTGo7WYwoEbin+nXV1vhWqYY2YFd0AXox/Z3FsN+dgSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779372646; c=relaxed/simple;
	bh=aaFq8muEgNmquaWgc32wII9JbY560YzAhRSiy59T8+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOjY7iRnq8hy2FG7PpchfLTGrpoyqITokX2w6Kh3ZxMj+mlnxprKJCL/jRMV/4p5RZgZGLLJ3tp+4zj4mzXECa+jkO0fduub0R63idfdDRLYHPa4RClEkOYFgVHZPN/i5yU9Jmv5qKDo/lFuI8seqaYs8OOLulw5/4lvrg/xdE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2b1jAPCe; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D6C1F000E9;
	Thu, 21 May 2026 14:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779372644;
	bh=lFTjSW7LcqxQLX3MWL2pp4UH/Jy5/O1vgSQS8V84Bek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=2b1jAPCed8iNuvmDbKRf1VbR5M+wcXi4ChUHQTOdGbqx7YUYLttz4hrv9vZCR/44a
	 oJDDMb7T+HsGy6yPMGALEfdwbuIaRsVv7P8X9+YX/W3k/v7YW4sHFNM/OtVpgzY/Cu
	 lQSQpHj5xvalSy9E4W7C1IuJFdwOZ6pliiNITXzA=
Date: Thu, 21 May 2026 16:10:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alexandru Hossu <hossu.alexandru@gmail.com>
Cc: linux-staging@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v9] staging: rtl8723bs: fix WEP length underflow and OOB
 read in OnAuth()
Message-ID: <2026052134-dingy-uncouth-6c9f@gregkh>
References: <20260521130324.754100-1-hossu.alexandru@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521130324.754100-1-hossu.alexandru@gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253572-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 5114F5A78AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 03:03:24PM +0200, Alexandru Hossu wrote:
> OnAuth() has two bugs in the shared-key authentication path.
> 
> When the Privacy bit is set, rtw_wep_decrypt() is called without
> verifying that the frame is long enough to contain a valid WEP IV and
> ICV.  Inside rtw_wep_decrypt(), length is computed as:
> 
>     length = len - WLAN_HDR_A3_LEN - iv_len
> 
> and then passed as (length - 4) to crc32_le().  If len is less than
> WLAN_HDR_A3_LEN + iv_len + icv_len (32 bytes), length - 4 is negative
> and, after the implicit cast to size_t, causes crc32_le() to read far
> beyond the frame buffer.  Add a minimum length check before accessing
> the IV field and calling the decryption path.
> 
> When processing a seq=3 response, rtw_get_ie() stores the Challenge
> Text IE length in ie_len, but the subsequent memcmp() always reads 128
> bytes regardless of ie_len.  IEEE 802.11 mandates a challenge text of
> exactly 128 bytes; reject any IE whose length field differs, matching
> the check already applied to OnAuthClient().
> 
> Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
> ---
> v9: add WLAN_HDR_A3_LEN guard and WEP minimum length check before
>     iv[3] access and rtw_wep_decrypt(); tighten ie_len check from
>     <= 0 to != 128 to reject under-size challenge IEs
> 
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> index 68ce422305ed..8575b7bd6d84 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> @@ -687,6 +687,9 @@ unsigned int OnAuth(struct adapter *padapter, union recv_frame *precv_frame)
>  	if ((pmlmeinfo->state&0x03) != WIFI_FW_AP_STATE)
>  		return _FAIL;
>  
> +	if (len < WLAN_HDR_A3_LEN)
> +		return _FAIL;
> +
>  	sa = GetAddr2Ptr(pframe);
>  
>  	auth_mode = psecuritypriv->dot11AuthAlgrthm;
> @@ -698,6 +701,9 @@ unsigned int OnAuth(struct adapter *padapter, union recv_frame *precv_frame)
>  		prxattrib->hdrlen = WLAN_HDR_A3_LEN;
>  		prxattrib->encrypt = _WEP40_;
>  
> +		if (len < WLAN_HDR_A3_LEN + 8)
> +			return _FAIL;
> +
>  		iv = pframe+prxattrib->hdrlen;
>  		prxattrib->key_index = ((iv[3]>>6)&0x3);
>  
> @@ -802,7 +808,7 @@ unsigned int OnAuth(struct adapter *padapter, union recv_frame *precv_frame)
>  			p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + 4 + _AUTH_IE_OFFSET_, WLAN_EID_CHALLENGE, (int *)&ie_len,
>  					len - WLAN_HDR_A3_LEN - _AUTH_IE_OFFSET_ - 4);
>  
> -			if (!p || ie_len <= 0) {
> +			if (!p || ie_len != 128) {
>  				status = WLAN_STATUS_CHALLENGE_FAIL;
>  				goto auth_fail;
>  			}
> -- 
> 2.54.0
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

