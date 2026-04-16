Return-Path: <stable+bounces-238334-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMidNfYR4WnoogAAu9opvQ
	(envelope-from <stable+bounces-238334-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 18:44:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF10411E67
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 18:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 95AFF3016B36
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 16:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825152E06E4;
	Thu, 16 Apr 2026 16:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgSrISub"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B043B303A37
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 16:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776357873; cv=none; b=ItMf3K4k3Plp31DCSzArSJFbtTp6eOKmt/1btkNrFEzS5WgS0P0+i79h3B1ViwVLwW0LohNf4qwh3XvQnicJdiDchXSyJvNNNaljB3I9LCkaarJnA17t1u+X9k7pyCAREOhQBF7Pqh4W0PdGCxv7/jKyZifkPDAIscovSGkCiYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776357873; c=relaxed/simple;
	bh=YUU3+xjeLdsqtZTdFxdFBIaeAlTtFbDXLvp82LEvJPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/1yXYWZ7KsRZPHn2PnOvx40EPN6Xl3NALonbdD71Q3WzHAEwiMq2i5foatz3KWaqCeeW5ufmQME7heHRWgm9PKa9/o7dQJDAes0h9QZ5QBz7FVy2+g6bFCBRBmYXjQ0fBkvEl9qLPPcmjmK2/MRmkVrqp41PIdO852DD1zRyAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dgSrISub; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488b150559bso65172285e9.1
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 09:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776357870; x=1776962670; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g9D1OzvPa4FIenlg0nAZ/POcm7VOaJA4WMHxYv2Zv/c=;
        b=dgSrISubAy5GM2nXHfeBR/ZEBYvjaOpaZtbVCIlM6QpoEnG39/6eOy/FJF1HsKQHJT
         aIq40L5ZwlqExQsRfyNjiQwZsLnXmwUVm1ut9HVLzALuFCxr9WVt42+D8wW+ArmUrzzM
         6wBcDb/6m3CZPm5UNlHqrFQqoHpA3jGcdwZxR+pM3YJFHycYj26FZWxUjhn3/p9j0A6p
         evLX63cDK7DfO9L0lxvq1K1T5LMnfm5Hy/yqxOsEzFKNY8AKM7nL9BV+QXcTCsMMLptr
         PEnX+nAT1qLLYQl2pMC+CM36mKaPJ3B/1ne3VOP+AA2sQpZfhNstVe0ayW95PnQpT/5U
         /NwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776357870; x=1776962670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g9D1OzvPa4FIenlg0nAZ/POcm7VOaJA4WMHxYv2Zv/c=;
        b=mHlBo6X5OnyahYj0JVE1l6/cvFP/OvXb24w2IljT2BC4riCuSWoeYo/hl32tNyuiqY
         Vg7349laxzgfh7bghsbN4/hlHDtDmmHU5h/cXlULzuiBhTakj3iZc5TbcT4eUPZ8tcGb
         aqrSmASE9WVZ54Bmq6K6Wn4nCienR6EdHgRRxYYGutK7X785fhzGcEcZ4skxgZTYuMUq
         Q3eLCLbvZ+ENad/2UyVx0QLW5ouCUX85AS08UQ2eBW/etTUP6tEy0ZyXLDyw1knrgdJ+
         6JboyMP/So4u3TTFOIZYQhBxFe9FkmN4HfViUnCZ2IUk4Q1RgtO8qndUijw5iKayp4d4
         ciKg==
X-Forwarded-Encrypted: i=1; AFNElJ/ZuHKvNGUcuwIXboYwqccHhnWxJPZetyYmDtuG7SfxK0D2X7A5YJu34xMqQpyWIhJf7kYXH/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqVgcevHBzZEZIwCph8UGumbclYD27L3IZG/Bg2zoNHCLRJNVv
	Zg78zQNSHl8wBReOWrCPP2ODkqKyOnpudPILNwE2D1rTjd9zDQMMU22O
X-Gm-Gg: AeBDievZL2hUib4pBKpcCy5DWROeP4l9gNEU7UdDDNN6P5QzSZLUDcC8GMOQbcneQJx
	HfD2mOj4L6J6P4EYDdU+bXPUrLXjl6PQCfLo/0WcsEi5hM1kELoiX34GY6WdizEHQ10WnrNE34v
	U77sxwNRPxFdLfUDjRXx8gMJG3zFTs4kH8tPwtE4RPKorqt2SkSD9DNOOe+o1lrPs4SJ42rkyik
	0dIZrv0VszBjujxoKdfcqcbxxDLLCjgGCoW/jLcxU3p4xndDURpiO9/90i/vM/+OmTKf2ykUE5F
	Mrr3kxNn03zitjt/Tc97RTuRbg7levwGdUa/ovVnHnqrXFMfA0MDqmtiTRF/r6SGaMaFYx7p9he
	4SgMTqQ6W1C+y3lYwQS/PT20mQWMPgTRNC6Uyg1HqphKC35vVaZpNY54sx3FPMAniHgW1Z6w4jL
	D6FyyMeoJsSZ6fLMH4Nws=
X-Received: by 2002:a05:600c:681:b0:488:e192:6fbd with SMTP id 5b1f17b1804b1-488e192710cmr170540595e9.30.1776357870042;
        Thu, 16 Apr 2026 09:44:30 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f585cefdsm68242275e9.14.2026.04.16.09.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 09:44:29 -0700 (PDT)
Date: Thu, 16 Apr 2026 19:44:26 +0300
From: Dan Carpenter <error27@gmail.com>
To: Delene Tchio Romuald <delenetchior1@gmail.com>
Cc: gregkh@linuxfoundation.org, dan.carpenter@linaro.org,
	luka.gejak@linux.dev, hansg@kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 4/5] staging: rtl8723bs: fix out-of-bounds reads in IE
 parsing functions
Message-ID: <aeER6sBPtdGneLuY@stanley.mountain>
References: <20260415185501.440492-1-delenetchior1@gmail.com>
 <20260415185501.440492-5-delenetchior1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415185501.440492-5-delenetchior1@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238334-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,get_maintainer.pl:url,stanley.mountain:mid,linux.dev:email]
X-Rspamd-Queue-Id: BEF10411E67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 07:55:00PM +0100, Delene Tchio Romuald wrote:
> rtw_get_wapi_ie(), rtw_get_sec_ie() and rtw_get_wps_ie() walk a
> buffer of Information Elements using the TLV length field without
> first verifying that the length byte itself is inside the buffer,
> and without verifying that the element's declared length fits
> inside the remaining buffer. Both conditions can be reached with
> crafted input, causing reads past the end of the buffer.
> 
> An attacker within WiFi radio range can exploit this by sending
> crafted beacon or probe-response frames carrying truncated or
> oversized IEs. No authentication is required.
> 
> Ensure the length byte is inside the buffer (cnt + 1 < in_len)
> and break out of the loop if the declared element length would
> read past in_len.
> 
> Found by reviewing bounds checks in IE walkers.
> Not tested on hardware.
> 
> Fixes: 554c0a3abf216 ("staging: Add rtl8723bs sdio wifi driver")
> Cc: stable@vger.kernel.org
> Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
> Signed-off-by: Delene Tchio Romuald <delenetchior1@gmail.com>
> ---
> v4: add Fixes: tag and Cc: stable (Dan Carpenter); carry Luka Gejak's
>     Reviewed-by.
> v3: rebased on staging-next; sent as numbered series with proper
>     Cc from get_maintainer.pl.
> v2: rebased on staging-next (v1 was based on v7.0-rc6 and did not
>     apply).
> 
>  drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> index 72b7f731dd471..e0fed3f42de0c 100644
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

It's a pity this function doesn't return negative error codes.

> +
>  		if (authmode == WLAN_EID_BSS_AC_ACCESS_DELAY &&
>  		    (!memcmp(&in_ie[cnt + 6], wapi_oui1, 4) ||
>  		     !memcmp(&in_ie[cnt + 6], wapi_oui2, 4))) {
                             ^^^^^^^^^^^^^^
here we are assuming the in_len is at least "cnt + 6 + 4" so we need
something like:

		if (cnt + 2 + in_ie[cnt + 1] > in_len)
			break;

		if (authmode == WLAN_EID_BSS_AC_ACCESS_DELAY) {
			if (cnt + 10 > in_len)
				break;
			if (!memcmp(&in_ie[cnt + 6], wapi_oui1, 4) || ...

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

Same in the other places as well.

regards,
dan carpenter


