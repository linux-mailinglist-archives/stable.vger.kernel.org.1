Return-Path: <stable+bounces-201015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0A7CBD17B
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 10:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7A4B3011748
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 09:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE94F32A3F9;
	Mon, 15 Dec 2025 09:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yKKOyBKB"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641AA2E5B32
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 09:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765789332; cv=none; b=TpL0MoLhmeymgyNdBBm5e1gc3wBbSdozULvXuWTsQTk/hlsDHol59qlisbamndDbF/wALx5sz3QAqYZxKm6VejVh9uxcu1wIgxfQW4lYC6dDKMk0vSrkpsCtSIQ6JwIurtZcjWVoCY2TffQpoT0pB6HxY1vRFEhIOr/Qf7YmV6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765789332; c=relaxed/simple;
	bh=9NvkoFw7U3ArevfZL6/5aLW0bkMGw3tc/YoZtkn4VXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jj6tekA/jFTRHD/PesgAIBRmGjItgKFLLp6hE528h3D8IEq8bzBDZk4dpdX3eKXGPQRHsnul3b4oZSHcxOltOc4pl43ubQRqUL7Hji9QrkW00Sf1cHCa3tVBo/yHj5mqZbBrGPXpk5T8SVazDIxYLGNSVGubkDk3ppyMJ3kP3VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yKKOyBKB; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-647a3bca834so4890596a12.2
        for <stable@vger.kernel.org>; Mon, 15 Dec 2025 01:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765789326; x=1766394126; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/eh2Jk7y1LUL7tcgTyarCIDEPQpluVmFaeTv2vZoA4M=;
        b=yKKOyBKBwFgjKKBuMLOX27X7d3Z8g8h7omMqnQKBiJg3LRcIjxrno/WMUv+3PitIWj
         J6sLvvhib8vHhoC0pAlih1v7zX1eZ5exw61n78dG0VXs7WIn4jwJGw/TMdjJbMZZ4pf2
         C4gB4qHNRjmvbvUmrzMhdPPNq934OI6g/zcwXAU++Ip3JthqC/A1wlUMlm0pXxxjhmYk
         JiOkU5HNGEVPyGlbTbqlf3lX7Hls1KrI9r4r92JEPzKMMJwx5WHssAE11ZuaY6dNv2dU
         eQQpCw2DJ0yS8ek9qPCO0+76WamBMi/zo3r1VhoCx1VgoykDhPMQDFgZLaHfgpqfyThw
         diug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765789327; x=1766394127;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/eh2Jk7y1LUL7tcgTyarCIDEPQpluVmFaeTv2vZoA4M=;
        b=sNikvbHEZX6Z5CS1TBvj58BuHYd8J9vJZYuno7E7nCFxug3PcOBBP8fwSVAYG3l17v
         DBm1XkroaOTbcJdn0sslqVizFLOg6X1xjxL1lDqH64Kg+7g8rhp23cdOWrw4xgZM8bcV
         72+eyctcvOIEK5RYD7cuzOWOr1tOiq9S+bo5nQjuiu7bhvLQ67mZM+IWNIR73yPV0cIR
         H31BAtu69SqAE53KT2fKb+ccjrSB95CK9gO7Wck8zkFjJh+qBfi6lp07J74zcugHw8YB
         AtW/D7kEBul36ECUCZGgNnUjUeDk3WuY1XgCDbjwL2Qx9bQ4suWEE3oA/zNIuoyIGi8B
         6ZOA==
X-Forwarded-Encrypted: i=1; AJvYcCXxdQvg8QK1YmWRHhpslWx7lZ0aeXXo0H81z9E7SbT+c8cAr51vC9PkF1M+xyWq0PKTkt/DL2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFNdURDtnOpl2NDhxvUdwIi60STyU+upHQ/vyYmxEupm0tO+v2
	2seZ+5drUZzAcmsKH2UmY6acbYHT/nQyBoYmjB3Gcv0W2VpSNRzY1CurXtdRFHoTm4w=
X-Gm-Gg: AY/fxX7q7aw48VK+/7vqJ8iH2pWJXvhlzMYh9EVdue6M01ogZtyRuCCuTmZSDVRtkdW
	Hez5HLRuJX1vTBKs8QNdk+936kO0eALpLeBCjaFKodUFp7WyrdnqfIMSszXirE7pmYFDgmmiCA4
	qXtnBVPQLraxtZbNJ4aZ+x1JuixYAQXRZ8zmpUqecjCj5YlgSuBGmY8Ju4ch6AMK9Q4jkJwvlK6
	YEVfKY2ebAYFJdLlv8I1BG3u7Z39pGUrFEUes8MDYL4ca7E6autfjN0m+PdEKh/Ui9T4B16jWY7
	+X0UuH1hp/nMv/OQpQUWv0uYkV90hkIyNEAe9ow0uOf4+8aOhU3v80RxLVqLxBBu1E1ihORLenO
	Y7O1shInBQvJRt6xeKFULOyvxOUCwDm//TR8rbXhBenElxaKQKI6aD4A0V33Apt8QTDoAkCYHTn
	cuu9XoIMMSqdfh3y6FppK1
X-Google-Smtp-Source: AGHT+IG4myQfras1/40xDmXOQgpwgiM3Ljs8/6uploYCUZ16zAD9bEd9YTmSTzDXHafRBREFjId5kg==
X-Received: by 2002:a05:6402:1446:b0:640:ca0a:dc1c with SMTP id 4fb4d7f45d1cf-6499b16e791mr10050760a12.7.1765789326445;
        Mon, 15 Dec 2025 01:02:06 -0800 (PST)
Received: from [192.168.0.108] ([130.185.218.160])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64981fa5514sm12907579a12.0.2025.12.15.01.02.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 01:02:06 -0800 (PST)
Message-ID: <c698d581-da15-42bf-9612-62f1bad66615@linaro.org>
Date: Mon, 15 Dec 2025 11:02:08 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 RESEND] coresight: etm-perf: Fix reference count leak
 in etm_setup_aux
To: Ma Ke <make24@iscas.ac.cn>, Leo Yan <leo.yan@arm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 stable@vger.kernel.org, suzuki.poulose@arm.com, mike.leach@linaro.org,
 alexander.shishkin@linux.intel.com, mathieu.poirier@linaro.org
References: <20251215022709.17220-1-make24@iscas.ac.cn>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251215022709.17220-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/12/2025 04:27, Ma Ke wrote:
> In etm_setup_aux(), when a user sink is obtained via
> coresight_get_sink_by_id(), it increments the reference count of the
> sink device. However, if the sink is used in path building, the path
> holds a reference, but the initial reference from
> coresight_get_sink_by_id() is not released, causing a reference count
> leak. We should release the initial reference after the path is built.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 0e6c20517596 ("coresight: etm-perf: Allow an event to use different sinks")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Changes in v2:
> - modified the patch as suggestions.

I think Leo's comment on the previous v2 is still unaddressed. But 
releasing it in coresight_get_sink_by_id() would make it consistent with 
coresight_find_csdev_by_fwnode() and prevent further mistakes.

It also leads me to see that users of coresight_find_device_by_fwnode() 
should also release it, but only one out of two appears to.

James

> ---
>   drivers/hwtracing/coresight/coresight-etm-perf.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index 17afa0f4cdee..56d012ab6d3a 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -454,6 +454,11 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
>   		goto err;
>   
>   out:
> +	if (user_sink) {
> +		put_device(&user_sink->dev);
> +		user_sink = NULL;
> +	}
> +
>   	return event_data;
>   
>   err:


