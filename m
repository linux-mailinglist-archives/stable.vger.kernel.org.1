Return-Path: <stable+bounces-194591-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 093B8C51884
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 11:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42AC91889E6F
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 09:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF3B2FF15A;
	Wed, 12 Nov 2025 09:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ed16QTWo"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1C52C0F6C
	for <stable@vger.kernel.org>; Wed, 12 Nov 2025 09:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762941446; cv=none; b=AKWf7I6duzneE2gveq5MwtP4Dm+jHBOvQogc4ogEoGx14lxgEzX6OyTcvx4Eb6GUkrGSGEXSQ51DUTOEPgJpEhWIC/eFIM2Qz/xDRrlJ/xFZTUt7jaAl4qVYD14oQ8kHVXN9BF2sZ5exNIMGVnzaUQLiE6/VkiIQlTNNz4r9Ws8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762941446; c=relaxed/simple;
	bh=h5pc/J9kECEj83qwMGeNWx9aIJNRYX1Hy3xLVwBEJGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GiFtpCZ7qxkcOdA0Vi4k1trHEBM6oAq7e8b32FSGMlU0yIqJSm/v04Piv4It+ACU+yS4nIuplU+tLZ7R205zjoPZBoRF/NTzkLTIeq36J0Wb7DXs/4BLnB9laZ6ZHcGbhflZkKImzCdTAOtpXEp/gwNT1QsYBurtj2CvwIvz9ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ed16QTWo; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so4541845e9.3
        for <stable@vger.kernel.org>; Wed, 12 Nov 2025 01:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762941443; x=1763546243; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=THV2t9S7ZHP7pdKhDRWq/0bVFWuA15jyz8cfeJ9DlQE=;
        b=ed16QTWo5wP1wUMfSQsBaSpY6EeliF8axVT0bnUE+rlO1T+zMnpz3reuiW/Tv5vjms
         S0uP82mGZX7uvbz4sic92If9aNk1LgpgmzTZ+jvaJdR2y6zWTvbCQ7a8tKXpj8fWSW8O
         4Q9grhfH3IuLuEKhpB6BF4El69aiENEBk6x4BmrMWG+ZDm28Mn/hML1CuXvogQCp0NBO
         MXOLO2QAUJya1bVn9CwF5qfOUlgX2lGTFiEz8e+wnyy9/QX1vwd26TxrgP2eRVqKB1/f
         WEQf+DkKjrdIIxO7WDUFc0cM5DKtAcOgCjIO/EO7tfBqneoZus4va+dY2+ZKFB+fiaXJ
         VuhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762941443; x=1763546243;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=THV2t9S7ZHP7pdKhDRWq/0bVFWuA15jyz8cfeJ9DlQE=;
        b=Al+r4/fVXiLull1Dlp+vMruqhTdGmGe5R7G+XfDef80xhxV6ynTqEbCAwA3c/K7ozx
         rNPOzot3ljIxupdKu1hKM2s+Hv+cnRSNISDi1pHrA7PYylYeGWyAMVc7tVqLtliR64+X
         n38VF49aKhc17vBVwr6wmyytoTnU5AE+NxV1gc/3M1M4UzWc2vaMoo8rKRdy91KA6pJI
         3dzuXAaaed24lrkdEilrqODUJ3cU9v9Ofa9u7zcHvqtz0P9sKsgXu5B3kFMPEyVRRpzq
         qhUakXPD02SDqJiQyS1MTvk9iHKH1JGfccA3P2IvYC69PvX0tx7GSfYqxoQFc8v64rHs
         vsiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbBXfWPDTHL/knOOnR7X2WLAhOsHSic1TFRfh6nBQOvNjKpWYfx5P7WQLkRp4E8e4U7NM8ASM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRPplvETtd676kj+fLUuNsbqwfH4oWkz4w3LEew0WS2Vcpgj9V
	/ZLt5SCACDWyd+ggBBAE+oEU6aTZzKEkjZHe+FUTN74c6S5IS41ZHs4h0JhjqIm+FoBZY8H9TiX
	UFyu0fFI=
X-Gm-Gg: ASbGncub4QC5UqtVXpliikOjNE3eSFRBqtS6/4soiWRKsnGWyPg49Lg8x8yK/tAzCpK
	Fw6e62kGPON7k2FJVXQlSkCCmhhUSoc82MYXd5lnsoWirpsCOWDr8IDrrUR5LFTm+UJ1QS49rI+
	acEPOs7TJcytqrD6P3bgHUBfIMHY53FyzzX6L3QajYZaCHvNqzsIvdjg8d7OprTOpmIIThfJVjq
	o0/26BthoZaNzWwfGZqIKLuUrpKrm+NCa7JypEe58+5E9Sf7u0bbl+DwqCndNPyXAav/Ym7hmdC
	BHXixppyfm+LdO+K7dFZJOuy+RouGt5oE//fsmVicfdW4YibkeGiH+82vycnynxrdM9vzaC+d1e
	F36Zmm02CP2+o6ZdopjKthTaI2iJbShx8ciJ6LV0+5DH5mqf2ZkCaczkNXLzzgYVophg6FDjoFP
	fUwXjVe4aMnd51oeuU5vkBh88BYK0CM+PC8fWoTS9+8CeLnbPh2SHY
X-Google-Smtp-Source: AGHT+IE6GPhOCh8HFhZfQQ3ULvU03kQlQmrGmLzCTYmC9ODd7TdLqnbZMWma58iY06JtZBKfzEDdkQ==
X-Received: by 2002:a5d:5f50:0:b0:42b:3aca:5a86 with SMTP id ffacd0b85a97d-42b4bdd0f1dmr1885508f8f.57.1762941442847;
        Wed, 12 Nov 2025 01:57:22 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:23e5:17c0:bfdb:f0d? ([2a05:6e02:1041:c10:23e5:17c0:bfdb:f0d])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-42b2ee2ed31sm26858942f8f.29.2025.11.12.01.57.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 01:57:22 -0800 (PST)
Message-ID: <3c2dee38-46a8-4359-b981-d4e3d53061fe@linaro.org>
Date: Wed, 12 Nov 2025 10:57:21 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource/drivers/stm: Fix section mismatches
To: Johan Hovold <johan@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251017054943.7195-1-johan@kernel.org>
 <7ad2b976-3b0d-4823-a145-ceedf071450d@linaro.org>
 <aRH74auttb6UgnjP@hovoldconsulting.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <aRH74auttb6UgnjP@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/10/25 15:51, Johan Hovold wrote:
> Hi Daniel,
> 
> On Wed, Nov 05, 2025 at 02:32:18PM +0100, Daniel Lezcano wrote:
> 
>> You should replace __init by __init_or_module
> 
> That's not sufficient as the driver can still be rebound through sysfs
> currently (the driver would probably crash anyway, but that's a separate
> issue).
> 
> Also note that no drivers use __init_or_module these days, likely as
> everyone uses modules and it's not worth the added complexity in trying
> to get the section markers right for a build configuration that few
> people care about.
> 
> I can send a follow-on patch to suppress the unbind attribute, or
> include it in a v2 if you insist on using __init_or_module.
> 
> What do you prefer?

I think it makes sens to use __init_or_module because these drivers have 
been always compiled in and we are converting them into modules.

[ ... ]

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

