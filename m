Return-Path: <stable+bounces-28080-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F27CF87B147
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 20:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 931BE1F2830E
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 19:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30ADE6214C;
	Wed, 13 Mar 2024 18:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jV2hrKAZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D846361695
	for <stable@vger.kernel.org>; Wed, 13 Mar 2024 18:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710354975; cv=none; b=dpM/EJCey06/0sOYs/dm//PMidEVzB80F7uZVj5MFl7vLuDjKz5J8FLNIX1kbduWT/Q64L8BUBC6lnB1gpg5WW0qiqnIt+GZ/KpCjTALeqXVN3MYoDukYGj+b1QtLtK07OH0nm3dLvlIADSMh6kSge2fulE8FFTEkr1b1eOxgpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710354975; c=relaxed/simple;
	bh=zho4zfMHNiuaTcL0umnf2caSh6sAfCx2tvVdCPnpco8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UHpGkV/6IX1peQTgjDjiXToHz64suJf2jwO39t3G/diy3MKVYrYNkeceFmxvq0clJDRmA2Iomg+OeXUj23YZn8c1DIxzi0MfPhd0EztGQ0X07fp/JKEWTA/+Lff1m1khKktnfqtCvdH3R73aOJGjB4IZidjI+fdzRwDPhvsqT3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jV2hrKAZ; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-513a6416058so277408e87.1
        for <stable@vger.kernel.org>; Wed, 13 Mar 2024 11:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710354970; x=1710959770; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wJZRN1PwthQIFaTVIj6b+wrHJJuPxOPVwgOgTSw6J0s=;
        b=jV2hrKAZKQhB3X8o+s0bouTDrAU+OnCxndy70/7qckXu0j4lAWOLfXk0n0w/4mFm/N
         88K/Ux62ep1VJXY53xxHc9ECgyc660sokm4iWWXMyoDj4kHygk8Uw2jT3t6GaTdkutE1
         xLrL58hM0uVLapq7FaBjZM0YEPsqiXzgfzvLRWjWOuo3GRKYBtiW7dCV0UgQC9M8NM3A
         1cD2CBvcvQ3JDpLTOZhGURkN3B1icqg95Po4eaXdMHH4hwkFaGRP06wDLZennNwWhd/S
         ouF00i+snat2NhEQUma3y57KbAAcdhn12hYUQAGBvkRVvHoMhZOYAplkYF+PRaY/bT6F
         svuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710354970; x=1710959770;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wJZRN1PwthQIFaTVIj6b+wrHJJuPxOPVwgOgTSw6J0s=;
        b=rWvxG83Gr5Gm/Cs3DYjTxsGBuX1ZCa8OYDBvmNXQjil2/P4qEMVhZE9HmvNmR3tm7Q
         gUmU6/0LMvYp9bBeIBlAmyp6VRjFvlZNqzuGAht0deZuvIAfRIHYfvvE5MfInokX02O8
         4E8JTWMdG+onNdUdWUXtFYhH2LFtulG4Qrgvp04gpOfwvzVnm/22jFmwHshhqkIulr9c
         lJlK426wSDC211uT1pHgJ0eTa6P8Q1wSWTPfO06EZaVsygH2KSwlr5+yjJezAwjVG115
         rU5WOoIXL9iBXmH2RjQZyOMFM+/SKRiIuFBuuUJ1qM95IjftO7jEAhU5Ar9fFg94hbUF
         Ev5g==
X-Forwarded-Encrypted: i=1; AJvYcCXbb6JBn0UmW6Mns8D4Kw88Ye3f6NvSN3vWBAdTbNaSdvAoijbcJH5Zf1RWK7VyCzXvwjO+yQSCfdhi4fb9JeGNhdW6l2kX
X-Gm-Message-State: AOJu0Yx0SK+blebXajHo/UI+VAy1StRDhrbpYpEtbGtDMErn8wKbqxFF
	niMaMuchaaWvAKKbL0GcNBYzLhXW4vlJJGr/s0nHkWN/O/cqrbRNe5U9tGz2Pak=
X-Google-Smtp-Source: AGHT+IHs6eKAY8MztXzFg5vWopSydCZHQ8A50tiLUvOOKAqt2J6kyJjmU4cx4uWXivEvZ56pKKzi2A==
X-Received: by 2002:ac2:42c1:0:b0:513:f09:d00c with SMTP id n1-20020ac242c1000000b005130f09d00cmr9178338lfl.22.1710354970053;
        Wed, 13 Mar 2024 11:36:10 -0700 (PDT)
Received: from [172.30.205.0] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id eo6-20020a056512480600b005135b81f30asm2144123lfb.97.2024.03.13.11.36.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 11:36:09 -0700 (PDT)
Message-ID: <58f07908-127a-438d-84e2-e059f269859b@linaro.org>
Date: Wed, 13 Mar 2024 19:36:06 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: apss-ipq-pll: use stromer ops for IPQ5018 to
 fix boot failure
Content-Language: en-US
To: Gabor Juhos <j4g8y7@gmail.com>, Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Sricharan Ramabadhran <quic_srichara@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240311-apss-ipq-pll-ipq5018-hang-v1-1-8ed42b7a904d@gmail.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240311-apss-ipq-pll-ipq5018-hang-v1-1-8ed42b7a904d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/11/24 16:06, Gabor Juhos wrote:
> Booting v6.8 results in a hang on various IPQ5018 based boards.
> Investigating the problem showed that the hang happens when the
> clk_alpha_pll_stromer_plus_set_rate() function tries to write
> into the PLL_MODE register of the APSS PLL.
> 
> Checking the downstream code revealed that it uses [1] stromer
> specific operations for IPQ5018, whereas in the current code
> the stromer plus specific operations are used.
> 
> The ops in the 'ipq_pll_stromer_plus' clock definition can't be
> changed since that is needed for IPQ5332, so add a new alpha pll
> clock declaration which uses the correct stromer ops and use this
> new clock for IPQ5018 to avoid the boot failure.
> 
> 1. https://git.codelinaro.org/clo/qsdk/oss/kernel/linux-ipq-5.4/-/blob/NHSS.QSDK.12.4/drivers/clk/qcom/apss-ipq5018.c#L67
> 
> Cc: stable@vger.kernel.org
> Fixes: 50492f929486 ("clk: qcom: apss-ipq-pll: add support for IPQ5018")
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---
> Based on v6.8.
> ---
>   drivers/clk/qcom/apss-ipq-pll.c | 20 +++++++++++++++++++-
>   1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
> index 678b805f13d45..11f1ae59438f7 100644
> --- a/drivers/clk/qcom/apss-ipq-pll.c
> +++ b/drivers/clk/qcom/apss-ipq-pll.c
> @@ -55,6 +55,24 @@ static struct clk_alpha_pll ipq_pll_huayra = {
>   	},
>   };
>   
> +static struct clk_alpha_pll ipq_pll_stromer = {
> +	.offset = 0x0,
> +	.regs = ipq_pll_offsets[CLK_ALPHA_PLL_TYPE_STROMER_PLUS],

CLK_ALPHA_PLL_TYPE_STROMER?

[...]

>   static const struct apss_pll_data ipq5018_pll_data = {
>   	.pll_type = CLK_ALPHA_PLL_TYPE_STROMER_PLUS,

and here?

The L register differs, so the rattesetting done from Linux must
have never worked anyway?

Konrad

