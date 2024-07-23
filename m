Return-Path: <stable+bounces-60746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8063939ECD
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 12:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC1351C2200E
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 10:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB1714E2E8;
	Tue, 23 Jul 2024 10:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiTZk/jQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C5413C818;
	Tue, 23 Jul 2024 10:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721730842; cv=none; b=aAioX7qxB52HfZtNrBH97+m8uew9Vdkm/HVfx5dC7h4DLllXxyqHWNgwHXK5zo9FdAiXp97ckCD4U3iyRxC1yKJ35PobJWo0f4PyKTKiNvZN7pFzIFrnnj9++pT/PeMfobTVHdWM1Iz6e21RZbwL6pwoE38rS/OvCp3WkKGvw08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721730842; c=relaxed/simple;
	bh=YuVwqKdXt1E8MkGQq6NQ2AXq+9zlpqlhszfi98LBZXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZJ1yxne76JOqJpoUbfXY2eZXGDEUN55sexwFpAPnphLMnABJssckbEgmhKvuzAa2fchlxk+ER+9jP0RmPXnnuWRBqCImVlfaiI2duqZkCFQU+Jjplb7veE9fSMh74/AYCWTJ+VPT6n2hfnzw+xeKniYijDu8zXb7TcmpdCLoNnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HiTZk/jQ; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52f04c29588so2641929e87.3;
        Tue, 23 Jul 2024 03:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721730839; x=1722335639; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cz8+Y1QSeSSuHfxWaaeZn1X4P75aV5338HCWDu/yjTA=;
        b=HiTZk/jQ1zVFd/oaZiH9vy7eeKLe9kHBDViYr36uJiGCdsnUUdfWwHbgovRYaDLIoo
         CFLMkv4lrVk0yZL0dJXYFiKpE8wfO8T7YBdQA3Auasi8AAHShU3TIfe78ybmsSu82fsB
         sjnaEZZSGmIo+CchQWy1S8PxuiA4HuS1C1EGWzxcjfvAArfa6BMzqQE0HNSbDgA5GBqw
         rC+K7V1Z66w/WP/nyMYiL3k4Dk4L3nW9m9wcMLovT3IqdVKK832eQ/t00xZ/Tu5zTFhM
         6xhVCFnnvUPUq5VakpUAkCb3D+p/fHXt8LbG3VGRTFfhdDKWBNYON+uIaPikmzyxxD94
         YY4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721730839; x=1722335639;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cz8+Y1QSeSSuHfxWaaeZn1X4P75aV5338HCWDu/yjTA=;
        b=XaTIidKICK7s6PRpTruPNGhJZJ1DSDExxApIXQwsBLXSVIbJaGVHwgLjPzuhyjzIU8
         ol/U0zJFZOAr9PWckpQasseUYKZj5QVcqve468eDmxUX2qy7jVf3942cK05Eingg8Rl0
         pzUjAQG9mOrZv52XeXlpm8E9ESJ+mYLCmfL7hRPBlC+AHCvIgCJ8AOS5aPqDvsiKoV7A
         tMYXOQzPtvgNcYHw5DmoJEe7QKDz6pBIKmm8/cbKHpIvpzK8MOVWhgufKuYyob+SPCaY
         lwg7V0cF3NIOR1/SdhMXbBf4d70PcNX3k+IDVjnJUZFMXXPSMGVthBZYKxINr9nqAW9w
         YYkA==
X-Forwarded-Encrypted: i=1; AJvYcCV2A+EuOBrikkcBtBRnj7USFw8uGqXyxK9XqprVwhugHNIMVZQVjSyhaXhqhms/he+9Qk4y9cpkNUbU6Ajqj2Znj9hL7KyyZDrlkEdojD7A2FmErNGYCmNSjlb80wAqua8TTGRlil2AsdLxyO1YskSIcztxPw4f8YkPN8fWNSNYLU1mwlo1g2PzTOI=
X-Gm-Message-State: AOJu0YxiUKa59vfkWlG0H3hK3ztsaNVGxCPfc3BfXRx7qYxZ658r1M3Z
	THc+u/9g2kz+Us5T/9wX5NDIMh+V8Td7rIhOnR1T+o76ho48XRFM
X-Google-Smtp-Source: AGHT+IFjnE70mtfjkdEyZtp93m8AclelDcFP6Zxzv9/eLhU2xaX0d/Zs+3zxDczpL4HXw4gB75j6Ug==
X-Received: by 2002:a05:6512:3b82:b0:52c:d8e9:5d8b with SMTP id 2adb3069b0e04-52efb7c7e96mr6589657e87.25.1721730838585;
        Tue, 23 Jul 2024 03:33:58 -0700 (PDT)
Received: from [192.168.8.101] ([37.31.142.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c8bed67sm521179566b.124.2024.07.23.03.33.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 03:33:57 -0700 (PDT)
Message-ID: <249c4534-2fb5-4968-a761-473fe9faca96@gmail.com>
Date: Tue, 23 Jul 2024 12:33:55 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: samsung: fix getting Exynos4 fin_pll rate from
 external clocks
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20240722063309.60054-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Artur Weber <aweber.kernel@gmail.com>
In-Reply-To: <20240722063309.60054-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.07.2024 08:33, Krzysztof Kozlowski wrote:
> Commit 0dc83ad8bfc9 ("clk: samsung: Don't register clkdev lookup for the
> fixed rate clocks") claimed registering clkdev lookup is not necessary
> anymore, but that was not entirely true: Exynos4210/4212/4412 clock code
> still relied on it to get the clock rate of xxti or xusbxti external
> clocks.
> 
> Drop that requirement by accessing already registered clk_hw when
> looking up the xxti/xusbxti rate.
> 
> Reported-by: Artur Weber <aweber.kernel@gmail.com>
> Closes: https://lore.kernel.org/all/6227c1fb-d769-462a-b79b-abcc15d3db8e@gmail.com/
> Fixes: 0dc83ad8bfc9 ("clk: samsung: Don't register clkdev lookup for the fixed rate clocks")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Seems to fix the warning for me on the Samsung Galaxy Tab 3 8.0, so:

Tested-by: Artur Weber <aweber.kernel@gmail.com> # Exynos4212

Thanks for the patch!

Best regards
Artur

