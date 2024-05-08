Return-Path: <stable+bounces-43465-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBAA8C037A
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 19:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2819A2890B6
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 17:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02BA128806;
	Wed,  8 May 2024 17:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="INisVFej"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262B820309
	for <stable@vger.kernel.org>; Wed,  8 May 2024 17:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715190227; cv=none; b=ePtv4hnVcfUomjb0iHg6lbT6MdoTkIqUgN2U1fe1Ja3swoyajZv8WNGuhGIJIOU/2Dx5m+BO4G7FxY37afBm9kWB7iGUI56s386WZdTYCg2fvIz+hax1jT+FwUQo1pIyyegI/KAh19XabHHHtKs5YozPKHvbMZbb7MycSRDGKz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715190227; c=relaxed/simple;
	bh=31XmwO5nXS1nwEapBk2NNksodlmCulY6cmDlawgK3qs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qeq5iMlzRGWosLnI7LXYQ0VqqzvVcp3vt4tbeCv86I59M7nuD1q1rb0e8JQHi1ol/QNByraJqLTKRQ0k6vPtZFPyi6IEtTcmJxhYsYtGCwkkyNSFNLCNV9I7P5Ta9itr3as5kEgfvm+6fqggp3tmMdyNcrdEw2B9boOXdy7Zlr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=INisVFej; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41ebcf01013so350425e9.0
        for <stable@vger.kernel.org>; Wed, 08 May 2024 10:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715190224; x=1715795024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=idEaMcbGFaK4BQgFvbB0b5BDKYmvMsNLNj6qCW0EDH0=;
        b=INisVFejlQ1rTtIijaKpKsCM5C1LOXcWblW7Bfb9xL147+SQECDaaNw61uoWiMfvfS
         /KmnYfmYLJNqwVQpMlEciNglye3xUFw77UEbWETf5tskPxn1EvidTyJQ9anvTf8A+J+Y
         mJSHELJ4eTpMmnHWvsj4JMYdlkMEsifxTMM3erwilUZYZ6QHg58KC7VV0hZk2fVcTcEQ
         9HuZMONxY+SDRFVSvVrOYFddpAO1h8oVsg49ewi03G902Uf+o34e7EOnbutFxORzXgzD
         MSk7bwpCdzqhRUvEYrXdiCH8TuQxFsthtpqIhJcyLXzoocv8lWS0cFG8XGxMC+MsDT6n
         TKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715190224; x=1715795024;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=idEaMcbGFaK4BQgFvbB0b5BDKYmvMsNLNj6qCW0EDH0=;
        b=RlL+NvzzO07a8leJ7bNULLSwrYj0Xm1bYRo+LdfVjd16E2XpAh3V6a67Qdq4gEP9Fn
         FMhsA5HiFMqltfPu/Qq+zi1rU/OF0D+LRT0AeNt6Au2nisD0Hc1x+d+ZYvELSshx9yin
         3X7uGI9EvodPd2Y0p4j6MvpHBrCTA7BkbOhpeUOSWwP0EfsLXLE7sbJ3xpB+OOWoCLBK
         6QWgYNPMXUODpojJ5w+glQS2GbH7lt1P5n+F9BLF+CcX9kvS+RRdyk44TtMRiBeL+Z3l
         oFGZ5TwyT3f/oLh3YjbM72pwhq62513+ge0HbE0Wc0npYyIX93nfUhEACP06Wkg6+Xdc
         zZew==
X-Forwarded-Encrypted: i=1; AJvYcCUPdr+ws6G3UNkyw2U1Yc26QRCBvMrAfBqtY2iBnu11q+621TucVTcT8xdMHCdKR8nz/MKqTU5g+3GnARrt1Yw1ftszalqa
X-Gm-Message-State: AOJu0Yz3SEeePydJeqCKLjr+GtPztwzrkF0/NMUHQrjG1FiqGD+9gdGc
	nnVDTvjXrtHDqaJTnZ+Sj8TVxMXHA8Fs+3tx8wZC4J7+sR/alD9sMT6feglQKXQ=
X-Google-Smtp-Source: AGHT+IEu1aW4a8E99d+7lWp9ZffFtuGe8/3woIj3ozR0DQZMe/xC4frcR0jBIUcfvK8mmbuAyGoGxQ==
X-Received: by 2002:a05:600c:1d05:b0:418:d3f4:677b with SMTP id 5b1f17b1804b1-41fbce7ddc9mr2866845e9.17.1715190224639;
        Wed, 08 May 2024 10:43:44 -0700 (PDT)
Received: from [192.168.0.3] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f882086f0sm30355515e9.42.2024.05.08.10.43.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 10:43:44 -0700 (PDT)
Message-ID: <613657e3-0ddb-47f7-b66b-e1462b6a6282@linaro.org>
Date: Wed, 8 May 2024 18:43:43 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] pinctrl: qcom: spmi-gpio: drop broken pm8008
 support
To: Johan Hovold <johan+linaro@kernel.org>, Lee Jones <lee@kernel.org>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Das Srinagesh <quic_gurus@quicinc.com>,
 Satya Priya <quic_c_skakit@quicinc.com>, Stephen Boyd <swboyd@chromium.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 stable@vger.kernel.org
References: <20240506150830.23709-1-johan+linaro@kernel.org>
 <20240506150830.23709-10-johan+linaro@kernel.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240506150830.23709-10-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/05/2024 16:08, Johan Hovold wrote:
> The SPMI GPIO driver assumes that the parent device is an SPMI device
> and accesses random data when backcasting the parent struct device
> pointer for non-SPMI devices.
> 
> Fortunately this does not seem to cause any issues currently when the
> parent device is an I2C client like the PM8008, but this could change if
> the structures are reorganised (e.g. using structure randomisation).
> 
> Notably the interrupt implementation is also broken for non-SPMI devices.
> 
> Also note that the two GPIO pins on PM8008 are used for interrupts and
> reset so their practical use should be limited.
> 
> Drop the broken GPIO support for PM8008 for now.
> 
> Fixes: ea119e5a482a ("pinctrl: qcom-pmic-gpio: Add support for pm8008")
> Cc: stable@vger.kernel.org	# 5.13
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> index f4e2c88a7c82..e61be7d05494 100644
> --- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> +++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> @@ -1206,7 +1206,6 @@ static const struct of_device_id pmic_gpio_of_match[] = {
>   	{ .compatible = "qcom,pm7325-gpio", .data = (void *) 10 },
>   	{ .compatible = "qcom,pm7550ba-gpio", .data = (void *) 8},
>   	{ .compatible = "qcom,pm8005-gpio", .data = (void *) 4 },
> -	{ .compatible = "qcom,pm8008-gpio", .data = (void *) 2 },
>   	{ .compatible = "qcom,pm8019-gpio", .data = (void *) 6 },
>   	/* pm8150 has 10 GPIOs with holes on 2, 5, 7 and 8 */
>   	{ .compatible = "qcom,pm8150-gpio", .data = (void *) 10 },

Since there are no upstream dtsi users there's no harm in dropping and 
re-adding when i2c can be taken account of.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

