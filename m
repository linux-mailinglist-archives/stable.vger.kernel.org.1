Return-Path: <stable+bounces-249121-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCy9MCn3CWrgvgQAu9opvQ
	(envelope-from <stable+bounces-249121-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 19:13:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECF75626D6
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 19:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04B51301F9BE
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 17:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263D83C3BEE;
	Sun, 17 May 2026 17:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="kRZ9RGN1"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1769C33ADA8
	for <stable@vger.kernel.org>; Sun, 17 May 2026 17:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779037963; cv=none; b=eqJsjyhTa3gUbjmHNBojKbRZCQwxf49XTWPceyor3l//nCk+ha7zjhL0p/UqQ+EIKLaXph5L5gXRxXwAV99sSPNW1frp4EHkebXCNouQkOHwNUw+D1kWgrc4L7V81TkMntvnzaFRiO+xmjVC90gPgDb8huoVPuSkNCDKtGAGYK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779037963; c=relaxed/simple;
	bh=rncEqY2lnCflhGiKv/GKEoLLk/JmJ7O9b8tC7N387QI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RQuB5g6vvkXRF4mQNAu84kqMAIoUbI4bk0XzYGrge3e/FwP3qqY6NQx0JKAQ2eU0G/4FvrEGbsTZr6HG+++65YJSRZynmzSzkvdJSK9OLAhtRM4UlGpBWDoH3H4Qp4inFbnrfKH33q6oHEFivfxCRcrXTH7ojtH+bAXTycMNC5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=kRZ9RGN1; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-439712b3416so244409fac.2
        for <stable@vger.kernel.org>; Sun, 17 May 2026 10:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1779037960; x=1779642760; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5xXk1rxT9NJV1FgwYVhJyOKtq8DN0GT5xvOX7oCK3To=;
        b=kRZ9RGN1n1X1S+xxGXGESjXX4bGdBJrR6oAPHSLXBhf+3YbH0Vvv2wqMIYitV224TA
         Fkli3ritROMh6JYMb5tCwAgk2erWY2yi2uaccJ/O5isWKPdr/513Dap9LLQ/oFfP3oUs
         /bnJUuBz6kOTnIQLGsAreZhj+dpHiBk4JO3gqYCxp0DdSc5fGwUC8sX6eZBymWAzVM2C
         LTbxZ4/zaTgSS8RaegvXiQW6D1QC9Epht9z2rJm01TbgVjR+4sNb+4p0wFAPFyVe50eJ
         /hrOzQGHsZPQs+O4YPL9/KOL+TcKWFKlMeKPQbWoU1L7povjMwRydzUfIg4LM1nf+qMM
         luOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779037960; x=1779642760;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5xXk1rxT9NJV1FgwYVhJyOKtq8DN0GT5xvOX7oCK3To=;
        b=bUD0IcGmxrgTKBpLMIs+/TPG0n8uIopX12OXttW1qAFLv9rCjiFp28+ne+RIlzvlwT
         6+6yaCJU65lASmNS4at8By8ROidNAg7oVQTKY6cgolf7fLctKHzg4s55tyNVmtVZHAnu
         6CDTDQ+1C6MEi6quc2NlOnZq+qbDcEgazT6NYBcFtyq71wPzSSjSEhmmz9Au50k+BmZU
         NmFaHJIPG0GsM98kwL/94+XTtJ0NcjrPh43tEHP8njkPdD2TWJfApN1addKGvKp5ziIU
         hdAYMA9bSjsxfOcArksbGrlcTH7dkSHEJ1Z90wMA06dosFxHVoap8hnNgCYM5Cq6yciO
         1vWw==
X-Forwarded-Encrypted: i=1; AFNElJ+rVHxQRTHueyhnlFel9OJmCNGKRzuJ1eSF0l/ZSHbrQABQ18qfqwgr7bQMZy1trEE1CCkHk7o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq714fU9B2gtiFA3yIPPKgA5ctqt1RdpcrtrYTxI0ZrbVvIsQ2
	MUBkfrb3PzUuu8O5g5doq2iw/0u3GstU3o4wOL0BeofFQd9cmcp9S46JVf3ssALSslY=
X-Gm-Gg: Acq92OES3A7ue778kg2kaXMOV0xRdyM/4I/CZN+W5QMtVzWKVnqhPTZqrNdQd92ynWc
	88qlIpTCxmU1uV8o7NZeG0MiyOfLRoY0Wlc6427Z+M+LbvMb4igwfzMdJJxaE8xFB2Ugg8i07lV
	k6+OQ3Ui/HZ7uktYO+Spbz/kOs2B8WZmiBbZZ2QjF0tnY0bg+VpNe6AFiaI++bObxe58GxgVKH6
	stfHr7eNg/t1wk9DfJ/Pkr+KqgsYh7DYVmtV+PiW2av3nZE6Z7kQv8W6JmWlK+acfHvYTznpp+V
	AC5cVcavGLPsExRuex/JkXbB033IDQO09NGB+EDXR1Vm+Y4P/44282FrLRHbG9Ly6zrRemvwHLf
	8lnksx9s3umrMv3i+phVuOw/BPPJmuqPOM3Qj6jlYQ8Au5HsVsGA+mNROJrxdUS7tisrEwAN0mw
	Pz8PDglVRut4VXghpFn234TAp1IG2A0xwHakY6+i8oL8Oe1LLqzLKb3YpMBUWlsRb2U90y+eRjk
	nPB+HIe4A==
X-Received: by 2002:a05:6870:b0f6:b0:439:7835:136c with SMTP id 586e51a60fabf-43a2dce8716mr7226411fac.23.1779037960055;
        Sun, 17 May 2026 10:12:40 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:7a4b:ddf0:f61:f58d? ([2600:8803:e7e4:500:7a4b:ddf0:f61:f58d])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43a94fc2cdbsm2007319fac.6.2026.05.17.10.12.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 May 2026 10:12:38 -0700 (PDT)
Message-ID: <54ee1fba-3209-4192-82c3-674a1ae3ca8f@baylibre.com>
Date: Sun, 17 May 2026 12:12:38 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: pressure: rohm-bm1390: notify trigger on all error
 paths
To: Stepan Ionichev <sozdayvek@gmail.com>, mazziesaccount@gmail.com
Cc: jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260517160801.269-1-sozdayvek@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260517160801.269-1-sozdayvek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1ECF75626D6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-249121-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlechner@baylibre.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre-com.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,baylibre.com:mid]
X-Rspamd-Action: no action

