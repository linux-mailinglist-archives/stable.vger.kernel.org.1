Return-Path: <stable+bounces-6637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 709C9811DA6
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 19:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3A311C214F1
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 18:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2655FEF7;
	Wed, 13 Dec 2023 18:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MqlHrheV"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8851E95
	for <stable@vger.kernel.org>; Wed, 13 Dec 2023 10:58:10 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50bfd7be487so8311953e87.0
        for <stable@vger.kernel.org>; Wed, 13 Dec 2023 10:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702493889; x=1703098689; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ZUzcUAYKJKCVreBhAC/gAbdLaRwduwq5l8nhnkZ9Qs=;
        b=MqlHrheVo9reLIuB53KYt/C67JY7p5R4tsLLEyLS1iESkdNLof7/zHDTMhIWR21pQd
         Q7UH1e53vDmGErH61ukGKlioXgHWHwjMey8TGprz+CfSa2zBvr+4FJgXazuYLHz/j1jo
         wODcGqIefGT2t1uCsIxanE0GZM/YHIEFA+hYN9X+27/r18IkI4XBYJ1dIe5E+MKlytmZ
         1RkzVGnjrprwaQ2FFDT3+rKDklbFP3+b5l1cxw6c3ZTQjqeBeGsBFbwFGC8IBq8VQiOJ
         8gysB0vh5GFxE7Fr6A0ZKTd+fwAHMXETgeFvCF+0UOLX480xj/oVP4ulVsDpNdXS8f/h
         D+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702493889; x=1703098689;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZUzcUAYKJKCVreBhAC/gAbdLaRwduwq5l8nhnkZ9Qs=;
        b=qBE9mPf4AQdDMYBFEQiKNOfFLMKA/ijVgIaIYFQ8izCjvnAYBJnoVyoBR7KQD37PHU
         WvIBZMWHnvaZeXm/BOcwVJ3Ye9cssCqKh+4kgH0atTd4X9PyvCvUhoWXjKuLQx/IVOzj
         51Wvz/NF+b3Fvc8GahNiGIhREoBUQIjgY15rKjSkPe/dFZFPCouVhjKLgBYizbq8zwR4
         /IS+G0yjN/53pKNaAdF9jfCXcvnFXMyeU1ew940+H1wk1TiaC28Xb4pPyAh8QojYIrZz
         74inmzCQJO9oeFsduFwDbGmsDDIexzhdxSAzs1txhd1m8XTWDdvnd+xt4Fmql9wTogrx
         TblQ==
X-Gm-Message-State: AOJu0YwDUzpVw8Il7UIVSEQZvsZNd/mmLYM9cA8RHItfbio5k41Bl8NT
	e3eyfMN7HflkJ1T5pA2oDk7F8Q==
X-Google-Smtp-Source: AGHT+IFyyAwZxWhcdxaTGwmrqPBk0gEDkvIOCe1nLi88UcVTZe5H3wQnyG/s2PV/+lx0LJVv+t4q8w==
X-Received: by 2002:a05:6512:3608:b0:50d:12b4:e01e with SMTP id f8-20020a056512360800b0050d12b4e01emr3575281lfs.104.1702493888765;
        Wed, 13 Dec 2023 10:58:08 -0800 (PST)
Received: from [172.30.204.126] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id u4-20020a05651206c400b005009c4ba3f0sm1680336lff.72.2023.12.13.10.58.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 10:58:08 -0800 (PST)
Message-ID: <ac04f771-2cfd-461d-ba37-7348a62b92ba@linaro.org>
Date: Wed, 13 Dec 2023 19:58:06 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] arm64: dts: qcom: sdm845: fix USB DP/DM HS PHY
 interrupts
Content-Language: en-US
To: Johan Hovold <johan+linaro@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20231213173403.29544-1-johan+linaro@kernel.org>
 <20231213173403.29544-3-johan+linaro@kernel.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231213173403.29544-3-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/13/23 18:34, Johan Hovold wrote:
> The USB DP/DM HS PHY interrupts need to be provided by the PDC interrupt
> controller in order to be able to wake the system up from low-power
> states and to be able to detect disconnect events, which requires
> triggering on falling edges.
> 
> A recent commit updated the trigger type but failed to change the
> interrupt provider as required. This leads to the current Linux driver
> failing to probe instead of printing an error during suspend and USB
> wakeup not working as intended.
> 
> Fixes: 84ad9ac8d9ca ("arm64: dts: qcom: sdm845: fix USB wakeup interrupt types")
> Fixes: ca4db2b538a1 ("arm64: dts: qcom: sdm845: Add USB-related nodes")
> Cc: stable@vger.kernel.org      # 4.20
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
Matches ds

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

