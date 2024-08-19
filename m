Return-Path: <stable+bounces-69587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D42A3956BF2
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 15:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E1ED1F23794
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 13:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D0316F85B;
	Mon, 19 Aug 2024 13:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yDk/K3A4"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870E916C86A
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 13:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724073779; cv=none; b=Of5vAeT/Cn669ZPOEk51+vTOoWjrkKM078Wz8PhugpANqEC9fB15pwHOHMW/HmaSJ0FZlF/uOv5s9hGtmhnZ1PyNHb/pm7mq+pwxQIEfKftNIlhrp3ng3nwABcpqwitXIJfmPQx6sE9IbFFJ5zuUphBPgmQborUZ6FouswRB914=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724073779; c=relaxed/simple;
	bh=O2MwCfLhtuz3WtZXy/MYatQ0Sno9ksR85Gi+1RqITFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RBMQVnbdpI68OS6y6AN5QMoykuv0+p1dNEi+NJY4fn3vKrfsITfuqyDlESIbPH8hNStA0ioUGnV2IFwa2MYMx4sqh7oRJkMuR5d1RS9+DcjB7F/w1PimOFOwLmc6+ILpLF+kMofDVRLHCe5OaUxXld8+XgTW0BjVWGVYt2AxwEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yDk/K3A4; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42803bbf842so47640845e9.1
        for <stable@vger.kernel.org>; Mon, 19 Aug 2024 06:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724073775; x=1724678575; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GuyNk5fVdyh6epV9U4Iq9p9Lvv3ALtYfwMJQqqgo6Yk=;
        b=yDk/K3A4AZrayhh2VHwN98Zfi9uulq1lRuePuwUVBT92asa1xO/LJXdVWkOy9XUVle
         g39Tn/s6mXGRNHIgV6hVoLJOBiHkg16ApaSQEi55x2bg/qAwCmcW9UWHzTi1oiS3gppc
         HUJominY65l9ehZBFDkXuU9UrEDisBKLAs6A95KOerXO9MVVG0UxchEyGawsd95SsubL
         v4ho8UremKnbYINTxJmtFjreqmrgvcqlCeHqrEbGrPG/rH2uSolLVE67ac+FnxV7jOlX
         VQ3fvoEwa/x65Zp0OOX+ht4pQL7Sh2DEXlDUGBbH8ZOGFxAuwOvVt+tpbjY3izEkIXtH
         9QQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724073775; x=1724678575;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GuyNk5fVdyh6epV9U4Iq9p9Lvv3ALtYfwMJQqqgo6Yk=;
        b=vbSxF7G7KHJDGgdAu60Pt23GJLyVcRad3QKAS5Vh70+d4HLSG97itBoO04mBgoUnm5
         /TVeB47uEsxEgv4L9T2aDcmm12lK0sdyk5aV0QyqqrIHXXorbrGWVtVrr3v7C7yhRy+i
         TyWqIsjxR9Kez5V+zeCK7sEj+eiAN0Y6tpHD1CJxWm+PFFU07R7BZvfUgwjm8Tq8+wvi
         HaCdh35eaE1jbi5P8/l0PZ5VV7/h6PGcY8dJ115geJ1odoSejkMjYedFiC0aIh/aqQ8M
         cHGIOwCsoZZ4NZg4cCXMiK3WBsGSmPS2kXh0ndKAJ33Mysfp0pYh1QQXCwza/KIrT7rS
         x6Yg==
X-Forwarded-Encrypted: i=1; AJvYcCWqJETmFYmUYgywp8JrD6vwBeCYvNCD1PA+4wJCJcCmS7SnC3XrVbGJ5UqWQL1ObGzqzG/w12Y11Xy1wOoP15sq+cf2Qcq3
X-Gm-Message-State: AOJu0YyUWFXLO6r+b38McfbmI3mI9sKlWvT74MEzMMmix7qDKNmlTliK
	mnSzZhjEtORaC2WG1gtcgTI2O7xTf7CtscFAnUTdjqegT8rjSQd9ILqAvMSAZtA=
X-Google-Smtp-Source: AGHT+IEPz54Ns7DkJpUWWgC/R1C4JWEbFnoSanERwA9Q7te9U+I6z6L41rY0uwvrgLlKgxD0fLi0cg==
X-Received: by 2002:a05:600c:4753:b0:426:593c:9359 with SMTP id 5b1f17b1804b1-429ed7ed62fmr88977775e9.32.1724073774440;
        Mon, 19 Aug 2024 06:22:54 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3718985a6d1sm10654962f8f.57.2024.08.19.06.22.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 06:22:53 -0700 (PDT)
Message-ID: <9e6d817f-1fcf-4d31-b0c5-d68753e1f949@linaro.org>
Date: Mon, 19 Aug 2024 15:22:53 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] thermal: of: Fix OF node leak in
 thermal_of_trips_init() error path
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240814195823.437597-1-krzysztof.kozlowski@linaro.org>
 <f3d2c104-360a-4da0-8d77-59af89ebda2b@linaro.org>
 <CAJZ5v0hiR0sqgfR1WiuT=tXx3XRWgAE-j3biEMMaV5FjiSZwbw@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0hiR0sqgfR1WiuT=tXx3XRWgAE-j3biEMMaV5FjiSZwbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/08/2024 15:20, Rafael J. Wysocki wrote:
> On Mon, Aug 19, 2024 at 12:12 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 14/08/2024 21:58, Krzysztof Kozlowski wrote:
>>> Terminating for_each_child_of_node() loop requires dropping OF node
>>> reference, so bailing out after thermal_of_populate_trip() error misses
>>> this.  Solve the OF node reference leak with scoped
>>> for_each_child_of_node_scoped().
>>>
>>> Fixes: d0c75fa2c17f ("thermal/of: Initialize trip points separately")
>>> Cc: <stable@vger.kernel.org>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>
>> Applied, thanks for the fixes
> 
> Is there a place from which I can pull these?
> 
> It would be good to include them into 6.11 as they are -stable material.
> 
> Alternatively, I can pick them up from the list.

I'll send a PR for fixes only. Let me double check if there are other 
fixes to go along with those

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

