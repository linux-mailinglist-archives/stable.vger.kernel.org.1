Return-Path: <stable+bounces-74059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05152971F77
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 18:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E39091C22A40
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 16:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902AF1531E6;
	Mon,  9 Sep 2024 16:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="blVo2zYL"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8434528DCC
	for <stable@vger.kernel.org>; Mon,  9 Sep 2024 16:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725900341; cv=none; b=o5OZdhaXJ59E0NifywDZjGoIAW2qZLT2zr+EHtDdV7T+6xB0N8XMR40Q78Ly2TxTUyd/6u1ketJZ/NatAvY3Ckk8sZs9uAZeTHw354joJ7MoGAf+lQ0sZQuB/S3UCwbkpr88SoOkcftUrXm+OOzQyiyolZ20OFC9J2+R5XSjMnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725900341; c=relaxed/simple;
	bh=aypj3AwzTBOrw+k/CCAxDywSoAK4r/5l7M6JJLd8etY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MgwLBjNoZTTtE9QeCHyZQkEErR3iPZdnWS3kQuaClcFB+Z/48Lve4ObxaiSLLdr/pfD7RPscgSZpQYGfkbKsyskjWBTSIXxKd6IZ+H84iwpJtjSGc+0rJTSg/HUxZsK6cHDNckvN0tCQZZTmgO8AlIhIp14szeRRwFk6KNXXWg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=blVo2zYL; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cb6eebfa1so1794725e9.0
        for <stable@vger.kernel.org>; Mon, 09 Sep 2024 09:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725900338; x=1726505138; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eMsoOURx1kT61a6viyi10a0/CZlrMyenlU3TId0O9kA=;
        b=blVo2zYLgrJAK9x8b0zcmKIKrw5GJIgM+PJ5sllX1+JK6HTezPnT/pbfSc6c7K6d7Y
         y4N5pWId+1jpm0JxiE/IKYu4i3tLiebjxc0V8kHn3ylRIBnlhZoubiN8c47DhLFpB6XK
         A+D8x/Y6s11R4Pwm9IiYFuurklgZO3cm3hAGfaIF8gUWY9NK9Z0hMPcxWkXnYu9bOGAm
         QwrDRqMx0ff4FR80AdtHklqAS8NXCbhELm9a7XnEA7erVdK698tvtKnk3Ba1Sr5A8L1B
         UvL4IwM1XXW8JqW1ErUJpC06/ufnt8N1QYUzqNieQsyUTwp1BZ8/ejKsaiHuN9+FxpI3
         AaTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725900338; x=1726505138;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eMsoOURx1kT61a6viyi10a0/CZlrMyenlU3TId0O9kA=;
        b=N5bjjeebdHwwv9jy04sAi8tmOsy2GVSeoE8kpRoMtJvXY4/j3wJLLLzci8zbM1xpTL
         qFVpktd/KF9bBf7/c2h82WBkOlAw37nRHhAK7FW1oWvFJKii/j1QR85HDPksz1q2Q1u0
         F95tagwWADxU7wsFJCtTdIlYXanhnGF2CdTwZ05xLvPHp398/UWFp3gl2TtF1nRCzu4n
         dhJlHr7YwKQAMWwz0i97Bgvtomc5jm03NO34KZRxeHuEwFJpZPtGSQia79bk8iAl01Tm
         kQDCB9W3zyxW4PquApeur5XVE4SruEoNb8T6wiA78XC8PkI8XpAyRvfxQzwzAKsHTA3Q
         C2rQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1wAnVBRxR7/264sfKjsBuPgvhUHkMqFgX0L/mDROh6qHsFeLI5VLyGtFUuxpY+iDjPJ+G5DQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmesqMCOK+ZdxA8JG83fe5GPDSz9izWhw7WlmyCREU+vw3orp5
	XbEG8i5xqD9LGiGk32ncnZvcu2xjv1hBU79qFBRFrbVa6FAHVRFqV/M1MTf0wWo=
X-Google-Smtp-Source: AGHT+IFW9IMEyKpdaJtbCqeR2BfZUGVbj5qq4s89gkF2dIQ1hZCkg5BprfSbih9wBltACm/FIFWYiA==
X-Received: by 2002:a05:600c:4186:b0:42c:aeee:e605 with SMTP id 5b1f17b1804b1-42caeeee6f8mr24097205e9.9.1725900336995;
        Mon, 09 Sep 2024 09:45:36 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3789567625esm6480948f8f.64.2024.09.09.09.45.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 09:45:36 -0700 (PDT)
Message-ID: <1944839e-306f-4881-b430-9837ce62cded@linaro.org>
Date: Mon, 9 Sep 2024 18:45:35 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soundwire: stream: Revert "soundwire: stream: fix
 programming slave ports for non-continous port maps"
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>, Vinod Koul
 <vkoul@kernel.org>, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Sanyog Kale <sanyog.r.kale@intel.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, "stable@vger.kernel.org"
 <stable@vger.kernel.org>
References: <20240904145228.289891-1-krzysztof.kozlowski@linaro.org>
 <Zt8H530FkqBMiYX+@opensource.cirrus.com>
 <8462d322-a40a-4d6c-99c5-3374d7f3f3a0@linux.intel.com>
 <adb3d03f-0cd2-47a7-9696-bc2e28d0e587@linaro.org>
 <2024090943-retiree-print-14ba@gregkh>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <2024090943-retiree-print-14ba@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/09/2024 18:23, Greg KH wrote:
>>>>> Soundwire core and existing codecs expect that the array passed as
>>>>> prop.sink_ports and prop.source_ports is continuous.  The port mask still
>>>>> might be non-continuous, but that's unrelated.
>>>>>
>>>>> Reported-by: Bard Liao <yung-chuan.liao@linux.intel.com>
>>>>> Closes: https://lore.kernel.org/all/b6c75eee-761d-44c8-8413-2a5b34ee2f98@linux.intel.com/
>>>>> Fixes: ab8d66d132bc ("soundwire: stream: fix programming slave ports for non-continous port maps")
>>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>>
>>>>> ---
>>>>
>>>> Would be good to merge this as soon as we can, this is causing
>>>> soundwire regressions from rc6 onwards.
>>>
>>> the revert also needs to happen in -stable. 6.10.8 is broken as well.
>>
>> It will happen. You do not need to Cc-stable (and it will not help, will
>> not be picked), because this is marked as fix for existing commit.
> 
> No, "Fixes:" tags only do not guarantee anything going to stable, you
> have to explicitly tag it Cc: stable to do so, as per the documentation.

Then anyway cc-stable not in body won't work.

> 
> Yes, we often pick up "Fixes:" only tags, when we have the time, but
> again, never guaranteed at all.

Hm, I assumed you are still taking fixes for the fixes automatically.
That's the case here. I will resend with cc-stable in such case.

Best regards,
Krzysztof


