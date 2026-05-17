Return-Path: <stable+bounces-249120-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KokLuD1CWrDvgQAu9opvQ
	(envelope-from <stable+bounces-249120-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 19:07:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A939C562659
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 19:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B40CD300293A
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 17:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38AA3C13F1;
	Sun, 17 May 2026 17:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="mFmthNfo"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D110347532
	for <stable@vger.kernel.org>; Sun, 17 May 2026 17:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779037659; cv=none; b=gJBG/LBwzce+4zVzuvIQa8ViXT0LTudB5Wf7CG5fO85Vc1B3KBmxex8+J7lSqGkEc8s7kXtxpBY2BkshQC/1PsmMn3xBcNQiG8ZMBuKlbgqvwFosEsnZ4XdKY0Rh8/2nho8XSC3ZCq8Y4LSmIO53h+ds3Q4CVVSjjWwv0nloeRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779037659; c=relaxed/simple;
	bh=B+gnwHBAfIoCpLNTcKZqdCPscmLQ/yi14UzJTcxzsQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JZjMHRFKwSaoViWoeQrOeWl8dai6J19M90301VhBaR/amITL9TiEPqc5A56fGF617czhnyzTsG9ESlhV3bpKPZ7tKvlVzKxqecpz5VNPamJTGqUekxP238CZzgv640beW4JzXz4b0OdBU8BULOcbJKguiQIPgA2h4fkC8tUyuQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=mFmthNfo; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d4c383f2fcso1616370a34.0
        for <stable@vger.kernel.org>; Sun, 17 May 2026 10:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1779037655; x=1779642455; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hrOnBFPP1Ld1TfCVTVS9lLZmmZK95raO/NO3JK/+lUU=;
        b=mFmthNfohzVMZ/SaWMnJUpMphLArtL698X24lYrEPvcrhq9//Pfwe7lBnuwY1j4Ljy
         4/3abvjznNBNAXb6Tei/ErnSjbJUkmh+EfapJfxWpzr7BDnpWn5YJ4Qh8+uf2OadvaCK
         H9ro9NzH10bqO0CNUH7L8JLnRcj8H7utZUZpLz0rPJ2+DeyQD4bMmYZ3vreJAKMWsqyo
         HH0BEuz+IbQ4PCW/FgRA/FjpzyY2yoE5Eyxw3qyK9LUcW0nZ8Eky4YzwQq0P/m8iJcv0
         REQMoDSE9jd3dnaz8dkbBehKoIMY+Lh3F4XDXMb3acXjyAmnaDRtOxB1EiHl+qfG17be
         u7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779037655; x=1779642455;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hrOnBFPP1Ld1TfCVTVS9lLZmmZK95raO/NO3JK/+lUU=;
        b=Ay/o4Ewd/5ncABLSqxEovabFyz992LD76vZQJNUTBsg43eUJdtcJjYCzS6rmV1m2gU
         tphrnkmOsxX6yoEFizmNDeOGXpODCWEJ+IkOGVvHW+7qmyQVFTuoYoJ3tBGvTZfDrPU7
         eGJ0CtN3CheV/SDVx38JeLh/AcG7OC5UQzNN+gt92QJ9YX4lt68viqpRFajkShurW+5Z
         di74ZyTCfb2cMHOqkDCbYJnWcXeymV5oGl6pz42y/0HUs7Q60gSa6sGzICcs4ydIF9ku
         2dFS9YFb3vfymE1D3DsAacgsb4YfbW3l4CYWbcfBjZvfDMWAkH5+I9MmGDNJU6y1/IXB
         OePw==
X-Forwarded-Encrypted: i=1; AFNElJ9IkaLGPAVIe74eBBZZrDzvapp5xWEAgsioK9gmjrFMOm0mZlQjJF/OkALY2lhTIFWfZL1/tMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCkbxUOLKH5mbfqPmKzq/kMoNgptsON4YjsWMzLeRDFpePtr8J
	W50IqOJpMfWKvqv2WFzL/R0P+28ra+oPqhQ1ihgQx5UGD3LTUlup96RMKOGsSqZRJy8=
X-Gm-Gg: Acq92OEhn8d0MlvyT9RSAY4HpWF0aBGcfugsAxzzQa0Ho/eX74l97Eg1UBvyoRcW4Xc
	ld+7nqJC+wEOJk/gouzvpIvmGshTbL49xqZt/BNRnZgYdt3VE36yIy9we4wVC4vr6BsYyJZmacX
	1NLQ9UVAqUntXQFc2muV52R74E/lGJmMkt8DXhrh9i6dGWHgqgrRwWjjj0I9mmSWa+sydUt9Dc5
	Uc5rGEBbz8WGMyI3vyQK/HonOBEh+hFpEcPEWhHM9oeZKNFosJkRvkPiF67Ls3jznuZMPT9OIIG
	4YGZsmTJQWZyPsQ2qt0WOPsD5blNRn0n8NsPevLfocUVA83FiyXi2BGQdfJZXMGYw67pAIam8wC
	0BBTji3S/+I89t+MMz853QnPOvyO5pIB51e56Z2mSI3G/PAVTGf1Mnkgyw5ve8DnOfOHfERn07e
	bBeF6AEBledZBVnKJwUPsjtwKl+V5imwprZoHW6nqUTJ0oiSwKkyx2iHrXQ2T2RSpAdQLQU64=
X-Received: by 2002:a05:6830:710e:b0:7d9:71fa:3079 with SMTP id 46e09a7af769-7e4f2a13f65mr8565931a34.10.1779037655575;
        Sun, 17 May 2026 10:07:35 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:7a4b:ddf0:f61:f58d? ([2600:8803:e7e4:500:7a4b:ddf0:f61:f58d])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e55bc111d6sm6311763a34.19.2026.05.17.10.07.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 May 2026 10:07:33 -0700 (PDT)
Message-ID: <57d1d577-39fc-47bc-b01e-a2cc1d2ebdbd@baylibre.com>
Date: Sun, 17 May 2026 12:07:33 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: nxp-sar-adc: notify trigger on channel read
 error in buffer ISR
To: Stepan Ionichev <sozdayvek@gmail.com>, jic23@kernel.org
Cc: daniel.lezcano@linaro.org, nuno.sa@analog.com, andy@kernel.org,
 gregkh@linuxfoundation.org, hcazarim@yahoo.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260517162346.189-1-sozdayvek@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260517162346.189-1-sozdayvek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A939C562659
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,analog.com,kernel.org,linuxfoundation.org,yahoo.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-249120-lists,stable=lfdr.de];
	DMARC_NA(0.00)[baylibre.com];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlechner@baylibre.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,baylibre.com:mid,baylibre-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