On 5/17/26 11:08 AM, Stepan Ionichev wrote:
> bm1390_trigger_handler() has three error returns:
> 
> 	if (ret || !status)
> 		return IRQ_NONE;          /* status read failed */
> 	...
> 	if (ret) {
> 		dev_warn(...);
> 		return IRQ_NONE;          /* pressure read failed */
> 	}
> 	...
> 	if (ret) {
> 		dev_warn(...);
> 		return IRQ_HANDLED;       /* temp read failed */
> 	}
> 
> None of them call iio_trigger_notify_done(). The success path at the
> end does, so on a single transient regmap or pressure-read error the
> trigger never sees its use_count decremented, and the
> !atomic_read(&trig->use_count) guard in iio_trigger_poll_chained()
> drops every subsequent dispatch for that trigger. The buffered-data
> flow stays wedged until the trigger is detached.
> 
> The IRQ_HANDLED return on the temperature path additionally leaves
> the temp branch's last partial state in &data->buf.temp without
> pushing the sample, which is the existing intended behaviour; only
> the missing notify_done() needs fixing.
> 
> Funnel all returns through a single 'done' label that calls
> iio_trigger_notify_done() before returning the saved irqreturn_t.
> 
> Fixes: 81ca5979b6ed ("iio: pressure: Support ROHM BU1390")
> Cc: stable@vger.kernel.org
> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
> ---
>  drivers/iio/pressure/rohm-bm1390.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/pressure/rohm-bm1390.c b/drivers/iio/pressure/rohm-bm1390.c
> index 08146ca0f..c18352399 100644
> --- a/drivers/iio/pressure/rohm-bm1390.c
> +++ b/drivers/iio/pressure/rohm-bm1390.c
> @@ -626,12 +626,15 @@ static irqreturn_t bm1390_trigger_handler(int irq, void *p)
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *idev = pf->indio_dev;
>  	struct bm1390_data *data = iio_priv(idev);
> +	irqreturn_t result = IRQ_HANDLED;
>  	int ret, status;
>  
>  	/* DRDY is acked by reading status reg */
>  	ret = regmap_read(data->regmap, BM1390_REG_STATUS, &status);
> -	if (ret || !status)
> -		return IRQ_NONE;
> +	if (ret || !status) {
> +		result = IRQ_NONE;

IRQ_NONE means that the interrupt wasn't handled, so it won't be cleared
and the handler will likely just run again immediately. So it probably
isn't the right thing to be returning in the first place.

> +		goto done;
> +	}
>  
>  	dev_dbg(data->dev, "DRDY trig status 0x%x\n", status);
>  
> @@ -639,7 +642,8 @@ static irqreturn_t bm1390_trigger_handler(int irq, void *p)
>  		ret = bm1390_pressure_read(data, &data->buf.pressure);
>  		if (ret) {
>  			dev_warn(data->dev, "sample read failed %d\n", ret);
> -			return IRQ_NONE;
> +			result = IRQ_NONE;
> +			goto done;
>  		}
>  	}
>  
> @@ -648,15 +652,16 @@ static irqreturn_t bm1390_trigger_handler(int irq, void *p)
>  				       &data->buf.temp, sizeof(data->buf.temp));
>  		if (ret) {
>  			dev_warn(data->dev, "temp read failed %d\n", ret);
> -			return IRQ_HANDLED;
> +			goto done;
>  		}
>  	}
>  
>  	iio_push_to_buffers_with_ts(idev, &data->buf, sizeof(data->buf),
>  				    data->timestamp);
> +done:
>  	iio_trigger_notify_done(idev->trig);
>  
> -	return IRQ_HANDLED;
> +	return result;
>  }
>  
>  /* Get timestamps and wake the thread if we need to read data */


