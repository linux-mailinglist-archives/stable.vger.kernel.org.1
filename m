Return-Path: <stable+bounces-238134-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BiOFcSX32nXWQAAu9opvQ
	(envelope-from <stable+bounces-238134-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 15:51:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C99405011
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 15:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 345FA3062A06
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 13:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974693CBE63;
	Wed, 15 Apr 2026 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+TVCkY0"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822A230C631
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 13:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776261029; cv=none; b=gVWyfgwkvEuww9LCPQfFttOhHZN5K2e59/DlBowyzM3jwGmBn1mgk/KZqqI9JO7eBIfEilTTGeSWvYNJfo5pi+3ahIkHqOFouK3U2bM8VVbb/87HBnYP9f78NBtieJFMNlP3/qyG9T7AcW+Qz3uc90YS3zjoiyX77qgi/lS83MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776261029; c=relaxed/simple;
	bh=eVNrw32cdCvsLSD61G9JKcU5GmtqCrVfszu08tUS68k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HY60Oc2HgMDjFgqQIhIONsYl1k9s+JdI8mguOPvKnsNuib84fTFs959LsEjxCYXYvqQJVoVFRp3NV99tCVh9Vt64l8Awxq7xdU89l+pSpkQ+8j3ucP/gKJk0kjivO6kOiIESiuqfOpIy1xybxOgj1r8ZeGw/Bd2Ner1HJ4a9HEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+TVCkY0; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488c2690057so68939295e9.0
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 06:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776261026; x=1776865826; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g79BUYEA9YLVd9gvOkb8IdbY0UtoN0HAYMseG9etvGg=;
        b=O+TVCkY0NtumX0MrCWOhjfrFhpTT7saaAOe06NIJg5zDdL+44/3sZWckhduzZgI/WY
         VFxdjfrWd7J3uXz6bEw+LsCGxQQfVsMevNY4KcHiwcwa5NQWcHZ8UDOLeFB90tD8TNYz
         UX43NNIk7pNYfPwQzxpAo7RuZbNPlhvcVRxgxxG/KTSxaWu/09nSsj9c9BDs0aGikJQd
         1NeYnXPWuCgPwEA3EP89pqywPve2vXvkbxMJRU6yygrHwwZZEUrb28wLqYemXNKDwgqN
         xhjEXat0mKGNk5V9eKP2WgstFfQZFDuADOSGsNsZ/MKvO1iJWa1POErPkuIvIc1aXGyy
         kmpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776261026; x=1776865826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g79BUYEA9YLVd9gvOkb8IdbY0UtoN0HAYMseG9etvGg=;
        b=Q+0gvjnmEhFSRBs8qnG6c4/lIoqHKBsbww7fq8N9d2n21saMZ8IklYN0IuD9FgAzXc
         +IyEBTo/Vw/qIztUUqxskPNIYo35oDQn1KcCoa/5p03cD71jnaOV8CjVgu4Y6fOwiwN1
         d8Bso4SOwnD7v3DmmnmRdSSAwXSAXrgNTf1+9R5610YqbcqnyS05L5Ly0VkA+1tXrFb2
         q8xGw22PTP8L5AiSOajl75rOYuFNIXLhMB5CDR3FZFKlQg6Tg9rYt7IZWitDV0t+KcIY
         XPuUDq8zEM9owsC2+WdGLUykhu7tbwmY9kOdfGu/itZuur6GYkSCsFO3ebGAVnQ5GE0K
         qF5Q==
X-Forwarded-Encrypted: i=1; AFNElJ81H/ztJgJ28qB45jbBU8yiMz8cMOnvCsPBMskrWh4QEDoDKuOcHFV01scuZ4L8NPc8529VHJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEQrcl9zp9ThAUPAYRktHpRaSDiBxonAwjYJgoelw9Xaf8f7QA
	TRipfOML24E6fwUEoyV3u+qFF/+Kavujtg7TZYwRwOh7o96Q7EYW9jFx
X-Gm-Gg: AeBDievdseZAKoIyRUzG9tIkGFVWf1V6ETWBtLmT0NSE2XejQ6Tyt/8ESudceKe9v9x
	QL7aWvLlII2k5FAScNm2qQp/n7s5viAu+AONh0oAOmxOI73qYAb5jNnizk52tnfpBri+TVgPR4G
	LOgM1t1SlJvX8PR7RHaiOVpaX5j0le1ZmTyXQhwSaw0zG6RxE1NvO8QazrvijkOfMN+GP+UUhD/
	AmsKsOUgKS2lODzybJTWi0puNRVuPcRhL2ZgkJLx5xiqjY/+DgkSbg+g589BXmPdVJtX/frKby/
	6FbhzgKVAodn3sbKN9EV6C1pgTYHTM41NkKOBNehuB9A+Lccpacb7mvcMfSfK3bFiUhq4UxCI5V
	T2lA7tjlgztZAREkHubulJF7jSKYOB4Mt3MAQUHYBMg9eXNdbkUywns1cTpB1BFdA5KdAr+wxmG
	rtFnzjLro9W9gZjCjwz44jBtg7pPiE3g==
X-Received: by 2002:a05:600c:8591:b0:488:a824:fe04 with SMTP id 5b1f17b1804b1-488d6abe9e4mr219085585e9.26.1776261025568;
        Wed, 15 Apr 2026 06:50:25 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f0ec6d2dsm20410085e9.30.2026.04.15.06.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 06:50:24 -0700 (PDT)
Date: Wed, 15 Apr 2026 16:50:21 +0300
From: Dan Carpenter <error27@gmail.com>
To: luka.gejak@linux.dev
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] staging: rtl8723bs: fix remote heap info disclosure
 and OOB reads
