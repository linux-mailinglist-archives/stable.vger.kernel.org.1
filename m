Return-Path: <stable+bounces-52077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C28749078F6
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 18:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9AE21C21910
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 16:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5403C149E17;
	Thu, 13 Jun 2024 16:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OBmPKlo2"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82716149E09
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718297920; cv=none; b=WAEWCQYAapsktUlIwMPHfG0DPUyV3H1q9sDllrwIeyXF9NVeprSGMbiMQdVI5pg2oluYa/apnk5mwBGdpDeJj1sKyInUPvz6aTM4Tous/pqgiZzP433eZSpoKmOA3YkvbDnZ8PpYJ3LsZXn/whE+j1JtwqJEcratBOL5l3/jUxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718297920; c=relaxed/simple;
	bh=Ko2U0XciqYiZd+52ExiI+tllpyZWj8YuZw6B1gktbbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qlHiPgTWMwErOE9k7MDi0s3DlRrkz9MHm1HQJLv1EfTMwaDzfYtFtkmH+1AZpZiz2J+Ym3LdqfQUQuDOALsGRZnWw+I/IllG2/HtI0YZcvw31jR2b1YTiRdCgvKGOuMZk1bmx8gLx1nkIOiZf8b5jxu5hXSm7uJXoqgy7owuKYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OBmPKlo2; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52bbdc237f0so1578352e87.0
        for <stable@vger.kernel.org>; Thu, 13 Jun 2024 09:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718297917; x=1718902717; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=94cRgmNIJScPtZdK94CW4LdsaQMvPLRaBspPuDEVpOs=;
        b=OBmPKlo29u+ky8APFdx9lrkw5zGFLOCnSEHWcoyLHBQX4iZ5RfnYXsM6jPjN8ZS5IL
         mYUY5y6TPYU3fmW0ph3Xxi9dUZ6NiHeyGH0wCqkv4l/FWGeeZjm40wI5AJ34SawJBby5
         d8xWyiRqDHS9xjOxL2k6QQiYgNBWn+vKRGJ8DdWVMBgv6B8hrvhayqIKuFidSOwM/hv+
         kHBDuDPbDzsF3mmJs4Ih2hdAT3YqWb98Y5YSpMcllJ8itvO0cx6IG/mUgOTVd5cTb8jH
         Wh0XDjjKkU5HPvt6ntMe5On5Qe8jncwdbRNibPLTVAJ952fJTGrTNVRcBbOrH2PdUDqS
         1gNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718297917; x=1718902717;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=94cRgmNIJScPtZdK94CW4LdsaQMvPLRaBspPuDEVpOs=;
        b=kRQLaFmcRIGujnNrMVZQNdx/7Fg+6fBJe5WdBskcnW8mWDzqO4cXa+KGvRvGsaVb9Q
         zKiX/8nvnicRVpWacdrIcY1nALLQ1tWimHuQYBcd69pANGhTYSOkuDTO+Pcc+RtUJYcy
         XJ8IRh5JslFncgToJWCCwPKkUOQBsTkLNQKCJj1CerNmNpJ2AXWZeUjB5pjK+Q/Ezi3I
         U2LcaFYDvypeiroLYvSOIa/dxcen4a6JIHsVkWw+5T26RsCWKJTa+wsxsk0azHAAXsTz
         Ezkdzx07i768oBual6WUJGlLiJbuwCtF/Gj7ddzQiQRSBx1ld9dF7AkNRcI2gOW4Bf0V
         wKcw==
X-Forwarded-Encrypted: i=1; AJvYcCUarb2chptUJU9K9aMS58Bw1we1sFWFF0ZeYeYAB4JirGaqYCAAlKSfqrldE665S2mi9cOwuiscnebGvYJDw48BpLWAk/aD
X-Gm-Message-State: AOJu0Yy/Pfzf/n68pdGmC4KrLJ+qR2UZWQYSybxEEUwjVIzkaIdC9vBh
	IJv2QWPXI3qTCb0Y/HwvneYHGyUAcbk7Dwgb229GeXbnfZ2rA9UYGXMOT++3nH0=
X-Google-Smtp-Source: AGHT+IEyF4qoR9IYhKLhBMALpMTojh7HHUHgZZVfxWEoUECZp0xgvGWJZgNHhC77wpiXn4vOxAsA1Q==
X-Received: by 2002:a05:6512:44c:b0:51a:f689:b4df with SMTP id 2adb3069b0e04-52ca6e91b34mr221587e87.44.1718297916719;
        Thu, 13 Jun 2024 09:58:36 -0700 (PDT)
Received: from ?IPV6:2a00:f41:900a:a4b1:9ab2:4d92:821a:bb76? ([2a00:f41:900a:a4b1:9ab2:4d92:821a:bb76])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca2872466sm284108e87.143.2024.06.13.09.58.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 09:58:36 -0700 (PDT)
Message-ID: <d1062fb2-860a-41fe-887f-14977181f5f3@linaro.org>
Date: Thu, 13 Jun 2024 18:58:33 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/8] clk: qcom: clk-alpha-pll: Fix CAL_L_VAL override
 for LUCID EVO PLL
To: Ajit Pandey <quic_ajipan@quicinc.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Vinod Koul <vkoul@kernel.org>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Taniya Das <quic_tdas@quicinc.com>, Jagadeesh Kona <quic_jkona@quicinc.com>,
 Imran Shaik <quic_imrashai@quicinc.com>,
 Satya Priya Kakitapalli <quic_skakitap@quicinc.com>, stable@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20240611133752.2192401-1-quic_ajipan@quicinc.com>
 <20240611133752.2192401-2-quic_ajipan@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240611133752.2192401-2-quic_ajipan@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/11/24 15:37, Ajit Pandey wrote:
> In LUCID EVO PLL CAL_L_VAL and L_VAL bitfields are part of single
> PLL_L_VAL register. Update for L_VAL bitfield values in PLL_L_VAL
> register using regmap_write() API in __alpha_pll_trion_set_rate
> callback will override LUCID EVO PLL initial configuration related
> to PLL_CAL_L_VAL bit fields in PLL_L_VAL register.
> 
> Observed random PLL lock failures during PLL enable due to such
> override in PLL calibration value. Use regmap_update_bits() with
> L_VAL bitfield mask instead of regmap_write() API to update only
> PLL_L_VAL bitfields in __alpha_pll_trion_set_rate callback.
> 
> Fixes: 260e36606a03 ("clk: qcom: clk-alpha-pll: add Lucid EVO PLL configuration interfaces")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/clk/qcom/clk-alpha-pll.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
> index c51647e37df8..a538559caaa0 100644
> --- a/drivers/clk/qcom/clk-alpha-pll.c
> +++ b/drivers/clk/qcom/clk-alpha-pll.c
> @@ -1665,7 +1665,7 @@ static int __alpha_pll_trion_set_rate(struct clk_hw *hw, unsigned long rate,
>   	if (ret < 0)
>   		return ret;
>   
> -	regmap_write(pll->clkr.regmap, PLL_L_VAL(pll), l);
> +	regmap_update_bits(pll->clkr.regmap, PLL_L_VAL(pll), LUCID_EVO_PLL_L_VAL_MASK,  l);

Since you're altering a function used by LUCID and TRION PLLs.. how will
that affect non-LUCID_EVO/OLE ones?

Konrad

