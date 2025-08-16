Return-Path: <stable+bounces-169853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2A4B28BF5
	for <lists+stable@lfdr.de>; Sat, 16 Aug 2025 10:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A9A894E1E69
	for <lists+stable@lfdr.de>; Sat, 16 Aug 2025 08:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5F6239E6C;
	Sat, 16 Aug 2025 08:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XsO0AeG4"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C52238159
	for <stable@vger.kernel.org>; Sat, 16 Aug 2025 08:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755333640; cv=none; b=n3dqWBsCtclGPWFwOglL8MM3bJ1PAgoY4tQrOj933uXRevgfdztxWBWY+xS2hwIafW5rmEukSp0rvvQ+0C/NTSB8sGc27Jg58HNrg40o/Ips2YEmY8XKmhkBRoesr8FhVvbmANX5OKoBe1iUfjuzc0XekeC3yoYi3ljqgYGtV/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755333640; c=relaxed/simple;
	bh=+nyBYhn8EVJUVicrJiULxaDWYjj5D8eBw/Z0c2ikZx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mBJhIrmnLq/SxbzV1yY83j8SnGdSWVDyLc1qnMK4exrKfScEk4EoYpE63c24AlcQsxPdeurTHqaVc5jIs71XMgb0EKZxS79itXq+Hi8dHv+BJrSzXHE3MsPwXvR0I2IVBqrMt/fDqBx+ERP1HD9h+tUMjW0KiL7eRIpulC6O0SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XsO0AeG4; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb72b3a1bso42426966b.0
        for <stable@vger.kernel.org>; Sat, 16 Aug 2025 01:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755333636; x=1755938436; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=F/l+KZ/7BYHbQKPotBrKwjmieFaPg4+hOagx5GhBXek=;
        b=XsO0AeG4kPxa67egKDC1ElRMNlVseLkXNhNuZe39uE0gVcl9pxlPyAFp0V+ZLNGOps
         7pfxktUxUWIfuUu/cbIsXLpkwQ2DcgzBYjow3ikIzC9JOrXU+8nUnRzuihtLSRghN4jw
         zrZEREfMjfcwcxnN1SAmQ7Zv916T+8ZlwbRDnLVSce5BULgDq21MtqfuYsGDHXBaJfYr
         XLwsnPfbPw6qe0u19MXhbXEM4VkIngIp5ykynJkDv/nLTSec34H0JdSyLnwJI0nHzE2D
         MZDmhgTf0cBhIpgoQWQiuJuNyTrA2QS+RpHBsQ5qu4lY1yYAYV9Tushq02ZfKbrlED5/
         Oa5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755333636; x=1755938436;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F/l+KZ/7BYHbQKPotBrKwjmieFaPg4+hOagx5GhBXek=;
        b=rwwXeD8vStzEpqNdYT+DvNtfIan13iB7HgyCn7G6g6LWstGqDplCWoIr1nAWwOQTKS
         VVEq8mXJcnP+fNkqc9wNSHEx5wsEcfxyoPj1Y7MXcCEBEMbws39YWoLJCB4f+8js/M8F
         ZPfZGsw8lzBI8vKC/r9mlSGIryz1Z8nt/b/ZvBomfuq9xC7/oyuBUQvbZgeHhza3eWyk
         qOEgz5JunInawXitroyUwdi2MxabwtZdc/9/1h20QVkQg0j8fTOiJ2MrB3Vx1okGM++t
         ZT3nsSG5qK4A2FCjuC19MLUYmxiwekzmnNytYXDvca+YITqIqlbUgBtZtSosUd6OtXRK
         ol+Q==
X-Gm-Message-State: AOJu0YwkXDmEd+qKSXNythuo4J3min+bzJG/nT/VaSu/c7HdP23kHLuM
	4YrC+KR3kZxX1Qsa2X8p8b8FMlu+FIDtU8edS7GubWzJ5cT3KfokjOs84IkAwl9bQ3Q=
X-Gm-Gg: ASbGncsq/S2k4DAXFoexjrXUPn0kGZiTSYMi84AiizQyR6exIXuTbYY6/1hIONHtiHw
	er3KOfiM4pVjjhPT5EjR/lFTBfl9SKF6fFC9vJrUzGEgF9JNQuDY9h4/+5Rb457HPSsmXEJfe0d
	L5eNP9uGkAGVj3b7Ct7MK6WNtan9xLXS3+FoF8vygJgqNn6WwQhgfXe0HqHpf3ZhnoivFK8dqSm
	DcEm/ZjElx0UKyv6MYEU7lE1nuBvok0860/karmclt+ID6oxzaMqrXD94Ob3Y5c8YwjzooIvmeQ
	jcYGsGPICzWVSRxg9CAMQgzkfec1ZQ5UDdBJ2QeUeOlSSiCYY6+9e+IBHFj3aCacfPNO3ew7GDN
	Vz3mdQYItSao8Cd+PCVizq9kJVRbBxKHfFsv3xq/8X9M=