On 5/17/26 11:23 AM, Stepan Ionichev wrote:
> nxp_sar_adc_isr_buffer() bails on the first channel-read failure
> without calling iio_trigger_notify_done(), so a single I/O error
> leaves the trigger's use_count stuck and the buffer flow wedged
> until rebind.
> 
> Route the error exit through a 'done:' label that always calls
> iio_trigger_notify_done().
> 
> Fixes: 4434072a893e ("iio: adc: Add the NXP SAR ADC support for the s32g2/3 platforms")
> Cc: stable@vger.kernel.org
> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
> ---
>  drivers/iio/adc/nxp-sar-adc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/nxp-sar-adc.c b/drivers/iio/adc/nxp-sar-adc.c
> index 9d9f2c76b..ed004812c 100644
> --- a/drivers/iio/adc/nxp-sar-adc.c
> +++ b/drivers/iio/adc/nxp-sar-adc.c
> @@ -341,7 +341,7 @@ static void nxp_sar_adc_isr_buffer(struct iio_dev *indio_dev)
>  		ret = nxp_sar_adc_read_data(info, info->buffered_chan[i]);
>  		if (ret < 0) {
>  			nxp_sar_adc_read_notify(info);
> -			return;
> +			goto done;
>  		}
>  
>  		info->buffer[i] = ret;
> @@ -352,6 +352,7 @@ static void nxp_sar_adc_isr_buffer(struct iio_dev *indio_dev)
>  	iio_push_to_buffers_with_ts(indio_dev, info->buffer, sizeof(info->buffer),
>  				    iio_get_time_ns(indio_dev));
>  
> +done:
>  	iio_trigger_notify_done(indio_dev->trig);
>  }
>  

This is fine. Although we are already duplicating the call to
nxp_sar_adc_read_notify(). So could be OK to just call
iio_trigger_notify_done() and return too. Let's see if anyone
else has an opinion.


