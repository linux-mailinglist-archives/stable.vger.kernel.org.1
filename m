Return-Path: <stable+bounces-54844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E369912F67
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 23:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D135DB24E5F
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 21:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A431917C200;
	Fri, 21 Jun 2024 21:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S/4Y2Etj"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C191482488
	for <stable@vger.kernel.org>; Fri, 21 Jun 2024 21:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719004910; cv=none; b=b4klv/9qzbBfxvnmaTqLHWqC7DFcr8JVC7eWM2qhQCs5cnFuSrdf0Km0L/8OKZVuwdWTR93+lYD620MST7XgzFIfpCizkoYGq9KQRiZVNNg5iZXZwJ6wD2KnWXai46sNr5wZ8d0QZmY4JIx+jel/KnpS1O8JAWhC6Wg3Cpx+em8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719004910; c=relaxed/simple;
	bh=6OwU3g5/7PEoCA8T5u53wxNdNZACBR3qvz1VZFAE+r0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YdlUn15SzcpNlw66aGO81ra8msDzKQVekO5zingWJU327P/MpnM4lS7wfKyJTxmUlvRtxUoW6fj0iIAK5CqoUe6in745umLzA16k76FG5TadB4/xGzaeU7Lf7J2Ss2cQIUEjA9Pig6qWvjnvF2jIy7vk41T5Pyli0SvlCxAdXXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S/4Y2Etj; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-363bbd51050so1771092f8f.0
        for <stable@vger.kernel.org>; Fri, 21 Jun 2024 14:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719004907; x=1719609707; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dwpodCTQAZQJVX6OzPylhaU++onJn6Fu1+C4vSG5mPw=;
        b=S/4Y2Etj8LP7qEGj2ZnU44xkq5yuAPZAtz2UyKj/pm2pVkVxYUjFqcPvQxyRo14OkQ
         XTSMZpxfhAIKd78psfHwP0NWsYnq+6vzu29h1p527YUpjsUY2R9Zq2yqDIby4BdppFbg
         WXulQiaFDN8ORVFqorllNI0CfG/xKU9nFJ8bR/ibKobl4wBV3YaABUQeB6x+aLiHwkOS
         Qybrp9b9u2yjKAz/mcbm/0jD0iSsVnQu5IX8v/CchUVsQq51L6guKo6Oy1Cbgh5FguEa
         R1sXQ6x2hIppAudJrUWi0kd5kYF2RMNxIm+kPGT5Qqr79EBlHyD0Zk1o7utCD53m0CsN
         8M3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719004907; x=1719609707;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dwpodCTQAZQJVX6OzPylhaU++onJn6Fu1+C4vSG5mPw=;
        b=kLQtx472a7iC/KcsMvBAMREMapMgx5WtnR67qPW3tISTS/efWm+Pw9XmsDUt10mWuD
         oNLA7ZTZ/VhLAypxjsfhHlQeXr81gn63VSfnh8jx4W0cCqyGWSiYMykjc3Ej8OygqA/7
         y6gDLWQC1DohkQILJ3fjOr/FaB7cyOLZxo3fxvST1zEOyFQymO0TF5KzoXyxUkiBK73B
         OpF+uZYqXRLYdzCrc3YeFcI18p9nzShBex0fUSgHMGKWqyrX8k9QAuKtfwOTPdHhuosf
         sVKex1+BIaA1NQs95t5l++Zc2YeS2npheGJBKsL40JqkX6qH4YU1Az1hQqxuS9mWZW1J
         IH8A==
X-Forwarded-Encrypted: i=1; AJvYcCWlkFvfry0Hx3Pxip3tpgQbHXwc1qY37K4/ecynRq/0ZIzmj67BGGupez5HQ/8HBy7nyXn0LKdsi58Vp8V+ROyIc4XZWmYg
X-Gm-Message-State: AOJu0YzHvFp2Cboe81zhVvLyKGLr+f1V3Tz1BxFg8NKGfC9mnV7p/rU5
	xetbIhaC+pleKIiRnJhhcGkoPVNGYppfSrtF+JpBj4fhHXJXQeaYYuwWvOZCoCc=
X-Google-Smtp-Source: AGHT+IEzQ4rIrOnwizgWJWmaBFT5pkt5oc9TgW9owS7sv9mlyk1FyS0hLQMvtFnAXXdLtrJb0u6rEA==
X-Received: by 2002:adf:f209:0:b0:366:dd50:8ccd with SMTP id ffacd0b85a97d-366dd508d96mr1273664f8f.38.1719004907144;
        Fri, 21 Jun 2024 14:21:47 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-366383f6d16sm2793209f8f.3.2024.06.21.14.21.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 14:21:46 -0700 (PDT)
Message-ID: <91d242ae-ece2-4665-ac1e-54694152da70@linaro.org>
Date: Fri, 21 Jun 2024 22:21:45 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rtc: abx80x: Fix return value of nvmem callback on
 read
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Sean Anderson <sean.anderson@seco.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Joy Chakraborty <joychakr@google.com>, linux-rtc@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240613120750.1455209-1-joychakr@google.com>
 <171895100442.14088.18136838489262595773.b4-ty@linaro.org>
 <202406211503118dfe2df1@mail.local>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <202406211503118dfe2df1@mail.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/06/2024 16:03, Alexandre Belloni wrote:
> On 21/06/2024 07:23:24+0100, Srinivas Kandagatla wrote:
>>
>> On Thu, 13 Jun 2024 12:07:50 +0000, Joy Chakraborty wrote:
>>> Read callbacks registered with nvmem core expect 0 to be returned on
>>> success and a negative value to be returned on failure.
>>>
>>> abx80x_nvmem_xfer() on read calls i2c_smbus_read_i2c_block_data() which
>>> returns the number of bytes read on success as per its api description,
>>> this return value is handled as an error and returned to nvmem even on
>>> success.
>>>
>>> [...]
>>
>> Applied, thanks!
>>
>> [1/1] rtc: abx80x: Fix return value of nvmem callback on read
>>        commit: 126b2b4ec0f471d46117ca31b99cd76b1eee48d8
>>
> 
> Please drop it from your tree, I'm going to handle the rtc related
> patches...
> 

Sure I will drop it.

--srini
>> Best regards,
>> -- 
>> Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
> 