Message-ID: <ad-Xnciuuz6wqAVq@stanley.mountain>
References: <20260415133726.23515-1-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415133726.23515-1-luka.gejak@linux.dev>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238134-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,stanley.mountain:mid]
X-Rspamd-Queue-Id: 02C99405011
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 03:37:26PM +0200, luka.gejak@linux.dev wrote:
> From: Luka Gejak <luka.gejak@linux.dev>
> 
> When building an association request frame, the driver iterates over
> the ies received from the ap. In three places, the driver trusts the
> attacker-controlled pIE->length without validating that it meets the
> minimum expected size for the respective ie.
> 
> For WLAN_EID_HT_CAPABILITY, this causes an oob read of adjacent heap
> memory which is then transmitted over the air (remote heap information
> disclosure). For WLAN_EID_VENDOR_SPECIFIC, it causes two separate oob
> reads: one when checking the 4-byte oui, and another when copying the
> 14-byte wps ie.
> 
> Fix these issues by adding explicit length checks and returning a
> failure if the length is insufficient. For HT_CAPABILITY, also clamp
> the length passed to rtw_set_ie() to the struct size.
> 
> Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
> ---
> Changes in v3:
> - Switched to fail-fast handling for malformed IEs in issue_assocreq().
> - Fixed HT capability path to use structure-sized output length in rtw_set_ie().
> - Updated commit message to reflect all oob read cases.
> 
> Changes in v2:
> - Refactored rtw_set_ie() alignment to follow "open parenthesis" style.
> - Allowed the line length to exceed 100 characters for better readability as requested by Greg KH.
> 
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> index 5f00fe282d1b..3d44bc36532d 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> @@ -2929,6 +2929,9 @@ void issue_assocreq(struct adapter *padapter)
>  
>  		switch (pIE->element_id) {
>  		case WLAN_EID_VENDOR_SPECIFIC:
> +			if (pIE->length < 4)
> +				goto exit;

Oh huh.  I was more thinking about an upper bound, but yeah we need a
both.  Anyway, what should the upper bound be?

regards,
dan carpenter


