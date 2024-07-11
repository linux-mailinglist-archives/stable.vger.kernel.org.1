Return-Path: <stable+bounces-59110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BB992E6A7
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 13:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 312D11F26380
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 11:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A1F15B116;
	Thu, 11 Jul 2024 11:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HB50Gyk/"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEA615821D
	for <stable@vger.kernel.org>; Thu, 11 Jul 2024 11:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720697077; cv=none; b=eIFlFmJ/9QRF972j6nn0xxKWlrCDaTjntzxARpivpLgE5OJPpcXuPzrTw/XTPq4GhhbtDaQcJ+qZEqn4XdIPkcww9O+wleDkoE0XK0e0eOtKNkJNyM9st+fUGLTYopZwTzIwZFWYYZhseHBM9cC7fG0ltPTVcy0Sb2ERk6V4P1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720697077; c=relaxed/simple;
	bh=/9oArPsq57wbS0FYuGBqiYy7h9TmwdEnt+Vdtx21jTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FkNJsi2ix62rR0ar/+jEtjwUsAcHxScA0tO5U5+vh0HeU1xvPXbeXQw6rZ+Wy2HCsIMY2wFtcfXc/eakVfAPCb3KCPQd875o7CVB8p8iAuliVYCwhaNrkr945c3VOkSSHFLd2H0kGaO4AmLzs4AZMRTnA9vrG3q3zSD3sXT0+78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HB50Gyk/; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4266b1f1b21so5105115e9.1
        for <stable@vger.kernel.org>; Thu, 11 Jul 2024 04:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720697074; x=1721301874; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7J3XmVGRUwfePfxIWcbxVXHrQGcPTlGlP9ANwNd5N5M=;
        b=HB50Gyk/IIdd8Jjt+ZJbamW10O+oxUOzC5bcyxUuPFE4RJrQlixxZi0b/IXjCrXt9X
         VcPDPrM3jkyMz1+3Nm2iJQxQRfZWp7cYzUMHRBvV2cNN+g7c6sso/ekyFMEMlffeXMpi
         sg5kxHstWJ2wN4zItA0/awsU3HWowpV/gIgQSeMCgAMmlOdjgZjBMgw4igkEmtv1/4qn
         PkkEerff0lC3qo7BKESqQF3v759QaHTVMG94UkR8t5hXGiGbYUt+8JjknLEgJGgj6rcr
         P6lBnO5fVkzEHzVuwqK/f1jQJkQDtg2/h+DXiUiaRGOC+ALRjcJkJpzrwjBdKxWm3Mlw
         /AGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720697074; x=1721301874;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7J3XmVGRUwfePfxIWcbxVXHrQGcPTlGlP9ANwNd5N5M=;
        b=jd18jlLvODn/pM9x+c2R4XJnWUJdtWU9MLsK1KIBV7gcvuEyi9gS9j9RBonKfnkV5H
         S4HC/DfZ5lrDh056XCJUAt6c/AfG/yXkBqttATFgT/APjQdx66PlhmlbWQTEWv9lNMk0
         kdyXYzXknkcwkVph33Lio0ZQT9TfF099pWbigvwl9sN9ScwVf9k3V4TjIcggPvi+3PUm
         Mz/I7T6ZwCx+I0Jf1ood5OYcPUYuQnZ8gvyTLetSODI3Ml94vNeLQm9VP/i3TFeFZble
         1buUHrWUVIcC96t4W1nmWXUJeWQk25kZCRROgTv3jtUL1HCdJNHwWb+QoEqjq12IPMzf
         cmrg==
X-Forwarded-Encrypted: i=1; AJvYcCV7S91hPWI2qGzcADgAALG+e0SMGXN4deHyiQFBiA9IiLQxkGqzK+NL5dC3ESrq/6W7oFzbv/kk93eBeftcZDHns86r7aAP
X-Gm-Message-State: AOJu0Yy3bbEnmna9pvwDhhhBJgioQInCSscdftl64TmCAEta9IUZF8Bv
	OESuobKBvNSxEfUpuDFGq7vuotiZ7lInD7wCwoRCVEwOl8+wLCxz4bzz6J8wdIM=
X-Google-Smtp-Source: AGHT+IH+MrhpKULhyNqDavQn/HmaV04zZUuIb4CtelgvAjidvApzydEGwVdpRswc/d+4R9FRlMUmJA==
X-Received: by 2002:a05:600c:4653:b0:426:5ccc:df62 with SMTP id 5b1f17b1804b1-426709fae88mr45907865e9.41.1720697073933;
        Thu, 11 Jul 2024 04:24:33 -0700 (PDT)
