Return-Path: <stable+bounces-214761-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BD6Nv9Bh2keVgQAu9opvQ
	(envelope-from <stable+bounces-214761-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 14:45:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4723810609C
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 14:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 992B13019920
	for <lists+stable@lfdr.de>; Sat,  7 Feb 2026 13:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83827243964;
	Sat,  7 Feb 2026 13:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EBl/nIpB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4100B14A91;
	Sat,  7 Feb 2026 13:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770471930; cv=none; b=DcRRLi84SaszEBcCLkS38yErlO9+f1Q61H7SfYfxkJx+KXG0ISh08e1GFpZd62DX5HLoxdQX8XtbBJCXM9acvwuJz4S4OTTqhJu4KNKEYIZU3IADQEM+MzQMQz5gJ6Q18ubFzx7XL7wrtnM4qbDIDTLL/COl7OkVIyJn53bntt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770471930; c=relaxed/simple;
	bh=pMw1PWkNvxtyLId6Dmo/G3JTnzoAs8e4iYO5dVbhxI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKJmXI17gcRcukqWyp4IyFuffgFdNUXPkV3LpqLfMkvT/768A5fM7toqRG5jp5/8fOOP9wj/oHUJ1DDLbfOea48cUlpsM+We5OyQ1jz1p4s9kLljchDYMPTgTQYB4yz4phSFrQCVYf+FmJV04odSvbGhXrxmAa1ORI/CPiUlSfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EBl/nIpB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5421FC116D0;
	Sat,  7 Feb 2026 13:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770471929;
	bh=pMw1PWkNvxtyLId6Dmo/G3JTnzoAs8e4iYO5dVbhxI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EBl/nIpBFu5HqMyTYbWs/vVaZkjlMWTTiBTxzwUWQAm8Wp/jJaP6GOB2vTI2UzGya
	 kLI6vkIXcSuPd9rt7FPCdlbkxYEPIusI/+m5YzGVog8gaOsLEDp3XJvplyRVaFrIMS
	 zfIgInaHphXfmhUsnD+duHkpm5vLQ8Z7+k0O7xtE=
Date: Sat, 7 Feb 2026 14:45:26 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: lukagejak5@gmail.com
Cc: Dan Carpenter <dan.carpenter@linaro.org>, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, Luka Gejak <luka.gejak@linux.dev>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 01/26] staging: rtl8723bs: fix potential out-of-bounds
 read in  rtw_restruct_wmm_ie
Message-ID: <2026020759-buddy-reboot-93b5@gregkh>
References: <20260206075439.103287-1-luka.gejak@linux.dev>
 <20260206075439.103287-2-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206075439.103287-2-luka.gejak@linux.dev>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214761-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4723810609C
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 08:54:14AM +0100, lukagejak5@gmail.com wrote:
> From: Luka Gejak <luka.gejak@linux.dev>
> 
> The current code checks 'i + 5 < in_len' at the end of the if statement.
> However, it accesses 'in_ie[i + 5]' before that check, which can lead
> to an out-of-bounds read. Move the length check to the beginning of the
> conditional to ensure the index is within bounds before accessing the
> array.
> 
> Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> index 8e1e1c97f0c4..0b82b1f2f1ec 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> @@ -2000,7 +2000,10 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
>  	while (i < in_len) {
>  		ielength = initial_out_len;
>  
> -		if (in_ie[i] == 0xDD && in_ie[i + 2] == 0x00 && in_ie[i + 3] == 0x50  && in_ie[i + 4] == 0xF2 && in_ie[i + 5] == 0x02 && i + 5 < in_len) { /* WMM element ID and OUI */
> +		if (i + 5 < in_len &&
> +		    in_ie[i] == 0xDD && in_ie[i + 2] == 0x00 &&
> +		    in_ie[i + 3] == 0x50 && in_ie[i + 4] == 0xF2 &&
> +		    in_ie[i + 5] == 0x02) {
>  			for (j = i; j < i + 9; j++) {
>  				out_ie[ielength] = in_ie[j];
>  				ielength++;
> -- 
> 2.52.0
> 
> 

You still have an extra space in the subject line :(

And I think I took some of these changes already, can you rebase the
rest of these against my tree and resend them?

thanks,

greg k-h

