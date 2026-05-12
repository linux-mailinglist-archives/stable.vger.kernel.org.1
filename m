Return-Path: <stable+bounces-245406-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJwjLwnZAmqbyAEAu9opvQ
	(envelope-from <stable+bounces-245406-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 09:38:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 402B351BFFA
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 09:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D1923063DD7
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 07:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB08379C37;
	Tue, 12 May 2026 07:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNGf+EKP"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903B036F8EC
	for <stable@vger.kernel.org>; Tue, 12 May 2026 07:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778571443; cv=none; b=QR7WWKyZ4Q7bT99ZBuex7OcWZPXPOGdF9FycEmuuMuAcVdttDr/3wVOvLuvH4KSQDxYR3egTVhvaCqvwC4CCryiknB/wCCvM3Gigkl6oswJY4dwtbfIOwWjdHr/bjSW9ifPtQcF5o48bBFKGGN2Dm+/ZoNPjDIyC1/Gl6C7ed/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778571443; c=relaxed/simple;
	bh=dTmrkJn4weiuNg0VBlPnKFt/P9440EYzy09QpnPlOH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NsFijw04OLzjSGnKJgZicVUQVKFOQnX2Zy/JaQd4fElVjaMiLIOWAHg+YWwfS1GW3kFM9gr77ftrL9K/JdNxfbO5mXbnkNpOBNQWNQy5JsWXZ5A0YYulL3cC9ROBCjCw/eUkBlM0xTp+rRTo/NlHWkCTCRsIDxLjXQTbiferDW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNGf+EKP; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48d146705b4so63373065e9.3
        for <stable@vger.kernel.org>; Tue, 12 May 2026 00:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778571440; x=1779176240; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PnFqd4eoebq6QO9QB+ogH2edRmONki+/t3a+recyMXU=;
        b=dNGf+EKP8X/nJTSkKvkSSIwcjtKcekO52ctrgH2rUoggXXnC2SBPbX39sgofnQtS+t
         WvlXHBmc3uqH94Bk76cnTps+o21xzs71qXE/08fMujVr699G/PS3EPCvO1XY6C8DbUF7
         701SuBBwlEJwvTsN+EvqHjRGsvnya1h3vajQSCJ97N3kgSp3d5ia0qKvezBS8Pop0UhW
         freiAs3GIrwXzlxp0TZtv4/+BuLUErtmaAA31lmtqciB10jg3pgMSV/J1odOmSNrEbqe
         sKzUaQk08I3pOmjYcMu2i0EmzTBVbp8QYQtEUtxKwyafRN5nAVp79Z4KXiaRlvn+36Jo
         Jn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778571440; x=1779176240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnFqd4eoebq6QO9QB+ogH2edRmONki+/t3a+recyMXU=;
        b=mzl9+/rbLfQePRR/4viOzvzjOhdWwbG+/5amFaW3rZQliH3UjEsbd+g+bhFvb0orOs
         ZoMlZVM/fNMF70MCNYZzmDpoJpNS2Lx5By1Vx4AvYgvyfe7rJsshuKXmGe9rn0gfN69U
         5FY3L1Y7ETYGYAafRPOf/OVOqPETRgDCrrqguwRVjSXy+lZkhDq11kmiS+oJsuMMuVx5
         CoeV+O7IcjI+xMsJ0XyYMu+/pjiK6f9r98k313RwhwbqSe85unC9Kyr7LggXvN/aXqJX
         vlPVGeQNco0xIkKwtflkML9PeA/3XrFHpwQ3ov4B9Qoj5Ytk83bZ4am1sqHq2erQLUNI
         cFJA==
X-Forwarded-Encrypted: i=1; AFNElJ+dQ2YSClksQV3YgEgw74Y9zWsAGb7n7vXB9dUDic8H/w4DkV/P4nIgkIiheppW4st7+x616yI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyalRLEeSx8lNSRJ6/g724RZamnmpLJiYJNV79HEWvXsQkc7UXd
	6FulnB+8UweTJcmoDYYTNEGARmU3YAUBbG3nhlP7LGEiaa2BZThHa8GY
X-Gm-Gg: Acq92OHGq1q/5e12y0GYvRLeCWxcAV+MkfTJG8qTbx62eHgvFdSnZ2LNdkAKcOMFxVb
	zi1jkhYDX1hrsTT1LAT0DW3BdmOBT/L+JheKhyIMQnVcFTGp9HfwF9n1qyTmk1y27d/ijd8DWAz
	trw1IANTYfRVViFznBnXEiR8Lk2OnVMJSQJ7n2yf4gAvaxoWQMmETJYCe5/rJr5743MNtt4idUX
	yKNiBcAGC4BzQQHvlMJ16e9XGa+oNrNbjUfeP9XtXNA+9MfKl+zfvf7Tg+zd7iqgcz60F9SCJv4
	h507CTxyAWq+Ryejwc4gVgIjwusuHDOwT2dcJcuTaxZrdu4Zh0XxvAz43/BAom3iQyEXbDG6+gI
	2LzrWn+LJrnpJ3XTSJVspMuAC9TVjS31RKZmEQyCkOcRYO/38m8wocX9tI/9aQGnly0lCeffc0q
	u9HwMOdUtso6ZUuH0xBWAonNhSTecG/g==
X-Received: by 2002:a05:600c:474b:b0:488:9e54:94c0 with SMTP id 5b1f17b1804b1-48e8fe5017fmr25335265e9.8.1778571439934;
        Tue, 12 May 2026 00:37:19 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f43de84sm11609595e9.26.2026.05.12.00.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 00:37:19 -0700 (PDT)
Date: Tue, 12 May 2026 10:37:15 +0300
From: Dan Carpenter <error27@gmail.com>
To: Shayaun Nejad <snejad123@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: rtl8723bs: bound SUPP_RATES IE length in
 rtw_check_beacon_data
Message-ID: <agLYq3tu0M4QpSmo@stanley.mountain>
References: <cover.1778550157.git.snejad123@gmail.com>
 <a56d8fa71dc6843e5096ce69d4c216c0ca99a7de.1778550157.git.snejad123@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a56d8fa71dc6843e5096ce69d4c216c0ca99a7de.1778550157.git.snejad123@gmail.com>
X-Rspamd-Queue-Id: 402B351BFFA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245406-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,stanley.mountain:mid]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 06:44:56PM -0700, Shayaun Nejad wrote:
> rtw_check_beacon_data() copies SUPP_RATES and EXT_SUPP_RATES IE
> payloads into a 16-byte support_rate[] buffer.
> 
> The IE lengths are used directly, so oversized rate IEs can overflow the
> stack buffer.
> 
> Clamp the supported rates copy and the combined extended supported rates
> copy to NDIS_802_11_LENGTH_RATES_EX.
> 
> Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shayaun Nejad <snejad123@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_ap.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
> index 4b40124110..363ecb02b5 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_ap.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
> @@ -873,6 +873,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
>  		       &ie_len,
>  		       (pbss_network->ie_length - _BEACON_IE_OFFSET_));
>  	if (p) {
> +		ie_len = min_t(uint, ie_len, NDIS_802_11_LENGTH_RATES_EX);

These days we would use umin()

>  		memcpy(support_rate, p + 2, ie_len);
>  		support_rate_num = ie_len;

support_rate_num is set here.  We know from the min_t() that it's less
<= NDIS_802_11_LENGTH_RATES_EX.

>  	}
> @@ -882,8 +883,11 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
>  		       WLAN_EID_EXT_SUPP_RATES,
>  		       &ie_len,
>  		       pbss_network->ie_length - _BEACON_IE_OFFSET_);
> -	if (p)
> +	if (p && support_rate_num < NDIS_802_11_LENGTH_RATES_EX) {

We know that support_rate_num <= NDIS_802_11_LENGTH_RATES_EX.  Allowing
== NDIS_802_11_LENGTH_RATES_EX is okay because memcpy() of zero bytes is
a no-op.

> +		ie_len = min_t(uint, ie_len,
> +			       NDIS_802_11_LENGTH_RATES_EX - support_rate_num);

Use umin() here too.

Otherwise the patch is fine.

regards,
dan carpenter

>  		memcpy(support_rate + support_rate_num, p + 2, ie_len);
> +	}
>  
>  	network_type = rtw_check_network_type(support_rate, channel);
>  
> -- 
> 2.43.0
> 

