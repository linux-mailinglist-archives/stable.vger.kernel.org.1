Return-Path: <stable+bounces-69896-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2011B95BB6A
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 18:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A52B2B22399
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 16:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DC11CCECC;
	Thu, 22 Aug 2024 16:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wC/2Iep0"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530FE1CCB2E
	for <stable@vger.kernel.org>; Thu, 22 Aug 2024 16:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724343044; cv=none; b=LndBk3MPLAyrTK4f3jZHQaRK7vhZi/zHVbbhVKfGagFDrjIv4HYvuLJWQF3pxXTp7YBR01aOgttfKupAYklW7K7XFXKJNSal/vu7zCx4m4WCrbhTs8acfGt1To9i25IK0U2IW6J94OqflaB0lIYYjkuL/NUoJz8QYUnwMb7Ijfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724343044; c=relaxed/simple;
	bh=oTVnwnxoi3MwR+fT4MSoMLg39Y4GQfy4UfuGydIln/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fpzZuBWodiG/X6gBgTZUKUy6sq6QPb7fSiWvBc8jpSO1mklu/dTgiXGD/BePbfuX87MXkKWbvjWGfPhLrhezlZCXaVZwyZV+xx502yzFQppULMXbTvv9grrcsFcoF7riYCIk3o0Ou/ZFIh6x+mtB4lXdqDEagGUicsTTVKg4AbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wC/2Iep0; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42817f1eb1fso7676155e9.1
        for <stable@vger.kernel.org>; Thu, 22 Aug 2024 09:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724343042; x=1724947842; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ghU7bGQfCH6VMs7XeQb7I+ZFRK+m6U/I472i0hWudlY=;
        b=wC/2Iep0M0IEKgTPpYzAOntqPZRcTH8+Crcnc5mpjAoy7eiT1E7gjvhZBTadltxUG2
         UoaICx2j2/wK3ubd0Quv+fJXDdxWDne2xXocjwTWmQZ3GdNvYNqm5SiEbleZtVnSaeAN
         LBS5zkznBnRRMjiwmDC6SiYdxbAuP1hqf6XYjt+3z+nX6f9J8ka2xHP3VjkCUq74liva
         imjIg7ARB3OBSxl0egIeyXIi4pg+u9rPGu1TVuoF61Vj/0SRHiOurZD9Fet1CUxNY6Vp
         nwboLI2MCMsm0TNuFBN6g4tvR+nDtB1nENMmkqSGIl3NZct1DJU5pXrQKr9E+2AhxqZ9
         jxNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724343042; x=1724947842;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ghU7bGQfCH6VMs7XeQb7I+ZFRK+m6U/I472i0hWudlY=;
        b=Ij9JPT6SV25eihFPy4QprUCaIRQxvxHs8I2ZorJMD8Pq4/YSURpO2Dq009BlVmsdPg
         H5BnS/SzkiyKs2C6DBo04Eugneb8RZhyOE6/BsQj8BFBAys92OVW1Qxxh2odd7MgytNw
         LVvf7YFYSSLZudLHePphmeBqcqhgRJLopLG2tDDfypZR+hW9qMh6KT1FPl111Nz8uuaa
         7NHpz8z4JKenAQ4vXHN1Sa/5tL8Gne1rgwkLtSrlkTikVIZBxoQnXTv8XgwUCoLRmtip
         bAti2NVp93EkvxueAXt2WuvKeqI9gLDwffe+5X3mFT6jbrV1nYdA07nmvHYspc+tuN/h
         B9gw==
X-Gm-Message-State: AOJu0Yy/tNCWkZc0VvLVu5YO9KSGvHXS5sexFD079bMpL9OSRrcuvesl
	h191qgKfWrzq9aTUoQMxGaGyV587ucv06vmRYm9z5Yc4yvgmTKzRu99q7QSK3SY=
X-Google-Smtp-Source: AGHT+IFbeUlcYW7rVjFtPeB/keXD1uOdpULEogsJaEXgMJoh81iXZzt7Lg0xKqgNI513crPHQS93Ng==
X-Received: by 2002:a05:600c:c8d:b0:427:d72a:6c26 with SMTP id 5b1f17b1804b1-42abf048b3dmr42289485e9.6.1724343041166;
        Thu, 22 Aug 2024 09:10:41 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42ac500e119sm29671935e9.0.2024.08.22.09.10.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 09:10:40 -0700 (PDT)
Message-ID: <133ea087-a5e9-48ca-bb89-33f41220276f@linaro.org>
Date: Thu, 22 Aug 2024 18:10:40 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] thermal: of: Fix OF node leak in
 thermal_of_zone_register()
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20240814195823.437597-1-krzysztof.kozlowski@linaro.org>
 <20240814195823.437597-2-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240814195823.437597-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/08/2024 21:58, Krzysztof Kozlowski wrote:
> thermal_of_zone_register() calls of_thermal_zone_find() which will
> iterate over OF nodes with for_each_available_child_of_node() to find
> matching thermal zone node.  When it finds such, it exits the loop and
> returns the node.  Prematurely ending for_each_available_child_of_node()
> loops requires dropping OF node reference, thus success of
> of_thermal_zone_find() means that caller must drop the reference.
> 
> Fixes: 3fd6d6e2b4e8 ("thermal/of: Rework the thermal device tree initialization")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

