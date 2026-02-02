Return-Path: <stable+bounces-213036-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cI1FDVFjgGml7gIAu9opvQ
	(envelope-from <stable+bounces-213036-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 09:41:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A6EC9BF7
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 09:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8262B30056C2
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 08:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4AB286415;
	Mon,  2 Feb 2026 08:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rq4IwYdU"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C65D261593
	for <stable@vger.kernel.org>; Mon,  2 Feb 2026 08:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770021493; cv=none; b=AYHkCoPjtFYMJmkHosYCU+ckROAMRAP3EP3Vk68Flnsv5xqS3LQ4ssk2LThGU/V8Oz0X9LOj3G1RmK7UpcXzwEz4Rbc7zaE7IZxz4N086xiV2dba8IO2gn7vbfMRP0uh+JbKwsSGm2cmwQ4egUBFAZ80KdYNz3Itf7Ml0aIV2B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770021493; c=relaxed/simple;
	bh=+fmzMPeUWacPPRF3LvbYKkeMsNR3Q87Kspg2bI3U8yI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHhkKWHL6oIvmVprlgAf8l+TPV08SRRB+PPEyFLONUMOCUGZqSuBqKQ2XAYVCX/eaofDLOdM0p0oKZfJ+CfEiZXxieeliCU6J3Ib+uV6ESPci/lRB5B/qlaxCJZgfjrA5HorrRAE8h55MDK/4Zo+Rq4koSzSu2/9scRoB1sd+pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rq4IwYdU; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-480142406b3so29795975e9.1
        for <stable@vger.kernel.org>; Mon, 02 Feb 2026 00:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770021491; x=1770626291; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l1RUynbe4rR3Ig0UQ0DktCKbiavjUNRPlOk68dYYI2Y=;
        b=Rq4IwYdUaZZRQt5sQXnVH1CbPjR13OCr3rvyXdLBYIpyLuFtkWMmTmqxdSUfDlRgWZ
         T03Rd40MjdYs7h/9LM0eXY85HPsS8fypUE+rWagZXT1719D2G+Sww7cXoqhyAuPhog8K
         nrSbG74e5JAn05jZR25lqL/JekalQSasKsQ1RX6s5wVcxv4cVstHTm6KferiexaLmpYz
         4382pdPCjPGbZx6/Ls83//4dq83nvshcBgPuFd7Dk4hcfQUY5Zq42k/PCDaqt3AhAt/p
         HqFkH+JG8QFH5IhBIsHtL7QoYnlKaIrlpvd7LXlMJ6kZ5gFI+7R8gIenxNvplhVgDgWA
         Jihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770021491; x=1770626291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l1RUynbe4rR3Ig0UQ0DktCKbiavjUNRPlOk68dYYI2Y=;
        b=Sgi8TqYM21jmPXJc6Xq6OECmX/0uvd/Z1VMXRUcIPLrPvTVSPvt/sp4P0u0CDhIBwi
         9w8kre2OPhTFXNymtANrfXcPALp+Lpj2FHc17wsnkhsEhSdGTJYIFmKhGorDvNjILsBH
         kXUsq0V/1DPbz2rFpX12/G472tdo4mQP9K3bO1tIa3FdOPjZ5LvSgVaiM2LraL3t7wLi
         5+pc12ZNcBEfo7xcETIfd4pk3vl0ZReX9Pb5o94nuwwMuJnU4sk7mH67BD0HW/DgkX6b
         vnPP2S2uhQaGMn3HdOH/XSfHXwNshyNsgRY9TcnevBplnU0rQ+TEGChAGqaYgBuRrsEi
         Ulgw==
X-Forwarded-Encrypted: i=1; AJvYcCXY1ATKksGcR5oXcwgV6KSeuHOHB0QTy83N6A/zxfXLsaSROrQxIbohK9Vxme+XlAjnjp9VVl8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0JAAWqvnNwZD24CiLNSS8FpB4DGRBCd87jxTORfPpFIWVhAUU
	dA+Drffu4moF2l4gQ9ysTprwq38Z2Pm0nvZ4XcqgY+89VWvOfXgI39BBbIcJIaT+v1U=
X-Gm-Gg: AZuq6aK6cl37dHQ5q7t+iaP8SsVe7C2AjRjB98Tg76REZ+j6xeIeSe/xCyfpkTKnXgw
	S52TytGphubCNnwcd9lwwDCeWcd0zlY02+8FawQ28uY+M79slXrfLMWiBPBmho8aBK8dEvELvJU
	cx36ux0n+mqljNtPTFLbRGiliOSQHYdK55r8OZaOJPgGp5S3nI1TVqo9au1EXvuJI5S2MmMOWH5
	GdhEa47VL2FDB7BQ1Vh9eBPwfIQgSVZET/2TZnPq3pyAoqnPfCxSKTY4ZyUvbs9vM3qZZbQlWjx
	QXSvfH0QwDBzevTEuPs1n7XrJmCGFQEj5ba1zBAHt6nQM0nNYov72428skax25kvIkMNqvsMPde
	Hq0mdihNdM9DRT505t6t4W2eY+b2ZoyNY7XueT16UqiQDy7ockx1PZnVxz6uXbhNPqU8FAV9E0+
	eH9unMOQED4SwIxj3b
X-Received: by 2002:a05:600c:34c4:b0:480:52fd:d2e4 with SMTP id 5b1f17b1804b1-482db012dd7mr143262185e9.0.1770021490711;
        Mon, 02 Feb 2026 00:38:10 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482e267b699sm85202545e9.16.2026.02.02.00.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 00:38:10 -0800 (PST)
Date: Mon, 2 Feb 2026 11:38:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: gregkh@linuxfoundation.org, straube.linux@gmail.com, hansg@kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] staging: rtl8723bs: fix null dereference in
 find_network
Message-ID: <aYBib7CfThRZ28wm@stanley.mountain>
References: <20260202063808.664468-1-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202063808.664468-1-ethantidmore06@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,gmail.com,kernel.org,lists.linux.dev,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213036-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.carpenter@linaro.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 85A6EC9BF7
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 12:38:08AM -0600, Ethan Tidmore wrote:
> The pwlan variable has the possibility of returning NULL and is not
> checked for NULL and then later dereferenced.
> 
> Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> index f81a29cd6a78..29dd0b56223a 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> @@ -835,8 +835,11 @@ static void find_network(struct adapter *adapter)
>  	struct wlan_network *tgt_network = &pmlmepriv->cur_network;
>  
>  	pwlan = rtw_find_network(&pmlmepriv->scanned_queue, tgt_network->network.mac_address);
> -	if (pwlan)
> -		pwlan->fixed = false;
> +

Delete this blank line.

regards,
dan carpenter

> +	if (!pwlan)
> +		return;
> +
> +	pwlan->fixed = false;
>  
>  	if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) &&
>  	    (adapter->stapriv.asoc_sta_count == 1))
> -- 
> 2.52.0
> 

