Return-Path: <stable+bounces-72735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4032D968B88
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 18:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED2CA280EEB
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 16:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB53D1A3029;
	Mon,  2 Sep 2024 16:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XaQ0RyRW"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619341A302E;
	Mon,  2 Sep 2024 16:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725293015; cv=none; b=D3YqkAooxBlYHO8fbso+lHZriQ0BCE125UB21s2R9OEKJAb+WD2MkcELuMs5rN/6yGRNxQu8DDXN8uNeI4YYNHEw8DNkAEv5FcWs8NqPRW/ES2yQpciEWTM7LaaZ5E93w/N+zkM9sv9UL89MkME9wDwDN+z9s12Te8cQ7OJcXQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725293015; c=relaxed/simple;
	bh=r3TP/0lyfRYWbzIzSDicRQkQHchH96nDet4lScmpUCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SuTmgxMbHgDZ0jodA3USYzdZduLnz+tjqtHnOjakoiCnYOUheqHtHq82MjnZ0sKqLRv/3yPo2HTyttwnSe3kbIlbaZCX0+7D5Mx1SD282oP3FsMgGiI6d6Ox1/2l7HCXFIxiKc8SidUcqbBcEhbO7lvtxFydcI/bg6snu43lre0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XaQ0RyRW; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c25554ec1eso1409503a12.1;
        Mon, 02 Sep 2024 09:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725293011; x=1725897811; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+Kv/apDvPrExBQ5X/4dafVzGVDaldCIfwo7y23syOH4=;
        b=XaQ0RyRWVkOhCGq9e55ruXmyn+aKIcNTFg0M09GNrvF4k7+HAEdxuobnYhrnAthp0g
         mzL9mT3qJ8asjl2Fqpfmmoj8RWNyaR1P01x52oqdskoezv8x7SqdFU0aRAAGdtp3zckH
         oqbprgVCskurcuNM96VHhLIWfL/KWNmIEPbHgWF6sEMq7UO1ZYQ1m+6UQyo40lKyRnya
         WWgWlCyv1wsah52uFkkYXLNggUIT8cRIlcHEwCbVjWRGTVi06UphfTNDVoZ4esgCzTO8
         YA/XDIAzUflqdNUqxiwJk9H6l27i+lzxG5NX5uRwnVN+FBs9pM9FxmDAP7UCtfoEUstR
         6hQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725293011; x=1725897811;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Kv/apDvPrExBQ5X/4dafVzGVDaldCIfwo7y23syOH4=;
        b=IfZcxOVMXDyobpNCxBDzOVQPqvKQQB4gZnu/HhBOmGNt0p0jspqFZzZUcbFFKhi4tm
         XihhJADzERftmbjSwqzdhzfywd/3Ix5KSJ1KaHSOjiM52bNJSZBxuUn3Ga1MeMZNkqRo
         rcFu6idyYQbk8Ew+0viizRZRzvuLFXDIa8ployyQ5ARtAHmTJ/0CnP6EQZBJFXjdR7/3
         gckRSFu3wP4c2SmOsBW87c+9PGVqLF/UglZP2xE55NsHK6ZLU9hlIE7TlJFjAscch06A
         7ge/u4Q0RCQELITCuVpBRZwPVEmUttU/wp8k1HwlPL0+V8PBSnJIusS/bMFh2a4FIMza
         o5xQ==
X-Forwarded-Encrypted: i=1; AJvYcCVd0LH7WFN2cR1OsbxDp3uzTmGulcWpr97Y6Untqq8lCkOYc9vTnEpzPlFIpjg/mKzbsrWJW+L0srgEv54=@vger.kernel.org, AJvYcCXMqdVwdPYGKSuJuxzgFHXpNu2+jYHWqL6WDj6rfKRr5wMtSTHVIBvyIFKt3+mv8Za9B8HPE+NJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7KmiaAvI1fOlDuvc+eIorDeQubOW0+3hzhdEJivR1QOzYT3s5
	hSvDEqMzhvUjpzEfn8KYBhdRH/AZPxVcV6v27F0D5raRjdf0sXda
X-Google-Smtp-Source: AGHT+IFwZe3vVzPMqvX+UqTwajDfeT9bDtU/z3lfwpijGNagFI21EwhcugsW/nwlZeHUF+s2trUicw==
X-Received: by 2002:a05:6402:27d1:b0:5c0:b333:b2e1 with SMTP id 4fb4d7f45d1cf-5c21ed52b96mr11240428a12.20.1725293010839;
        Mon, 02 Sep 2024 09:03:30 -0700 (PDT)
Received: from [192.168.0.20] ([148.56.230.39])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226ccfe84sm5359695a12.71.2024.09.02.09.03.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 09:03:29 -0700 (PDT)
Message-ID: <bb0dba5a-68e9-4c03-bbea-6788f4cc7d16@gmail.com>
Date: Mon, 2 Sep 2024 18:03:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt8186-corsola: Disable DPI display
 interface
To: Chen-Yu Tsai <wenst@chromium.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Stephen Boyd <swboyd@chromium.org>, Pin-yen Lin <treapking@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, stable@vger.kernel.org
References: <20240821042836.2631815-1-wenst@chromium.org>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; keydata=
 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
In-Reply-To: <20240821042836.2631815-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/08/2024 06:28, Chen-Yu Tsai wrote:
> The DPI display interface feeds the external display pipeline. However
> the pipeline representation is currently incomplete. Efforts are still
> under way to come up with a way to represent the "creative" repurposing
> of the DP bridge chip's internal output mux, which is meant to support
> USB type-C orientation changes, to output to one of two type-C ports.
> 
> Until that is finalized, the external display can't be fully described,
> and thus won't work. Even worse, the half complete graph potentially
> confuses the OS, breaking the internal display as well.
> 
> Disable the external display interface across the whole Corsola family
> until the DP / USB Type-C muxing graph binding is ready.
> 
> Reported-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> Closes: https://lore.kernel.org/linux-mediatek/38a703a9-6efb-456a-a248-1dd3687e526d@gmail.com/
> Fixes: 8855d01fb81f ("arm64: dts: mediatek: Add MT8186 Krabby platform based Tentacruel / Tentacool")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Applied, thanks

> ---
> Stephen has recently posted the "platform/chrome: Add DT USB/DP
> muxing/topology support" patch series, which is now up to v3 [1].
> More work based on this series is needed for the DP bridge drivers.
> 
> [1] https://lore.kernel.org/dri-devel/20240819223834.2049862-1-swboyd@chromium.org/
> ---
>   arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
> index 0c4a26117428..682c6ad2574d 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
> @@ -353,7 +353,8 @@ &dpi {
>   	pinctrl-names = "default", "sleep";
>   	pinctrl-0 = <&dpi_pins_default>;
>   	pinctrl-1 = <&dpi_pins_sleep>;
> -	status = "okay";
> +	/* TODO Re-enable after DP to Type-C port muxing can be described */
> +	status = "disabled";
>   };
>   
>   &dpi_out {

