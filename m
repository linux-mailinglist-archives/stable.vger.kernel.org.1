Return-Path: <stable+bounces-269288-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id C4aAB9jJPmoVLwkAu9opvQ
	(envelope-from <stable+bounces-269288-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 20:50:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 711486CFCE1
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 20:49:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rowland.harvard.edu header.s=google header.b=ps2hJqnK;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269288-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269288-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=rowland.harvard.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44170302E78B
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 18:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F2D3542D4;
	Fri, 26 Jun 2026 18:49:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F97236B05E
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 18:49:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782499768; cv=none; b=j/hLMjCG0iaGqo56tLiLZgWx2t12dBpdEcCUKrVmqfJOOJ6KNdTguJ1uQtMKBVAKI+SbjxjQKXxx1yYjOKPYuZA2lb5CLBbAmx/AFWwZobAw/RiLwn9G+l7pGTvBdsHusXhVsNHMWPfyjrNKVlAGDQ9SkScJsAm6jpGRpssBcKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782499768; c=relaxed/simple;
	bh=WdQn7ZxlwVSwEkRpRMyk7ZVypiug2xjkELicFBqpHrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVBEefrMbx0rBgxbNYE8BzfR6GMq+BRd4ut8nRxiJLpiI3E4aVFXB4e9RW8W5KbXPZfVGAZ8dY8PLS3LycrxsQkNz8z7dUAg9BUllS3L+8sTgabZtNB/epk+eWbMdfG0+r5Az2+4GbWG9mYkRLxRxpvV6zm3CDskwo5YYM3tEkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=ps2hJqnK; arc=none smtp.client-ip=209.85.219.46
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8e5be46f663so10698956d6.0
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 11:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1782499766; x=1783104566; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d74Wj9KlK+DdwUy/vFvxXnQUACrpg/th02DaCorHY/0=;
        b=ps2hJqnK25tZ3xanuuPsI7X/HChMmMQsxlqZQxJhPCXvHA66XWGAuzXQp+zi/FhWCS
         zkDotzFUxY0BAxJz9uFG1cvwARriEIDujIdv5AOLSQCFRdrudZqqHDqmx5ki6nMiDnNP
         VNTZBbRIFJOKE88jO0ON6dr2bNTmevB+xErUTgPiXVkl5jKJPM/eXU6fClZucIa/r4hy
         hLSfAMhhzhWRchLTQw7nkKJj7Rw9JfuIrVb8QydqhNS67KdFoy3gjWYRVtEOyZr+DzTF
         z2xx53VUnpUm66Xqx0rL1s/1bjWCmy6+hipUqX9AW1VtGE4t0yVw1o2VLcuHh/bu4+Kr
         9jYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782499766; x=1783104566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d74Wj9KlK+DdwUy/vFvxXnQUACrpg/th02DaCorHY/0=;
        b=H9wtdlhabRTSYaCEYIi8KepFojj4kb6qUWa3AgT6x4eTJI/fhDT6WVbOnejqqRqVps
         4o5I0nyJNfMNq2FDd9aIvfEInPOaMqR94K6LUtl9MVwpSRe+XlysLEE9hBOWIboDCGi4
         7zucpPlQyi54f/ceAbWeqbAnUqVpM3DVVUpptcym8HCwcD27JYB55Rld0qBYvl6DfpsE
         NMmMRZbtDFN+EPVNsZmaD/8cc6DMqZTA7zLJmQzbP8mZZVUQgbf29tAVNcldPBuF8BG5
         7AYNoaJeHRbuUvX366/tLUm4oMGiqjzrWFh5Ef68aclh5KD5btPCsZ4B4Kl86m06QrRU
         GOWw==
X-Forwarded-Encrypted: i=1; AHgh+RpwE/1fn3m9z1z+q8mIunePcRrGDtb6kXZKDXoNbvIXKobQUpfBJLEtNVMkVJDfzLfcuP6J1oM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI7ciFO89RuyNmgucheUwId7je37KaCqqC72wA6d+NaMrGm6wX
	h8oOWZ+dBSKkVZbpBgW8WhefR4+xNhU+flv7l7ki0yXhvnSTDiHlR/scoxMm6+HpfQ==
X-Gm-Gg: AfdE7ck7sWIcPFFBdTrdxzQtWobtuwt3DCWlr12pn3aU/MXWN979g/+vb93sOPBh4LV
	Shred3E4fKdc3K/aRmVAXCzVPUmky95bMFzcwwHOSHksPfvKywfq8RLUkr8k0IelHnDAh1SKLUB
	S0atowJYg8J12cvhHHGi7KlxLPqrCE1W3fzl/Z7a4MEqT3W45cghRdaPVkLg7JcJxkHkP5GubDH
	BIK6/LJXe2IJSa8sIP4WSEufHTIDadrkCmndn9/YJjkJU49uMtuzULw6BtWR42zu/CUu8QtaNwY
	3wpgLKHzVOUnShBS2RXKm/M8l++/+8u4xNs9delt0ZDABoR5ZxZzLVbQy95Veq4eJn7PQ5PnOMO
	OpHfGMibB5yrj5WWRJn/1RvdamFhkt6M3vb9BysCKzK/WbdtNSVrj+lbkX1kdpho63xLXwFmmrk
	3BWDPUQq0Qf0RHcvBO3RU3i6Y5YG7nxVux
X-Received: by 2002:a05:6214:f25:b0:8e0:c7de:1a2e with SMTP id 6a1803df08f44-8e6d2cdb818mr141380256d6.0.1782499766035;
        Fri, 26 Jun 2026 11:49:26 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210:d62f:1911:f952:16ba])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df82c62eedsm225409556d6.47.2026.06.26.11.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 11:49:25 -0700 (PDT)
