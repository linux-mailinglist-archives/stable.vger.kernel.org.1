Return-Path: <stable+bounces-152298-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25874AD3AD6
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 16:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F3153A2225
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 14:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFFF294A1B;
	Tue, 10 Jun 2025 14:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="V3XCHuSX"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C1C42A8B
	for <stable@vger.kernel.org>; Tue, 10 Jun 2025 14:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749564786; cv=none; b=tvynu0/zB5ESyEhX53xznaPpxtqNTtmaWQMXXuW30iXH/AsIPqY9ZSSRU9yD0+Q0blYL8/KvGf8l+2wPUeOlgQLvVmL3ZnF8C/YEAod0oJqJsm9iLuQdZoDh6T4xgDyhDEGtxMAwT56DVoaPyzEDYamP8RQ639QOb0ddvBlfEv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749564786; c=relaxed/simple;
	bh=fpsoKDI5uQBG0A/tf+KR5lMgKJjTIhz4S647EHuhAcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eiW8uTqhT4+P8/wdzHuZSeTI4cHbH+o9XlBBOUoxKm5woB5hAZ7Mj47o50MseUkSWrge6MVbMfdHf8IORG84UNE7L+veCOCQ+xY+LgfcAZknbLAG7EFEGRmc8rZzwrob7EFwjOG+/0cdawvGEvIBLa24P643Txkrn3WDgfTCIfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=V3XCHuSX; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2dfe2913a4bso1319563fac.1
        for <stable@vger.kernel.org>; Tue, 10 Jun 2025 07:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749564783; x=1750169583; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EB37374BUiYYtPh0W39NXdXaP1PW8agQzueDQPq14KA=;
        b=V3XCHuSXapmuF4wVTwU6WqGQUdEAo4fTZp0ySwy1Q9J9rDmgCrHrFBCdPcQngmYbUC
         6tcBhxL5anHVM2mfmYXn4v1Ozk9b1fzq50jGWBHjBbWa0xtk2/yOy2QnFMegUaFzk7pu
         U5mJeWFJ9Mw13kTJd6WiEH8hKCJs4DWxYA124QDm8LaShH7tapDKHBgKazu8hnEZhCnL
         EDfvY6O7vv1RXMhtj293WdlfYZf6AOOQEsovyK1ony2Cpp60Ip18Y872db6iozSjy0uP
         rM0dNkuIqK/fp9B2rKJEkxz/0xB3zLk544130D9sBJj0gvm0gFTxxPnn73yGk/o2KxVH
         4THg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749564783; x=1750169583;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EB37374BUiYYtPh0W39NXdXaP1PW8agQzueDQPq14KA=;
        b=IpOcU3sZeO/H4aQK6TJjVAkQUQvFuR7N6cgXzqQ/xoRuXsTiKptILRXggxBCs7R340
         ThZqIv3OTI5qhTHayTiIenJyLwXcz7Lh8DaPpd5LK6SBPzjGStUj/69v4+xxsMQ59CXd
         4nU0eZfFxYjEU2YobBRDsxnPcFRT0EdxYq846naImRM1bcO4MAHCnZuQCoxch0puyR4I
         P5jGmaCi3tMr7/AHVWT7+gOqTwKBGCgW6vGz7oFhfqwnZhPSH+iiQZa5nT3lTeykoGml
         XxKqTx3g3DBhv/GH+fNU30OQVMCuKoXL0gMLGS2NADALcE7kNS3PMTMM+HSh/Q/sA6UL
         wpcg==
X-Forwarded-Encrypted: i=1; AJvYcCUb+Z1tysoWSjoUJXY7cHijJOCf/wgkxVqbfCd9XqlbXHqWfzbK4uiqyQ+05eubdYWzjvx5+to=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8OG9Fpq6iYdJahpA6q8Hz426t98MWziXjfoigLOwfo2azoKpO
	8Az+5e0mpZp4aLXM7ORt2RA1yvuXG4tFL9VT+atDRdVuCBFVLIeky8GAM+AcqcwalXE=
X-Gm-Gg: ASbGncv6TsfvD7S88/ktzKKjDXxD3g58SDDkbNWDDet8DkA5L11MOdwN8jCDIElJhEH
	c/amHHXJP9WRpiGU1F42xfh9gr2Gj7ujf4F97oDk6hDYlOm9fXcuWbIo81lZVQ35k9BVBunBD2j
	Z7HbonjYI7wHz4fTkrMYtzGEcJzQQFtx9fY6q9QA0WVUdt+SyyhtAS04Q0lKG64TM2sSCSGs7gL
	RI4ZNDEmhUnfqWpPzSb81QLq3SQ9rTMooRbP8RXkcATbC8M7Kj8remb+KO6Lbkaqibwrv4M3/e0
	KeqJLucpRSaYXOO+pcafoHQ8VH0jO9rT9zeDGfh+DAEAg6CYt4fOWxEeiYPfitz/zfRgQp74azJ
	VGnohRPT7DQA5EaNjH7o76A6MNTP5oLYiAHiv
X-Google-Smtp-Source: AGHT+IHAbrcgd7SMwTbrASrunkgINOAH46uqCGl/ZheJKIvnseT/m5wL46bO3WtZ1gBizyI3v0xdYA==
X-Received: by 2002:a05:6870:1996:b0:2e8:7953:ece7 with SMTP id 586e51a60fabf-2ea012f1b15mr10055146fac.24.1749564783154;
        Tue, 10 Jun 2025 07:13:03 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:a49:6255:d8db:1aea? ([2600:8803:e7e4:1d00:a49:6255:d8db:1aea])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ea071253c4sm2390597fac.21.2025.06.10.07.13.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 07:13:01 -0700 (PDT)
Message-ID: <a6a4ab63-907d-48a4-8ece-2f77b16a1566@baylibre.com>
Date: Tue, 10 Jun 2025 09:12:59 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.15 30/34] dt-bindings: pwm: adi,axi-pwmgen: Fix clocks
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
References: <20250607100719.711372213@linuxfoundation.org>
 <20250607100720.893179321@linuxfoundation.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250607100720.893179321@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/7/25 5:08 AM, Greg Kroah-Hartman wrote:
> 6.15-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: David Lechner <dlechner@baylibre.com>
> 
> commit e683131e64f71e957ca77743cb3d313646157329 upstream.
> 
> Fix a shortcoming in the bindings that doesn't allow for a separate
> external clock.
> 
> The AXI PWMGEN IP block has a compile option ASYNC_CLK_EN that allows
> the use of an external clock for the PWM output separate from the AXI
> clock that runs the peripheral.
> 
> This was missed in the original bindings and so users were writing dts
> files where the one and only clock specified would be the external
> clock, if there was one, incorrectly missing the separate AXI clock.
> 
> The correct bindings are that the AXI clock is always required and the
> external clock is optional (must be given only when HDL compile option
> ASYNC_CLK_EN=1).
> 
> Fixes: 1edf2c2a2841 ("dt-bindings: pwm: Add AXI PWM generator")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Link: https://lore.kernel.org/r/20250529-pwm-axi-pwmgen-add-external-clock-v3-2-5d8809a7da91@baylibre.com
> Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---

Hi Greg,

It looks like the companion driver patch for this didn't get picked up.

https://lore.kernel.org/all/20250529-pwm-axi-pwmgen-add-external-clock-v3-3-5d8809a7da91@baylibre.com/
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a8841dc3dfbf127a19c3612204bd336ee559b9a1

The intention was for both patches to be applied together.