Received: from [192.168.0.3] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42673d7f528sm101758575e9.9.2024.07.11.04.24.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 04:24:33 -0700 (PDT)
Message-ID: <aea131bf-416e-4e58-a64b-0353b63340ea@linaro.org>
Date: Thu, 11 Jul 2024 12:24:32 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] media: ov5675: Elongate reset to first transaction
 minimum gap
To: Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Jacopo Mondi <jacopo@jmondi.org>, Johan Hovold <johan@kernel.org>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240711-linux-next-ov5675-v1-0-69e9b6c62c16@linaro.org>
 <20240711-linux-next-ov5675-v1-2-69e9b6c62c16@linaro.org>
 <fcd0db64-6104-47a6-a482-6aa3eec702bc@cherry.de>
 <CAPY8ntAgjnA2NFRG_qaDnHvzWVX_VJ8ONCVvuJhPQgvSxwD0Uw@mail.gmail.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <CAPY8ntAgjnA2NFRG_qaDnHvzWVX_VJ8ONCVvuJhPQgvSxwD0Uw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/07/2024 12:17, Dave Stevenson wrote:
> Hi Quentin and Bryan
> 
> On Thu, 11 Jul 2024 at 11:40, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Bryan,
>>
>> On 7/11/24 12:20 PM, Bryan O'Donoghue wrote:
>>> The ov5675 specification says that the gap between XSHUTDN deassert and the
>>> first I2C transaction should be a minimum of 8192 XVCLK cycles.
>>>
>>> Right now we use a usleep_rage() that gives a sleep time of between about
>>> 430 and 860 microseconds.
>>>
>>> On the Lenovo X13s we have observed that in about 1/20 cases the current
>>> timing is too tight and we start transacting before the ov5675's reset
>>> cycle completes, leading to I2C bus transaction failures.
>>>
>>> The reset racing is sometimes triggered at initial chip probe but, more
>>> usually on a subsequent power-off/power-on cycle e.g.
>>>
>>> [   71.451662] ov5675 24-0010: failed to write reg 0x0103. error = -5
>>> [   71.451686] ov5675 24-0010: failed to set plls
>>>
>>> The current quiescence period we have is too tight, doubling the minimum
>>> appears to fix the issue observed on X13s.
>>>
>>> Fixes: 49d9ad719e89 ("media: ov5675: add device-tree support and support runtime PM")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>>> ---
>>>    drivers/media/i2c/ov5675.c | 9 +++++++--
>>>    1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/media/i2c/ov5675.c b/drivers/media/i2c/ov5675.c
>>> index 92bd35133a5d..0498f8f3064d 100644
>>> --- a/drivers/media/i2c/ov5675.c
>>> +++ b/drivers/media/i2c/ov5675.c
>>> @@ -1018,8 +1018,13 @@ static int ov5675_power_on(struct device *dev)
>>>
>>>        gpiod_set_value_cansleep(ov5675->reset_gpio, 0);
>>>
>>> -     /* 8192 xvclk cycles prior to the first SCCB transation */
>>> -     usleep_range(delay_us, delay_us * 2);
>>> +     /* The spec calls for a minimum delay of 8192 XVCLK cycles prior to
>>> +      * transacting on the I2C bus, which translates to about 430
>>> +      * microseconds at 19.2 MHz.
>>> +      * Testing shows the range 8192 - 16384 cycles to be unreliable.
>>> +      * Grant a more liberal 2x -3x clock cycle grace time.
>>> +      */
>>> +     usleep_range(delay_us * 2, delay_us * 3);
>>>
>>
>> Would it make sense to have power_off have the same logic? We do a
>> usleep_range of those same values currently, so keeping them in sync
>> seems to make sense to me.
>>
>> Also, I'm wondering if it isn't an issue with the gpio not being high
>> right after gpoiod_set_value_cansleep() returns, i.e. the time it
>> actually takes for the HW to reach the IO level that means "high" for
>> the camera. And that this increased sleep is just a way to mitigate that?
>>
>> With this patch we essentially postpone the power_on by another 430ms
>> making it almost a full second before we can start using the camera.
>> That's quite a lot I think? We don't have a usecase right now that
>> requires this to be blazing fast (and we anyway would need at the very
>> least 430ms), so take this remark as what it is, a remark.
> 
> I think you've misread 430 usec as 430 msec.
> 
> I was looking at the series and trying to decide whether it's worth
> going to the effort of computing the time at all when even on the
> slowest 6MHz XVCLK we're sub 1.5ms for the required delay.
> At the max XVLCK of 24MHz you could save 1ms. I know of very few use
> cases that would suffer for a 1ms delay.
> 
> I know we all like to be precise, but it sounds like the precision
> actually causes grief in this situation.

Yeah the first draft of the patch just had a post-reset delay of I 
forget - I think I just used usleep_range(2000, 2200); again but I kind 
respected the attempt to hit the specification and wanted to fix the 
original logic, which is close but no cigar ATM.

---
bod


