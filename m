Return-Path: <stable+bounces-237864-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id O5YjNUQ73mnipgkAu9opvQ
	(envelope-from <stable+bounces-237864-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 15:04:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 882F03FA451
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 15:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74E99306B135
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FCC3E6DDB;
	Tue, 14 Apr 2026 13:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0MTee/e"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D9B3E6DD5
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 13:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776171769; cv=none; b=qdTZiFfNR2425Z4RIMosJ7eZJ/McO+u59VBEGivL0GaHea1IUITMjgwrCaUypqL0/0b5b8Pfa+H/YQC9lw2D0j9kwZQzRRSUZTZEqbcp4vs6iuihw6TpOgTUJxT8Adh9VaLRSu/eh1fyMcdeYkzcSZyjH1CwR2h+68qYHjhAJLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776171769; c=relaxed/simple;
	bh=AW468umSoMxfQZuO3i3oPBw2NNfhkyDeqV5TDwGam/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JxMvp5FHX+82whhVUUlBwJ6fPLzlAK5WT4mstEsWLfKpV2ezFw5CB+sFlzi8onxYI/TovKVQBcE57zZ8t2ov6uDSIr14TIabfVw6LJDo3yCjbhgrVXWmNMtwILVdYbiQvpzAE8ZMN4SY0bIxD922iVI2ffXgjlB70spzuvBdTAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0MTee/e; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488b00ed86fso57758185e9.3
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 06:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776171764; x=1776776564; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=696EAWx7+IwRQtEykEd8+V1n8vDOpq5v6LhBAVHyZ/Y=;
        b=Q0MTee/eaLXzZU8rurmwcJSlxaTVbOjtBT55BQajSlTfuwurP++YXLAkW2MN9DeZ6m
         cOoIQOXmsVFQzQKdYvAQZtRnLG/Punnd8mJEYE0nD6wKhPTD5+h63VBVOFsTb1knUhU+
         IiCMipT63wc/bAilRfxq1vt1bqsJxMkOJElcOw//Ldyzy9fmepAmTwRYwRK3qZMZq0x6
         maCCPqcxk6PWf5BOqj8yyaz51VpEyh5XBURwXpcr7rAEU7x37rrOU0+WJBQOCOQfmiCw
         DF1VaRYCalphhj/hEGqSwNuK/jhQR4ABZQvVolCO3NBOR7EXmIe5sN8RVEx44pegvtTX
         4jKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776171764; x=1776776564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=696EAWx7+IwRQtEykEd8+V1n8vDOpq5v6LhBAVHyZ/Y=;
        b=o1w3vib7SEIMiqeBx6h0pkH5Y/QlEm/7BCo79VLRaIp68aZyEsf9b4I2Y6zf+HoEoU
         LkL1pD9bGOlChQ/gYqnTAubvvoA3t5WkuqFkqC/4woToPbdn4Z6Hcikn3fq+bSVHuIpz
         tryCenEBtZHcnxbmKhsGxrBFVmDuVqkNDGIJoPmfKIbMsNMBLRuCuKyMFqyrFN1st6S8
         i0qjC0zM8kxgAyrLavyRdSJBueiY5maF0Wmn8f3ZqXcaEKRuTOUPK1NAranAe8eqDx4l
         9wTTsd1YXskWyD6+vp/Wrmdd4X8GEF3NpnHAVy/1C8qSPjqjZB3hUuWhqLPce+8QjfWj
         fxmA==
X-Forwarded-Encrypted: i=1; AFNElJ+Xj/ZScQM+StjgcXB4acjbINPPIH587ZkOG0THhCyFSGf7VuFf8SspcLs5iSyOe+sP+U3IzMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YywCBtAunuwQc7W9Dte53PG1BCM/6YZHfTZYQYZDdnjeGwutDx8
	9Qu/52YFLqFkicNtBxhJPOMREGpRULvr+0UjS300LCMNOcbFfB9NUZzC
X-Gm-Gg: AeBDiesOgYQMlndKEwumuPqsgW6+kRSMLa9t4LJo49wjkBr05KHLVeCg9wLCT6X9bbn
	NKfR8ICVxakKxCzgLrC2aFLA4c4fN/M6Su2dmhq3L5tBmOQB14V4tbwgE46Y6WKQ1rRCg1Xkp1Z
	5Elx3QqhujtVUBjns/D/tyChQUTEUWnhY5rGHrqt1Ww60rZyEPfcjx7fxfJraHkaQslOwEFwr3V
	rq4GlJu24dRylbOeJn0MUuiXjRkGQAzxkTU0w9Fcf74zq4Ef1ey3LwOzcb7XFjGI9qOhaCh80id
	y73On+tlllufaZ1n8l2kZjKGASuh3pKAYT2wVHXEhUYTboZlR3MC+0X6c+WUKpA1jg3GRYxIaPY
	FgAuYWUrJLehx8U9TXRgvurjz78CId/A62Kbq197muaGmemgP2+e0ShAXzP13dwnN37FvZPsCn7
	Rcepg33CwscmXkEVUUbv09hbOstX60bNwd1Nzs
X-Received: by 2002:a05:600c:45c9:b0:488:869c:edaa with SMTP id 5b1f17b1804b1-488d67e269amr237317035e9.7.1776171763810;
        Tue, 14 Apr 2026 06:02:43 -0700 (PDT)
Received: from localhost (hf33.n1.ips.mtn.co.ug. [41.210.143.51])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ede1e05bsm82588805e9.6.2026.04.14.06.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 06:02:42 -0700 (PDT)
Date: Tue, 14 Apr 2026 15:48:55 +0300
From: Dan Carpenter <error27@gmail.com>
To: Alexandru Hossu <hossu.alexandru@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, dan.carpenter@linaro.org,
	hansg@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: fix frame length underflow in
 OnAuthClient
Message-ID: <ad43t8KkI0BBc-co@stanley.mountain>
References: <20260413202824.740653-1-hossu.alexandru@gmail.com>
 <20260414100804.871764-1-hossu.alexandru@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414100804.871764-1-hossu.alexandru@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237864-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[stanley.mountain:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 882F03FA451
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 12:08:04PM +0200, Alexandru Hossu wrote:
> If pkt_len is less than WLAN_HDR_A3_LEN + offset + 6, the reads of
> the seq and status fields go beyond the frame buffer. Additionally,
> when pkt_len < WLAN_HDR_A3_LEN + _AUTH_IE_OFFSET_ (30 bytes), the
> subtraction passed to rtw_get_ie() wraps around since pkt_len is
> unsigned, causing rtw_get_ie() to scan well past the end of the buffer.
> 
> Add a minimum length check after computing offset to reject frames
> that are too short before any fixed field access.
> 
> Reported-by: Dan Carpenter <error27@gmail.com>
> Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> index 90f27665667a..6b0ac54ad3d4 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> @@ -869,6 +869,9 @@ unsigned int OnAuthClient(struct adapter *padapter, union recv_frame *precv_fram
>  
>  	offset = (GetPrivacy(pframe)) ? 4 : 0;
                             ^^^^^^
Do we know for sure that this is within bounds?  And there is earlier
code which pokes in pframe as well.  This code is quite complicated.

I looked at how to do bounds checking but it all seems pretty
complicated to me and I haven't investigated this enough to know the
right answers.

regards,
dan carpenter

>  
> +	if (pkt_len < WLAN_HDR_A3_LEN + offset + 6)
> +		goto authclnt_fail;
> +
>  	seq	= le16_to_cpu(*(__le16 *)((SIZE_PTR)pframe + WLAN_HDR_A3_LEN + offset + 2));
>  	status	= le16_to_cpu(*(__le16 *)((SIZE_PTR)pframe + WLAN_HDR_A3_LEN + offset + 4));
>  
> -- 
> 2.53.0