Date: Fri, 26 Jun 2026 14:49:23 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: raoxu <raoxu@uniontech.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [usb-storage] [PATCH] USB: usb-storage: ene_ub6250: restore
 media-ready check
Message-ID: <387c7948-fcfe-4802-8696-51c45d7d2dcf@rowland.harvard.edu>
References: <F42641386E32404F+20260626070607.4119527-1-raoxu@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F42641386E32404F+20260626070607.4119527-1-raoxu@uniontech.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rowland.harvard.edu,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[rowland.harvard.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269288-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:raoxu@uniontech.com,m:gregkh@linuxfoundation.org,m:linux-usb@vger.kernel.org,m:usb-storage@lists.one-eyed-alien.net,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[stern@rowland.harvard.edu,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[rowland.harvard.edu:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stern@rowland.harvard.edu,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uniontech.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,harvard.edu:email,rowland.harvard.edu:dkim,rowland.harvard.edu:mid,rowland.harvard.edu:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 711486CFCE1

On Fri, Jun 26, 2026 at 03:06:07PM +0800, raoxu wrote:
> From: Xu Rao <raoxu@uniontech.com>
> 
> Commit 1892bf90677a ("USB: usb-storage: Fix use of bitfields for
> hardware data in ene_ub6250.c") converted the media status fields from
> bitfields to bit masks.
> 
> The original ene_transport() test called ene_init() only when neither
> media type was ready:
> 
>         !(sd_ready || ms_ready)
> 
> The converted test became:
> 
>         !sd_ready || ms_ready
> 
> This is not equivalent. Restore the original semantics by testing that
> both ready bits are clear before calling ene_init().
> 
> Fixes: 1892bf90677a ("USB: usb-storage: Fix use of bitfields for hardware data in ene_ub6250.c")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xu Rao <raoxu@uniontech.com>
> ---
>  drivers/usb/storage/ene_ub6250.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/storage/ene_ub6250.c b/drivers/usb/storage/ene_ub6250.c
> index 8770de01a384..ed49a3bc859c 100644
> --- a/drivers/usb/storage/ene_ub6250.c
> +++ b/drivers/usb/storage/ene_ub6250.c
> @@ -2305,7 +2305,8 @@ static int ene_transport(struct scsi_cmnd *srb, struct us_data *us)
> 
>  	/*US_DEBUG(usb_stor_show_command(us, srb)); */
>  	scsi_set_resid(srb, 0);
> -	if (unlikely(!(info->SD_Status & SD_Ready) || (info->MS_Status & MS_Ready)))
> +	if (unlikely(!(info->SD_Status & SD_Ready) &&
> +		     !(info->MS_Status & MS_Ready)))
>  		result = ene_init(us);
>  	if (result == USB_STOR_XFER_GOOD) {
>  		result = USB_STOR_TRANSPORT_ERROR;

Thanks for fixing this.

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>

How on earth did you find the error?  It doesn't exactly spring to the 
eye.

Alan Stern

