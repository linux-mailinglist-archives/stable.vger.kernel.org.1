Return-Path: <stable+bounces-214760-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JsWFFk5h2kuVQQAu9opvQ
	(envelope-from <stable+bounces-214760-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 14:08:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D41105ED6
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 14:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1378301A722
	for <lists+stable@lfdr.de>; Sat,  7 Feb 2026 13:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C6D341063;
	Sat,  7 Feb 2026 13:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fr6jE4pC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C2D2C3252;
	Sat,  7 Feb 2026 13:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770469716; cv=none; b=kfxmgZwuc6TNiO23rDdTPXK7aOkzeKhnf11+/UtrM3rWRk/Zss3ZxGQ1RP/gEXqy237xtOCrPPsVMM5BU2/8UfSBPT91ZKUmzNwOXZnwqD9XJu0wEVfyX6NwYqIGTMGvZeRYaZTzODv/80f/5D0zsHa7uNm3Jo3xjfVg2Bgb/mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770469716; c=relaxed/simple;
	bh=NSfmqgdvywmJWDB73UCxwTR988iTbpCYUP1NM7is0/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJPbagx9PQLhh9Vnanvn3KcPHeHz6es/VunE/BCzdUQIxja1FSF6bL6ihn/ExpuG1690qEMXvGLhVAIXHTPeKCGoXHKCqldZlcujnpdLGs6J/YO0ZFg8VHygUj04JMfXakm7imfMswobWPkZMCA/QFDyloR28CoE9XZRQ81mYfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fr6jE4pC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB0FBC116D0;
	Sat,  7 Feb 2026 13:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770469716;
	bh=NSfmqgdvywmJWDB73UCxwTR988iTbpCYUP1NM7is0/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fr6jE4pCDOsJQQYYA5HcutzTK35lhlwNUX+XVdq7YMnRwPvU6z8vo5gqsw/7KqLMq
	 C/fUBU6BqDSAop56tV4Sp5/WT7tkAuqWyH3Rl8LST3US/RJdsGV3MjmoETAoKZjZdt
	 jhdENvd4aLufUYXtObTsl7GsS5EQ+ZKx/sazCfAw=
Date: Sat, 7 Feb 2026 14:08:33 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Luka Gejak <lukagejak5@gmail.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v6 1/5] staging: rtl8723bs: fix potential out-of-bounds
 read in  rtw_restruct_wmm_ie
Message-ID: <2026020716-starboard-uncurled-2334@gregkh>
References: <20260130185658.207785-1-lukagejak5@gmail.com>
 <20260130185658.207785-2-lukagejak5@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130185658.207785-2-lukagejak5@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214760-lists,stable=lfdr.de];
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
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A7D41105ED6
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 07:56:54PM +0100, Luka Gejak wrote:
> The current code checks 'i + 5 < in_len' at the end of the if statement.
> However, it accesses 'in_ie[i + 5]' before that check, which can lead
> to an out-of-bounds read. Move the length check to the beginning of the
> conditional to ensure the index is within bounds before accessing the
> array.
> 
> Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Luka Gejak <lukagejak5@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> index 98704179ad35..7dfc2678924e 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> @@ -2000,7 +2000,10 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
>  	while (i < in_len) {
>  		ielength = initial_out_len;
>  
> -		if (in_ie[i] == 0xDD && in_ie[i+2] == 0x00 && in_ie[i+3] == 0x50  && in_ie[i+4] == 0xF2 && in_ie[i+5] == 0x02 && i+5 < in_len) { /* WMM element ID and OUI */
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

Nope, I can't take this, as it doesn't apply to my tree at all :(

Please rebase and resend.

thanks,

greg k-h

