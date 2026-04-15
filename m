Return-Path: <stable+bounces-238067-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMbaNaRT32l1RwAAu9opvQ
	(envelope-from <stable+bounces-238067-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 11:00:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E09140241B
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 11:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 120D230AFA59
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 08:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D6A3D47D4;
	Wed, 15 Apr 2026 08:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bfp3Ywzu"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574F73D47B2
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 08:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776243505; cv=none; b=Nr0f8F69/Zu11STb3/+YGrmIw4UPZl5l57/4rJEZ2YKQ10mO7jkBFbCTnvoFX86kTF7XvUZxBt0DqP2kfArT5aWxtiLHVwMB1CV4B5cO9JHzfNkFeE1UUkuGDnqEkjxuTY6i8st4afQzH00CfKmAE/YCNQVa2kcRJsziHI6fDog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776243505; c=relaxed/simple;
	bh=tjwxoCh8RsswJL0AZaKD6YnWt2NGDz3mZWuPI5eieOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+bRth7aGO7W9PDlRq2hnQIn0PkhMKnKXzFIw9PIaXd+Nt9XjXOkkfeDFgSqxQsdTvELgy5P3vclHq6Ps90iT+vZ7y3OKoPSdM/BZoUq6VxKHPq9maaKljzj2oLLAIjloCWoKYn/c9/yFXtwrNCSNF0jGvYxLY0p42CebyUkhfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bfp3Ywzu; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48374014a77so87466775e9.3
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 01:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776243503; x=1776848303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6h2N9ksCXacxSbGHcgLCh/qKq3F9bELd0+y8Uh8lUbQ=;
        b=Bfp3YwzuBWuRyRkeliansjvvWyCITd+aUeAHWF4L3j9Csdemf1DpydPAdrAlJAkzuP
         Gelqb4ZWSoDUHr9wWRffzUi78iw1ePK8k1k8V/nJ55kfPZk/7gZVlJ6YbBtPgmV6vPuH
         43kBc10DrxuqZwiHxjeOvT82vJtwoQBFUtFHmNdItWVOWx/toKrljxpqCCBRmuSyn1lD
         9yc4ZNIlk9dbpOk0GM0P6lmz4VRU63uEUPN7X410D98tDGB5wgpNKyoDbdakAndFxLpQ
         DbzM9yJM73oUGsKmFhM8kv7DkC7tzvNhs14u7wJ2ENDjE1kYILop+heza9lNThx1yacN
         c8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776243503; x=1776848303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6h2N9ksCXacxSbGHcgLCh/qKq3F9bELd0+y8Uh8lUbQ=;
        b=F1o7ejPPEjYAuxs1Texdmp9YWJCIztH6hM+B09HsrKPMX2QZPjcdcBVPkEvwrJJkdW
         dToLvJeyT3mUnh01ZkwfhE3I4bSDS8o1WlGfJPgfR5TFgHnnJ/0DUnkDzVysdyB1ucUn
         7VVRoU4POD6cBKvhE2UazSBbBUYl4fuCW2MVBcEHLrJfVUbwteF1spW6/711+q3mLBTf
         hrcPLkG50bMkz4vetcMaZuxO/IDwkEV17UWSj+h1uTUMiK1jUX79yCo06iqeNKKD7RH5
         2anogAyh6Tc9MkXYAnswxo6EUdoTtCmNshFyLCOBt+8/+bJ1XNzIvsaRDc5HB/5M0YaK
         mxFw==
X-Forwarded-Encrypted: i=1; AFNElJ85FvsArOm1UtonlZ4YDlyl3EJdb5+ZSQtt8S5zDUXLJgVKsdC/dBsN9KGDExsIiugqaoFa9xU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX0dCfdYuMMaiF1ubsSHq5W142qFFqUMHjkwVNjYojdwfPLW9v
	B/y4+R8tej0SFdca1Xw58D+EjEGUpB0S1jHXfRWLMWqaln/W37cKBGJ4
X-Gm-Gg: AeBDiesDUQkXRvjVNGcs8DauGsljB1ZaFpRRfZaVJZfaRS9pu0CQBkYiS0BvTbes6vz
	85MbWDmmzKRFjLariTUYxEMqJppTBVqSHfbD3P5j/XB56n9uLsrZH+KxD2vDaP42RqqeKwPeLDm
	b3rDgjvf0mhsZ1xZ1Anh9DRa3GxUHahymmCaijKovCH9qDLDRtVtZvQpJl9hEJi2rp7B4D/xH8m
	EKvSTzJwRQX06mUGVgGZJmVoY4nSQS+ygCpxkDTDPRc5M4AqTblnG/yvEOlcMm61bEv2AhqVjF9
	sREkm0qcVQW0ZDDVWoQ81EGvaVWcL5h9uKPMsFe3SrtFTnShK58k+4yYfOmfJL9QFpSO0VJLnip
	7gFV4skRbWbMQlJ2hSRGBePptS6bJfZW5bQrJlaYhaeaUE2bHFJlhBN9170NZ4mq8HBUUPZAaPx
	wo8oyy1Joi9V/hnH20Gzk=
X-Received: by 2002:a05:600c:820a:b0:488:81b1:ae36 with SMTP id 5b1f17b1804b1-488d688688fmr287096005e9.23.1776243502635;
        Wed, 15 Apr 2026 01:58:22 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f096d110sm19990255e9.11.2026.04.15.01.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 01:58:22 -0700 (PDT)
Date: Wed, 15 Apr 2026 11:58:18 +0300
From: Dan Carpenter <error27@gmail.com>
To: luka.gejak@linux.dev
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8723bs: fix remote heap information
 disclosure in issue_assocreq
Message-ID: <ad9TKjTLxDRwDyIy@stanley.mountain>
References: <20260415050302.9934-1-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415050302.9934-1-luka.gejak@linux.dev>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238067-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 2E09140241B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 07:03:02AM +0200, luka.gejak@linux.dev wrote:
> From: Luka Gejak <luka.gejak@linux.dev>
> 
> When building an association request frame, the driver copies the
> ht capability ie using the attacker-controlled pIE->length from the
> ap's beacon. If the ap provides a length greater than the size of
> struct HT_caps_element (26 bytes), it causes an out-of-bounds read
> of the adjacent heap memory (HT_info and network structures).
> This uninitialized or sensitive memory is then transmitted over the air,
> resulting in a remote heap information disclosure.
> 
> Fix this by clamping the length passed to rtw_set_ie() to the actual
> size of struct HT_caps_element.
> 
> Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
> ---
> ---
> Changes in v2:
> - Refactored rtw_set_ie() alignment to follow "open parenthesis" style.
> - Allowed the line length to exceed 100 characters for better readability as requested by Greg KH.
> 
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> index 5f00fe282d1b..08e597bc0345 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> @@ -2954,7 +2954,9 @@ void issue_assocreq(struct adapter *padapter)
>  			if (padapter->mlmepriv.htpriv.ht_option) {
>  				if (!(is_ap_in_tkip(padapter))) {
>  					memcpy(&(pmlmeinfo->HT_caps), pIE->data, sizeof(struct HT_caps_element));
> -					pframe = rtw_set_ie(pframe, WLAN_EID_HT_CAPABILITY, pIE->length, (u8 *)(&(pmlmeinfo->HT_caps)), &(pattrib->pktlen));
> +					pframe = rtw_set_ie(pframe, WLAN_EID_HT_CAPABILITY,
> +							    min_t(uint, pIE->length, sizeof(struct HT_caps_element)),
> +							    (u8 *)&pmlmeinfo->HT_caps, &pattrib->pktlen);

You're being conservative and trying to work around the invalid
pIE->length, but in the case where the original code corrupts memory,
we're allow to just give up and return a failure.

There are two other cases where we trust pIE->length in this function
and those need to be fixed as well.

regards,
dan carpenter