X-Google-Smtp-Source: AGHT+IEUWPix12tYXIkNxiBUpB3rv7hl8dAmfhGPQnbSvib0NIVN2ojKsm5Asba9NVT8V172giODpw==
X-Received: by 2002:a17:907:9627:b0:af9:a9ea:f42f with SMTP id a640c23a62f3a-afcdc1f4d0emr205463366b.9.1755333635915;
        Sat, 16 Aug 2025 01:40:35 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdce9ed8fsm339015466b.53.2025.08.16.01.40.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Aug 2025 01:40:35 -0700 (PDT)
Message-ID: <ddadd8cb-9738-4540-8c37-98e3aa93012f@linaro.org>
Date: Sat, 16 Aug 2025 10:40:33 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: icc-bwmon: Fix handling dev_pm_opp_find_bw_*()
 errors
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Thara Gopinath <thara.gopinath@gmail.com>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
References: <20250814063256.10281-2-krzysztof.kozlowski@linaro.org>
 <e35ca54c-252f-45c4-bfdf-fd943f833bc4@oss.qualcomm.com>
 <f2400037-c39c-4266-9e77-b084bd5f9395@linaro.org>
 <213ce041-733e-4e3e-87d5-db0b37c410b4@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <213ce041-733e-4e3e-87d5-db0b37c410b4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/08/2025 13:27, Konrad Dybcio wrote:
> On 8/14/25 1:25 PM, Krzysztof Kozlowski wrote:
>> On 14/08/2025 11:15, Konrad Dybcio wrote:
>>> On 8/14/25 8:32 AM, Krzysztof Kozlowski wrote:
>>>> The ISR calls dev_pm_opp_find_bw_ceil(), which can return EINVAL, ERANGE
>>>> or ENODEV, and if that one fails with ERANGE, then it tries again with
>>>> floor dev_pm_opp_find_bw_floor().
>>>>
>>>> Code misses error checks for two cases:
>>>> 1. First dev_pm_opp_find_bw_ceil() failed with error different than
>>>>    ERANGE,
>>>> 2. Any error from second dev_pm_opp_find_bw_floor().
>>>>
>>>> In an unlikely case these error happened, the code would further
>>>> dereference the ERR pointer.  Close that possibility and make the code
>>>> more obvious that all errors are correctly handled.
>>>>
>>>> Reported by Smatch:
>>>>   icc-bwmon.c:693 bwmon_intr_thread() error: 'target_opp' dereferencing possible ERR_PTR()
>>>>
>>>> Fixes: b9c2ae6cac40 ("soc: qcom: icc-bwmon: Add bandwidth monitoring driver")
>>>> Cc: <stable@vger.kernel.org>
>>>> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>>>> Closes: https://lore.kernel.org/r/aJTNEQsRFjrFknG9@stanley.mountain/
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>
>>>> ---
>>>>
>>>> Some unreleased smatch, though, because I cannot reproduce the warning,
>>>> but I imagine Dan keeps the tastiests reports for later. :)
>>>> ---
>>>>  drivers/soc/qcom/icc-bwmon.c | 3 +++
>>>>  1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
>>>> index 3dfa448bf8cf..597f9025e422 100644
>>>> --- a/drivers/soc/qcom/icc-bwmon.c
>>>> +++ b/drivers/soc/qcom/icc-bwmon.c
>>>> @@ -656,6 +656,9 @@ static irqreturn_t bwmon_intr_thread(int irq, void *dev_id)
>>>>  	if (IS_ERR(target_opp) && PTR_ERR(target_opp) == -ERANGE)
>>>>  		target_opp = dev_pm_opp_find_bw_floor(bwmon->dev, &bw_kbps, 0);
>>>>  
>>>> +	if (IS_ERR(target_opp))
>>>> +		return IRQ_HANDLED;
>>>
>>> So the thunk above checks for a ceil freq relative to bw_kbps and then
>>> if it doesn't exist, for a floor one
>>>
>>> Meaning essentially if we fall into this branch, there's no OPPs in the
>>> table, which would have been caught in probe
>> Yes, unless:
>> 1. There is a bug in the opp code
>> 2. Probe code is anyhow changed in the future
>>
>> I think the code should be readable and obviouswithin the function, not
>> depend on some pre-checks in the probe. But if you think that's
>> defensive coding I can also add a comment to silence future Smatch
>> complains.
> 
> I ultimately don't *really* mind either, just wanted to point out that
> currently it's effectively a false positive
I will adjust the commit msg to point out that it is actually impossible
condition now.

Best regards,
Krzysztof

