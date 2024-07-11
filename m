Return-Path: <stable+bounces-59117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB3992E838
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 14:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3CF22858F2
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 12:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C21B15B14C;
	Thu, 11 Jul 2024 12:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qB8XhNlj"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49E415279A
	for <stable@vger.kernel.org>; Thu, 11 Jul 2024 12:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720700732; cv=none; b=IYIpBW1kNbE9aQGXwAM+JvggsUGhr0XWJ1juheGgCVvzgV3gldA+FNmJbEynna4OoKkVU8rfBAB31yYEWLsFbXwhbEBriXEcMEPtkB1B3xvL0C5Fc8mmTKUVBeGM/V6/pkgDSv0aZxpGEW5iZTcEf9G8xT9PPYR2IdbIwTQjLNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720700732; c=relaxed/simple;
	bh=+4agpP4fKew4RJi8Fu9CbGGBtivkkmDoF7lWUBBjsTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=da2nOtFXwyA9Zjjp61sgAtM39u/R2O2O4HOGpIwPcp9ZmAHhehw/BC9FjmYSKKLCNQ0HmLl0g6GOqDNWoOwMG6a0Djh3B0jL6BjLIIEBtXbFGVpnD+5WrLsg0/VGCOysGxFbdhdFgO+JvANH1X/K2aue51eczZ/3Qul3m+fOqLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qB8XhNlj; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4279ca8af51so678305e9.3
        for <stable@vger.kernel.org>; Thu, 11 Jul 2024 05:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720700729; x=1721305529; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QsuxKhv37VJtjgsQPrgg4cYo5c3nfgRPfOWIb6JCAwA=;
        b=qB8XhNljJbWzEYqo6JEcqFXUHjTVUyA1TJ2XW8nEq1KZxYL1YAa1UOONoZrOiFAf22
         pwjhwaViInopyvIEam6ay/LnKzevq2PM+wJmsI+2BpYs4z0tX0X//NysK9fMSeGeaMhY
         4k4geKwEl9+5lTLaqO049hge4vUAavUTFUr5y4ijZdCuVx/M9TIODl+ETKSPa3B1q5EC
         3qItCasuV7p87NEaPADbdKhWqZ7Tn90DrL1I82eb+/KrXe2pgs/lx4YO9P8EKTA8ooTc
         qT5NHb/0Y9X1KqhoCDxSJVO3Uz0iII+ekRH2yKqODWVF+k+OJNdkVub0+0yMQkqKfQH/
         0Jvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720700729; x=1721305529;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QsuxKhv37VJtjgsQPrgg4cYo5c3nfgRPfOWIb6JCAwA=;
        b=MxJHFUnOSIeJpkerFf4meEmPC3+W/EY0zSgjQBxmwEN1M5oVlTuOPo0LNly0VINj+D
         HfHlzY1JvhJoO0+JRWW3kr/l4aSTX4rqiEMNo3b5wkIFMgc53/3XTTDN3OaGNI8fSQpR
         xfYEFsSOxlJnNkZvwhho8CoPrpFtfsv5npIv+BFlP8Zkd3YIxPMrCS/LRXliC2sAThsP
         QNiOIx6W0wBUY65Q9dTGAZgqG6TnZ3Rmvh7ouYGV0zyBLggZnHSwJb9kPpzyLCzJp9Gq
         YsOJanABZ9SaHCWEb/tV/q+H6eAn2ibtxTKHBCuXMFJdOdfslcdlft+HMXedLH2+UAvG
         SSYw==
X-Forwarded-Encrypted: i=1; AJvYcCWDuf0haU99yYq0g8DxSeoys7jn9GMkOSvmBj9lacVOVXs6TMDElrVOr2gtke3EXdgLR+2RsjKEwNkpkvKcr7EcWCwnIaZe
X-Gm-Message-State: AOJu0YzbKDJ+pFPK4iDKsXqvM59fWwTET1JQL9eb2idnzbku9j4jkBFn
	K4+H8N1K4hVyu2MqDSdJyT8mYne2zdPes5pDgroICw/stQ5UyV00iV2K0d9py/E=
X-Google-Smtp-Source: AGHT+IFzl7Kbq9YU3O0zMt6IJS1tzDY6wqKPq6NgvTLS9ETYv7JkW2OhVbjBeqsfX2eaFQ7N2dshnQ==
X-Received: by 2002:a05:600c:2d43:b0:426:5fcc:deb0 with SMTP id 5b1f17b1804b1-426707e38bemr55061115e9.24.1720700729221;
        Thu, 11 Jul 2024 05:25:29 -0700 (PDT)
Received: from [192.168.0.3] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427979f5784sm38609385e9.31.2024.07.11.05.25.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 05:25:28 -0700 (PDT)
Message-ID: <b30e10b3-6916-45a3-81c8-182d81d4a34e@linaro.org>
Date: Thu, 11 Jul 2024 13:25:27 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] media: ov5675: Elongate reset to first transaction
 minimum gap
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Jacopo Mondi <jacopo@jmondi.org>
Cc: Johan Hovold <johan@kernel.org>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, dave.stevenson@raspberrypi.com
References: <20240711-linux-next-ov5675-v1-0-69e9b6c62c16@linaro.org>
 <20240711-linux-next-ov5675-v1-2-69e9b6c62c16@linaro.org>
 <fcd0db64-6104-47a6-a482-6aa3eec702bc@cherry.de>
 <aa20591f-3939-4776-9025-b8d7159f4c63@linaro.org>
 <1051b88e-d6af-4361-a4de-95a28ddfad69@cherry.de>
 <078e3274-f592-4ce0-a938-d58a0f88cf84@linaro.org>
 <3646cd1f-09f1-4e80-8d55-a9ac25cbf81d@cherry.de>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <3646cd1f-09f1-4e80-8d55-a9ac25cbf81d@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/07/2024 13:22, Quentin Schulz wrote:
> Hi Bryan,
> 
> On 7/11/24 2:07 PM, Bryan O'Donoghue wrote:
>> On 11/07/2024 12:41, Quentin Schulz wrote:
>> Worst case XVCLK period is 1.365 milliseconds.
>>
>> If your theory on the GPIO is correct, its still difficult to see how 
>> @ 6MHz - which we don't yet support and probably never will, that 1.5 
>> milliseconds would be insufficient.
>>
>> So - I'm happy enough to throw out the first patch and give a range of 
>> 1.5 to 1.6 milliseconds instead.
>>
> 
> Works for me.

Great.

Just for record, I'll update power_off() too to match the logic we are 
applying @ power_on since we've decided the calculation based on XVCLK 
is overkill.

---
bod

